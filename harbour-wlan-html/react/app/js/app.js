var app = app || {};

(function () {
    'use strict';

    var wsEndpoint = '__WS_ENDPOINT__';
    var debugCheck = '__WS_' + 'ENDPOINT__';
    if (wsEndpoint == debugCheck) {
        wsEndpoint = 'ws://192.168.1.91:8893';
    }
    var socket = new WebSocketWrapper(wsEndpoint);

    var KEY_ENTER = 13;
    var KEY_ARROW_LEFT = 13;
    var KEY_ARROW_RIGHT = 13;
    var KEY_ARROW_UP = 13;
    var KEY_ARROW_DOWN = 13;
    var KEY_ARROW_DEL = 8;
    var KEY_ARROW_BACK_SPACE = 46;

    var TextInput = React.createClass({
        getInitialState: function() {
            return {
                textStore: ""
            };
        },
        sendActionDel: function() {
            this.props.socket.send('send_key_del', '');
        },
        sendActionNewText: function(text){
            this.props.socket.send('insert_text', text);
        },
        sendActionEnter: function() {
            this.props.socket.send('send_key_enter', '');
        },
        sendActionArrow: function(direction){
            this.props.socket.send('send_key_arrow', direction);
        },

        handleNewText: function (event) {
            console.log("key pressed" + event)
            var text = React.findDOMNode(this.refs.textInput);
            if (event.keyCode == KEY_ENTER) {
                if (text.value === "") {
                    this.sendActionEnter();
                }
                else {
                    this.sendActionNewText(text.value);
                    React.findDOMNode(this.refs.textInput).value = '';
                }
            }
            else if (event.keyCode == KEY_ARROW_DEL || event.keyCode == KEY_ARROW_BACK_SPACE) {
                this.sendActionDel();
            }
            else if (event.keyCode == KEY_ARROW_LEFT) {
               this.sendActionArrow('left');
            }
            else if (event.keyCode == KEY_ARROW_UP) {
                this.sendActionArrow('up');
            }
            else if (event.keyCode == KEY_ARROW_RIGHT) {
                this.sendActionArrow('right');
            }
            else if (event.keyCode == KEY_ARROW_DOWN) {
                this.sendActionArrow('down');
            }
            else {
                var input = text.value;
                var textStore = this.state.textStore;
                if (input !== textStore) {
                    if (input.length > textStore.length) { // text was added not removed
                        var send = input.substr(textStore.length);
                        this.sendActionNewText(send);
                    }
                }
            }

            this.state.textStore = text.value;
        },

        render: function () {
            return (
                <input ref="textInput" className="message__input" onKeyUp={this.handleNewText} placeholder="Enter your text" autoFocus />
            );
        }

    });

    var StatusWidget = React.createClass({
        checkConnectionState: function() {

            var readyStateMsg =
                [[0, 'connecting'],
                [1, 'connected'],
                [2, 'disconnecting'],
                [3, 'not connected']];

            var statusIndex = this.props.socket.getSocket().readyState  || 3;

            var status = readyStateMsg[statusIndex][1];
            this.setState({status: status});
        },
        componentDidMount: function() {
            this.checkConnectionState();
            setInterval(this.checkConnectionState, this.props.statusPollIntervall)
        },
        getInitialState: function() {
            return {
                status: 'not connected'
            };
        },

        getDefaultProps: function() {
            return {
                statusPollIntervall: 1000
            };
        },
        render: function() {
            return(
               <div> Status: {this.state.status} </div>
            );
        }
    });



    React.render(
        <TextInput socket={socket}/>,
        document.getElementById('messageInput')
    );

    React.render(
        <StatusWidget socket={socket}/>,
        document.getElementById('status')
    );


})();