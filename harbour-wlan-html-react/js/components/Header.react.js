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
            <section className="header" >
                <div className="container">
                <div className="row">
                    <div className="column header__title">
                        <h1>sailfish-wlan-keyboard</h1>
                    </div>
                     <div className="offset-by-two eight columns message">
                        <TextInput
                            placeholder="Enter your text"
                            className="message__input"
                            keyMode={this.state.keyMode}/>
                     </div>
                </div>
                </div>
            </section>
        );
    }
});

module.exports = Header;