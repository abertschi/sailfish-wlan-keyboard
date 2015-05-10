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
            id: column
            width: tabs.width
            anchors {
                left: parent.left
                topMargin: 50
                top: parent.top
            }

            Connections {
                target: notifications
                onStateReload: {
                    if (notifications.connectivityAvailable) {
                        interfaceRepeater.model = utils.getAvailableEndpointsAsQVariant()
                        anyContextMenu.text = "Any"
                    }
                    else {
                        interfaceRepeater.model = undefined
                        anyContextMenu.text = "-"
                    }
                }
            }

            ComboBox {
                id: interfaceComboBox
                label: qsTr("Interface")
                description: qsTr("Option <i>Any</i> &nbsp; exposes to WLAN and USB")
                focus: true
                width: parent.width
                currentIndex: settings.connectionInterfaceIndex
                anchors.left: parent.left

                menu: ContextMenu {
                    MenuItem {
                        id: anyContextMenu
                        text: qsTr("Any")
                    }
                    Repeater {
                        id: interfaceRepeater
                        model: utils.getAvailableEndpointsAsQVariant()
                        MenuItem {
                            property string iName: modelData.interfaceName()
                            id: item
                            text: modelData.interfaceName() + ' (' + modelData.ipAddress() + ')'
                        }
                    }
                    onActivated: {
                        if (index == 0) {
                            // expose on any if
                            settings.useAnyConnection = true
                        }
                        else {
                            var item = interfaceRepeater.itemAt(index - 1);
                            console.debug(item.text + " selected");
                            settings.useAnyConnection = false
                            settings.connectionInterface = item.iName
                        }
                        settings.connectionInterfaceIndex = index
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
                    text: qsTr("Port")
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
                        if (portTextInput.text.length != 4) {
                            popupError.show(qsTr("Port requires 4 digits"))
                            console.log("Port is invalid")
                            color: "red"
                        }
                        else {
                            settings.httpPort = parseInt(portTextInput.text)
                            settings.wsPort = parseInt(portTextInput.text) +5
                            parent.focus = true
                        }
                    }
                    validator: RegExpValidator {
                        id: portValidator
                        regExp: /^[0-9]{4}$/
                    }
                }
            }

            Label {
                text: qsTr("Port to listen for keystrokes")
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
                text: qsTr("Start on launch")
                description: qsTr("Start server on app launch")
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
                label: qsTr("Keyboard mode")
                currentIndex: settings.keyboardMode === settings._KEYBOARD_MODE_CLIPBOARD ? 0 : 1
                anchors.left: parent.left
                description: qsTr("Mode to process incomming keystrokes")
                menu: ContextMenu {
                    MenuItem { text: qsTr("Clipboard") }
                    MenuItem { text: qsTr("Headless") }
                }

                onCurrentIndexChanged: {
                    if(currentIndex == 0) {
                        console.log("Setting keyboardMode to Clipboard")

                        settings.keyboardMode = settings._KEYBOARD_MODE_CLIPBOARD
                        app.openPageClipboardMode()
                    }
                    else {
                        console.log("Setting keyboardMode to Headless")

                        settings.keyboardMode = settings._KEYBOARD_MODE_HEADLESS
                        app.openPageHeadlessMode()
                    }
                }
            }
        }
    }
}
