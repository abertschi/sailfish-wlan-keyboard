import QtQuick 2.0
import Sailfish.Silica 1.0

PopupBase {

    background.color: "#DB4D4D" //Theme.secondaryHighlightColor
    background.opacity: 0.7
    textLabel.color: "white"
    textLabel.font.bold: true

    Component.onCompleted: {
    }

    Label {
        text: "!"
        font.bold: true
        font.pixelSize: Theme.fontSizeHuge
        anchors.leftMargin: Theme.paddingLarge * 2
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
    }

}
