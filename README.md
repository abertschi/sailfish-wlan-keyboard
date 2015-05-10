# sailfish-wlan-keyboard

The sailfish-wlan-keyboard provides an easy way to use you your computer keyboard to type on your phone.

![Sailfish WlanKeyboard](http://abertschi.ch/default_public/harbour-wlan-keyboard-devel.png)

Simply connect your phone to WIFI or USB and browse a website on your computer published by your phone. Keystrokes being entered there are transmitted to your phone and inserted at your cursor position. No hassle any longer with tiny smartphone keyboards or just too big fingers.


![Sailfish WlanKeyboard](http://abertschi.ch/default_public/harbour-wlan-keyboard-html-and-phone.png)

==================================================================

## Developer notes

### Technology Stack
 - C++ with Qt 5 and QML Quick 2.1
 - React.js with Flux application architecture, HTML5, WebSockets

#### Development Tool Stack
 - SailfishSDK based on Qt Creator 3
 - npm with gulp and browserify, reactify, watchify

## Build it!

### Web Frontend

You will need [npm](https://www.npmjs.com) installed on your system. After you have successfully cloned the repository and stepped into the frontend folder, download the dependencies.

```shell
$ cd harbour-wlan-keyboard-html
$ npm install
```

With the dependencies in place, you are now able to build the web assets. Fire up Gulp for that.

```shell
# Start development mode (Browse http://localhost:1337)
$ gulp
```

For a production ready build, add the `--production` flag so it will be used once Qt Creator is fired up for a new build.

### Sailfish Application
With the Web Frontend generated, import the files under `./harbour-wlan-keyboard` in [QtCreator](https://sailfishos.org/develop/sdk-overview/) and build for SailfishOS.

## Contributing

Help is always welcome. Contribute to the project by forking and submitting a pull request.

## License

This project is released under the GNU General Public License V3.

## Contact
[![twitter: @andrinbertschi]( https://img.shields.io/badge/twitter-andrinbertschi-yellow.svg?style=flat-square)](http://twitter.com/andrinbertschi)
