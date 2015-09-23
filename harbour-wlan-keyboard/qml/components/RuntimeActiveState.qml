import QtQuick 2.1
import Sailfish.Silica 1.0


Column {
    id: runtimeAddresses
    width: parent.width
    anchors.top: parent.top
    anchors.topMargin: parent.width * 0.25
    anchors {
        left: parent.left
    }
    spacing:10

    Column {
        id: column
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
                anchors.horizontalCenter: column.horizontalCenter
                height: Theme.itemSizeSmall
                width: parent.width
                Label {
                    text: modelData
                    anchors.centerIn: parent
                    font.bold: true
                }
            }
        }

        Text {
            text: qsTr("Open the above site in your browser")
            color: Theme.secondaryColor
            font.pixelSize: Theme.fontSizeExtraSmall
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
        }
    }
}
