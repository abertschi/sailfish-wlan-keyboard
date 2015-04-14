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
        text: "<b>Sorry</b>, no connection available"
        width: parent.width - 2 * Theme.paddingLarge
        wrapMode: Text.Wrap
        horizontalAlignment: Text.AlignHCenter
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: Theme.fontSizeLarge
        color: Theme.highlightColor
        anchors.verticalCenter: parent.verticalCenter
    }
}



