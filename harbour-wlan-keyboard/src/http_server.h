#ifndef HTTP_SERVER_H
#define HTTP_SERVER_H

#include <qhttpserver/qhttpserverfwd.h>

#include <QObject>


#endif // HTTP_SERVER_H

class http_server : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString staticContent READ getStaticContent WRITE setStaticContent)

    Q_PROPERTY(bool m_isRunning READ isRunning NOTIFY runningChanged)

public:
    explicit http_server(QObject *parent = 0);

    virtual ~ http_server();

    Q_INVOKABLE void startServer(qint16 m_port);

    Q_INVOKABLE void stopServer();

    Q_INVOKABLE bool isRunning() const;

    void setStaticContent(QString filePath);

    QString getStaticContent();

    qint16 getPort() const;

    Q_INVOKABLE QString getFullAddress() const;

    Q_INVOKABLE QString getIp() const;

signals:
    void runningChanged(bool isRunning);
    void modifyStaticContent(QString *response);

private slots:
    void handleRequest(QHttpRequest *req, QHttpResponse *resp);

private:
    QHttpServer * m_server;
    QString m_staticContent;
    qint16 m_port;
    bool m_isRunning;
};
