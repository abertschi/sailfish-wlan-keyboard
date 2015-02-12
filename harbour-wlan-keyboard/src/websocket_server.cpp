#include "websocket_server.h"

websocket_server::websocket_server(QObject *parent) :QObject(parent) {
    this->m_server = new QtWebsocket::QWsServer(this, QtWebsocket::Tcp);
}

websocket_server:: ~ websocket_server() {
    if (this->isRunning())  {
        stopServer();
    }
    delete(this->m_server);
}

void  websocket_server::startServer(qint16 port){
    if (! m_server->listen(QHostAddress::Any, port)) {
        qDebug() << "Error: Can't launch server, " << m_server->errorString();
    }
    else {
        this->m_port = port;
        this->m_isRunning = true;
        QObject::connect(m_server, SIGNAL(newConnection()), this, SLOT(processNewConnection()));
        qDebug() << "WebsocketServer started and listening on port " << port;
    }
}

void websocket_server::processNewConnection() {
    QtWebsocket::QWsSocket* clientSocket = m_server -> nextPendingConnection();

    QObject::connect(clientSocket, SIGNAL(frameReceived(QString)), this, SLOT(processMessageInternal(QString)));
    QObject::connect(clientSocket, SIGNAL(disconnected()), this, SLOT(socketDisconnected()));
    QObject::connect(clientSocket, SIGNAL(pong(quint64)), this, SLOT(processPong(quint64)));

    //clients << clientSocket;

    qDebug() << "New websocket client connected";
}

void websocket_server::processMessageInternal(QString message) {
    qDebug() << "Message from client received: " << message;

    emit processMessage(&message);
}

void websocket_server::processPong(quint64 elapsedTime) {
    qDebug() << tr("ping: %1 ms").arg(elapsedTime);
}

void websocket_server::stopServer() {
    this->m_isRunning = false;
    QObject::disconnect(m_server, SIGNAL(newConnection()), this, SLOT(processNewConnection()));
    m_server->close();
}

void websocket_server::socketDisconnected() {
}

bool websocket_server::isRunning() const {
    return this->m_isRunning;
}

qint16 websocket_server::getPort() const {
    return this->m_port;
}

QString websocket_server::getIp() const {
    return Utils::getIpAddress();
}

