import QtQuick 2.0
import "LocalStore.js" as LocalStore

QtObject {

    QtObject {
        id: enumHeadlessMode
        property int RETURN_BASED: _qtSettings.RETURN_BASED
        property int CONTINUOUS: _qtSettings.CONTINUOUS
    }

    QtObject {
        id: enumKeyboardMode
        property int CLIPBOARD: _qtSettings.CLIPBOARD
        property int HEADLESS: _qtSettings.HEADLESS
    }

    // deprecated: use enumKeyboardMode
    property int _KEYBOARD_MODE_ALT_KEYBOARD: _qtSettings.HEADLESS
    property int _KEYBOARD_MODE_CLIPBOARD: _qtSettings.CLIPBOARD

    property int httpPort: _qtSettings.httpPort

    property int wsPort: _qtSettings.wsPort

    property bool autostart: _qtSettings.autostart

    property bool useHttps: _qtSettings.useHttps

    property int keyboardMode: _qtSettings.keyboardMode

    property int headlessMode: _qtSettings.headlessMode

    property bool useAnyConnection: _qtSettings.useAnyConnection

    property bool firstRun: _qtSettings.firstRun

    property string connectionInterface: _qtSettings.connectionInterface

    property int connectionInterfaceIndex: _qtSettings.connectionInterfaceIndex

    Component.onCompleted: {
        if (firstRun) {
            LocalStore.initSettings()
        }

        httpPort = LocalStore.get('httpPort', 7777);
        wsPort = LocalStore.get('wsPort', 7778);
        autostart = LocalStore.get('autostart', false);
        useHttps = LocalStore.get('useHttps', false);
        keyboardMode = LocalStore.get('keyboardMode', enumKeyboardMode.CLIPBOARD);
        headlessMode = LocalStore.get('headlessMode', enumHeadlessMode.RETURN_BASED);
        useAnyConnection = LocalStore.get('useAnyConnection', true);
        connectionInterface = LocalStore.get('connectionInterface', null);
        connectionInterfaceIndex = LocalStore.get('connectionInterfaceIndex', 0);
        firstRun = LocalStore.get('firstRun', true);
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
        _qtSettings.connectionInterfaceIndex = connectionInterfaceIndex
    }
    onHeadlessModeChanged: {
        LocalStore.set('headlessMode', headlessMode)
        _qtSettings.headlessMode = headlessMode
    }
}
