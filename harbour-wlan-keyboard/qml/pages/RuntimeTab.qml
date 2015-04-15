import QtQuick 2.1
import QtFeedback 5.0
import Sailfish.Silica 1.0

Item {
    id: tabRuntime
    height: tabs.height
    width: tabs.width

    state: "NOT_RUNNING"

    Connections {
        target: httpServer
        onRunningChanged: {
            if (isRunning) {
                tabRuntime.state = "RUNNING"
            }
            else {
                tabRuntime.checkOfflineState()
            }
        }
    }

    function checkOfflineState() {
        console.log('logged')
        if (utils.getAvailableEndpointsAsQVariant().size() === 0) {
            tabRuntime.state = "NO_CONNECTION"
        }
        else {
            tabRuntime.state = "NOT_RUNNING"
        }
    }

    Timer {
        id: noConnectionTimer
        repeat: true //tabRuntime.state != "RUNNING"
        interval: 2000
        onIntervalChanged: checkOfflineState()
    }
    Component.onCompleted: noConnectionTimer.start()
    states: [
        State {
            name: "RUNNING"
            PropertyChanges { target: connections; opacity: 1 ; visible: true}
            PropertyChanges { target: notRunning; visible: false }
            PropertyChanges { target: noConnection; visible: false }
        },
        State {
            name: "NOT_RUNNING"
            PropertyChanges { target: connections; visible: false }
            PropertyChanges { target: notRunning; visible: true }
            PropertyChanges { target: noConnection; visible: false }
        },
        State {
            //when: false
            name: "NO_CONNECTION"
            PropertyChanges { target: connections; visible: false }
            PropertyChanges { target: notRunning; visible: false }
            PropertyChanges { target: noConnection; visible: true }
        }
    ]

    NumberAnimation { targets: [noConnection, notRunning, connections]; properties: "opacity"; duration: 1000 }


    RuntimeNoConnection {
        id: noConnection
    }

    RuntimeNotRunning {
        id: notRunning
    }

    RuntimeConnections {
        id: connections
    }
}
