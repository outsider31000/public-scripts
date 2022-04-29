
-----------------------------Place Animals /peds in cart nearby
local prompt = false
local AnimalPrompt

function SetupAnimalPrompt()
    Citizen.CreateThread(function()
        local str = 'Put in cart'
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

local models = {-1758092337}
Citizen.CreateThread(function()
	while true do 
		Wait(10)
		local veh = GetVehiclePedIsIn(PlayerPedId(),false)
		local model = GetEntityModel(veh)
		for k,v in pairs(models) do 
			if  model == v  then
				Citizen.InvokeNative(0x081FB9D6422F804C, veh,5,false)    
            	Citizen.InvokeNative(0xA9F1D75195CC40F6, veh,5,true) 
            	Citizen.InvokeNative(0x6A3C24B91FD0EA09, veh,5,true)
			end
		end
	end
end)


Citizen.CreateThread(function()
	SetupAnimalPrompt()
	while true do 
		Wait(100)
		local ped = PlayerPedId()
		coords = GetEntityCoords(ped)
		forwardoffset = GetOffsetFromEntityInWorldCoords(ped,0.0,2.0,0.0)
		local Pos2 = GetEntityCoords(ped)
		local targetPos = GetOffsetFromEntityInWorldCoords(obj3, -0.0, 1.1,-0.1)
		local rayCast = StartShapeTestRay(Pos2.x, Pos2.y, Pos2.z, forwardoffset.x, forwardoffset.y, forwardoffset.z,-1,ped,7)
		local A,hit,C,C,spot = GetShapeTestResult(rayCast)                
		local model = GetEntityModel(spot)
		cartcoords = GetEntityCoords(spot)
		for k,v in pairs(models) do 
			if  model == v  then-- or  then --1758092337 : WAGON05X
				local animal = Citizen.InvokeNative(0xD806CD2A4F2C2996, ped)
				if animal ~= false then
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
						DoScreenFadeOut(1800)
						Wait(2000)
						TriggerServerEvent('EveryoneTeleportEntity',pedid,cartcoords.x,cartcoords.y,cartcoords.z+1.5)
						SetEntityCoords(animalcheck,cartcoords.x,cartcoords.y,cartcoords.z+1.5,false)
						--FreezeEntityPosition(animalcheck, true)
						DoScreenFadeIn(3000)
						Wait(2000)
					end

					forwardoffset = GetOffsetFromEntityInWorldCoords(ped,0.0,2.0,0.0)
					local Pos2 = GetOffsetFromEntityInWorldCoords(ped, -0.0, 0.0,0.5)
					local targetPos = GetOffsetFromEntityInWorldCoords(obj3, -0.0, 1.1,-0.1)
					local rayCast = StartShapeTestRay(Pos2.x, Pos2.y, Pos2.z, forwardoffset.x, forwardoffset.y, forwardoffset.z,-1,ped,7)
					A,hit,B,C,spot = GetShapeTestResult(rayCast)
					NetworkRequestControlOfEntity(animalcheck)
					model = GetEntityModel(spot)
				else
					PromptSetEnabled(AnimalPrompt, false)
					PromptSetVisible(AnimalPrompt, false)
					prompt = false
				end
			else
				PromptSetEnabled(AnimalPrompt, false)
				PromptSetVisible(AnimalPrompt, false)
				prompt = false
			end
		end
	end
end)


RegisterNetEvent('EveryoneTeleportEntity')
AddEventHandler('EveryoneTeleportEntity', function(netid,x,y,z)
	ent = NetworkGetEntityFromNetworkId(netid)
	Wait(150)
	SetEntityCoords(ent,x,y,z)
end)
----------------------------------------------------------------------------------------




