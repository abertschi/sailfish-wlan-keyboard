#ifndef HEADLESS_KEYBOARD_DELEGATE_H
#define HEADLESS_KEYBOARD_DELEGATE_H

#include <QObject>
#include <QtDBus/QtDBus>


#define SERVICE "ch.abertschi.keyboard.headless"
#define PATH  "/"
#define IF_NAME  "ch.abertschi.keyboard.headless.Server"
class HeadlessKeyboardDelegate : public QObject
{
    Q_OBJECT
public:
    explicit HeadlessKeyboardDelegate(QObject *parent = 0);
    virtual ~ HeadlessKeyboardDelegate();

    enum ArrowDirection
    {
        UP = 1,
        DOWN = 2,
        LEFT = 3,
        RIGHT = 4
    };

    void send_text(QString text);
    void exit();
    void send_key_return();
    void send_key_del();
    void send_key_arrow (ArrowDirection direction);
    void send_keyboard_label(QString label);
    void send_enable_debug(bool enabled);
    void send_enable_keyboard();

signals:

public slots:

private:
    QDBusInterface * m_dbus_iface;

};
#endif // HEADLESS_KEYBOARD_DELEGATE_H
