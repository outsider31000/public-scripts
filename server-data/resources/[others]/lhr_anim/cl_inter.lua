--local isInZone = false 
--local play = false

--RegisterNetEvent('anim_menuopen') AddEventHandler('anim_menuopen', function() 
--	WarMenu.OpenMenu('Anim') 
--end)


    




local Animation = {
	{
		['Text'] = "Knock on the door",
		['hashAnim'] = "WORLD_HUMAN_KNOCK_DOOR",
	},
	
	{
		['Text'] = "Urinate",
		['hashAnim'] = "WORLD_HUMAN_PEE",
	},

	{
		['Text'] = "Sit on the floor",
		['hashAnim'] = "WORLD_HUMAN_FIRE_SIT",
	},


	{
		['Text'] = "Hands on waist",
		['hashAnim'] = "WORLD_HUMAN_BADASS",
	},

	{
		['Text'] = "Vomit",
		['hashAnim'] = "WORLD_HUMAN_VOMIT",
	},

	{
		['Text'] = "Vomiting on your knees",
		['hashAnim'] = "WORLD_HUMAN_VOMIT_KNEEL",
	},

	{
		
		['Text'] = "Wash your face on your knees",
		['hashAnim'] = "WORLD_HUMAN_WASH_FACE_BUCKET_GROUND",
	},

	{
		['Text'] = "Observe squatting",
		['hashAnim'] = "WORLD_PLAYER_DYNAMIC_KNEEL",
	},

	{
		['Text'] = "Impatient",
		['hashAnim'] = "WORLD_HUMAN_WAITING_IMPATIENT",
	},

	
	{
		['Text'] = "Wait",
		['hashAnim'] = "WORLD_HUMAN_STAND_WAITING",
	},

	{
		['Text'] = "Inspect the floor",
		['hashAnim'] = "WORLD_HUMAN_CROUCH_INSPECT",
	},

	{
		['Text'] = "Inspect",
		['hashAnim'] = "WORLD_HUMAN_INSPECT",
	},

	{
		['Text'] = "Cross your arms",
		['hashAnim'] = "WORLD_HUMAN_STARE_STOIC",
	},

	{
		['Text'] = "Clean a glass",
		['hashAnim'] = "WORLD_HUMAN_BARTENDER_CLEAN_GLASS",
	},

	{
		['Text'] = "Lean on counter 1",
		['hashAnim'] = "WORLD_HUMAN_SHOPKEEPER",
	},
	
	{
		['Text'] = "Lean on counter 2",
		['hashAnim'] = "WORLD_HUMAN_SHOPKEEPER_CATALOG",
	},

	{
		['Text'] = "Hands on waist 2",
		['hashAnim'] = "WORLD_HUMAN_STERNGUY_IDLES",
	},

	{
		['Text'] = "Take notes in notebook",
		['hashAnim'] = "WORLD_HUMAN_WRITE_NOTEBOOK",
	},
	
	{
		['Text'] = "Pure smoking",
		['hashAnim'] = "WORLD_HUMAN_SMOKE_CIGAR",
	},
	
	{
		['Text'] = "Smoking cigarette",
		['hashAnim'] = "WORLD_HUMAN_SMOKE_INTERACTION",
	},
	
	{
		['Text'] = "Meter bag (cart)",
		['hashAnim'] = "PROP_HUMAN_SACK_STORAGE_IN",
	},
	
    {
        ['Text'] = "Have coffee",
        ['hashAnim'] = "WORLD_HUMAN_COFFEE_DRINK",
    },
    
    {
        ['Text'] = "Fan yourself",
        ['hashAnim'] = "WORLD_HUMAN_FAN",
    },	
	
    {
        ['Text'] = "Sit on the floor 2",
        ['hashAnim'] = "WORLD_CAMP_FIRE_SEATED_GROUND",
    },
	
    {  
        ['Text'] = "Lean on the wall",
        ['hashAnim'] = "WORLD_HUMAN_LEAN_BACK_WALL",
    },
	
    {
        ['Text'] = "Lean against the wall while smoking",
        ['hashAnim'] = "WORLD_HUMAN_LEAN_BACK_WALL_SMOKING",
    },
	
    {
        ['Text'] = "Lean on the wall while drinking",
        ['hashAnim'] = "WORLD_HUMAN_LEAN_BACK_WALL_DRINKING",
    },
	
    {
        ['Text'] = "Lean to the right",
        ['hashAnim'] = "WORLD_HUMAN_LEAN_WALL_RIGHT",
    },	

    {
        ['Text'] = "Sit and read",
        ['hashAnim'] = "WORLD_HUMAN_SIT_GROUND_READING_BOOK",
    },

    {
        ['Text'] = "Sit with can",
        ['hashAnim'] = "WORLD_HUMAN_CANNED_FOOD_COOKING",
    },

    {
        ['Text'] = "Clear window",
        ['hashAnim'] = "WORLD_HUMAN_CLEAN_WINDOW",
    }, 

    {
        ['Text'] = "Fish standing up",
        ['hashAnim'] = "WORLD_HUMAN_STAND_FISHING",
    },

    {
        ['Text'] = "Lean on the railing (smoke)",
        ['hashAnim'] = "WORLD_HUMAN_LEAN_RAILING",
    },


    {
        ['Text'] = "Sit overhang",
        ['hashAnim'] = "WORLD_HUMAN_SEAT_LEDGE_NEW",
    },

    {
        ['Text'] = "Sleep floor 1",
        ['hashAnim'] = "WORLD_HUMAN_SLEEP_GROUND_PILLOW",
    },

    {
        ['Text'] = "Sleep floor 2",
        ['hashAnim'] = "WORLD_HUMAN_SLEEP_GROUND_ARM",
    },

    {
        ['Text'] = "Sit overhang harmonic",
        ['hashAnim'] = "WORLD_HUMAN_SEAT_LEDGE_HARMONICA",
    },

    {
        ['Text'] = "Sit harmonica bench",
        ['hashAnim'] = "PROP_HUMAN_SEAT_BENCH_HARMONICA",
    },

    {
        ['Text'] = "Play guitar sitting down",
        ['hashAnim'] = "WORLD_HUMAN_SIT_GUITAR",
    },

}

local Animationfille = {

{
	['TextF'] = "Wash your face on your knees",
	['hashAnim'] = "WORLD_HUMAN_WASH_FACE_BUCKET_GROUND",
},


{
	['TextF'] = "Observe squatting",
	['hashAnim'] = "WORLD_PLAYER_DYNAMIC_KNEEL",
},

{
	['TextF'] = "Impatient",
	['hashAnim'] = "WORLD_HUMAN_WAITING_IMPATIENT",
},

{
	['TextF'] = "Wait",
	['hashAnim'] = "WORLD_HUMAN_STAND_WAITING",
},


{
	['Text'] = "Clean a glass",
	['hashAnim'] = "WORLD_HUMAN_BARTENDER_CLEAN_GLASS",
},

{
	['TextF'] = "Inspect the floor",
	['hashAnim'] = "WORLD_HUMAN_CROUCH_INSPECT",
},

{
	['TextF'] = "Inspect",
	['hashAnim'] = "WORLD_HUMAN_INSPECT",
},

{
	['TextF'] = "Cross your arms",
	['hashAnim'] = "WORLD_HUMAN_STARE_STOIC",
},


{
	['TextF'] = "Take notes in notebook",
	['hashAnim'] = "WORLD_HUMAN_WRITE_NOTEBOOK",
},

}



local Emote = {
	
	{
		['Text'] = "Say Hello",
		['HashEmote'] = -339257980,
	},
	
	
	{
		['Text'] = "Throw a kiss",
		['HashEmote'] = 1927505461,
	},
	
	{
		['Text'] = "Nod with crossed arms",
		['HashEmote'] = 1879954891,
	},
	
	
	{
		['Text'] = "Follow me!",
		['HashEmote'] = 1115379199,
	},
	
	{
		['Text'] = "Beg",
		['HashEmote'] = 164860528,
	},
	
	{
		['Text'] = "Shoot in the air",
		['HashEmote'] = 1939251934,
	},
	
	{
		['Text'] = "Shoot in front",
		['HashEmote'] = -1639456476,
	},
	

	{
        ['Text'] = "Clap",
        ['HashEmote'] = -221241824,
    },

    {
        ['Text'] = "Disapprove",
        ['HashEmote'] = 1509171361,
    },

    {
        ['Text'] = "Threaten",
        ['HashEmote'] = 1256841324,
    },



	{
		['Text'] = "Feign injury",
		['HashEmote'] = -110352861,
	},
	
	{
		['Text'] = "Anger",
		['HashEmote'] = 796723886,
	},
	
	{
		['Text'] = "Victoria",
		['HashEmote'] = -402959,
	},
	
	{
		['Text'] = "Bad smell",
		['HashEmote'] = -166523388,
	},

	{
		['Text'] = "Approve",
		['HashEmote'] = 425751659,
	},

	{
		['Text'] = "Spit",
		['HashEmote'] = -2106738342,
	},

	-- {
		-- 	['Text'] = "LetsCraft",
		-- 	['HashEmote'] = -415456998,
		-- },
		
	-- {
	-- 	['Text'] = "PlaySomeCards",
	-- 	['HashEmote'] = -843470756,
	-- },
	
	{
		['Text'] = "Look at the horizon",
		['HashEmote'] = 935157006,
	},

	{
		['Text'] = "Enter 1",
		['HashEmote'] = 1593752891,
	},
	
	{
		['Text'] = "Enter 2",
		['HashEmote'] = 7918540,
	},
	
	{
		['Text'] = "Enter 3",
		['HashEmote'] = 486225122,
	},
	
	{
		['Text'] = "Come here",
		['HashEmote'] = 474409519,
	},
	
	{
		['Text'] = "Fishing",
		['HashEmote'] = 1159716480,
	},
	{
		['Text'] = "Show muscles",
		['HashEmote'] = -773960361,
	},
	
	{
		['Text'] = "Conspire",
		['HashEmote'] = 589481092,
	},
	
	
	{
		['Text'] = "Stop",
		['HashEmote'] = -1691237868,
	},
	
	{
		['Text'] = "Filter",
		['HashEmote'] = 831975651,
	},
	
	{
		['Text'] = "Friendly greeting",
		['HashEmote'] = 901097731,
	},
	
	{
		['Text'] = "Polite greeting",
		['HashEmote'] = -2121881035,
	},
	
	{
		['Text'] = "Greet with hat",
		['HashEmote'] = -1457020913,
	},
	
	{
		['Text'] = "Greet with respect",
		['HashEmote'] = -1801715172,
	},

	{
		['Text'] = "Glad to see you",
		['HashEmote'] = 523585988,
	},
	
	{
		['Text'] = "Taa Daa!",
		['HashEmote'] = -462132925,
	},

	{
		['Text'] = "Get outraged",
		['HashEmote'] = 1802342943,
	},

	{
		['Text'] = "Sick",
		['HashEmote'] = -1118911493,
	},

	{
		['Text'] = "Shut up",
		['HashEmote'] = -1644757697 ,
	},

	{
		['Text'] = "Nod",
		['HashEmote'] = -822629770,
	},

	{
		['Text'] = "Mock",
		['HashEmote'] = 803206066,
	},

	{
		['Text'] = "Deny",
		['HashEmote'] = -653113914,
	},

	{
		['Text'] = "Slow applause",
		['HashEmote'] = 1023735814,
	},
	
	{
		['Text'] = "Who me?",
		['HashEmote'] = 329631369,
	},
	
	{
		['Text'] = "Yeehaa",
		['HashEmote'] = 445839715 ,
	},
	
	{
		['Text'] = "Pretend cry",
		['HashEmote'] = 246916594,
	},

	{
		['Text'] = "Regret",
		['HashEmote'] = 81347960,
	},
	
	{
		['Text'] = "Hen",
		['HashEmote'] = 1825177171,
	},
	
	{
		['Text'] = "Fuck you 1",
		['HashEmote'] = 354512356,
	},

	{
		['Text'] = "Fuck you 2",
		['HashEmote'] = 969312568,
	},

	{
		['Text'] = "I'm watching you",
		['HashEmote'] = -553424129,
	},
	{
		['Text'] = "Delay",
		['HashEmote'] = 1533402397,
	},

	{
		['Text'] = "Get angry",
		['HashEmote'] = 987239450,
	},

	{
		['Text'] = "Proud",
		['HashEmote'] = -1252070669,
	}

}



Citizen.CreateThread(function()
	
	local sexe =  IsPedMale(PlayerPedId())

	WarMenu.CreateMenu('Anim', 'Actions')
	WarMenu.CreateSubMenu('Choix', 'Anim', 'Expressions')
	WarMenu.CreateSubMenu('Select', 'Anim', 'Animations')
	WarMenu.CreateSubMenu('Faire', 'Anim', 'Animation Girl')
	

	while true do
		Citizen.Wait(0)
		if WarMenu.IsMenuOpened('Anim') then
			if WarMenu.MenuButton('Emote', 'Choix') then end
				if sexe == 1 then 
					WarMenu.MenuButton('Animations', 'Select') 
				else 
					WarMenu.MenuButton('Animations', 'Faire') 
				end
			elseif WarMenu.IsMenuOpened('Choix') then
				for i = 1, #Emote do
					if WarMenu.Button(Emote[i]['Text']) then
						WarMenu.CloseMenu()
						Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0,Emote[i]['HashEmote'], 1, 1, 0, 0)
					end					
				end
			
			elseif WarMenu.IsMenuOpened('Select') then
				for j = 1, #Animation do
					if WarMenu.Button(Animation[j]['Text']) then
						WarMenu.CloseMenu()
						TaskStartScenarioInPlace(PlayerPedId(), GetHashKey(Animation[j]['hashAnim']), -1, true, false, false, false)
					end
				end
			
		elseif WarMenu.IsMenuOpened('Faire') then
			if WarMenu.Button('Stop') then
				ClearPedTasks(PlayerPedId())
			end
			for j = 1, #Animationfille do
				if WarMenu.Button(Animationfille[j]['Text']) then
					WarMenu.CloseMenu()
					TaskStartScenarioInPlace(PlayerPedId(), GetHashKey(Animation[j]['hashAnim']), -1, true, false, false, false)
				end
			end
		end
		WarMenu.Display()
	end
end)


RegisterCommand("am", function(source, args)
	WarMenu.OpenMenu('Anim')
end)


--[[ RegisterCommand("hw", function(source, args)
	Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0,987239450, 1, 1, 0, 0)
end) ]]

function GetDistance3D(coords, coords2)
	return #(coords - coords2)
end

GetClosestPlayer = function(coords)
    local players         = GetPlayers()
    local closestDistance = 5
    local closestPlayer   = -1
    local coords          = coords
    local usePlayerPed    = false
    local playerPed       = PlayerPedId()
    local playerId        = PlayerId()


    if coords == nil then
        usePlayerPed = true
        coords       = GetEntityCoords(playerPed)
    end

    for i=1, #players, 1 do
        local target = GetPlayerPed(players[i])
      --  print(target)

        if not usePlayerPed or (usePlayerPed and players[i] ~= playerId) then
            local targetCoords = GetEntityCoords(target)
            local distance     = GetDistanceBetweenCoords(targetCoords, coords.x, coords.y, coords.z, true)

            if closestDistance > distance then
                closestPlayer = players[i]
                closestDistance = distance
            end
        end
    end

    return closestPlayer, closestDistance
end

function GetPlayers()
    local players = {}

    for i = 0, 31 do
        if NetworkIsPlayerActive(i) then
          --  print(i)
            table.insert(players, i)
        end
    end

    return players
end





-- TaskStartScenarioAtPosition(GetPlayerPed(), GetHashKey('PROP_HUMAN_PIANO'), -312.22 - 0.08, 799.01, 118.43 + 0.03, 102.37, 0, true, true, 0, true) (PIANO)

local scenario = {
    ['knock'] = "WORLD_HUMAN_KNOCK_DOOR",
    ['trumpet'] = "WORLD_HUMAN_TRUMPET",
    ['sitguitar'] = "WORLD_HUMAN_SIT_GUITAR",
    ['lean'] = "WORLD_HUMAN_LEAN_BACK_WALL",
    ['impatient'] = "WORLD_HUMAN_WAITING_IMPATIENT",
	['clipboard'] = "WORLD_HUMAN_CLIPBOARD",	
	['fishing'] = "WORLD_HUMAN_STAND_FISHING",
	['mourning'] = "WORLD_HUMAN_GRAVE_MOURNING",
	['broom1'] = "WORLD_HUMAN_PUSH_BROOM_WORKING",
	['broom2'] = "WORLD_HUMAN_STRAW_BROOM_WORKING",		
	['mourningkneel'] = "WORLD_HUMAN_GRAVE_MOURNING_KNEEL",
	['pee'] = "WORLD_HUMAN_PEE",
	['passedout'] = "WORLD_HUMAN_DRUNK_PASSED_OUT_FLOOR",
	['badass'] = "WORLD_HUMAN_BADASS",		
	['vomit'] = "WORLD_HUMAN_VOMIT",
	['vomitkneel'] = "WORLD_HUMAN_VOMIT_KNEEL",
	['layground1'] = "WORLD_CAMP_FIRE_LAY_BACK_GROUND",
	['layground2'] = "WORLD_CAMP_FIRE_LAY_GROUND_SIDE",
	['sitground1'] = "WORLD_CAMP_FIRE_SIT_GROUND",	
	['sitground2'] = "WORLD_CAMP_FIRE_SIT_GROUND_RECLINE",
	['cleantable'] = "WORLD_HUMAN_CLEAN_TABLE",	
    ['sitground3'] = "WORLD_HUMAN_FIRE_SIT",	
    ['observe'] = "WORLD_PLAYER_DYNAMIC_KNEEL",	
    ['waiting'] = "WORLD_HUMAN_STAND_WAITING",	
    ['inspect'] = "WORLD_HUMAN_CROUCH_INSPECT",	
    ['inspect2'] = "WORLD_HUMAN_INSPECT",	
    ['crossarms'] = "WORLD_HUMAN_STARE_STOIC",	
    ['cleanglass'] = "WORLD_HUMAN_BARTENDER_CLEAN_GLASS",	
    ['handcounter'] = "WORLD_HUMAN_SHOPKEEPER",	
    ['handcounter2'] = "WORLD_HUMAN_SHOPKEEPER_CATALOG",	
    ['handwaist'] = "WORLD_HUMAN_STERNGUY_IDLES",	
    ['notebook'] = "WORLD_HUMAN_WRITE_NOTEBOOK",	
    ['sitground4'] = "WORLD_CAMP_FIRE_SEATED_GROUND",	
    ['sitbook'] = "WORLD_HUMAN_SIT_GROUND_READING_BOOK",	
    ['sitcan'] = "WORLD_HUMAN_CANNED_FOOD_COOKING",	
    ['sitledge'] = "WORLD_HUMAN_SEAT_LEDGE_NEW",	
    ['raillean'] = "WORLD_HUMAN_LEAN_RAILING",	
    ['sleep2'] = "WORLD_HUMAN_SLEEP_GROUND_PILLOW",	
    ['ledgeharm'] = "WORLD_HUMAN_SEAT_LEDGE_HARMONICA",
    ['benchharm'] = "PROP_HUMAN_SEAT_BENCH_HARMONICA",
    -- ['wnormal'] = "MP_Style_Default",
    -- ['wcasual'] = "MP_Style_Casual",
    -- ['wcrazy'] = "MP_Style_Crazy",
    -- ['wflamboyant'] = "MP_Style_Flamboyant",
    -- ['wgunslinger'] = "MP_Style_Gunslinger",
    -- ['wrefined'] = "MP_Style_Refined",
    -- ['wsilent'] = "MP_Style_SilentType",
    -- ['wgreenhorn'] = "MP_Style_Greenhorn",
    -- ['wveteran'] = "MP_Style_Veteran",
    -- ['weasyrider'] = "MP_Style_EasyRider",
	--['cleanwindow'] = "WORLD_HUMAN_CLEAN_WINDOW",	
    --['washboard1'] = "WORLD_HUMAN_WASHBOARD",	
	--['washboard2'] = "WORLD_HUMAN_WASHBOARD_BASIN",
	--['hammerground'] = "WORLD_HUMAN_HAMMER_GROUND",
	--['hammertable'] = "WORLD_HUMAN_HAMMER_TABLE",
	--['hammerwall'] = "WORLD_HUMAN_HAMMER_WALL",	
    --['fan'] = "WORLD_HUMAN_FAN",	
    --['bale'] = "WORLD_HUMAN_BALE_PICKUP_1_MALE_A",
    --['papersell'] = "WORLD_HUMAN_SELL_PAPER",
    --['sack'] = "WORLD_HUMAN_SACK_PICKUP_1_MALE_A",
}

local kit_emotes ={
    ['stinky'] = -166523388,
    ['chicken'] = 1825177171,
    ['tip'] = -1457020913,
    ['slit'] = 1256841324,
    ['slwclp'] = 1023735814,
    ['smh'] = -653113914,
    ['spit'] = -2106738342,
    ['no'] = 1509171361,
    ['yes'] = 425751659,
    ['wave'] = -339257980,
    ['bird'] = 969312568,
    ['blowkiss'] = 1927505461,
    ['nodcrossed'] = 1879954891,
    ['followme'] = 1115379199,
    ['plead'] =  164860528,
    ['shootfront'] = -1639456476,
    ['clap'] = -221241824,
    ['hurt'] = -110352861,
    ['angry'] = 796723886,
    ['victory'] =  -402959,
    ['letscraft'] = -415456998,
    ['cards'] = -843470756,
    ['lookhorizon'] = 935157006,
    ['indicate1'] = 1593752891,
    ['indicate2'] = 7918540,
    ['indicate3'] = 486225122,
    ['comehere'] = 474409519,
    ['spit'] = -2106738342,
    ['fishing'] = 1159716480,
    ['muscles'] = -773960361,
    ['flirt'] = 831975651,
    ['happytoseeyou'] = 523585988,
    ['tada'] = -462132925,
    ['outrage'] = 1802342943,
    ['sick'] = -1118911493,
    ['shutup'] = -1644757697,
    ['makefun'] = 803206066,
    ['deny'] = -653113914,
    ['whome'] = 329631369,
    ['yeehaw'] = 445839715,
    ['cry'] = 246916594,
    ['wail'] = 81347960,
    ['foff'] = 354512356,
    ['watchyou'] = -553424129,
    ['challenge'] = 1533402397,
    ['proud'] = -1252070669,
}

--upper body and prop control emotes.
--animDictionary 
--animationName
--speed
--speedMultiplier 
--duration 
--flag
local hasProp = false
local emote = {
--[[
["clipboard"] = {
    animDict = "move_m@clipboard", 
    animName = "idle", 
    speed = 3.0, 
    speedX = -8, 
    duration = -1, 
    flags = 49,
    hasProp = true,
        propName = 'p_amb_clipboard_01',
        boneIndex = 18905, 
        xPos = 0.1875, 
        yPos = 0.05, 
        zPos = 0.10, 
        xRot = -125.0, 
        yRot = -49.0,
        zRot = -5.0,
    },
	]]--
	["wipesweat"] = {
    animDict = "mech_loco_m@character@arthur@fidgets@weather@sunny_hot@unarmed", 
    animName = "sweat_face_b", 
    speed = 8.0, 
    speedX = 3.0, 
    duration = 3000, 
    flags = 2,
    hasProp = false,
    },
	["thanksmale"] = {
    animDict = "script_re@wealthy_couple", 
    animName = "thanks_man", 
    speed = 8.0, 
    speedX = 3.0, 
    duration = -1, 
    flags = 24,
    hasProp = false,
    },
		["thanksmale2"] = {
    animDict = "script_re@wealthy_couple", 
    animName = "thanks_v2_man", 
    speed = 8.0, 
    speedX = 3.0, 
    duration = -1, 
    flags = 24,
    hasProp = false,
    },
			["thanksfemale"] = {
    animDict = "script_re@wealthy_couple", 
    animName = "thanks_woman", 
    speed = 8.0, 
    speedX = 3.0, 
    duration = -1, 
    flags = 24,
    hasProp = false,
    },
				["thanksfemale2"] = {
    animDict = "script_re@wealthy_couple", 
    animName = "thanks_v2_female_woman", 
    speed = 8.0, 
    speedX = 3.0, 
    duration = -1, 
    flags = 24,
    hasProp = false,
    },
				["kneel"] = {
    animDict = "MECH_DYNAMIC@WORLD_PLAYER_DYNAMIC_KNEEL_GROUND@GENERIC@MALE_A@base", 
    animName = "base", 
    speed = 2.0, 
    speedX = 2.0, 
    duration = -1, 
    flags = 2,
    hasProp = false,
    },
				["sleep"] = {
    animDict = "amb_rest@world_human_passed_out_floor@male_a@idle_a", 
    animName = "idle_b", 
    speed = 2.0, 
    speedX = 2.0, 
    duration = -1, 
    flags = 2,
    hasProp = false,
    },
				["lean2"] = {
    animDict = "amb_rest_lean@world_human_lean_fence_fwd_check_out_livestock@male_e@idle_c", 
    animName = "idle_g", 
    speed = 2.0, 
    speedX = 2.0, 
    duration = -1, 
    flags = 2,
    hasProp = false,
    },
				["dance1"] = {
    animDict = "amb_misc@world_human_drunk_dancing@male@male_b@idle_a", 
    animName = "idle_b", 
    speed = 2.0, 
    speedX = 2.0, 
    duration = -1, 
    flags = 1,
    hasProp = false,
    },

            ["dance2"] = {
    animDict = "script_mp@emotes@dance@drunk@b@male@unarmed@full", 
    animName = "fullbody", 
    speed = 2.0, 
    speedX = 2.0, 
    duration = -1, 
    flags = 1,
    hasProp = false,
    },

            ["dance3"] = {
    animDict = "script_mp@emotes@dance@confident@b@male@unarmed@full", 
    animName = "fullbody", 
    speed = 2.0, 
    speedX = 2.0, 
    duration = -1, 
    flags = 1,
    hasProp = false,
    },

        ["dance4"] = {
    animDict = "script_mp@emotes@dance@wild@b@male@unarmed@full", 
    animName = "fullbody", 
    speed = 2.0, 
    speedX = 2.0, 
    duration = -1, 
    flags = 1,
    hasProp = false,
    },

        ["dance5"] = {
    animDict = "script_mp@emotes@dance@drunk@a@male@unarmed@full", 
    animName = "fullbody", 
    speed = 2.0, 
    speedX = 2.0, 
    duration = -1, 
    flags = 1,
    hasProp = false,
    },

        ["dance6"] = {
    animDict = "script_mp@emotes@dance@old@a@male@unarmed@full", 
    animName = "fullbody", 
    speed = 2.0, 
    speedX = 2.0, 
    duration = -1, 
    flags = 1,
    hasProp = false,
    },

        ["dance7"] = {
    animDict = "script_mp@emotes@dance@confident@b@male@unarmed@full", 
    animName = "fullbody", 
    speed = 2.0, 
    speedX = 2.0, 
    duration = -1, 
    flags = 1,
    hasProp = false,
    },

         ["dance8"] = {
    animDict = "script_mp@emotes@dance@carefree@a@male@unarmed@full", 
    animName = "fullbody", 
    speed = 2.0, 
    speedX = 2.0, 
    duration = -1, 
    flags = 1,
    hasProp = false,
    },

        ["dance9"] = {
    animDict = "script_mp@emotes@dance@awkward@a@male@unarmed@full", 
    animName = "fullbody", 
    speed = 2.0, 
    speedX = 2.0, 
    duration = -1, 
    flags = 1,
    hasProp = false,
    },
				["beg"] = {
    animDict = "amb_misc@world_human_begging_mother@female_a@react_begging", 
    animName = "react_begging_frontleft", 
    speed = 2.0, 
    speedX = 2.0, 
    duration = -1, 
    flags = 1,
    hasProp = false,
    },
					["lean3"] = {
    animDict = "amb_rest_lean@world_human_lean@post@left@female_a@idle_a", 
    animName = "idle_a", 
    speed = 2.0, 
    speedX = 2.0, 
    duration = -1, 
    flags = 1,
    hasProp = false,
    },
						["lean4"] = {
    animDict = "amb_rest_lean@world_human_lean@post@left@female_a@idle_a", 
    animName = "idle_b", 
    speed = 2.0, 
    speedX = 2.0, 
    duration = -1, 
    flags = 1,
    hasProp = false,
    },
							["lean5"] = {
    animDict = "amb_rest_lean@world_human_lean@post@left@female_a@idle_a", 
    animName = "idle_c", 
    speed = 2.0, 
    speedX = 2.0, 
    duration = -1, 
    flags = 1,
    hasProp = false,
    },
					["lean6"] = {
    animDict = "amb_rest_lean@world_human_lean@wall@right@male_b@idle_a", 
    animName = "idle_c", 
    speed = 2.0, 
    speedX = 2.0, 
    duration = -1, 
    flags = 1,
    hasProp = false,
    },
				["idle"] = {
    animDict = "script_story@mob5@ig@ig_5_guardbackyard", 
    animName = "base_guard", 
    speed = 2.0, 
    speedX = 2.0, 
    duration = -1, 
    flags = 1,
    hasProp = false,
    },		
}



local scenarioPlaying = IsPedActiveInScenario(PlayerPedId()) -- Registering whether or not the player is in an active scenario
local emotePlaying = false
local isPropAttached = false

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end

function clear(upper)
--print("Invoked Clear")
    local playerPed = PlayerPedId()
    if (emotePlaying == true) or (scenarioPlaying == true) then 
        if isPropAttached then
            DetachEntity(prop, 1, 1)
            DeleteObject(prop)
            isPropAttached = false
        end
        ClearPedTasks(playerPed)
        ClearPedSecondaryTask(playerPed)
        ClearPedTasksImmediately(playerPed)
        scenarioPlaying = false
        emotePlaying = false
    end
end

function displayEmotesList()
    local index = 0 -- Current index
    local display = "^0" -- Text to display

    for name, value in pairs(scenario) do -- Adding the scenario names to the display var
        index = index + 1
        if index == 1 then
            display = display..name
        else
            display = display..", "..name
        end
    end

    for name, value in pairs(emote) do -- Adding the emote names to the display var
        index = index + 1
        if index == 1 then
            display = display..name
        else
            display = display..", "..name
        end
    end


    TriggerEvent("chatMessage", "Emotes", {255,0,0}, "") -- Saying "EMOTES:" in red
    TriggerEvent("chatMessage", "", {0,0,0}, display) -- Displaying the emotes in white
end

function playScenario(scenarioDic) -- Plays an emote from the given name dictionary
    print("Made it to playScenario")
    local playerPed = PlayerPedId()
    if not DoesEntityExist(playerPed) then -- Return of the ped doesn't exist
        return false
    end

    print("Attempting to Start Scenario")
    --print (scenarioDic)

    local scenarioHash = GetHashKey(scenarioDic)
    local x,y,z = table.unpack(GetEntityCoords(playerPed))
    --print (scenarioHash)

    --TaskStartScenarioInPlace(playerPed, scenarioHash, 600000, true, true, true, true) -- Start the scenario
    TaskStartScenarioAtPosition(playerPed, scenarioHash, x,y,z-0.98, GetEntityHeading(playerPed), 0, true, true, 0, true)

    print("Made it past the Scenario Call!")
    
    scenarioPlaying = true

    return true
end

function playEmote(animDict, animName, speed, speedX, duration, flags)
    if not DoesEntityExist(PlayerPedId()) then
        return false
    end

    loadAnimDict(animDict)
    TaskPlayAnim(PlayerPedId(), animDict, animName, speed, speedX, duration, flags, 0, 0, 0, 0 )
    emotePlaying = true
    return true
    
end

function attachProp(propName, boneIndex, xPos, yPos, zPos, xRot, yRot, zRot)
    if not DoesEntityExist(PlayerPedId()) then
        return false
    end

    local player = PlayerPedId()
    local x,y,z = table.unpack(GetEntityCoords(player))
    prop = CreateObject(GetHashKey(propName), x, y, z+0.2,  true,  true, true)
    AttachEntityToEntity(prop, player, GetPedBoneIndex(player, boneIndex), xPos, yPos, zPos, xRot, yRot, zRot, true, true, false, true, 1, true)
    isPropAttached = true

end

---------------------------------------------------events--------------------------------------------------------

-- RegisterCommand('emotes', function()
--     displayEmotesList() -- Displays all of the emotes
-- end)


RegisterCommand('e', function(source, args)
    local etype = string.lower(tostring(args[1]))
    if args[1] ~= nil then
        TriggerEvent("emote:invoke", etype)
    -- else
    --     TriggerEvent("chatMessage", "[System]:", {255,0,0}, "Use \"^3/emotes\"^0 to display all of the emotes")
    end
    CancelEvent()
end)

RegisterNetEvent("emote:invoke")
AddEventHandler('emote:invoke', function(name)

    if IsPedInAnyVehicle(PlayerPedId()) then -- Returns if the player is in any vehicle
        return false
    end

print(kit_emotes[name])
    if (scenario[name] ~= nil) then

        clear()
        playScenario(scenario[name])
    elseif kit_emotes[name] ~= nil then  
        Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, kit_emotes[name] , 1, 1, 0, 0)

    elseif (emote[name] ~= nil) then

        if emote[name].hasProp == false then

            clear()
            playEmote(emote[name].animDict, emote[name].animName, emote[name].speed, emote[name].speedX, emote[name].duration, emote[name].flags)

        elseif emote[name].hasProp == true then

            clear()
            playEmote(emote[name].animDict, emote[name].animName, emote[name].speed, emote[name].speedX, emote[name].duration, emote[name].flags)
            attachProp(emote[name].propName, emote[name].boneIndex, emote[name].xPos, emote[name].yPos, emote[name].zPos, emote[name].xRot, emote[name].yRot, emote[name].zRot)

        end

    elseif name == "c" then

        clear(false,true)

    else

        TriggerEvent("chatMessage", "[System]:", {255,0,0}, "Invalid emote name")

    end
end)


Citizen.CreateThread(function()-- Cancels the scenario if the player is moving
    while true do

        if scenarioPlaying then
            if (IsControlPressed(0, 32) or IsControlPressed(0, 33) or IsControlPressed(0, 34) or IsControlPressed(0, 35)) then
                clear() 
            end
        end

        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function() -- Cancels emotes with prop with Backspace
	while true do
        Citizen.Wait(0)
        if isPropAttached then
            if IsControlPressed(1, 202) and DoesEntityExist(prop) then
                Wait(200)
                clear()      
            end
        end

        -- exit holster animation if aiming is triggered
        if IsControlPressed(1, 25) and (IsEntityPlayingAnim(PlayerPedId(), 'move_m@intimidation@cop@unarmed', 'idle', 3) or IsEntityPlayingAnim(PlayerPedId(), 'move_weapon@pistol@copa', 'idle', 3) or IsEntityPlayingAnim(PlayerPedId(), 'move_weapon@pistol@cope', 'idle', 3)) then
            ClearPedTasks(PlayerPedId())
            ClearPedSecondaryTask(PlayerPedId())       
        end

        -- Cancels emote if the player is dead
        if IsPedRagdoll(PlayerPedId()) then 
            clear()
        end
	end
end)
