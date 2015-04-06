import QtQuick 2.0
import "LocalStore.js" as LocalStore

QtObject {

    property int httpPort: 7777
    property int wsPort: 7778
    property bool autostart: false
    property bool useHttps: false
    property int keyboardMode: 1
    property bool useAnyConnection: true
    property string prefferedIp

    Component.onCompleted: {
        if (LocalStore.isEmpty()) {
            LocalStore.set('httpPort', wsPort);
            LocalStore.set('wsPort', wsPort);
            LocalStore.set('autostart', autostart);
            LocalStore.set('useHttps', useHttps);
            LocalStore.set('keyboardMode', keyboardMode);
            LocalStore.set('useAnyConnection', useAnyConnection);
            LocalStore.set('prefferedIp', prefferedIp);
        }
        else {
            httpPort = LocalStore.get('httpPort');
            wsPort = LocalStore.get('wsPort');
            autostart = LocalStore.get('autostart');
            useHttps = LocalStore.get('useHttps');
            keyboardMode = LocalStore.get('keyboardMode');
            useAnyConnection = LocalStore.get('useAnyConnection');
            prefferedIp = LocalStore.get('prefferedIp');
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
    onPrefferedIpChanged: {
        LocalStore.set('prefferedIp', prefferedIp)
    }
}
