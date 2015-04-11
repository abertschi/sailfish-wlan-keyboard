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

            PageHeader { title: "Headless mode" }

            Label {
                text: "This mode automatically inserts incomming keystrokes into your currently focused widget."
                horizontalAlignment: Text.AlignHCenter
                width: parent.width
                wrapMode: Text.Wrap
            }

            SectionHeader {
                text: "Preview"
            }

            AnimatedImage {
                id: animation
                playing: true
                width: 300
                anchors.horizontalCenter: parent.horizontalCenter
                fillMode: Image.PreserveAspectFit
                source: "sample.gif"
            }


            SectionHeader {
                text: "Installation"
            }

            Label {
                text: "To use this mode, you need to install the <b> headless keyboard </b> layout."
                width: parent.width
                wrapMode: Text.Wrap
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }

            SectionHeader {
                text: "Download"
            }

            Button {
                text: "Download"
                anchors.horizontalCenter: parent.horizontalCenter

                onClicked: {
                    Qt.openUrlExternally("www.abertschi.ch");
                    console.log('open url')
                }
            }

            Label {
                text: "The keyboard layout is opensource software and hosted on <a href='https://github.com/abertschi/sailfish-headless-keyboard-layout'>Github </a>"
                width: parent.width
                wrapMode: Text.Wrap
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
}
