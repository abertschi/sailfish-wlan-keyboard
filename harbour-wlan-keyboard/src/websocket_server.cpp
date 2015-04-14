#include "websocket_server.h"

websocket_server::websocket_server(QObject *parent) :QObject(parent)
{
    this->m_server = new QtWebsocket::QWsServer(this, QtWebsocket::Tcp);
}

websocket_server:: ~ websocket_server()
{
    if (this->isRunning())
    {
        stopServer();
    }
    delete(this->m_server);
}

void  websocket_server::startServerBroadcast(qint16 port)
{
    startServer(QHostAddress::Any, port);
}

void websocket_server::startServer(const QString &interfaceName, qint16 port)
{
    QHostAddress addr = Utils::getHostAddressByInterfaceName(interfaceName);
     qDebug()  << addr.toString();
    this->startServer(addr, port);
}

void websocket_server::startServer(const QHostAddress &address, qint16 port)
{
    if (! m_server->listen(address, port))
    {
        qDebug() << "Error: Can't launch server, " << m_server->errorString();
    }
    else
    {
        this->m_isRunning = true;
        QObject::connect(m_server, SIGNAL(newConnection()), this, SLOT(processNewConnection()));
        qDebug() << "WebsocketServer started and listening on port " << port;
    }
}

void websocket_server::stopServer()
{
    this->m_isRunning = false;
    QObject::disconnect(m_server, SIGNAL(newConnection()), this, SLOT(processNewConnection()));
    m_server->close();
}

void websocket_server::processNewConnection()
{
    QtWebsocket::QWsSocket* clientSocket = m_server -> nextPendingConnection();
    QObject::connect(clientSocket, SIGNAL(frameReceived(QString)), this, SLOT(processMessageInternal(QString)));
    QObject::connect(clientSocket, SIGNAL(disconnected()), this, SLOT(socketDisconnected()));
    QObject::connect(clientSocket, SIGNAL(pong(quint64)), this, SLOT(processPong(quint64)));

    m_clients << clientSocket;

    qDebug() << "New websocket client connected";
}

void websocket_server::processMessageInternal(QString message)
{
    qDebug() << "Message from client received: " << message;
    emit processMessage(&message);
}

void websocket_server::processPong(quint64 elapsedTime)
{
    qDebug() << tr("ping: %1 ms").arg(elapsedTime);
}

void websocket_server::socketDisconnected()
{
    QtWebsocket::QWsSocket* socket = qobject_cast<QtWebsocket::QWsSocket*>(sender());
    if (socket == 0)
    {
        return;
    }

    m_clients.removeOne(socket);
    socket->deleteLater();

    qDebug() << "Client disconnected";
}

bool websocket_server::isRunning() const
{
    return this->m_isRunning;
}

qint16 websocket_server::getPort() const
{
    return this->m_server->serverPort();
}

QString websocket_server::getIp() const
{
    return this->m_server->serverAddress().toString();
}

