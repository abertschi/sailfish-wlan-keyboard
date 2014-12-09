#include "http_server.h"
#include <QDebug>
#include <QFile>
#include <qtcpserver.h>
#include <qhttpserver/qhttpserver.h>
#include <qhttpserver/qhttprequest.h>
#include <qhttpserver/qhttpresponse.h>

http_server::http_server(QObject *parent): QObject(parent), running(false){

    server = new QHttpServer(this);
    qDebug() << "creating http server ";

    connect(server, SIGNAL(newRequest(QHttpRequest*, QHttpResponse*)),
            this, SLOT(handleRequest(QHttpRequest*, QHttpResponse*)));
}

http_server:: ~ http_server() {

}

// ---------------------------------------------------
// header http_server
// ---------------------------------------------------

void http_server::startServer(qint16 port = 7777) {
    qDebug() << "starting listening on " << port;
    server->listen(QHostAddress::Any, port);
    running = true;
    this->port = port;
}

void http_server::stopServer() {
    server->close();
    qDebug() << "server closed";

    running = false;
}

bool http_server::isRunning() const{
    return running;
}


void http_server::setStaticContent(const QString & filePath){
    this->filePath = filePath;
}

qint16 http_server::getPort() const{
     return this->port;
}

QString http_server::getIp() const{
    QTcpServer *engine =  this->server->getEngine();
    qint32 ipv4 = engine->serverAddress().toIPv4Address();
    return QString::number(ipv4);
}


void http_server::handleRequest(QHttpRequest *req, QHttpResponse *resp) {
    qDebug() << "handling new request";
    qDebug() << req->path();
    qDebug() << req->remoteAddress();
    qDebug() << req->methodString();
    qDebug() << req->body().size();

    QFile file(this->filePath);
    if (!file.open(QIODevice::ReadOnly)) {
        qDebug() << "Error reading http content";
        return;
    }

    QTextStream in(&file);
    QByteArray content;
    while (!in.atEnd()) {
        content += in.readLine();
    }
    resp->setHeader("Content-Length", QString::number(content.size()));
    resp->writeHead(200);
    resp->end(content);
}


