#include "server_configurator.h"
#include <QQuickItem>


static const QString ENDPOINT_MARKER("__WS_ENDPOINT__");

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

    connect(m_http_server, SIGNAL(modifyHtmlResponse(QString*)), this, SLOT(modifyHtmlContent(QString*)));
}

void ServerConfigurator::modifyHtmlContent(QString *content) {
    QString addr = m_websocket_server->getFullAddresses().at(0);

    if(content->contains(ENDPOINT_MARKER)) {
        *content = content->replace(ENDPOINT_MARKER, addr) ;
    }
}

void ServerConfigurator::processSocketMessage(QString *message) {

    QByteArray byteArray = message->toUtf8();
    const char* messageChar = byteArray.constData();

    qDebug() <<QString::fromUtf8(messageChar);

    QScopedPointer<rapidjson::Document> document (new rapidjson::Document);

    if (document->Parse(messageChar).HasParseError())
        qDebug() << "error in parsing message " << rapidjson::GetParseError_En(document->Parse(messageChar).GetParseError()); // todo fix

    if (document->IsObject() && document->HasMember("event")) {
        QString event = (*document.data())["event"].GetString();

        if (event == "new_keycode") {
            processEventNewKeycode(document.data());
        }
        else if (event == "new_keyrow") {
            processEventNewKeyrow(document.data());
        }
        else
            qDebug() << "unknown websocket event received: " << event;
    }
}

void ServerConfigurator::processEventNewKeycode(rapidjson::Document * document) {
    const rapidjson::Value& data = (*document)["data"];

    const rapidjson::Value& value = data["keyvalue"];

    qDebug() << "processing event: newKeycode";
    QString insert("{\"cmd\":\"%1\",\"arg\":\"%2\"}");
    insert = insert.arg("insert_text").arg(value.GetString());

    qDebug() << "Clipboard set: " << insert;
    //m_keyboardUtils->setClipboard(insert);
}

void ServerConfigurator::processEventNewKeyrow(rapidjson::Document * document) {
    qDebug() << "processing event: newKeyrow";

    QString result;
    QString keys = (*document)["data"].GetString();


    if (Settings::getInstance().getKeyboardMode() == Settings::KeyboardMode::CLIPBOARD)
    {
        result = keys;
    }
    else
    { // Settings::KeyboardMode::HEADLESS
        if (Settings::getInstance().getHeadlessMode() == Settings::HeadlessMode::RETURN_BASED)
        {

            QString tmplt("{\"cmd\":\"%1\",\"arg\":\"%2\"}");
            result = tmplt.arg("insert_text").arg(keys);
        }
        else
        { // Settings::KeyboardMode::CONTINUOUS

        }
    }

    qDebug() << "Clipboard set: " << result;
    m_keyboardUtils->setClipboard(result);
}


