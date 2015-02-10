#ifndef UTILS_H
#include <QHostInfo>
#include <QNetworkInterface>
#include <QClipboard>
#include <QGuiApplication>
#define UTILS_H

class Utils : public QObject
{
    Q_OBJECT
public:
    Utils(QObject *parent = 0);

    static QString getIpAddress();

    void setClipboard(QString content);

    QClipboard * getClipboard();

private:
    QClipboard *m_clipboard;

};

#endif // UTILS_H
