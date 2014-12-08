QT += network core gui

QHTTP_SERVER_DIR = $$PWD

INCLUDEPATH += $$QHTTP_SERVER_DIR

HEADERS += $$QHTTP_SERVER_DIR/qhttprequest.h \
    $$QHTTP_SERVER_DIR/qhttpresponse.h \
    $$QHTTP_SERVER_DIR/qhttpserverapi.h \
    $$QHTTP_SERVER_DIR/qhttpserverfwd.h \
    $$QHTTP_SERVER_DIR/qhttpserver.h
    $$QHTTP_SERVER_DIR/qhttpconnection.h

SOURCES = $$QHTTP_SERVER_DIR/qhttpconnection.cpp \
    $$QHTTP_SERVER_DIR/qhttprequest.cpp \
    $$QHTTP_SERVER_DIR/qhttpresponse.cpp \
    $$QHTTP_SERVER_DIR/qhttpserver.cpp

include($$QHTTP_SERVER_DIR/http-parser/http_parser.pri)
