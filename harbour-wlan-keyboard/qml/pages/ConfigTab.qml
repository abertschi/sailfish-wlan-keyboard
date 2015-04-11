import QtQuick 2.1
import Sailfish.Silica 1.0

Item {
    height: tabs.height
    width: tabs.width

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height + 2 * Theme.paddingLarge

        VerticalScrollDecorator {}

        Column {
            width: tabs.width
            anchors {
                left: parent.left
                topMargin: 50
                top: parent.top
            }

            ComboBox {
                label: "Interface"
                description: "Option <i>Any</i> &nbsp; exposes to WLAN and USB"
                focus: true
                width: parent.width
                currentIndex: settings.useAnyConnection ? 0 : settings.connectionIndex
                anchors.left: parent.left
                menu: ContextMenu {
                    MenuItem {
                        text: "Any"
                    }
                    Repeater {
                        id: interfaceRepeater
                        model: utils.getAllIpAddresses()
                        MenuItem {
                            id: item;
                            text: modelData
                        }
                    }
                    onActivated: {
                        if (index == 0) {
                            // expose on any if
                            settings.useAnyConnection = true
                        }
                        else {
                            var selection = interfaceRepeater.itemAt(index - 1).text;
                            console.debug(selection + " selected");
                            settings.useAnyConnection = false
                            settings.connectionIndex = index -1
                        }
                    }
                }
            }

            Row {
                id: row
                anchors {
                    leftMargin: Theme.paddingLarge
                    rightMargin: Theme.paddingLarge
                    left: parent.left
                    right: parent.right
                }
                height: portTextInput.height

                Label {
                    id: portLabel
                    text: "Port"
                    anchors.top: parent.top
                }

                Label {
                    id: portSpacer
                    width: Theme.paddingMedium
                }

                TextInput {
                    id: portTextInput
                    width: parent.width - portSpacer.width - portLabel.width
                    inputMethodHints: Qt.ImhDialableCharactersOnly
                    anchors.top: parent.top
                    text:  settings.httpPort
                    color: Theme.highlightColor
                    horizontalAlignment: TextInput.AlignTop
                    EnterKey.onClicked: {
                        settings.httpPort = parseInt(portTextInput.text)
                        settings.wsPort = parseInt(portTextInput.text) +5
                        parent.focus = true
                    }
                    validator: RegExpValidator { regExp: /^[0-9]{4}$/ }
                }
            }

            Label {
                text: "Port to listen for keystrokes"
                anchors {
                    rightMargin: Theme.paddingLarge
                    leftMargin: Theme.paddingLarge
                    left: parent.left
                    right: parent.right
                }
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

            /* 15-04-12: not yet implemented
        TextSwitch {
            id: httpsSwitch
            text: "Use HTTPS"
            checked: settings.useHttps
            onCheckedChanged: {
                settings.useHttps = checked
            }
        }
        */

            ComboBox {
                id: keyboardMode
                width: parent.width
                label: "Keyboard mode"
                currentIndex: settings.keyboardMode == settings._KEYBOARD_MODE_CLIPBOARD ? 0 : 1
                anchors.left: parent.left
                description: "Mode to process incomming keystrokes"
                menu: ContextMenu {
                    MenuItem { text: "Clipboard" }
                    MenuItem { text: "Headless" }
                }

                onCurrentIndexChanged: {
                    if(currentIndex == 0) {
                        settings.keyboardMode = settings._KEYBOARD_MODE_CLIPBOARD
                        pageStack.push(Qt.resolvedUrl("ClipboardModePage.qml"))

                    }
                    else {
                        settings.keyboardMode = settings._KEYBOARD_MODE_ALT_KEYBOARD
                        pageStack.push(Qt.resolvedUrl("HeadlessModePage.qml"))
                    }
                }
            }
        }
    }
}
