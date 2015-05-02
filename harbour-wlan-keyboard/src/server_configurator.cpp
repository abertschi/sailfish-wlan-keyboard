#include "server_configurator.h"
#include <QQuickItem>

static const QString ENDPOINT_MARKER("__WS_ENDPOINT__");

ServerConfigurator::ServerConfigurator(QObject *parent): QObject(parent)
{
    this->m_keyboardUtils = new Utils(QObject::parent());
    this->m_headless_keyboard = new HeadlessKeyboardDelegate(parent);
}

ServerConfigurator::~ServerConfigurator() {
}

void ServerConfigurator::configure(QQuickView *view)
{
    this->m_websocket_server = new websocket_server(QObject::parent());
    view->rootContext()->setContextProperty("websocketServer", m_websocket_server);
    connect(m_websocket_server, SIGNAL(processMessage(QString*)), this, SLOT(processSocketMessage(QString*)));
    //connect(m_websocket_server, SIGNAL(processNewClientConnected())), this, SLOT(onNewClientConnected());

    this->m_http_server = new http_server(QObject::parent());
    m_http_server->setStaticContent("/usr/share/harbour-wlan-keyboard/index.html");
    view->rootContext()->setContextProperty("httpServer", m_http_server);
    connect(m_http_server, SIGNAL(modifyHtmlResponse(QString*)), this, SLOT(modifyHtmlContent(QString*)));

    //connect(Settings::getInstance(), SIGNAL(settingsChanged(Settings*)), this, SLOT(onSettingsChanged(Settings*)));
}

void ServerConfigurator::modifyHtmlContent(QString *content)
{
    QString addr = m_websocket_server->getFullAddresses().at(0);
    if(content->contains(ENDPOINT_MARKER)) {
        *content = content->replace(ENDPOINT_MARKER, addr) ;
    }
}

void ServerConfigurator::sendSettingsToWsClients(QString settingsJson)
{
    QString templ = QString("{\"event\":\"update_settings\", \"data\": %1 }").arg(settingsJson);
    m_websocket_server->send(templ);
}

void ServerConfigurator::processSocketMessage(QString *message)
{
    QJsonDocument d = QJsonDocument::fromJson(message->toUtf8());
    if (d.isObject())
    {
        QJsonObject jsonObj = d.object();
        QString event = jsonObj["event"].toString();
        if (event == "insert_text")
        {
            QString text = jsonObj["data"].toString();
            processInsertText(text);
        }
        else if (event == "send_key_return")
        {
            processKeyReturn();
        }
        else if (event == "send_key_del")
        {
            processKeyDel();
        }
        else if (event == "send_key_arrow") {
            QString direction = jsonObj["data"].toString();
            processKeyArrow(direction);
        }
        else
        {
            qDebug() << "unknown websocket event received: " << event;
        }
    }
}

void ServerConfigurator::processInsertText(QString text)
{
    if (Settings::getInstance().getKeyboardMode() == Settings::KeyboardMode::CLIPBOARD)
    {
        m_keyboardUtils->setClipboard(text);
    }
    else
    { // Settings::KeyboardMode::HEADLESS
        QString label = m_http_server->getFullAddresses().at(0);
        m_headless_keyboard->send_keyboard_label(label);
        m_headless_keyboard->send_text(text);
    }
}

void ServerConfigurator::processKeyReturn()
{
    m_headless_keyboard->send_key_return();
}

void ServerConfigurator::processKeyDel()
{
    m_headless_keyboard->send_key_del();
}

void ServerConfigurator::processKeyArrow(QString in)
{
    HeadlessKeyboardDelegate::ArrowDirection arrowEnum;

    QString arrow = in.toLower();
    if (arrow == "left")
    {
        arrowEnum = HeadlessKeyboardDelegate::ArrowDirection::LEFT;
    }
    else if (arrow == "right")
    {
        arrowEnum = HeadlessKeyboardDelegate::ArrowDirection::RIGHT;
    }
    else if (arrow == "up")
    {
        arrowEnum = HeadlessKeyboardDelegate::ArrowDirection::UP;
    }
    else if (arrow == "down")
    {
        arrowEnum = HeadlessKeyboardDelegate::ArrowDirection::DOWN;
    }

    m_headless_keyboard->send_key_arrow(arrowEnum);
}

void ServerConfigurator::send(QString msg)
{
    m_websocket_server->send(msg);
}

void ServerConfigurator::onNewClientConnected()
{
    sendSettingsToWsClients(Settings::getInstance().toJson());
}

void ServerConfigurator::onSettingsChanged(Settings * s)
{
    sendSettingsToWsClients(s->toJson());
}

/*
void ServerConfigurator::processEventNewKeycode(rapidjson::Document * document)
{

    const rapidjson::Value& data = (*document)["data"];

    const rapidjson::Value& value = data["keyvalue"];

    qDebug() << "processing event: newKeycode";
    QString insert("{\"cmd\":\"%1\",\"arg\":\"%2\"}");
    insert = insert.arg("insert_text").arg(value.GetString());

    qDebug() << "Clipboard set: " << insert;
    //m_keyboardUtils->setClipboard(insert);
}

void ServerConfigurator::processEventNewKeyrow(rapidjson::Document * document)
{
}
*/
