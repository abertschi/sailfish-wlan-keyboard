#include "utils.h"
#include <sstream>

Utils::Utils(QObject *parent) :QObject(parent)
{
    QGuiApplication * app = (QGuiApplication*) parent;
    this->m_clipboard = app->clipboard();
}

int Utils::getAvailableEndpointSize()
{
    return getAvailableEndpoints().length();
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
                    //qDebug() << interface.name() << " " << entry.ip().toString() << " " << interface.hardwareAddress();
                    endpoints.append(e);
                }
            }
        }
    }
    //qDebug() << endpoints;
    return endpoints;
}

QVariant Utils::getAvailableEndpointsAsQVariant()
{
    QList<QObject*> dataList;
    foreach (ServerEndpoint* endpoint, getAvailableEndpoints())
    {
        //qDebug() << "add as qvariant: " << endpoint->ipAddress();
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
                    //qDebug() << "ip found: " << entry.ip().toString();
                    return entry.ip();
                }
            }
        }
    }
    // todo: exception handling
    qDebug() << "host not found ...";
}

void Utils::setClipboard(QString content)
{
    m_clipboard->setText(content);
}

QClipboard * Utils::getClipboard()
{
    return this->m_clipboard;
}

QString Utils::escapeJsonString(QString str)
{
   std::ostringstream ss;
   std::string input = str.toStdString();
   for (auto iter = input.cbegin(); iter != input.cend(); iter++) {
           switch (*iter) {
               case '\\': ss << "\\\\"; break;
               case '"': ss << "\\\""; break;
               case '/': ss << "\\/"; break;
               case '\b': ss << "\\b"; break;
               case '\f': ss << "\\f"; break;
               case '\n': ss << "\\n"; break;
               case '\r': ss << "\\r"; break;
               case '\t': ss << "\\t"; break;
               default: ss << *iter; break;
           }
       }
    return QString::fromStdString(ss.str());
}
