var AppDispatcher = require('../dispatcher/AppDispatcher');
var AppConstants = require('../constants/WlanKeyboardConstants');

var WlanKeyboardActions = {

    actionEnterKeyPressed: function () {
        AppDispatcher.dispatch({
            type: AppConstants.ActionTypes.SEND_KEY_ENTER
        });
    },

    actionDelKeyPressed: function () {

        AppDispatcher.dispatch({
            type: AppConstants.ActionTypes.SEND_KEY_DEL
        });
    },

    actionArrowKeyPressed: function (arrow) {
        AppDispatcher.dispatch({
            type: AppConstants.ActionTypes.SEND_KEY_ARROW,
            direction: arrow
        });
    },

    actionNewText: function (text) {
        AppDispatcher.dispatch({
            type: AppConstants.ActionTypes.SEND_TEXT,
            text: text
        });
    },

    jollaAppSettingsUpdated: function (settings) {
        AppDispatcher.dispatch({
            type: AppConstants.ActionTypes.RECEIVE_SETTINGS,
            settings: settings
        });
    },

    actionSetClipboardOnPhone: function(clipboard) {
        console.log("actionSetClipboardOnPhone: " + clipboard);
        AppDispatcher.dispatch({
           type: AppConstants.ActionTypes.SET_CLIPBOARD_VALUE,
            clipboard: clipboard
        });
    },

    actionSetClipboardOnComputer: function(clipboard) {
        console.log("actionSetClipboardOnComputer: " + clipboard);
        AppDispatcher.dispatch({
            type: AppConstants.ActionTypes.RECEIVE_CLIPBOARD_VALUE,
            clipboard: clipboard
        });
    },

    connectionStatusChanged: function (status) {
        AppDispatcher.dispatch({
            type: AppConstants.ActionTypes.CONNECTION_STATUS_CHANGED,
            status: status
        });
    },

    keyModeChanged: function (mode) {
        AppDispatcher.dispatch({
            type: AppConstants.ActionTypes.KEY_MODE_CHANGED,
            keyMode: mode
        });
    },

    moreOptionsVisibled: function(state) {
        AppDispatcher.dispatch({
            type: AppConstants.ActionTypes.MORE_OPTIONS_VISIBLE,
            visble: state
        });
    }
};

module.exports = WlanKeyboardActions;