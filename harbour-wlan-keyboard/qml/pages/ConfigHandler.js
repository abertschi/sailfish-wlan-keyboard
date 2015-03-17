
function createIfOptions(container) {
    var component = Qt.createComponent("MenuItem.qml");
    if (component.status == Component.Ready)
        _finishCreateIfOptions(container, component);
    else
        component.statusChanged.connect(_finishCreateIfOptions(container, component));
}

function _finishCreateIfOptions(container, component) {
    if (component.status == Component.Ready) {
        var widget = component.createObject(container, {"text": "100"});
        if (widget == null) {
            // Error Handling
            console.log("Error creating object");
        }
    } else if (component.status == Component.Error) {
        // Error Handling
        console.log("Error loading component:", component.errorString());
    }
}
