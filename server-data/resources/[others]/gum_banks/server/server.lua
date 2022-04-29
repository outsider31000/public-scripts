local VorpCore = {}
TriggerEvent("getCore",function(core)
	VorpCore = core
end)
local money_state_d = 0
local money_state_g = 0
local send_money_client = 0
local send_dolar_client = 0
local use_bank = 0


RegisterServerEvent('gum_bank:bank_check')
AddEventHandler( 'gum_bank:bank_check', function(city)
	local _source = source
	local User = VorpCore.getUser(_source)
	local Character = User.getUsedCharacter
	local u_identifier = Character.identifier
	local u_charid = Character.charIdentifier
	local firstname = Character.firstname
	local lastname = Character.lastname
	local user_money = Character.money
	local user_gold = Character.gold
	local u_city = city
	if User ~= nil then
		exports.ghmattimysql:execute("SELECT * FROM bank_users WHERE identifier = @identifier AND charidentifier = @charidentifier AND name = @name", {['identifier'] = u_identifier, ['charidentifier'] = u_charid, ['name'] = u_city}, function(result)
			if result[1] then
				local money_state_d = result[1].money
				local money_state_g = result[1].gold
				TriggerClientEvent("gum_bank:money_state", _source, money_state_d, money_state_g,firstname, lastname, u_city, user_money, user_gold)
			else
				TriggerClientEvent("vorp:TipRight", _source, ""..Config.Bank_Create_Account.." "..u_city.."~q~ ", 5000)
				TriggerClientEvent("gum_bank:create_account", _source)
				local Parameters = { ['identifier'] = u_identifier, ['charidentifier'] = u_charid, ['money'] = 0, ['name'] = u_city }
				exports.ghmattimysql:execute("INSERT INTO bank_users ( `identifier`,`charidentifier`,`money`,`name` ) VALUES ( @identifier,@charidentifier,@money,@name )", Parameters)
			end
		return false
		end)
	end
end)

RegisterServerEvent('gum_bank:update_add_money')
AddEventHandler( 'gum_bank:update_add_money', function (now_bank_money, set_money, city)
	local _source = source
	local User = VorpCore.getUser(_source)
	local Character = User.getUsedCharacter
	local u_identifier = Character.identifier
	local u_charid = Character.charIdentifier
	local set_money_fix = tonumber(string.format("%.2f", set_money))
	local money_status = tonumber(string.format("%.2f", now_bank_money))
	local add_reward_money = tonumber(string.format("%.2f", money_status+set_money_fix))
	local u_city = city
	local user_money = Character.money
    if set_money_fix <= user_money then
		Character.removeCurrency(0, set_money_fix)
		TriggerClientEvent("vorp:TipRight", _source, ""..Config.Bank_Add_Gold.." ~e~"..set_money_fix.." $~q~ ", 5000)
		TriggerClientEvent("vorp:TipRight", _source, ""..Config.Bank_Now.."  ~e~"..add_reward_money.." $~q~ ", 5000)
		exports.ghmattimysql:execute( "SELECT * FROM bank_users WHERE identifier = @identifier and charidentifier = @charidentifier and name = @name", {['identifier'] = u_identifier, ['charidentifier'] = u_charid, ['name'] = u_city}, function(result)
			if result[1] then
				local Parameters = { ['identifier'] = u_identifier, ['charidentifier'] = u_charid,  ['money'] = add_reward_money, ['name'] = u_city }
				exports.ghmattimysql:execute("UPDATE bank_users SET money = @money WHERE identifier = @identifier AND charidentifier = @charidentifier AND name = @name", Parameters)
			else
				local Parameters = { ['identifier'] = u_identifier, ['charidentifier'] = u_charid, ['money'] = add_reward_money, ['name'] = u_city }
				exports.ghmattimysql:execute("INSERT INTO bank_users ( `identifier`,`charidentifier`,`money`,`name` ) VALUES ( @identifier,@charidentifier,@money,@name )", Parameters)
			end
			return false
		end)
	end
end)

RegisterServerEvent('gum_bank:update_remove_money')
AddEventHandler( 'gum_bank:update_remove_money', function (now_bank_money, set_money, city)
	local _source = source
	local User = VorpCore.getUser(_source)
	local Character = User.getUsedCharacter
	local u_identifier = Character.identifier
	local u_charid = Character.charIdentifier
	local set_money_fix = tonumber(string.format("%.2f", set_money))
	local money_status = tonumber(string.format("%.2f", now_bank_money))
	local remove_reward_money = tonumber(string.format("%.2f", money_status-set_money_fix))
	local u_city = city
	if money_status >= set_money_fix then
		TriggerClientEvent("vorp:TipRight", _source, ""..Config.Bank_Remove_Money.." ~e~"..set_money.." $~q~ ", 5000)
		TriggerClientEvent("vorp:TipRight", _source, ""..Config.Bank_Now.." ~e~"..remove_reward_money.." $~q~ ", 5000)
		Character.addCurrency(0, set_money)
		exports.ghmattimysql:execute( "SELECT * FROM bank_users WHERE identifier = @identifier and charidentifier = @charidentifier and name = @name", {['identifier'] = u_identifier, ['charidentifier'] = u_charid, ['name'] = u_city}, function(result)
			if result[1] then
				local Parameters = { ['identifier'] = u_identifier, ['charidentifier'] = u_charid, ['money'] = remove_reward_money, ['name'] = u_city }
				exports.ghmattimysql:execute("UPDATE bank_users SET money = @money WHERE identifier = @identifier AND charidentifier = @charidentifier AND name = @name", Parameters)
			else
				local Parameters = { ['identifier'] = u_identifier, ['charidentifier'] = u_charid, ['money'] = remove_reward_money, ['name'] = u_city}
				exports.ghmattimysql:execute("INSERT INTO bank_users ( `identifier`,`charidentifier`,`money`,`name` ) VALUES ( @identifier,@charidentifier,@money,@name )", Parameters)
			end
			return false
		end)
	else
		TriggerClientEvent("vorp:TipRight", _source, ""..Config.Dont_Have.."~e~"..set_money.." $~q~ ", 5000)
	end
end)



RegisterServerEvent('gum_bank:update_add_gold')
AddEventHandler( 'gum_bank:update_add_gold', function (now_bank_gold, set_gold, city)
	local _source = source
	local User = VorpCore.getUser(_source)
	local Character = User.getUsedCharacter
	local set_gold_fix = tonumber(string.format("%.2f", set_gold))
	local gold_status = tonumber(string.format("%.2f", now_bank_gold))
	local u_identifier = Character.identifier
	local u_charid = Character.charIdentifier
	local add_reward_gold = tonumber(string.format("%.2f", gold_status+set_gold_fix))
	local u_city = city
	Character.removeCurrency(0, set_gold_fix)
	TriggerClientEvent("vorp:TipRight", _source, ""..Config.Bank_Add_Gold.." ~e~"..set_gold_fix.." G~q~ ", 5000)
	TriggerClientEvent("vorp:TipRight", _source, ""..Config.Bank_Now.." ~e~"..add_reward_gold.." $~q~ ", 5000)
	exports.ghmattimysql:execute( "SELECT * FROM bank_users WHERE identifier = @identifier and charidentifier = @charidentifier and name = @name", {['identifier'] = u_identifier, ['charidentifier'] = u_charid, ['name'] = u_city}, function(result)
		if result[1] then
			local Parameters = { ['identifier'] = u_identifier, ['charidentifier'] = u_charid,  ['gold'] = add_reward_gold, ['name'] = u_city }
			exports.ghmattimysql:execute("UPDATE bank_users SET gold = @gold WHERE identifier = @identifier AND charidentifier = @charidentifier AND name = @name", Parameters)
		else
			local Parameters = { ['identifier'] = u_identifier, ['charidentifier'] = u_charid, ['gold'] = add_reward_gold, ['name'] = u_city }
			exports.ghmattimysql:execute("INSERT INTO bank_users ( `identifier`,`charidentifier`,`gold`,`name` ) VALUES ( @identifier,@charidentifier,@gold,@name )", Parameters)
		end
		return false
	end)
end)

RegisterServerEvent('gum_bank:update_remove_gold')
AddEventHandler( 'gum_bank:update_remove_gold', function (now_bank_gold, set_gold, city)
	local _source = source
	local User = VorpCore.getUser(_source)
	local Character = User.getUsedCharacter
	local u_identifier = Character.identifier
	local u_charid = Character.charIdentifier
	local user_gold = Character.gold
	local set_gold_fix = tonumber(string.format("%.2f", set_gold))
	local gold_status = tonumber(string.format("%.2f", now_bank_gold))
	local remove_reward_gold = tonumber(string.format("%.2f", gold_status-set_gold_fix))
	local u_city = city
	if gold_status >= set_gold_fix then
		Character.addCurrency(1, set_gold_fix)
		TriggerClientEvent("vorp:TipRight", _source, ""..Config.Bank_Remove_Money.." ~e~"..set_gold.." G~q~ ", 5000)
		TriggerClientEvent("vorp:TipRight", _source, ""..Config.Bank_Now.." ~e~"..remove_reward_gold.." G~q~ ", 5000)
		exports.ghmattimysql:execute( "SELECT * FROM bank_users WHERE identifier = @identifier and charidentifier = @charidentifier and name = @name", {['identifier'] = u_identifier, ['charidentifier'] = u_charid, ['name'] = u_city}, function(result)
			if result[1] then
				local Parameters = { ['identifier'] = u_identifier, ['charidentifier'] = u_charid, ['gold'] = remove_reward_gold, ['name'] = u_city }
				exports.ghmattimysql:execute("UPDATE bank_users SET gold = @gold WHERE identifier = @identifier AND charidentifier = @charidentifier AND name = @name", Parameters)
			else
				local Parameters = { ['identifier'] = u_identifier, ['charidentifier'] = u_charid, ['gold'] = remove_reward_gold, ['name'] = u_city}
				exports.ghmattimysql:execute("INSERT INTO bank_users ( `identifier`,`charidentifier`,`gold`,`name` ) VALUES ( @identifier,@charidentifier,@gold,@name )", Parameters)
			end
			return false
		end)
	else
		TriggerClientEvent("vorp:TipRight", _source, ""..Config.Dont_Have.." ~e~"..set_gold.." G~q~ ", 5000)
	end
end)
