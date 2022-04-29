local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

VorpInv = exports.vorp_inventory:vorp_inventoryApi()

-- Open ID card
RegisterServerEvent('syn_id:open')
AddEventHandler('syn_id:open', function(playerid,sex)
	print(playerid)
	local Character = VorpCore.getUser(source).getUsedCharacter
	local job = Character.job
	local jobgrade = Character.jobGrade
	local name = Character.firstname .. ' ' .. Character.lastname
	local type = 'id'
	local array = {}
	 array = {
		name = name,
		job = job,
		jobgrade = jobgrade
	}
	if playerid ~= nil then
		TriggerClientEvent('syn_id:open', playerid, array, type,sex,source)
		TriggerClientEvent('syn_id:open', source, array, type,sex,source)
	end
end)

RegisterServerEvent('syn_id:open2')
AddEventHandler('syn_id:open2', function(playerid,sex)
	local Character = VorpCore.getUser(playerid).getUsedCharacter
	local job = Character.job
	local jobgrade = Character.jobGrade
	local name = Character.firstname .. ' ' .. Character.lastname
	local type = 'id'
	local array = {}
	 array = {
		name = name,
		job = job,
		jobgrade = jobgrade
	}
		TriggerClientEvent('syn_id:open', source, array, type,sex,playerid)
end)
