import QtQuick 2.1
import QtFeedback 5.0
import Sailfish.Silica 1.0

Column {
    width: parent.width
    anchors {
        left: parent.left
        verticalCenter: parent.verticalCenter

    }
    Rectangle {
        color: Theme.highlightBackgroundColor
        anchors.horizontalCenter: parent.horizontalCenter
        height: Theme.itemSizeSmall
        width: page.width
        Label {
            text: "http://192.168.221.111:7777"
            anchors.centerIn: parent
        }
    }

    Text {
        text: "Open the above site in your browser"
        color: Theme.secondaryColor
        font.pixelSize: Theme.fontSizeExtraSmall
        anchors.horizontalCenter: parent.horizontalCenter
    }

}
