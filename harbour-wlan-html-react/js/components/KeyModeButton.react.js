var React = require('react');
var ReactPropTypes = React.PropTypes;

var KeyModeButton = React.createClass({

    render: function () {

        var classSelected = this.props.selected ? this.props.classNameSelected : "";
        return (
            <div
                className={this.props.className + " " + classSelected}
                onClick={this._onClick}
            >
                {this.props.label}
            </div>
        );
    },

    _onClick: function (event) {
        if (!this.props.selected) {
            this.props.onClick(!this.props.selected);
        }
    }
});

module.exports = KeyModeButton;