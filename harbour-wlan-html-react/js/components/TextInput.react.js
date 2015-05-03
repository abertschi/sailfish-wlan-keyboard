var React = require('react');
var ReactPropTypes = React.PropTypes;
var AppActions = require('../actions/WlanKeyboardActions');
var WlanKeyboardConstants = require('../constants/WlanKeyboardConstants');

var KEY_ENTER = 13;
var KEY_ARROW_LEFT = 37;
var KEY_ARROW_RIGHT = 39;
var KEY_ARROW_UP = 38;
var KEY_ARROW_DOWN = 40;
var KEY_ARROW_DEL = 8;
var KEY_ARROW_BACK_SPACE = 46;

var TextInput = React.createClass({

    getInitialState: function () {
        return {
            value: this.props.value || '',
            lastValue: ''
        };
    },

    getDefaultProps: function() {
        return {
            keyMode: WlanKeyboardConstants.KeyMode.HEADLESS
        };
    },

    render: function() {
        return (
            <div>
                <input ref="textInput"
                    className={this.props.className}
                    id={this.props.id}
                    placeholder={this.props.placeholder}
                    onKeyUp={this._onTextChange}
                    autoFocus={true}
                />
            </div>
        );
    },

    _onTextChange: function (event) {
        var eventInput = React.findDOMNode(this.refs.textInput);
        this.setState({value: eventInput.value});

        switch (event.keyCode) {

            case KEY_ENTER:
                if (eventInput.value == "") {
                    AppActions.actionEnterKeyPressed();
                }
                else {
                    if (this.props.keyMode == WlanKeyboardConstants.KeyMode.HEADLESS) {
                        AppActions.actionEnterKeyPressed();
                    }
                    else {
                        AppActions.actionNewText(eventInput.value);
                    }
                    eventInput.value= '';
                }
                break;

            case (KEY_ARROW_DEL):
            case (KEY_ARROW_BACK_SPACE):
                AppActions.actionDelKeyPressed();
                break;

            case KEY_ARROW_UP:
                AppActions.actionArrowKeyPressed('up');
                break;

            case KEY_ARROW_DOWN:
                AppActions.actionArrowKeyPressed('down');
                break;

            case KEY_ARROW_LEFT:
                AppActions.actionArrowKeyPressed('left');
                break;

            case KEY_ARROW_RIGHT:
                AppActions.actionArrowKeyPressed('right');
                break;

            default:
                var value = eventInput.value;
                var lastValue = this.state.lastValue;
                if (value != lastValue) {
                    if (value.length > lastValue.length) {
                        var newText = value.substr(lastValue.length);
                        AppActions.actionNewText(newText);
                    }
                }
                break;
        }
        this.setState({value: eventInput.value, lastValue: eventInput.value});
    }
});

module.exports = TextInput;