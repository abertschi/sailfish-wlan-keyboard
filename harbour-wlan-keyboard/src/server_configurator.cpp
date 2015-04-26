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

    this->m_http_server = new http_server(QObject::parent());
    m_http_server->setStaticContent("/usr/share/harbour-wlan-keyboard/index.html");
    view->rootContext()->setContextProperty("httpServer", m_http_server);

    connect(m_http_server, SIGNAL(modifyHtmlResponse(QString*)), this, SLOT(modifyHtmlContent(QString*)));
}

void ServerConfigurator::modifyHtmlContent(QString *content)
{
    QString addr = m_websocket_server->getFullAddresses().at(0);
    if(content->contains(ENDPOINT_MARKER)) {
        *content = content->replace(ENDPOINT_MARKER, addr) ;
    }
}

void ServerConfigurator::processSocketMessage(QString *message)
{
    QScopedPointer<rapidjson::Document> document (new rapidjson::Document);
    const char* messageChar = message->toLatin1();
    qDebug() <<QString::fromUtf8(messageChar);

    if (document->Parse(messageChar))
    {
        qDebug() << "error in parsing message "
                 << rapidjson::GetParseError_En(document->Parse(messageChar).GetParseError()); // todo fix
    }
    if (document->HasMember("event"))
    {
        QString event = (*document.data())["event"].GetString();
        if (event == "insert_text")
        {
            QString text = (*document)["data"].GetString();
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
            QString direction = (*document)["data"].GetString();
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

