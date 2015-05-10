import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {

    state: "RUNNING"

    states: [
        State {
            name: "RUNNING"
            when: notifications.serverState === notifications._SERVER_STATE_ACTIVE
            PropertyChanges { target: statusLabel; text: "Status: <b>active</b>"}
            PropertyChanges { target: labelRepeater; model: httpServer.getFullAddresses()}
        },
        State {
            name: "NOT_RUNNING"
            when: notifications.serverState === notifications._SERVER_STATE_INACTIVE
            PropertyChanges { target: statusLabel; text: "Status: <b>inactive</b>"}
            PropertyChanges { target: labelRepeater; model: ["Ready to start"]}
        },
        State {
            when: notifications.serverState === notifications._SERVER_STATE_NO_CONNECTIVITY
            name: "NO_CONNECTION"
            PropertyChanges { target: statusLabel; text: "Status: <b>no connectivity</b>"}
            PropertyChanges { target: labelRepeater; model: ["Connect your device"]}
        }
    ]

    Image {
        id: image
        //y: Theme.paddingLarge
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: Theme.paddingSmall
        anchors.top: parent.top
        opacity: 1
        width: parent.width / 3 * 2
        fillMode: Image.PreserveAspectFit
        source: "../pages/server-switch.png"
    }

    Column {
        id: column
        width: parent.width
        anchors {
            left: parent.left
            horizontalCenter: parent.horizontalCenter
            top: image.bottom
        }

        Label {
            id: statusLabel
            wrapMode: Text.Wrap
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: Theme.fontSizeTiny
            color: Theme.highlightColor
        }
        Label {
            id: keyboardMode
            text: {
                var mode = settings.keyboardMode === settings._KEYBOARD_MODE_CLIPBOARD ? qsTr("Clipboard") : qsTr("Headless");
                return qsTr("Mode:") + " <b>" + mode + "</b>"
            }
            wrapMode: Text.Wrap
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: Theme.fontSizeTiny
            color: Theme.highlightColor
        }
    }

    Column {
        id: column2
        width: parent.width
        anchors {
            left: parent.left
            horizontalCenter: parent.horizontalCenter
            top: column.bottom
            topMargin: Theme.paddingMedium
        }

        Repeater {
            id: labelRepeater
            width: parent.width
            model: ""
            Label {
                id: addrLabel
                wrapMode: Text.Wrap
                text: modelData
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: Theme.fontSizeTiny
                color: Theme.highlightColor
            }
        }
    }

    function extractHttpPrefix(addr) {
        if(addr !== 'undefined' && addr.length > 1) {
            return addr.substr(7, addr.length);
        }
        return addr;
    }

    CoverActionList {
        id: coverAction

        CoverAction {
           iconSource: "image://theme/icon-cover-pause"
            onTriggered: {
                if (app.isServerRunning() && notifications.serverState !== notifications._SERVER_STATE_NO_CONNECTIVITY) {
                    console.log("Coveraction to stop the server pressed")

                    app.stopServers();
                }
            }
        }
        CoverAction {
            iconSource: "image://theme/icon-cover-play"
            onTriggered: {
                if (!app.isServerRunning() && notifications.serverState !== notifications._SERVER_STATE_NO_CONNECTIVITY) {
                    console.log("Coveraction to start the server pressed")
                    app.startServers();
                }
            }
        }
    }
}


