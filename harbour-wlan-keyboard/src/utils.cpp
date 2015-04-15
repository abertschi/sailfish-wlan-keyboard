#include "utils.h"

Utils::Utils(QObject *parent) :QObject(parent)
{
    QGuiApplication * app = (QGuiApplication*) parent;
    this->m_clipboard = app->clipboard();
}

QList<ServerEndpoint*> Utils::getAvailableEndpoints()
{
    QList<ServerEndpoint*> endpoints;
    foreach(QNetworkInterface interface, QNetworkInterface::allInterfaces())
    {
        if (interface.flags().testFlag(QNetworkInterface::IsUp) && !interface.flags().testFlag(QNetworkInterface::IsLoopBack))
        {
            foreach (QNetworkAddressEntry entry, interface.addressEntries())
            {
                if ( interface.hardwareAddress() != "00:00:00:00:00:00" && entry.ip().toString().contains("."))
                {
                    ServerEndpoint* e = new ServerEndpoint();
                    e->setInterfaceName(interface.name());
                    e->setIpAddress(entry.ip().toString());
                    e->setHardwareAddr(interface.hardwareAddress());
                    qDebug() << interface.name() << " " << entry.ip().toString() << " " << interface.hardwareAddress();
                    endpoints.append(e);
                }
            }
        }
    }
    qDebug() << endpoints;
    return endpoints;
}

QVariant Utils::getAvailableEndpointsAsQVariant()
{
    QList<QObject*> dataList;
    foreach (ServerEndpoint* endpoint, getAvailableEndpoints())
    {
        qDebug() << "add as qvariant: " << endpoint->ipAddress();
        dataList.append(endpoint);
    }
    return QVariant::fromValue(dataList);
}

QHostAddress Utils::getHostAddressByInterfaceName(QString host)
{
    foreach(QNetworkInterface interface, QNetworkInterface::allInterfaces())
    {
        if(interface.name() == host)
        {
            foreach (QNetworkAddressEntry entry, interface.addressEntries())
            {
                if ( interface.hardwareAddress() != "00:00:00:00:00:00" && entry.ip().toString().contains("."))
                {
                    qDebug() << "ip found: " << entry.ip().toString();
                    return entry.ip();
                }
            }
        }
    }
    // todo: exception handling
    qDebug() << "host not found ...";
}

/*
QList<QHostAddress> Utils::getAllHostAdresses()
{
    QList<QHostAddress> resultAddrs;
    QList<QHostAddress> addrs = QNetworkInterface::allAddresses();
    QList<QString> ignores;
    ignores << "127.0.0.1";
    ignores << "::1";

    for(int i = 0; i < addrs.count(); i ++) {
        QHostAddress addr = addrs[i];
        if(! ignores.contains(addr.toString()))
            resultAddrs << addr;
    }
    return resultAddrs;
}

*/

void Utils::setClipboard(QString content)
{
    m_clipboard->setText(content);
}

QClipboard * Utils::getClipboard()
{
    return this->m_clipboard;
}

