VORP = exports.vorp_inventory:vorp_inventoryApi()

Citizen.CreateThread(function()
	Citizen.Wait(2000)

	VORP.RegisterUsableItem("tobaccoseed", function(data)
        VORP.subItem(data.source, "tobaccoseed", 1)
        local item = "tobaccoseed"
        TriggerClientEvent('poke_planting:planto1', data.source, "CRP_TOBACCOPLANT_AA_SIM", "CRP_TOBACCOPLANT_AB_SIM", "CRP_TOBACCOPLANT_AC_SIM", item)
    end)

	VORP.RegisterUsableItem("sugarcaneseed", function(data)
		VORP.subItem(data.source, "sugarcaneseed", 1)
		local item = "sugarcaneseed"
		TriggerClientEvent('poke_planting:planto1', data.source, "CRP_SUGARCANE_AA_SIM", "CRP_SUGARCANE_AB_SIM", "CRP_SUGARCANE_AC_SIM", item)
		
	end)
	
	VORP.RegisterUsableItem("cornseed", function(data)
		VORP.subItem(data.source, "cornseed", 1)
		local item = "cornseed"
		TriggerClientEvent('poke_planting:planto1', data.source, "CRP_CORNSTALKS_CB_SIM", "CRP_CORNSTALKS_CA_SIM", "CRP_CORNSTALKS_AB_SIM", item)
		
	end)
	
	VORP.RegisterUsableItem("dixonappleseed", function(data)
			VORP.subItem(data.source, "dixonappleseed", 1)
			local item = "dixonappleseed"
			TriggerClientEvent('poke_planting:planto1', data.source, "p_tree_magnolia_01", "p_tree_magnolia_02", "p_tree_magnolia_02_MD", item)
	end)
	
	VORP.RegisterUsableItem("bananaseed", function(data)
			VORP.subItem(data.source, "bananaseed", 1)
			local item = "bananaseed"
			TriggerClientEvent('poke_planting:planto1', data.source, "p_tree_banana_01_crt", "p_tree_banana_01_MD_crt", "p_tree_banana_01_MD_crt", item)
		
    end)

	VORP.RegisterUsableItem("cottonseed", function(data)
			VORP.subItem(data.source, "cottonseed", 1)
			local item = "cottonseed"
			TriggerClientEvent('poke_planting:planto1', data.source, "CRP_COTTON_AD_SIM", "CRP_COTTON_BA_SIM", "CRP_COTTON_BB_SIM", item)
		
	end)

	VORP.RegisterUsableItem("ginsengseed", function(data)
			VORP.subItem(data.source, "ginsengseed", 1)
			local item = "ginsengseed"
			TriggerClientEvent('poke_planting:planto1', data.source, "CRP_GINSENG_AA_SIM", "CRP_GINSENG_AB_SIM", "CRP_GINSENG_AD", item)
		
	end)

	VORP.RegisterUsableItem("carrotseed", function(data)
			VORP.subItem(data.source, "carrotseed", 1)
			local item = "carrotseed"
			TriggerClientEvent('poke_planting:planto1', data.source, "crp_carrots_aa_sim", "crp_carrots_har_ba_sim", "crp_carrots_sap_ba_sim", item)
		
	end)

	VORP.RegisterUsableItem("seedpotato", function(data)
			VORP.subItem(data.source, "seedpotato", 1)
			local item = "seedpotato"
			TriggerClientEvent('poke_planting:planto1', data.source, "crp_potato_aa_sim", "crp_potato_har_aa_sim", "crp_potato_sap_aa_sim", item)
		
	end)

	VORP.RegisterUsableItem("tomatoplant", function(data)
			VORP.subItem(data.source, "tomatoplant", 1)
			local item = "tomatoplant"
			TriggerClientEvent('poke_planting:planto1', data.source, "crp_tomatoes_aa_sim", "crp_tomatoes_har_aa_sim", "crp_tomatoes_sap_aa_sim", item)
		
	end)

	VORP.RegisterUsableItem("cocaseed", function(data)
			VORP.subItem(data.source, "cocaseed", 1)
			local item = "cocaseed"
			TriggerClientEvent('poke_planting:planto1', data.source, "p_sap_maple_aa_sim", "p_sap_maple_ab_sim", "p_sap_maple_ad_sim", item)
		
	end)

	VORP.RegisterUsableItem("wheatseed", function(data)
			VORP.subItem(data.source, "wheatseed", 1)
			local item = "wheatseed"
			TriggerClientEvent('poke_planting:planto1', data.source, "crp_wheat_dry_aa_sim", "crp_wheat_sap_long_ab_sim", "crp_wheat_stk_ab_sim", item)
		
	end)

	VORP.RegisterUsableItem("barleyseed", function(data)
			VORP.subItem(data.source, "barleyseed", 1)
			local item = "barleyseed"
			TriggerClientEvent('poke_planting:planto1', data.source, "crp_wheat_dry_aa_sim", "crp_wheat_sap_long_ab_sim", "crp_wheat_dry_long_aa_sim", item)
		
	end)

	VORP.RegisterUsableItem("grapeseed", function(data)
			VORP.subItem(data.source, "grapeseed", 1)
			local item = "grapeseed"
			TriggerClientEvent('poke_planting:planto1', data.source, "rdr_bush_neat_ac_sim", "rdr_bush_neat_ab_sim", "rdr_bush_hedgecore_ac", item)
		
	end)

	VORP.RegisterUsableItem("wateringcan", function(data)
		TriggerClientEvent('poke_planting:regar1', data.source)
	end)
	
end)

RegisterServerEvent('giveback')
AddEventHandler('giveback', function(item)
	VORP.addItem(source, item, 1)
	TriggerClientEvent("seed:used")
end)

RegisterServerEvent('poke_planting:giveitem')
AddEventHandler('poke_planting:giveitem', function(tipo)
    local _source = source
	local count = math.random(2, 5)
	if tipo == "CRP_TOBACCOPLANT_AC_SIM" then
		TriggerClientEvent("vorp:TipRight", _source, 'You have collected [X'..count..'] Tobacco Leaves', 3000)
		VORP.addItem(_source, "tobacco", count)
	elseif tipo == "CRP_SUGARCANE_AC_SIM" then
		TriggerClientEvent("vorp:TipRight", _source, 'You have collected [X'..count..'] Sugar', 3000)
		VORP.addItem(_source, "sugar", count)
	elseif tipo == "CRP_CORNSTALKS_AB_SIM" then
		TriggerClientEvent("vorp:TipRight", _source, 'You have collected [X'..count..'] Corn', 3000)
		VORP.addItem(_source, "corn", count)
	elseif tipo == "CRP_COTTON_BB_SIM" then
		TriggerClientEvent("vorp:TipRight", _source, 'You have collected [X'..count..'] Raw Cotton', 3000)
		VORP.addItem(_source, "rawcotton", count)
	elseif tipo == "CRP_GINSENG_AD" then
		TriggerClientEvent("vorp:TipRight", _source, 'You have collected [X'..count..'] Ginseng', 3000)
		VORP.addItem(_source, "ginseng", count)
	elseif tipo == "crp_carrots_sap_ba_sim" then
		TriggerClientEvent("vorp:TipRight", _source, 'You have collected [X'..count..'] Carrots', 3000)
		VORP.addItem(_source, "carrot", count)
	elseif tipo == "crp_potato_sap_aa_sim" then
		TriggerClientEvent("vorp:TipRight", _source, 'You have collected [X'..count..'] Potatoes', 3000)
		VORP.addItem(_source, "potato", count)
	elseif tipo == "crp_tomatoes_sap_aa_sim" then
		TriggerClientEvent("vorp:TipRight", _source, 'You have collected [X'..count..'] Tomatoes', 3000)
		VORP.addItem(_source, "tomato", count)
	elseif tipo == "p_sap_maple_ad_sim" then
		TriggerClientEvent("vorp:TipRight", _source, 'You have collected [X'..count..'] Coca Leaves', 3000)
		VORP.addItem(_source, "cocaleaf", count)
	elseif tipo == "crp_wheat_stk_ab_sim" then
		TriggerClientEvent("vorp:TipRight", _source, 'You have collected [X'..count..'] Wheat', 3000)
		VORP.addItem(_source, "wheat", count)
	elseif tipo == "crp_wheat_dry_long_aa_sim" then
		TriggerClientEvent("vorp:TipRight", _source, 'You have collected [X'..count..'] Barley', 3000)
		VORP.addItem(_source, "barley", count)
	elseif tipo == "p_tree_magnolia_02_MD" then
        TriggerClientEvent("vorp:TipRight", _source, 'You have collected [X'..count..'] Dixon Apples', 3000)
		VORP.addItem(_source, "dixonapple", count)
	elseif tipo == "p_tree_banana_01_MD_crt" then
        TriggerClientEvent("vorp:TipRight", _source, 'You have collected [X'..count..'] Bananas', 3000)
        VORP.addItem(_source, "banana", count)
	elseif tipo == "rdr_bush_hedgecore_ac" then
        TriggerClientEvent("vorp:TipRight", _source, 'You have collected [X'..count..'] Grapes', 3000)
        VORP.addItem(_source, "grapes", count)
	end

end)
