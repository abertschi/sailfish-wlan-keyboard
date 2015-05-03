var AppDispatcher = require('../dispatcher/AppDispatcher');
var EventEmmiter = require('events').EventEmitter;
var WlanKeyboardConstants = require('../constants/WlanKeyboardConstants');
var assign = require('object-assign');

var CHANGE_EVENT = 'change';

var _serverSettings = {};

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
        var settings = WlanKeyboardStore.getServerSettings() || {};
        return WlanKeyboardConstants.KeyMode.HEADLESS;
    }

});

AppDispatcher.register(function (action) {

    switch (action.type) {
        case WlanKeyboardConstants.ActionTypes.RECEIVE_SETTINGS:
            break;

        default:
            break;
    }
});

module.exports = WlanKeyboardStore;