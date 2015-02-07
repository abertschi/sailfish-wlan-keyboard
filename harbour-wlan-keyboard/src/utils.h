#ifndef UTILS_H
#include <QHostInfo>
#include <QNetworkInterface>
#define UTILS_H

class Utils
{
public:
    Utils();

    static QString getIpAddress();
};

#endif // UTILS_H
