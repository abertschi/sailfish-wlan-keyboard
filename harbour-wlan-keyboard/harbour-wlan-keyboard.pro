# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application

TARGET = harbour-wlan-keyboard

CONFIG += sailfishapp warn_off plugin c++11

SOURCES += \
    $$PWD/src/harbour-wlan-keyboard.cpp \
    $$PWD/src/http_server.cpp \
    $$PWD/src/websocket_server.cpp \
    src/utils.cpp \
    src/server_configurator.cpp \
    src/server_endpoint.cpp \
    src/settings.cpp

QT += core gui quick network

INCLUDEPATH += inc src

OTHER_FILES += \
    qml/harbour-wlan-keyboard.qml \
    qml/cover/CoverPage.qml \
    rpm/harbour-wlan-keyboard.changes.in \
    rpm/harbour-wlan-keyboard.spec \
    rpm/harbour-wlan-ke yboard.yaml \
    translations/*.ts \
    harbour-wlan-keyboard.desktop \
    harbour-wlan-keyboard.png \
    index.html \
    qml/pages/img/headless.gif \
    qml/pages/img/clipboard.gif \
    qm/cover/cover.png \
    qml/pages/HomePage.qml \
    qml/components/MyActionButton.qml \
    qml/services/LocalStore.js \
    qml/components/Settings.qml \
    qml/components/AboutImage.qml \
    qml/components/AppEvents.qml \
    qml/components/RuntimeActiveState.qml \
    qml/components/RuntimeNoConnectivityState.qml \
    qml/components/RuntimeInactivState.qml \
    qml/pages/PageAbout.qml \
    qml/pages/PageHeadlessMode.qml \
    qml/pages/PageContainer.qml \
    qml/pages/TabRuntime.qml \
    qml/pages/TabConfig.qml \
    qml/pages/PageClipboardMode.qml \
    qml/components/PopupBase.qml \
    qml/components/PopupError.qml \
    qml/components/PopupLoad.qml

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n static
TRANSLATIONS += translations/harbour-wlan-keyboard-de.ts

HEADERS += \
    src/http_server.h \
    src/websocket_server.h \
    src/utils.h \
    src/server_configurator.h \
    src/start_server_input.h \
    src/server_endpoint.h \
    src/settings.h

include(inc/qhttpserver/qhttpserver.pri)
include(inc/QtWebsocket/qtwebsocket_headers.pri)
include(inc/rapidjson/rapidjson.pri)

# Third Party libs
LIB_BASE = _DO_DEFINE
QMAKE_RPATHDIR +=  /usr/share/harbour-wlan-keyboard/lib

linux-g++-64 {
LIB_BASE = $$PWD/lib/i486
}
else:linux-g++ {
LIB_BASE = $$PWD/lib/i486 # $$PWD/lib/armv7hl  i486
}

# LIBS += -L$$LIB_BASE -lqhttpserver

LIBS += $$LIB_BASE/libqhttpserver.so.0
LIBS += $$LIB_BASE/libQtWebsocket.so.1

lib.files += $$LIB_BASE/libqhttpserver.so.0 \
             $$LIB_BASE/libQtWebsocket.so.1
lib.path = \
    /usr/share/harbour-wlan-keyboard/lib

INSTALLS += lib

resources.files += index.html
resources.path = /usr/share/harbour-wlan-keyboard

INSTALLS += resources

RESOURCES +=


