import QtQuick 2.1
import QtFeedback 5.0
import Sailfish.Silica 1.0

Image {
    id: image

    property int pressed: 0

    fillMode: Image.PreserveAspectFit
    opacity: mouse.pressed ? 1 : .7
    source: "../pages/server-switch.png"
    height: 400

    MouseArea {
        id: mouse
        anchors.fill: parent
        onPressed: {
            image.pressed += 1
        }
    }

    Connections {
        target: image
        onPressedChanged: {
            if (pressed === 5) {
                console.log('5 reached')
                pressed = 0
            }
        }
    }
}