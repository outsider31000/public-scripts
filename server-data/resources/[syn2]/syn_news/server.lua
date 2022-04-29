TriggerEvent("getCore",function(core)
    VorpCore = core
end)
VorpInv = exports.vorp_inventory:vorp_inventoryApi()

VorpInv.RegisterUsableItem("newspaper", function(data)
	TriggerClientEvent('syn_news:open', data.source)
end)

RegisterServerEvent('syn_news:getjob')
AddEventHandler('syn_news:getjob', function()
	local _source = source
	local Character = VorpCore.getUser(_source).getUsedCharacter
    local job = Character.job
	local news = {}
	exports.ghmattimysql:execute('SELECT * FROM newspaper', {}, function(result)
		if result[1] ~= nil then 
			news = json.decode(result[1].news)
		end
		TriggerClientEvent('syn_news:recjob', _source, job,news)
	end)
end)

RegisterServerEvent("syn_news:savenews")
AddEventHandler("syn_news:savenews", function(x)
    local _source = source
	exports.ghmattimysql:execute("TRUNCATE TABLE newspaper", {})
    local parameters = { ['news'] = json.encode(x)}
    exports.ghmattimysql:execute("INSERT INTO newspaper (`news`) VALUES ( @news)", parameters)
end)