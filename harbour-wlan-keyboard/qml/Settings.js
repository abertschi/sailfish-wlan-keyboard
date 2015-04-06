.pragma library
.import "LocalStore.js" as LocalStore

// DEPRECATED

var KeyboardMode = {
    CLIPBOARD: "1",
    ALT_KEYBOARD: "2"
}

var Keys = {
    httpPort: "httpPort",
    wsPort: "wsPort",
    autostart: "autostart",
    useHttps: "useHttps",
    keyboardMode: "keyboardMode",
    useAnyConnection: "useAnyConnection",
    preferedIp: "preferedIp"
}

var DbVals = {
    DB_FALSE: "false",
    DB_TRUE: "true"
}

function init() {
    if(LocalStore.isEmpty() || false) {
        LocalStore.set(Keys.httpPort, 7777);
        LocalStore.set(Keys.wsPort, 7778);
        LocalStore.set(Keys.autostart, false);
        LocalStore.set(Keys.useHttps, false);
        LocalStore.set(Keys.keyboardMode, KeyboardMode.CLIPBOARD);
        LocalStore.set(Keys.useAnyConnection, true);
        LocalStore.set(Keys.preferedIp, null);
    }
}

function getHttpPort() {
    return LocalStore.get(Keys.httpPort);
}

function setHttpPort(port) {
    return LocalStore.set(Keys.httpPort, port);
}

function getWsPort() {
    return LocalStore.get(Keys.wsPort);
}

function setWsPort(port) {
    return LocalStore.set(Keys.wsPort, port);
}

function isAutostart() {
    return LocalStore.get(Keys.autostart);
}

function setAutostart(yes) {
    return LocalStore.set(Keys.autostart, yes ? DbVals.DB_TRUE: DbVals.DB_FALSE);
}

function isHttps() {
    return LocalStore.get(Keys.useHttps);
}

function setHttps(yes) {
    return LocalStore.set(Keys.useHttps, yes ? DbVals.DB_TRUE: DbVals.DB_FALSE);
}

function isKeyboardModeClipboard() {
    return LocalStore.get(Keys.keyboardMode) === KeyboardMode.CLIPBOARD;
}

function isKeyboardModeKeyboardLayout() {
    return LocalStore.get(Keys.keyboardMode) === KeyboardMode.ALT_KEYBOARD;
}

function setKeyboardMode(mode) {
    LocalStore.set(Keys.keyboardMode, mode)
}

function getUseAnyConnection() {
    return LocalStore.get(Keys.useAnyConnection);
}

function setUseAnyConnection(yes) {
    return LocalStore.get(Keys.useAnyConnection, yes ? DbVals.DB_TRUE: DbVals.DB_FALSE);
}

function getPreferedIp() {
    return LocalStore.get(Keys.preferedIp, "not-defined");
}

function setPreferedIp(ip) {
    LocalStore.set(Keys.preferedIp, ip);
}

