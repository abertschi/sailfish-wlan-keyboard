/*
    USB Switch - a simple USB mode switcher for SailfishOS
    Copyright (C) 2014 Jens Klingen
    https://github.com/jklingen/harbour-usb-switch
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
    GNU General Public License for more details.
    You should have received a copy of the GNU General Public License
    along with this program. If not, see <http://www.gnu.org/licenses/>.

    TODO, what was changed
    https://github.com/jklingen/harbour-usb-switch/blob/master/qml/components/ModeButton.qml
*/

import QtQuick 2.1
import Sailfish.Silica 1.0


Item {
    id: startSwitch
    property bool selected
    property string text
    property string iconSource


    //icon.source: iconSource + '?' + ((parent.pressed || selected) ? Theme.highlightColor : Theme.primaryColor)
    //icon.x:
    //icon.anchors.horizontalCenter: parent.horizontalCenter
    //icon.anc hors.left: parent.lef

    /*
    Rectangle {
        id: bg
        anchors.fill: parent
        anchors.horizontalCenter: parent.horizontalCenter
        //color: Theme.secondaryHighlightColor
        //opacity: mouse.pressed ? .25 : 0
    }

    /*
    Label {
        anchors.top: icon.bottom
        anchors.topMargin: 0
        color: (mouse.pressed || selected ) ? Theme.highlightColor : Theme.primaryColor
        text: startSwitch.text
        anchors.horizontalCenter: parent.horizontalCenter
    }
*/
    Image {
        id: icon
        source: "../pages/server-switch.png" + '?' + ((mouse.pressed || selected) ? Theme.highlightColor : Theme.primaryColor)
        fillMode: Image.PreserveAspectFit
        anchors.centerIn: parent
        height: parent.height
        opacity: mouse.pressed ? 1 : .7
        smooth: true
    }
    MouseArea {
        id: mouse
        anchors.fill: parent
    }



}
