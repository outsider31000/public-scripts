--[[ local closestLocation

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(2)
      if IsEntityDead(PlayerPedId()) then
        sleep = false
          local coords = GetEntityCoords(PlayerPedId())
          local spawnPoints = Config.spawnPoints[1]
          local minDistance = 2000;
          for k, v in pairs(Config.spawnPoints) do
              local currentCheck = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.x, v.y, v.z, false)
              if currentCheck < minDistance then
                  minDistance = currentCheck
                  closestLocation = Config.spawnPoints[k]
              end
          end
      end
      if sleep then
        Citizen.Wait(1000)
      end
  end
end) ]]

RegisterNetEvent('vorp:PlayerForceRespawn')
AddEventHandler('vorp:PlayerForceRespawn', function()
  TriggerServerEvent('syn_death:delete') 
  --Citizen.Wait(5000)
  --print('TPing to x: ' .. closestLocation.x .. ' y : ' .. closestLocation.y ..'z :'.. closestLocation.z);
  --[[ if closestLocation ~= nil then 
    SetEntityCoords(PlayerPedId(), closestLocation.x, closestLocation.y , closestLocation.z, false)
  end ]]
end)