// Websocket client
var sfKeyboard = function() {
};

var sock = new SockJS('ws://localhost:7777');
sock.onopen = function() {
  console.log('open');
}

sock.onmessage = function(e) {
  console.log('message: ', e.data);
}

stock.onclose = function() {
  console.log('close');
}

while(true) {
  sock.send('test');
  console.log('sent');
}

function start() {
  
}