import QtQuick 2.0
import Sailfish.Silica 1.0

Item {

    QtObject {
        id: serverStates
        property int stateActive: 0
        property int stateInActive: 1
        property int stateNoConnectivity: 2
    }

    id: appEvents

    property bool connectivityAvailable: true
    property bool serverRunning: {
        return settings.autostart
    }

    property int serverState:
        (notifications.serverRunning && notifications.connectivityAvailable) ? serverStates.stateActive :
           (!notifications.serverRunning && notifications.connectivityAvailable) ? serverStates.stateInActive :
                serverStates.stateNoConnectivity

    Component.onCompleted:  {
        console.log("starting timer")
    }

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
            console.log("timer checks states")

            // todo: check if there is a way with system notifications, dbus
            if (utils.getAvailableEndpointSize() > 0) {
                if (! connectivityAvailable) {
                    connectivityAvailable = true
                    console.log("Connectivity available")
                }
            }
            else {
                if (connectivityAvailable) {
                    connectivityAvailable = false
                     console.log("Connectivity dropped")
                }
            }
        }
    }
}
