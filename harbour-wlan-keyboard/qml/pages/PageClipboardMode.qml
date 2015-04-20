import QtQuick 2.1
import QtFeedback 5.0
import Sailfish.Silica 1.0

Page {
    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height + 2 * Theme.paddingLarge

        VerticalScrollDecorator {}

        Column {
            id: column
            width: parent.width
            spacing: Theme.paddingLarge

            anchors {
                rightMargin: Theme.paddingLarge
                leftMargin: Theme.paddingLarge
                left: parent.left
                right: parent.right
            }

            PageHeader { title: "Clipboard Mode" }

            Label {
                width: parent.width
                text: "This mode copies all incomming keystrokes to your clipboard. Copy paste them in a focused input widget."
                wrapMode: Text.Wrap
                //horizontalAlignment: Text.AlignHCenter
            }

            AnimatedImage {
                id: animation
                playing: true
                width: 300
                anchors.horizontalCenter: parent.horizontalCenter
                fillMode: Image.PreserveAspectFit
                source: "sample.gif"
            }
        }
    }
}
