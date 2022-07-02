# Inventory in Lua System for VORPCore framework

## Requirements
- [VORP_Core](https://github.com/VORPCORE/vorp-core-lua)
- [VORP Inputs](https://github.com/VORPCORE/vorp_inputs-lua)

## How to install
* Download the lastest version of VORP Inventory
* Copy and paste ```vorp_inventory``` folder to ```resources/vorp_inventory```
* Add ```ensure vorp_inventory``` to your ```resource.cfg``` file
* To change the language go to ```resources/vorp_inventory/Config``` and change the default language, also you will have to edit the html file to change the text on the inventory menu


## Features
* Unique weapons in order not to duplicate them.
* Each weapon has its own ammo and can have diferent type of ammo.
* give ammo from your belt
* When dropping or giving a weapon you give it with all the modifications and ammo.
* It also has usable items.
* KLS.


![image](https://user-images.githubusercontent.com/87246847/156600012-3901dac7-73f8-4577-a8f5-9a60d7e3150b.png)
<img width="354" alt="image" src="https://user-images.githubusercontent.com/87246847/156600211-cc3fc70f-60bb-4884-971a-1d2ad4fdb8ad.png">
<img width="286" alt="image" src="https://user-images.githubusercontent.com/87246847/176539805-57997f6d-967d-4341-bdf6-cf88f2277a0f.png">

## Extra Features
* All features from vorp_inventory_lua 1.0.7
* Description of all items in DB
* Gold item like Dollars (You can give and drop item)
- You can choose if using Gold like Dollars in config.lua and config.js
- Added descriptions of each item in inventory, for items (desc is in DB), for weapons (desc is in config.lua), for dollars and gold (desc are in html)


## Wiki
[Wiki VORP Inventory](http://docs.vorpcore.com:3000/vorp-inventory)

## Credits
- To [Val3ro](https://github.com/Val3ro) for the initial work.
- to [Emolitt](https://github.com/RomainJolidon) and [Outsider](https://github.com/outsider31000) for finishing/testing.   
- Credits to Vorp Team for creating the C# version and [Local9](https://github.com/Local9).
