#ifndef HTTP_SERVER_H
#define HTTP_SERVER_H

#include <qhttpserver/qhttpserverfwd.h>

#include <QObject>

#endif // HTTP_SERVER_H

class http_server : public QObject
{
    Q_OBJECT

public:
    explicit http_server(QObject *parent = 0);

    Q_INVOKABLE void startServer();

    Q_INVOKABLE void stopServer();

private slots:
    void handleRequest(QHttpRequest *req, QHttpResponse *resp);

private:
    QHttpServer &server;
};
