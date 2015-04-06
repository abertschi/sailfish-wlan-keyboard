
function createIfOptions(parentId) {
    var component = Qt.createComponent( "MenuItem.qml" );
    if( component.status != Component.Ready )
    {
        if( component.status == Component.Error )
            console.debug("Error:"+ component.errorString() );
        return; // or maybe throw
    }
    var dlg = component.createObject( parentId, {} );
    console.log(dlg)
}
