import QtQuick 2.1
import Sailfish.Silica 1.0

Page {
    id: page
    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height + 2 * Theme.paddingLarge

        VerticalScrollDecorator {}

        RemorsePopup { id: remorse }

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
                text: qsTr("This mode automatically inserts incoming keystrokes into your currently focused widget.")
                width: parent.width
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
                source: "img/headless.gif"
            }

            SectionHeader {
                text: qsTr("Configuration")
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
                text: "Option <b>Continuous</b> delegates incoming keystrokes to the focused widget. The text appears instantly."
                width: parent.width
                wrapMode: Text.Wrap
                font.pixelSize: Theme.fontSizeTiny
            }

            Label {
                text: "Option <b>Return key based</b> caches incoming keystrokes until return is hit before the text appears."
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
                text: qsTr("To use this mode, you need to install the <b> headless keyboard </b> extension.")
                width: parent.width
                wrapMode: Text.Wrap
                //horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Label {
                text: qsTr("The headless keyboard extension is completely Free and Open Source Software. Due to harbor policies, it needs to be distributed in an alternative store. Therefore, you install it on your own risk.")
                width: parent.width
                wrapMode: Text.Wrap
                //horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }

            SectionHeader {
                text: qsTr("Download")
                font.bold: true
                //height: Theme.paddingMedium
            }

            Label {
                text: qsTr("Download the keyboard with the Button below or take a look at the <a href='https://github.com/abertschi/sailfish-headless-keyboard-layout'>source code</a>.")
                width: parent.width
                wrapMode: Text.Wrap
                //horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter

                MouseArea {
                    anchors.fill: parent
                    onClicked: remorse.execute(qsTr("Browsing Source Code "), function() { Qt.openUrlExternally("https://github.com/abertschi/sailfish-headless-keyboard-layout"); } )
                }
            }

            Button {
                text: qsTr("Download")
                anchors.horizontalCenter: parent.horizontalCenter

                onClicked: {
                    remorse.execute(qsTr("Browsing Download Page "), function() { Qt.openUrlExternally("https://openrepos.net/content/abertschi/headless-keyboard"); } )
                }
            }

        }
    }
}
