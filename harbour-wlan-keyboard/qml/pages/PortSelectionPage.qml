import QtQuick 2.0
import Sailfish.Silica 1.0

SilicaListView {
    id: portSelection
    anchors.fill: parent

    header: PageHeader { title: "Please select a port" }

    model: 9999

    Repeater{
        BackgroundItem {
            width: portSelection.width
            Label {
                id: port
                text: index
                color: highlighted ? Theme.highlightColor : Theme.primaryColor
                anchors.verticalCenter: parent.verticalCenter
                x: Theme.paddingLarge
            }
            //onClicked: pageStack.push(Qt.resolvedUrl(page))
        }
    }
    VerticalScrollDecorator {}
}
