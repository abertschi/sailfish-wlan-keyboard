var AppDispatcher = require('../dispatcher/AppDispatcher');
var EventEmmiter = require('events').EventEmitter;
var WlanKeyboardConstants = require('../constants/WlanKeyboardConstants');
var assign = require('object-assign');
var JollaAppConnection = require('../utils/JollaAppConnection');

var CHANGE_EVENT = 'change';

var _serverSettings = {};

var _connectionStatus = {};

var _keyMode = _keyMode || WlanKeyboardConstants.KeyMode.HEADLESS;

var WlanKeyboardStore = assign({}, EventEmmiter.prototype, {

    emitChange: function () {
        this.emit(CHANGE_EVENT);
    },

    addChangeListener: function (callback) {
        this.on(CHANGE_EVENT, callback);
    },

    removeChangeListener: function (callback) {
        this.removeListener(callback);
    },


    getServerSettings: function() {
        return _serverSettings;
    },

    getKeyMode: function() {
        return _keyMode;
    },

    updateKeyMode: function(keyMode) {
        _keyMode = keyMode;
        this.emitChange();
    },

    getConnectionStatus: function() {
        return _connectionStatus;
    },

    updateConnectionStatus: function(status) {
        _connectionStatus = status;
        this.emitChange();
    }

});

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

        case WlanKeyboardConstants.ActionTypes.KEY_MODE_CHANGED:
            WlanKeyboardStore.updateKeyMode(action.keyMode);
            console.log(action);
            break;

        case WlanKeyboardConstants.ActionTypes.CONNECTION_STATUS_CHANGED:
                WlanKeyboardStore.updateConnectionStatus(action.status);
                if (action.status != WlanKeyboardStore.getConnectionStatus) {
                    WlanKeyboardStore.updateConnectionStatus(action.status);
                }
            break;

        default:
            break;
    }
});


module.exports = WlanKeyboardStore;