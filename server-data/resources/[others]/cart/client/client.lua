local prompt = false
local AnimalPrompt

function SetupAnimalPrompt()
    Citizen.CreateThread(function()
        local str = 'In Kutsche legen'
        AnimalPrompt = PromptRegisterBegin()
        PromptSetControlAction(AnimalPrompt, 0xE8342FF2)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(AnimalPrompt, str)
        PromptSetEnabled(AnimalPrompt, false)
        PromptSetVisible(AnimalPrompt, false)
        PromptSetHoldMode(AnimalPrompt, true)
        PromptRegisterEnd(AnimalPrompt)

    end)
end

local models = {
	-1758092337,
	1596452133,
	-283162583, 
	661519966, 
	47200842, 
	219205323, 
	-824257932, 
	-1347283941, 
	-570691410, 
	-377157708, 
	1770617692, 
	87577242, 
	-1698498246, 
	-1308375373, 
	822759307,
	-1753201617,
	-332781688,
	-1866132622,
	1874711736,
	1172094279,
	1016623270
}

Citizen.CreateThread(function()
	while true do
		local veh = GetVehiclePedIsIn(PlayerPedId(),false)
		local model = GetEntityModel(veh)
		for k,v in pairs(models) do 
			if  model == v then
				Citizen.InvokeNative(0x081FB9D6422F804C, veh,5,false)    
				Citizen.InvokeNative(0xA9F1D75195CC40F6, veh,5,true) 
				Citizen.InvokeNative(0x6A3C24B91FD0EA09, veh,5,true)
			end
			Wait(500)
		end
	end
end)


Citizen.CreateThread(function()
	SetupAnimalPrompt()
	while true do 
		Wait(300)
		local ped = PlayerPedId()
		local animal = Citizen.InvokeNative(0xD806CD2A4F2C2996, ped)
		if animal ~= false then
			coords = GetEntityCoords(ped)
			local forwardoffset = GetOffsetFromEntityInWorldCoords(ped,0.0,2.0,0.0)
			local Pos2 = GetEntityCoords(ped)
			local targetPos = GetOffsetFromEntityInWorldCoords(obj3, -0.0, 1.5,-0.1)
			local rayCast = StartShapeTestRay(Pos2.x, Pos2.y, Pos2.z, forwardoffset.x, forwardoffset.y, forwardoffset.z,-1,ped,7)
			local A,hit,B,C,spot = GetShapeTestResult(rayCast)                
			local cartcoords = GetEntityCoords(spot)
			local model = GetEntityModel(spot)
			for k,v in pairs(models) do
				if  model == v  then
					if prompt == false then
						PromptSetEnabled(AnimalPrompt, true)
						PromptSetVisible(AnimalPrompt, true)
						prompt = true
					end
					if PromptHasHoldModeCompleted(AnimalPrompt) then
						PromptSetEnabled(AnimalPrompt, false)
						PromptSetVisible(AnimalPrompt, false)
						prompt = false
						animalcheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, ped)
						pedid = NetworkGetNetworkIdFromEntity(animalcheck)
						Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), animalcheck, GetEntityCoords(PlayerPedId()), 10.0, true)
						Wait(1000)
						TriggerServerEvent('EveryoneTeleportEntity',pedid,cartcoords.x,cartcoords.y,cartcoords.z+1.0)
						SetEntityCoords(animalcheck,cartcoords.x,cartcoords.y,cartcoords.z+1.0,false)
						Wait(1000)
					end
					local forwardoffset = GetOffsetFromEntityInWorldCoords(ped,0.0,2.0,0.0)
					local Pos2 = GetOffsetFromEntityInWorldCoords(ped, -0.0, 0.0,0.5)
					local targetPos = GetOffsetFromEntityInWorldCoords(obj3, -0.0, 1.5,-0.1)
					local rayCast = StartShapeTestRay(Pos2.x, Pos2.y, Pos2.z, forwardoffset.x, forwardoffset.y, forwardoffset.z,-1,ped,7)
					local A,hit,B,C,spot = GetShapeTestResult(rayCast)
					NetworkRequestControlOfEntity(animalcheck)
					local model = GetEntityModel(spot)
				else
					PromptSetEnabled(AnimalPrompt, false)
					PromptSetVisible(AnimalPrompt, false)
					prompt = false
				end
				break
			end
	    else
		    PromptSetEnabled(AnimalPrompt, false)
		    PromptSetVisible(AnimalPrompt, false)
		    prompt = false
	    end
	end
end)

RegisterNetEvent('EveryoneTeleportEntity')
AddEventHandler('EveryoneTeleportEntity', function(netid,x,y,z)
	ent = NetworkGetEntityFromNetworkId(netid)
	Wait(300)
	SetEntityCoords(ent,x,y,z)
end)