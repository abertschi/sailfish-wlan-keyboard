import QtQuick 2.1
import QtFeedback 5.0
import Sailfish.Silica 1.0

Item {
    height: tabs.height
    width: tabs.width

    Label {
        text: "Connect your phone to USB or any WLAN network."
        width: parent.width
        wrapMode: Text.Wrap
        horizontalAlignment: Text.AlignHCenter

        font.pixelSize: Theme.fontSizeLarge
        color: Theme.highlightColor
        //anchors.top: parent.top
        anchors.verticalCenter: parent.verticalCenter
    }
}

