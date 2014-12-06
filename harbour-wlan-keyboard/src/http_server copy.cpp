#include "http_server.h"
#include <QDebug>

#include <qhttpserver/qhttpserver.h>
#include <qhttpserver/qhttprequest.h>
#include <qhttpserver/qhttpresponse.h>

namespace wlankeyboard {

http_server::http_server(QObject *parent): QObject(parent) {

    this->server = new QHttpServer(this);

    connect(this->server, SIGNAL(newRequest(QHttpRequest*, QHttpResponse*)),
            this, SLOT(handleRequest(QHttpRequest*, QHttpResponse*)));
}

// ---------------------------------------------------
// header http_server
// ---------------------------------------------------

void http_server::startServer() {
    this->server->listen(QHostAddress::Any, 8080);
}

void http_server::stopServer() {
    this->server->close();
}

void http_server::handleRequest(QHttpRequest *req, QHttpResponse *resp) {
    Q_UNUSED(req);
    QByteArray body = "Hello World";
    resp->setHeader("Content-Length", QString::number(body.size()));
    resp->writeHead(200);
    resp->end(body);
}

}
