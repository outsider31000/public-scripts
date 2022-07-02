function initSecondaryInventoryHandlers() {
    $('#inventoryElement').droppable({
        drop: function (event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");



            if (type === "horse" && itemInventory === "second") {
                disableInventory(500);
                if (itemData.type != "item_weapon") {
                    dialog.prompt({
                        title: LANGUAGE.prompttitle,
                        button: LANGUAGE.promptaccept,
                        required: true,
                        item: itemData,
                        type: itemData.type,
                        input: {
                            type: "number",
                            autofocus: "true"
                        },

                        validate: function (value, item, type) {
                            if (!value) {
                                dialog.close()
                                return;
                            }

                            if (!isInt(value)) {
                                return;
                            }

                            if (!isValidating) {
                                processEventValidation();
                                $.post("http://vorp_inventory/TakeFromHorse", JSON.stringify({
                                    item: itemData,
                                    type: type,
                                    number: value,
                                    horse: horseid
                                }));
                            }

                        }
                    });
                } else {
                    if (!isValidating) {
                        processEventValidation();
                        $.post("http://vorp_inventory/TakeFromHorse", JSON.stringify({
                            item: itemData,
                            type: itemData.type,
                            number: 1,
                            horse: horseid
                        }));
                    }
                }
            } else if (type === "cart" && itemInventory === "second") {
                disableInventory(500);
                if (itemData.type != "item_weapon") {
                    dialog.prompt({
                        title: LANGUAGE.prompttitle,
                        button: LANGUAGE.promptaccept,
                        required: true,
                        item: itemData,
                        type: itemData.type,
                        input: {
                            type: "number",
                            autofocus: "true"
                        },

                        validate: function (value, item, type) {
                            if (!value) {
                                dialog.close()
                                return;
                            }

                            if (!isInt(value)) {
                                return;
                            }

                            if (!isValidating) {
                                processEventValidation();
                                $.post("http://vorp_inventory/TakeFromCart", JSON.stringify({
                                    item: itemData,
                                    type: type,
                                    wagon: wagonid,
                                    number: value
                                }));
                            }
                        }
                    });
                } else {
                    if (!isValidating) {
                        processEventValidation();
                        $.post("http://vorp_inventory/TakeFromCart", JSON.stringify({
                            item: itemData,
                            type: itemData.type,
                            wagon: wagonid,
                            number: 1
                        }));
                    }
                }
            } else if (type === "house" && itemInventory === "second") {
                disableInventory(500);
                if (itemData.type != "item_weapon") {
                    dialog.prompt({
                        title: LANGUAGE.prompttitle,
                        button: LANGUAGE.promptaccept,
                        required: true,
                        item: itemData,
                        type: itemData.type,
                        input: {
                            type: "number",
                            autofocus: "true"
                        },
                        validate: function (value, item, type) {
                            if (!value) {
                                dialog.close()
                                return;
                            }

                            if (!isInt(value)) {
                                return;
                            }

                            if (!isValidating) {
                                processEventValidation();
                                $.post("http://vorp_inventory/TakeFromHouse", JSON.stringify({
                                    item: itemData,
                                    type: type,
                                    number: value,
                                    house: houseId
                                }));
                            }
                        }
                    });
                } else {
                    if (!isValidating) {
                        processEventValidation();
                        $.post("http://vorp_inventory/TakeFromHouse", JSON.stringify({
                            item: itemData,
                            type: itemData.type,
                            number: 1,
                            house: houseId
                        }));
                    }

                }
            } else if (type === "hideout" && itemInventory === "second") {
                disableInventory(500);
                if (itemData.type != "item_weapon") {
                    dialog.prompt({
                        title: LANGUAGE.prompttitle,
                        button: LANGUAGE.promptaccept,
                        required: true,
                        item: itemData,
                        type: itemData.type,
                        input: {
                            type: "number",
                            autofocus: "true"
                        },
                        validate: function (value, item, type) {
                            if (!value) {
                                dialog.close()
                                return;
                            }

                            if (!isInt(value)) {
                                return;
                            }

                            if (!isValidating) {
                                processEventValidation();
                                $.post("http://vorp_inventory/TakeFromHideout", JSON.stringify({
                                    item: itemData,
                                    type: type,
                                    number: value,
                                    hideout: hideoutId
                                }));
                            }
                        }
                    });
                } else {
                    if (!isValidating) {
                        processEventValidation();
                        $.post("http://vorp_inventory/TakeFromHideout", JSON.stringify({
                            item: itemData,
                            type: itemData.type,
                            number: 1,
                            hideout: hideoutId
                        }));
                    }
                }
            } else if (type === "bank" && itemInventory === "second") {
                disableInventory(500);
                if (itemData.type != "item_weapon") {
                    dialog.prompt({
                        title: LANGUAGE.prompttitle,
                        button: LANGUAGE.promptaccept,
                        required: true,
                        item: itemData,
                        type: itemData.type,
                        input: {
                            type: "number",
                            autofocus: "true"
                        },
                        validate: function (value, item, type) {
                            if (!value) {
                                dialog.close()
                                return;
                            }

                            if (!isInt(value)) {
                                return;
                            }
                            if (!isValidating) {
                                processEventValidation();
                                $.post("http://vorp_inventory/TakeFromBank", JSON.stringify({
                                    item: itemData,
                                    type: type,
                                    number: value,
                                    bank: bankId
                                }));
                            }
                        }
                    });
                } else {
                    if (!isValidating) {
                        processEventValidation();
                        $.post("http://vorp_inventory/TakeFromBank", JSON.stringify({
                            item: itemData,
                            type: itemData.type,
                            number: 1,
                            bank: bankId
                        }));
                    }
                }

            } else if (type === "clan" && itemInventory === "second") {
                disableInventory(500);
                if (itemData.type != "item_weapon") {
                    dialog.prompt({
                        title: LANGUAGE.prompttitle,
                        button: LANGUAGE.promptaccept,
                        required: true,
                        item: itemData,
                        type: itemData.type,
                        input: {
                            type: "number",
                            autofocus: "true"
                        },
                        validate: function (value, item, type) {
                            if (!value) {
                                dialog.close()
                                return;
                            }

                            if (!isInt(value)) {
                                return;
                            }

                            if (!isValidating) {
                                processEventValidation();
                                $.post("http://vorp_inventory/TakeFromClan", JSON.stringify({
                                    item: itemData,
                                    type: type,
                                    number: value,
                                    clan: clanid
                                }));
                            }
                        }
                    });
                } else {
                    if (!isValidating) {
                        processEventValidation();
                        $.post("http://vorp_inventory/TakeFromClan", JSON.stringify({
                            item: itemData,
                            type: itemData.type,
                            number: 1,
                            clan: clanid
                        }));
                    }
                }
            } else if (type === "steal" && itemInventory === "second") {
                disableInventory(500);
                if (itemData.type != "item_weapon") {
                    dialog.prompt({
                        title: LANGUAGE.prompttitle,
                        button: LANGUAGE.promptaccept,
                        required: true,
                        item: itemData,
                        type: itemData.type,
                        input: {
                            type: "number",
                            autofocus: "true"
                        },
                        validate: function (value, item, type) {
                            if (!value) {
                                dialog.close()
                                return;
                            }

                            if (!isInt(value)) {
                                return;
                            }

                            if (!isValidating) {
                                processEventValidation();
                                $.post("http://vorp_inventory/TakeFromsteal", JSON.stringify({
                                    item: itemData,
                                    type: type,
                                    number: value,
                                    steal: stealid
                                }));
                            }
                        }
                    });
                } else {
                    if (!isValidating) {
                        processEventValidation();
                        $.post("http://vorp_inventory/TakeFromsteal", JSON.stringify({
                            item: itemData,
                            type: itemData.type,
                            number: 1,
                            steal: stealid
                        }));
                    }
                }
            } else if (type === "Container" && itemInventory === "second") {
                disableInventory(500);
                if (itemData.type != "item_weapon") {
                    dialog.prompt({
                        title: LANGUAGE.prompttitle,
                        button: LANGUAGE.promptaccept,
                        required: true,
                        item: itemData,
                        type: itemData.type,
                        input: {
                            type: "number",
                            autofocus: "true"
                        },
                        validate: function (value, item, type) {
                            if (!value) {
                                dialog.close()
                                return;
                            }

                            if (!isInt(value)) {
                                return;
                            }

                            if (!isValidating) {
                                processEventValidation();
                                $.post("http://vorp_inventory/TakeFromContainer", JSON.stringify({
                                    item: itemData,
                                    type: type,
                                    number: value,
                                    Container: Containerid
                                }));
                            }
                        }
                    });
                } else {
                    if (!isValidating) {
                        processEventValidation();
                        $.post("http://vorp_inventory/TakeFromContainer", JSON.stringify({
                            item: itemData,
                            type: itemData.type,
                            number: 1,
                            Container: Containerid
                        }));
                    }
                }
            }
        }
    });

    $('#secondInventoryElement').droppable({
        drop: function (event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");


            if (type === "horse" && itemInventory === "main") {
                disableInventory(500);
                if (itemData.type != "item_weapon") {
                    dialog.prompt({
                        title: LANGUAGE.prompttitle,
                        button: LANGUAGE.promptaccept,
                        required: true,
                        item: itemData,
                        type: itemData.type,
                        input: {
                            type: "number",
                            autofocus: "true"
                        },
                        validate: function (value, item, type) {
                            if (!value) {
                                dialog.close()
                                return;
                            }

                            if (!isInt(value)) {
                                return;
                            }

                            if (!isValidating) {
                                processEventValidation();
                                $.post("http://vorp_inventory/MoveToHorse", JSON.stringify({
                                    item: itemData,
                                    type: type,
                                    number: value,
                                    horse: horseid
                                }));
                            }
                        }
                    });
                } else {
                    if (!isValidating) {
                        processEventValidation();
                        $.post("http://vorp_inventory/MoveToHorse", JSON.stringify({
                            item: itemData,
                            type: itemData.type,
                            number: 1,
                            horse: horseid
                        }));
                    }

                }

            } else if (type === "cart" && itemInventory === "main") {
                disableInventory(500);
                if (itemData.type != "item_weapon") {
                    dialog.prompt({
                        title: LANGUAGE.prompttitle,
                        button: LANGUAGE.promptaccept,
                        required: true,
                        item: itemData,
                        type: itemData.type,
                        input: {
                            type: "number",
                            autofocus: "true"
                        },
                        validate: function (value, item, type) {
                            if (!value) {
                                dialog.close()
                                return;
                            }

                            if (!isInt(value)) {
                                return;
                            }

                            if (!isValidating) {
                                processEventValidation();
                                $.post("http://vorp_inventory/MoveToCart", JSON.stringify({
                                    item: itemData,
                                    type: type,
                                    wagon: wagonid,
                                    number: value
                                }));
                            }
                        }
                    });
                } else {
                    if (!isValidating) {
                        processEventValidation();
                        $.post("http://vorp_inventory/MoveToCart", JSON.stringify({
                            item: itemData,
                            type: itemData.type,
                            wagon: wagonid,
                            number: 1
                        }));
                    }
                }

            } else if (type === "house" && itemInventory === "main") {
                disableInventory(500);
                if (itemData.type != "item_weapon") {
                    dialog.prompt({
                        title: LANGUAGE.prompttitle,
                        button: LANGUAGE.promptaccept,
                        required: true,
                        item: itemData,
                        type: itemData.type,
                        input: {
                            type: "number",
                            autofocus: "true"
                        },
                        validate: function (value, item, type) {
                            if (!value) {
                                dialog.close()
                                return;
                            }

                            if (!isInt(value)) {
                                return;
                            }
                            if (!isValidating) {
                                processEventValidation();
                                $.post("http://vorp_inventory/MoveToHouse", JSON.stringify({
                                    item: itemData,
                                    type: type,
                                    number: value,
                                    house: houseId
                                }));
                            }
                        }
                    });
                } else {
                    if (!isValidating) {
                        processEventValidation();
                        $.post("http://vorp_inventory/MoveToHouse", JSON.stringify({
                            item: itemData,
                            type: itemData.type,
                            number: 1,
                            house: houseId
                        }));
                    }
                }
            } else if (type === "hideout" && itemInventory === "main") {
                disableInventory(500);
                if (itemData.type != "item_weapon") {
                    dialog.prompt({
                        title: LANGUAGE.prompttitle,
                        button: LANGUAGE.promptaccept,
                        required: true,
                        item: itemData,
                        type: itemData.type,
                        input: {
                            type: "number",
                            autofocus: "true"
                        },
                        validate: function (value, item, type) {
                            if (!value) {
                                dialog.close()
                                return;
                            }

                            if (!isInt(value)) {
                                return;
                            }

                            if (!isValidating) {
                                processEventValidation();
                                $.post("http://vorp_inventory/MoveToHideout", JSON.stringify({
                                    item: itemData,
                                    type: type,
                                    number: value,
                                    hideout: hideoutId
                                }));
                            }
                        }
                    });
                } else {
                    if (!isValidating) {
                        processEventValidation();
                        $.post("http://vorp_inventory/MoveToHideout", JSON.stringify({
                            item: itemData,
                            type: itemData.type,
                            number: 1,
                            hideout: hideoutId
                        }));
                    }
                }
            } else if (type === "bank" && itemInventory === "main") {
                disableInventory(500);
                if (itemData.type != "item_weapon") {
                    dialog.prompt({
                        title: LANGUAGE.prompttitle,
                        button: LANGUAGE.promptaccept,
                        required: true,
                        item: itemData,
                        type: itemData.type,
                        input: {
                            type: "number",
                            autofocus: "true"
                        },
                        validate: function (value, item, type) {
                            if (!value) {
                                dialog.close()
                                return;
                            }


                            if (!isInt(value)) {
                                return;
                            }

                            if (!isValidating) {
                                processEventValidation();
                                $.post("http://vorp_inventory/MoveToBank", JSON.stringify({
                                    item: itemData,
                                    type: type,
                                    number: value,
                                    bank: bankId
                                }));
                            }
                        }
                    });
                } else {
                    if (!isValidating) {
                        processEventValidation();
                        $.post("http://vorp_inventory/MoveToBank", JSON.stringify({
                            item: itemData,
                            type: itemData.type,
                            number: 1,
                            bank: bankId
                        }));
                    }
                }
            } else if (type === "clan" && itemInventory === "main") {
                disableInventory(500);
                if (itemData.type != "item_weapon") {
                    dialog.prompt({
                        title: LANGUAGE.prompttitle,
                        button: LANGUAGE.promptaccept,
                        required: true,
                        item: itemData,
                        type: itemData.type,
                        input: {
                            type: "number",
                            autofocus: "true"
                        },
                        validate: function (value, item, type) {
                            if (!value) {
                                dialog.close()
                                return;
                            }

                            if (!isInt(value)) {
                                return;
                            }

                            if (!isValidating) {
                                processEventValidation();
                                $.post("http://vorp_inventory/MoveToClan", JSON.stringify({
                                    item: itemData,
                                    type: type,
                                    number: value,
                                    clan: clanid
                                }));
                            }
                        }
                    });
                } else {
                    if (!isValidating) {
                        processEventValidation();
                        $.post("http://vorp_inventory/MoveToClan", JSON.stringify({
                            item: itemData,
                            type: itemData.type,
                            number: 1,
                            clan: clanid
                        }));
                    }
                }

            } else if (type === "steal" && itemInventory === "main") {
                disableInventory(500);
                if (itemData.type != "item_weapon") {
                    dialog.prompt({
                        title: LANGUAGE.prompttitle,
                        button: LANGUAGE.promptaccept,
                        required: true,
                        item: itemData,
                        type: itemData.type,
                        input: {
                            type: "number",
                            autofocus: "true"
                        },
                        validate: function (value, item, type) {
                            if (!value) {
                                dialog.close()
                                return;
                            }

                            if (!isInt(value)) {
                                return;
                            }

                            if (!isValidating) {
                                processEventValidation();
                                $.post("http://vorp_inventory/MoveTosteal", JSON.stringify({
                                    item: itemData,
                                    type: type,
                                    number: value,
                                    steal: stealid
                                }));
                            }
                        }
                    });
                } else {
                    if (!isValidating) {
                        processEventValidation();
                        $.post("http://vorp_inventory/MoveTosteal", JSON.stringify({
                            item: itemData,
                            type: itemData.type,
                            number: 1,
                            steal: stealid
                        }));
                    }
                }

            } else if (type === "Container" && itemInventory === "main") {
                disableInventory(500);
                if (itemData.type != "item_weapon") {
                    dialog.prompt({
                        title: LANGUAGE.prompttitle,
                        button: LANGUAGE.promptaccept,
                        required: true,
                        item: itemData,
                        type: itemData.type,
                        input: {
                            type: "number",
                            autofocus: "true"
                        },
                        validate: function (value, item, type) {
                            if (!value) {
                                dialog.close()
                                return;
                            }

                            if (!isInt(value)) {
                                return;
                            }

                            if (!isValidating) {
                                processEventValidation();
                                $.post("http://vorp_inventory/MoveToContainer", JSON.stringify({
                                    item: itemData,
                                    type: type,
                                    number: value,
                                    Container: Containerid
                                }));
                            }
                        }
                    });
                } else {
                    if (!isValidating) {
                        processEventValidation();
                        $.post("http://vorp_inventory/MoveToContainer", JSON.stringify({
                            item: itemData,
                            type: itemData.type,
                            number: 1,
                            Container: Containerid
                        }));
                    }
                }

            }
        }
    });
}

function secondInventorySetup(items) {
    $("#inventoryElement").html("");
    $("#secondInventoryElement").html("");

    $.each(items, function (index, item) {
        count = item.count;

        $("#secondInventoryElement").append("<div data-label='" + item.label +
            "' style='background-image: url(\"img/items/" + item.name.toLowerCase() +
            ".png\"), url(); background-size: 90px 90px, 90px 90px; background-repeat: no-repeat; background-position: center;' id='item-" +
            index + "' class='item'><div class='count'>" + count +
            "</div><div class='text'></div></div>")
        $('#item-' + index).data('item', item);
        $('#item-' + index).data('inventory', "second");

        $("#item-" + index).hover(
            function () {
                OverSetTitleSecond(item.label);
            },
            function () {
                OverSetTitleSecond(" ");
            },
            function () {
                OverSetDesc(item.desc);
            },
            function () {
                OverSetDesc(" ");
            }
        );

    });
}
