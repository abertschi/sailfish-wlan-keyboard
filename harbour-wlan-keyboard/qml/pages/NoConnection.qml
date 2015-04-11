import QtQuick 2.1
import QtFeedback 5.0
import Sailfish.Silica 1.0

Column {
    width: parent.width
    anchors {
        left: parent.left
        verticalCenter: parent.verticalCenter
    }

    Label {
        text: "Connect your phone to USB or any WLAN network and start the server"
        width: parent.width - 2 * Theme.paddingLarge
        wrapMode: Text.Wrap
        horizontalAlignment: Text.AlignHCenter
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: Theme.fontSizeMedium
        color: Theme.highlightColor
        anchors.verticalCenter: parent.verticalCenter
    }
}



