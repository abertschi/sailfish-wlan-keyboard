#ifndef SERVER_CONFIGURATOR_H
#define SERVER_CONFIGURATOR_H

#include <QObject>
#include <sailfishapp.h>
#include <QDebug>
#include <QDir>
#include <QScopedPointer>
#include <QQuickView>
#include <QQmlEngine>
#include <QGuiApplication>
#include "rapidjson/document.h"
#include "rapidjson/error/en.h"
#include "http_server.h"
#include "websocket_server.h"
#include "settings.h"
#include "headless_keyboard_delegate.h"
#endif // SERVER_CONFIGURATOR_H

class ServerConfigurator: public QObject
{
    Q_OBJECT
public:
    explicit ServerConfigurator(QObject *parent = 0);
    virtual ~ ServerConfigurator();
    void configure(QQuickView *view);

private slots:
    void modifyHtmlContent(QString *content);
    void processSocketMessage(QString *message);

private:
    void processInsertText(QString text);
    void processKeyReturn();
    void processKeyDel();
    void processKeyArrow(QString arrow);

    http_server * m_http_server;
    websocket_server * m_websocket_server;
    Utils * m_keyboardUtils;
    HeadlessKeyboardDelegate * m_headless_keyboard;
};


