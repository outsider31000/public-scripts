local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

local DoorInfo	= {}

RegisterServerEvent('syn_doorlocks:Load')
AddEventHandler('syn_doorlocks:Load', function()
	for k, v in pairs(DoorInfo) do
		TriggerClientEvent('syn_doorlocks:setState', -1, v.doorID, v.state)
	end
end)

RegisterServerEvent('syn_doorlocks:updatedoorsv')
AddEventHandler('syn_doorlocks:updatedoorsv', function(source, doorID, cb)
    local _source = source
	
	local User = VorpCore.getUser(_source)
	local Character = User.getUsedCharacter
	local job = Character.job
	
	if not IsAuthorized(job, Config.DoorList[doorID]) then
		TriggerClientEvent("vorp:TipRight", _source, "No Key!", 5000)
		return
	else 
		TriggerClientEvent('syn_doorlocks:changedoor', _source, doorID)
	end
end)

RegisterServerEvent('syn_doorlocks:updateState')
AddEventHandler('syn_doorlocks:updateState', function(doorID, state, cb)
    local _source = source
	
	local User = VorpCore.getUser(_source)
	local Character = User.getUsedCharacter
	local job = Character.job
	
	if type(doorID) ~= 'number' then
		return
	end

	if not IsAuthorized(job, Config.DoorList[doorID]) then
		return
	end
	
	DoorInfo[doorID] = {
		doorID = doorID,
		state = state
	}

	TriggerClientEvent('syn_doorlocks:setState', -1, doorID, state)
end)

function IsAuthorized(jobName, doorID)
	for _,job in pairs(doorID.authorizedJobs) do
		if job == jobName then
			return true
		end
	end
	return false
end