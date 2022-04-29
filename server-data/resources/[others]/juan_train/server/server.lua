--========================================================================
-- 
-- NOTE: Somewhat unchanged by Juan
-- Taken from : https://github.com/VenomXNL/XNL-FiveM-Trains-U3/
-- Original from:
-- Original Post:	 https://forum.fivem.net/t/release-trains/28841
-- Original Script:  https://github.com/Bluethefurry/FiveM-Trains/releases
--========================================================================

local PlayerCount = 0
local list = {}


RegisterServerEvent("train:playerActivated")
--RegisterServerEvent("playerDropped")

function ActivateTrain ()
	if (PlayerCount) == 1 then
		TriggerClientEvent('Trainroute', GetHostId())
	else
		SetTimeout(15000,ActivateTrain)
	end
end

--snippet from hardcap to make PlayerCount work
-- yes i know i'm lazy
AddEventHandler('train:playerActivated', function()
  if not list[source] then
    PlayerCount = PlayerCount + 1
    list[source] = true
		if (PlayerCount) == 1 then -- new session?
			SetTimeout(15000,ActivateTrain)
		end
  end
end)

AddEventHandler('playerDropped', function()
  if list[source] then
    PlayerCount = PlayerCount - 1
    --print(PlayerCount)
    list[source] = nil
  end
end)

RegisterNetEvent("notify")
AddEventHandler("notify", function(players, coords)
    for each, player in ipairs(players) do
        TriggerEvent("vorp:getCharacter", player, function(user)
            if user ~= nil then
              TriggerClientEvent("Witness:ToggleNotification2", player, coords)
            end
        end)
    end
end)
