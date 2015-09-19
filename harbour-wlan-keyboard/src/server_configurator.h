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
    void send(QString msg);


private slots:
    void modifyHtmlContent(QString *content);
    void processSocketMessage(QString *message);
    void onNewClientConnected();
    void onSettingsChanged(Settings *s);
    void onPhoneClipboardChanged(QString cb);

private:
    void processInsertText(QString text);
    void processKeyReturn();
    void processKeyDel();
    void processKeyArrow(QString arrow);
    void sendSettingsToWsClients(QString settingsJson);
    void sendClipboardToClients(QString cb);

    http_server * m_http_server;
    websocket_server * m_websocket_server;
    Utils * m_keyboardUtils; // todo: make singelton
    HeadlessKeyboardDelegate * m_headless_keyboard;
};


