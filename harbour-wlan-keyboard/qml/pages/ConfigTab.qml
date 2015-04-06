import QtQuick 2.1
import QtFeedback 5.0
import Sailfish.Silica 1.0
//import "../Settings.js" as Settings

Item {
    height: tabs.height
    width: tabs.width

    Column {
        width: tabs.width
        anchors {
            left: parent.left
            topMargin: 50
            top: parent.top
        }

        ComboBox {
            focus: true
            id: me
            width: parent.width
            label: "Interface"
            currentIndex: {
                if (settings.useAnyConnection)
                    return 0;

                return settings.connectionIndex
            }

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
                        settings.useAnyConnection = true
                    }
                    else {
                        var selection = ifRepeat.itemAt(index - 1).text;
                        console.debug(selection + " selected");
                        settings.useAnyConnection = false
                        settings.connectionIndex = index -1
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
                text:  settings.httpPort
                color: Theme.highlightColor
                horizontalAlignment: TextInput.AlignTop

                EnterKey.onClicked: {
                    var httpPort = parseInt(tf.text)
                    var wsPort = parseInt(tf.text) +5
                    settings.httpPort = httpPort
                    settings.wsPort = wsPort
                    parent.focus = true
                    popup.notify("Restart server to apply changes");
                }

                validator: RegExpValidator { regExp: /^[0-9]{4}$/ }
            }
        }

        Label {
            anchors {
                rightMargin: Theme.paddingLarge
                leftMargin: Theme.paddingLarge
                left: parent.left
                right: parent.right
            }
            text: "Port to listen for keystrokes"
            font.pixelSize: Theme.fontSizeExtraSmall
            color: Theme.secondaryColor
        }

        TextSwitch {
            text: "Start on launch"
            description: "Start server on app launch"
            checked: settings.autostart
            onCheckedChanged: {
                settings.autostart = checked
            }
        }

        TextSwitch {
            id: httpsSwitch
            text: "Use HTTPS"
            checked: settings.useHttps
            onCheckedChanged: {
                settings.useHttps = checked
            }
        }

        ComboBox {
            id: keyboardMode
            width: parent.width
            label: "Keyboard mode"
            currentIndex: settings.keyboardMode == settings._KEYBOARD_MODE_CLIPBOARD ? 0 : 1
            anchors.left: parent.left
            menu: ContextMenu {
                MenuItem { text: "Clipboard" }
                MenuItem { text: "Keyboard layout" }
            }
            onPressed: {
                if(currentIndex == 0)
                    settings.keyboardMode = settings._KEYBOARD_MODE_CLIPBOARD
                else
                    settings.keyboardMode = settings._KEYBOARD_MODE_ALT_KEYBOARD
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
