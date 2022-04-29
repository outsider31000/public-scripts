local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

VorpInv = exports.vorp_inventory:vorp_inventoryApi()
VORP = exports.vorp_core:vorpAPI()

RegisterServerEvent('syn_bounty:getjob')
AddEventHandler('syn_bounty:getjob', function()
	local _source = source
	local Character = VorpCore.getUser(_source).getUsedCharacter
    local job = Character.job
	TriggerClientEvent('syn_bounty:findjob', _source, job)
end)

RegisterServerEvent('syn_bounty:addbounty')
AddEventHandler('syn_bounty:addbounty', function(name, reason, bounty)
	local Parameters = { ['name'] = name, ['reason'] = reason, ['bounty'] = bounty}
    exports.ghmattimysql:execute("INSERT INTO bountyboard ( `name`, `reason`, `bounty`) VALUES ( @name, @reason, @bounty)", Parameters)
end)

RegisterServerEvent('syn_bounty:getbounties')
AddEventHandler('syn_bounty:getbounties', function()
	local _source = source
	exports.ghmattimysql:execute('SELECT * FROM bountyboard', {}, function(result)
		local bounties = {}
		if result[1] ~= nil then 
			for i=1, #result, 1 do
				table.insert(bounties, {
					id = result[i].id,
					name = result[i].name,
					reason = result[i].reason,
					bounty = result[i].bounty
				})
				TriggerClientEvent('syn_bounty:findbounties', _source, bounties)
			end
		end
	end)
end)

RegisterServerEvent('syn_bounty:removebounty')
AddEventHandler('syn_bounty:removebounty', function(id)
	local _source = source
	exports.ghmattimysql:execute("DELETE FROM bountyboard WHERE id=@id", {["id"] = id})
end)


