local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

local function GetAmountBoats(Player_ID, Character_ID)
    local HasBoates = exports.ghmattimysql:execute( "SELECT * FROM boates WHERE identifier = @identifier AND charid = @charid ", {
        ['identifier'] = Player_ID,
        ['charid'] = Character_ID
    } )

    if #HasBoates > 0 then
        return true
    end

    return false
end

RegisterServerEvent('elrp:buyboat')
AddEventHandler( 'elrp:buyboat', function (args)
    local _price    = args['Price']
    local _model    = args['Model']
    local _name     = args['Name']
    local User = VorpCore.getUser(source).getUsedCharacter
    u_identifier = User.identifier
    u_charid = User.charIdentifier
    u_money = User.money

    if u_money < _price then
        TriggerClientEvent("vorp:TipBottom", source, "You don't have enough money", 3000)
        return
    end

    User.removeCurrency(0, _price)

    local Parameters = { ['identifier'] = u_identifier, ['charid'] = u_charid, ['boat'] = _model, ['name'] = _name }
    exports.ghmattimysql:execute("INSERT INTO boates ( `identifier`, `charid`, `boat`, `name` ) VALUES ( @identifier, @charid, @boat, @name )", Parameters)
    TriggerClientEvent("vorp:TipBottom", source, "You Purchased a boat", 3000)
    TriggerClientEvent("elrp:spawnBoat", source, _model)
end)

RegisterServerEvent('elrp:loadownedboats')
AddEventHandler('elrp:loadownedboats', function()
    local _source = source
    local User = VorpCore.getUser(_source).getUsedCharacter
    u_identifier = User.identifier
    u_charid = User.charIdentifier

    local Parameters = { ['@identifier'] = u_identifier, ['@charid'] = u_charid }
    exports.ghmattimysql:execute('SELECT * FROM boates WHERE identifier = @identifier AND charid = @charid', Parameters, function(HasBoats)
        if HasBoats[1] then
            local boat = HasBoats[1].boat

            TriggerClientEvent("elrp:loadBoatsMenu", _source, HasBoats)
        end
    end)
end)