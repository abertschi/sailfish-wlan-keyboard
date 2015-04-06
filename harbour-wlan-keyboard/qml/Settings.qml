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

    // index of interfaces if not useAnyConnection is chosen
    property string connectionIndex

    Component.onCompleted: {
        if (LocalStore.isEmpty() ) {
            LocalStore.set('httpPort', wsPort);
            LocalStore.set('wsPort', wsPort);
            LocalStore.set('autostart', autostart);
            LocalStore.set('useHttps', useHttps);
            LocalStore.set('keyboardMode', keyboardMode);
            LocalStore.set('useAnyConnection', useAnyConnection);
            LocalStore.set('connectionIndex', connectionIndex);
        }
        else {
            httpPort = LocalStore.get('httpPort', 7777);
            wsPort = LocalStore.get('wsPort', 7778);
            autostart = LocalStore.get('autostart', false);
            useHttps = LocalStore.get('useHttps', false);
            keyboardMode = LocalStore.get('keyboardMode', _KEYBOARD_MODE_CLIPBOARD);
            useAnyConnection = LocalStore.get('useAnyConnection', true);
            connectionIndex = LocalStore.get('connectionIndex', 0);
        }
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
    onConnectionIndexChanged: {
        LocalStore.set('connectionIndex', connectionIndex)
    }
}
