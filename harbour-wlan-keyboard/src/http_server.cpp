#include "http_server.h"
#include "utils.h"
#include <QDebug>
#include <QFile>
#include <qtcpserver.h>
#include <qhttpserver/qhttpserver.h>
#include <qhttpserver/qhttprequest.h>
#include <qhttpserver/qhttpresponse.h>
#include "server_endpoint.h"

http_server::http_server(QObject *parent): QObject(parent), m_isRunning(false)
{
    this->m_server = new QHttpServer(this);
}

http_server:: ~ http_server()
{
    if (m_isRunning) {
        stopServer();
    }
    delete(this->m_server);
}

void http_server::startServer(const QString interfaceName, qint16 port)
{
    QHostAddress addr = Utils::getHostAddressByInterfaceName(interfaceName);
    qDebug() << interfaceName << addr.toString() << "addr: " << addr.toString() << "port: " << port;
    startServer(addr, port);
    m_isBroadcasting = false;
}

void http_server::startServerBroadcast(qint16 port)
{
    m_isBroadcasting = true;
    this->startServer(QHostAddress::Any, port);
}

void http_server::startServer(const QHostAddress &address, qint16 port)
{
    qDebug() << "Starting httpServer on port " << m_server;

    if (m_server->listen(address, port)) {

        connect(m_server, SIGNAL(newRequest(QHttpRequest*, QHttpResponse*)),
                this, SLOT(handleRequest(QHttpRequest*, QHttpResponse*)));

        m_isRunning = true;
        emit runningChanged(true);
        qDebug() << "HttpServer successfully started";
    }
    else {
        qDebug() << "Error in starting httpServer, error: " << m_server->getEngine()->errorString();
    }
}

void http_server::stopServer()
{
    if (m_isRunning) {
        m_server->close();
        disconnect(m_server, SIGNAL(newRequest(QHttpRequest*, QHttpResponse*)),
                   this, SLOT(handleRequest(QHttpRequest*, QHttpResponse*)));

        m_isRunning = false;
        emit runningChanged(false);
    }
}

void http_server::handleRequest(QHttpRequest *req, QHttpResponse *resp)
{
    qDebug() << "handling new request using path: " << req->path()
             << " remoteAddress: " << req->remoteAddress()
             <<  "methodString: " <<req->methodString()
              << " body-size: " << req->body().size();

    QString content;
    QFile file;
    file.setFileName(this->m_staticContent);

    if(file.open(QIODevice::ReadOnly) == 0) {
        content="Error in opening file!";
    }
    else {
        QTextStream in(&file);
        content = in.readAll();
        emit modifyHtmlResponse(&content);
    }
    resp->setHeader("Content-Length", QString::number(content.size()));
    resp->writeHead(200);
    resp->end(content.toUtf8());
    file.close();
}

bool http_server::isRunning() const
{
    return m_isRunning;
}

void http_server::setStaticContent(QString filePath)
{
    qDebug() << "static content set " << filePath;
    this->m_staticContent = filePath;
}

QString http_server::getStaticContent()
{
    return this->m_staticContent;
}

qint16 http_server::getPort() const
{
    return this->m_server->getEngine()->serverPort();
}

QStringList http_server::getIpAddresses() const
{
    QStringList list;
    if (m_isRunning)
    {
        if (m_isBroadcasting)
        {

            foreach(ServerEndpoint* endpoint, Utils::getAvailableEndpoints())
            {
                list << endpoint->ipAddress();
            }
        }
        else
        {
            list <<  this->m_server->getEngine()->serverAddress().toString();
        }
    }
    return list;
}

QStringList http_server::getFullAddresses() const
{
    QStringList list;
    if (m_isRunning)
    {
        foreach (QString ip, getIpAddresses())
        {
            list << "http://" + ip + ":" + QString::number(getPort());
        }
    }
    return list;
}
