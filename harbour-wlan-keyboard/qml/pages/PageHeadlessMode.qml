import QtQuick 2.1
import QtFeedback 5.0
import Sailfish.Silica 1.0

Page {
    id: page
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
                width: parent.width
                wrapMode: Text.Wrap
            }

            SectionHeader {
                text: "Preview"
                font.bold: true
            }

            AnimatedImage {
                id: animation
                asynchronous: true
                playing: true
                width: parent.width - 2 * Theme.paddingLarge
                anchors.horizontalCenter: parent.horizontalCenter
                fillMode: Image.PreserveAspectFit
                source: "img/headless.gif"
            }

            SectionHeader {
                text: "Configuration"
                font.bold: true
                //height: Theme.paddingMedium
            }

            /*
            ComboBox {
                id: submodeComboBox
                width: page.width
                label: "Headless mode"
                anchors.left: parent.left
                anchors.leftMargin: 0
                menu: ContextMenu {
                    MenuItem { text: "Continuous" }
                    MenuItem { text: "Return key based" }
                }
            }

            Label {
                text: "Option <b>Continuous</b> delegates incomming keystrokes to the focused widget. The text appears instantly."
                width: parent.width
                wrapMode: Text.Wrap
                font.pixelSize: Theme.fontSizeTiny
            }

            Label {
                text: "Option <b>Return key based</b> caches incomming keystrokes until return is hit before the text appears."
                width: parent.width
                wrapMode: Text.Wrap
                font.pixelSize: Theme.fontSizeTiny
            }


            SectionHeader {
                text: "Installation"
                font.bold: true
                //height: Theme.paddingMedium
            } */

            Label {
                text: "To use this mode, you need to install the <b> headless keyboard </b> layout."
                width: parent.width
                wrapMode: Text.Wrap
                //horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Label {
                text: "The headless keyboard layout is completely Free and Opensource Software. However, alternative keyboard layouts are not yet supported in the official Harbor store. Therefore, you install it on your own risk."
                width: parent.width
                wrapMode: Text.Wrap
                //horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }

            SectionHeader {
                text: "Download"
                font.bold: true
                //height: Theme.paddingMedium
            }

            Label {
                text: "Download the keyboard with the Button below or take a look at the <a href='https://github.com/abertschi/sailfish-headless-keyboard-layout'>source code</a>."
                width: parent.width
                wrapMode: Text.Wrap
                //horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Button {
                text: "Download"
                anchors.horizontalCenter: parent.horizontalCenter

                onClicked: {
                    Qt.openUrlExternally("www.abertschi.ch");
                    console.log('open url')
                }
            }
        }
    }
}
