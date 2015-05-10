import QtQuick 2.1
import Sailfish.Silica 1.0

Column {
    width: parent.width
    anchors {
        left: parent.left
        verticalCenter: parent.verticalCenter
        top: parent.top
        topMargin: parent.width * 0.25
    }

    Label {
        text: qsTr("Sorry, no connectivity")
        width: parent.width - 2 * Theme.paddingLarge
        wrapMode: Text.Wrap
        font.bold: true
        horizontalAlignment: Text.AlignHCenter
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: Theme.fontSizeExtraLarge
        color: Theme.highlightColor
    }

    Label {
        text: qsTr("Find a WIFI connection or use USB.")
        width: parent.width - 2 * Theme.paddingLarge
        wrapMode: Text.Wrap
        horizontalAlignment: Text.AlignHCenter
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: Theme.fontSizeMedium
        color: Theme.highlightColor
    }
}



