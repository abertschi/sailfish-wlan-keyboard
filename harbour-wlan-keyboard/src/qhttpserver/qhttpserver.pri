#include(../qhttpserver.pri)

QHTTPSERVER_BASE = ..
TEMPLATE = lib

!win32:VERSION = 0.1.0

QT += network
QT -= gui

CONFIG += dll debug_and_release

CONFIG(debug, debug|release) {
    win32: TARGET = $$join(TARGET,,,d)
}

QHTTP_SERVER_DIR = $$PWD
HTTP_PARSER_DIR = $$PWD/../http-parser/

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
    $$QHTTP_SERVER_DIR/qhttpserver.cpp \
    $$HTTP_PARSER_DIR/http_parser.c

DEFINES += QHTTPSERVER_EXPORT

INCLUDEPATH += \
    $$HTTP_PARSER_DIR \
    $$QHTTP_SERVER_DIR

PRIVATE_HEADERS += \
    $$HTTP_PARSER_DIR/http_parser.h
    $$QHTTP_SERVER_DIR/qhttpconnection.h

PUBLIC_HEADERS += \
    $$QHTTP_SERVER_DIR/qhttpserver.h
    $$QHTTP_SERVER_DIR/qhttprequest.h
    $$QHTTP_SERVER_DIR/qhttpresponse.h
    $$QHTTP_SERVER_DIR/qhttpserverapi.h
    $$QHTTP_SERVER_DIR/qhttpserverfwd.h

HEADERS = $$PRIVATE_HEADERS $$PUBLIC_HEADERS

OBJECTS_DIR = $$QHTTPSERVER_BASE/build
MOC_DIR = $$QHTTPSERVER_BASE/build
DESTDIR = $$QHTTPSERVER_BASE/lib

target.path = $$LIBDIR
headers.path = $$INCLUDEDIR
headers.files = $$PUBLIC_HEADERS
