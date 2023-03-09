local VORPcore = {}
local VORPInv = {}

local VORPInv = exports.vorp_inventory:vorp_inventoryApi()

TriggerEvent("getCore",function(core)
    VORPcore = core
end)

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

RegisterServerEvent('RSG:checkjob', function()
    local _source = source
    local Character = VORPcore.getUser(_source).getUsedCharacter
    local job = Character.job
    local count = VORPInv.getItemCount(_source, Config.shovelitem)
    TriggerClientEvent('RSG:sendjob', _source, job,count)
end)

RegisterServerEvent('syn_undertaker:reward')
AddEventHandler('syn_undertaker:reward', function()
    local _source = source
    local Character = VORPcore.getUser(_source).getUsedCharacter
    local job = Character.job
    local reward = math.random(Config.rewardmin,Config.rewardmax)
        local count = VORPInv.getItemCount(_source, Config.shovelitem)
            if contains (Config.jobs, job) then  
            local reward = math.random(Config.rewardmin,Config.rewardmax)
            Character.addCurrency(0, reward)
            VORPcore.NotifyRightTip(_source,"you where paid " .. reward,4000)
        else
            VORPcore.NotifyRightTip(_source,"dont have the job to be paid " .. reward,4000)
        end
    
end)



