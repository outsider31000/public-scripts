
RegisterNetEvent("vorpInventory:createPickup")
AddEventHandler("vorpInventory:createPickup", PickupsService.createPickup)

RegisterNetEvent("vorpInventory:createMoneyPickup")
AddEventHandler("vorpInventory:createMoneyPickup", PickupsService.createMoneyPickup)

RegisterNetEvent("vorpInventory:sharePickupClient")
AddEventHandler("vorpInventory:sharePickupClient", PickupsService.sharePickupClient)

RegisterNetEvent("vorpInventory:shareMoneyPickupClient")
AddEventHandler("vorpInventory:shareMoneyPickupClient", PickupsService.shareMoneyPickupClient)

RegisterNetEvent("vorpInventory:removePickupClient")
AddEventHandler("vorpInventory:removePickupClient", PickupsService.removePickupClient)

RegisterNetEvent("vorpInventory:playerAnim")
AddEventHandler("vorpInventory:playerAnim", PickupsService.playerAnim)

RegisterNetEvent("vorp:PlayerForceRespawn")
AddEventHandler("vorp:PlayerForceRespawn", PickupsService.DeadActions)