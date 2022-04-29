# redemrp_blueberry
A Blueberry harvesting for RedEM:RP

## 1. Installation
- Be sure you have RedEM , RedEM:RP and Inventory Installed
if not -> [RedEM](https://github.com/kanersps/redem) --> [RedEM:RP](https://github.com/RedEM-RP/redem_roleplay) --> [Inventory](https://github.com/RedEM-RP/redemrp_inventory)
- Clone redemrp_blueberry into [redemrp] folder
- add ```ensure redemrp_blueberry``` after ```ensure redemrp_inventory```
- change Trigger on client side in line 101 to your status/basicneed system
- add this to inventory if you don't have this
there
```
    ["blueberry"] =
    {
        label = "Blueberry",
        description = "?????????",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/blueberry.png",
        type = "item_standard",


    },
    ["stick"] =
    {
        label = "Stick",
        description = "?????????",
        weight = 0.02,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 64,
        imgsrc = "items/stick.png",
        type = "item_standard",


    },
```

## 2.Credits
- https://github.com/ktos93
