QT += network

QTWEBSOCKET_HEADERS += \
    $$PWD/WsEnums.h \
    $$PWD/QWsSocket.h\
    $$PWD/QWsServer.h \
    $$PWD/QWsHandshake.h \
    $$PWD/QWsFrame.h \
    $$PWD/QTlsServer.h \
    $$PWD/functions.h

HEADERS += $$QTWEBSOCKET_HEADERS
