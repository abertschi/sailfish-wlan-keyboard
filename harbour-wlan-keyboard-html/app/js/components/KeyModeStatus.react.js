var React = require('react');
var ReactPropTypes = React.PropTypes;
var AppConstants = require('../constants/WlanKeyboardConstants');
var KeyModeStatus = React.createClass({

    render: function () {
        var status = this.props.keyMode == AppConstants.KeyMode.HEADLESS ? "headless" : "clipboard";
        return (
            <div
                className={this.props.className}
            >
                {status}
            </div>
        );
    }
});

module.exports = KeyModeStatus;