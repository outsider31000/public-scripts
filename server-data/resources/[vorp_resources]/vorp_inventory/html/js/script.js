$("document").ready(function () {

    $("#secondInventoryHud").draggable();
    $("#inventoryHud").draggable();

    $("#inventoryHud").hide();
    $("#secondInventoryHud").hide();

    $("body").on("keyup", function (key) {
        if (Config.closeKeys.includes(key.which)) {
            closeInventory();
        }
    });

    initSecondaryInventoryHandlers();
});

window.onload = initDivMouseOver;

window.addEventListener('message', function (event) {

    /*$('body').animate({ opacity: event.data.show ? 1 : 0 }, 500);*/
    
    // if(event.data.action == "updateStatusHud") {

    //     if(event.data.money) {
    //         $("#money-value").text(event.data.money.toFixed(2) + " ").css("color" , "#ffffff");
    //         /*console.log(event.data.money)*/
    //     }

    //     if(event.data.gold) {
    //         $("#gold-value").text(event.data.gold.toFixed(2) + " ").css("color" , "#ffffff");
    //         /*console.log(event.data.gold)*/
    //     }

    //     if(event.data.id) {
    //         $("#id-value").text(event.data.id + "ID ").css("color" , "#ffffff");
    //         /*console.log(event.data.id)*/
    //     }

    // }

    // Initial entry, setup things like locale
    if (event.data.action == "initiate") {
        //BACKHERE
        LANGUAGE = event.data.language
    }
    
    if (event.data.action == "reclabels") {
        ammolabels = event.data.labels
    }

    if (event.data.action == "updateammo") {
        if (event.data.ammo) {
            allplayerammo = event.data.ammo
        }
    }

    if (event.data.action == "updateStatusHud") {

        if (event.data.money || event.data.money === 0) {
            $("#money-value").text(event.data.money.toFixed(2) + " ");

        }
        if (Config.UseGoldItem) {
            if (event.data.gold || event.data.gold === 0) {
                $("#gold-value").text(event.data.gold.toFixed(2) + " ");

            }
        }
        if (event.data.id) {
            $("#id-value").text("ID " + event.data.id);

        }
        
    } else if (event.data.action == "transaction") {
        let t = event.data.type
        if(t == 'started') {
            let displaytext = event.data.text
            $('#loading-text').html(displaytext)
            $('#transaction-loader').show()
        }
        if(t == 'completed') {
            $('#transaction-loader').hide()
        }
    }

    if (event.data.action == "changecheck") {
        checkxy = event.data.check
        infoxy = event.data.info
        $('#check').html('')
        $("#check").append(`<button id='check'>${checkxy}/${infoxy}</button>`);
    }
    if (event.data.action == "display") {
        $("#inventoryHud").fadeIn();
        $(".controls").remove();

        $("#inventoryHud").append(
            `<div class='controls'><div class='controls-center'><input type='text' id='search' placeholder='${LANGUAGE.inventorysearch}'/><button id='check'>${checkxy} / ${infoxy}</button></div><button id='close'>${LANGUAGE.inventoryclose}</button></div></div>`
        );

        $("#search").bind('input', function () {
            searchFor = $("#search").val().toLowerCase();
            $(".item").each(function () {
                label = $(this).data("label").toLowerCase();
                if (label.indexOf(searchFor) < 0) {
                    $(this).hide();
                } else {
                    $(this).show();
                }
            });
        });

        type = event.data.type


        if (event.data.type == "horse") {
            horseid = event.data.horseid;
            initiateSecondaryInventory(horseid, event.data.title, event.data.capacity)
        }

        if (event.data.type == "cart") {
            wagonid = event.data.wagonid;
            initiateSecondaryInventory(wagonid, event.data.title, event.data.capacity)
        }

        if (event.data.type == "house") {
            houseId = event.data.houseId;
            initiateSecondaryInventory(houseId, event.data.title, event.data.capacity)
        }
        if (event.data.type == "hideout") {
            hideoutId = event.data.hideoutId;
            initiateSecondaryInventory(hideoutId, event.data.title, event.data.capacity)
        }
         if (event.data.type == "bank") {
            bankId = event.data.bankId;
            initiateSecondaryInventory(bankId, event.data.title, event.data.capacity)
        }
        if (event.data.type == "clan") {
            clanid = event.data.clanid;
            initiateSecondaryInventory(clanid, event.data.title, event.data.capacity)
        }
        if (event.data.type == "steal") {
            stealid = event.data.stealId;
            initiateSecondaryInventory(stealid, event.data.title, event.data.capacity)
        }
        if (event.data.type == "Container") {
           Containerid = event.data.Containerid;
           initiateSecondaryInventory(Containerid, event.data.title, event.data.capacity)
        }

        disabled = false;

        $(document).on('keydown', function (event) {
            $("#search").focus();
        });

        $("#close").on('click', function (event) {
            closeInventory();
        });
    } else if (event.data.action == "hide") {
        $("#inventoryHud").fadeOut();
        $(".controls").fadeOut();
        $(".site-cm-box").remove();

        $("#secondInventoryHud").fadeOut();
        $(".controls").fadeOut();
        $(".site-cm-box").remove();
        dialog.close();
    } else if (event.data.action == "setItems") {
        inventorySetup(event.data.itemList);

        if (type != "main") {

            $('.item').draggable({
                helper: 'clone',
                appendTo: 'body',
                zIndex: 99999,
                revert: 'invalid',
                start: function (event, ui) {
                    if (disabled) {
                        return false;
                    }


                    itemData = $(this).data("item");
                    itemInventory = $(this).data("inventory");

                    if (itemInventory === "main") {
                        $("#inventoryHud").fadeOut();
                    } else if (itemInventory === "second") {
                        $("#secondInventoryHud").fadeOut();
                    }

                },
                stop: function () {
                    itemData = $(this).data("item");
                    itemInventory = $(this).data("inventory");

                    if (itemInventory === "main") {
                        $("#inventoryHud").fadeIn();
                    } else if (itemInventory === "second") {
                        $("#secondInventoryHud").fadeIn();
                    }


                }
            });
        }

    } else if (event.data.action == "setSecondInventoryItems") {
        secondInventorySetup(event.data.itemList);
        if (secondaryCapacityAvailable == true) {
            // Get how many items are in inventory
            let l = event.data.itemList.length
            let itemlist = event.data.itemList
            let total = 0
            let p = 0
            for (p; p < l; p++) {
                total += Number(itemlist[p].count)
            }
            secondarySetCurrentCapacity(total)
        }
    } else if (event.data.action == "nearPlayers") {
        if (event.data.what == "give") {
            selectPlayerToGive(event.data);
        }
    }
});

//for gold cash and ID
