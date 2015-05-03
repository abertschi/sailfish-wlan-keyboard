"use strict"

var React = require('react');
var WlanKeyboardStore = require('../stores/WlanKeyboardStore');
var Header = require('./Header.react');

var WlanKeyboard = React.createClass({

    getInitialState: function() {
        return {};
    },

    getDefaultProps: function() {
        return {};
    },

    componentDidMount: function() {

    },

    componentWillMount: function() {

    },

    render: function() {

        return(
            <div>
                <Header/>
            </div>
        );
    }
});

module.exports = WlanKeyboard;