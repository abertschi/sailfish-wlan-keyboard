# sailfish-wlan-keyboard

> Use your computer keyboard to type on your phone

Did you get fed up with small smartphone keyboards? Do you have your computer anyway always with you? Use *WlanKeyboard for SailfishOS* to type on your phone by using your computer keyboard.

![Sailfish WlanKeyboard](http://abertschi.ch/default_public/harbour-wlan-keyboard.png)

# How does it work
Simply connect your phone to the same network as your computer. Browse a website published by your phone and start typing. Your keystrokes are available in your clipboard and can be pasted into a focused input widget of any application.

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


## License
- sailfish-wlan-keyboard license

        sailfish-wlan-keyboard - Use your computer keyboard to type on your phone.
        Copyright (C) 2015 by Andrin Bertschi

        This program is free software: you can redistribute it and/or modify
        it under the terms of the GNU General Public License as published by
        the Free Software Foundation, either version 3 of the License, or
        (at your option) any later version.

        This program is distributed in the hope that it will be useful,
        but WITHOUT ANY WARRANTY; without even the implied warranty of
        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
        GNU General Public License for more details.

        You should have received a copy of the GNU General Public License
        along with this program. If not, see <http://www.gnu.org/licenses/>

- *rapidjson* by Milo Yip , see https://github.com/miloyip/rapidjson  

        Copyright (C) 2011 Milo Yip  
        Permission is hereby granted, free of charge, to any person obtaining a copy
        of this software and associated documentation files (the "Software"), to deal
        in the Software without restriction, including without limitation the rights
        to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
        copies of the Software, and to permit persons to whom the Software is
        furnished to do so, subject to the following conditions:
        The above copyright notice and this permission notice shall be included in
        all copies or substantial portions of the Software.
        THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
        IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
        FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
        AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
        LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
        OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
        THE SOFTWARE.


- *QtWebsocket* by Antoine Lafarge, see https://github.com/antlafarge/QtWebsocket  

        Copyright 2013 Antoine Lafarge qtwebsocket@gmail.com
        This file is part of QtWebsocket.
        QtWebsocket is free software: you can redistribute it and/or modify it under
        the terms of the GNU Lesser General Public License as published by the
        Free Software Foundation, either version 3 of the License, or any later version.

        QtWebsocket is distributed in the hope that it will be useful,
        but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
        or FITNESS FOR A PARTICULAR PURPOSE.
        See the GNU Lesser General Public License for more details.

        You should have received a copy of the GNU Lesser General Public License
        along with QtWebsocket. If not, see http://www.gnu.org/licenses/.

- *QHttpServer* by Nikhil Marathe, see https://github.com/nikhilm/qhttpserver  

        Copyright (C) 2011-2014 Nikhil Marathe <nsm.nikhil@gmail.com>

        Permission is hereby granted, free of charge, to any person obtaining a copy
        of this software and associated documentation files (the "Software"), to
        deal in the Software without restriction, including without limitation the
        rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
        sell copies of the Software, and to permit persons to whom the Software is
        furnished to do so, subject to the following conditions:

        The above copyright notice and this permission notice shall be included in
        all copies or substantial portions of the Software.

        THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
        IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
        FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
        AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
        LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
        FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
        IN THE SOFTWARE.
