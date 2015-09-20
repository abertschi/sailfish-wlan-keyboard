import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {
    id: cover

    state: "RUNNING"

    states: [
        State {
            name: "RUNNING"
            when: notifications.serverState === notifications._SERVER_STATE_ACTIVE
            PropertyChanges { target: statusLabel; text: qsTr("<b>running</b>")}
            PropertyChanges { target: action; iconSource: "image://theme/icon-cover-pause" }
        },
        State {
            name: "NOT_RUNNING"
            when: notifications.serverState === notifications._SERVER_STATE_INACTIVE
            PropertyChanges { target: statusLabel; text: qsTr("<b>inactive</b>")}
            PropertyChanges { target: action; iconSource: "image://theme/icon-cover-play" }

        },
        State {
            when: notifications.serverState === notifications._SERVER_STATE_NO_CONNECTIVITY
            name: "NO_CONNECTION"
            PropertyChanges { target: statusLabel; text: "<b>no connectivity</b>"}
        }
    ]

    BackgroundItem {
        id: bg
        anchors.top: cover.top
        anchors.left: cover.left
        anchors.bottom: cover.bottom
        anchors.fill: parent

        AnimatedImage {
            id: animation;
            source: "../pages/img/server_run_slow.gif"
            width: parent.width * 2
            rotation: 300
            anchors.top: bg.top
            anchors.topMargin: Theme.paddingLarge
            fillMode: Image.PreserveAspectFit
            opacity: (animation.playing ? .5: .2)
            playing: notifications.serverRunning

            onPlayingChanged: {
                if (!animation.playing) {
                    animation.currentFrame = 4
                }
            }
        }
    }

    Rectangle {
        id: bgNumber
        anchors.top: cover.top
        anchors.right: cover.right
        anchors.rightMargin: Theme.paddingSmall* 2
        anchors.topMargin: Theme.paddingSmall * 2
        width: Theme.paddingSmall * 1.5
        height: Theme.paddingSmall * 1.5
        color: "transparent"
        border.color:  "transparent"
        radius: 100

        Label {
            id: numberOfConnections
            text: ""
            wrapMode: Text.Wrap
            font.bold: true
            anchors.centerIn: parent

            font.pixelSize: Theme.fontSizeTiny * .7
            color: Theme.highlightColor
            opacity: .8
        }

     }

    Connections {
        target: websocketServer
        onNumberOfClientsChanged: {
            if (websocketServer.getNumberOfClients() == 0) {
                bgNumber.color = "transparent";
                bgNumber.border.color = "transparent";
            }
            else {
                bgNumber.color = Theme.highlightColor;
                bgNumber.border.color = Theme.highlightColor;
            }
        }

    }





    Column {
        id: column0
        width: parent.width
        anchors.top: cover.top
        anchors.left: cover.left
        anchors.leftMargin: Theme.paddingSmall* 2
        anchors.topMargin: Theme.paddingSmall


        Label {
            id: text
            text: qsTr("Wlan Keyboard")
            wrapMode: Text.Wrap
            font.bold: true


            font.pixelSize: Theme.fontSizeTiny
            color: Theme.highlightColor
            opacity: .8
        }


    }


    Column {
        id: column
        width: parent.width
        anchors.centerIn: parent

        Rectangle {
            color: "transparent"
            border.color: Theme.highlightColor
            anchors.horizontalCenter: parent.horizontalCenter
            width: statusLabel.width * 1.5
            height: statusLabel.height
            radius: 5

            Label {
                id: statusLabel
                wrapMode: Text.Wrap
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.highlightColor
            }
        }

    }

    CoverActionList {
        id: coverAction

        CoverAction {
            id: action
            iconSource: app.isServerRunning() ? "image://theme/icon-cover-pause": "image://theme/icon-cover-play"
            onTriggered: {
                if (!app.isServerRunning() && notifications.serverState !== notifications._SERVER_STATE_NO_CONNECTIVITY) {
                    console.log("Coveraction to start the server pressed")
                    app.startServers();
                }
                else if (app.isServerRunning() && notifications.serverState !== notifications._SERVER_STATE_NO_CONNECTIVITY) {
                    console.log("Coveraction to stop the server pressed")
                    app.stopServers();
                }

            }
        }
    }
}


