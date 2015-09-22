#include "headless_keyboard_delegate.h"

HeadlessKeyboardDelegate::HeadlessKeyboardDelegate(QObject *parent) : QObject(parent)
{
    this->m_service_watcher = new QDBusServiceWatcher(SERVICE, QDBusConnection::sessionBus());

    QObject::connect(m_service_watcher, SIGNAL(serviceRegistered(const QString&)),
                     this, SLOT(serviceRegistered(const QString&)));

    QObject::connect(m_service_watcher, SIGNAL(serviceUnregistered(const QString&)),
                     this, SLOT(serviceUnregistered(const QString&)));

    this->m_dbus_iface = new QDBusInterface(SERVICE, PATH, IF_NAME, QDBusConnection::sessionBus(), parent);
    if (! m_dbus_iface->isValid())
    {
        qDebug() << "dbus interface " << SERVICE << " is invalid";
        m_is_running = false;
        runningChanged(false);
    }
    qDebug() << "dbus connection successfully created";
    QDBusConnection::sessionBus().connect(SERVICE,
                                          PATH,
                                          IF_NAME,
                                          "receive_clipboard_changed",
                                          this, SLOT(onClipboardChangedPrivate(QString)));

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
    //m_dbus_iface->asyncCall("send_keyboard_label", label);
    qDebug() << "Feature is not supported";
}

void HeadlessKeyboardDelegate::send_enable_debug(bool enabled)
{
    m_dbus_iface->asyncCall("send_enable_debug", enabled);
}

void HeadlessKeyboardDelegate::send_enable_keyboard()
{
    m_dbus_iface->asyncCall("send_enable_keyboard");
}

void HeadlessKeyboardDelegate::onClipboardChangedPrivate(QString cb)
{
    emit onClipboardChanged(cb);
}

bool HeadlessKeyboardDelegate::isRunning()
{
    return m_is_running;
}

void HeadlessKeyboardDelegate::onServiceRegistered(QString s)
{
    qDebug() << "headless mode service was registered " << s;
    m_is_running = true;
    emit runningChanged(true);

}

void HeadlessKeyboardDelegate::onServiceUnRegistered(QString s)
{
    qDebug() << "headless mode service was unregistered " << s;
    m_is_running = false;
    emit runningChanged(false);
}
