local VORP_INV = exports.vorp_inventory:vorp_inventoryApi()
local VORP_API = exports.vorp_core:vorpAPI()
local webhook = ""
local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)


RegisterServerEvent("lawmen:checkmyjob")
AddEventHandler("lawmen:checkmyjob", function()
    local player = VorpCore.getUser(source).getUsedCharacter
    local pJob = player.job
    TriggerClientEvent("lawmen:thejob",source,pJob)
end)

RegisterServerEvent("lawmen:goondutysv")
AddEventHandler("lawmen:goondutysv", function(ptable)
    local cops = 0

    for _,i in pairs(ptable) do
        local player = VorpCore.getUser(i).getUsedCharacter
        local pJob = player.job
        local grade = player.jobGrade

        for k,v in pairs(Marshal_Jobs) do
            if pJob == v then
                if (pJob == 'police' or pJob == 'wepolice' or pJob == 'nhpolice' or pJob == 'lepolice' or pJob == 'marshal' or pJob == 'pinkerton' or pJob == 'ranger') then
                    cops = cops + 1
                end
            end
        end
    end


    for k,v in pairs(OffDutyJobs) do
        local _source = source
        local player = VorpCore.getUser(_source).getUsedCharacter
        local job = player.job
        local grade = player.jobGrade
        local playername = player.firstname.. ' ' ..player.lastname
        if cops < Config.MaxCops then
            if job == 'offpolice' then
                player.setJob('police', grade)
                local message = playername.. " Went On Duty as police " ..grade
                TriggerEvent('Log', webhook, "Police Duty", message, 255)
                TriggerClientEvent('vorp:TipRight', _source, 'You are now On Duty')
            elseif job == 'offwepolice' then
                player.setJob('wepolice', grade)
                local message = playername.. " Went On Duty as wepolice " ..grade
                TriggerEvent('Log', webhook, "Police Duty", message, 255)
                TriggerClientEvent('vorp:TipRight', _source, 'You are now On Duty')
            elseif job == 'offnhpolice' then
                player.setJob('nhpolice', grade)
                local message = playername.. " Went On Duty as nhpolice " ..grade
                TriggerEvent('Log', webhook, "Police Duty", message, 255)
                TriggerClientEvent('vorp:TipRight', _source, 'You are now On Duty')
            elseif job == 'offlepolice' then
                player.setJob('lepolice', grade)
                local message = playername.. " Went On Duty as lepolice " ..grade
                TriggerEvent('Log', webhook, "Police Duty", message, 255)
                TriggerClientEvent('vorp:TipRight', _source, 'You are now On Duty')
            elseif job == 'offmarshal' then
                player.setJob('marshal', grade)
                local message = playername.. " Went On Duty as marshal " ..grade
                TriggerEvent('Log', webhook, "Police Duty", message, 255)
                TriggerClientEvent('vorp:TipRight', _source, 'You are now On Duty')
            elseif job == 'offpinkerton' then
                player.setJob('pinkerton', grade)
                local message = playername.. " Went On Duty as pinkerton " ..grade
                TriggerEvent('Log', webhook, "Police Duty", message, 255)
                TriggerClientEvent('vorp:TipRight', _source, 'You are now On Duty')
            elseif job == 'offranger' then
                player.setJob('ranger', grade)
                local message = playername.. " Went On Duty as ranger " ..grade
                TriggerEvent('Log', webhook, "Police Duty", message, 255)
                TriggerClientEvent('vorp:TipRight', _source, 'You are now On Duty')
            end
            TriggerClientEvent("lawmen:onduty", _source, true)
        else
            TriggerClientEvent("vorp:TipRight", _source, "You cannot take duty. Max cops online: "..Config.MaxCops, 2000)
        end
        break
    end
end)

RegisterServerEvent("lawmen:gooffdutysv")
AddEventHandler("lawmen:gooffdutysv", function()
    local _source = source
    local player = VorpCore.getUser(_source).getUsedCharacter
    local job = player.job
    local grade = player.jobGrade
    local playername = player.firstname.. ' ' ..player.lastname
    for k,v in pairs(Marshal_Jobs) do
        if v == job then
            player.setJob('off'..job, grade)
            local message = playername.. " Went Off Duty as off"..job.. ' ' ..grade
            TriggerEvent('Log', webhook, "Police Duty", message, 255)
            TriggerClientEvent('vorp:TipRight', _source, 'You are now Off Duty')
            TriggerClientEvent("lawmen:offdutycl", _source, false)
        end
        TriggerClientEvent("lawmen:onduty", _source, false)
    end
end)

RegisterServerEvent('lawmen:FinePlayer')
AddEventHandler('lawmen:FinePlayer', function(player, amount)
    local _source = source
    local User = VorpCore.getUser(player)
    local Police = VorpCore.getUser(_source)
    local Target = User.getUsedCharacter
    local pCharacter = Police.getUsedCharacter
    local fine = tonumber(amount)

    for i,v in pairs(Marshal_Jobs) do
        if v == pCharacter.job then
            pJob = v
            local Society_Account = pJob
            if pCharacter.job == Society_Account then
                if Target.money < fine then
                    Target.removeCurrency(0, Target.money)
                    exports.ghmattimysql:executeSync('UPDATE society_ledger SET ledger = ledger + @fine WHERE job = @job', { fine = Target.money, job = Society_Account})
                else
                    Target.removeCurrency(0, fine)
                    exports.ghmattimysql:executeSync('UPDATE society_ledger SET ledger = ledger + @fine WHERE job = @job', { fine = fine, job = Society_Account })
                end
                TriggerClientEvent("vorp:TipRight", _source, 'You fined '..Target.firstname..' '..Target.lastname..' $'..amount, 10000)
                TriggerClientEvent("vorp:TipRight", player, 'You received a fine of $'..fine, 10000)
            end
        end
    end
end)

RegisterServerEvent('lawmen:savetime')
AddEventHandler('lawmen:savetime', function(player, amount)
    local _source = source
    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
    local identifier = Character.identifier
    local characterid = Character.charIdentifier
    local time_s = --[[ getTime() + ]] amount
    exports.ghmattimysql:executeSync('UPDATE jail SET time_s =@time_s WHERE identifier = @identifier AND characterid = @characterid ', { time_s =time_s, identifier = identifier, characterid = characterid})
end)

RegisterServerEvent('lawmen:JailPlayer')
AddEventHandler('lawmen:JailPlayer', function(player, amount)
    local _source = source
    local user_name = GetPlayerName(player)
    local User = VorpCore.getUser(player)
    local CharInfo = User.getUsedCharacter
    local steam_id = CharInfo.identifier
    local Character = CharInfo.charIdentifier

    -- TIME
    local time_m = tostring(amount)
    local amount = amount * 60
    local timestamp = getTime() + amount

    exports.ghmattimysql:execute("INSERT INTO jail (identifier, characterid, name, time, time_s) VALUES (@identifier, @characterid, @name, @timestamp, @time)", {["@identifier"] = steam_id, ["@characterid"] = Character, ["@name"] = user_name, ["@timestamp"] = timestamp, ["@time"] = amount}, function(result)
        if result ~= nil then
            TriggerClientEvent("lawmen:JailPlayer", player, amount)
        else
            TriggerClientEvent("vorp:TipRight", _source, 'An error occurred in that query', 5000)
        end
    end)
end)

RegisterServerEvent("lawmen:unjail")
AddEventHandler("lawmen:unjail", function(target_id)
    local _source = source
    local User = VorpCore.getUser(target_id)
    local CharInfo = User.getUsedCharacter
    local steam_id = CharInfo.identifier
    local Character = CharInfo.charIdentifier

    exports.ghmattimysql:execute("DELETE FROM jail WHERE identifier = @identifier AND characterid = @characterid", {["@identifier"] = steam_id, ["@characterid"] = Character}, function(result)
        if result ~= nil then
            TriggerClientEvent("lawmen:UnjailPlayer", target_id)
        else
            TriggerClientEvent("vorp:TipRight", _source, 'An error occurred in that query', 5000)
        end
    end)
end)

RegisterServerEvent('lawmen:GetID')
AddEventHandler('lawmen:GetID', function(player)
    local _source = tonumber(source)

    local User = VorpCore.getUser(player)
    local Target = User.getUsedCharacter

    TriggerClientEvent("vorp:TipRight", _source, 'Name: '..Target.firstname..' '..Target.lastname, 10000)
    TriggerClientEvent("vorp:TipRight", _source, 'Job: '..Target.job, 10000)
end)

RegisterServerEvent('lawmen:getVehicleInfo')
AddEventHandler('lawmen:getVehicleInfo', function(player, mount)
    local _source = tonumber(source)

    local User = VorpCore.getUser(player)
    local Character = User.getUsedCharacter

    exports.ghmattimysql:execute("SELECT * FROM `stables` WHERE charidentifier=@identifier", {identifier=Character.charIdentifier}, function(result)
        local found = false
        if result[1] then
            for i,v in pairs(result) do
                if GetHashKey(v.modelname) == mount then
                    found = true
                    TriggerClientEvent("vorp:TipRight", _source, 'Vehicle/Horse Owned By: '..Character.firstname..' '..Character.lastname, 10000)
                end
            end
        end
        if not found then
            TriggerClientEvent("vorp:TipRight", _source, "Vehicle/Horse not owned by anyone", 10000)
        end
    end)
end)

RegisterServerEvent('lawmen:handcuff')
AddEventHandler('lawmen:handcuff', function(player)
    TriggerClientEvent('lawmen:handcuff', player)
end)

RegisterServerEvent('lawmen:lockpicksv')
AddEventHandler('lawmen:lockpicksv', function(player)
    local _source = source
    local chance = math.random(1,100)
    local user = VorpCore.getUser(_source).getUsedCharacter
    if chance < 5 then
        VORP_INV.subItem(_source, 'lockpick', 1)
        TriggerClientEvent("vorp:TipBottom", _source, "~pa~"..user.firstname.." "..user.lastname.."~q~: Gosh Darnit! My Lockpick broke!", 2000)
    else
        TriggerClientEvent('lawmen:lockpicked', player)
    end
end)

RegisterServerEvent("lawmen:putinoutvehicle")
AddEventHandler("lawmen:putinoutvehicle", function(player)
    TriggerClientEvent('lawmen:putinoutvehicle', player)
end)

RegisterServerEvent('lawmen:drag')
AddEventHandler('lawmen:drag', function(target)
    local _source = source
    local user = VorpCore.getUser(_source).getUsedCharacter
    for i,v in pairs(Marshal_Jobs) do
        if user.job == v then
            TriggerClientEvent('lawmen:drag', target, _source)
        else
            print(('lawmen: %s attempted to drag a player (is not police)!'):format(GetPlayerName(_source)))
        end
    end
end)

RegisterServerEvent("lawmen:check_jail")
AddEventHandler("lawmen:check_jail", function()
    local _source = source

    Citizen.Wait(2000)

    local User = VorpCore.getUser(_source)
    local CharInfo = User.getUsedCharacter
    local steam_id = CharInfo.identifier

    local Character = CharInfo.charIdentifier

    exports.ghmattimysql:execute("SELECT * FROM jail WHERE identifier = @identifier AND characterid = @characterid", {["@identifier"] = steam_id, ["@characterid"] = Character}, function(result)

        if result[1] ~= nil then
            local time = result[1]["time_s"]
            time = tonumber(time)
            TriggerClientEvent("lawmen:JailPlayer", _source, time)
        end
    end)
end)

RegisterServerEvent("lawmen:guncabinet")
AddEventHandler("lawmen:guncabinet", function(weapon, ammoList, compList)
    local _source = source
    VORP_INV.createWeapon(_source, weapon, ammoList, compList)
end)

function getTime ()
    return os.time(os.date("!*t"))
end

RegisterServerEvent('lawmen:lockpick:break')
AddEventHandler('lawmen:lockpick:break', function()
    local _source = source
	local user = VorpCore.getUser(_source).getUsedCharacter
	VorpInv.subItem(_source, "lockpick", 1)
	TriggerClientEvent("vorp:TipBottom", _source, "Gosh Darnit!, My Lockpick broke!", 2000)	
end)

--[[ VORP_INV.RegisterUsableItem("lockpick", function(data)
    VORP_INV.CloseInv(data.source)
    TriggerClientEvent("lawmen:lockpick", data.source)
end) ]]

VORP_INV.RegisterUsableItem("handcuffs", function(data)
    VORP_INV.CloseInv(data.source)
    TriggerClientEvent("lawmen:cuffs", data.source)
end)