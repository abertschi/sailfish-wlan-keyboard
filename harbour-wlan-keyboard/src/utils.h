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

    Q_INVOKABLE QVariant getAvailableEndpointsAsQVariant();
    static QList<ServerEndpoint*> getAvailableEndpoints();
    Q_INVOKABLE static int getAvailableEndpointSize();

    static QHostAddress getHostAddressByInterfaceName(QString name);
    //static QList<QHostAddress> Utils::getAllHostAdresses();

    void setClipboard(QString content);
    QClipboard * getClipboard();

    static Utils& getInstance(QObject *parent)
    {
        static Utils instance(parent) ;
        return instance;
    }

private:
    Utils(QObject *parent = 0);
    QClipboard *m_clipboard;

};


#endif // UTILS_H
