local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

RegisterServerEvent("parks_stagecoach:pay_fare")
AddEventHandler("parks_stagecoach:pay_fare", function(fare)
    local Character = VorpCore.getUser(source).getUsedCharacter
    Character.addCurrency(0, fare)
end)

--- DATA BASE QUERIES

local function GetAmmoutStagecoaches(Player_ID, Character_ID)

    local HasStagecoaches = exports.ghmattimysql:execute( "SELECT * FROM stagecoaches WHERE identifier = @identifier AND charid = @charid ", {
        ['@identifier'] = Player_ID,
        ['@charid'] = Character_ID
    } )


    if #HasStagecoaches > 0 then 
        return true 
    end
    return false
    end

RegisterServerEvent("parks_stagecoach:buy_stagecoach")
AddEventHandler("parks_stagecoach:buy_stagecoach", function(args)
    local _price = args['Price']
    local _model = args['Model']
    local _name  = args['Name']
    local Character = VorpCore.getUser(source).getUsedCharacter
    u_identifier = Character.identifier
    u_charid = Character.charIdentifier
    u_money = Character.money

    Character.removeCurrency(0, _price)

    local Parameters = { ['identifier'] = u_identifier, ['charid'] = u_charid, ['stagecoach'] = _model, ['name'] = _name }
    exports.ghmattimysql:execute("INSERT INTO stagecoaches ( `identifier`, `charid`, `stagecoach`, `name` ) VALUES ( @identifier, @charid, @stagecoach, @name )", Parameters)
    TriggerClientEvent("vorp:TipRight", source, 'You got a new Stagecoach!', 2000)
    TriggerClientEvent("parks_stagecoach:SpawnWagon", source, _model)

end)

RegisterServerEvent("parks_stagecoach:loadstagecoach")
AddEventHandler("parks_stagecoach:loadstagecoach", function()
    local _source = source
    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
    u_identifier = Character.identifier
    u_charid = Character.charIdentifier

    local Parameters = { ['@identifier'] = u_identifier, ['@charid'] = u_charid }
    exports.ghmattimysql:execute('SELECT * FROM stagecoaches WHERE identifier = @identifier AND charid = @charid', Parameters, function(HasStagecoaches)
        if HasStagecoaches[1] then
            local stagecoach = HasStagecoaches[1].stagecoach

            TriggerClientEvent("parks_stagecoach:LoadCoachesMenu", _source, HasStagecoaches)
        end
    end)
end)

RegisterServerEvent("parks_stagecoach:StartCoachJobServer")
AddEventHandler("parks_stagecoach:StartCoachJobServer", function (zone_name, spawn_coach)
    TriggerClientEvent("parks_stagecoach:StartCoachJob", source, zone_name, spawn_coach)
end)