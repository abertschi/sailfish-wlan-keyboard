import QtQuick 2.1
import QtFeedback 5.0
import Sailfish.Silica 1.0
import "../Settings.js" as Settings

Item {
    height: tabs.height
    width: tabs.width

    Column {
        width: tabs.width
        anchors {
            left: parent.left
            //leftMargin: Theme.paddingLarge * 2
            topMargin: 50
            top: parent.top
        }

        ComboBox {
            focus: true
            id: me
            width: parent.width
            label: "Interface"
            currentIndex: 0
            anchors.left: parent.left
            description: "Option <i>Any</i> &nbsp; exposes to WLAN and USB"

            menu: ContextMenu {
                MenuItem {
                    id: anyIf
                    text: "Any"
                }

                Repeater {
                    id: ifRepeat
                    model: utils.getAllIpAddresses()
                    MenuItem {
                        id: item; text: modelData
                    }
                }
                onActivated: {
                    if (index == 0) {
                        // expose on any if
                        Settings.setUseAnyConnection(true);
                    }
                    else {
                        var selection = ifRepeat.itemAt(index - 1).text;
                        console.debug(selection + " selected");
                        Settings.setUseAnyConnection(false);
                        Settings.setPreferedIp(selection);
                    }
                    popup.notify("Restart server to apply changes");
                }
            }
        }


        Row {
            id: row
            anchors.leftMargin: Theme.paddingLarge
            anchors.rightMargin: Theme.paddingLarge
            anchors.left: parent.left
            anchors.right: parent.right
            height: tf.height
            Label {

                id: portLabel
                text: "Port"
                anchors.top: parent.top
            }

            Label {
                id: spacer
                width: Theme.paddingMedium

            }

            TextInput {
                id: tf
                width: parent.width - spacer.width - portLabel.width
                inputMethodHints: Qt.ImhDialableCharactersOnly

                anchors.top: parent.top
                text:  parseInt(Settings.getHttpPort())
                color: Theme.highlightColor
                horizontalAlignment: TextInput.AlignTop

                EnterKey.onClicked: {
                    var httpPort = parseInt(tf.text)
                    var wsPort = parseInt(tf.text + 1)
                    Settings.setHttpPort(httpPort);
                    Settings.setWsPort(wsPort);
                    parent.focus = true
                    popup.notify("Restart server to apply changes");
                }

                validator: RegExpValidator { regExp: /^[0-9]{4}$/ }
            }
        }

        Label {

            anchors.leftMargin: Theme.paddingLarge
            anchors.rightMargin: Theme.paddingLarge
            anchors.left: parent.left
            anchors.right: parent.right
            text: "Port to listen for keystrokes"
            font.pixelSize: Theme.fontSizeExtraSmall
            color: Theme.secondaryColor
        }

        TextSwitch {
            text: "Start on launch"
            description: "Start server on app launch"
            checked: false

            onClicked: {
                Settings.setAutostart(!checked)
            }

            Component.onCompleted: checked = Settings.isAutostart()

        }


        TextSwitch {
            text: "Use HTTPS"
            checked: false
            onClicked: {
              Settings.setHttps(!checked)
            }

            Component.onCompleted: checked = Settings.isHttps()
        }


        ComboBox {
            id: keyboardMode
            width: parent.width
            label: "Keyboard mode"
            currentIndex: Settings.isKeyboardModeClipboard() ? 0 : 1
            anchors.left: parent.left

            menu: ContextMenu {
                MenuItem { text: "Clipboard" }
                MenuItem { text: "Keyboard layout" }
            }

            onClicked: {
                currentIndex == 0 ? Settings.setKeyboardMode(Settings.KeyboardMode.CLIPBOARD) :
                                    Settings.setKeyboardMode(Settings.KeyboardMode.ALT_KEYBOARD);
            }
        }

        Label {
            id: desc
            width: parent.width
            text: "Mode how new keystrokes are processed"
            anchors.left: parent.left
            anchors.leftMargin: Theme.paddingLarge
            opacity: 1
            wrapMode: Text.Wrap
            font.pixelSize: Theme.fontSizeExtraSmall
            color: Theme.secondaryColor
        }

    }
}
