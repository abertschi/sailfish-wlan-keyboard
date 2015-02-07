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
        contentHeight: column.height

        VerticalScrollDecorator {}

        property int httpPort: 7778
        property int websocketPort: 7777

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            id: column
            width: home.width
            spacing: Theme.paddingLarge
            PageHeader {
                title: "Wlan Keyboard"
            }

            SectionHeader {
                horizontalAlignment: Text.AlignLeft
                text: "Server"
            }

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

                Connections {
                    target: websocketServer
                    onNewMessageSignal: {
                        console.log("slot called");
                        traceArea.text = traceArea.text + message;
                    }
                }
            }

        }
    }
}


