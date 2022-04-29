local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)


RegisterServerEvent("ambulancejob:CobrarRevivir")
AddEventHandler("ambulancejob:CobrarRevivir", function()
    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
    Character.removeCurrency(0, 40) -- change qt of money here 
 end)