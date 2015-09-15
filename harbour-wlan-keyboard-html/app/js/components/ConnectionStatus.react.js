var React = require('react');
var ReactPropTypes = React.PropTypes;
var AppActions = require('../actions/WlanKeyboardActions');
var WlanKeyboardConstants = require('../constants/WlanKeyboardConstants');


var ConnectionStatus = React.createClass({

    render: function () {

        var msg;
        if (this.props.status == WlanKeyboardConstants.ConnectionStatus.CONNECTED) {
            msg = "Connected";
        } else {
            msg = "No connection to device";
        }

        return (
            <div className={this.props.className}>{msg}</div>
        );
    }
});

module.exports = ConnectionStatus;