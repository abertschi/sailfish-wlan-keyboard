TARGET = harbour-wlan-keyboard

CONFIG += sailfishapp warn_off plugin c++11 qdbus

QT += core gui quick network

INCLUDEPATH += inc src

include(gitversion.pri)

SOURCES += \
    $$PWD/src/harbour-wlan-keyboard.cpp \
    $$PWD/src/http_server.cpp \
    $$PWD/src/websocket_server.cpp \
    src/utils.cpp \
    src/server_configurator.cpp \
    src/server_endpoint.cpp \
    src/settings.cpp \
    src/headless_keyboard_delegate.cpp

HEADERS += \
    src/http_server.h \
    src/websocket_server.h \
    src/utils.h \
    src/server_configurator.h \
    src/server_endpoint.h \
    src/settings.h \
    src/headless_keyboard_delegate.h

include(inc/qhttpserver/qhttpserver.pri)
include(inc/QtWebsocket/qtwebsocket_headers.pri)

OTHER_FILES += \
    qml/harbour-wlan-keyboard.qml \
    qml/cover/CoverPage.qml \
    rpm/harbour-wlan-keyboard.changes.in \
    rpm/harbour-wlan-keyboard.spec \
    rpm/harbour-wlan-keyboard.yaml \
    translations/**.ts \
    harbour-wlan-keyboard.desktop \
    harbour-wlan-keyboard.png \
    qml/pages/img/headless.gif \
    qml/pages/img/clipboard.gif \
    qm/cover/cover.png \
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
    qml/components/PopupLoad.qml \
    404.html \
    ../harbour-wlan-keyboard-html/dist/**/*.*

CONFIG += sailfishapp_i18n static

TRANSLATIONS += translations/harbour-wlan-keyboard-de.ts
TRANSLATIONS += translations/harbour-wlan-keyboard-sv.ts
TRANSLATIONS += translations/harbour-wlan-keyboard-zh_CN.ts
TRANSLATIONS += translations/harbour-wlan-keyboard.ts

# Third Party libs
LIB_BASE = _DO_DEFINE
QMAKE_RPATHDIR +=  /usr/share/harbour-wlan-keyboard/lib

linux-g++-64: {
LIB_BASE = $$PWD/lib/armv7hl
}
else {
LIB_BASE = $$PWD/lib/armv7hl # $$PWD/lib/armv7hl  i486
}

unix {
    # get rid of mac osx DS_Store files
    system(find $$PWD -name ".DS_Store" -depth -exec rm {} \;)
}

LIBS += $$LIB_BASE/libqhttpserver.so.0
LIBS += $$LIB_BASE/libQtWebsocket.so.1

lib.files += $$LIB_BASE/libqhttpserver.so.0 \
             $$LIB_BASE/libQtWebsocket.so.1
lib.path = \
    /usr/share/harbour-wlan-keyboard/lib

INSTALLS += lib

html.files += ../harbour-wlan-keyboard-html/dist/*
html.path = /usr/share/harbour-wlan-keyboard/publish

html404.files += 404.html
html404.path = /usr/share/harbour-wlan-keyboard/

INSTALLS += html html404 trans

RESOURCES +=
