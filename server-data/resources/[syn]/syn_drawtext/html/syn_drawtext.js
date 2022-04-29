window.addEventListener("message", function (event) {   
    if (event.data.action == "showNotification") {
        $('#showNotification').html('');
        $('#showNotification').html('<div class="container" style="background: rgba(255,255,255,0.5); border-radius: 5px; position:absolute; right:20px; bottom:500px; min-width:300px; max-width: 300px;"><div class="row"><div class="col-12 p-0 pl-1" id="title"><small>' + event.data.title + '</small></div></div><div class="row"><div class="col-2 text-center p-2 my-auto"><i class="fa-3x ' + event.data.icon + '" id="icon"></i></div><div class="col-10 p-2"><div class="container-fluid"><div class="row"><div class="col-12" id="message"><small>' + event.data.message + '</small></div></div></div></div></div></div>');
        $('#showNotification').css({"display":"flex"});
    }
    else if(event.data.action == "hideNotification") {
        $('#showNotification').css({"display":"none"});
        $('#showNotification').html('');
    }
});