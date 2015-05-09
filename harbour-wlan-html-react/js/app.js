"use strict"

var React = require('react');
var WlanKeyboard = require('./components/WlanKeyboard.react');
var JollaAppConn = require('./utils/JollaAppConnection');

var wsEndpoint = '__WS_ENDPOINT__';
var debugCheck = '__WS_' + 'ENDPOINT__';

if (wsEndpoint == debugCheck) {
    wsEndpoint = 'ws://192.168.1.91:8893';
}

JollaAppConn.connect(wsEndpoint);

console.log("ABOUT TO CALL");
setTimeout(function() {

    console.log("CALLLLED");
}, 1000);

React.render(
    <WlanKeyboard />,
    document.getElementById('app')
);