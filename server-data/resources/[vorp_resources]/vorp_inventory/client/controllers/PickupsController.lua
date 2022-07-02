
RegisterNetEvent("vorpInventory:createPickup")
AddEventHandler("vorpInventory:createPickup", PickupsService.createPickup)

RegisterNetEvent("vorpInventory:createMoneyPickup")
AddEventHandler("vorpInventory:createMoneyPickup", PickupsService.createMoneyPickup)

RegisterNetEvent("vorpInventory:createGoldPickup")
AddEventHandler("vorpInventory:createGoldPickup",PickupsService.createGoldPickup)

RegisterNetEvent("vorpInventory:sharePickupClient")
AddEventHandler("vorpInventory:sharePickupClient", PickupsService.sharePickupClient)

RegisterNetEvent("vorpInventory:shareMoneyPickupClient")
AddEventHandler("vorpInventory:shareMoneyPickupClient", PickupsService.shareMoneyPickupClient)

RegisterNetEvent("vorpInventory:shareGoldPickupClient")
AddEventHandler("vorpInventory:shareGoldPickupClient",PickupsService.shareGoldPickupClient)

RegisterNetEvent("vorpInventory:removePickupClient")
AddEventHandler("vorpInventory:removePickupClient", PickupsService.removePickupClient)

RegisterNetEvent("vorpInventory:playerAnim")
AddEventHandler("vorpInventory:playerAnim", PickupsService.playerAnim)

RegisterNetEvent("vorp:PlayerForceRespawn")
AddEventHandler("vorp:PlayerForceRespawn", PickupsService.DeadActions)