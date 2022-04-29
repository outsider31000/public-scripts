var type;
var title;
var button;
$(document).ready(function(){
  
    $(".container").hide();    
    $("#container-input").hide();    
    
    window.addEventListener('message', function(event){
        $('#container-input').html('')
        var data = event.data;
        type=data.action;
        title = data.title;
        button = data.button;
        
        if (data.action == "open") {
            $(".container").fadeIn(1000);
            $("#container-input").fadeIn(0);
            $('#container-input').append(
                `<div id="container-input" style="display: none;"></div>
            <h3 style="text-align: center;">${title}</h3>      <input type="text" id="input"/>
            </div>
            `
            );
            $('#submit').text(button)
        }
    });


});

document.onkeyup = function (data) {
    if ((data.which == 13) || (data.which == 27)) { // backspace key
        $(".container").hide();    
        $("#container-input").hide();
        $.post('http://syn_inputs/sendinput', JSON.stringify({input:$("#input").val()}));
    }
};

$("#submit").click(function (event) {
    $(".container").hide();    
    $("#container-input").hide();     
    $.post('http://syn_inputs/sendinput', JSON.stringify({input:$("#input").val()}));
});


