import QtQuick 2.1
import QtFeedback 5.0
import Sailfish.Silica 1.0

Column {

    width: parent.width
    anchors {
        left: parent.left
        verticalCenter: parent.verticalCenter
        top: parent.top
        topMargin: parent.width * 0.25
    }
    height: parent.height

    Label {
        text: qsTr("Ready to start")
        width: parent.width - 2 * Theme.paddingLarge
        wrapMode: Text.Wrap
        font.bold: true
        horizontalAlignment: Text.AlignHCenter
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: Theme.fontSizeExtraLarge
        color: Theme.highlightColor
    }

    Label {
        text: qsTr("Run the server and start typing.")
        width: parent.width - 2 * Theme.paddingLarge
        wrapMode: Text.Wrap
        horizontalAlignment: Text.AlignHCenter
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: Theme.fontSizeMedium
        color: Theme.highlightColor
    }
}



