local playerjob 
local name = "Input Name"
local reason = "Reason"
local bounty = 0
local bountylist = {}
local isDead = IsPedDeadOrDying(PlayerPedId())

RegisterNetEvent('syn_bounty:findjob')
AddEventHandler('syn_bounty:findjob', function(job)
	playerjob = job
end)

RegisterNetEvent('syn_bounty:findbounties')
AddEventHandler('syn_bounty:findbounties', function(bounties)
	bountylist = bounties
end)

RegisterNetEvent("syn_bounty:bountyboard")
AddEventHandler("syn_bounty:bountyboard", function()
	TriggerServerEvent("syn_bounty:getjob")
	TriggerServerEvent("syn_bounty:getbounties")
	Citizen.Wait(600)
	WarMenu.OpenMenu('bountyboard')
end)

RegisterNetEvent("vorp:SelectedCharacter")
AddEventHandler("vorp:SelectedCharacter", function(charid)
  TriggerEvent('syn_bounty:blip')
end)

RegisterNetEvent("syn_bounty:blip")
AddEventHandler("syn_bounty:blip", function()
	
  	for k, v in pairs(Config.Locations) do
		if v.blip then 
  	  		local blip = N_0x554d9d53f696d002(1664425300, v.Pos.x, v.Pos.y, v.Pos.z)
  	  		SetBlipSprite(blip, v.blipsprite, 1)
  	  		SetBlipScale(blip, 0.2)
			Citizen.InvokeNative(0x9CB1A1623062F402, blip, v.Name)
		end
	end

end)

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


Citizen.CreateThread( function()
    WarMenu.CreateMenu('bountyboard', "Bounty Board")
    WarMenu.CreateSubMenu('removebounty', 'bountyboard', "Remove Bounty")
    WarMenu.CreateSubMenu('checkbounty', 'bountyboard', "Wanted")
    WarMenu.CreateSubMenu('add', 'bountyboard', "Add Bounty")

    
    while true do
		if WarMenu.IsMenuOpened('bountyboard') then
			for k,v in pairs(Config.job) do
				if playerjob == v then
					if WarMenu.MenuButton("Add Bounty", 'add') then end
					if WarMenu.MenuButton("Remove Bounty", 'removebounty') then end
				end
			end
			if WarMenu.MenuButton("Check Bounties", 'checkbounty') then end
			if WarMenu.Button("Exit") then
				WarMenu.CloseMenu()
			end

        
		elseif WarMenu.IsMenuOpened('add') then
            if WarMenu.Button("Name: "..name) then 
				TriggerEvent("vorpinputs:getInput", "Confirm", "Name", function(cb)
                    local namex = cb
                    if namex ~= nil then
                        name = namex
                    end
               end)
			end
			if WarMenu.Button("Reason: "..reason) then 
				TriggerEvent("vorpinputs:getInput", "Confirm", "Reason", function(cb)
                    local reasonx = cb
                    if reasonx ~= nil then
                        reason = reasonx
                    end
               end)
			end
			if WarMenu.Button("Bounty: $"..bounty) then 
				TriggerEvent("vorpinputs:getInput", "Confirm", "Bounty", function(cb)
                    local testprice = tonumber(cb)
                    if testprice ~= nil and testprice ~= 0 and testprice > 0 then
                        bounty = testprice
                    end
               end)
			end
			if WarMenu.Button("Confirm") then 
				TriggerServerEvent("syn_bounty:addbounty",name,reason,bounty)
				bounty = 0
				name = "Input Name"
				reason = "Reason"
				WarMenu.CloseMenu()      
			end
        elseif WarMenu.IsMenuOpened('removebounty') then
			for i = 1, #bountylist do
				if WarMenu.Button("Name: "..bountylist[i].name.." / Bounty: "..bountylist[i].bounty) then
					TriggerServerEvent("syn_bounty:removebounty",bountylist[i].id)
					WarMenu.CloseMenu()      
				end
			end
		elseif WarMenu.IsMenuOpened('checkbounty') then
			for i = 1, #bountylist do
				if WarMenu.Button("Name: "..bountylist[i].name.."/ Reason: "..bountylist[i].reason.." / Bounty: "..bountylist[i].bounty) then end
			end
           
        end ----- end of menu
        WarMenu.Display()
        Citizen.Wait(0)
    end
end)