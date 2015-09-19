    #ifndef SERVER_ENDPOINT_H
#define SERVER_ENDPOINT_H

#include <QObject>
#include <QDebug>


class ServerEndpoint: public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString m_interfaceName READ interfaceName)
    Q_PROPERTY(QString m_ipAddress READ ipAddress)
    Q_PROPERTY(QString m_hardwareAddr READ hardwareAddr)

public:

    explicit ServerEndpoint(QObject *parent = 0);
    virtual ~ ServerEndpoint();

    void setInterfaceName(QString interface);

    Q_INVOKABLE QString interfaceName();

    void setIpAddress(QString address);

    Q_INVOKABLE QString ipAddress();

    Q_INVOKABLE QString hardwareAddr();

    void setHardwareAddr(QString hw);

private:
    QString m_interfaceName;
    QString m_ipAddress;
    QString m_hardwareAddr;
};

#endif // SERVER_ENDPOINT_H
