"use strict"

var React = require('react');
var WlanKeyboardStore = require('../stores/WlanKeyboardStore');
var Header = require('./Header.react');
var ConnectionStatus = require('./ConnectionStatus.react');
var KeyModeStatus = require('./KeyModeStatus.react');
var AppConstants = require('../constants/WlanKeyboardConstants');
var WlanKeyboardActions = require('../actions/WlanKeyboardActions');

var WlanKeyboard = React.createClass({

    getStateFromStores: function () {
        return {
            status: WlanKeyboardStore.getConnectionStatus(),
            keyMode: WlanKeyboardStore.getKeyMode(),
            clipboard: WlanKeyboardStore.getPhoneClipboard() || "test"
        };
    },

    getInitialState: function () {
        return this.getStateFromStores();
    },

    componentDidMount: function () {
        WlanKeyboardStore.addChangeListener(this._onChange);



        setTimeout(function() {
            //console.log("Checkig cb");
            //var cb = window.clipboardData.getData('Text');
            //console.log(cb);
            //if (cb && WlanKeyboardStore.getPhoneClipboard() != cb) {
            //    WlanKeyboardActions.actionSetClipboardOnPhone(cb);
            //}
        }, 1000);
    },

    componentWillUnmount: function () {
        WlanKeyboardStore.removeListener(this._onChange);
    },

    render: function () {

        var arrowIcon = "\u276F";

        return (
            <div>
                <div className="container">
                    <Header/>
                    <section className="configuration">



                        <div className="configuration__status configuration__status">
                            <div className="configuration__button text__center">
                                 ...
                            </div>
                        </div>

                        <div className="configuration__status">
                            <ConnectionStatus status={this.state.status} className="text__center"/>
                        </div>

                        <div className="configuration__status configuration__status">
                            <div className="configuration__button text__center">
                                sync clipboards
                            </div>
                        </div>
                    </section>

                    <section className="clipboard">

                        <div className="clibparod__input_icon ">
                            ❯
                        </div>

                        <div className="clipboard__input">

                        <input className="clipboard__input_inner" value={this.state.clipboard} readonly="true" placeholder="Copy text into your clipboard">
                        </input>

                        </div>
                    </section>

                    <section className="footer">
                        <div className="lineHead">
                            <a href="https://github.com/abertschi/sailfish-wlan-keyboard">Released under GPL v3</a>
                        </div>
                    </section>

                </div>


            </div>
        );

        /*
         <div className="configuration__button">
         <KeyModeStatus
         keyMode={this.state.keyMode}
         className="configuration__button_layout text__center"/>
         </div>
         */
    },

    _onChange: function () {
        this.setState(this.getStateFromStores());
    },

    _onHeadlessClicked: function (state) {
        var keyMode = state === true ? AppConstants.KeyMode.HEADLESS : AppConstants.KeyMode.CLIPBOARD;
        WlanKeyboardActions.keyModeChanged(keyMode);
    },

    _onClipboardSelected: function (state) {
        var keyMode = state === true ? AppConstants.KeyMode.CLIPBOARD : AppConstants.KeyMode.HEADLESS;
        WlanKeyboardActions.keyModeChanged(keyMode);
    }
});

module.exports = WlanKeyboard;