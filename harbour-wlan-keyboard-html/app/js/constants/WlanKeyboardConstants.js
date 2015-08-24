var keyMirror = require('keymirror');

module.exports = {

  ActionTypes: keyMirror({
      RECEIVE_SETTINGS: null,
      SEND_TEXT: null,
      SEND_KEY_ENTER: null,
      SEND_KEY_DEL: null,
      SEND_KEY_ARROW: null,
      RECEIVE_CLIPBOARD_VALUE: null,
      SET_CLIPBOARD_VALUE: null,
      CONNECTION_STATUS_CHANGED: null,
      KEY_MODE_CHANGED: null,
      MORE_OPTIONS_VISIBLE: null
  }),

    KeyMode: {
        HEADLESS: 1,
        CLIPBOARD: 0
    },

    ConnectionStatus: keyMirror({
            CONNECTED: null,
            NOT_CONNECTED: null
    })
}