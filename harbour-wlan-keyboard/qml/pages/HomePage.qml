/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: home
    SilicaFlickable {
        id: flickable
        anchors.fill: parent
        contentWidth: parent.width
        contentHeight: column.height + Theme.paddingLarge

        VerticalScrollDecorator {}

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            id: column
            width: home.width
            spacing: Theme.paddingLarge

            PageHeader {
                title: " Configuration"
            }




/*
            SectionHeader {
                horizontalAlignment: Text.AlignRight
                text: "Configuration"
            }

*/
            Component.onCompleted: {
                optionItemRepeater.append("Server", "192.168.1.80:8000", "");
                optionItemRepeater.append("Connected clients", "0", "");
            }


            IconTextSwitch {
                id: serverStartTrigger
                property bool isSourceInitialSet: false
                text: "Start server"
                description: "Server is not running"

                anchors.topMargin: Theme.paddingLarge *2
                anchors.bottomMargin: Theme.paddingLarge *2
                checked: isAnyServerRunning()
                icon.source: {
                    if (! isSourceInitialSet) {
                        isSourceInitialSet = true;
                        return checked ? "image://theme/icon-cover-play" : "image://theme/icon-cover-pause";
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

                Connections {
                    target: httpServer
                    onRunningChanged: {
                        serverStartTrigger.description = isRunning ? "Server is running" : "Server is not running";
                    }
                }

                Timer {
                    id: busyTimer
                    interval: 3000
                    onTriggered: parent.busy = false
                    onRunningChanged: {
                        if (!running)
                             parent.icon.source = (parent.checked ? "image://theme/icon-cover-play" : "image://theme/icon-cover-pause");
                    }
                }
            }

            Separator {
                anchors {
                    right: parent.right
                    rightMargin: Theme.paddingLarge
                    left: parent.left
                    leftMargin: Theme.paddingLarge
                    topMargin: Theme.paddingLarge
                }
                id: separator
                width:parent.width;
                color: Theme.highlightColor

            }

            /*
            TextSwitch {
                 text: "Auto copy to clipboard"
                 description: "Copy keystrokes automatic to clipboard"
                    onCheckedChanged: {

                }
            }

            SectionHeader {
                horizontalAlignment: Text.AlignRight
                text: "Configuration"
            }
*/
            Column {

                anchors {

                    right: parent.right
                    rightMargin: Theme.paddingLarge
                    left: parent.left
                    leftMargin: Theme.paddingLarge
                    topMargin: 300
                 }

                Label {
                       id: title
                       text: "Address"
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

                Connections {
                    target: httpServer
                    onRunningChanged: {
                        ipAddressLabel.text = isRunning ? httpServer.getFullAddress() : "-";
                    }
                }
            }


            Column {

                width: parent.width
                spacing: Theme.paddingLarge

                anchors {
                    //right: parent.right
                    //rightMargin: Theme.paddingLarge
                    //left: parent.left
                    //leftMargin: Theme.paddingLarge
                }


}


/*
            Column {

                anchors {
                    //right: parent.right
                    //rightMargin: Theme.paddingLarge
                    left: parent.left
                    leftMargin: Theme.paddingLarge
                }

                width: parent ? parent.width : Screen.width
                //implicitHeight: desc.y + desc.height

                Label {
                    id: label
                    width: parent.width
                    text: "Server"
                    anchors {

                        // center on the first line if there are multiple lines

                    }
                    wrapMode: Text.Wrap
                    color: Theme.primaryColor
                }
                Label {
                    id: desc
                    width: label.width
                    //height: text.length ? (implicitHeight + Theme.paddingMedium) : 0
                     text: "192.168.1.1:8000"
                    anchors.top: label.bottom
                    anchors.left: label.left
                    wrapMode: Text.Wrap
                    font.pixelSize: Theme.fontSizeExtraSmall
                    color: Theme.secondaryColor
                }
            }

*/

            SectionHeader {
                horizontalAlignment: Text.AlignRight
                text: "Keystrokes"
            }




            TextArea {
               /* MouseArea {
                    width: parent.width
                    height: parent.height
                    onDoubleClicked: {
                        console.log(messageArea.text);
                        messageArea.text = "";
                    }
                }*/

                id: messageArea
                width: parent.width
                height: Math.max(home.width/3, implicitHeight)
                placeholderText: "Start typing in your browser"
                label: "Double tap to copy to clipboard"
                readOnly: false

                onClicked: {
                    console.log(messageArea.text);
                    messageArea.text = "";
                }

                Connections {
                    target: websocketServer
                    onKeystrokeReceived: {
                        messageArea.text += Qt.Key_1;
                    }

                }
            }
            /*
            TextField {
                id: serverTf
                width: parent.width
                readOnly: true
                label: httpServer.getFullAddress();
                text: "Server address"
                horizontalAlignment: TextInput.AlignLeft
            }

            TextField {
                id: statusTf
                width: parent.width
                readOnly: true
                text: "Server status"
                label: httpServer.isRunning() ? "running" : "not running"
                horizontalAlignment: TextInput.AlignLeft
            }

            SectionHeader {
                horizontalAlignment: Text.AlignLeft
                text: "Controls"
            }

            Row {
                id: controlRow
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: Theme.paddingLarge
                property bool running: false

                IconButton {
                    id: pause
                    icon.source: "image://theme/icon-l-pause"
                    onClicked: {
                        controlRow.running = false
                        httpServer.stopServer()
                        websocketServer.stopServer()
                    }
                    enabled: controlRow.running
                }

                IconButton {
                    id: start
                    icon.source: "image://theme/icon-l-play"
                     onClicked: {
                         controlRow.running = true
                         httpServer.startServer(flickable.httpPort);
                         websocketServer.startServer(flickable.websocketPort)
                     }
                     enabled: ! controlRow.running
                }
            }

            SectionHeader {
                horizontalAlignment: Text.AlignLeft
                text: "Trace"
            }

            TextArea {
                id: traceArea
                width: parent.width
                height: 350
                placeholderText: "Browse the server address and start typing ..."
                label: "Trace area"
                readOnly: true
                VerticalScrollDecorator {}
            }
*/
        }
    }
}


