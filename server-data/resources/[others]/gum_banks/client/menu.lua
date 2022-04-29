local keys = { ['G'] = 0x760A9C6F, ["B"] = 0x4CC0E2FE, ['S'] = 0xD27782E3, ['W'] = 0x8FD015D8, ['H'] = 0x24978A28, ['G'] = 0x5415BE48, ["ENTER"] = 0xC7B5340A, ['E'] = 0xDFF812F9, ["J"] = 0xF3830D8E }
local now_bank_money = nil
local now_bank_gold = nil
local now_name = nil
local now_lastname = nil
local now_money = nil
local now_gold = nil
local now_city = nil
local currency = 0
local IsInZone = {}

start_check = function ()
    for k,v in pairs(Banks) do
        if v['Enable'] then
        	IsInZone[k] = false
        end
    end
end
RegisterNetEvent("vorp:SelectedCharacter")
AddEventHandler("vorp:SelectedCharacter", function(charid)
	Citizen.CreateThread(function()
		start_check()
	end)
end)

RegisterNetEvent("vorp:SelectedCharacter")
AddEventHandler("vorp:SelectedCharacter", function(charid)
	Citizen.CreateThread(function()
		while true do
			for k,v in pairs(Banks) do
				optimalization_fix = 5
				if v['Enable'] then
					IsInZone[k] = IsPlayerNearCoords(Banks[k]["Coords"].x, Banks[k]["Coords"].y, Banks[k]["Coords"].z, Banks[k]["Coords"].r)
					if IsInZone[k] then
						DrawText3D(Banks[k]["Coords"].x, Banks[k]["Coords"].y, Banks[k]["Coords"].z, Config.Text_Enter)
						if IsControlJustPressed(0, keys['G']) then
							local closestPlayer, closestDistance = GetClosestPlayer()
							if closestPlayer ~= -1 and closestDistance <= 2.0 then  
								TriggerEvent("vorp:TipRight", Config.Waiting_Text, 2000)
							else
								if now_name ~= nil and now_lastname ~= nil and now_city ~= nil then
									FreezeEntityPosition(PlayerPedId(), true)
									TriggerServerEvent("gum_bank:bank_check", Banks[k]["City_Name"])
									Citizen.Wait(500)
									TriggerEvent("gum_bank:open_bank", _source, Banks[k]["City_Name"], k)
								else
									TriggerEvent("vorp:TipRight", Config.Loading_Text, 2000)
									TriggerServerEvent("gum_bank:bank_check", Banks[k]["City_Name"])
								end
							end
						end
					end
				end
			end
			Citizen.Wait(optimalization_fix)
		end
	end)
end)

RegisterNetEvent("gum_bank:money_state")
AddEventHandler("gum_bank:money_state", function(money_state_dolar,money_state_gold, firstname, lastname, u_city, user_money, user_gold)
	now_bank_money = money_state_dolar
	now_bank_gold = money_state_gold
	now_name = firstname
	now_lastname = lastname
	now_city = u_city
	now_money = user_money
	now_gold = user_gold
end)

RegisterNetEvent("gum_bank:open_bank")
AddEventHandler("gum_bank:open_bank", function(city, k)
	TriggerServerEvent("gum_bank:block_now_using", '1')			
	WarMenu.OpenMenu('bank_menu')
end)


RegisterNetEvent("gum_bank:create_account")
AddEventHandler("gum_bank:create_account", function()
	Citizen.Wait(2000)
	WarMenu.CloseMenu()
	FreezeEntityPosition(PlayerPedId(), false)
end)
RegisterNetEvent("vorp:SelectedCharacter")
AddEventHandler("vorp:SelectedCharacter", function(charid)
	Citizen.CreateThread(function()
		optimalization_fix2 = 5
		WarMenu.CreateMenu('bank_menu', Config.Bank_Book)
		WarMenu.SetSubTitle('bank_menu', Config.Text_Sub)
		while true do
			for k,v in pairs(Banks) do
				if v['Enable'] then
					IsInZone[k] = IsPlayerNearCoords(Banks[k]["Coords"].x, Banks[k]["Coords"].y, Banks[k]["Coords"].z, Banks[k]["Coords"].r)
					if IsInZone[k] then
						local playerPed = PlayerPedId()
						local ped = PlayerPedId()
						local coords = GetEntityCoords(PlayerPedId())
						if WarMenu.IsMenuOpened('bank_menu') then
							if WarMenu.Button(""..Config.City_Text.."~t6~"..now_city.."") then
							end
							if WarMenu.Button(""..Config.Name_Text.."~t6~"..now_name.."") then
							end
							if WarMenu.Button(""..Config.LName_Text.."~t6~"..now_lastname.."") then
							end
							if currency == 0 then
								if WarMenu.Button(""..Config.Money_Text.."~t6~"..now_bank_money.." $") then
									--currency = 1
								end
								if WarMenu.Button("") then
								end

								if WarMenu.Button(Config.Add_Money_To_Bank) then
									TriggerEvent("vorpinputs:getInput", Config.Send_Money_Text, Config.Send_Money_Text1, function(cb)
										local count_money = tonumber(cb)
											if (count_money ~= nil and count_money ~= 0 and count_money > 0) and count_money <= now_money then
											TriggerServerEvent("gum_bank:bank_check", now_city)
											Citizen.Wait(500)
											TriggerServerEvent("gum_bank:update_add_money", tonumber(string.format("%.2f", now_bank_money)), tonumber(string.format("%.2f", count_money)), now_city)
											WarMenu.CloseMenu()
										else
											TriggerEvent("vorp:TipRight", Config.NotCoolValue, 4000)
											WarMenu.CloseMenu()
										end
									end)
								end
								if WarMenu.Button(Config.Take_Money_To_Bank) then
									TriggerEvent("vorpinputs:getInput", Config.Take_Money_From_Bank, Config.Take_Money_From_Bank2, function(cb)
										local count_money2 = tonumber(cb)
										if count_money2 ~= nil and count_money2 ~= 0 and count_money2 >= 0 then
											TriggerServerEvent("gum_bank:bank_check", now_city)
											Citizen.Wait(500)
											TriggerServerEvent("gum_bank:update_remove_money", tonumber(string.format("%.2f", now_bank_money)), tonumber(string.format("%.2f", count_money2)), now_city)
											WarMenu.CloseMenu()
										else
											TriggerEvent("vorp:TipRight", Config.NotCoolValue, 4000)
											WarMenu.CloseMenu()
										end
									end)
								end
							else
								--[[ if WarMenu.Button(""..Config.Gold_Text.."~t6~"..now_bank_gold.." G") then
									currency = 0
								end
								if WarMenu.Button("") then
								end
								if WarMenu.Button(Config.Add_Gold_To_Bank) then
									TriggerEvent("vorpinputs:getInput", Config.Add_Gold_To_Bank2, Config.Add_Gold_To_Bank3, function(cb)
										local count_gold = tonumber(cb)
											if (count_gold ~= nil and count_gold ~= 0 and count_gold > 0) and count_gold <= now_gold then
											TriggerServerEvent("gum_bank:update_add_gold", tonumber(string.format("%.2f", now_bank_gold)), tonumber(string.format("%.2f", count_gold)), now_city)
											WarMenu.CloseMenu()
										else
											TriggerEvent("vorp:TipRight", Config.NotCoolValue, 4000)
											WarMenu.CloseMenu()
										end
									end)
								end
								if WarMenu.Button(Config.Remove_Gold_To_Bank) then
										TriggerEvent("vorpinputs:getInput", Config.Remove_Gold_To_Bank2, Config.Remove_Gold_To_Bank3, function(cb)
										local count_gold2 = tonumber(cb)
										if count_gold2 ~= nil and count_gold2 ~= 0 and count_gold2 >= 0 then
											print(count_gold2)
											TriggerServerEvent("gum_bank:update_remove_gold", tonumber(string.format("%.2f", now_bank_gold)), tonumber(string.format("%.2f", count_gold2)), now_city)
											WarMenu.CloseMenu()
										else
											TriggerEvent("vorp:TipRight", Config.NotCoolValue, 4000)
											WarMenu.CloseMenu()
										end
									end)
								end ]]
							end
							if WarMenu.Button("") then
							end
							if WarMenu.Button(Config.Leave_Bank) then
								WarMenu.CloseMenu()
							end
							WarMenu.Display()
						end
					end
				end
			end
			Citizen.Wait(optimalization_fix2)
		end
	end)
end)

function DrawText3D(x, y, z, text)
	local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
	local px,py,pz=table.unpack(GetGameplayCamCoord())

	SetTextScale(0.35, 0.35)
	SetTextFontForCurrentCommand(6)
	SetTextColor(255, 255, 255, 215)
	local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
	SetTextCentre(1)
	DisplayText(str,_x,_y)
end

function IsPlayerNearCoords(x, y, z, radius)
	local playerx, playery, playerz = table.unpack(GetEntityCoords(PlayerPedId(), 0))
	local distance = GetDistanceBetweenCoords(playerx, playery, playerz, x, y, z, true)
	if distance < radius then
		return true
	end
end

function GetClosestPlayer()
    local players, closestDistance, closestPlayer = GetActivePlayers(), -1, -1
    local playerPed, playerId = PlayerPedId(), PlayerId()
    local coords, usePlayerPed = coords, false
    
    if coords then
        coords = vector3(coords.x, coords.y, coords.z)
    else
        usePlayerPed = true
        coords = GetEntityCoords(playerPed)
    end
    
    for i=1, #players, 1 do
        local tgt = GetPlayerPed(players[i])

        if not usePlayerPed or (usePlayerPed and players[i] ~= playerId) then

            local targetCoords = GetEntityCoords(tgt)
            local distance = #(coords - targetCoords)

            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = players[i]
                closestDistance = distance
            end
        end
    end
    return closestPlayer, closestDistance
end

RegisterNetEvent("vorp:SelectedCharacter")
AddEventHandler("vorp:SelectedCharacter", function(charid)
	Citizen.CreateThread(function()
		for k,v in pairs(Banks) do
			if v['Enable'] then
				local blips = N_0x554d9d53f696d002(1664425300, Banks[k]['Coords'].x, Banks[k]['Coords'].y, Banks[k]['Coords'].z)
				SetBlipSprite(blips, -2128054417, 1)
				SetBlipScale(blips, 1.5)
				Citizen.InvokeNative(0x9CB1A1623062F402, blips, Banks[k]['Blip_Name'])
			end
		end
	end)
end)
