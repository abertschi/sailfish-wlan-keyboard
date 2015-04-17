#ifndef UTILS_H
#include <QHostInfo>
#include <QNetworkInterface>
#include <QClipboard>
#include <QGuiApplication>
#include "server_endpoint.h"
#define UTILS_H

class Utils : public QObject
{
    Q_OBJECT
public:
    Utils(QObject *parent = 0);

    Q_INVOKABLE QVariant getAvailableEndpointsAsQVariant();
    static QList<ServerEndpoint*> getAvailableEndpoints();
    Q_INVOKABLE static int getAvailableEndpointSize();

    static QHostAddress getHostAddressByInterfaceName(QString name);
    //static QList<QHostAddress> Utils::getAllHostAdresses();

    void setClipboard(QString content);
    QClipboard * getClipboard();

private:
    QClipboard *m_clipboard;

};


#endif // UTILS_H
