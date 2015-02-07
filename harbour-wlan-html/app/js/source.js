

var SfKeyboard = function(url) {
  
  var socket = new FancyWebSocket(url);
    
   this.sendKeyCode = function(keycode) {
     console.log(keycode);
    socket.send('new_keycode', keycode);
  };
    
  // sever events
  socket.bind('close', function(data){
   console.log(data.name )
  });
  
  socket.bind('open', function(data){
   console.log('open'.name )
  });
  
};


  