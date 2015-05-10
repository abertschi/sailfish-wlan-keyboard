import QtQuick 2.1
import Sailfish.Silica 1.0

Page {
    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height + 2 * Theme.paddingLarge

        VerticalScrollDecorator {}

        Column {
            id: column
            width: parent.width
            spacing: Theme.paddingLarge * 2

            anchors {
                rightMargin: Theme.paddingLarge
                leftMargin: Theme.paddingLarge
                left: parent.left
                right: parent.right
            }

            PageHeader { title: qsTr("Clipboard Mode") }

            Label {
                width: parent.width
                text: qsTr("This mode copies all incomming keystrokes to your clipboard. You need to paste them into a focused widget.")
                wrapMode: Text.Wrap
            }

            SectionHeader {
                text: qsTr("Preview")
                font.bold: true
            }

            AnimatedImage {
                id: animation
                asynchronous: true
                playing: true
                 width: parent.width - 2 * Theme.paddingLarge
                anchors.horizontalCenter: parent.horizontalCenter
                fillMode: Image.PreserveAspectFit
                source: "img/clipboard.gif"
            }
        }
    }
}
