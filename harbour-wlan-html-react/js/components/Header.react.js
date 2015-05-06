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
                         <div className="message__input_icon">❯</div>
                         <TextInput
                            placeholder="Enterd your text"
                            className="message__input"
                            keyMode={this.state.keyMode}/>
                     </div>
                </div>
                    <div className="row">
                        <div className="offset-by-two eight columns config_bar">

                        </div>
                </div>
                </div>
            </section>
        );
    }
});

module.exports = Header;