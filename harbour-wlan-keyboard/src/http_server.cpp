#include "http_server.h"
#include "utils.h"
#include <QDebug>
#include <QFile>
#include <qtcpserver.h>
#include <qhttpserver/qhttpserver.h>
#include <qhttpserver/qhttprequest.h>
#include <qhttpserver/qhttpresponse.h>

http_server::http_server(QObject *parent): QObject(parent), running(false){
}

http_server:: ~ http_server() {

}

// ---------------------------------------------------
// header http_server
// ---------------------------------------------------

void http_server::startServer(qint16 port) {

    this->server = new QHttpServer(this);


    qDebug() << "creating http server " << server;

    connect(server, SIGNAL(newRequest(QHttpRequest*, QHttpResponse*)),
           this, SLOT(handleRequest(QHttpRequest*, QHttpResponse*)));


    qDebug() << "starting listening on " << port;
    try {
        if (server->listen(port)) {
            running = true;
            this->port = port;
            qDebug() << "Server started";
        }
        else {
            qDebug() << "Error in starting http-server, error: " << server->getEngine()->errorString();
        }
    } catch(int e) {
        qDebug() << "Catch occurred "<< e;
    }

    emit runningChanged(true);

}

void http_server::stopServer() {
    disconnect(server, SIGNAL(newRequest(QHttpRequest*, QHttpResponse*)),
           this, SLOT(handleRequest(QHttpRequest*, QHttpResponse*)));
    server->close();
    //delete server;

    qDebug() << "server closed";

    running = false;
    emit runningChanged(false);
}

bool http_server::isRunning() const{
    return running;
}

void http_server::setStaticContent(QString filePath){
    qDebug() << "static content set " << filePath;
    this->staticContent = filePath;
}

QString http_server::getStaticContent() {
    return this->staticContent;
}

qint16 http_server::getPort() const{
     return this->port;
}

QString http_server::getIp() const{
    return Utils::getIpAddress();
}

QString http_server::getFullAddress() const {
    QString addr = "-";

    if (running)
        addr = "http://" + getIp() + ":" + QString::number(getPort());

    return addr;
}

void http_server::handleRequest(QHttpRequest *req, QHttpResponse *resp) {
    qDebug() << "handling new request using path: " << req->path()
             << " remoteAddress: " << req->remoteAddress()
             <<  "methodString: " <<req->methodString()
             << " body-size: " << req->body().size();

    QString content;
    QFile file;
    file.setFileName(this->staticContent);

    if(file.open(QIODevice::ReadOnly) == 0) {
        content="Error in opening file!";
    }
    else {
        QTextStream in(&file);
        content = in.readAll();
        emit modifyStaticContent(&content);
    }
    resp->setHeader("Content-Length", QString::number(content.size()));
    resp->writeHead(200);
    resp->end(content.toUtf8());
    file.close();
}



