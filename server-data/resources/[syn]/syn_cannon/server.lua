local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

VorpInv = exports.vorp_inventory:vorp_inventoryApi()


RegisterCommand("gat", function(source, args) 
  if args ~= nil then
    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
    local type =  tonumber(args[1])
    local job = "police"
    local job2 = Character.job
    local rank = Character.jobGrade
    if job == job2 and rank > 4 then
      TriggerClientEvent('syn_cannon:spawncannon',_source, type)
    else return false end
  end
end)




