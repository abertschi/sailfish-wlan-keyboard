import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components"


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
            spacing: Theme.paddingLarge * 1.2

            anchors {
                rightMargin: Theme.paddingLarge
                leftMargin: Theme.paddingLarge
                left: parent.left
                right: parent.right
            }

            PageHeader {
                id: header
                height: Theme.paddingLarge * 2
                title: qsTr("sailfish-wlan-keyboard")
            }

            Label {
                anchors {
                    right: parent.right
                    rightMargin: Theme.paddingLarge
                }
                color: Theme.highlightColor
                font {
                    pixelSize: Theme.fontSizeSmall
                    family: Theme.fontFamilyHeading
                }
                text: app.settings.version;
            }

            Item {
                width: parent.width
                height: image.height + imageDesc.height

                AboutImage {
                    id: image
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Label {
                    id: imageDesc
                    anchors.top: image.bottom
                    anchors.topMargin: - Theme.paddingLarge
                    width: parent.width
                    horizontalAlignment: Text.AlignHCenter
                    color: Theme.highlightColor
                    //text: qsTr("<i>Typing just easier </i>")
                    wrapMode: Text.Wrap
                }
            }

            Label {
                width: parent.width
                text: qsTr("The <b>sailfish-wlan-keyboard</b> provides an easy way to use you your computer keyboard to type on your phone.")
                wrapMode: Text.Wrap
            }

            SectionHeader {
                text: "Privacy"
                font.bold: true
                height: Theme.paddingMedium
            }


            Label {
                id: l
                width: parent.width
                text: qsTr("Your personal information belongs to you. This is Free and OpenSource Software that respects your privacy. Dig into the code on <a href='https://github.com/abertschi/sailfish-wlan-keyboard'>Github </a>.")
                wrapMode: Text.Wrap
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        remorse.execute("Browsing Source", function() { Qt.openUrlExternally("https://github.com/abertschi/sailfish-wlan-keyboard"); } )
                    }
                }
            }

            SectionHeader {
                text: "Feedback"
                font.bold: true
                height: Theme.paddingMedium
            }


            Label {
                width: parent.width
                text: qsTr("Do you have any suggestion, found a bug or just want to tell me something? File an issue on Github or just write me an email at <i>sailfish@abertschi.ch</i>")
                wrapMode: Text.Wrap
            }

            SectionHeader {
                text: "Donation"
                font.bold: true
                height: Theme.paddingMedium
            }

            Label {
                width: parent.width
                text: qsTr("This application is powered by your donation. If you like my app, buy me a coffee. <b> Thank you! </b>")
                wrapMode: Text.Wrap
            }

            Button {
                text: "Donate"
                anchors.horizontalCenter: parent.horizontalCenter

                onClicked: {

                    console.log('open url')
                }
            }

            SectionHeader {
                text: "Autor"
                font.bold: true
                height: Theme.paddingMedium
            }

            Label {
                width: parent.width
                //horizontalAlignment: Text.AlignHCenter
                text: "Andrin Bertschi<br/>www.abertschi.ch <br/>Twitter: <i>@andrinbertschi</i>"
                wrapMode: Text.Wrap
                fontSizeMode: Theme.fontSizeSmall
            }
        }
    }
}


