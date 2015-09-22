"use strict"

var React = require('react');
var WlanKeyboard = require('./components/WlanKeyboard.react');
var JollaAppConn = require('./utils/JollaAppConnection');

var wsEndpoint = '__WS_ENDPOINT__';
var debugCheck = '__WS_' + 'ENDPOINT__';

if (wsEndpoint == debugCheck) {
    wsEndpoint = 'ws://192.168.1.165:8893';
}

console.log("Booting sailfish-wlan-keyboard frontend");
console.log("Using websocket endpoint: " + wsEndpoint);

JollaAppConn.connect(wsEndpoint);

window.React = React;

React.render(
    <WlanKeyboard />,
    document.getElementById('app')
);