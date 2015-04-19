#include "settings.h"

Settings::Settings(QObject *parent) :
    QObject(parent)
{
}

void Settings::setHttpPort(qint32 httpPort)
{
    if (m_httpPort == httpPort)
        return;

    m_httpPort = httpPort;
    emit onHttpPortChanged(httpPort);
}

qint32 Settings::getHttpPort()
{
    return m_httpPort;
}

void Settings::setWsPort(qint32 wsPort)
{
    if (m_wsPort == wsPort)
        return;

    m_wsPort = wsPort;
    emit onWsPortChanged(m_wsPort);
}

qint32 Settings::getWsPort()
{
    return m_wsPort;
}

void Settings::setAutostart(bool autostart)
{
    if (m_autostart == autostart)
        return;

    m_autostart = autostart;
    emit onAutostartChanged(m_autostart);
}

bool Settings::getAutostart()
{
    return m_autostart;
}

void Settings::setUseHttps(bool useHttps)
{
    if (m_useHttps == useHttps)
        return;

    m_useHttps = useHttps;
    emit onUseHttpsChanged(m_useHttps);
}

bool Settings::getUseHttps()
{
    return m_useHttps;
}

void Settings::setKeyboardMode(KeyboardMode keyboardMode)
{
    if (m_keyboardMode == keyboardMode)
        return;

    m_keyboardMode = keyboardMode;
    emit onKeyboardModeChanged(m_keyboardMode);
}

Settings::KeyboardMode Settings::getKeyboardMode()
{
    return m_keyboardMode;
}

void Settings::setUseAnyConnection(bool useAnyConnection)
{
    if (m_useAnyConnection == useAnyConnection)
        return;

    m_useAnyConnection = useAnyConnection;
    emit onUseAnyConnectionChanged(m_useAnyConnection);
}

bool Settings::getUseAnyConnection()
{
    return m_useAnyConnection;
}

void Settings::setFirstRun(bool firstRun)
{
    if (m_firstRun == firstRun)
        return;

    m_firstRun = firstRun;
    emit onFirstRunChanged(m_firstRun);
}

bool Settings::getFirstRun()
{
    return m_firstRun;
}

void Settings::setConnectionInterface(QString connectionInterface)
{
    if (m_connectionInterface == connectionInterface)
        return;

    m_connectionInterface = connectionInterface;
    emit onConnectionInterfaceChanged(m_connectionInterface);
}

QString Settings::getConnectionInterface()
{
    return m_connectionInterface;
}

void Settings::setConnectionInterfaceIndex(qint32 connectionInterfaceIndex)
{
    if (m_connectionInterfaceIndex == connectionInterfaceIndex)
        return;

    m_connectionInterfaceIndex = connectionInterfaceIndex;
    emit onConnectionInterfaceIndexChanged(m_connectionInterfaceIndex);
}

qint32 Settings::getConnectionInterfaceIndex()
{
    return m_connectionInterfaceIndex;
}

void Settings::setHeadlessMode(HeadlessMode headlessMode)
{
    if(m_headlessMode == headlessMode)
        return;

    m_headlessMode = headlessMode;
    emit onHeadlessModeChanged(m_headlessMode);
}

Settings::HeadlessMode Settings::getHeadlessMode()
{
    return m_headlessMode;
}

QString* Settings::toJson() const
{
    return new QString("");

}


