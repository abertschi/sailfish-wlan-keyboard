"use strict"

var React = require('react');
var WlanKeyboardStore = require('../stores/WlanKeyboardStore');
var Header = require('./Header.react');
var ConnectionStatus = require('./ConnectionStatus.react');
var KeyModeButton = require('./KeyModeButton.react');
var AppConstants = require('../constants/WlanKeyboardConstants');
var WlanKeyboardActions = require('../actions/WlanKeyboardActions');

var WlanKeyboard = React.createClass({

    getStateFromStores: function () {
        return {
            status: WlanKeyboardStore.getConnectionStatus(),
            keyMode: WlanKeyboardStore.getKeyMode()
        };
    },

    getInitialState: function () {
        return this.getStateFromStores();
    },

    componentDidMount: function () {
        WlanKeyboardStore.addChangeListener(this._onChange);
    },

    componentWillUnmount: function () {
        WlanKeyboardStore.removeListener(this._onChange);
    },

    render: function () {


        var isHeadless = this.state.keyMode == AppConstants.KeyMode.HEADLESS;

        return (
            <div>
                <div className="container">
                    <Header/>
                    <section className="configuration">
                        <div className="configuration__button">
                            <KeyModeButton
                                label="headless"
                                onClick={this._onHeadlessClicked}
                                selected={isHeadless}
                                classNameSelected="configuration__button_layout--selected"
                                className="configuration__button_layout text__center"/>
                        </div>
                        <div className="configuration__button">
                            <KeyModeButton
                                label="clipboard"
                                onClick={this._onClipboardSelected}
                                selected={!isHeadless}
                                classNameSelected="configuration__button_layout--selected"
                                className="configuration__button_layout text__center"/>
                        </div>
                        <div className="configuration__status">
                            <ConnectionStatus status={this.state.status} className="text__center"/>
                        </div>


                    </section>


                </div>


            </div>
        );
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