
function createInterfaceOptions(container) {
    var component = Qt.createComponent("MenuItem.qml");
    console.log(component);

    var created = component.createObject(container, {"text": "100"});

}

function _completeInterfaceOptions(component, container) {
    if (component.status == Component.Ready) {

        console.log(created)
        if (created == null) {
            // Error Handling
            console.log("Error creating object");
        }
    } else if (component.status == Component.Error) {
        // Error Handling
        console.log("Error loading component:", component.errorString());
    }
}
