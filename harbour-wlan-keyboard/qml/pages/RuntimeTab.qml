import QtQuick 2.1
import QtFeedback 5.0
import Sailfish.Silica 1.0

Item {
    id: tabRuntime
    height: tabs.height
    width: tabs.width

    state: "NOT_RUNNING"

    states: [
        State {
            name: "RUNNING"
            when: notifications.serverRunning && notifications.connectivityAvailable
            PropertyChanges { target: connections; opacity: 1 ; visible: true}
            PropertyChanges { target: notRunning; visible: false }
            PropertyChanges { target: noConnection; visible: false }
        },
        State {
            name: "NOT_RUNNING"
            when: !notifications.serverRunning && notifications.connectivityAvailable
            PropertyChanges { target: connections; visible: false }
            PropertyChanges { target: notRunning; visible: true }
            PropertyChanges { target: noConnection; visible: false }
        },
        State {
            when: ! notifications.connectivityAvailable
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
