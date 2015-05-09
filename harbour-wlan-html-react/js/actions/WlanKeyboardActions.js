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
            text: settings
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
    }
};

module.exports = WlanKeyboardActions;