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
#include "rapidjson/document.h" // rapidjson's DOM-style API
#include "rapidjson/prettywriter.h" // for stringify JSON
#include "rapidjson/filestream.h" // wrapper of C stream for prettywriter as output
#include <cstdio>

#include "http_server.h"
#include "websocket_server.h"
#endif // SERVER_CONFIGURATOR_H

class ServerConfigurator: public QObject
{
    Q_OBJECT
public:
    explicit ServerConfigurator(QObject *parent = 0);

    virtual ~ ServerConfigurator();

    void configure(QQuickView *view);

private slots:
    void modifyHttpContent(QString *content);
    void processSocketMessage(QString *message);

private:
    // cant pass reference of document directly, because of:
    // Users/abertschi/git-projs/harbour-wlan-keyboard/harbour-wlan-keyboard/inc/rapidjson/document.h:1871: error: 'rapidjson::GenericDocument<Encoding, Allocator, StackAllocator>::GenericDocument(const rapidjson::GenericDocument<Encoding, Allocator, StackAllocator>&) [with Encoding = rapidjson::UTF8<>, Allocator = rapidjson::MemoryPoolAllocator<>, StackAllocator = rapidjson::CrtAllocator, rapidjson::GenericDocument<Encoding, Allocator, StackAllocator> = rapidjson::GenericDocument<rapidjson::UTF8<> >]' is private
    void processEventNewKeycode(QString *message);

    void processEventNewKeyrow(QString *message);


private:
http_server *m_http_server;
websocket_server *m_websocket_server;
Utils *m_keyboardUtils;
};


