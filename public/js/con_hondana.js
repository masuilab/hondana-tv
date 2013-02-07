var io = new CometIO().connect();

io.on("connect", function(session){
  console.log("connect!! "+session);

  $("#btn_up").click(function(){
    io.push("scroll", {y : -100});
  });
  $("#btn_down").click(function(){
    io.push("scroll", {y : 100});
  });
  $("#btn_left").click(function(){
    io.push("scroll", {x : -100});
  });
  $("#btn_right").click(function(){
    io.push("scroll", {x : 100});
  });
  $("#books img.book").click(function(e){
    var url = e.currentTarget.attributes['x-url'].value;
    io.push("go", {url: url});
  });
});

io.on("error", function(err){
  console.error(err);
});
