import QtQuick 2.1
import QtFeedback 5.0
import Sailfish.Silica 1.0


Column {
    id: runtimeAddresses
    width: parent.width
    anchors.top: parent.top
    anchors.topMargin: parent.width * 0.25
    anchors {
        left: parent.left
        verticalCenter: parent.verticalCenter

    }
    spacing:10

    Column {
        //anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        width: parent.width
        spacing: 7

        Connections {
            target: httpServer
            onRunningChanged: {
                repeater.model = httpServer.getFullAddresses()
            }
        }

        Repeater {
            id: repeater
            model: httpServer.getFullAddresses()
            Rectangle {
                color: Theme.highlightBackgroundColor
                anchors.horizontalCenter: parent.horizontalCenter
                height: Theme.itemSizeSmall
                width: parent.width
                Label {
                    text: modelData
                    anchors.centerIn: parent
                    font.bold: true
                }
            }
        }
    }

    Text {
        text: "Open the above site in your browser"
        color: Theme.secondaryColor
        font.pixelSize: Theme.fontSizeExtraSmall
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
