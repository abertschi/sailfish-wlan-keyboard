var WsSocket = require('./ws_events_dispatcher');
var Actions = require('../actions/WlanKeyboardActions');
var AppDispatcher = require('../dispatcher/AppDispatcher');

var ConnectionStatus = require('../constants/WlanKeyboardConstants').ConnectionStatus;

console.log("init from jolla app");

var socket = {};
var endpoint = {};
var isCheckStatus = false;

function checkStatus() {
    isCheckStatus = true;

        //CONNECTING	0	The connection is not yet open.
        //OPEN	1	The connection is open and ready to communicate.
        //CLOSING	2	The connection is in the process of closing.
        //CLOSED	3	The connection is closed or couldn't be opened.

    setTimeout(function() {
        var state;
        var readyState = socket.getSocket().readyState;
        switch (readyState) {
            case 1:
                state = ConnectionStatus.CONNECTED;
                break;
            case 0:
            case 2:
            case 3:
            default:
                state = ConnectionStatus.NOT_CONNECTED;
                JollaAppConnection.connect(endpoint);
        }
        Actions.connectionStatusChanged(state);
        checkStatus();
    }, 1000);

}

var JollaAppConnection = {

    connect: function (endP) {
        endpoint = endP;
        try {
            socket = new WsSocket(endpoint);
        } catch (e) {

        }

        if(!isCheckStatus) {
            checkStatus();
        }

        socket.bind("update_settings", function (data) {
            Actions.jollaAppSettingsUpdated(data);
        });


        socket.bind('close', function () {
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