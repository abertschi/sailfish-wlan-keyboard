#ifndef WEBSOCKET_SERVER_H
#define WEBSOCKET_SERVER_H

#include <QObject>

#endif // WEBSOCKET_SERVER_H

class websocket_server : public QObject
{
    Q_OBJECT

public:
    explicit websocket_server(QObject *parent = 0);

    Q_INVOKABLE void start();

    Q_INVOKABLE void stop();

    void getPort() const;

    void setPort(qint16 port);

    QString* getIp() const;

signals:
    void portChanged();
};

