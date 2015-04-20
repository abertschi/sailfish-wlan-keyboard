import QtQuick 2.0
import Sailfish.Silica 1.0

Item {

     id: appEvents

    property int _SERVER_STATE_ACTIVE: 0
    property int _SERVER_STATE_INACTIVE: 1
    property int _SERVER_STATE_NO_CONNECTIVITY: 2

    property bool connectivityAvailable: true
    property bool serverRunning: {
        return settings.autostart
    }

    property int serverState:
        (notifications.serverRunning && notifications.connectivityAvailable) ? _SERVER_STATE_ACTIVE :
           (!notifications.serverRunning && notifications.connectivityAvailable) ? _SERVER_STATE_INACTIVE :
                _SERVER_STATE_NO_CONNECTIVITY

    Connections {
        target: httpServer
        onRunningChanged: {
            serverRunning = isRunning
        }
    }

    Timer {
        id: connectivityTimer
        repeat: true
        interval: 5000
        running: true
        onTriggered: {
            console.log("Checking network connectivity ...")

            // todo: check if there is a way with system notifications, dbus
            if (utils.getAvailableEndpointSize() > 0) {
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
