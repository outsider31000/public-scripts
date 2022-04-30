window.addEventListener('message', function (event) {

    /*$('body').animate({ opacity: event.data.show ? 1 : 0 }, 500);*/
    
    if(event.data.action == "updateStatusHud") {

        if(event.data.money) {
            $("#money-value").text(event.data.money.toFixed(2) + " ").css("color" , "#ffffff");
            /*console.log(event.data.money)*/
        }

        if(event.data.gold) {
            $("#gold-value").text(event.data.gold.toFixed(2) + " ").css("color" , "#ffffff");
            /*console.log(event.data.gold)*/
        }

        if(event.data.id) {
            $("#id-value").text(event.data.id + "ID ").css("color" , "#ffffff");
            /*console.log(event.data.id)*/
        }

    }
});

//for gold cash and ID
