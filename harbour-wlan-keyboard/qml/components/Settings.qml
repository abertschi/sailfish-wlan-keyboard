import QtQuick 2.0
import "../services/LocalStore.js" as LocalStore

QtObject {
    id: settings

    // todo: always throws Unable to assign [undefined] to int
    property int _HEADLESS_MODE_RETURN_BASED: 0 //_qtSettings.RETURN_BASED
    property int _HEADLESS_MODE_CONTINUOUS: 1 //_qtSettings.CONTINUOUS

    property int _KEYBOARD_MODE_HEADLESS: 1 //_qtSettings.HEADLESS
    property int _KEYBOARD_MODE_CLIPBOARD: 0 //_qtSettings.CLIPBOARD


    // boolean doesnt seem to work, therefore bools are int
    property int httpPort: _qtSettings.httpPort

    property int wsPort: _qtSettings.wsPort

    property int autostart: _qtSettings.autostart

    property int useHttps: _qtSettings.useHttps

    property int keyboardMode: _qtSettings.keyboardMode

    property int headlessMode: _qtSettings.headlessMode

    property int useAnyConnection: _qtSettings.useAnyConnection

    property int firstRun: _qtSettings.firstRun

    property string connectionInterface: _qtSettings.connectionInterface

    property int connectionInterfaceIndex: _qtSettings.connectionInterfaceIndex

    Component.onCompleted: {
        if (firstRun) {
            LocalStore.initSettings()
        }

        httpPort = LocalStore.get('httpPort', 7777);
        wsPort = LocalStore.get('wsPort', 7778);
        var a = LocalStore.get('autostart', 0);
        console.log("AUTOSTART: " + a)
        autostart =  a
        useHttps = LocalStore.get('useHttps', 0);
        keyboardMode = LocalStore.get('keyboardMode', _KEYBOARD_MODE_CLIPBOARD);
        headlessMode = LocalStore.get('headlessMode', _HEADLESS_MODE_RETURN_BASED);
        useAnyConnection = LocalStore.get('useAnyConnection', 1);
        connectionInterface = LocalStore.get('connectionInterface', "");
        connectionInterfaceIndex = LocalStore.get('connectionInterfaceIndex', 0);
        firstRun = LocalStore.get('firstRun', 1);
    }

    onHttpPortChanged: {
        LocalStore.set('httpPort', httpPort)
        _qtSettings.httpPort = httpPort
    }
    onWsPortChanged: {
        LocalStore.set('wsPort', wsPort)
        _qtSettings.wsPort = wsPort
    }
    onAutostartChanged: {
        console.log("AUTOSTART: " + autostart)

        LocalStore.set('autostart', autostart)
        _qtSettings.autostart = autostart
    }
    onUseHttpsChanged: {
        LocalStore.set('useHttps', useHttps)
        _qtSettings.useHttps = useHttps
    }
    onKeyboardModeChanged: {
        LocalStore.set('keyboardMode', keyboardMode)
        _qtSettings.keyboardMode = keyboardMode
    }
    onConnectionInterfaceChanged: {
        LocalStore.set('connectionInterface', connectionInterface)
        _qtSettings.connectionInterface = connectionInterface
    }
    onConnectionInterfaceIndexChanged: {
        LocalStore.set('connectionInterfaceIndex', connectionInterfaceIndex)
        _qtSettings.connectionInterfaceIndex = connectionInterfaceIndex
    }
    onFirstRunChanged: {
        LocalStore.set('firstRun', firstRun)
        _qtSettings.firstRun = firstRun
    }
    onHeadlessModeChanged: {
        LocalStore.set('headlessMode', headlessMode)
        _qtSettings.headlessMode = headlessMode
    }
}
