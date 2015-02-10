#include "server_configurator.h"
#include <QQuickItem>


// QWidget::focusWidget() and QApplication::focusWidget() are handy for this kind of thing.

ServerConfigurator::ServerConfigurator(QObject *parent): QObject(parent)
{
    this->m_keyboardUtils = new Utils(QObject::parent());
}

ServerConfigurator::~ServerConfigurator() {
}

void ServerConfigurator::configure(QQuickView *view) {

    this->m_websocket_server = new websocket_server(QObject::parent());
    view->rootContext()->setContextProperty("websocketServer", m_websocket_server);
    connect(m_websocket_server, SIGNAL(processMessage(QString*)), this, SLOT(processSocketMessage(QString*)));

    this->m_http_server = new http_server(QObject::parent());
    m_http_server->setStaticContent("/usr/share/harbour-wlan-keyboard/index.html");
    view->rootContext()->setContextProperty("httpServer", m_http_server);

    connect(m_http_server, SIGNAL(modifyStaticContent(QString*)), this, SLOT(modifyHttpContent(QString*)));

    //qmlRegisterType<http_server>("harbour.wlankeyboard.HttpServer", 1, 0, "HttpServer");
    //qmlRegisterType<websocket_server>("harbour.wlankeyboard.WebsocketServer", 1, 0, "WebsocketServer");

}

void ServerConfigurator::modifyHttpContent(QString *content) {
    // todo static
    QString endPoint("__WS_ENDPOINT__");
    QString addr ("ws://" + m_websocket_server->getIp() + ":" + QString::number(m_websocket_server->getPort()));


    if(content->contains(endPoint)) {
        *content = content->replace(endPoint, addr) ;
    }
}

void ServerConfigurator::processSocketMessage(QString *message) {
    char *messageChar = message->toLocal8Bit().data();

    rapidjson::Document document;

    if (document.Parse(messageChar).HasParseError())
        qDebug() << "error";

    if (document.IsObject() && document.HasMember("event")) {
        QString event = document["event"].GetString();

        // todo: pass reference of document directly

        if (event == "new_keycode")
            processEventNewKeycode(message);
         else if (event == "new_keyrow")
            processEventNewKeyrow(message);
         else
            qDebug() << "unknown websocket event received: " << event;
    }
}

void ServerConfigurator::processEventNewKeycode(QString * content) {
    qDebug() << "processing event: newKeycode";



}

void ServerConfigurator::processEventNewKeyrow(QString * content) {
    qDebug() << "processing event: newKeyrow";

    char *messageChar = content->toLocal8Bit().data();
    rapidjson::Document document;
    document.Parse(messageChar);

    QString keyrow = document["data"].GetString();


    QGuiApplication * app = (QGuiApplication*) parent();

    QKeyEvent keyEvent(QEvent::KeyPress,Qt::Key_0, Qt::NoModifier);
    QGuiApplication::sendEvent(this, &keyEvent);


    QQuickItem *inputItem = qobject_cast<QQuickItem*>(QGuiApplication::focusObject());
    qDebug() << "inputItem: " <<inputItem;
    if (inputItem) {
        //inputItem->setEnabled(false);
        //inputItem->keyPressEvent(QKeyEvent::);
    }

    //qDebug() << QGuiApplication::topLevelWidgets();

     qDebug() <<QGuiApplication::focusObject();
    //QWidget * widget = app->focusObject();
    //widget>paste();


    keyrow = "\u200B" + keyrow;
    qDebug() << "set clipboard: " << keyrow;
     m_keyboardUtils->setClipboard(keyrow);
}
