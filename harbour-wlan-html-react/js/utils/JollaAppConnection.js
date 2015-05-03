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


AppDispatcher.register(function(action) {

    switch (action.type) {
        case WlanKeyboardConstants.ActionTypes.RECEIVE_SETTINGS:
            break;

        case WlanKeyboardConstants.ActionTypes.SEND_TEXT:
            JollaAppConnection.sendText(action.text);
            break;

        case WlanKeyboardConstants.ActionTypes.SEND_KEY_ENTER:
            console.log("new action received" + action);
            JollaAppConnection.sendKeyEnter();
            break;

        case WlanKeyboardConstants.ActionTypes.SEND_KEY_DEL:
            JollaAppConnection.sendKeyDel();
            break;

        case WlanKeyboardConstants.ActionTypes.SEND_KEY_ARROW:
            JollaAppConnection.sendKeyArrow(action.direction);
            break;

        default:
            break;
    }
});


module.exports = JollaAppConnection