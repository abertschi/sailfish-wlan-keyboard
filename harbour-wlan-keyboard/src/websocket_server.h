#ifndef WEBSOCKET_SERVER_H
#define WEBSOCKET_SERVER_H
#include "QtWebsocket/QWsServer.h"
#include <QtCore>
#include <QtNetwork>
#include "QtWebsocket/QWsSocket.h"
#include <QObject>

#endif // WEBSOCKET_SERVER_H

class websocket_server : public QObject
{
    Q_OBJECT

public:
    explicit websocket_server(QObject *parent = 0);

    virtual ~ websocket_server();

    Q_INVOKABLE void startServer(qint16 port);

    Q_INVOKABLE void stopServer();

    Q_INVOKABLE bool isRunning() const;

    qint16 getPort() const;

    Q_INVOKABLE QString getIp() const;

public slots:
    void processNewConnection();
    void processMessage(QString message);
    void processPong(quint64 elapsedTime);
    void socketDisconnected();

private:
    QtWebsocket::QWsServer * server;
    QList<QtWebsocket::QWsSocket*> clients;
};


