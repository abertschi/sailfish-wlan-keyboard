var React = require("react");
var TextInput = require('./TextInput.react');

var WlanKeyboardStore = require('../stores/WlanKeyboardStore');

var Header = React.createClass({

    getStateFromStores: function() {
        return {
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
        return (
            <section className="header">
                <div className="header__title">
                    <h1>sailfish-wlan-keyboard</h1>
                </div>
                <div className="message">
                    <div className="message__input_icon">❯</div>
                    <TextInput
                        placeholder="Enterd your text"
                        className="message__input__textfield"
                        classNameContainer="message__input"
                        keyMode={this.state.keyMode}/>
                </div>
            </section>
        );
    },

    _onChange: function() {
        this.setState(this.getStateFromStores());
    }
});

module.exports = Header;