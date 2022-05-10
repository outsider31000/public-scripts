local VorpCore = {}
TriggerEvent("getCore",function(core)
    VorpCore = core
end)

VorpInv = exports.vorp_inventory:vorp_inventoryApi()

local fishEntity = {
    [`A_C_FISHBLUEGIL_01_MS`]        = "a_c_fishbluegil_01_ms",
    [`A_C_FISHBLUEGIL_01_SM`]        = "a_c_fishbluegil_01_sm",
    [`A_C_FISHBULLHEADCAT_01_MS`]    = "a_c_fishbullheadcat_01_ms",
    [`A_C_FISHBULLHEADCAT_01_SM`]    = "a_c_fishbullheadcat_01_sm",
    [`A_C_FISHCHAINPICKEREL_01_MS`]  = "a_c_fishchainpickerel_01_ms",
    [`A_C_FISHCHAINPICKEREL_01_SM`]  = "a_c_fishchainpickerel_01_sm",
    [`A_C_FISHCHANNELCATFISH_01_LG`] = "a_c_fishchannelcatfish_01_lg",
    [`A_C_FISHCHANNELCATFISH_01_XL`] = "a_c_fishchannelcatfish_01_xl",
    [`A_C_FISHLAKESTURGEON_01_LG`]   = "a_c_fishlakesturgeon_01_lg",
    [`A_C_FISHLARGEMOUTHBASS_01_LG`] = "a_c_fishlargemouthbass_01_lg",
    [`A_C_FISHLARGEMOUTHBASS_01_MS`] = "a_c_fishlargemouthbass_01_ms",
    [`A_C_FISHLONGNOSEGAR_01_LG`]    = "a_c_fishlongnosegar_01_lg",
    [`A_C_FISHMUSKIE_01_LG`]         = "a_c_fishmuskie_01_lg",
    [`A_C_FISHNORTHERNPIKE_01_LG`]   = "a_c_fishnorthernpike_01_lg",
    [`A_C_FISHPERCH_01_MS`]          = "a_c_fishperch_01_ms",
    [`A_C_FISHPERCH_01_SM`]          = "a_c_fishperch_01_sm",
    [`A_C_FISHRAINBOWTROUT_01_LG`]   = "a_c_fishrainbowtrout_01_lg",
    [`A_C_FISHRAINBOWTROUT_01_MS`]   = "a_c_fishrainbowtrout_01_ms",
    [`A_C_FISHREDFINPICKEREL_01_MS`] = "a_c_fishredfinpickerel_01_ms",
    [`A_C_FISHREDFINPICKEREL_01_SM`] = "a_c_fishredfinpickerel_01_sm",
    [`A_C_FISHROCKBASS_01_MS`]       = "a_c_fishrockbass_01_ms",
    [`A_C_FISHROCKBASS_01_SM`]       = "a_c_fishrockbass_01_sm",
    [`A_C_FISHSALMONSOCKEYE_01_LG`]  = "a_c_fishsalmonsockeye_01_lg",
    [`A_C_FISHSALMONSOCKEYE_01_ML`]  = "a_c_fishsalmonsockeye_01_ml",
    [`A_C_FISHSALMONSOCKEYE_01_MS`]  = "a_c_fishsalmonsockeye_01_ms",
    [`A_C_FISHSMALLMOUTHBASS_01_LG`] = "a_c_fishsmallmouthbass_01_lg",
    [`A_C_FISHSMALLMOUTHBASS_01_MS`] = "a_c_fishsmallmouthbass_01_ms",
}

local fishNames = {
    [`A_C_FISHBLUEGIL_01_MS`]        = Config.fishData.A_C_FISHBLUEGIL_01_MS[1],
    [`A_C_FISHBLUEGIL_01_SM`]        = Config.fishData.A_C_FISHBLUEGIL_01_SM[1],
    [`A_C_FISHBULLHEADCAT_01_MS`]    = Config.fishData.A_C_FISHBULLHEADCAT_01_MS[1],
    [`A_C_FISHBULLHEADCAT_01_SM`]    = Config.fishData.A_C_FISHBULLHEADCAT_01_SM[1],
    [`A_C_FISHCHAINPICKEREL_01_MS`]  = Config.fishData.A_C_FISHCHAINPICKEREL_01_MS[1],
    [`A_C_FISHCHAINPICKEREL_01_SM`]  = Config.fishData.A_C_FISHCHAINPICKEREL_01_SM[1],
    [`A_C_FISHCHANNELCATFISH_01_LG`] = Config.fishData.A_C_FISHCHANNELCATFISH_01_LG[1],
    [`A_C_FISHCHANNELCATFISH_01_XL`] = Config.fishData.A_C_FISHCHANNELCATFISH_01_XL[1],
    [`A_C_FISHLAKESTURGEON_01_LG`]   = Config.fishData.A_C_FISHLAKESTURGEON_01_LG[1],
    [`A_C_FISHLARGEMOUTHBASS_01_LG`] = Config.fishData.A_C_FISHLARGEMOUTHBASS_01_LG[1],
    [`A_C_FISHLARGEMOUTHBASS_01_MS`] = Config.fishData.A_C_FISHLARGEMOUTHBASS_01_MS[1],
    [`A_C_FISHLONGNOSEGAR_01_LG`]    = Config.fishData.A_C_FISHLONGNOSEGAR_01_LG[1],
    [`A_C_FISHMUSKIE_01_LG`]         = Config.fishData.A_C_FISHMUSKIE_01_LG[1],
    [`A_C_FISHNORTHERNPIKE_01_LG`]   = Config.fishData.A_C_FISHNORTHERNPIKE_01_LG[1],
    [`A_C_FISHPERCH_01_MS`]          = Config.fishData.A_C_FISHPERCH_01_MS[1],
    [`A_C_FISHPERCH_01_SM`]          = Config.fishData.A_C_FISHPERCH_01_SM[1],
    [`A_C_FISHRAINBOWTROUT_01_LG`]   = Config.fishData.A_C_FISHRAINBOWTROUT_01_LG[1],
    [`A_C_FISHRAINBOWTROUT_01_MS`]   = Config.fishData.A_C_FISHRAINBOWTROUT_01_MS[1],
    [`A_C_FISHREDFINPICKEREL_01_MS`] = Config.fishData.A_C_FISHREDFINPICKEREL_01_MS[1],
    [`A_C_FISHREDFINPICKEREL_01_SM`] = Config.fishData.A_C_FISHREDFINPICKEREL_01_SM[1],
    [`A_C_FISHROCKBASS_01_MS`]       = Config.fishData.A_C_FISHROCKBASS_01_MS[1],
    [`A_C_FISHROCKBASS_01_SM`]       = Config.fishData.A_C_FISHROCKBASS_01_SM[1],
    [`A_C_FISHSALMONSOCKEYE_01_LG`]  = Config.fishData.A_C_FISHSALMONSOCKEYE_01_LG[1],
    [`A_C_FISHSALMONSOCKEYE_01_ML`]  = Config.fishData.A_C_FISHSALMONSOCKEYE_01_ML[1],
    [`A_C_FISHSALMONSOCKEYE_01_MS`]  = Config.fishData.A_C_FISHSALMONSOCKEYE_01_MS[1],
    [`A_C_FISHSMALLMOUTHBASS_01_LG`] = Config.fishData.A_C_FISHSMALLMOUTHBASS_01_LG[1],
    [`A_C_FISHSMALLMOUTHBASS_01_MS`] = Config.fishData.A_C_FISHSMALLMOUTHBASS_01_MS[1],
}

Citizen.CreateThread(function()
    Citizen.Wait(2000)
    for index,item in pairs(Config.Baits) do
        VorpInv.RegisterUsableItem(item, function(data)
    		local UsableBait = item
    		VorpInv.subItem(data.source, UsableBait, 1)
    		TriggerClientEvent("vorp_fishing:UseBait", data.source, UsableBait)
            VorpInv.CloseInv(data.source)
        end)
    end
end)

RegisterServerEvent('vorp_fishing:FishToInventory')
AddEventHandler("vorp_fishing:FishToInventory", function(fishModel)
    local _source = source
    local User = VorpCore.getUser(source)
    local Character = User.getUsedCharacter
	local fish = fishEntity[fishModel]
	local fish_name = fishNames[fishModel]
	VorpInv.addItem(_source, fish, 1)
	TriggerClientEvent("vorp:TipBottom", _source, 'You got a '..fish_name, 4000)
end)

RegisterServerEvent('vorp_fishing:discord_keep')
AddEventHandler("vorp_fishing:discord_keep", function(fishModel, fishWeight)
    local _source = source
    local User = VorpCore.getUser(source)
    local Character = User.getUsedCharacter
	local fish = fishEntity[fishModel]
	local fish_name = fishNames[fishModel]
    local fish_weight = string.format("%.2f%%", (fishWeight * 54.25))
    local botname = Config.DiscordBotName
    local avatar = Config.DiscordAvatar
    local webhook = Config.DiscordWebHook
    local CharName
    if Character ~= nil then
        if Character.lastname ~= nil then
            CharName = Character.firstname .. ' ' .. Character.lastname
        else
            CharName = Character.firstname
        end
    end

    local embeds = {
            {
                ["title"] = CharName .." "..Config.Lang.discord_fishCaught,
                ["description"] = Config.Lang.discord_fishKept,
                ["type"]="rich",
                ["color"] = 4777493,
                ["fields"] = {
                    {
                        ["name"] = Config.Lang.discord_fieldFishName,
                        ["value"] = fish_name,
                        ["inline"] = true,
                    },{
                        ["name"] = Config.Lang.discord_fieldFishWeight,
                        ["value"] = fish_weight:gsub("%%", "").."Kg",
                        ["inline"] = true,
                    },
                },
                ["footer"]=  {
                    ["text"]= "Vorp Fishing",
                },
            }
        }
        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({ username = botname,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end)






