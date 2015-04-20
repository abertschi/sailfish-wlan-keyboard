import QtQuick 2.0
import Sailfish.Silica 1.0

//deprecated
Page {
    id: home
    SilicaFlickable {
        id: flickable
        anchors.fill: parent
        contentWidth: parent.width

        VerticalScrollDecorator {}

        PageHeader {
            title: qsTr("Configuration");
            id: pageHeader
        }

        IconTextSwitch {
            id: serverStatusSwitch
            property bool isFirstLoad: false
            text: qsTr("Start server");
            description: tr("Server is not running")

            anchors.top: pageHeader.bottom;
            anchors.topMargin: Theme.paddingLarge
            checked: isServerRunning()

            icon.source: {
                if (! isFirstLoad) {
                    functions.updateServerStatus(checked);
                    isFirstLoad = true;
                }
            }

            icon.opacity: 0.4
            icon.width: 40
            icon.height: 40

            onCheckedChanged: {
                busy = true
                busyTimer.start();

                if (checked) {
                    startServers();
                }
                else {
                    stopServers();
                }
            }

            Timer {
                id: busyTimer
                interval: 2000
                onTriggered: parent.busy = false
                onRunningChanged: {
                    if (!running)
                        functions.updateServerStatus(parent.checked);
                }
            }
        }
        Separator {
            id: seperator
            anchors {
                right: parent.right
                rightMargin: Theme.paddingLarge
                left: parent.left
                leftMargin: Theme.paddingLarge
                topMargin: Theme.paddingLarge
                top: serverStatusSwitch.bottom
            }
            width:parent.width;
            color: Theme.highlightColor

        }
        IconButton {

            Column {
                id: addressColumn
                anchors {
                    right: parent.right
                    rightMargin: Theme.paddingLarge
                    left: parent.left
                    leftMargin: Theme.paddingLarge
                    topMargin: Theme.paddingLarge
                    top: seperator.bottom
                }

                Label {
                    id: title
                    text: qsTr("Address");
                    truncationMode: TruncationMode.Fade
                    wrapMode: Text.Wrap
                    color: Theme.primaryColor
                }
                Label {
                    id: ipAddressLabel
                    text: "-"
                    truncationMode: TruncationMode.Fade
                    font.pixelSize: Theme.fontSizeExtraSmall
                    color: Theme.secondaryColor
                }
            }

            Column {
                anchors {
                    right: parent.right
                    rightMargin: Theme.paddingLarge
                    left: parent.left
                    leftMargin: Theme.paddingLarge
                    topMargin: Theme.paddingLarge * 2
                    top: addressColumn.bottom
                }
                width: parent.width

                Label {
                    id: connHint
                    width: parent.width
                    text: qsTr("Connect your phone to a WLAN network.")
                    font.pixelSize: Theme.fontSizeExtraSmall
                    color: Theme.secondaryColor
                    wrapMode: Text.Wrap
                }
            }
        }



        // ---------------------------------------------------------
        // functions
        // ---------------------------------------------------------

        Item {
            id: functions
            function updateServerStatus(isRunning) {

                if (isRunning) {
                    var notifyMsg = qsTr("Browse") + " " + httpServer.getFullAddress();
                    loadPopup.notify(notifyMsg);
                    serverStatusSwitch.icon.source = "image://theme/icon-cover-play";
                    serverStatusSwitch.description = qsTr("Server is running");
                    ipAddressLabel.text = httpServer.getFullAddress();
                }
                else {
                    serverStatusSwitch.icon.source = "image://theme/icon-cover-pause";
                    serverStatusSwitch.description = qsTr("Server is not running");
                    ipAddressLabel.text = "-";
                }
            }
        }
    }
}
