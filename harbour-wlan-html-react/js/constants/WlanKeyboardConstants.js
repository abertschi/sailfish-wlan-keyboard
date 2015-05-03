var keyMirror = require('keymirror');

module.exports = {

  ActionTypes: keyMirror({
      RECEIVE_SETTINGS: null,
      SEND_TEXT: null,
      SEND_KEY_ENTER: null,
      SEND_KEY_DEL: null,
      SEND_KEY_ARROW: null,
      CONNECTION_STATUS_CHANGED: null
  }),

    KeyMode: {
        HEADLESS: 0,
        CLIPBOARD: 1
    }

};