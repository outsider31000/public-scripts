# Inventory System for VORP Core (made in Lua)
> :warning: This is in test phase. If you find some bug, Contact the vorp team on Discord

## Requirements
- [VORP Core](https://github.com/VORPCORE/VORP-Core/releases)
- [VORP Inputs](https://github.com/VORPCORE/VORP-Inputs/releases)
- [VORP Character](https://github.com/VORPCORE/VORP-Character/releases)

## How to install
* Download the lastest version of VORP Inventory
* Copy and paste ```vorp_inventory``` folder to ```resources/vorp_inventory```
* Add ```ensure vorp_inventory``` to your ```server.cfg``` file
* To change the language go to ```resources/vorp_inventory/Config``` and change the default language, also you will have to edit the html file to change the text on the inventory menu
* Now you are ready!

## Features
* Unique weapons in order not to duplicate them.
* Each weapon has its own ammo and can have diferent type of ammo.
* Each weapon has its own modifications.
* When dropping or giving a weapon you give it with all the modifications and ammo.
* It also has usable items.
* KLS.


![image](https://user-images.githubusercontent.com/87246847/156600012-3901dac7-73f8-4577-a8f5-9a60d7e3150b.png)
<img width="354" alt="image" src="https://user-images.githubusercontent.com/87246847/156600211-cc3fc70f-60bb-4884-971a-1d2ad4fdb8ad.png">


## API For Lua
For importing the API on top of your server resource file
```vorpInventory = exports.vorp_inventory:vorp_inventoryApi()```
this will return a table for simply using the inventory
* Uses:
* Quit weapon
``` vorpInventory.subWeapon(source,weaponId)```
* Create and give new Weapon with the name of the weapon in capital letters
``` vorpInventory.addWeapon(source,weaponName)```
* Add an item with quantity
``` vorpInventory.addItem(source,item,cuantity)```
* Sub item with quantity
``` vorpInventory.subItem(source,item,subCuantity)```
* Returns the item quantity
``` vorpInventory.getItemCuantity(source,item)```

## Wiki
[Wiki VORP Inventory](http://docs.vorpcore.com:3000/vorp-inventory)

## Credits

Credits to Vorp Team for creating the C# version
