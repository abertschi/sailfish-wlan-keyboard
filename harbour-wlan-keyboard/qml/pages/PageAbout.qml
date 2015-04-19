import QtQuick 2.0
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
                text: "v.1.1"
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
                width: parent.width
                //horizontalAlignment: Text.AlignHCenter
                text: qsTr("Your personal information belongs to you. This is Free and OpenSource Software that respects your privacy. Dig into the code on <a href='https://github.com/abertschi/sailfish-headless-keyboard-layout'>Github </a>.")
                wrapMode: Text.Wrap
            }

            SectionHeader {
                text: "Feedback"
                font.bold: true
                height: Theme.paddingMedium
            }

            Label {
                width: parent.width
                text: qsTr("Do you have any suggestion or just want to tell me something? File an issue on Github or just write me an email at <i>sailfish@abertschi.ch</i>")
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
                    Qt.openUrlExternally("http://www.abertschi.ch");
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
                horizontalAlignment: Text.AlignHCenter
                text: qsTr("Andrin Bertschi<br/> www.abertschi.ch")
                wrapMode: Text.Wrap
            }
        }
    }
}


