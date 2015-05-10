import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.wlan.keyboard 1.0
import "../components"


Page {
    id: page

    property string paypalDonate: "https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=M7MC5SBL972KG";
    property string twitterUrl: "https://twitter.com/andrinbertschi";
    property string githubUrl: "https://github.com/abertschi/sailfish-wlan-keyboard";
    property string appVersion: AppInfo.version

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
                text: appVersion;
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
                text: qsTr("Privacy")
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
                        remorse.execute(qsTr("Browsing Source"), function() { Qt.openUrlExternally(githubUrl); } )
                    }
                }
            }

            SectionHeader {
                text: qsTr("Feedback")
                font.bold: true
                height: Theme.paddingMedium
            }


            Label {
                width: parent.width
                text: qsTr("Do you have any suggestion, found a bug or just want to tell me something? File an issue on Github or just write me an email at <i>sailfish@abertschi.ch</i>")
                wrapMode: Text.Wrap
            }

            SectionHeader {
                text: qsTr("Donation")
                font.bold: true
                height: Theme.paddingMedium
            }

            Label {
                width: parent.width
                text: qsTr("This application is powered by your donation. If you like my app, buy me a coffee. <b> Thank you! </b>")
                wrapMode: Text.Wrap
            }

            Button {
                text: qsTr("Donate")
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    remorse.execute(qsTr("Browsing PayPal"), function() { Qt.openUrlExternally(paypalDonate); } )
                }
            }

            SectionHeader {
                text: qsTr("Autor")
                font.bold: true
                height: Theme.paddingMedium
            }

            Label {
                width: parent.width
                text: "Andrin Bertschi<br/> Twitter: <i>@andrinbertschi</i>"
                wrapMode: Text.Wrap
                fontSizeMode: Theme.fontSizeSmall
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                          remorse.execute(qsTr("Browsing Twitter"), function() { Qt.openUrlExternally(twitterUrl); } )
                    }
                }
            }
        }
    }
}


