import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {

    state: "RUNNING"

    states: [
        State {
            name: "RUNNING"
            when: notifications.serverState === notifications.serverStates.stateActive
            PropertyChanges { target: statusLabel; text: "Status: <b>active</b>"}
            PropertyChanges { target: addrLabel; text: extractHttpPrefix(httpServer.getFullAddresses().at(0))}
        },
        State {
            name: "NOT_RUNNING"
            when: notifications.serverState === notifications.serverStates.stateInActive
            PropertyChanges { target: statusLabel; text: "Status: <b>inactive</b>"}
            PropertyChanges { target: addrLabel; text: "Start the server"}
        },
        State {
            when: notifications.serverState === notifications.serverStates.stateNoConnectivity
            name: "NO_CONNECTION"
            PropertyChanges { target: statusLabel; text: "Status: <b>no connectivity</b>"}
            PropertyChanges { target: addrLabel; text: "Connect your device"}
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

        width: parent.width
        anchors {
            left: parent.left
            horizontalCenter: parent.horizontalCenter
            top: image.bottom
            topMargin: Theme.paddingMedium
        }
        height: parent.height

        Label {
            id: statusLabel
            //text: "Status: <b>inactive</b>"
            //width: parent.width - 2 * Theme.paddingLarge
            wrapMode: Text.Wrap
            //font.bold: true
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: Theme.fontSizeTiny
            color: Theme.highlightColor
        }

        Label {
            id: addrLabel
            //text: extractHttpPrefix("http://192.168.111.111:7777")
            //width: parent.width - 2 * Theme.paddingLarge
            wrapMode: Text.Wrap
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: Theme.fontSizeTiny
            color: Theme.highlightColor
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
            iconSource: "image://theme/icon-cover-new"
            onTriggered: {
            }
        }
        CoverAction {
            iconSource: "image://theme/icon-cover-new"
            onTriggered: {
            }
        }
    }
}


