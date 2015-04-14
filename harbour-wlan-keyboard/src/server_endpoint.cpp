#include "server_endpoint.h"

ServerEndpoint::ServerEndpoint(QObject *parent): QObject(parent)
{
}

ServerEndpoint::~ServerEndpoint() {
}

void ServerEndpoint::setInterfaceName(QString interface) {
    m_interfaceName = interface;
}

QString ServerEndpoint::interfaceName() {
    return m_interfaceName;
}

void ServerEndpoint::setIpAddress(QString address) {
    m_ipAddress =  address;
}

QString ServerEndpoint::ipAddress() {
    return  m_ipAddress;
}

QString ServerEndpoint::hardwareAddr() {
    return m_hardwareAddr;
}

void ServerEndpoint::setHardwareAddr(QString hw) {
    m_hardwareAddr = hw;
}


