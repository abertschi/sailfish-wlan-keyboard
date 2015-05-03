var React = require("react");
var TextInput = require('./TextInput.react');
var WlanKeyboardStore = require('../stores/WlanKeyboardStore');

var Header = React.createClass({

    getInitialState: function () {
        return {
            keyMode: WlanKeyboardStore.getKeyMode()
        };
    },

    render: function () {
        return (
            <div>
                <h1>sailfish-wlan-keyboard</h1>
                <TextInput
                    placeholder="Enter your text"
                    keyMode={this.state.keyMode}/>
            </div>
        );
    }
});

module.exports = Header;