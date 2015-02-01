#include "websocket_server.h"


websocket_server::websocket_server(QObject *parent) :QObject(parent) {
    server = new QtWebsocket::QWsServer(this, QtWebsocket::Tcp);
}

websocket_server:: ~ websocket_server() {
}

// ---------------------------------------------------
// header websocket_server
// ---------------------------------------------------
void  websocket_server::startServer(qint16 port){
    if (! server->listen(QHostAddress::Any, port)) {
        qDebug() << "Error: Can't launch server";
        qDebug() << tr("QWsServer error : %1").arg(server->errorString());
    }
    else {
        qDebug() << "Server is listening on port " << port;
    }
    QObject::connect(server, SIGNAL(newConnection()), this, SLOT(processNewConnection()));
}

void websocket_server::processNewConnection() {
    QtWebsocket::QWsSocket* clientSocket = server -> nextPendingConnection();

    QObject::connect(clientSocket, SIGNAL(frameReceived(QString)), this, SLOT(processMessage(QString)));
    //QObject::connect(clientSocket, SIGNAL(disconnected()), this, SLOT(socketDisconnected()));
    QObject::connect(clientSocket, SIGNAL(pong(quint64)), this, SLOT(processPong(quint64)));

    //clients << clientSocket;

    qDebug() << "Client connected";
}

void websocket_server::processMessage(QString message) {
    qDebug() << "Message from client received: " << message;
}

void websocket_server::processPong(quint64 elapsedTime) {
    qDebug() << tr("ping: %1 ms").arg(elapsedTime);
}

void websocket_server::stopServer() {
    server->close();
}

void websocket_server::socketDisconnected() {

}

bool websocket_server::isRunning() const {
}

qint16 websocket_server::getPort() const {
}

QString websocket_server::getIp() const {
}

