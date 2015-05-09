#ifndef SETTINGS_H
#define SETTINGS_H

#include <QObject>

class Settings : public QObject
{
    Q_OBJECT

    Q_PROPERTY(qint32 httpPort READ getHttpPort WRITE setHttpPort NOTIFY onHttpPortChanged)
    Q_PROPERTY(qint32 wsPort READ getWsPort WRITE setWsPort NOTIFY onWsPortChanged)
    Q_PROPERTY(bool autostart READ getAutostart WRITE setAutostart NOTIFY onAutostartChanged)
    Q_PROPERTY(bool useHttps READ getUseHttps WRITE setUseHttps NOTIFY onUseHttpsChanged)
    Q_PROPERTY(bool firstRun READ getFirstRun WRITE setFirstRun NOTIFY onFirstRunChanged)
    Q_PROPERTY(KeyboardMode keyboardMode READ getKeyboardMode WRITE setKeyboardMode NOTIFY onKeyboardModeChanged)
    Q_PROPERTY(HeadlessMode headlessMode READ getHeadlessMode WRITE setHeadlessMode NOTIFY onHeadlessModeChanged)
    Q_PROPERTY(bool useAnyConnection READ getUseAnyConnection WRITE setUseAnyConnection NOTIFY onUseAnyConnectionChanged)
    Q_PROPERTY(QString connectionInterface READ getConnectionInterface WRITE setConnectionInterface NOTIFY onConnectionInterfaceChanged)
    Q_PROPERTY(qint32 connectionInterfaceIndex READ getConnectionInterfaceIndex WRITE setConnectionInterfaceIndex NOTIFY onConnectionInterfaceIndexChanged)

public:
    explicit Settings(QObject *parent = 0);

    enum KeyboardMode
    {
         CLIPBOARD = 0,
         HEADLESS = 1
     };

    enum HeadlessMode
    {
        RETURN_BASED = 0,
        CONTINUOUS = 1
    };

    Q_ENUMS(KeyboardMode)
    Q_ENUMS(HeadlessMode)

    static Settings&  getInstance()
    {
        static Settings instance;
        return instance;
    }

    void setHttpPort(qint32 httpPort);
    qint32 getHttpPort();

    void setWsPort(qint32 wsPort);
    qint32 getWsPort();

    void setAutostart(bool autostart);
    bool getAutostart();

    void setUseHttps(bool useHttps);
    bool getUseHttps();

    void setKeyboardMode(KeyboardMode keyboardMode);
    KeyboardMode getKeyboardMode();

    void setHeadlessMode(HeadlessMode headlessMode);
    Settings::HeadlessMode getHeadlessMode();

    void setUseAnyConnection(bool useAnyConnection);
    bool getUseAnyConnection();

    void setFirstRun(bool firstRun);
    bool getFirstRun();

    void setConnectionInterface(QString connectionInterface);
    QString getConnectionInterface();

    void setConnectionInterfaceIndex(qint32 connectionInterfaceIndex);
    qint32 getConnectionInterfaceIndex();

    QByteArray toJson() const;


signals:
    void settingsChanged(Settings* s);
    void onHttpPortChanged(qint32 httpPort);
    void onWsPortChanged(qint32 wsPort);
    void onAutostartChanged(bool autostart);
    void onUseHttpsChanged(bool useHttps);
    void onFirstRunChanged(bool firstRun);
    void onKeyboardModeChanged(KeyboardMode keyboardMode);
    void onHeadlessModeChanged(HeadlessMode headlessMode);
    void onUseAnyConnectionChanged(bool useAnyConnection);
    void onConnectionInterfaceChanged(QString connectionInterface);
    void onConnectionInterfaceIndexChanged (qint32 connectionInterfaceIndex);

public slots:

private:
    qint32 m_httpPort;
    qint32 m_wsPort;
    bool m_autostart;
    bool m_useHttps;
    KeyboardMode m_keyboardMode;
    HeadlessMode m_headlessMode;
    bool m_useAnyConnection;
    bool m_firstRun;
    QString m_connectionInterface;
    qint32 m_connectionInterfaceIndex;

    //singelton
    //Settings(Settings const&)        = delete;
    void operator=(Settings const&)  = delete;
};

#endif // SETTINGS_H
