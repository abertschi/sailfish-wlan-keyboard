#include "headless_keyboard_delegate.h"

HeadlessKeyboardDelegate::HeadlessKeyboardDelegate(QObject *parent) : QObject(parent)
{
    this->m_dbus_iface = new QDBusInterface(SERVICE, PATH, IF_NAME, QDBusConnection::sessionBus(), parent);
    if (! m_dbus_iface->isValid())
    {
        qDebug() << "dbus interface is invalid";
        //exit(1); // todo
    }
    qDebug() << "dbus connection successfully created";
    QDBusConnection::sessionBus().connect(SERVICE,
                                          PATH,
                                          IF_NAME,
                                          "receive_clipboard_changed",
                                          this, SLOT(receive_clibpoard_changed_private(QString)));
}

HeadlessKeyboardDelegate:: ~ HeadlessKeyboardDelegate()
{
    delete(this->m_dbus_iface);
}

void HeadlessKeyboardDelegate::send_text(QString text)
{
    m_dbus_iface->asyncCall("send_text", text);
}

void HeadlessKeyboardDelegate::exit()
{
    m_dbus_iface->asyncCall("exit");
}

void HeadlessKeyboardDelegate::send_key_return()
{
    m_dbus_iface->asyncCall("send_key_return");
}

void HeadlessKeyboardDelegate::send_key_del()
{
    m_dbus_iface->asyncCall("send_key_del");
}

void HeadlessKeyboardDelegate::send_key_arrow (ArrowDirection direction)
{
    QString msg;
    switch(direction)
    {
    case LEFT:
        msg = "left";
        break;
    case RIGHT:
        msg = "right";
        break;
    case UP:
        msg = "up";
        break;
    case DOWN:
        msg = "down";
        break;
    default:
        return;
    }

    m_dbus_iface->asyncCall("send_key_arrow", msg);
}

void HeadlessKeyboardDelegate::send_keyboard_label(QString label)
{
    m_dbus_iface->asyncCall("send_keyboard_label", label);
}

void HeadlessKeyboardDelegate::send_enable_debug(bool enabled)
{
    m_dbus_iface->asyncCall("send_enable_debug", enabled);
}

void HeadlessKeyboardDelegate::send_enable_keyboard()
{
    m_dbus_iface->asyncCall("send_enable_keyboard");
}

void HeadlessKeyboardDelegate::receive_clibpoard_changed_private(QString cb)
{
    emit on_clipboard_set(cb);
}
