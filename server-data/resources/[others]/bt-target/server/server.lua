local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

RegisterServerEvent("target:checkjob")
AddEventHandler("target:checkjob", function()
    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
    local job = Character.job
    TriggerClientEvent("target:jobchecked", _source, job)
end)