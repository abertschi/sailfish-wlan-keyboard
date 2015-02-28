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

import QtQuick 2.0
import Sailfish.Silica 1.0


IconButton {
    property bool alwaysHighlighted
    property string text
    property string iconSource

    signal onClicked

    icon.source: iconSource + '?' + ((parent.pressed || alwaysHighlight) ? Theme.highlightColor : Theme.primaryColor)

    Label {
        y: 2*Theme.paddingLarge
        anchors.horizontalCenter: parent.horizontalCenter
        color: (parent.pressed || alwaysHighlighted ) ? Theme.highlightColor : Theme.primaryColor
        text:parent.text
    }
    Rectangle {
        width:parent.width
        height:parent.height-2*Theme.paddingLarge
        color:Theme.secondaryHighlightColor
        opacity: parent.pressed ? .25 : 0
    }
}
