import QtQuick 2.0
import "LocalStore.js" as LocalStore

QtObject {

    property int _KEYBOARD_MODE_ALT_KEYBOARD: 2
    property int _KEYBOARD_MODE_CLIPBOARD: 1

    property int httpPort
    property int wsPort
    property int autostart
    property int useHttps
    property int keyboardMode
    property bool useAnyConnection
    property bool firstRun;

    property string connectionInterface

    property int connectionInterfaceIndex

    Component.onCompleted: {
        httpPort = LocalStore.get('httpPort', 7777);
        wsPort = LocalStore.get('wsPort', 7778);
        autostart = LocalStore.get('autostart', false);
        useHttps = LocalStore.get('useHttps', false);
        keyboardMode = LocalStore.get('keyboardMode', _KEYBOARD_MODE_CLIPBOARD);
        useAnyConnection = LocalStore.get('useAnyConnection', true);
        connectionInterface = LocalStore.get('connectionInterface', null);
        connectionInterfaceIndex = LocalStore.get('connectionInterfaceIndex', 0);
        firstRun = LocalStore.get('firstRun', true);

    }

    onHttpPortChanged: {
        LocalStore.set('httpPort', httpPort)
    }
    onWsPortChanged: {
        LocalStore.set('wsPort', wsPort)
    }
    onAutostartChanged: {
        LocalStore.set('autostart', autostart)
    }
    onUseHttpsChanged: {
        LocalStore.set('useHttps', useHttps)
    }
    onKeyboardModeChanged: {
        LocalStore.set('keyboardMode', keyboardMode)
    }
    onConnectionInterfaceChanged: {
        LocalStore.set('connectionInterface', connectionInterface)
    }
    onConnectionInterfaceIndexChanged: {
        LocalStore.set('connectionInterfaceIndex', connectionInterfaceIndex)
    }
    onFirstRunChanged: {
        LocalStore.set('firstRun', firstRun)
    }
}
