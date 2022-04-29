local diceDisplaying = {}
local displayTime = 8000

Citizen.CreateThread(function()
    local strin = ""

	while true do
		local currentTime, html = GetGameTimer(), ""
		for k, v in pairs(diceDisplaying) do
            
			local player = GetPlayerFromServerId(k)
			if NetworkIsPlayerActive(player) then
			    local sourcePed, targetPed = GetPlayerPed(player), PlayerPedId()
        	    local sourceCoords, targetCoords = GetEntityCoords(sourcePed), GetEntityCoords(targetPed)
        	    local pedCoords = GetPedBoneCoords(sourcePed, 0x2e28, 0.0, 0.0, 0.0)
    
                if player == source or #(sourceCoords - targetCoords) < 10 then
                    local onScreen, xxx, yyy = GetHudScreenPositionFromWorldPosition(pedCoords.x, pedCoords.y, pedCoords.z + 1.2)
                    if not onScreen then
                        if v.type == "dices" then
                            if #v.num > 1 then
                                if #v.num == 2 then
                                    html = html .. "<span style=\"position: absolute; padding-left: 150px; left: ".. xxx * 72 .."%;top: ".. yyy * 100 .."%;\">"
                                elseif #v.num == 3 then
                                    html = html .. "<span style=\"position: absolute; padding-left: 150px; left: ".. xxx * 66 .."%;top: ".. yyy * 100 .."%;\">"
                                end
                                for a, b in pairs(v.num) do
                                    html = html .. "<img \" width=\"75px\" height=\"75px\" src=\"dice_".. b.dicenum ..".png\">"
                                end
                            else
                                html = html .. "<span style=\"position: absolute; left: ".. xxx * 94 .."%;top: ".. yyy * 100 .."%;\">"
                                html = html .. "<img \" width=\"75px\" height=\"75px\" src=\"dice_".. v.num[1].dicenum ..".png\">"    
                            end
                            html = html .. "</img></span>"
                        elseif v.type == "rps" then
                            html = html .. "<span style=\"position: absolute; left: ".. xxx * 94 .."%;top: ".. yyy * 100 .."%;\">"
                            html = html .. "<img \" width=\"75px\" height=\"75px\" src=\"option_".. v.num ..".png\">"    
                            html = html .. "</img></span>"
                        elseif v.type == "coin" then
                            html = html .. "<span style=\"position: absolute; left: ".. xxx * 94 .."%;top: ".. yyy * 100 .."%;\">"
                            html = html .. "<img \" width=\"75px\" height=\"75px\" src=\"coin_".. v.num ..".png\">"    
                            html = html .. "</img></span>"
                        end
                    end
                end
        	end
        	if v.time <= currentTime then
        		diceDisplaying[k] = nil
        	end
        end

        if strin ~= html then
            SendNUIMessage({
                type = true,
                html = html
            })
            strin = html
        end
        
		Wait(0)
    end
end)

RegisterNetEvent("syn_dice:ToggleDisplay")
AddEventHandler("syn_dice:ToggleDisplay", function(playerId, number, typ)
	diceDisplaying[tonumber(playerId)] = {num = number, time = GetGameTimer() + displayTime, type = typ}
end)

RegisterNetEvent("syn_dice:ToggleDiceAnim")
AddEventHandler("syn_dice:ToggleDiceAnim", function()
    TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_PLAYER_PICKUP_WEAPON_THROWN_TOMAHAWK_ANCIENT'), -1, true, false, false, false)
end)

RegisterNetEvent("syn_dice:TogglecoinAnim")
AddEventHandler("syn_dice:TogglecoinAnim", function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),0,0,GetHashKey("KIT_EMOTE_ACTION_COIN_FLIP_1"),1,1,0,0,0)  -- UPPER BODY EMOTE
end)

RegisterNetEvent("syn_dice:TogglerpsAnim")
AddEventHandler("syn_dice:TogglerpsAnim", function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),0,0,GetHashKey("KIT_EMOTE_ACTION_ROCK_PAPER_SCISSORS_1"),1,1,0,0,0)  -- UPPER BODY EMOTE
end)
