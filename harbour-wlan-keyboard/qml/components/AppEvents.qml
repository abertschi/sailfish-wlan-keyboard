import QtQuick 2.0
import Sailfish.Silica 1.0

Item {

     id: appEvents

    property int _SERVER_STATE_ACTIVE: 0
    property int _SERVER_STATE_INACTIVE: 1
    property int _SERVER_STATE_NO_CONNECTIVITY: 2

    property bool connectivityAvailable: true
    property bool serverRunning

    property int serverState:
        (notifications.serverRunning && notifications.connectivityAvailable) ? _SERVER_STATE_ACTIVE :
           (!notifications.serverRunning && notifications.connectivityAvailable) ? _SERVER_STATE_INACTIVE :
                _SERVER_STATE_NO_CONNECTIVITY

     signal onStateReload()
     signal applicationStateActive(bool active) // active if in foreground

    Connections {
        target: httpServer
        onRunningChanged: {
            serverRunning = isRunning
        }
    }

    Connections {
        target: qGuiApplication
        onApplicationStateChanged: {
            console.log("application state: " + state);
            connectivityTimer.running = (state == 4); // 4 =  active
            applicationStateActive(state == 4);
        }
    }

    Component.onCompleted: {
        serverRunning =  settings.autostart
    }

    onServerStateChanged: {
        onStateReload()
    }

    Timer {
        id: connectivityTimer
        property int lastSize: -1

        repeat: true
        interval: 5000
        running: true
        onTriggered: {
            var endpoints = utils.getAvailableEndpointSize();
            if (lastSize !== endpoints) {
                lastSize = endpoints
                onStateReload()
            }

            // todo: check if there is a way with system notifications, dbus
            if (endpoints > 0) {
                if (! connectivityAvailable) {
                    connectivityAvailable = true
                    console.log("New network connectivity available")
                }
            }
            else {
                if (connectivityAvailable) {
                    connectivityAvailable = false
                    console.log("Connectivity was dropped")
                }
            }
        }
    }
}
