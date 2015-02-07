#include "utils.h"

Utils::Utils() {
}

QString Utils::getIpAddress() {
    QList<QString> ignores;
    ignores << "127.0.0.1";
    ignores << "::1";

    QList<QHostAddress> addrs = QNetworkInterface::allAddresses();
    QString foundIp = "localhost";

    for(int i = 0; i < addrs.count(); i ++) {
        QString ip = addrs[i].toString();
        qDebug() << ip;
        if(ignores.contains(ip))
            continue;
        foundIp = ip;
        break;
    }
    return foundIp;
}

