#include "http_server.h"
#include <QDebug>

#include <qhttpserver/qhttpserver.h>
#include <qhttpserver/qhttprequest.h>
#include <qhttpserver/qhttpresponse.h>

http_server::http_server(QObject *parent): QObject(parent) {

    QHttpServer *server = new QHttpServer(this);

    connect(server, SIGNAL(newRequest(QHttpRequest*, QHttpResponse*)),
            this, SLOT(handleRequest(QHttpRequest*, QHttpResponse*)));
    server->listen(QHostAddress::Any, 8080);
}


// ---------------------------------------------------
// header http_server
// ---------------------------------------------------

void http_server::startServer() {

}

void http_server::stopServer() {
 // server->close();
}

void http_server::handleRequest(QHttpRequest *req, QHttpResponse *resp) {
    Q_UNUSED(req);
    QByteArray body = "Hello World";
    resp->setHeader("Content-Length", QString::number(body.size()));
    resp->writeHead(200);
    resp->end(body);
}


