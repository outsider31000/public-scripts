local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

VorpInv = exports.vorp_inventory:vorp_inventoryApi()
function contains(table, element)
    if table ~= 0 then 
        for k, v in pairs(table) do
            if v == element then
                return true
            end
        end
    end
return false
end

RegisterServerEvent("syn_alert:sendalert")
AddEventHandler("syn_alert:sendalert", function(players, job,alert,blip,doctor)
    local _source = source
    local players = GetPlayers()
    if contains(job, "doctor") then 
        local doctors = 0 
        for z, m in pairs(players) do
            local User = VorpCore.getUser(m)
            local used = User.getUsedCharacter
            if used.job == "doctor" then
                doctors = doctors + 1 
                TriggerClientEvent("vorp:TipRight", m, alert , 50000)
                TriggerClientEvent("syn_alert:createblip",m,blip,doctor,_source)
            end
        end
        if doctors == 0 then 
            TriggerClientEvent("syn_alert:cantalert",_source)
        end
    else
        for z, m in pairs(players) do
            local User = VorpCore.getUser(m)
            local used = User.getUsedCharacter
            for k,v in pairs(job) do 
                if used.job == v then
                    TriggerClientEvent("vorp:TipRight", m, alert , 50000)
                    TriggerClientEvent("syn_alert:createblip",m,blip,doctor,_source)
                end
            end
        end 
    end
end)

RegisterServerEvent("syn_alert:inform")
AddEventHandler("syn_alert:inform", function(player)
    local _source = source
    TriggerClientEvent("syn_alert:recresp",player)
end)