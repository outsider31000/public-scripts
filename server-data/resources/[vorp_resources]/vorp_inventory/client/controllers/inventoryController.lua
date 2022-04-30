RegisterNetEvent("vorpInventory:giveItemsTable")
AddEventHandler("vorpInventory:giveItemsTable", InventoryService.processItems)

RegisterNetEvent("vorpInventory:giveInventory")
AddEventHandler("vorpInventory:giveInventory", InventoryService.getInventory)

RegisterNetEvent("vorpInventory:giveLoadout")
AddEventHandler("vorpInventory:giveLoadout", InventoryService.getLoadout)

RegisterNetEvent("vorp:SelectedCharacter")
AddEventHandler("vorp:SelectedCharacter", InventoryService.onSelectedCharacter)

RegisterNetEvent("vorpInventory:receiveItem")
AddEventHandler("vorpInventory:receiveItem", InventoryService.receiveItem)

RegisterNetEvent("vorpInventory:removeItem")
AddEventHandler("vorpInventory:removeItem", InventoryService.removeItem)

RegisterNetEvent("vorpInventory:receiveWeapon")
AddEventHandler("vorpInventory:receiveWeapon", InventoryService.receiveWeapon)
	