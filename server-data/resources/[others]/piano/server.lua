local tipchance    = 75     -- This is the percentage chance that a person gets a tip
local use_xp       = true   -- false will disable the xp system for this script
local use_econ     = true   -- false will disable the tip system for this script
 
local real_eco_mod = 0.02   -- multiple the results of the tip by this number 0.02 then 1$ = 2cents is default 0.01 - 1.0 is the recommended range

-- money and xp are rsemi random numbers upper and lower are the limits of those number Random number 1 to 5 is set for money by default and xp
-- is set to 10 to 40... Note that the results for price will be multiplied by the real_eco_mod value.

local lower_money  = 1 -- must be a whole number
local upper_money  = 5 -- must be a whole number
local lower_xp     = 10 
local upper_xp     = 40 





---DO NOT edit below this line -- 



RegisterServerEvent('piano:AddSomeMoney')
AddEventHandler('piano:AddSomeMoney', function()
	
	local _source = source
	local tipres = 100
	local price = 0
	local xp = 0


	tipres = math.random(1,100)

	price = math.random(lower_money,upper_money)
        price = price * real_eco_mod

	xp = math.random(lower_xp,upper_xp) 




-- will get players level and do some math this will modify the xp and gold values by a Star Rating higher level gives you a better chance of success --



    TriggerEvent("vorp:getCharacter", _source, function(user)
        
	        if use_econ == true then
			if tipres <= tipchance then
				if price <= 0.01 then price = 0.01 end
        			TriggerEvent("vorp:addMoney", _source, 0, price)
			end
 		end
	
                if use_xp == true then
        		TriggerEvent("vorp:addXp", _source, xp)
		end
        
	tipres = math.random(1,100)
    end)
end)

