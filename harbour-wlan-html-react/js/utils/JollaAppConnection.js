var WsSocket = require('./ws_events_dispatcher');
var Actions = require('../actions/WlanKeyboardActions');
var AppDispatcher = require('../dispatcher/AppDispatcher');
var WlanKeyboardConstants = require('../constants/WlanKeyboardConstants');

console.log("init from jolla app");

var socket = {};

function checkStatus() {

    setTimeout(function() {
        var readyStateMsg = [
            [0, 'connecting'],
            [1, 'connected'],
            [2, 'disconnecting'],
            [3, 'not connected']];

        Actions.connectionStatusChanged(readyStateMsg[socket.getSocket().readyState][1]);

        checkStatus();
    }, 1000);

}

var JollaAppConnection = {

    connect: function (endpoint) {
        socket = new WsSocket(endpoint);
        checkStatus();

        socket.bind("update_settings", function (data) {
            Actions.jollaAppSettingsUpdated(data);
        });

        socket.bind('open', function () {

        });

        socket.bind('close', function () {

        });

        socket.bind('open', function () {

        });
    },

    sendKeyEnter: function () {
        console.log('socket.send(');
        socket.send('send_key_return', '');
    },

    sendKeyDel: function () {
        socket.send('send_key_del', '');
    },

    sendKeyArrow: function (direction) {
        socket.send('send_key_arrow', direction);
    },

    sendText: function (text) {
        socket.send('insert_text', text);
    }
}

module.exports = JollaAppConnection