#ifndef HTTP_SERVER_H
#define HTTP_SERVER_H
#include <QHostInfo>
#include <QNetworkInterface>
#include <qhttpserver/qhttpserverfwd.h>
#include <QObject>
#endif // HTTP_SERVER_H

class http_server : public QObject
{
    Q_OBJECT

    Q_PROPERTY(bool m_isRunning READ isRunning NOTIFY runningChanged)

public:
    explicit http_server(QObject *parent = 0);

    virtual ~ http_server();

    Q_INVOKABLE void startServer(qint16 m_port);
    Q_INVOKABLE void startServer(const QHostAddress &address, qint16 m_port);
    Q_INVOKABLE void stopServer();

    Q_INVOKABLE bool isRunning() const;

    Q_INVOKABLE void setStaticContent(QString filePath);
    Q_INVOKABLE QString getStaticContent();

    Q_INVOKABLE qint16 getPort() const;
    Q_INVOKABLE QString getFullAddress() const;
    Q_INVOKABLE QString getIp() const;

signals:
    void runningChanged(bool isRunning);
    void modifyHtmlResponse(QString *response);

private slots:
    void handleRequest(QHttpRequest *req, QHttpResponse *resp);

private:
    QHttpServer * m_server;
    QString m_staticContent;
    bool m_isRunning;
};
