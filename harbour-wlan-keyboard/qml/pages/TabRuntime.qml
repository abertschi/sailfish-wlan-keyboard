import QtQuick 2.1
import Sailfish.Silica 1.0
import "../components"

Item {
    id: tabRuntime
    height: tabs.height
    width: tabs.width

    state: "NOT_RUNNING"

    states: [
        State {
            name: "RUNNING"
            when: notifications.serverState === notifications._SERVER_STATE_ACTIVE
            PropertyChanges { target: active; opacity: 1 ; visible: true}
            PropertyChanges { target: inActive; visible: false }
            PropertyChanges { target: noConnectivity; visible: false }
        },
        State {
            name: "NOT_RUNNING"
            when: notifications.serverState === notifications._SERVER_STATE_INACTIVE
            PropertyChanges { target: active; visible: false }
            PropertyChanges { target: inActive; visible: true }
            PropertyChanges { target: noConnectivity; visible: false }
        },
        State {
            when: notifications.serverState === notifications._SERVER_STATE_NO_CONNECTIVITY
            name: "NO_CONNECTION"
            PropertyChanges { target: active; visible: false }
            PropertyChanges { target: inActive; visible: false }
            PropertyChanges { target: noConnectivity; visible: true }
        }
    ]

    NumberAnimation { targets: [noConnectivity, inActive, active]; properties: "opacity"; duration: 1000 }


    RuntimeNoConnectivityState {
        id: noConnectivity
    }

    RuntimeInactivState {
        id: inActive
    }

    RuntimeActiveState {
        id: active
    }
}
