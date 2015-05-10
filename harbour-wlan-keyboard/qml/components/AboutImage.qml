import QtQuick 2.1
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
}

