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

    void startServer(const QHostAddress &address, qint16 port);
    Q_INVOKABLE void startServerBroadcast(qint16 port);
    Q_INVOKABLE void startServer(const QString interfaceName, qint16 port);
    Q_INVOKABLE void stopServer();

    Q_INVOKABLE bool isRunning() const;

    Q_INVOKABLE void setBasePath(QString filePath);
    Q_INVOKABLE void setError404File(QString filePath);

    Q_INVOKABLE QString getStaticContent();

    Q_INVOKABLE qint16 getPort() const;
    Q_INVOKABLE QStringList getFullAddresses() const;
    Q_INVOKABLE QStringList getIpAddresses() const;

signals:
    void runningChanged(bool isRunning);
    void modifyHtmlResponse(QString *response);

private slots:
    void handleRequest(QHttpRequest *req, QHttpResponse *resp);

private:
    QHttpServer * m_server;
    QString m_basePath;
    QString m_error404File;
    bool m_isRunning;
    bool m_isBroadcasting;
};
