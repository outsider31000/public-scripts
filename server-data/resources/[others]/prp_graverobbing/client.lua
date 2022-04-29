local gravestones = { "p_grave06x", "p_gravedugcover01x", "p_gravefresh01x", "p_gravemarker01x", "p_gravemarker02x", "p_gravestone_srd08x", "p_gravestone01ax", "p_gravestone01x", "p_gravestone03ax", "p_gravestone03x", "p_gravestone04x",                                               -- generic | p_graveyard.rpf
"p_gravestone05x", "p_gravestone06x", "p_gravestone07ax",  "p_gravestone07x",  "p_gravestone08ax", "p_gravestone08x", "p_gravestone09x", "p_gravestone14ax", "p_gravestone14x", "p_gravestone16ax", "p_gravestone16x",                                               -- generic | p_graveyard.rpf
"p_gravestonebroken01x", "p_gravestonebroken02x", "p_gravestonebroken05x", "p_gravestoneclean02ax", "p_gravestoneclean02x", "p_gravestoneclean03x", "p_gravestoneclean04ax",
"p_gravestoneclean04x", "p_gravestoneclean05ax", "p_gravestoneclean05x", "p_gravestoneclean06ax", "p_gravestoneclean06x", "p_gravestonejanedoe02x" }

RegisterNetEvent('GraveRobbing:TriggerRobbery')
AddEventHandler('GraveRobbing:TriggerRobbery', function()
	local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))

	for key, value in pairs(gravestones) do
		local gravestone = DoesObjectOfTypeExistAtCoords(x, y, z, 1.0, GetHashKey(value), true)

		if gravestone then
			local chance = math.random(1,100)
			if chance >= 50 then

				StartAnimation('script@mech@treasure_hunting@grab',0,'PBL_GRAB_01',0,1,true,20000)

				exports['progressBars']:startUI(20000, "Digging grave...")
	
				Wait(20000)

				TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 10000, true, false, false, false)
	
				exports['progressBars']:startUI(10000, "Searching grave...")

				Wait(10000)

				ClearPedTasks(PlayerPedId())
				
				TriggerServerEvent("wcrp:graverobbingreward")
			else
				StartAnimation('script@mech@treasure_hunting@nothing',0,'PBL_NOTHING_01',0,1,true,10000)

				exports['progressBars']:startUI(20000, "Digging grave...")
	
				Wait(20000)

				TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 10000, true, false, false, false)
	
				exports['progressBars']:startUI(10000, "Searching grave...")

				Wait(10000)
				
				ClearPedTasks(PlayerPedId())

				TriggerEvent('vorp:TipRight', 'Nothing found in the Grave.', 5000)
			end
		end
	end
end)

-- string, int, string, bool, bool, bool, int
function StartAnimation(animDict,flags,playbackListName,p3,p4,groundZ,time)
	Citizen.CreateThread(function()
		local player = PlayerPedId()
		local aCoord = GetEntityCoords(player)
		local pCoord = GetOffsetFromEntityInWorldCoords(PlayerPedId(), -10.0, 0.0, 0.0)

		local pRot = GetEntityRotation(player)

		if groundZ then
			local a, groundZ = GetGroundZAndNormalFor_3dCoord( aCoord.x, aCoord.y, aCoord.z + 10 )
			aCoord = {x=aCoord.x, y=aCoord.y, z=groundZ}
		end

		local animScene = Citizen.InvokeNative(0x1FCA98E33C1437B3, animDict, flags, playbackListName, 0, 1)
		-- SET_ANIM_SCENE_ORIGIN
		Citizen.InvokeNative(0x020894BF17A02EF2, animScene, aCoord.x, aCoord.y, aCoord.z, pRot.x, pRot.y, pRot.z, 2) 
		-- SET_ANIM_SCENE_ENTITY
		Citizen.InvokeNative(0x8B720AD451CA2AB3, animScene, "player", player, 0)
	    
	    	-- DIG UP A CHEST
	    	--local chest = CreateObjectNoOffset(GetHashKey('p_strongbox_muddy_01x'), pCoord, true, true, false, true)
	    	--Citizen.InvokeNative(0x8B720AD451CA2AB3, animScene, "CHEST", chest, 0)

	    	-- LOAD_ANIM_SCENE
	    	Citizen.InvokeNative(0xAF068580194D9DC7, animScene) 
	    	Citizen.Wait(1000)
	    	-- START_ANIM_SCENE
	    	print('START_ANIM_SCENE: '.. animScene)
	    	Citizen.InvokeNative(0xF4D94AF761768700, animScene) 
	    	if time then
	    		Citizen.Wait(tonumber(time))	
	    	else
	   		Citizen.Wait(10000) 
	    	end
			
	    	-- SET CHEST AS OPENED AFTER DUG UP
	    	-- Citizen.InvokeNative(0x188F8071F244B9B8, chest, 1) -- found native sets CHEST as OPENED		
	    	
		-- _DELETE_ANIM_SCENE
	    	Citizen.InvokeNative(0x84EEDB2C6E650000, animScene) 
   	end) 
end

--- DIG UP AND FIND NOTHING
--StartAnimation('script@mech@treasure_hunting@nothing',0,'PBL_NOTHING_01',0,1,true,10000)

--- DIG UP AND GRAB SOMETHING
-- StartAnimation('script@mech@treasure_hunting@grab',0,'PBL_GRAB_01',0,1,true,10000)

--- DIG UP CHEST ( NOTE: UNCOMMENT LINES to spawn chest )
-- StartAnimation('script@mech@treasure_hunting@chest',0,'PBL_CHEST_01',0,1,true,10000)
