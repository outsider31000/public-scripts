var ShowPing = false;

$(function() {
    window.addEventListener('message', function(event) {
        var item = event.data;
        var num = event.data.number;
        var buf = $('#wrap');
        if (ShowPing) {
            buf.find('table').append("<tr class=\"heading\"><th width=\"2\">ID</th><th>Name</th><th>Ping</th></tr>");
        } else {
            buf.find('table').append("<tr class=\"heading\"><th>ID</th><th>Name</th></tr>");
        }
        if (item.meta && item.meta == 'close')
        {
            document.getElementById("player_table").innerHTML = "";
            $('#wrap').hide();
            return;
        }
        buf.find('table').append(item.text);
        $('#wrap').show();
        $('#title2').html('')
        $('#title2').append(`<center><h2 id="title2">Players:  ${num}</h2></center>`);
        console.log(num);
    }, false);
    
});

/* 
document.onkeyup = function (data) {
    if ((data.which == 13) || (data.which == 27)) { // backspace key
        document.getElementById("player_table").innerHTML = "";
        $('#wrap').hide();
        $.post('http://syn_scoreboard/closemenu', JSON.stringify());
    }
}; */