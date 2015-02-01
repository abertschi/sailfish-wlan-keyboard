#-------------------------------------------------
#
# Project created by QtCreator 2012-03-05T10:38:43
#
#-------------------------------------------------
QT += network

QT -= gui

TARGET = QtWebsocket
TEMPLATE = lib
# CONFIG += staticlib

CONFIG += dll debug_and_release

QTWEBSOCKET_HEADERS += \
    $$PWD/WsEnums.h \
    $$PWD/QWsSocket.h\
    $$PWD/QWsServer.h \
    $$PWD/QWsHandshake.h \
    $$PWD/QWsFrame.h \
    $$PWD/QTlsServer.h \
    $$PWD/functions.h

SOURCES += \
    QWsServer.cpp \
    QWsSocket.cpp \
    QWsHandshake.cpp \
    QWsFrame.cpp \
    QTlsServer.cpp \
    functions.cpp

HEADERS += $$QTWEBSOCKET_HEADERS
