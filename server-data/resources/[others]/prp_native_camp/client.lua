villageprops = {}
local all = {}
InVillage = false
InTownBlackwater = false
InMayneMine = false
ThingsSpawned = false
                                
function Createvillage(village, x,y,z,h)
    propvillage = CreateObject(village, x,y,z,h, true)
    --PlaceObjectOnGroundProperly(prop)
    SetEntityRotation(propvillage, 0, 0, h)
    FreezeEntityPosition(propvillage, true)
    table.insert(villageprops, propvillage)

end

Citizen.CreateThread(function()
  while true do
      Citizen.Wait(1)
      local pos = GetEntityCoords(PlayerPedId())
      if not InVillage and (Vdist(pos.x, pos.y, pos.z, 891.38, 298.18, 115.0) < 100.0) and not ThingsSpawned then
          InVillage = true
          if InVillage then
            for k,v in pairs(Config.village) do
              Createvillage(v.propvillage, v.x, v.y, v.z, v.h)
              ThingsSpawned = true 
            end
          end
      end
      if InVillage and (Vdist(pos.x, pos.y, pos.z, 891.38, 298.18, 115.0) > 120.0) and ThingsSpawned then
          InVillage = false
          if not InVillage and ThingsSpawned then
            for k, v in pairs(villageprops) do
                DeleteObject(v)
                ThingsSpawned = false
            end
          end
      end
      if not InTownBlackwater and (Vdist(pos.x, pos.y, pos.z, -802.65, -1311.03, 43.62) < 120.0) and not ThingsSpawned then
        InTownBlackwater = true
          if InTownBlackwater then
            for k,v in pairs(Config.blackwater) do
              Createvillage(v.propvillage, v.x, v.y, v.z, v.h)
              ThingsSpawned = true 
            end
          end
      end
      if InTownBlackwater and (Vdist(pos.x, pos.y, pos.z, -802.65, -1311.03, 43.62) > 140.0) and ThingsSpawned then
        InTownBlackwater = false
          if not InTownBlackwater and ThingsSpawned then
            for k, v in pairs(villageprops) do
                DeleteObject(v)
                ThingsSpawned = false
            end
          end
      end
      if not InMayneMine and (Vdist(pos.x, pos.y, pos.z, -1429.71, 1179.51, 226.4) < 80.0) and not ThingsSpawned then
        InMayneMine = true
          if InMayneMine then
            for k,v in pairs(Config.maynemine) do
              Createvillage(v.propvillage, v.x, v.y, v.z, v.h)
              ThingsSpawned = true 
            end
          end
      end
      if InMayneMine and (Vdist(pos.x, pos.y, pos.z, -1429.71, 1179.51, 226.4) > 100.0) and ThingsSpawned then
        InMayneMine = false
          if not InMayneMine and ThingsSpawned then
            for k, v in pairs(villageprops) do
                DeleteObject(v)
                ThingsSpawned = false
            end
          end
      end
  end
end)

---remove all on resource stop---
AddEventHandler('onResourceStop', function(resource) 
  if resource == GetCurrentResourceName() then
    for k,v in pairs(all) do
        DeleteObject(v)
    end
    for k,v in pairs(villageprops) do
      DeleteObject(v)
    end
  end
end)