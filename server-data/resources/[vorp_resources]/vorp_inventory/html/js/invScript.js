function inventorySetup(items) {
    $("#inventoryElement").html("");


    $.each(items, function (index, item) {
        count = item.count;

        if (item.limit > 0) {
            count = count + " / " + item
                .limit; /*   count = count + "" ;   if you want to disable the count max items add this instead. */
        }
        if (item.type != "item_weapon") {
            $("#inventoryElement").append("<div data-label='" + item.label +
            "' style='background-image: url(\"img/items/" + item.name.toLowerCase() +
            ".png\"), url(); background-size: 90px 90px, 90px 90px; background-repeat: no-repeat; background-position: center;' id='item-" +
            index + "' class='item'><div class='count'>" + count +
            "</div><div class='text'></div></div>")
        }else{
            $("#inventoryElement").append("<div data-label='" + item.label +
            "' style='background-image: url(\"img/items/" + item.name.toLowerCase() +
            ".png\"), url(); background-size: 90px 90px, 90px 90px; background-repeat: no-repeat; background-position: center;' id='item-" +
            index + "' class='item'></div></div>")
        }

        $('#item-' + index).data('item', item);
        $('#item-' + index).data('inventory', "main");

        var data = [];
        if (item.used) {
            data.push({
                text: LANGUAGE.unequip,
                action: function () {
                    $.post("http://vorp_inventory/UnequipWeapon", JSON.stringify({
                        item: item.name,
                        id: item.id
                    }));
                }
            })
        }
        if (item.used2) {
            data.push({
                text: LANGUAGE.unequip,
                action: function () {
                    $.post("http://vorp_inventory/UnequipWeapon", JSON.stringify({
                        item: item.name,
                        id: item.id
                    }));
                }
            })
        }
        if (item.usable) {
            data.push({
                text: LANGUAGE.use,
                action: function () {
                    $.post("http://vorp_inventory/UseItem", JSON.stringify({
                        item: item.name,
                        type: item.type,
                        hash: item.hash,
                        amount: item.count,
                        id: item.id
                    }));
                }
            });
        }

        if (item.canRemove) {
            data.push({
                text: LANGUAGE.give,
                action: function () {
                    giveGetHowMany(item.name, item.type, item.hash, item.id);
                }
            });

            data.push({
                text: LANGUAGE.drop,
                action: function () {
                    dropGetHowMany(item.name, item.type, item.hash, item.id);
                }
            });
        }

        if (data.length > 0) {
            $("#item-" + index).contextMenu([data], {
                offsetX: 1,
                offsetY: 1,
            });
        }

        $("#item-" + index).hover(
            function () {
                OverSetTitle(item.label);
            },
            function () {
                OverSetTitle(" ");
            }
        );

        $("#item-" + index).hover(
            function () {
                OverSetDesc(item.desc);
            },
            function () {
                OverSetDesc(" ");
            }
        );

    });

    var gunbelt_item = "gunbelt"
    var gunbelt_label = LANGUAGE.gunbeltlabel
    var gunbelt_desc = LANGUAGE.gunbeltdescription

    $("#inventoryElement").append("<div data-label='" + gunbelt_label +
        "' style='background-image: url(\"img/items/" + gunbelt_item +
        ".png\"), url(); background-size: 90px 90px, 90px 90px; background-repeat: no-repeat; background-position: center;' id='item-" +
        gunbelt_item + "' class='item'><div class='text'></div></div>")
    var data = [];
    
    let empty = true
    if (allplayerammo) {
        for (const [ind, tab] of Object.entries(allplayerammo)) {
            if (tab > 0) {
                empty = false
                data.push({
                    text: `${ammolabels[ind]} : ${tab}`,
                    action: function () {
                        giveammotoplayer(ind);
                    }
                });
            }
        }
    }
    
    if (empty) {
        data.push({
            text: LANGUAGE.empty,
            action: function () {}
        });
    }
    
    
    $("#item-" + gunbelt_item).contextMenu([data], {
        offsetX: 1,
        offsetY: 1,
    });


    $("#item-" + gunbelt_item).hover(
        function() {
            OverSetTitle(gunbelt_label);
        },
        function() {
            OverSetTitle(" ");
        }
    );

    $('#item-' + gunbelt_item).hover(
          function() {
                  OverSetDesc(gunbelt_desc);
          },
          function() {
              OverSetDesc(" ");
          }
      )
    $('#item-' + gunbelt_item).data('item', gunbelt_item);
    $('#item-' + gunbelt_item).data('inventory', "none");

    isOpen = true;
    initDivMouseOver()
    //AddMoney
    var m_item = "money";
    var m_label = LANGUAGE.inventorymoneylabel
    var m_desc = LANGUAGE.inventorymoneydescription


    $("#inventoryElement").append("<div data-label='" + m_label +
        "' style='background-image: url(\"img/items/" + m_item +
        ".png\"), url(); background-size: 90px 90px, 90px 90px; background-repeat: no-repeat; background-position: center;' id='item-" +
        m_item + "' class='item'><div class='text'></div></div>")

    var data = [];

    data.push({
        text: LANGUAGE.givemoney,
        action: function () {
            giveGetHowManyMoney();
        }
    });

    data.push({
        text: LANGUAGE.dropmoney,
        action: function () {
            dropGetHowMany(m_item, "item_money", "asd", 0);
        }
    });



    $("#item-" + m_item).contextMenu([data], {
        offsetX: 1,
        offsetY: 1,
    });
    $("#item-" + m_item).hover(
        function() {
            OverSetTitle(m_item);
        },
        function() {
            OverSetTitle(" ");
        }
    );

    $("#item-" + m_item).hover(
        function () {
            OverSetDesc(m_desc);
        },
        function () {
            OverSetDesc(" ");
        }
    );

    $('#item-' + m_item).data('item', m_item);
    $('#item-' + m_item).data('inventory', "none");

    isOpen = true;
    initDivMouseOver()
    
    if (Config.UseGoldItem) {
          
          //AddGold
          var g_item = "gold";
          var g_label = LANGUAGE.inventorygoldlabel;
          var g_desc = LANGUAGE.inventorygolddescription


          $("#inventoryElement").append("<div data-label='" + g_label +
              "' style='background-image: url(\"img/items/" + g_item +
              ".png\"), url(); background-size: 90px 90px, 90px 90px; background-repeat: no-repeat; background-position: center;' id='item-" +
              g_item + "' class='item'><div class='text'></div></div>")

          var data = [];
          
          data.push({
              text: LANGUAGE.givegold,
              action: function() {
                  giveGetHowManyGold();
              }
          });

          data.push({
              text: LANGUAGE.dropgold,
              action: function() {
                  dropGetHowMany(g_item, "item_gold", "asd", 0);
              }
          });


          $("#item-" + g_item).contextMenu([data], {
              offsetX: 1,
              offsetY: 1,
          });


          $("#item-" + g_item).hover(
              function() {
                  OverSetTitle(g_label);
              },
              function() {
                  OverSetTitle(" ");
              }
          );

          $('#item-' + g_item).hover(
                function() {
                        OverSetDesc(g_desc);
                },
                function() {
                    OverSetDesc(" ");
                }
            );

          $('#item-' + g_item).data('item', g_item);
          $('#item-' + g_item).data('inventory', "none");

          isOpen = true;
          initDivMouseOver()
    }

}