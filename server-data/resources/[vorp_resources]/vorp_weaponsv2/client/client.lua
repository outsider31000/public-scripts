local _, wepHash
local compss = {}
local elements = {}
local wep
local added = {}
local weaponid
local globalhash
local comps = {}
local sum = 0
local wepobject
local createdobject = false
local h
local roll
local pricing = {}
local playerjob
local playerrank
local crafting = false
local craftingammoitem
local craftingammoitem2
local itemtosend
local materialtosend
local cal = false
local modelz = false
local next = next 
local craftingwepitem
local craftingwepitem2
local inshop = false
local currentshop
local itemprice
local itemlabel
local category
local itemtobuy
local blip
local label 
local prompts = GetRandomIntInRange(0, 0xffffff)

RegisterNetEvent("vorp_weapons:removeallammo") -- new event 
AddEventHandler("vorp_weapons:removeallammo", function()
	TriggerServerEvent("syn_weapons:removeallammoserver")
	Citizen.InvokeNative(0xF25DF915FA38C5F3,PlayerPedId(),1,1)
	Citizen.InvokeNative(0x1B83C0DEEBCBB214,PlayerPedId())
end)

function RemoveWeaponComponentFromPed(ped, componentHash, weaponHash)
	return Citizen.InvokeNative(0x19F70C4D80494FF8, ped, componentHash, weaponHash)
end

function GiveWeaponComponentToEntity(entity, componentHash, weaponHash, p3)
	return Citizen.InvokeNative(0x74C9090FDD1BB48E, entity, componentHash, weaponHash, p3)
end

function shuffle(tbl)
	for i = #tbl, 2, -1 do
		local j = math.random(i)
		tbl[i], tbl[j] = tbl[j], tbl[i]
	end
	return tbl
end

function LoadModel(model)
	if not IsModelInCdimage(model) then
		return false
	end

	RequestModel(model)

	while not HasModelLoaded(model) do
		Wait(0)
	end

	return true
end

Citizen.CreateThread(function()
    Citizen.Wait(5000)
    local str = Config2.Language.openmenu
	openmenu = PromptRegisterBegin()
	PromptSetControlAction(openmenu, Config.keys["G"])
	str = CreateVarString(10, 'LITERAL_STRING', str)
	PromptSetText(openmenu, str)
	PromptSetEnabled(openmenu, 1)
	PromptSetVisible(openmenu, 1)
	PromptSetStandardMode(openmenu,1)
    PromptSetHoldMode(openmenu, 1)
	PromptSetGroup(openmenu, prompts)
	Citizen.InvokeNative(0xC5F428EE08FA7F2C,openmenu,true)
	PromptRegisterEnd(openmenu)
end)

RegisterNetEvent("vorp:SelectedCharacter")
AddEventHandler("vorp:SelectedCharacter", function(charid)
	TriggerServerEvent("syn_weapons:removeused")
	TriggerEvent("syn_weapons:initalizing")
	Citizen.Wait(1000)
	RemoveAllPedWeapons(PlayerPedId(),true,true)
end)


function makeEntityFaceEntity(entity)
	local p2 = GetEntityCoords(entity, true)
	local p1 = GetEntityCoords(PlayerPedId(), true)
	local dx = p2.x - p1.x
	local dy = p2.y - p1.y
	local heading = GetHeadingFromVector_2d(dx, dy)
    SetEntityHeading( PlayerPedId(), heading )
end
function playanim(anim,msg)
	local playerPed = PlayerPedId()
	TaskStartScenarioInPlace(playerPed, GetHashKey(anim), 20000, true, false, false, false)
	exports['progressBars']:startUI(20000, msg)
	Citizen.Wait(20000)
	ClearPedTasksImmediately(PlayerPedId())
end

RegisterNetEvent("syn_weapons:itemcheckpassed")
AddEventHandler("syn_weapons:itemcheckpassed", function(item)
	playanim("WORLD_HUMAN_CROUCH_INSPECT",Config2.Language.craftingloading)
	TriggerServerEvent("syn_weapons:givebackbox",item)
	crafting = false
	craftingammoitem = nil
 	craftingammoitem2 = nil
 	itemtosend = nil
 	materialtosend = nil
	FreezeEntityPosition(PlayerPedId(),false)
end)
RegisterNetEvent("syn_weapons:itemcheckpassed2")
AddEventHandler("syn_weapons:itemcheckpassed2", function(item,label)
	playanim(Config.craftinganimations,Config2.Language.craftingloading)
	TriggerServerEvent("syn_weapons:givebackbox2",item,label)
	crafting = false
	craftingammoitem = nil
 	craftingammoitem2 = nil
 	itemtosend = nil
 	materialtosend = nil
	FreezeEntityPosition(PlayerPedId(),false)
end)

RegisterNetEvent("syn_weapons:itemcheckfailed")
AddEventHandler("syn_weapons:itemcheckfailed", function()
	crafting = false
	craftingammoitem = nil
 	craftingammoitem2 = nil
 	itemtosend = nil
 	materialtosend = nil
	FreezeEntityPosition(PlayerPedId(),false)
end)

RegisterNetEvent("syn_weapons:applymods")
AddEventHandler("syn_weapons:applymods", function()
	makeEntityFaceEntity(wepobject)
	playanim(Config.customizationanimation,Config2.Language.customloading)
	TriggerServerEvent("syn_weapons:addcomp",weaponid,added)
	for k,v in pairs(compss) do
		RemoveWeaponComponentFromPed(PlayerPedId(), v.name, globalhash)
	end
	for i = 1, #added do
		if added[i].model ~= 0 then
			LoadModel(added[i].model)
		end
		GiveWeaponComponentToEntity(PlayerPedId(), added[i].name, globalhash, true)
		if added[i].model ~= 0 then
			SetModelAsNoLongerNeeded(added[i].model)
		end
	end 
	createdobject = false
	FreezeEntityPosition(PlayerPedId(),false)
	DeleteEntity(wepobject)
	added = {}
	wephash = nil
	compss = {}
	globalhash = nil
	weaponid = nil
end)

RegisterNetEvent("syn_weapons:nomods")
AddEventHandler("syn_weapons:nomods", function()
	createdobject = false
	DeleteEntity(wepobject)
	FreezeEntityPosition(PlayerPedId(),false)
	added = {}
	wephash = nil
	compss = {}
	globalhash = nil
	weaponid = nil
end)

RegisterNetEvent("syn_weapons:findjob")
AddEventHandler("syn_weapons:findjob", function(job,rank)
	playerjob = job
	playerrank = rank
end)

AddEventHandler(
    "onResourceStart",
    function(resourceName)
        if resourceName == GetCurrentResourceName() then
			TriggerServerEvent("syn_weapons:removeused")
			TriggerEvent("syn_weapons:initalizing")
			TriggerServerEvent("syn_weapons:cleanup")
			--RemoveAllPedWeapons(PlayerPedId(),true,true)
        end
    end
)

function contains(table, element,element2)
	for k, v in pairs(table) do

        if v.comp == element and v.type == element2 then
        	return true
		end
    end
return false
end
function contains2(table, element)
	for k, v in pairs(table) do

        if v.comp == element then
        	return true
		end
    end
return false
end
function jobcheck(table, element)
	for k, v in pairs(table) do
        if v == element then
        	return true
		end
    end
return false
end
RegisterNetEvent("syn_weapons:initalizing") 
AddEventHandler("syn_weapons:initalizing", function()
	comps = json.decode(LoadResourceFile(GetCurrentResourceName(), 'wepcomps.json'))
	Citizen.Wait(2000)
	for k,v in pairs(comps) do 
		for x,l in pairs(v) do 
			if l.confirmed == 1 then
				if l.comp == "variant" then
					l.price = Config.price.variant
				elseif l.comp == "gripbody" then
					l.price = Config.price.griptype
				elseif l.comp == "grip" then
					l.price = Config.price.gripdecal
				elseif l.comp == "decal" then
					if l.type == "cylinder" then
						l.price = Config.price.decalextra
					elseif l.type == "frame" then 
						l.price = Config.price.decalframe
					elseif l.type == "barrel" then 
						l.price = Config.price.decalbarrel
					end
				elseif l.comp == "wrapcolor" then
					l.price = Config.price.wrapcolor
				elseif l.comp == "comp" then
					if l.type == "scope" then
						l.price = Config.price.sight
					elseif l.type == "rifling" then 
						l.price = Config.price.rifling
					elseif l.type == "other" then 
						l.price = Config.price.barrel
					elseif l.type == "wrap" then 
						l.price = Config.price.wrap
					end
				elseif l.comp == "barrel" or l.comp == "trigger" or l.comp == "cylinder" or l.comp == "frontsight" or l.comp == "frame" or l.comp == "scope" then
					if l.label == "Gold" then
						l.price = Config.price.gold
					elseif l.label == "Silver" then
						l.price = Config.price.silver
					elseif l.label == "Blued Steel" then
						l.price = Config.price.bluesteel
					elseif l.label == "Browned Steel" then
						l.price = Config.price.brownsteel
					elseif l.label == "Blackened Steel" then
						l.price = Config.price.blacksteel
					elseif l.label == "Copper" then
						l.price = Config.price.copper
					elseif l.label == "Nickel" then
						l.price = Config.price.nickle
					elseif l.label == "Brass" then
						l.price = Config.price.brass
					elseif l.label == "Iron" then
						l.price = Config.price.iron
					end
				elseif l.comp == "decalcolor" then
					if l.label == "Gold" then
						l.price = Config.price.gold
					elseif l.label == "Silver" then
						l.price = Config.price.silver
					elseif l.label == "Blued Steel" then
						l.price = Config.price.bluesteel
					elseif l.label == "Browned Steel" then
						l.price = Config.price.brownsteel
					elseif l.label == "Blackened Steel" then
						l.price = Config.price.blacksteel
					elseif l.label == "Copper" then
						l.price = Config.price.copper
					elseif l.label == "Nickel" then
						l.price = Config.price.nickle
					elseif l.label == "Brass" then
						l.price = Config.price.brass
					elseif l.label == "Iron" then
						l.price = Config.price.iron
					end

				end
			end
		end
	end
end)

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
                playerid = GetPlayerServerId(players[i])
                tgt1 = GetPlayerPed(players[i])
            end
        end
    end
    return closestPlayer, closestDistance,  playerid, tgt1
end

function DrawText3D(x, y, z, text)
	local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
	local px,py,pz=table.unpack(GetGameplayCamCoord())  
	local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
	local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
	if onScreen then
	  SetTextScale(0.30, 0.30)
	  SetTextFontForCurrentCommand(1)
	  SetTextColor(255, 255, 255, 215)
	  SetTextCentre(1)
	  DisplayText(str,_x,_y)
	  local factor = (string.len(text)) / 225
	  DrawSprite("feeds", "hud_menu_4a", _x, _y+0.0125,0.015+ factor, 0.03, 0.1, 35, 35, 35, 190, 0)
	end
end 
AddEventHandler(
    "onResourceStop",
    function(resourceName)
		if GetCurrentResourceName() == resourceName then
			FreezeEntityPosition(PlayerPedId(),false)
			RemoveBlip(blip)
			if createdobject then
				DeleteEntity(wepobject)
			end
        end
    end
)

function drawtext(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str, Citizen.ResultAsLong())
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    if enableShadow then 
        SetTextDropshadow(1, 0, 0, 0, 255)
    end
    Citizen.InvokeNative(0xADA9255D, 10);
    DisplayText(str, x, y)
end

function createobject(x, y, z, objecthash)
	if not createdobject then
		wepobject = Citizen.InvokeNative(0x9888652B8BA77F73 , objecthash, 0,x,y,z,true,1.0)
		h = GetEntityHeading(wepobject)
		local tabley = GetEntityRotation(wepobject,1)
		local x,y,z = table.unpack(tabley)
		roll = x
		if next(added)~= nil then
			for k,v in pairs(compss) do
				RemoveWeaponComponentFromWeaponObject(wepobject, v.name)
			end
			for i = 1, #added do
				if added[i].model ~= 0 then
					LoadModel(added[i].model)
				end
				GiveWeaponComponentToEntity(wepobject, added[i].name, -1, true)
				if added[i].model ~= 0 then
					SetModelAsNoLongerNeeded(added[i].model)
				end
			end 
		end
		createdobject = true
	end
end  

Citizen.CreateThread(function() 
    while true do 
        Citizen.Wait(0)
        local sleep = true
		if createdobject then
			drawtext(Config2.Language.rotateitem1, 0.25, 0.74, 0.3, 0.2, true, 255, 255, 255, 255, true, 10000)
			drawtext(Config2.Language.rotateitem2, 0.25, 0.76, 0.3, 0.2, true, 255, 255, 255, 255, true, 10000)
			drawtext(Config2.Language.rotateitem3, 0.25, 0.78, 0.3, 0.2, true, 255, 255, 255, 255, true, 10000)
			drawtext(Config2.Language.rotateitem4, 0.25, 0.80, 0.3, 0.2, true, 255, 255, 255, 255, true, 10000)
			HasStreamedTextureDictLoaded("menu_textures")
			DrawSprite("menu_textures", "translate_bg_1a", 0.25, 0.78, 0.14, 0.12, 1.8, 0, 0, 0, 255, 1)
			if whenKeyJustPressed(Config.keys["1"]) then
				h = h + 10
				SetEntityRotation(wepobject,roll % 360,0,h % 360,1,true)
			end
			if whenKeyJustPressed(Config.keys["2"]) then
				h = h - 10
				SetEntityRotation(wepobject,roll % 360,0,h % 360,1,true)
			end
			if whenKeyJustPressed(Config.keys["3"]) then
				roll = roll - 20
				SetEntityRotation(wepobject,roll % 360,0,h % 360,1,true)
			end
			if whenKeyJustPressed(Config.keys["4"]) then
				roll = roll + 20
				SetEntityRotation(wepobject,roll % 360,0,h % 360,1,true)
			end
			
		end
	end
end)

Citizen.CreateThread(function()
    while true do
	  Citizen.Wait(0)
	  	if not createdobject and not crafting  and not inshop then
      		local coords, letSleep = GetEntityCoords(PlayerPedId()), true
	  		for k, v in pairs(Config.customizationLocations) do
				local dist = GetDistanceBetweenCoords(coords.x,coords.y,coords.z, v.Pos.x,v.Pos.y,v.Pos.z, 1)
				if dist < 1 then
					letSleep = false  
        		   		--DrawText3D(v.Pos.x, v.Pos.y, v.Pos.z, Config2.Language.presstobuy)

						   local label  = CreateVarString(10, 'LITERAL_STRING', Config2.Language.presstobuy)
						   PromptSetActiveGroupThisFrame(prompts, label)
						if Citizen.InvokeNative(0xC92AC953F0A982AE,openmenu) then
							print(weaponid)
							if Config.jobonly then
								TriggerServerEvent("syn_weapons:getjob")
								Citizen.Wait(400)
								if jobcheck(Config.job, playerjob) and tonumber(playerrank) >= Config.jobrankcustomization then
									local closestPlayer, closestDistance, playerid, tgt1 = GetClosestPlayer()
        		   	    			if closestPlayer ~= -1 and closestDistance <= 2.0 then
        		   	    			    TriggerEvent("vorp:TipBottom", Config2.Language.tooclose, 4000)
        		   	    			else
										if weaponid == nil then
											TriggerEvent("vorp:TipBottom", Config2.Language.pleaserequip, 4000)
										else
											local ped = PlayerPedId()
											_, wepHash = GetCurrentPedWeapon(ped, true, 0, true)
											wep = GetCurrentPedWeaponEntityIndex(ped, 0)
											if globalhash ~= wepHash then 
												TriggerEvent("vorp:TipBottom", Config2.Language.pleaserequip, 4000)
											else
												if wep ~= nil and wep ~= 0 and globalhash ~= nil then
													TriggerEvent("syn_weapons:wepcomp")
													Citizen.Wait(1000)
													WarMenu.OpenMenu('wepcomp')
													--TriggerEvent("vorp:TipBottom", Config2.Language.scrolltoexit, 4000)
													--FreezeEntityPosition(PlayerPedId(),true)
													createobject(v.Pos2.x, v.Pos2.y, v.Pos2.z,globalhash)
												else
													TriggerEvent("vorp:TipBottom", Config2.Language.pleaserequip, 4000)
												end
											end
										end
									end
								else
									TriggerEvent("vorp:TipBottom", Config2.Language.wrongjobcuztom, 4000)
								end
							else
								local closestPlayer, closestDistance, playerid, tgt1 = GetClosestPlayer()
        		   	    		if closestPlayer ~= -1 and closestDistance <= 2.0 then
        		   	    		    TriggerEvent("vorp:TipBottom", Config2.Language.tooclose, 4000)
        		   	    		else
									if weaponid == nil then
										TriggerEvent("vorp:TipBottom", Config2.Language.pleaserequip, 4000)
									else
										local ped = PlayerPedId()
										_, wepHash = GetCurrentPedWeapon(ped, true, 0, true)
										wep = GetCurrentPedWeaponEntityIndex(ped, 0)
										if globalhash ~= wepHash then 
											TriggerEvent("vorp:TipBottom", Config2.Language.pleaserequip, 4000)
										else
											if wep ~= nil and wep ~= 0 and globalhash ~= nil then
												TriggerEvent("syn_weapons:wepcomp")
												Citizen.Wait(1000)
												WarMenu.OpenMenu('wepcomp')
												--TriggerEvent("vorp:TipBottom", Config2.Language.scrolltoexit, 4000)
												--FreezeEntityPosition(PlayerPedId(),true)
												createobject(v.Pos2.x, v.Pos2.y, v.Pos2.z,globalhash)
											else
												TriggerEvent("vorp:TipBottom", Config2.Language.pleaserequip, 4000)
											end
										end
									end
								end
							end	
						end
					
        		end
        		
			end
			if letSleep then
				Citizen.Wait(500)
			end
		end
    end
end)

Citizen.CreateThread(function()
    while true do
	  Citizen.Wait(0)
	  	if not crafting and not createdobject and not inshop then
      		local coords, letSleep = GetEntityCoords(PlayerPedId()), true
	  		for k, v in pairs(Config.craftinglocation) do
				local dist = GetDistanceBetweenCoords(coords.x,coords.y,coords.z, v.Pos.x,v.Pos.y,v.Pos.z, 1)
				if dist < 1 then
					letSleep = false  
        		   --	DrawText3D(v.Pos.x, v.Pos.y, v.Pos.z, Config2.Language.presstocraft)
					   local label  = CreateVarString(10, 'LITERAL_STRING', Config2.Language.presstocraft)
					   PromptSetActiveGroupThisFrame(prompts, label)
					if Citizen.InvokeNative(0xC92AC953F0A982AE,openmenu) then
					
						if Config.jobonly then
							TriggerServerEvent("syn_weapons:getjob")
							Citizen.Wait(400)
							if jobcheck(Config.job, playerjob) and tonumber(playerrank) >= Config.jobrankcrafting then
								crafting = true
								WarMenu.OpenMenu('crafting')
								--TriggerEvent("vorp:TipBottom", Config2.Language.scrolltoexit, 4000)
								--FreezeEntityPosition(PlayerPedId(),true)
							else
								TriggerEvent("vorp:TipBottom", Config2.Language.wrongjobcrafting, 4000)
							end
						else
							TriggerServerEvent("syn_weapons:getjob")
							Citizen.Wait(400)
							crafting = true
							WarMenu.OpenMenu('crafting')
							--TriggerEvent("vorp:TipBottom", Config2.Language.scrolltoexit, 4000)
							--FreezeEntityPosition(PlayerPedId(),true)
						end	
					end
        		end
        		
			end
			if letSleep then
				Citizen.Wait(500)
			end
		end
    end
end)

Citizen.CreateThread(function()
	if Config.weaponshops then
   		while true do
		  	Citizen.Wait(0)
		  	if not crafting and not createdobject  and not inshop then
   	   			local coords, letSleep = GetEntityCoords(PlayerPedId()), true
		  		for k, v in pairs(Config5.weaponshops) do
					local dist = GetDistanceBetweenCoords(coords.x,coords.y,coords.z, v.Pos.x,v.Pos.y,v.Pos.z, 1)
					if dist < 2 then
						letSleep = false  
   	     		   		--DrawText3D(v.Pos.x, v.Pos.y, v.Pos.z, Config2.Language.presstoshop)
							local label  = CreateVarString(10, 'LITERAL_STRING', Config2.Language.presstoshop)
							PromptSetActiveGroupThisFrame(prompts, label)
						if Citizen.InvokeNative(0xC92AC953F0A982AE,openmenu) then
						
							currentshop = k
							inshop = true
							WarMenu.OpenMenu('shop')
							--TriggerEvent("vorp:TipBottom", Config2.Language.scrolltoexit, 4000)
							--FreezeEntityPosition(PlayerPedId(),true)
						end
					end
					
				end
				if letSleep then
					Citizen.Wait(500)
				end	
			end
		end
	end
end)

Citizen.CreateThread(function()
	if Config.weaponshops then
    	Citizen.Wait(1000)
		for k,v in pairs(Config5.weaponshops) do 
			if v.showblip then
				blip = N_0x554d9d53f696d002(1664425300, v.Pos.x, v.Pos.y, v.Pos.z)
        		SetBlipSprite(blip, v.blipsprite, 1)
        		SetBlipScale(blip, 0.2)
        		Citizen.InvokeNative(0x9CB1A1623062F402, blip, v.Name)
			end
		end
	end
end)

RegisterNetEvent("syn_weapons:wepcomp") 
AddEventHandler("syn_weapons:wepcomp", function()
	local ped = PlayerPedId()
	local _, wepHash = GetCurrentPedWeapon(ped, true, 0, true)
	compss = {}
	if next(compss) == nil then
		for k,v in pairs(comps) do 
			local hash = GetHashKey(k)
			if hash == wepHash then
				for x,l in pairs(v) do 
					 table.insert(compss, {
						label = l.label,
						model = l.model,
						name = l.name,
						type = l.type,
						comp = l.comp,
						confirmed = l.confirmed,
						price = l.price
					}) 
				end
			end
		end
	end
end)

Citizen.CreateThread( function()
	WarMenu.CreateMenu('wepcomp', Config2.Language.customization)
	WarMenu.CreateMenu('crafting', Config2.Language.crafting)
	WarMenu.CreateMenu('shop', Config2.Language.shop)
	WarMenu.CreateSubMenu('weaponz', 'shop', Config2.Language.buyweapons)
	WarMenu.CreateSubMenu('weaponz2', 'shop', Config2.Language.buyweapons)
	WarMenu.CreateSubMenu('ammoz', 'shop', Config2.Language.buyammo)
	WarMenu.CreateSubMenu('ammoz2', 'shop', Config2.Language.buyammo)
	WarMenu.CreateSubMenu('wepcraft', 'crafting', Config2.Language.weaponcrafting)
	WarMenu.CreateSubMenu('wepcraft2', 'crafting', Config2.Language.weaponcrafting)
	WarMenu.CreateSubMenu('wepcraft3', 'crafting', Config2.Language.weaponcrafting)
	WarMenu.CreateSubMenu('ammocraft', 'crafting', Config2.Language.ammocrafting)
	WarMenu.CreateSubMenu('ammocraft2', 'crafting', Config2.Language.ammocrafting)
	WarMenu.CreateSubMenu('ammocraft3', 'crafting', Config2.Language.ammocrafting)
	WarMenu.CreateSubMenu('confirmexit2', 'crafting', Config2.Language.areusureexit)
	WarMenu.CreateSubMenu('confirmed', 'wepcomp', Config2.Language.customization)
	WarMenu.CreateSubMenu('comp', 'wepcomp', Config2.Language.comps)
	WarMenu.CreateSubMenu('scope', 'wepcomp', Config2.Language.sights)
	WarMenu.CreateSubMenu('rifling', 'wepcomp', Config2.Language.rifling)
	WarMenu.CreateSubMenu('other', 'wepcomp', Config2.Language.other)
	WarMenu.CreateSubMenu('scopecolor', 'wepcomp', Config2.Language.scopecolor)
	WarMenu.CreateSubMenu('wrap', 'wepcomp', Config2.Language.wrap)
	WarMenu.CreateSubMenu('wrapcolor', 'wepcomp', Config2.Language.wrapcolor)
	WarMenu.CreateSubMenu('barrel', 'wepcomp',Config2.Language.barrel)
	WarMenu.CreateSubMenu('trigger', 'wepcomp', Config2.Language.trigger)
	WarMenu.CreateSubMenu('variant', 'wepcomp', Config2.Language.variant)
	WarMenu.CreateSubMenu('frame', 'wepcomp', Config2.Language.frame)
	WarMenu.CreateSubMenu('frontsight', 'wepcomp', Config2.Language.frontsight)
	WarMenu.CreateSubMenu('cylinder', 'wepcomp', Config2.Language.cylinder)
	WarMenu.CreateSubMenu('gripbody', 'wepcomp', Config2.Language.gripbody)
	WarMenu.CreateSubMenu('grip', 'wepcomp', Config2.Language.grip)
	WarMenu.CreateSubMenu('decal', 'wepcomp', Config2.Language.decal)
	WarMenu.CreateSubMenu('decalcylinder', 'wepcomp', Config2.Language.decalcylinder)
	WarMenu.CreateSubMenu('decalframe', 'wepcomp', Config2.Language.decalframe)
	WarMenu.CreateSubMenu('decalbarrel', 'wepcomp', Config2.Language.decalbarrel)
	WarMenu.CreateSubMenu('decalcolor', 'wepcomp', Config2.Language.decalcolor)
	WarMenu.CreateSubMenu('cylinder2', 'wepcomp', Config2.Language.cylinder2)
	WarMenu.CreateSubMenu('frame2', 'wepcomp', Config2.Language.frame2)
	WarMenu.CreateSubMenu('barrel2', 'wepcomp', Config2.Language.barrel2)
	WarMenu.CreateSubMenu('confirmexit', 'wepcomp', Config2.Language.areusureexit)
	WarMenu.CreateSubMenu('confirmbuy', 'wepcomp', Config2.Language.buyselect)

	while true do
		if WarMenu.IsMenuOpened('wepcomp') then
			if cal == true then
				sum = 0
				for k,v in pairs(pricing) do
					sum = sum + v.price
				end
				cal = false
			end
			if WarMenu.MenuButton(Config2.Language.customization, "confirmed") then end
			if WarMenu.Button(Config2.Language.total..sum..Config2.Language.dollar) then end
			if WarMenu.MenuButton(Config2.Language.buyselect, "confirmbuy") then end
			if WarMenu.MenuButton(Config2.Language.exitmenu, "confirmexit") then end

		elseif WarMenu.IsMenuOpened('shop') then
			if WarMenu.MenuButton(Config2.Language.buyweapons, "weaponz") then end
			if WarMenu.MenuButton(Config2.Language.buyammo, "ammoz") then end
			if WarMenu.Button(Config2.Language.exitmenu) then 
				FreezeEntityPosition(PlayerPedId(),false)
				inshop = false
				currentshop = nil
				WarMenu.CloseMenu()
			end
		elseif WarMenu.IsMenuOpened('weaponz') then
			for k,v in pairs(Config5.weaponshops) do 
				if k == currentshop then 
					for l,m in pairs(v.weapons) do 
						if WarMenu.MenuButton(""..l.."","weaponz2") then
							category = l
						end  
					end
				end
			end
		elseif WarMenu.IsMenuOpened('ammoz') then
			for k,v in pairs(Config5.weaponshops) do 
				if k == currentshop then 
					for l,m in pairs(v.ammo) do 
						if WarMenu.MenuButton(""..l.."","ammoz2") then
							category = l
						end  
					end
				end
			end
		elseif WarMenu.IsMenuOpened('ammoz2') then
			for k,v in pairs(Config5.weaponshops) do 
				if k == currentshop then 
					for l,m in pairs(v.ammo) do 
						if category == l then 
							for j,d in pairs(m) do
								if WarMenu.MenuButton(""..j.." / "..Config2.Language.cost..d.price..Config2.Language.dollar,"shop") then
									FreezeEntityPosition(PlayerPedId(),false)
									inshop = false
									WarMenu.CloseMenu()
									TriggerEvent("vorpinputs:getInput",Config2.Language.confirm,Config2.Language.amount, function(cb)
										local count =     tonumber(cb)
										if count ~= nil and count ~= 0 and count > 0 then
											itemlabel = j
											itemprice = d.price
											itemtobuy = d.item
											TriggerServerEvent("syn_weapons:buyammo",itemtobuy,itemprice,count,itemlabel)
										else
										  TriggerEvent("vorp:TipBottom", Config2.Language.invalidamount, 4000)
										end
									end)
								end 
							end
						end
					end
				end
			end
		elseif WarMenu.IsMenuOpened('weaponz2') then
			for k,v in pairs(Config5.weaponshops) do 
				if k == currentshop then 
					for l,m in pairs(v.weapons) do     ----- more readable added weapon name instead of hash name. 
						if category == l then 
							for weapon,weaponData in pairs(m) do
								if Config.syndual then 
									if WarMenu.MenuButton(""..weapon.." / "..Config2.Language.cost..Config2.Language.dollar..weaponData.price,"shop") then
										itemprice = weaponData.price
										itemlabel = weapon
										itemtobuy = weaponData.hashname
										TriggerServerEvent("syn_weapons:buyweapon",itemtobuy,itemprice,itemlabel)
									end 
								else
									if WarMenu.MenuButton(""..weapon.." / "..Config2.Language.cost..weaponData.price..Config2.Language.dollar,"shop") then
										itemlabel = weapon
										itemprice = weaponData.price
										itemtobuy = weaponData.hashname
										TriggerServerEvent("syn_weapons:buyweapon",itemtobuy,itemprice,itemlabel)
									end 
								end
							end
						end
					end
				end
			end
		elseif WarMenu.IsMenuOpened('crafting') then
			if WarMenu.MenuButton(Config2.Language.weaponcrafting, "wepcraft") then end
			if WarMenu.MenuButton(Config2.Language.ammocrafting, "ammocraft") then end
			if WarMenu.MenuButton(Config2.Language.exitmenu, "confirmexit2") then end
		elseif WarMenu.IsMenuOpened('wepcraft') then
			for k,v in pairs(Config4.weapons) do 
				if WarMenu.MenuButton(""..k.."","wepcraft2") then
					craftingammoitem = k
				end 
			end
		elseif WarMenu.IsMenuOpened('wepcraft3') then
			if WarMenu.Button(Config2.Language.craft) then
				
				TriggerServerEvent("syn_weapons:itemscheck2",craftingammoitem2,itemtosend,materialtosend)
				WarMenu.CloseMenu()
			end 
			for k,v in pairs(Config4.weapons) do 
				if k ==craftingammoitem then
					for l, m in pairs(v) do
						if l == craftingammoitem2 then 
							for x,y in pairs(m.materials) do
								if WarMenu.Button(y.name.." / "..Config2.Language.count..y.amount) then end 
							end
						end
					end
				end
			end
		elseif WarMenu.IsMenuOpened('wepcraft2') then
			for k,v in pairs(Config4.weapons) do 
				if k ==craftingammoitem then
					for l, m in pairs(v) do
						if m.letcraft then
							if m.jobonly then 
								for p,q in pairs (m.jobs) do 
									if playerjob == q then
										if WarMenu.MenuButton(""..l.."","wepcraft3") then
											craftingammoitem2 = l
											materialtosend = m.materials
											itemtosend = m.hashname
										end 
									end
								end
							else
								if WarMenu.MenuButton(""..l.."","wepcraft3") then
									craftingammoitem2 = l
									materialtosend = m.materials
									itemtosend = m.hashname
								end 
							end
						end
					end
				end
			end
		elseif WarMenu.IsMenuOpened('ammocraft') then
			for k,v in pairs(Config3.ammo) do 
				if WarMenu.MenuButton(""..k.."","ammocraft2") then
					craftingammoitem = k
				end 
			end
		elseif WarMenu.IsMenuOpened('ammocraft3') then
			if WarMenu.Button(Config2.Language.craft) then
				TriggerServerEvent("syn_weapons:itemscheck",itemtosend,materialtosend)
				WarMenu.CloseMenu()
			end 
			for k,v in pairs(Config3.ammo) do 
				if k ==craftingammoitem then
					for l, m in pairs(v) do
						if l == craftingammoitem2 then 
							for x,y in pairs(m.materials) do
								if WarMenu.Button(y.name.." / "..Config2.Language.count..y.amount) then end 
							end
						end
					end
				end
			end
		elseif WarMenu.IsMenuOpened('ammocraft2') then
			for k,v in pairs(Config3.ammo) do 
				if k ==craftingammoitem then
					for l, m in pairs(v) do
						if m.letcraft then
							if m.jobonly then 
								for p,q in pairs (m.jobs) do 
									if playerjob == q then
										if WarMenu.MenuButton(""..l.."","ammocraft3") then
											craftingammoitem2 = l
											materialtosend = m.materials
											itemtosend = m.item
										end 
									end
								end
							else
								if WarMenu.MenuButton(""..l.."","ammocraft3") then
									craftingammoitem2 = l
									materialtosend = m.materials
									itemtosend = m.item
								end 
							end
						end
					end
				end
			end

		elseif WarMenu.IsMenuOpened('confirmexit2') then
			if WarMenu.Button(Config2.Language.yes) then
				crafting = false
				craftingammoitem = nil
 				craftingammoitem2 = nil
 				itemtosend = nil
 				materialtosend = nil
				FreezeEntityPosition(PlayerPedId(),false)
				WarMenu.CloseMenu()
			end
			if WarMenu.MenuButton(Config2.Language.no, "crafting") then end

		elseif WarMenu.IsMenuOpened('confirmbuy') then
			if WarMenu.Button(Config2.Language.yes) then
				TriggerServerEvent("syn_weapons:checkmoney",sum)
				pricing = {}
				sum = 0
				cal = false
				WarMenu.CloseMenu()
				Citizen.Wait(500)
			end
			if WarMenu.MenuButton(Config2.Language.no, "wepcomp") then end
		elseif WarMenu.IsMenuOpened('confirmexit') then
			if WarMenu.Button(Config2.Language.yes) then
				added = {}
				pricing = {}
				compss = {}
				sum = 0
				cal = false
				weaponid = nil
				wephash = nil
				globalhash = nil
				createdobject = false
				DeleteEntity(wepobject)
				FreezeEntityPosition(PlayerPedId(),false)
				WarMenu.CloseMenu()
			end
			if WarMenu.MenuButton(Config2.Language.no, "wepcomp") then end
		elseif WarMenu.IsMenuOpened('confirmed') then
			if contains(compss, "variant",nil) then
				if WarMenu.MenuButton(Config2.Language.variant, "variant") then end
			end
			if WarMenu.MenuButton(Config2.Language.comps, "comp") then end
			if contains(compss, "barrel",nil) then
				if WarMenu.MenuButton(Config2.Language.barrel, "barrel") then end
			end
			if contains(compss, "trigger",nil) then
				if WarMenu.MenuButton(Config2.Language.trigger, "trigger") then end
			end
			if contains(compss, "frame",nil) then
				if WarMenu.MenuButton(Config2.Language.frame, "frame") then end
			end
			if contains(compss, "frontsight",nil) then
				if WarMenu.MenuButton(Config2.Language.frontsight, "frontsight") then end
			end
			if contains(compss, "cylinder",nil) then
				if WarMenu.MenuButton(Config2.Language.cylinder, "cylinder") then end
			end
			if contains(compss, "gripbody",nil) then
				if WarMenu.MenuButton(Config2.Language.gripbody, "gripbody") then end
			end
			if contains(compss, "grip",nil) then
				if WarMenu.MenuButton(Config2.Language.grip, "grip") then end
			end
			if contains2(compss, "decal") then
				if WarMenu.MenuButton(Config2.Language.decal, "decal") then end
			end
			if contains2(compss, "decalcolor") and contains2(added, "decal") then
				if WarMenu.MenuButton(Config2.Language.decalcolor, "decalcolor") then end
			end
				if WarMenu.MenuButton(Config2.Language.scopecolor, "scopecolor") then end
			if contains(added, "comp","wrap") then
				if WarMenu.MenuButton(Config2.Language.wrapcolor, "wrapcolor") then end
			end

		elseif WarMenu.IsMenuOpened('decal') then
			if contains(compss, "decal","cylinder") then
				if WarMenu.MenuButton(Config2.Language.decalcylinder, "decalcylinder") then end
			end
			if contains(compss, "decal","frame") then
				if WarMenu.MenuButton(Config2.Language.decalframe, "decalframe") then end
			end
			if contains(compss, "decal","barrel") then
				if WarMenu.MenuButton(Config2.Language.decalbarrel, "decalbarrel") then end
			end

		elseif WarMenu.IsMenuOpened('decalcolor') then
			if contains(compss, "decalcolor", "cylinder") and contains(added, "decal","cylinder") then 
				if WarMenu.MenuButton(Config2.Language.cylinder2, "cylinder2") then end
			end
			if contains(compss, "decalcolor", "frame") and contains(added, "decal","frame") then 
				if WarMenu.MenuButton(Config2.Language.frame2, "frame2") then end
			end
			if contains(compss, "decalcolor", "barrel") and contains(added, "decal","barrel") then 
				if WarMenu.MenuButton(Config2.Language.barrel2, "barrel2") then end -- findme 
			end

		elseif WarMenu.IsMenuOpened('comp') then
			if contains(compss, "comp","scope") then
				if WarMenu.MenuButton(Config2.Language.sights, "scope") then end
			end
			if contains(compss, "comp","rifling") then
				if WarMenu.MenuButton(Config2.Language.rifling, "rifling") then end
			end
			if contains(compss, "comp","other") then
				if WarMenu.MenuButton(Config2.Language.other, "other") then end
			end
			if contains(compss, "comp","wrap") then
				if WarMenu.MenuButton(Config2.Language.wrap, "wrap") then end
			end

		elseif WarMenu.IsMenuOpened('other') then
			if WarMenu.Button(Config2.Language.remove) then 
				cal = true
				for k,v in pairs(added) do
					if  v.comp == "comp" and v.type == "other" then
						table.remove(added,k)
						RemoveWeaponComponentFromWeaponObject(wepobject, v.name)
					end
				end
				for k,v in pairs(pricing) do
					if  v.comp == "comp" and v.type == "other" then
						table.remove(pricing,k)
					end
				end
			end
			for i = 1, #compss do
				if compss[i].confirmed == 1 then
					if compss[i].comp == "comp"  then
						if compss[i].type == "other"  then
							if WarMenu.MenuButton(Config2.Language.label..compss[i].label..Config2.Language.price..compss[i].price..Config2.Language.dollar,"comp") then 
								if next(pricing) ~= nil then
									for k,v in pairs(pricing) do
										if v.name == compss[i].name or (v.name ~= compss[i].name and v.comp == compss[i].comp and v.type == compss[i].type) then
											table.remove(pricing,k)
										end
									end
									table.insert(pricing, {
										price = compss[i].price,
										comp = compss[i].comp,
										type = compss[i].type,
										name = compss[i].name
									})
								else
									table.insert(pricing, {
										price = compss[i].price,
										comp = compss[i].comp,
										type = compss[i].type,
										name = compss[i].name
									})
								end
								if next(added) ~= nil then
									for k,v in pairs(added) do
										if v.name == compss[i].name or (v.name ~= compss[i].name and v.comp == compss[i].comp and v.type == compss[i].type) then
											table.remove(added,k)
										end
									end
									table.insert(added, {
										label = compss[i].label,
										model = compss[i].model,
										comp = compss[i].comp,
										type = compss[i].type,
										name = compss[i].name
									})
								else
									table.insert(added, {
										label = compss[i].label,
										model = compss[i].model,
										comp = compss[i].comp,
										type = compss[i].type,
										name = compss[i].name
									}) 
								end 
								for k,v in pairs(compss) do
									
										if v.comp == compss[i].comp and v.type == compss[i].type then
											RemoveWeaponComponentFromWeaponObject(wepobject, v.name)
										end
									
								end
								cal = true
								if compss[i].model ~= 0 then
									LoadModel(compss[i].model)
									modelz = true
								end

								GiveWeaponComponentToEntity(wepobject,compss[i].name, -1, true)				
								
		
								if modelz then 
									SetModelAsNoLongerNeeded(compss[i].model)
									modelz = false

								end
							end
						end
					end
				end
			end
		elseif WarMenu.IsMenuOpened('wrap') then
			if WarMenu.Button(Config2.Language.remove) then 
				cal = true
				for k,v in pairs(added) do
					if  v.comp == "comp" and v.type == "wrap" then
						table.remove(added,k)
						RemoveWeaponComponentFromWeaponObject(wepobject, v.name)
					end
				end
				for k,v in pairs(pricing) do
					if  v.comp == "comp" and v.type == "wrap" then
						table.remove(pricing,k)
					end
				end
			end
			for i = 1, #compss do
				if compss[i].confirmed == 1 then
					if compss[i].comp == "comp"  then
						if compss[i].type == "wrap"  then
							if WarMenu.MenuButton(Config2.Language.label..compss[i].label..Config2.Language.price..compss[i].price..Config2.Language.dollar,"comp") then 
								if next(pricing) ~= nil then
									for k,v in pairs(pricing) do
										if v.name == compss[i].name or (v.name ~= compss[i].name and v.comp == compss[i].comp and v.type == compss[i].type) then
											table.remove(pricing,k)
										end
									end
									table.insert(pricing, {
										price = compss[i].price,
										comp = compss[i].comp,
										type = compss[i].type,
										name = compss[i].name
									})
								else
									table.insert(pricing, {
										price = compss[i].price,
										comp = compss[i].comp,
										type = compss[i].type,
										name = compss[i].name
									})
								end
								if next(added) ~= nil then
									for k,v in pairs(added) do
										if v.name == compss[i].name or (v.name ~= compss[i].name and v.comp == compss[i].comp and v.type == compss[i].type) then
											table.remove(added,k)
										end
									end
									table.insert(added, {
										label = compss[i].label,
										model = compss[i].model,
										comp = compss[i].comp,
										type = compss[i].type,
										name = compss[i].name
									})
									
								else
									table.insert(added, {
										label = compss[i].label,
										model = compss[i].model,
										comp = compss[i].comp,
										type = compss[i].type,
										name = compss[i].name
									}) 
									
								end 
								for k,v in pairs(compss) do
									
										if v.comp == compss[i].comp and v.type == compss[i].type then
											RemoveWeaponComponentFromWeaponObject(wepobject, v.name)
										end
									
								end
								cal = true
								if compss[i].model ~= 0 then
									LoadModel(compss[i].model)
									modelz = true
								end

								GiveWeaponComponentToEntity(wepobject,compss[i].name, -1, true)				
								
		
								if modelz then 
									SetModelAsNoLongerNeeded(compss[i].model)
									modelz = false

								end
							end
						end
					end
				end
			end
		elseif WarMenu.IsMenuOpened('scope') then
			if WarMenu.Button(Config2.Language.remove) then 
				cal = true
				for k,v in pairs(added) do
					if  v.comp == "comp" and v.type == "scope" then
						table.remove(added,k)
						RemoveWeaponComponentFromWeaponObject(wepobject, v.name)
					end
				end
				for k,v in pairs(pricing) do
					if  v.comp == "comp" and v.type == "scope" then
						table.remove(pricing,k)
					end
				end
			end
			for i = 1, #compss do
				if compss[i].confirmed == 1 then
					if compss[i].comp == "comp"  then
						if compss[i].type == "scope"  then
							if WarMenu.MenuButton(Config2.Language.label..compss[i].label..Config2.Language.price..compss[i].price..Config2.Language.dollar,"comp") then 
								if next(pricing) ~= nil then
									for k,v in pairs(pricing) do
										if v.name == compss[i].name or (v.name ~= compss[i].name and v.comp == compss[i].comp and v.type == compss[i].type) then
											table.remove(pricing,k)
										end
									end
									table.insert(pricing, {
										price = compss[i].price,
										comp = compss[i].comp,
										type = compss[i].type,
										name = compss[i].name
									})
								else
									table.insert(pricing, {
										price = compss[i].price,
										comp = compss[i].comp,
										type = compss[i].type,
										name = compss[i].name
									})
								end
								if next(added) ~= nil then
									for k,v in pairs(added) do
										if v.name == compss[i].name or (v.name ~= compss[i].name and v.comp == compss[i].comp and v.type == compss[i].type) then
											table.remove(added,k)

										end
									end
									table.insert(added, {
										label = compss[i].label,
										model = compss[i].model,
										comp = compss[i].comp,
										type = compss[i].type,
										name = compss[i].name
									})
									
								else
									table.insert(added, {
										label = compss[i].label,
										model = compss[i].model,
										comp = compss[i].comp,
										type = compss[i].type,
										name = compss[i].name
									}) 
								end 
								for k,v in pairs(compss) do
									
										if v.comp == compss[i].comp and v.type == compss[i].type then
											RemoveWeaponComponentFromWeaponObject(wepobject, v.name)
										end
									
								end
								cal = true
								if compss[i].model ~= 0 then
									LoadModel(compss[i].model)
									modelz = true
								end

								GiveWeaponComponentToEntity(wepobject,compss[i].name, -1, true)				
								
		
								if modelz then 
									SetModelAsNoLongerNeeded(compss[i].model)
									modelz = false

								end
							end
						end
					end
				end
			end
		elseif WarMenu.IsMenuOpened('rifling') then
			if WarMenu.Button(Config2.Language.remove) then 
				cal = true
				for k,v in pairs(added) do
					if  v.comp == "comp" and v.type == "rifling" then
						table.remove(added,k)
						RemoveWeaponComponentFromWeaponObject(wepobject, v.name)
					end
				end
				for k,v in pairs(pricing) do
					if  v.comp == "comp" and v.type == "rifling" then
						table.remove(pricing,k)
					end
				end
			end
			for i = 1, #compss do
				if compss[i].confirmed == 1 then
					if compss[i].comp == "comp"  then
						if compss[i].type == "rifling"  then
							if WarMenu.MenuButton(Config2.Language.label..compss[i].label..Config2.Language.price..compss[i].price..Config2.Language.dollar,"comp") then 
								if next(pricing) ~= nil then
									for k,v in pairs(pricing) do
										if v.name == compss[i].name or (v.name ~= compss[i].name and v.comp == compss[i].comp and v.type == compss[i].type) then
											table.remove(pricing,k)
										end
									end
									table.insert(pricing, {
										price = compss[i].price,
										comp = compss[i].comp,
										type = compss[i].type,
										name = compss[i].name
									})
								else
									table.insert(pricing, {
										price = compss[i].price,
										comp = compss[i].comp,
										type = compss[i].type,
										name = compss[i].name
									})
								end
								if next(added) ~= nil then
									for k,v in pairs(added) do
										if v.name == compss[i].name or (v.name ~= compss[i].name and v.comp == compss[i].comp and v.type == compss[i].type) then
											table.remove(added,k)

										end
									end
									table.insert(added, {
										label = compss[i].label,
										model = compss[i].model,
										comp = compss[i].comp,
										type = compss[i].type,
										name = compss[i].name
									})
									
								else
									table.insert(added, {
										label = compss[i].label,
										model = compss[i].model,
										comp = compss[i].comp,
										type = compss[i].type,
										name = compss[i].name
									}) 
									
								end 
								for k,v in pairs(compss) do
									
										if v.comp == compss[i].comp and v.type == compss[i].type then
											RemoveWeaponComponentFromWeaponObject(wepobject, v.name)
										end
									
								end
								cal = true
								if compss[i].model ~= 0 then
									LoadModel(compss[i].model)
									modelz = true
								end

								GiveWeaponComponentToEntity(wepobject,compss[i].name, -1, true)				
								
		
								if modelz then 
									SetModelAsNoLongerNeeded(compss[i].model)
									modelz = false

								end
							end
						end
					end
				end
			end

		elseif WarMenu.IsMenuOpened('barrel2') then
			if WarMenu.Button(Config2.Language.remove) then 
				cal = true -- findme
				for k,v in pairs(added) do
					if  v.comp == "decalcolor" and v.type == "barrel" then
						table.remove(added,k)
						RemoveWeaponComponentFromWeaponObject(wepobject, v.name)
					end
				end
				for k,v in pairs(pricing) do
					if  v.comp == "decalcolor" and v.type == "barrel" then
						table.remove(pricing,k)
					end
				end
			end
			for i = 1, #compss do
				if compss[i].confirmed == 1 then
					if compss[i].comp == "decalcolor"  then
						if compss[i].type == "barrel"  then
							if WarMenu.Button(Config2.Language.label..compss[i].label..Config2.Language.price..compss[i].price..Config2.Language.dollar) then 
								if next(pricing) ~= nil then
									for k,v in pairs(pricing) do
										if v.name == compss[i].name or (v.name ~= compss[i].name and v.comp == compss[i].comp and v.type == compss[i].type) then
											table.remove(pricing,k)
										end
									end
									table.insert(pricing, {
										price = compss[i].price,
										comp = compss[i].comp,
										type = compss[i].type,
										name = compss[i].name
									})
								else
									table.insert(pricing, {
										price = compss[i].price,
										comp = compss[i].comp,
										type = compss[i].type,
										name = compss[i].name
									})
								end
								if next(added) ~= nil then
									for k,v in pairs(added) do
										if v.name == compss[i].name or (v.name ~= compss[i].name and v.comp == compss[i].comp and v.type == compss[i].type) then
											table.remove(added,k)

										end
									end
									table.insert(added, {
										label = compss[i].label,
										model = compss[i].model,
										comp = compss[i].comp,
										type = compss[i].type,
										name = compss[i].name
									})
									
								else
									table.insert(added, {
										label = compss[i].label,
										model = compss[i].model,
										comp = compss[i].comp,
										type = compss[i].type,
										name = compss[i].name
									}) 
									
								end 
								for k,v in pairs(compss) do
									if v.comp ~= "comp" then
										if v.comp == compss[i].comp and v.type == compss[i].type then
											RemoveWeaponComponentFromWeaponObject(wepobject, v.name)
										end
									end
								end
								cal = true
								if compss[i].model ~= 0 then
									LoadModel(compss[i].model)
									modelz = true
								end

								GiveWeaponComponentToEntity(wepobject,compss[i].name, -1, true)				
								
		
								if modelz then 
									SetModelAsNoLongerNeeded(compss[i].model)
									modelz = false

								end
							end
						end
					end
				end
			end

		elseif WarMenu.IsMenuOpened('frame2') then
			if WarMenu.Button(Config2.Language.remove) then 
				cal = true
				for k,v in pairs(added) do
					if  v.comp == "decalcolor" and v.type == "frame" then
						table.remove(added,k)

						RemoveWeaponComponentFromWeaponObject(wepobject, v.name)
					end
				end
				for k,v in pairs(pricing) do
					if  v.comp == "decalcolor" and v.type == "frame" then
						table.remove(pricing,k)
					end
				end
			end
			for i = 1, #compss do
				if compss[i].confirmed == 1 then
					if compss[i].comp == "decalcolor"  then
						if compss[i].type == "frame"  then
							if WarMenu.Button(Config2.Language.label..compss[i].label..Config2.Language.price..compss[i].price..Config2.Language.dollar) then 
								if next(pricing) ~= nil then
									for k,v in pairs(pricing) do
										if v.name == compss[i].name or (v.name ~= compss[i].name and v.comp == compss[i].comp and v.type == compss[i].type) then
											table.remove(pricing,k)
										end
									end
									table.insert(pricing, {
										price = compss[i].price,
										comp = compss[i].comp,
										type = compss[i].type,
										name = compss[i].name
									})
								else
									table.insert(pricing, {
										price = compss[i].price,
										comp = compss[i].comp,
										type = compss[i].type,
										name = compss[i].name
									})
								end
								if next(added) ~= nil then
									for k,v in pairs(added) do
										if v.name == compss[i].name or (v.name ~= compss[i].name and v.comp == compss[i].comp and v.type == compss[i].type) then
											table.remove(added,k)

										end
									end
									table.insert(added, {
										label = compss[i].label,
										model = compss[i].model,
										comp = compss[i].comp,
										type = compss[i].type,
										name = compss[i].name
									})
									
								else
									table.insert(added, {
										label = compss[i].label,
										model = compss[i].model,
										comp = compss[i].comp,
										type = compss[i].type,
										name = compss[i].name
									}) 
									
								end 
								for k,v in pairs(compss) do
									if v.comp ~= "comp" then
										if v.comp == compss[i].comp and v.type == compss[i].type then
											RemoveWeaponComponentFromWeaponObject(wepobject, v.name)
										end
									end
								end
								cal = true
								if compss[i].model ~= 0 then
									LoadModel(compss[i].model)
									modelz = true
								end

								GiveWeaponComponentToEntity(wepobject,compss[i].name, -1, true)				
								
		
								if modelz then 
									SetModelAsNoLongerNeeded(compss[i].model)
									modelz = false

								end
							end
						end
					end
				end
			end

		elseif WarMenu.IsMenuOpened('cylinder2') then
			if WarMenu.Button(Config2.Language.remove) then 
				cal = true
				for k,v in pairs(added) do
					if  v.comp == "decalcolor" and v.type == "cylinder" then
						table.remove(added,k)

						RemoveWeaponComponentFromWeaponObject(wepobject, v.name)
					end
					for k,v in pairs(pricing) do
						if  v.comp == "decalcolor" and v.type == "cylinder" then
							table.remove(pricing,k)
						end
					end
				end
			end
			for i = 1, #compss do
				if compss[i].confirmed == 1 then
					if compss[i].comp == "decalcolor"  then
						if compss[i].type == "cylinder"  then
							if WarMenu.Button(Config2.Language.label..compss[i].label..Config2.Language.price..compss[i].price..Config2.Language.dollar) then 
								if next(pricing) ~= nil then
									for k,v in pairs(pricing) do
										if v.name == compss[i].name or (v.name ~= compss[i].name and v.comp == compss[i].comp and v.type == compss[i].type) then
											table.remove(pricing,k)
										end
									end
									table.insert(pricing, {
										price = compss[i].price,
										comp = compss[i].comp,
										type = compss[i].type,
										name = compss[i].name
									})
								else
									table.insert(pricing, {
										price = compss[i].price,
										comp = compss[i].comp,
										type = compss[i].type,
										name = compss[i].name
									})
								end
								if next(added) ~= nil then
									for k,v in pairs(added) do
										if v.name == compss[i].name or (v.name ~= compss[i].name and v.comp == compss[i].comp and v.type == compss[i].type) then
											table.remove(added,k)

										end
									end
									table.insert(added, {
										label = compss[i].label,
										model = compss[i].model,
										comp = compss[i].comp,
										type = compss[i].type,
										name = compss[i].name
									})
									
								else
									table.insert(added, {
										label = compss[i].label,
										model = compss[i].model,
										comp = compss[i].comp,
										type = compss[i].type,
										name = compss[i].name
									}) 
									
								end 
								for k,v in pairs(compss) do
									if v.comp ~= "comp" then
										if v.comp == compss[i].comp and v.type == compss[i].type then
											RemoveWeaponComponentFromWeaponObject(wepobject, v.name)
										end
									end
								end
								if compss[i].model ~= 0 then
									LoadModel(compss[i].model)
									modelz = true
								end
								cal = true
								GiveWeaponComponentToEntity(wepobject,compss[i].name, -1, true)				
								
		
								if modelz then 
									SetModelAsNoLongerNeeded(compss[i].model)
									modelz = false

								end
							end
						end
					end
				end
			end

		elseif WarMenu.IsMenuOpened('decalbarrel') then
			if WarMenu.Button(Config2.Language.remove) then 
				cal = true
				for k,v in pairs(added) do
					if  v.comp == "decal" and v.type == "barrel" then
						table.remove(added,k)

						RemoveWeaponComponentFromWeaponObject(wepobject, v.name)
					end
				end
				for k,v in pairs(pricing) do
					if  v.comp == "decal" and v.type == "barrel" then
						table.remove(pricing,k)
					end
				end
			end
			for i = 1, #compss do
				if compss[i].confirmed == 1 then
					if compss[i].comp == "decal"  then
						if compss[i].type == "barrel"  then
							if WarMenu.Button(Config2.Language.label..compss[i].label..Config2.Language.price..compss[i].price..Config2.Language.dollar) then 
								if next(pricing) ~= nil then
									for k,v in pairs(pricing) do
										if v.name == compss[i].name or (v.name ~= compss[i].name and v.comp == compss[i].comp and v.type == compss[i].type) then
											table.remove(pricing,k)
										end
									end
									table.insert(pricing, {
										price = compss[i].price,
										comp = compss[i].comp,
										type = compss[i].type,
										name = compss[i].name
									})
								else
									table.insert(pricing, {
										price = compss[i].price,
										comp = compss[i].comp,
										type = compss[i].type,
										name = compss[i].name
									})
								end
								if next(added) ~= nil then
									for k,v in pairs(added) do
										if v.name == compss[i].name or (v.name ~= compss[i].name and v.comp == compss[i].comp and v.type == compss[i].type) then
											table.remove(added,k)

										end
									end
									table.insert(added, {
										label = compss[i].label,
										model = compss[i].model,
										comp = compss[i].comp,
										type = compss[i].type,
										name = compss[i].name
									})
									
								else
									table.insert(added, {
										label = compss[i].label,
										model = compss[i].model,
										comp = compss[i].comp,
										type = compss[i].type,
										name = compss[i].name
									}) 
									
								end 
								for k,v in pairs(compss) do
									if v.comp ~= "comp" then
										if v.comp == compss[i].comp and v.type == compss[i].type then
											RemoveWeaponComponentFromWeaponObject(wepobject, v.name)
										end
									end
								end
								if compss[i].model ~= 0 then
									LoadModel(compss[i].model)
									modelz = true
								end

								GiveWeaponComponentToEntity(wepobject,compss[i].name, -1, true)				
								cal = true
		
								if modelz then 
									SetModelAsNoLongerNeeded(compss[i].model)
									modelz = false

								end
							end
						end
					end
				end
			end
		elseif WarMenu.IsMenuOpened('decalframe') then
			if WarMenu.Button(Config2.Language.remove) then 
				cal = true
				for k,v in pairs(added) do
					if  v.comp == "decal" and v.type == "frame" then
						table.remove(added,k)

						RemoveWeaponComponentFromWeaponObject(wepobject, v.name)
					end
				end
				for k,v in pairs(pricing) do
					if  v.comp == "decal" and v.type == "frame" then
						table.remove(pricing,k)
					end
				end
			end
			for i = 1, #compss do
				if compss[i].confirmed == 1 then
					if compss[i].comp == "decal"  then
						if compss[i].type == "frame"  then
							if WarMenu.Button(Config2.Language.label..compss[i].label..Config2.Language.price..compss[i].price..Config2.Language.dollar) then 
								if next(pricing) ~= nil then
									for k,v in pairs(pricing) do
										if v.name == compss[i].name or (v.name ~= compss[i].name and v.comp == compss[i].comp and v.type == compss[i].type) then
											table.remove(pricing,k)
										end
									end
									table.insert(pricing, {
										price = compss[i].price,
										comp = compss[i].comp,
										type = compss[i].type,
										name = compss[i].name
									})
								else
									table.insert(pricing, {
										price = compss[i].price,
										comp = compss[i].comp,
										type = compss[i].type,
										name = compss[i].name
									})
								end
								if next(added) ~= nil then
									for k,v in pairs(added) do
										if v.name == compss[i].name or (v.name ~= compss[i].name and v.comp == compss[i].comp and v.type == compss[i].type) then
											table.remove(added,k)

										end
									end
									table.insert(added, {
										label = compss[i].label,
										model = compss[i].model,
										comp = compss[i].comp,
										type = compss[i].type,
										name = compss[i].name
									})
									
								else
									table.insert(added, {
										label = compss[i].label,
										model = compss[i].model,
										comp = compss[i].comp,
										type = compss[i].type,
										name = compss[i].name
									}) 
									
								end 
								for k,v in pairs(compss) do
									if v.comp ~= "comp" then
										if v.comp == compss[i].comp and v.type == compss[i].type then
											RemoveWeaponComponentFromWeaponObject(wepobject, v.name)
										end
									end
								end
								if compss[i].model ~= 0 then
									LoadModel(compss[i].model)
									modelz = true
								end
								cal = true
								GiveWeaponComponentToEntity(wepobject,compss[i].name, -1, true)				
								
		
								if modelz then 
									SetModelAsNoLongerNeeded(compss[i].model)
									modelz = false

								end
							end
						end
					end
				end
			end

		elseif WarMenu.IsMenuOpened('decalcylinder') then
			if WarMenu.Button(Config2.Language.remove) then 
				cal = true
				for k,v in pairs(added) do
					if  v.comp == "decal" and v.type == "cylinder" then
						table.remove(added,k)
						RemoveWeaponComponentFromWeaponObject(wepobject, v.name)
					end
				end
				for k,v in pairs(pricing) do
					if  v.comp == "decal" and v.type == "cylinder" then
						table.remove(pricing,k)
					end
				end
			end
			for i = 1, #compss do
				if compss[i].confirmed == 1 then
					if compss[i].comp == "decal"  then
						if compss[i].type == "cylinder"  then
							if WarMenu.Button(Config2.Language.label..compss[i].label..Config2.Language.price..compss[i].price..Config2.Language.dollar) then  
								if next(pricing) ~= nil then
									for k,v in pairs(pricing) do
										if v.name == compss[i].name or (v.name ~= compss[i].name and v.comp == compss[i].comp and v.type == compss[i].type) then
											table.remove(pricing,k)
										end
									end
									table.insert(pricing, {
										price = compss[i].price,
										comp = compss[i].comp,
										type = compss[i].type,
										name = compss[i].name
									})
								else
									table.insert(pricing, {
										price = compss[i].price,
										comp = compss[i].comp,
										type = compss[i].type,
										name = compss[i].name
									})
								end
								if next(added) ~= nil then
									for k,v in pairs(added) do
										if v.name == compss[i].name or (v.name ~= compss[i].name and v.comp == compss[i].comp and v.type == compss[i].type) then
										table.remove(added,k)

										end
									end
									table.insert(added, {
										label = compss[i].label,
										model = compss[i].model,
										comp = compss[i].comp,
										type = compss[i].type,
										name = compss[i].name
									})
									
								else
									table.insert(added, {
										label = compss[i].label,
										model = compss[i].model,
										comp = compss[i].comp,
										type = compss[i].type,
										name = compss[i].name
									}) 
									
								end 
								for k,v in pairs(compss) do
									if v.comp ~= "comp" then
										if v.comp == compss[i].comp and v.type == compss[i].type then
											RemoveWeaponComponentFromWeaponObject(wepobject, v.name)
										end
									end
								end
								if compss[i].model ~= 0 then
									LoadModel(compss[i].model)
									modelz = true
								end
								cal = true
								GiveWeaponComponentToEntity(wepobject,compss[i].name, -1, true)				
								
		
								if modelz then 
									SetModelAsNoLongerNeeded(compss[i].model)
									modelz = false

								end
							end
						end
					end
				end
			end
			
		elseif WarMenu.IsMenuOpened('grip') then
			if WarMenu.Button(Config2.Language.remove) then 
				cal = true
				for k,v in pairs(added) do
					if  v.comp == "grip" then
						table.remove(added,k)

						RemoveWeaponComponentFromWeaponObject(wepobject, v.name)
					end
				end
				for k,v in pairs(pricing) do
					if  v.comp == "grip" then
						table.remove(pricing,k)
					end
				end
			end
			for i = 1, #compss do
				if compss[i].confirmed == 1 then
					if compss[i].comp == "grip" then
						if WarMenu.Button(Config2.Language.label..compss[i].label..Config2.Language.price..compss[i].price..Config2.Language.dollar) then 
							if next(pricing) ~= nil then
								for k,v in pairs(pricing) do
									if v.name ~= compss[i].name and v.comp == compss[i].comp then
										table.remove(pricing,k)
									end
								end
								table.insert(pricing, {
									price = compss[i].price,
									comp = compss[i].comp,
									type = compss[i].type,
									name = compss[i].name
								})
							else
								table.insert(pricing, {
									price = compss[i].price,
									comp = compss[i].comp,
									type = compss[i].type,
									name = compss[i].name
								})
							end
							if next(added) ~= nil then
								for k,v in pairs(added) do
									if v.name ~= compss[i].name and v.comp == compss[i].comp then
										table.remove(added,k)

									end
								end
								table.insert(added, {
									label = compss[i].label,
									model = compss[i].model,
									comp = compss[i].comp,
									type = compss[i].type,
									name = compss[i].name
								})
								
							else
								table.insert(added, {
									label = compss[i].label,
									model = compss[i].model,
									comp = compss[i].comp,
									type = compss[i].type,
									name = compss[i].name
								}) 
								
							end 
							for k,v in pairs(compss) do
								if v.comp ~= "comp" then
									if v.comp == compss[i].comp then
										RemoveWeaponComponentFromWeaponObject(wepobject, v.name)
									end
								end
							end
							if compss[i].model ~= 0 then
								LoadModel(compss[i].model)
								modelz = true
							end

							GiveWeaponComponentToEntity(wepobject,compss[i].name, -1, true)				
							cal = true
	
							if modelz then 
								SetModelAsNoLongerNeeded(compss[i].model)
								modelz = false

							end
						end
					end
				end
			end
		elseif WarMenu.IsMenuOpened('scopecolor') then
			if WarMenu.Button(Config2.Language.remove) then 
				cal = true
				for k,v in pairs(added) do
					if  v.comp == "scope" then
						table.remove(added,k)
						RemoveWeaponComponentFromWeaponObject(wepobject, v.name)
					end
				end
				for k,v in pairs(pricing) do
					if  v.comp == "scope" then
						table.remove(pricing,k)
					end
				end
			end
			for i = 1, #compss do
				if compss[i].confirmed == 1 then
					if compss[i].comp == "scope" then
						if WarMenu.Button(Config2.Language.label..compss[i].label..Config2.Language.price..compss[i].price..Config2.Language.dollar) then 
							if next(pricing) ~= nil then
								for k,v in pairs(pricing) do
									if v.name ~= compss[i].name and v.comp == compss[i].comp then
										table.remove(pricing,k)
									end
								end
								table.insert(pricing, {
									price = compss[i].price,
									comp = compss[i].comp,
									type = compss[i].type,
									name = compss[i].name
								})
							else
								table.insert(pricing, {
									price = compss[i].price,
									comp = compss[i].comp,
									type = compss[i].type,
									name = compss[i].name
								})
							end
							if next(added) ~= nil then
								for k,v in pairs(added) do
									if v.name ~= compss[i].name and v.comp == compss[i].comp then
										table.remove(added,k)

									end
								end
								table.insert(added, {
									label = compss[i].label,
									model = compss[i].model,
									comp = compss[i].comp,
									type = compss[i].type,
									name = compss[i].name
								})
								
							else
								table.insert(added, {
									label = compss[i].label,
									model = compss[i].model,
									comp = compss[i].comp,
									type = compss[i].type,
									name = compss[i].name
								}) 
								
							end 
							for k,v in pairs(compss) do
								if v.comp ~= "comp" then
									if v.comp == compss[i].comp then
										RemoveWeaponComponentFromWeaponObject(wepobject, v.name)
									end
								end
							end
							if compss[i].model ~= 0 then
								LoadModel(compss[i].model)
								modelz = true
							end
							cal = true
							GiveWeaponComponentToEntity(wepobject,compss[i].name, -1, true)				
							
	
							if modelz then 
								SetModelAsNoLongerNeeded(compss[i].model)
								modelz = false

							end
						end
					end
				end
			end
		elseif WarMenu.IsMenuOpened('wrapcolor') then
			if WarMenu.Button(Config2.Language.remove) then 
				cal = true
				for k,v in pairs(added) do
					if  v.comp == "wrapcolor" then
						table.remove(added,k)
						RemoveWeaponComponentFromWeaponObject(wepobject, v.name)
					end
				end
				for k,v in pairs(pricing) do
					if  v.comp == "wrapcolor" then
						table.remove(pricing,k)
					end
				end
			end
			for i = 1, #compss do
				if compss[i].confirmed == 1 then
					if compss[i].comp == "wrapcolor" then
						if WarMenu.Button(Config2.Language.label..compss[i].label..Config2.Language.price..compss[i].price..Config2.Language.dollar) then 
							if next(pricing) ~= nil then
								for k,v in pairs(pricing) do
									if v.name ~= compss[i].name and v.comp == compss[i].comp then
										table.remove(pricing,k)
									end
								end
								table.insert(pricing, {
									price = compss[i].price,
									comp = compss[i].comp,
									type = compss[i].type,
									name = compss[i].name
								})
							else
								table.insert(pricing, {
									price = compss[i].price,
									comp = compss[i].comp,
									type = compss[i].type,
									name = compss[i].name
								})
							end
							if next(added) ~= nil then
								for k,v in pairs(added) do
									if v.name ~= compss[i].name and v.comp == compss[i].comp then
										table.remove(added,k)

									end
								end
								table.insert(added, {
									label = compss[i].label,
									model = compss[i].model,
									comp = compss[i].comp,
									type = compss[i].type,
									name = compss[i].name
								})
								
							else
								table.insert(added, {
									label = compss[i].label,
									model = compss[i].model,
									comp = compss[i].comp,
									type = compss[i].type,
									name = compss[i].name
								}) 
								
							end 
							for k,v in pairs(compss) do
								if v.comp ~= "comp" then
									if v.comp == compss[i].comp then
										RemoveWeaponComponentFromWeaponObject(wepobject, v.name)
									end
								end
							end
							if compss[i].model ~= 0 then
								LoadModel(compss[i].model)
								modelz = true
							end

							GiveWeaponComponentToEntity(wepobject,compss[i].name, -1, true)				
							cal = true
	
							if modelz then 
								SetModelAsNoLongerNeeded(compss[i].model)
								modelz = false

							end
						end
					end
				end
			end
		elseif WarMenu.IsMenuOpened('gripbody') then
			for i = 1, #compss do
				if compss[i].confirmed == 1 then
					if compss[i].comp == "gripbody" then
						if WarMenu.Button(Config2.Language.label..compss[i].label..Config2.Language.price..compss[i].price..Config2.Language.dollar) then 
							if next(pricing) ~= nil then
								for k,v in pairs(pricing) do
									if v.name ~= compss[i].name and v.comp == compss[i].comp then
										table.remove(pricing,k)
									end
								end
								table.insert(pricing, {
									price = compss[i].price,
									comp = compss[i].comp,
									type = compss[i].type,
									name = compss[i].name
								})
							else
								table.insert(pricing, {
									price = compss[i].price,
									comp = compss[i].comp,
									type = compss[i].type,
									name = compss[i].name
								})
							end
							if next(added) ~= nil then
								for k,v in pairs(added) do
									if v.name ~= compss[i].name and v.comp == compss[i].comp then
										table.remove(added,k)

									end
								end
								table.insert(added, {
									label = compss[i].label,
									model = compss[i].model,
									comp = compss[i].comp,
									type = compss[i].type,
									name = compss[i].name
								})
							else
								table.insert(added, {
									label = compss[i].label,
									model = compss[i].model,
									comp = compss[i].comp,
									type = compss[i].type,
									name = compss[i].name
								}) 
							end 
							for k,v in pairs(compss) do
								if v.comp ~= "comp" then
									if v.comp == compss[i].comp then
										RemoveWeaponComponentFromWeaponObject(wepobject, v.name)
									end
								end
							end
							if compss[i].model ~= 0 then
								LoadModel(compss[i].model)
								modelz = true
							end
							cal = true
							GiveWeaponComponentToEntity(wepobject,compss[i].name, -1, true)				
							
	
							if modelz then 
								SetModelAsNoLongerNeeded(compss[i].model)
								modelz = false

							end
						end
					end
				end
			end
		elseif WarMenu.IsMenuOpened('cylinder') then
			if WarMenu.Button(Config2.Language.remove) then 
				cal = true
				for k,v in pairs(added) do
					if  v.comp == "cylinder" then
						table.remove(added,k)

						RemoveWeaponComponentFromWeaponObject(wepobject, v.name)
					end
				end
				for k,v in pairs(pricing) do
					if  v.comp == "cylinder" then
						table.remove(pricing,k)
					end
				end
			end
			for i = 1, #compss do
				if compss[i].confirmed == 1 then
					if compss[i].comp == "cylinder" then
						if WarMenu.Button(Config2.Language.label..compss[i].label..Config2.Language.price..compss[i].price..Config2.Language.dollar) then
							if next(pricing) ~= nil then
								for k,v in pairs(pricing) do
									if v.name ~= compss[i].name and v.comp == compss[i].comp then
										table.remove(pricing,k)
									end
								end
								table.insert(pricing, {
									price = compss[i].price,
									comp = compss[i].comp,
									type = compss[i].type,
									name = compss[i].name
								})
							else
								table.insert(pricing, {
									price = compss[i].price,
									comp = compss[i].comp,
									type = compss[i].type,
									name = compss[i].name
								})
							end
							if next(added) ~= nil then
								for k,v in pairs(added) do
									if v.name ~= compss[i].name and v.comp == compss[i].comp then
										table.remove(added,k)

									end
								end
								table.insert(added, {
									label = compss[i].label,
									model = compss[i].model,
									comp = compss[i].comp,
									type = compss[i].type,
									name = compss[i].name
								})
								
							else
								table.insert(added, {
									label = compss[i].label,
									model = compss[i].model,
									comp = compss[i].comp,
									type = compss[i].type,
									name = compss[i].name
								}) 
								
							end 
							for k,v in pairs(compss) do
								if v.comp ~= "comp" then
									if v.comp == compss[i].comp then
										RemoveWeaponComponentFromWeaponObject(wepobject, v.name)
									end
								end
							end
							if compss[i].model ~= 0 then
								LoadModel(compss[i].model)
								modelz = true
							end
							cal = true
							GiveWeaponComponentToEntity(wepobject,compss[i].name, -1, true)				
							
	
							if modelz then 
								SetModelAsNoLongerNeeded(compss[i].model)
								modelz = false

							end
						end
					end
				end
			end
		elseif WarMenu.IsMenuOpened('frontsight') then
			if WarMenu.Button(Config2.Language.remove) then 
				cal = true
				for k,v in pairs(added) do
					if  v.comp == "frontsight" then
						table.remove(added,k)

						RemoveWeaponComponentFromWeaponObject(wepobject, v.name)
					end
				end
				for k,v in pairs(pricing) do
					if  v.comp == "frontsight" then
						table.remove(pricing,k)
					end
				end
			end
			for i = 1, #compss do
				if compss[i].confirmed == 1 then
					if compss[i].comp == "frontsight" then
						if WarMenu.Button(Config2.Language.label..compss[i].label..Config2.Language.price..compss[i].price..Config2.Language.dollar) then
							if next(pricing) ~= nil then
								for k,v in pairs(pricing) do
									if v.name ~= compss[i].name and v.comp == compss[i].comp then
										table.remove(pricing,k)
									end
								end
								table.insert(pricing, {
									price = compss[i].price,
									comp = compss[i].comp,
									type = compss[i].type,
									name = compss[i].name
								})
							else
								table.insert(pricing, {
									price = compss[i].price,
									comp = compss[i].comp,
									type = compss[i].type,
									name = compss[i].name
								})
							end
							if next(added) ~= nil then
								for k,v in pairs(added) do
									if v.name ~= compss[i].name and v.comp == compss[i].comp then
										table.remove(added,k)

									end
								end
								table.insert(added, {
									label = compss[i].label,
									model = compss[i].model,
									comp = compss[i].comp,
									type = compss[i].type,
									name = compss[i].name
								})
								
							else
								table.insert(added, {
									label = compss[i].label,
									model = compss[i].model,
									comp = compss[i].comp,
									type = compss[i].type,
									name = compss[i].name
								}) 
								
							end 
							for k,v in pairs(compss) do
								if v.comp ~= "comp" then
									if v.comp == compss[i].comp then
										RemoveWeaponComponentFromWeaponObject(wepobject, v.name)
									end
								end
							end
							if compss[i].model ~= 0 then
								LoadModel(compss[i].model)
								modelz = true
							end
							cal = true
							GiveWeaponComponentToEntity(wepobject,compss[i].name, -1, true)				
							
	
							if modelz then 
								SetModelAsNoLongerNeeded(compss[i].model)
								modelz = false

							end
						end
					end
				end
			end
		elseif WarMenu.IsMenuOpened('frame') then
			if WarMenu.Button(Config2.Language.remove) then 
				cal = true
				for k,v in pairs(added) do
					if  v.comp == "frame" then
						table.remove(added,k)

						RemoveWeaponComponentFromWeaponObject(wepobject, v.name)
					end
				end
				for k,v in pairs(pricing) do
					if  v.comp == "frame" then
						table.remove(pricing,k)
					end
				end
			end
			for i = 1, #compss do
				if compss[i].confirmed == 1 then
					if compss[i].comp == "frame" then
						if WarMenu.Button(Config2.Language.label..compss[i].label..Config2.Language.price..compss[i].price..Config2.Language.dollar) then 
							if next(pricing) ~= nil then
								for k,v in pairs(pricing) do
									if v.name ~= compss[i].name and v.comp == compss[i].comp then
										table.remove(pricing,k)
									end
								end
								table.insert(pricing, {
									price = compss[i].price,
									comp = compss[i].comp,
									type = compss[i].type,
									name = compss[i].name
								})
							else
								table.insert(pricing, {
									price = compss[i].price,
									comp = compss[i].comp,
									type = compss[i].type,
									name = compss[i].name
								})
							end
							if next(added) ~= nil then
								for k,v in pairs(added) do
									if v.name ~= compss[i].name and v.comp == compss[i].comp then
										table.remove(added,k)

									end
								end
								table.insert(added, {
									label = compss[i].label,
									model = compss[i].model,
									comp = compss[i].comp,
									type = compss[i].type,
									name = compss[i].name
								})
								
							else
								table.insert(added, {
									label = compss[i].label,
									model = compss[i].model,
									comp = compss[i].comp,
									type = compss[i].type,
									name = compss[i].name
								}) 
								
							end 
							for k,v in pairs(compss) do
								if v.comp ~= "comp" then
									if v.comp == compss[i].comp then
										RemoveWeaponComponentFromWeaponObject(wepobject, v.name)
									end
								end
							end
							if compss[i].model ~= 0 then
								LoadModel(compss[i].model)
								modelz = true
							end

							GiveWeaponComponentToEntity(wepobject,compss[i].name, -1, true)				
							cal = true
	
							if modelz then 
								SetModelAsNoLongerNeeded(compss[i].model)
								modelz = false

							end
						end
					end
				end
			end
		elseif WarMenu.IsMenuOpened('trigger') then
			if WarMenu.Button(Config2.Language.remove) then 
				cal = true
				for k,v in pairs(added) do
					if  v.comp == "trigger" then
						table.remove(added,k)
						RemoveWeaponComponentFromWeaponObject(wepobject, v.name)
					end
				end
				for k,v in pairs(pricing) do
					if  v.comp == "trigger" then
						table.remove(pricing,k)
					end
				end
			end
			for i = 1, #compss do
				if compss[i].confirmed == 1 then
					if compss[i].comp == "trigger" then
						if WarMenu.Button(Config2.Language.label..compss[i].label..Config2.Language.price..compss[i].price..Config2.Language.dollar) then
							if next(pricing) ~= nil then
								for k,v in pairs(pricing) do
									if v.name ~= compss[i].name and v.comp == compss[i].comp then
										table.remove(pricing,k)
									end
								end
								table.insert(pricing, {
									price = compss[i].price,
									comp = compss[i].comp,
									type = compss[i].type,
									name = compss[i].name
								})
							else
								table.insert(pricing, {
									price = compss[i].price,
									comp = compss[i].comp,
									type = compss[i].type,
									name = compss[i].name
								})
							end
							if next(added) ~= nil then
								for k,v in pairs(added) do
									if v.name ~= compss[i].name and v.comp == compss[i].comp then
										table.remove(added,k)

									end
								end
								table.insert(added, {
									label = compss[i].label,
									model = compss[i].model,
									comp = compss[i].comp,
									type = compss[i].type,
									name = compss[i].name
								})
								
							else
								table.insert(added, {
									label = compss[i].label,
									model = compss[i].model,
									comp = compss[i].comp,
									type = compss[i].type,
									name = compss[i].name
								}) 
								
							end 
							for k,v in pairs(compss) do
								if v.comp ~= "comp" then
									if v.comp == compss[i].comp then
										RemoveWeaponComponentFromWeaponObject(wepobject, v.name)
									end
								end
							end
							if compss[i].model ~= 0 then
								LoadModel(compss[i].model)
								modelz = true
							end
							cal = true
							GiveWeaponComponentToEntity(wepobject,compss[i].name, -1, true)				
							
	
							if modelz then 
								SetModelAsNoLongerNeeded(compss[i].model)
								modelz = false

							end
						end
					end
				end
			end
		elseif WarMenu.IsMenuOpened('variant') then
			if WarMenu.Button(Config2.Language.remove) then 
				cal = true
				for k,v in pairs(added) do
					if  v.comp == "variant" then
						table.remove(added,k)

						RemoveWeaponComponentFromWeaponObject(wepobject, v.name)
					end
				end
				for k,v in pairs(pricing) do
					if  v.comp == "variant" then
						table.remove(pricing,k)
					end
				end
			end
			for i = 1, #compss do
				if compss[i].confirmed == 1 then
					if compss[i].comp == "variant" then
						if WarMenu.Button(Config2.Language.label..compss[i].label..Config2.Language.price..compss[i].price..Config2.Language.dollar) then
							if next(pricing) ~= nil then
								for k,v in pairs(pricing) do
									if v.name ~= compss[i].name and v.comp == compss[i].comp then
										table.remove(pricing,k)
									end
								end
								table.insert(pricing, {
									price = compss[i].price,
									comp = compss[i].comp,
									type = compss[i].type,
									name = compss[i].name
								})
							else
								table.insert(pricing, {
									price = compss[i].price,
									comp = compss[i].comp,
									type = compss[i].type,
									name = compss[i].name
								})
							end
							if next(added) ~= nil then
								for k,v in pairs(added) do
									if v.name ~= compss[i].name and v.comp == compss[i].comp then
										table.remove(added,k)

									end
								end
								table.insert(added, {
									label = compss[i].label,
									model = compss[i].model,
									comp = compss[i].comp,
									type = compss[i].type,
									name = compss[i].name
								})
								
							else
								table.insert(added, {
									label = compss[i].label,
									model = compss[i].model,
									comp = compss[i].comp,
									type = compss[i].type,
									name = compss[i].name
								}) 
								
							end 
							for k,v in pairs(compss) do
								if v.comp ~= "comp" then
									if v.comp == compss[i].comp then
										RemoveWeaponComponentFromWeaponObject(wepobject, v.name)
									end
								end
							end
							if compss[i].model ~= 0 then
								LoadModel(compss[i].model)
								modelz = true
							end
							cal = true
							GiveWeaponComponentToEntity(wepobject,compss[i].name, -1, true)				
							
	
							if modelz then 
								SetModelAsNoLongerNeeded(compss[i].model)
								modelz = false

							end
						end
					end
				end
			end
		elseif WarMenu.IsMenuOpened('barrel') then
			if WarMenu.Button(Config2.Language.remove) then 
				cal = true
				for k,v in pairs(added) do
					if  v.comp == "barrel" then
						table.remove(added,k)
						RemoveWeaponComponentFromWeaponObject(wepobject, v.name)
					end
				end
				for k,v in pairs(pricing) do
					if  v.comp == "barrel" then
						table.remove(pricing,k)
					end
				end
			end
			for i = 1, #compss do
				if compss[i].confirmed == 1 then
					if compss[i].comp == "barrel" then
						if WarMenu.Button(Config2.Language.label..compss[i].label..Config2.Language.price..compss[i].price..Config2.Language.dollar) then
							if next(pricing) ~= nil then
								for k,v in pairs(pricing) do
									if v.name ~= compss[i].name and v.comp == compss[i].comp then
										table.remove(pricing,k)
									end
								end
								table.insert(pricing, {
									price = compss[i].price,
									comp = compss[i].comp,
									type = compss[i].type,
									name = compss[i].name
								})
							else
								table.insert(pricing, {
									price = compss[i].price,
									comp = compss[i].comp,
									type = compss[i].type,
									name = compss[i].name
								})
							end 
							if next(added) ~= nil then
								for k,v in pairs(added) do
									if v.name ~= compss[i].name and v.comp == compss[i].comp then
										table.remove(added,k)
									end
								end
								table.insert(added, {
									label = compss[i].label,
									model = compss[i].model,
									comp = compss[i].comp,
									type = compss[i].type,
									name = compss[i].name
								})
								
							else
								table.insert(added, {
									label = compss[i].label,
									model = compss[i].model,
									comp = compss[i].comp,
									type = compss[i].type,
									name = compss[i].name
								}) 
								
							end 
							for k,v in pairs(compss) do
								if v.comp ~= "comp" then
									if v.comp == compss[i].comp then
										RemoveWeaponComponentFromWeaponObject(wepobject, v.name)
									end
								end
							end
							if compss[i].model ~= 0 then
								LoadModel(compss[i].model)
								modelz = true
							end
							cal = true
							GiveWeaponComponentToEntity(wepobject,compss[i].name, -1, true)				

	
							if modelz then 
								SetModelAsNoLongerNeeded(compss[i].model)
								modelz = false

							end
						end
					end
				end
			end
		end
		WarMenu.Display()
        Citizen.Wait(0)
	end
end)

RegisterNetEvent("syn_weapons:givecomp") 
AddEventHandler("syn_weapons:givecomp", function(components,id,hash)
	globalhash = hash
	weaponid = id
	added = components
	local ped = PlayerPedId()
	wep = GetCurrentPedWeaponEntityIndex(ped, 0)
	_, wepHash = GetCurrentPedWeapon(ped, true, 0, true)
	TriggerEvent("syn_weapons:wepcomp")
	for k,v in pairs(compss) do
		RemoveWeaponComponentFromPed(PlayerPedId(), v.name, globalhash)
	end
	Citizen.Wait(500)
	for i = 1, #components do
		if components[i].model ~= 0 then
			LoadModel(components[i].model)
		end
		GiveWeaponComponentToEntity(PlayerPedId(), components[i].name, globalhash, true)
		if components[i].model ~= 0 then
			SetModelAsNoLongerNeeded(components[i].model)
		end
	end 
end) 



function whenKeyJustPressed(key)
	
    if Citizen.InvokeNative(0x580417101DDB492F, 0, key) then
        return true
    else
        return false
    end
end

RegisterNetEvent("syn_weapons:getgun")
AddEventHandler("syn_weapons:getgun", function(key,guncheck,qt,item,guncheck2,playeritem)
    local wephash = Citizen.InvokeNative(0x8425C5F057012DAB,PlayerPedId())
	local weaponName = tostring(Citizen.InvokeNative(0x89CF5FF3D363311E,wephash))
	local currentammo = GetPedAmmoByType(PlayerPedId(), GetHashKey(key))
	if (guncheck2 ~= 0 and Citizen.InvokeNative(guncheck2, wephash)) or Citizen.InvokeNative(guncheck,wephash) or guncheck == 0 then
        TriggerServerEvent("syn_weapons:addammo",wephash,qt,key,playeritem,item)

	else
		TriggerEvent("vorp:TipBottom", Config2.Language.wrongwptype, 4000)
		TriggerServerEvent("syn_weapons:givebackbox",item)
    end
end)

RegisterNetEvent("syn_weapons:givebackbox")
AddEventHandler("syn_weapons:givebackbox", function(item)
	TriggerServerEvent("syn_weapons:givebackbox",item)
end)
