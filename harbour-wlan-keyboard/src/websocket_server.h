#ifndef WEBSOCKET_SERVER_H
#define WEBSOCKET_SERVER_H
#include "QtWebsocket/QWsServer.h"
#include <QtCore>
#include <QtNetwork>
#include "QtWebsocket/QWsSocket.h"
#include <QObject>
#include "utils.h"


#endif // WEBSOCKET_SERVER_H

class websocket_server : public QObject
{
    Q_OBJECT

    Q_PROPERTY(bool m_isRunning READ isRunning NOTIFY runningChanged)

public:
    explicit websocket_server(QObject *parent = 0);

    virtual ~ websocket_server();

    Q_INVOKABLE void startServer(qint16 port = 7777);
    void startServer(const QHostAddress &address, qint16 m_port);
    Q_INVOKABLE void startServer(const QString &address, qint16 port);
    Q_INVOKABLE void stopServer();

    Q_INVOKABLE bool isRunning() const;

    Q_INVOKABLE qint16 getPort() const;
    Q_INVOKABLE QString getIp() const;

private slots:
    void processNewConnection();
    void processMessageInternal(QString message);
    void processPong(quint64 elapsedTime);
    void socketDisconnected();

signals:
    void processMessage(QString *message);
    void runningChanged(bool isRunning);

private:
    QtWebsocket::QWsServer * m_server;
    QList<QtWebsocket::QWsSocket*>  m_clients;
    bool m_isRunning;
};


