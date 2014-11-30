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

CONFIG += sailfishapp

SOURCES += src/harbour-wlan-keyboard.cpp \
           src/Server.cpp

INCLUDEPATH += inc

LIBS += -lboost_system

OTHER_FILES += qml/harbour-wlan-keyboard.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    qml/pages/SecondPage.qml \
    rpm/harbour-wlan-keyboard.changes.in \
    rpm/harbour-wlan-keyboard.spec \
    rpm/harbour-wlan-keyboard.yaml \
    translations/*.ts \
    harbour-wlan-keyboard.desktop
    inc/websocketpp.pri

include(inc/websocketpp.pri)

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/harbour-wlan-keyboard-de.ts

HEADERS +=

