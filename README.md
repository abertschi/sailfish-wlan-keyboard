# sailfish-wlan-keyboard

> Use your computer keyboard to type on your phone

![Sailfish WlanKeyboard](http://abertschi.ch/default_public/harbour-wlan-keyboard.png)

Did you get fed up with small smartphone keyboard? Do you have your computer anyway always with you? Use *WlanKeyboard for SailfishOS* to type on your phone by using your computer keyboard.

# How does it work
Connect your phone to the same network as your computer. Browse a website published by your phone and start typing. This app provides Http and Websocket services enabling you to stream keystrokes to your phone.

# Harbour store restrictions
Due to some harbour restrictions, an alternative keyboard layout cannot be provided. Therefore, this app copies your keystrokes into the clipboard and you need to paste them into the focused widget.

I am about to write an alternative keyboard layout that should automatically pasting the keystrokes into the focused widget.
 However, this part cannot be published in the harbour store. See `./harbour-wlan-keys-layout/`

## Project internals
    # Sub projects
    harbour-wlan-keyboard/              sailfish app
    harbour-wlan-html/                  html5 UI for browser
    harbour-wlan-keyboard-layout/       alternative keyboard layout


## Used technologies
 - c++
 - Qt, Qml
 - html5, websockets
 - npm, gulp

- *rapidjson* by Milo Yip , see https://github.com/miloyip/rapidjson
- *QtWebsocket* by Antoine Lafarge, see https://github.com/antlafarge/QtWebsocket
- *QHttpServer* by Nikhil Marathe, see https://github.com/nikhilm/qhttpserver
