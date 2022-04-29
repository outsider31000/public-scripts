local systemlogs = ""
local lastcoords
local location = nil
local player = nil
local spectating = false
local visible = true
local invincible = false
local source = GetPlayerServerId(0)
local noclip = false
local RelativeMode = Config.RelativeMode
local Speed = Config.Speed
local FollowCam = Config.FollowCam
local playersx
local isDead = IsPedDeadOrDying(PlayerPedId())


--[[ RegisterNetEvent("vorp:SelectedCharacter")
AddEventHandler("vorp:SelectedCharacter", function(charid)
	kickWarning = true
	secondsUntilKick = 1800
		Citizen.CreateThread(function()
		while true do
			Wait(1000)
			local dead = IsEntityDead(PlayerPedId())
			playerPed = PlayerPedId()
			if playerPed and not dead then
				currentPos = GetEntityCoords(playerPed, true)
	
				if currentPos == prevPos then
					if time > 0 then
						if kickWarning and time == math.ceil(secondsUntilKick / 4) then
							TriggerEvent("chatMessage", "WARNING", {255, 0, 0}, "^1You'll be kicked in " .. time .. " seconds for being AFK!")
						end
	
						time = time - 1
					else
						TriggerServerEvent("kickafk")
					end
				else
					time = secondsUntilKick
				end
	
				prevPos = currentPos
			end
	end
	end)
end)
 ]]








Citizen.CreateThread(function() 
	while true do 
		Citizen.Wait(1)
		
		if IsControlJustPressed(0, 0x3C3DD371) and not isDead then -- pgdown key
			TriggerServerEvent("CheckGroup")
		end
		
		if spectating then 
			if IsControlJustPressed(0, 0x156F7119) then -- Backspace
				CancelCamera()
			end
		end

		if isDead then
			WarMenu.CloseMenu()
			local location = nil
			local player = nil
			local spectating = false
			local visible = true
			local invincible = false
			local source = GetPlayerServerId(0)
			local noclip = false
			local speed = 1.28
			CancelCamera()
		end

	end
end)

RegisterNetEvent("vorp:SelectedCharacter")
AddEventHandler("vorp:SelectedCharacter", function(charid)
	TriggerServerEvent("AnnouncePlayer")
	TriggerServerEvent("checksteam")
	Wait(1000)
	ExecuteCommand("rc")
end)

RegisterNetEvent("OpenMenu")
AddEventHandler("OpenMenu", function()
	playersx = GetPlayers()
    WarMenu.OpenMenu('AtomicMenu')
end)

Citizen.CreateThread(function()
    WarMenu.CreateMenu('AtomicMenu', "Atomic")
    WarMenu.SetSubTitle('AtomicMenu', ' ')
    WarMenu.SetMenuX('AtomicMenu', 0.04)
    WarMenu.SetMenuMaxOptionCountOnScreen('AtomicMenu', 15)
	
	WarMenu.CreateSubMenu('PlayerMenu', 'AtomicMenu', ' ')
	WarMenu.CreateSubMenu('PlayersList', 'AtomicMenu', ' ')
	WarMenu.CreateSubMenu('OptionsMenu', 'AtomicMenu', ' ')

	WarMenu.CreateSubMenu('pedmenu', 'AtomicMenu', ' ')
	WarMenu.CreateSubMenu('MenuMale', 'pedmenu', 'Male')
    WarMenu.CreateSubMenu('MenuFemale', 'pedmenu', 'Female')
    WarMenu.CreateSubMenu('MenuKid', 'pedmenu', 'Teen')
    WarMenu.CreateSubMenu('MenuHorse', 'pedmenu', 'Horses')
    WarMenu.CreateSubMenu('MenuDog', 'pedmenu', 'Dogs')
    WarMenu.CreateSubMenu('MenuAnimalGround', 'pedmenu', 'Animals')
    WarMenu.CreateSubMenu('MenuAnimalFly', 'pedmenu', 'Animals Birds')
    WarMenu.CreateSubMenu('MenuRemoveSkin', 'pedmenu', 'Remove Skin')
    WarMenu.CreateSubMenu('aw', 'pedmenu', 'Animal Weapons')

    while true do
        Citizen.Wait(0)

        if WarMenu.IsMenuOpened('AtomicMenu') then
			if WarMenu.MenuButton("Players", "PlayersList") then end
			if WarMenu.MenuButton("Options", "OptionsMenu") then end
			if WarMenu.MenuButton("Ped Menu", "pedmenu") then end
			--if WarMenu.MenuButton("Animal Weapons", "aw") then end

			if WarMenu.Button("Exit") then
				WarMenu.CloseMenu()
			end

			WarMenu.Display()
        end
		if WarMenu.IsMenuOpened('aw') then
			if WarMenu.Button("weapon_wolf") then
				giveweps('weapon_wolf')
				WarMenu.CloseMenu()
			elseif WarMenu.Button("weapon_wolf_medium") then
				giveweps('weapon_wolf_medium')
				WarMenu.CloseMenu()
			elseif WarMenu.Button("weapon_wolf_small") then
				giveweps('weapon_wolf_small')
				WarMenu.CloseMenu()
			elseif WarMenu.Button("weapon_alligator") then
				giveweps('weapon_alligator')
				WarMenu.CloseMenu()
			elseif WarMenu.Button("weapon_animal") then
				giveweps('weapon_animal')
				WarMenu.CloseMenu()
			elseif WarMenu.Button("weapon_badger") then
				giveweps('weapon_badger')
				WarMenu.CloseMenu()
			elseif WarMenu.Button("weapon_bear") then
				giveweps('weapon_bear')
				WarMenu.CloseMenu()
			elseif WarMenu.Button("weapon_beaver") then
				giveweps('weapon_beaver')
				WarMenu.CloseMenu()
			elseif WarMenu.Button("weapon_cougar") then
				giveweps('weapon_cougar')
				WarMenu.CloseMenu()
			elseif WarMenu.Button("weapon_coyote") then
				giveweps('weapon_coyote')
				WarMenu.CloseMenu()
			elseif WarMenu.Button("weapon_deer") then
				giveweps('weapon_deer')
				WarMenu.CloseMenu()
			elseif WarMenu.Button("weapon_fox") then
				giveweps('weapon_fox')
				WarMenu.CloseMenu()
			elseif WarMenu.Button("weapon_horse") then
				giveweps('weapon_horse')
				WarMenu.CloseMenu()
			elseif WarMenu.Button("weapon_muskrat") then
				giveweps('weapon_muskrat')
				WarMenu.CloseMenu()
			elseif WarMenu.Button("weapon_raccoon") then
				giveweps('weapon_raccoon')
				WarMenu.CloseMenu()
			elseif WarMenu.Button("weapon_snake") then
				giveweps('weapon_snake')
				WarMenu.CloseMenu()

			end
			WarMenu.Display()
		end
		if WarMenu.IsMenuOpened('PlayersList') then
			for k, v in pairs(playersx) do 
				if WarMenu.MenuButton(v.serverId.." : "..v.name, "PlayerMenu") then
					player = v
				end
			end
			WarMenu.Display()
		end
		
		if WarMenu.IsMenuOpened('PlayerMenu') then
			
			if WarMenu.Button('Goto Player') then 
				Teleport()
			end
			
			if WarMenu.Button('Bring Player') then 
				Bring()
			end
			
			if WarMenu.Button('Spectate Player') then 
				Spectate()
			end
			
			if WarMenu.Button('Message Player') then
				Message()
				WarMenu.CloseMenu()
			end
			
			if WarMenu.Button('Kick player', "") then 
				TriggerServerEvent("KickPlayer", player.serverId)
				TriggerServerEvent("Log", systemlogs, "Moderator", GetPlayerName(PlayerId()).." Kicked player " .. player.name, 65535)
				TriggerEvent("vorp:TipRight", "Player has been kicked.", 3000)
				WarMenu.CloseMenu()
			end
			
			WarMenu.Display()
		end
		
		if WarMenu.IsMenuOpened('OptionsMenu') then
			if WarMenu.Button('Toggle Visibility') then 
				if visible then 
					SetEntityVisible(PlayerPedId(), false)
					SetEntityCanBeDamaged(PlayerPedId(), false)
					SetEntityInvincible(PlayerPedId(), true)
		
					TriggerServerEvent("Log", systemlogs, "Visibility", GetPlayerName(PlayerId()).." turned Visibility off.", 65535)
					visible = false
				else 
					SetEntityVisible(PlayerPedId(), true)
					SetEntityCanBeDamaged(PlayerPedId(), true)
					SetEntityInvincible(PlayerPedId(), false)
					TriggerServerEvent("Log", systemlogs, "Visibility", GetPlayerName(PlayerId()).." turned Visibility on.", 65535)
					visible = true
				end
			end
			
			if WarMenu.Button("Toggle No-Clip") then
				NoClip()
				WarMenu.CloseMenu()
			end

			if WarMenu.Button('Teleport to Waypoint') then
				TeleToWaypoint()
			end
			
			if WarMenu.Button('Return to location') then 
				Return()
			end
			
			if WarMenu.Button('Send Announcement') then
				Announce()
				WarMenu.CloseMenu()
			end
			
			WarMenu.Display()
		end
		local playerPed = PlayerPedId()

        if WarMenu.IsMenuOpened('pedmenu') then
			
			if WarMenu.MenuButton('Male', 'MenuMale') then 
            end
			
			if WarMenu.MenuButton('Female', 'MenuFemale') then
            end
			
			if WarMenu.MenuButton('Teen', 'MenuKid') then
            end
			
			if WarMenu.MenuButton('Dogs', 'MenuDog') then
            end
			
			if WarMenu.MenuButton('Horses', 'MenuHorse') then
            end
			
			if WarMenu.MenuButton('Animals', 'MenuAnimalGround') then
            end
			
			if WarMenu.MenuButton('Animals Birds', 'MenuAnimalFly') then
            end
			
			if WarMenu.MenuButton('Remove Skin', 'MenuRemoveSkin') then
            end

            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('MenuMale') then	
			
		    if WarMenu.Button("(01) Dutch") then
			SetMonModel('CS_dutch')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(02) Lenny") then
			SetMonModel('CS_lenny')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(03) Leon") then
			SetMonModel('CS_leon')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(04) Marshall Thurwell") then
			SetMonModel('CS_MARSHALL_THURWELL')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(05) Micah Bell") then
			SetMonModel('CS_MicahBell')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(06) Mickey") then
			SetMonModel('CS_Mickey')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(07) Alfredo Montez") then
			SetMonModel('CS_MP_ALFREDO_MONTEZ')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(08) Sheriff Freeman") then
			SetMonModel('CS_SHERIFFFREEMAN')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(09) Sheriff Owens") then
			SetMonModel('CS_SheriffOwens')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(10) Slave Catcher") then
			SetMonModel('CS_slavecatcher')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(11) Town Crier") then
			SetMonModel('CS_TownCrier')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(12) Treasure Hunter") then
			SetMonModel('CS_TREASUREHUNTER')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(13) Vampire") then
			SetMonModel('CS_Vampire')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(14) Watson") then
			SetMonModel('CS_WATSON_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(15) Winton Holmes") then
			SetMonModel('CS_WintonHolmes')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(16) Welsh Fighter") then
			SetMonModel('CS_WELSHFIGHTER')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(17) Wrobel") then
			SetMonModel('CS_Wrobel')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(18) Jamie") then
			SetMonModel('CS_JAMIE')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(19) Joe") then
			SetMonModel('CS_JOE')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(20) German Father") then
			SetMonModel('CS_GermanFather')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(21) French Man") then
			SetMonModel('CS_FRENCHMAN_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(22) Francis Sinclair") then
			SetMonModel('CS_FRANCIS_SINCLAIR')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(23) Exotic Collector") then
			SetMonModel('CS_EXOTICCOLLECTOR')
            WarMenu.CloseMenu()

		    elseif WarMenu.Button("(24) Eagle Flies") then
			SetMonModel('CS_EagleFlies')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(25) Dr Malcolm MacIntosh") then
			SetMonModel('CS_DrMalcolmMacIntosh')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(26) Dr Higgins") then
			SetMonModel('CS_DrHiggins')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(27) Creole Doctor") then
			SetMonModel('CS_creoledoctor')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(28) Cornwall Train Conductor") then
			SetMonModel('CS_CornwallTrainConductor')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(29) Colm O Driscoll") then
			SetMonModel('CS_ColmODriscoll')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(30) Charles Smith") then
			SetMonModel('CS_charlessmith')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(31) Ashton") then
			SetMonModel('CS_ASHTON')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(32) Antony Formen") then
			SetMonModel('CS_ANTONYFOREMEN')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(33) Ansel Atherton") then
			SetMonModel('CS_ansel_atherton')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(34) Aberdeen Pig Farmer") then
			SetMonModel('CS_AberdeenPigFarmer')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(35) Val Bartender") then
			SetMonModel('U_M_O_ValBartender_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(36) Rig Train Station Worker") then
			SetMonModel('U_M_O_RigTrainStationWorker_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(37) Police Chief") then
			SetMonModel('U_M_O_BlWPoliceChief_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(38) Val Butcher") then
			SetMonModel('U_M_M_VALBUTCHER_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(39) Union Leader") then
			SetMonModel('U_M_M_UNIONLEADER_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(40) Gunsmith") then
			SetMonModel('U_M_M_TumGunsmith_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(41) Store Owner") then
			SetMonModel('U_M_M_StrGenStoreOwner_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(42) Story Treasure") then
			SetMonModel('U_M_M_story_TREASURE_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(43) Story Spectre") then
			SetMonModel('U_M_M_story_SPECTRE_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(44) Story Red Harlow") then
			SetMonModel('U_M_M_story_REDHARLOW_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(45) Story Pigfarm") then
			SetMonModel('U_M_M_story_PIGFARM_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(46) Story Hunter") then
			SetMonModel('U_M_M_story_HUNTER_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(47) Story Creeper") then
			SetMonModel('U_M_M_story_CREEPER_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(48) Story Cannibal") then
			SetMonModel('U_M_M_story_CANNIBAL_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(49) Skinny Old Guy") then
			SetMonModel('U_M_M_SKINNYOLDGUY_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(50) Shack Serial Killer") then
			SetMonModel('U_M_M_SHACKSERIALKILLER_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(51) Bank Guard") then
			SetMonModel('U_M_M_SDBANKGUARD_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(52) Donkey Rider") then
			SetMonModel('U_M_M_RKRDONKEYRIDER_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(53) Undertaker") then
			SetMonModel('U_M_M_RhdUndertaker_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(54) Priest") then
			SetMonModel('U_M_M_NbxPriest_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(55) Musician") then
			SetMonModel('U_M_M_NbxMusician_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(56) Graverobber") then
			SetMonModel('U_M_M_NBXGraverobber_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(57) Boat Ticket Seller") then
			SetMonModel('U_M_M_NbxBoatTicketSeller_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(58) Doorman") then
			SetMonModel('U_M_M_GAMDoorman_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(59) Fat Duster") then
			SetMonModel('U_M_M_FATDUSTER_01')
            WarMenu.CloseMenu()
				
		    elseif WarMenu.Button("(60) Executioner") then
			SetMonModel('U_M_M_EXECUTIONER_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(61) Witness") then
			SetMonModel('U_M_M_CRDWITNESS_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(62) Manager") then
			SetMonModel('U_M_M_CKTManager_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(63) Circus Wagon") then
			SetMonModel('U_M_M_CircusWagon_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(64) Bullet Catch Volunteer") then
			SetMonModel('U_M_M_BULLETCATCHVOLUNTEER_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(65) Train Station Worker") then
			SetMonModel('U_M_M_BlWTrainStationWorker_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(66) Oldman") then
			SetMonModel('U_M_M_BHT_OLDMAN')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(67) Mine Foreman") then
			SetMonModel('U_M_M_BHT_MINEFOREMAN')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(68) Lover") then
			SetMonModel('U_M_M_BHT_LOVER')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(69) Prisoner") then
			SetMonModel('U_M_M_AsbPrisoner_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(70) Dead Man") then
			SetMonModel('U_M_M_APFDeadMan_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(71) Army") then
			SetMonModel('S_M_Y_Army_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(72) Lumberjack") then
			SetMonModel('S_M_M_StrLumberjack_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(73) Magic Lanyern") then
			SetMonModel('S_M_M_MAGICLANTERN_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(74) Wildman") then
			SetMonModel('RE_WILDMAN_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(75) Torturing Captive") then
			SetMonModel('RE_TORTURINGCAPTIVE_MALES_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(76) Pickpocket") then
			SetMonModel('RE_PICKPOCKET_MALES_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(77) Naked") then
			SetMonModel('RE_NAKEDSWIMMER_MALES_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(78) Drunk Dueler") then
			SetMonModel('RE_DRUNKDUELER_MALES_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(79) Mr Mayor") then
			SetMonModel('RCSP_MRMAYOR_MALES_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(80) Winter") then
			SetMonModel('MSP_WINTER4_MALES_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(81) Train Robbery") then
			SetMonModel('MSP_TRAINROBBERY2_MALES_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(82) Saloon") then
			SetMonModel('MSP_SALOON1_MALES_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(83) Gang") then
			SetMonModel('MSP_GANG2_MALES_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(84) Laborer") then
			SetMonModel('A_M_M_BlWLaborer_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(85) Town Folk") then
			SetMonModel('A_M_M_AsbTownfolk_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(86) Card Game Players") then
			SetMonModel('A_M_M_CARDGAMEPLAYERS_01')
            WarMenu.CloseMenu()
			
            elseif WarMenu.Button("Remove Skin") then
            ExecuteCommand('reloadcloths')
            WarMenu.CloseMenu()
			
            end
            WarMenu.Display()
			
        elseif WarMenu.IsMenuOpened('MenuFemale') then -- FEMALE
			
		    if WarMenu.Button("(01)Town Folk") then
			SetMonModel('A_F_M_ARMTOWNFOLK_01')
            WarMenu.CloseMenu()
		
		    elseif WarMenu.Button("(02) Fancy Travellers") then
			SetMonModel('A_F_M_BiVFancyTravellers_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(03) Obese Women") then
			SetMonModel('A_F_M_BTCObeseWomen_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(04) Family Travelers") then
			SetMonModel('A_F_M_FAMILYTRAVELERS_COOL_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(05) High Society") then
			SetMonModel('A_F_M_GaMHighSociety_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(06) Train Passenger") then
			SetMonModel('A_F_M_LOWERTRAINPASSENGERS_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(07) Slums") then
			SetMonModel('A_F_M_NbxSlums_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(08) Upper Class") then
			SetMonModel('A_F_M_NbxUpperClass_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(09) Whore") then
			SetMonModel('A_F_M_NbxWhore_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(10) Prostitute") then
			SetMonModel('A_F_M_RhdProstitute_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(11) Fancy Whore") then
			SetMonModel('A_F_M_SDFancyWhore_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(12) China Town") then
			SetMonModel('A_F_M_SDChinatown_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(13) Prison") then
			SetMonModel('A_F_M_SKPPRISONONLINE_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(14) Val Prostitute") then
			SetMonModel('A_F_M_ValProstitute_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(15) Hill Billy") then
			SetMonModel('A_F_O_BtcHillbilly_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(16) Wap Town Folk") then
			SetMonModel('A_F_O_WAPTOWNFOLK_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(17) Rancher") then
			SetMonModel('MBH_RHODESRANCHER_FEMALES_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(18) Bounty Hunter") then
			SetMonModel('MSP_BOUNTYHUNTER1_FEMALES_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(19) Industry") then
			SetMonModel('MSP_INDUSTRY1_FEMALES_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(20) Mary") then
			SetMonModel('MSP_MARY1_FEMALES_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(21) Naked Black") then
			SetMonModel('MSP_SALOON1_FEMALES_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(22) Abigail") then
			SetMonModel('RCES_ABIGAIL3_FEMALES_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(23) Penelope Beauand") then
			SetMonModel('RCSP_BEAUANDPENELOPE1_FEMALES_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(24) Crackpot") then
			SetMonModel('RCSP_CRACKPOT_FEMALES_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(25) Odriscolls") then
			SetMonModel('RCSP_ODRISCOLLS2_FEMALES_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(26) Escort") then
			SetMonModel('RE_ESCORT_FEMALES_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(27) Worker") then
			SetMonModel('S_F_M_BwmWorker_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(28) Mother") then
			SetMonModel('U_F_M_LagMother_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(29) Resident") then
			SetMonModel('U_F_M_NbxResident_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(30) Nude") then
			SetMonModel('U_F_M_RhdNudeWoman_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(31) Black Belle") then
			SetMonModel('U_F_M_STORY_BLACKBELLE_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(32) Bartender") then
			SetMonModel('U_F_M_TljBartender_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(33) Store Owner") then
			SetMonModel('U_F_M_TumGeneralStoreOwner_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(34) Hermit") then
			SetMonModel('U_F_O_Hermit_woman_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(35) Aberdeen Sister") then
			SetMonModel('CS_AberdeenSister')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(36) Acrobat") then
			SetMonModel('CS_Acrobat')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(37) Braithwaite Maid") then
			SetMonModel('CS_braithwaitemaid')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(38) Brenda Crawley") then
			SetMonModel('CS_brendacrawley')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(39) Catherine Braithwaite") then
			SetMonModel('CS_catherinebraithwaite')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(40) Creepy Old Lady") then
			SetMonModel('CS_creepyoldlady')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(41) Doroethea Wicklow") then
			SetMonModel('CS_DOROETHEAWICKLOW')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(42) Edith Down") then
			SetMonModel('CS_EdithDown')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(43) German Mother") then
			SetMonModel('CS_GermanMother')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(44) Gloria") then
			SetMonModel('CS_GLORIA')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(45) Karen") then
			SetMonModel('CS_karen')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(46) Lillian Powell") then
			SetMonModel('CS_LillianPowell')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(47) Lilly Millet") then
			SetMonModel('CS_lillymillet')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(48) Mama Watson") then
			SetMonModel('CS_MAMAWATSON')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(49) Mary Beth") then
			SetMonModel('CS_marybeth')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(50) Meredith") then
			SetMonModel('CS_Meredith')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(51) Miss Marjorie") then
			SetMonModel('CS_missMarjorie')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(52) Mrs Calhoun") then
			SetMonModel('CS_Mrs_Calhoun')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(53) Susan Grimshaw") then
			SetMonModel('CS_susangrimshaw')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(54) Sword Dancer") then
			SetMonModel('CS_SwordDancer')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(55) Bath Girl") then
			SetMonModel('CS_VHT_BATHGIRL')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(56) Twin Groupie") then
			SetMonModel('CS_twingroupie_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(57) Opera Singer") then
			SetMonModel('CS_OPERASINGER')
            WarMenu.CloseMenu()
			
            elseif WarMenu.Button("Remove Skin") then
            ExecuteCommand('reloadcloths')
            WarMenu.CloseMenu()
			
            end
            WarMenu.Display()
			
        elseif WarMenu.IsMenuOpened('MenuKid') then -- TEEN
			
		    if WarMenu.Button("(01) Rhode Rancher") then
			SetMonModel('MBH_RHODESRANCHER_TEENS_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(02) Marston") then
			SetMonModel('MES_MARSTON6_TEENS_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(03) Mob") then
			SetMonModel('MSP_MOB1_TEENS_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(04) Calderon") then
			SetMonModel('RCSP_CALDERONSTAGE2_TEENS_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(05) Poisoned") then
			SetMonModel('RCSP_POISONEDWELL_TEENS_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(06) News Paper Boy") then
			SetMonModel('S_M_Y_NewspaperBoy_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(07) Public") then
			SetMonModel('RE_PUBLICHANGING_TEENS_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(08) Skipping Stones") then
			SetMonModel('RE_SKIPPINGSTONES_TEENS_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(09) Taunting") then
			SetMonModel('RE_TAUNTING_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(10) Taunting 02") then
			SetMonModel('RE_TAUNTING_MALES_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(11) Street Nbx") then
			SetMonModel('A_M_Y_NbxStreetKids_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(12) Street Slum") then
			SetMonModel('A_M_Y_NbxStreetKids_Slums_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(13) Street Slum 02") then
			SetMonModel('A_M_Y_SDStreetKids_Slums_02')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(14) Starving Shack") then
			SetMonModel('U_M_Y_ShackStarvingKid_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(15) Caj Home Stead") then
			SetMonModel('U_M_Y_CajHomeStead_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(16) Girl Braithwaites") then
			SetMonModel('U_F_Y_BRAITHWAITESSECRET_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(17) Home Stead Daughter") then
			SetMonModel('U_F_Y_CzPHomesteadDaughter_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(18) Street Kid") then
			SetMonModel('CS_SD_STREETKID_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(19) Street Kid 02") then
			SetMonModel('CS_SD_STREETKID_02')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(20) Kid Thief") then
			SetMonModel('CS_SDStreetKidThief')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(21) Duncangeddes") then
			SetMonModel('CS_duncangeddes')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(22) German Daughter") then
			SetMonModel('CS_GermanDaughter')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(23) German Son") then
			SetMonModel('CS_GermanSon')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(24) Jack Marston") then
			SetMonModel('CS_jackmarston_teen')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(25) London Derry Son") then
			SetMonModel('CS_LondonderrySon')
            WarMenu.CloseMenu()
			
			elseif WarMenu.Button("(26) Mixed Race") then
			SetMonModel('CS_MIXEDRACEKID')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(27) Wapiti Boy") then
			SetMonModel('CS_WapitiBoy')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(28) Princess Isabeau") then
			SetMonModel('CS_PrincessIsabeau')
            WarMenu.CloseMenu()
			
            elseif WarMenu.Button("Remove Skin") then
            ExecuteCommand('reloadcloths')
            WarMenu.CloseMenu()
			
            end
            WarMenu.Display()
			
        elseif WarMenu.IsMenuOpened('MenuDog') then -- ANIMALS DOGS
			
		    if WarMenu.Button("(01) Dog American Foxhound") then
			SetMonModel('A_C_DogAmericanFoxhound_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(02) Dog Australia Sheperd") then
			SetMonModel('A_C_DogAustralianSheperd_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(03) Dog Blue Tick Coonhound") then
			SetMonModel('A_C_DogBluetickCoonhound_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(04) Dog Catahoula Cur") then
			SetMonModel('A_C_DogCatahoulaCur_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(05) Dog ChesBay Retriever") then
			SetMonModel('A_C_DogChesBayRetriever_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(06) Dog Collie") then
			SetMonModel('A_C_DogCollie_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(07) Dog Hobo") then
			SetMonModel('A_C_DogHobo_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(08) Dog Hound") then
			SetMonModel('A_C_DogHound_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(09) Dog Husky") then
			SetMonModel('A_C_DogHusky_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(10) Dog Lab") then
			SetMonModel('A_C_DogLab_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(11) Dog Lion") then
			SetMonModel('A_C_DogLion_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(12) Dog Poodle") then
			SetMonModel('A_C_DogPoodle_0')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(13) Dog Rufus") then
			SetMonModel('A_C_DogRufus_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(14) Dog Street") then
			SetMonModel('A_C_DogStreet_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(15) Dog LostDog") then
			SetMonModel('RE_LOSTDOG_DOGS_01')
            WarMenu.CloseMenu()
			
            elseif WarMenu.Button("Remove Skin") then
            ExecuteCommand('reloadcloths')
            WarMenu.CloseMenu()
		
            end
            WarMenu.Display()	
			
        elseif WarMenu.IsMenuOpened('MenuHorse') then  -- HORSE
			
		    if WarMenu.Button("(01) AmericanPaint Greyovero") then
			SetMonModel('A_C_Horse_AmericanPaint_Greyovero')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(02) AmericanPaint Overo") then
			SetMonModel('A_C_Horse_AmericanPaint_Overo')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(03) AmericanPaint SplashedWhite") then
			SetMonModel('A_C_Horse_AmericanPaint_SplashedWhite')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(04) AmericanPaint Tobiano") then
			SetMonModel('A_C_Horse_AmericanPaint_Tobiano')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(05) Gypsycob Palominoblagdon") then
			SetMonModel('a_c_horse_gypsycob_palominoblagdon')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(06) Gypsycob Piebald") then
			SetMonModel('a_c_horse_gypsycob_piebald')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(07) Gypsycob Splashedbay") then
			SetMonModel('a_c_horse_gypsycob_splashedbay')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(08) Gypsycob Splashedpiebald") then
			SetMonModel('a_c_horse_gypsycob_splashedpiebald')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(09) Gypsycob Skewbald") then
			SetMonModel('a_c_horse_gypsycob_skewbald')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(10) Gypsycob Whiteblagdon") then
			SetMonModel('a_c_horse_gypsycob_whiteblagdon')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(11) American Standardbred Black") then
			SetMonModel('A_C_Horse_AmericanStandardbred_Black')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(12) American Standardbred Buckskin") then
			SetMonModel('A_C_Horse_AmericanStandardbred_Buckskin')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(13) American Standardbred PalominoDapple") then
			SetMonModel('A_C_Horse_AmericanStandardbred_PalominoDapple')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(14) American Standardbred SilverTail Buckskin") then
			SetMonModel('A_C_Horse_AmericanStandardbred_SilverTailBuckskin')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(16) Andalusian DarkBay") then
			SetMonModel('A_C_Horse_Andalusian_DarkBay')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(17) Andalusian Perlino") then
			SetMonModel('A_C_Horse_Andalusian_Perlino')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(18) Andalusian RoseGray") then
			SetMonModel('A_C_Horse_Andalusian_RoseGray')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(19) Appaloosa Black Snowflake") then
			SetMonModel('A_C_Horse_Appaloosa_BlackSnowflake')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(20) Appaloosa Blanket") then
			SetMonModel('A_C_Horse_Appaloosa_Blanket')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(21) Appaloosa Brown Leopard") then
			SetMonModel('A_C_Horse_Appaloosa_BrownLeopard')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(22) Appaloosa FewSpotted") then
			SetMonModel('A_C_Horse_Appaloosa_FewSpotted_PC')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(23) Appaloosa Leopard") then
			SetMonModel('A_C_Horse_Appaloosa_Leopard')
            WarMenu.CloseMenu()

		    elseif WarMenu.Button("(24) Appaloosa Leopard Blanket") then
			SetMonModel('A_C_Horse_Appaloosa_LeopardBlanket')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(25) Arabian Black") then
			SetMonModel('A_C_Horse_Arabian_Black')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(26) Arabian Grey") then
			SetMonModel('A_C_Horse_Arabian_Grey')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(27) Arabian White") then
			SetMonModel('A_C_Horse_Arabian_White')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(28) Arabian RoseGreyBay") then
			SetMonModel('A_C_Horse_Arabian_RoseGreyBay')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(29) Arabian WarpedBrindle") then
			SetMonModel('A_C_Horse_Arabian_WarpedBrindle_PC')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(30) Ardennes BayRoan") then
			SetMonModel('A_C_Horse_Ardennes_BayRoan')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(31) Ardennes IronGreyRoan") then
			SetMonModel('A_C_Horse_Ardennes_IronGreyRoan')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(32) Ardennes StrawberryRoan") then
			SetMonModel('A_C_Horse_Ardennes_StrawberryRoan')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(33) Belgian BlondChestnut") then
			SetMonModel('A_C_Horse_Belgian_BlondChestnut')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(34) Belgian MealyChestnut") then
			SetMonModel('A_C_Horse_Belgian_MealyChestnut')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(35) DutchWarmblood ChocolateRoan") then
			SetMonModel('A_C_Horse_DutchWarmblood_ChocolateRoan')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(36) DutchWarmblood SealBrown") then
			SetMonModel('A_C_Horse_DutchWarmblood_SealBrown')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(37) DutchWarmblood SootyBuckskin") then
			SetMonModel('A_C_Horse_DutchWarmblood_SootyBuckskin')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(38) HungarianHalfbred DarkDappleGrey") then
			SetMonModel('A_C_Horse_HungarianHalfbred_DarkDappleGrey')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(39) HungarianHalfbred FlaxenChestnut") then
			SetMonModel('A_C_Horse_HungarianHalfbred_FlaxenChestnut')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(40) HungarianHalfbred LiverChestnut") then
			SetMonModel('A_C_Horse_HungarianHalfbred_LiverChestnut')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(41) KentuckySaddle Black") then
			SetMonModel('A_C_Horse_KentuckySaddle_Black')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(42) KentuckySaddle ButterMilkBuckskin") then
			SetMonModel('A_C_Horse_KentuckySaddle_ButterMilkBuckskin_PC')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(43) KentuckySaddle ChestnutPinto") then
			SetMonModel('A_C_Horse_KentuckySaddle_ChestnutPinto')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(44) KentuckySaddle Grey") then
			SetMonModel('A_C_Horse_KentuckySaddle_Grey')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(45) KentuckySaddle SilverBay") then
			SetMonModel('A_C_Horse_KentuckySaddle_SilverBay')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(46) Kladruber Black") then
			SetMonModel('A_C_Horse_Kladruber_Black')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(47) Kladruber Silver") then
			SetMonModel('A_C_Horse_Kladruber_Silver')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(48) Kladruber Cremello") then
			SetMonModel('A_C_Horse_Kladruber_Cremello')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(49) Kladruber Grey") then
			SetMonModel('A_C_Horse_Kladruber_Grey')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(50) Kladruber DappleRoseGrey") then
			SetMonModel('A_C_Horse_Kladruber_DappleRoseGrey')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(51) Kladruber White") then
			SetMonModel('A_C_Horse_Kladruber_White')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(52) MissouriFoxTrotter AmberChampagne") then
			SetMonModel('A_C_Horse_MissouriFoxTrotter_AmberChampagne')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(53) MissouriFoxTrotter SableChampagne") then
			SetMonModel('A_C_Horse_MissouriFoxTrotter_SableChampagne')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(54) MissouriFoxTrotter SilverDapplePinto") then
			SetMonModel('A_C_Horse_MissouriFoxTrotter_SilverDapplePinto')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(55) MissouriFoxtrotter Blacktovero") then
			SetMonModel('A_C_Horse_MissouriFoxtrotter_Blacktovero')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(56) MissouriFoxtrotter Blueroan") then
			SetMonModel('A_C_Horse_MissouriFoxtrotter_Blueroan')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(57) MissouriFoxtrotter Buckskinbrindle") then
			SetMonModel('A_C_Horse_MissouriFoxtrotter_Buckskinbrindle')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(58) MissouriFoxtrotter Dapplegrey") then
			SetMonModel('A_C_Horse_MissouriFoxtrotter_Dapplegrey')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(59) Morgan Bay") then
			SetMonModel('A_C_Horse_Morgan_Bay')
            WarMenu.CloseMenu()
				
		    elseif WarMenu.Button("(60) Morgan BayRoan") then
			SetMonModel('A_C_Horse_Morgan_BayRoan')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(61) Morgan FlaxenChestnut") then
			SetMonModel('A_C_Horse_Morgan_FlaxenChestnut')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(62) Morgan LiverChestnut") then
			SetMonModel('A_C_Horse_Morgan_LiverChestnut_PC')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(63) Morgan Palomino") then
			SetMonModel('A_C_Horse_Morgan_Palomino')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(64) Mangy") then
			SetMonModel('A_C_Horse_MP_Mangy_Backup')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(65) Mustang GoldenDun") then
			SetMonModel('A_C_Horse_Mustang_GoldenDun')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(66) Mustang GrulloDun") then
			SetMonModel('A_C_Horse_Mustang_GrulloDun')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(67) Mustang TigerStripedBay") then
			SetMonModel('A_C_Horse_Mustang_TigerStripedBay')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(68) Mustang WildBay") then
			SetMonModel('A_C_Horse_Mustang_WildBay')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(69) Mustang Blackovero") then
			SetMonModel('A_C_Horse_Mustang_Blackovero')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(70) Mustang Buckskin") then
			SetMonModel('A_C_Horse_Mustang_Buckskin')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(71) Mustang Chestnuttovero") then
			SetMonModel('A_C_Horse_Mustang_Chestnuttovero')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(72) Mustang Reddunovero") then
			SetMonModel('A_C_Horse_Mustang_Reddunovero')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(73) Nokota BlueRoan") then
			SetMonModel('A_C_Horse_Nokota_BlueRoan')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(74) Nokota ReverseDappleRoan") then
			SetMonModel('A_C_Horse_Nokota_ReverseDappleRoan')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(75) Nokota WhiteRoan") then
			SetMonModel('A_C_Horse_Nokota_WhiteRoan')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(76) Shire DarkBay") then
			SetMonModel('A_C_Horse_Shire_DarkBay')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(77) Shire LightGrey") then
			SetMonModel('A_C_Horse_Shire_LightGrey')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(78) Shire RavenBlack") then
			SetMonModel('A_C_Horse_Shire_RavenBlack')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(79) SuffolkPunch RedChestnut") then
			SetMonModel('A_C_Horse_SuffolkPunch_RedChestnut')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(80) SuffolkPunch Sorrel") then
			SetMonModel('A_C_Horse_SuffolkPunch_Sorrel')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(81) TennesseeWalker BlackRabicano") then
			SetMonModel('A_C_Horse_TennesseeWalker_BlackRabicano')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(82) TennesseeWalker Chestnut") then
			SetMonModel('A_C_Horse_TennesseeWalker_Chestnut')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(83) TennesseeWalker DappleBay") then
			SetMonModel('A_C_Horse_TennesseeWalker_DappleBay')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(84) TennesseeWalker FlaxenRoan") then
			SetMonModel('A_C_Horse_TennesseeWalker_FlaxenRoan')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(85) TennesseeWalker MahoganyBay") then
			SetMonModel('A_C_Horse_TennesseeWalker_MahoganyBay')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(86) TennesseeWalker RedRoan") then
			SetMonModel('A_C_Horse_TennesseeWalker_RedRoan')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(87) Thoroughbred BlackChestnut") then
			SetMonModel('A_C_Horse_Thoroughbred_BlackChestnut')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(88) Thoroughbred BloodBay") then
			SetMonModel('A_C_Horse_Thoroughbred_BloodBay')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(89) Thoroughbred Brindle") then
			SetMonModel('A_C_Horse_Thoroughbred_Brindle')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(90) Thoroughbred DappleGrey") then
			SetMonModel('A_C_Horse_Thoroughbred_DappleGrey')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(91) Thoroughbred ReverseDappleBlack") then
			SetMonModel('A_C_Horse_Thoroughbred_ReverseDappleBlack')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(92) Turkoman DarkBay") then
			SetMonModel('A_C_Horse_Turkoman_DarkBay')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(93) Turkoman Gold") then
			SetMonModel('A_C_Horse_Turkoman_Gold')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(94) Turkoman Silver") then
			SetMonModel('A_C_Horse_Turkoman_Silver')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(95) Turkoman Black") then
			SetMonModel('A_C_Horse_Turkoman_Black')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(96) Turkoman Chestnut") then
			SetMonModel('A_C_Horse_Turkoman_Chestnut')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(97) Turkoman Grey") then
			SetMonModel('A_C_Horse_Turkoman_Grey')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(98) Turkoman Perlino") then
			SetMonModel('A_C_Horse_Turkoman_Perlino')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(99) Criollo Dun") then
			SetMonModel('A_C_Horse_Criollo_Dun')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(100) Criollo MarbleSabino") then
			SetMonModel('A_C_Horse_Criollo_MarbleSabino')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(101) Criollo_BayFrameOvero") then
			SetMonModel('A_C_Horse_Criollo_BayFrameOvero')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(102) Criollo BayBrindle") then
			SetMonModel('A_C_Horse_Criollo_BayBrindle')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(103) Criollo SorrelOvero") then
			SetMonModel('A_C_Horse_Criollo_SorrelOvero')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(104) Criollo BlueRoanOvero") then
			SetMonModel('A_C_Horse_Criollo_BlueRoanOvero')
            WarMenu.CloseMenu()
				
		    elseif WarMenu.Button("(105) Breton SteelGrey") then
			SetMonModel('A_C_Horse_Breton_SteelGrey')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(106) Breton MealyDapple") then
			SetMonModel('A_C_Horse_Breton_MealyDapple')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(107) Breton SealBrown") then
			SetMonModel('A_C_Horse_Breton_SealBrown')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(108) Breton GrulloDun") then
			SetMonModel('A_C_Horse_Breton_GrulloDun')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(109) Breton Sorrel") then
			SetMonModel('A_C_Horse_Breton_Sorrel')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(110) Breton RedRoan") then
			SetMonModel('A_C_Horse_Breton_RedRoan')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(111) NORFOLKROADSTER BLACK") then
			SetMonModel('A_C_HORSE_NORFOLKROADSTER_BLACK')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(112) NORFOLKROADSTER SPECKLEDGREY") then
			SetMonModel('A_C_HORSE_NORFOLKROADSTER_SPECKLEDGREY')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(113) NORFOLKROADSTER PIEBALDROAN") then
			SetMonModel('A_C_HORSE_NORFOLKROADSTER_PIEBALDROAN')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(114) NORFOLKROADSTER ROSEGREY") then
			SetMonModel('A_C_HORSE_NORFOLKROADSTER_ROSEGREY')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(115) NORFOLKROADSTER DAPPLEDBUCKSKIN") then
			SetMonModel('A_C_HORSE_NORFOLKROADSTER_DAPPLEDBUCKSKIN')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(116) NORFOLKROADSTER SPOTTEDTRICOLOR") then
			SetMonModel('A_C_HORSE_NORFOLKROADSTER_SPOTTEDTRICOLOR')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(117) Zebra") then
			SetMonModel('A_C_HorseMulePainted_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(118) Mule") then
			SetMonModel('A_C_HorseMule_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(119) Donkey") then
			SetMonModel('A_C_Donkey_01')
            WarMenu.CloseMenu()
			
            elseif WarMenu.Button("Remove Skin") then
            ExecuteCommand('reloadcloths')
            WarMenu.CloseMenu()
			
            end
            WarMenu.Display()
			
        elseif WarMenu.IsMenuOpened('MenuAnimalGround') then -- ANIMALS GROUND
		
			if WarMenu.Button("(01) Alligator") then
			SetMonModel('a_c_alligator_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(02) Armadillo") then
			SetMonModel('a_c_armadillo_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(03) Badger") then
			SetMonModel('a_c_badger_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(04) Bear") then
			SetMonModel('A_C_Bear_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(05) Black bear") then
			SetMonModel('A_C_BearBlack_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(06) Beaver") then
			SetMonModel('A_C_Beaver_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(07) Big Horn Ram") then
			SetMonModel('A_C_BigHornRam_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(08) Boar") then
			SetMonModel('A_C_Boar_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(09) Buck") then
			SetMonModel('A_C_Buck_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(10) Buffalo") then
			SetMonModel('A_C_Buffalo_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(11) Buffalo Tatanka") then
			SetMonModel('A_C_Buffalo_Tatanka_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(12) Bull") then
			SetMonModel('A_C_Ox_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(13) Cat") then
			SetMonModel('A_C_Cat_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(14) Chicken (Not moving)") then -- not moving
			SetMonModel('A_C_Chicken_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(15) Chipmunk (Bad Camera)") then -- bad camera
			SetMonModel('A_C_Chipmunk_01')
            WarMenu.CloseMenu()

		    elseif WarMenu.Button("(16) Cougar") then
			SetMonModel('A_C_Cougar_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(17) Cow") then
			SetMonModel('A_C_Cow')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(18) Coyote") then
			SetMonModel('A_C_Coyote_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(19) Crab (Bad Camera)") then -- bad camera
			SetMonModel('A_C_Crab_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(20) Crawfish (Not Moving)") then -- bad camera and not moving
			SetMonModel('A_C_Crawfish_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(21) Deer") then
			SetMonModel('A_C_Deer_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(22) Donkey") then
			SetMonModel('A_C_Donkey_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(23) Elk") then
			SetMonModel('A_C_Elk_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(24) Fox") then
			SetMonModel('A_C_Fox_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(25) Frog Bull (Bad Camera)") then -- bad camera
			SetMonModel('A_C_FrogBull_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(26) Gila Monster") then
			SetMonModel('A_C_GilaMonster_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(27) Goat") then
			SetMonModel('A_C_Goat_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(28) Iguana Desert") then
			SetMonModel('A_C_IguanaDesert_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(29) Javelina") then
			SetMonModel('A_C_Javelina_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(30) Lion") then
			SetMonModel('A_C_LionMangy_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(31) Moose") then
			SetMonModel('A_C_Moose_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(32) Muskrat") then
			SetMonModel('A_C_Muskrat_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(33) Panther") then
			SetMonModel('A_C_Panther_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(34) Pig") then
			SetMonModel('A_C_Pig_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(35) Possum") then
			SetMonModel('A_C_Possum_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(36) Pronghorn") then
			SetMonModel('A_C_Pronghorn_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(37) Rabbit") then
			SetMonModel('A_C_Rabbit_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(38) Raccoon") then
			SetMonModel('A_C_Raccoon_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(39) Rat (Bad Camera)") then -- bad camera
			SetMonModel('A_C_Rat_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(40) Rooster (Not Moving)") then -- not moving
			SetMonModel('A_C_Rooster_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(41) Sheep") then
			SetMonModel('A_C_Sheep_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(42) Skunk") then
			SetMonModel('A_C_Skunk_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(43) Snake") then
			SetMonModel('A_C_Snake_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(44) Snake BlackTail Rattle") then
			SetMonModel('A_C_SnakeBlackTailRattle_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(45) Snake Fer De Lance") then
			SetMonModel('A_C_SnakeFerDeLance_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(46) Snake Red Boa") then
			SetMonModel('A_C_SnakeRedBoa_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(47) Snake Red Boa 10ft") then
			SetMonModel('A_C_SnakeRedBoa10ft_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(48) Squirrel (Bad Camera)") then --bad camera
			SetMonModel('A_C_Squirrel_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(49) Toad (Bad Camera)") then -- bad camera
			SetMonModel('A_C_Toad_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(50) Turkey (Not Moving)") then -- not moving
			SetMonModel('A_C_Turkey_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(51) Turkey 02 (Not Moving)") then -- not moving
			SetMonModel('A_C_Turkey_02')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(52) Turtle Snapping") then
			SetMonModel('A_C_TurtleSnapping_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(53) Wolf") then
			SetMonModel('A_C_Wolf')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(54) Wolf Medium") then
			SetMonModel('A_C_Wolf_Medium')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(55) Wolf Small") then
			SetMonModel('A_C_Wolf_Small')
            WarMenu.CloseMenu()
			
            elseif WarMenu.Button("Remove Skin") then
            ExecuteCommand('reloadcloths')
            WarMenu.CloseMenu()
		
            end
            WarMenu.Display()	

        elseif WarMenu.IsMenuOpened('MenuAnimalFly') then -- ANIMALS FLY
		
		    if WarMenu.Button("(01) Bat") then --not moving and bad camera 
			SetMonModel('A_C_Bat_01')
            WarMenu.CloseMenu()
			
			elseif WarMenu.Button("(02) Blue Jay") then --not moving and bad camera
			SetMonModel('A_C_BlueJay_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(03) Condor") then -- not moving 
			SetMonModel('A_C_CaliforniaCondor_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(04) Cardinal") then -- not moving and bad camera
			SetMonModel('A_C_Cardinal_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(05) Parakeet") then -- Not moving
			SetMonModel('A_C_CarolinaParakeet_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(06) Cedar WaxWing") then -- not moving
			SetMonModel('A_C_CedarWaxwing_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(07) Cormorant") then  -- not moving
			SetMonModel('A_C_Cormorant_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(08) Crane Whooping") then
			SetMonModel('A_C_CraneWhooping_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(09) Crow") then
			SetMonModel('A_C_Crow_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(10) Eagle") then
			SetMonModel('A_C_Eagle_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(11) Egret") then
			SetMonModel('A_C_Egret_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(12) Canada Goose") then
			SetMonModel('A_C_GooseCanada_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(13) Hawk") then
			SetMonModel('A_C_Hawk_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(14) Heron") then
			SetMonModel('A_C_Heron_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(15) Loon") then
			SetMonModel('A_C_Loon_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(16) Oriole") then
			SetMonModel('A_C_Oriole_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(17) Owl") then
			SetMonModel('A_C_Owl_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(18) Parrot") then
			SetMonModel('A_C_Parrot_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(19) Pelican") then
			SetMonModel('A_C_Pelican_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(20) Pheasant") then
			SetMonModel('A_C_Pheasant_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(21) Pigeon") then
			SetMonModel('A_C_Pigeon')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(22) Prairie Chicken") then
			SetMonModel('A_C_PrairieChicken_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(23) Quail") then
			SetMonModel('A_C_Quail_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(24) Raven") then
			SetMonModel('A_C_Raven_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(25) Red Footed Booby") then
			SetMonModel('A_C_RedFootedBooby_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(26) Robin") then
			SetMonModel('A_C_Robin_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(27) Roseate Spoonbill") then
			SetMonModel('A_C_RoseateSpoonbill_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(28) Seagull") then
			SetMonModel('A_C_Seagull_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(29) Song Bird") then
			SetMonModel('A_C_SongBird_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(30) Sparrow") then
			SetMonModel('A_C_Sparrow_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(31) Wild Turkey") then
			SetMonModel('A_C_TurkeyWild_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(32) Vulture") then
			SetMonModel('A_C_Vulture_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(33) Woodpecker") then
			SetMonModel('A_C_Woodpecker_01')
            WarMenu.CloseMenu()
			
		    elseif WarMenu.Button("(34) Woodpecker 02") then
			SetMonModel('A_C_Woodpecker_02')
            WarMenu.CloseMenu()
			
            elseif WarMenu.Button("Remove Skin") then
            ExecuteCommand('reloadcloths')
            WarMenu.CloseMenu()
			
            end
            WarMenu.Display()
			
        elseif WarMenu.IsMenuOpened('MenuRemoveSkin') then
			
            if WarMenu.Button("Remove Skin") then
            ExecuteCommand('reloadcloths')
            WarMenu.CloseMenu()
			
            end
            WarMenu.Display()
		
		end
    end
end)
RegisterNetEvent("fixanimals:attack")
AddEventHandler("fixanimals:attack", function(attacker, entity)
	local attackerPed = GetPlayerPed(GetPlayerFromServerId(attacker))
	local attackType = GetAttackType(attackerPed)

	if entity == -1 then
		ApplyAttackToTarget(attackerPed, PlayerPedId(), attackType)
	else
		ApplyAttackToTarget(attackerPed, NetToPed(entity), attackType)
	end
end)

function GetPedCrouchMovement(ped)
	return Citizen.InvokeNative(0xD5FE956C70FF370B, ped)
end

function SetPedCrouchMovement(ped, state, immediately)
	Citizen.InvokeNative(0x7DE9692C6F64CFE8, ped, state, immediately)
end

function PlayAnimation(anim)
	if not DoesAnimDictExist(anim.dict) then
		print("Invalid animation dictionary: " .. anim.dict)
		return
	end

	RequestAnimDict(anim.dict)

	while not HasAnimDictLoaded(anim.dict) do
		Citizen.Wait(0)
	end

	TaskPlayAnim(PlayerPedId(), anim.dict, anim.name, 4.0, 4.0, -1, 0, 0.0, false, false, false, "", false)

	RemoveAnimDict(anim.dict)
end

function GetAttackType(playerPed)
	local playerModel = GetEntityModel(playerPed)

	for _, attackType in ipairs(Config.AttackTypes) do
		for _, model in ipairs(attackType.models) do
			if playerModel == model then
				return attackType
			end
		end
	end
end

function ApplyAttackToTarget(attacker, target, attackType)
	if attackType.force > 0 then
		SetPedToRagdoll(target, 1000, 1000, 0, 0, 0, 0)
		SetEntityVelocity(target, GetEntityForwardVector(attacker) * attackType.force)
	end

	if attackType.damage > 0 then
		ApplyDamageToPed(target, attackType.damage, 1, -1, 0)
	end
end

function GetPlayerServerIdFromPed(ped)
	GetPlayers()
	for _, player in pairs(playerx) do
		if player.ped == ped then
			return player.serverId
		end
	end
end

function ToggleCrouch()
	local playerPed = PlayerPedId()

	SetPedCrouchMovement(playerPed, not GetPedCrouchMovement(playerPed), true)
end
function Attack()
	local playerPed = PlayerPedId()

	if IsPedDeadOrDying(playerPed) or IsPedRagdoll(playerPed) then
		return
	end

	local attackType = GetAttackType(playerPed)

	if attackType then
		local target = GetClosestPed(playerPed, attackType.radius)

		if target then
			IsAttacking = true

			MakeEntityFaceEntity(playerPed, target)

			PlayAnimation(attackType.animation)

			ApplyAttackToTarget(playerPed, target, attackType)

			if IsPedAPlayer(target) then
				TriggerServerEvent("fixanimals:attack", GetPlayerServerIdFromPed(target), -1)
			elseif NetworkGetEntityIsNetworked(target) and not NetworkHasControlOfEntity(target) then
				TriggerServerEvent("fixanimals:attack", -1, PedToNet(target))
			else
				ApplyAttackToTarget(playerPed, target, attackType)
			end

			SetTimeout(Config.AttackCooldown, function()
				IsAttacking = false
			end)
		end
	end
end
function MakeEntityFaceEntity(entity1, entity2)
	local p1 = GetEntityCoords(entity1)
	local p2 = GetEntityCoords(entity2)

	local dx = p2.x - p1.x
	local dy = p2.y - p1.y

	local heading = GetHeadingFromVector_2d(dx, dy)

	SetEntityHeading(entity1, heading)
end

function GetClosestPed(playerPed, radius)
	local playerCoords = GetEntityCoords(playerPed)

	local itemset = CreateItemset(true)
	local size = Citizen.InvokeNative(0x59B57C4B06531E1E, playerCoords, radius, itemset, 1, Citizen.ResultAsInteger())

	local closestPed
	local minDist = radius

	if size > 0 then
		for i = 0, size - 1 do
			local ped = GetIndexedItemInItemset(i, itemset)

			if playerPed ~= ped and IsValidTarget(ped) then
				local pedCoords = GetEntityCoords(ped)
				local distance = #(playerCoords - pedCoords)

				if distance < minDist then
					closestPed = ped
					minDist = distance
				end
			end
		end
	end

	if IsItemsetValid(itemset) then
		DestroyItemset(itemset)
	end

	return closestPed
end
function IsPvpEnabled()
	return GetRelationshipBetweenGroups(`PLAYER`, `PLAYER`) == 5
end

function IsValidTarget(ped)
	return not IsPedDeadOrDying(ped) and not (IsPedAPlayer(ped) and not IsPvpEnabled())
end


function PerformRequest(hash)
    RequestModel(hash, 0)
    local bacon = 1
    while not Citizen.InvokeNative(0x1283B8B89DD5D1B6, hash) do
        Citizen.InvokeNative(0xFA28FE3A6246FC30, hash, 0)
        bacon = bacon + 1
        Citizen.Wait(0)
        if bacon >= 100 then break end
    end
end

local IsAnimal = false
local IsAttacking = false

function SetControlContext(pad, context)
	Citizen.InvokeNative(0x2804658EB7D8A50B, pad, context)
end

CreateThread(function()
	local lastPed = 0
	while true do
		local ped = PlayerPedId()

		if ped ~= lastPed then
			if IsPedHuman(ped) then
				SetControlContext(2, 0)
				IsAnimal = false
			else
				SetPedConfigFlag(ped, 43, true)
				IsAnimal = true
			end

			lastPed = ped
		end
		Wait(1000)
	end
end)

local cooldown = false 

Citizen.CreateThread(function() 
	while true do 
		Citizen.Wait(10)
		if cooldown then
			Wait(Config.AttackCooldown)
			cooldown = false
		end
	end
end)


CreateThread(function()
	while true do
		if IsAnimal then
			-- Change control context
			SetControlContext(2, `OnMount`)

			-- Disable first person mode as an animal since the camera is glitchy and may cause crashes
			DisableFirstPersonCamThisFrame()

			-- Allow animals that can't normally attack to attack
			if not IsAttacking and IsControlJustPressed(0, `INPUT_ATTACK`) and not cooldown then
				cooldown = true
				Attack()
			end

			-- Toggle crouched movement
			if IsControlJustPressed(0, `INPUT_HORSE_MELEE`) then
				ToggleCrouch()
			end
		end

		Wait(10)
	end
end)
function SetMonModel(name)
	local model = GetHashKey(name)
	local player = PlayerId()
	
	if not IsModelValid(model) then return end
	PerformRequest(model)
	
	if HasModelLoaded(model) then
		Citizen.InvokeNative(0xED40380076A31506, player, model, false)
		Citizen.InvokeNative(0x283978A15512B2FE, PlayerPedId(), true)
		SetModelAsNoLongerNeeded(model)
	end
end

function NoClip()
	local ped = PlayerPedId()
	if not noclip then
		noclip = true
		SetEntityVisible(ped, false)
		SetPlayerInvincible(ped, true)
		FreezeEntityPosition(ped, true)
		TriggerServerEvent("Log", systemlogs, "No Clip", GetPlayerName(PlayerId()).." turned No Clip on.", 65535)
	else
		noclip = false
		SetEntityVisible(ped, true)
		SetPlayerInvincible(ped, false)
		FreezeEntityPosition(ped, false)
		TriggerServerEvent("Log", systemlogs, "No Clip", GetPlayerName(PlayerId()).." turned No Clip off.", 65535)
	end
end

Citizen.CreateThread(function()
	LoadSettings()
	while true do
		Citizen.Wait(0)
		if noclip then
			-- Disable all controls except a few while in noclip mode
			DisableAllControlActions(0)
			EnableControlAction(0, 0x4A903C11) -- FrontendPauseAlternate
			EnableControlAction(0, 0x9720fcee) -- MpTextChatAll
			EnableControlAction(0, 0xA987235F) -- LookLr
			EnableControlAction(0, 0xD2047988) -- LookUd
			EnableControlAction(0, 0x3D99EEC6) -- HorseGunLr
			EnableControlAction(0, 0xBFF476F9) -- HorseGunUd
			EnableControlAction(0, 0xCF8A4ECA) -- RevealHud
			EnableControlAction(0, 0x4AF4D473) -- Del

			DisableFirstPersonCamThisFrame()

			-- Get the entity we want to control in noclip mode
			local entity = GetNoClipTarget()

			FreezeEntityPosition(entity, true)

			-- Get the position and heading of the entity
			local x, y, z = table.unpack(GetEntityCoords(entity))
			local h = TranslateHeading(entity, GetEntityHeading(entity))

			-- Cap the speed between MinSpeed and MaxSpeed
			if Speed > Config.MaxSpeed then
				SetSpeed(Config.MaxSpeed)
			end
			if Speed < Config.MinSpeed then
				SetSpeed(Config.MinSpeed)
			end

			-- Print the current noclip speed on screen
			DrawText(string.format('NoClip Speed: %.1f', Speed), 0.5, 0.90, true)

			-- Change noclip control mode
			if CheckControls(IsDisabledControlJustPressed, 0, Config.ToggleModeControl) then
				ToggleRelativeMode()
			end

			-- Increase/decrease speed
			if CheckControls(IsDisabledControlPressed, 0, Config.IncreaseSpeedControl) then
				SetSpeed(Speed + Config.SpeedIncrement)
			end
			if CheckControls(IsDisabledControlPressed, 0, Config.DecreaseSpeedControl) then
				SetSpeed(Speed - Config.SpeedIncrement)
			end

			-- Move up/down
			if CheckControls(IsDisabledControlPressed, 0, Config.UpControl) then
				z = z + Speed
			end
			if CheckControls(IsDisabledControlPressed, 0, Config.DownControl) then
				z = z - Speed
			end

			if RelativeMode then
				-- Print the coordinates, heading and controls on screen
				DrawText(string.format('Coordinates:\nX: %.2f\nY: %.2f\nZ: %.2f\nHeading: %.0f', x, y, z, h), 0.01, 0.3, false)

				if FollowCam then
					DrawText('W/S - Move, Spacebar/Shift - Up/Down, Page Up/Page Down/Mouse Wheel - Change speed, Q - Absolute mode, H - Disable Follow Cam', 0.5, 0.95, true)
				else
					DrawText('W/S - Move, A/D - Rotate, Spacebar/Shift - Up/Down, Page Up/Page Down - Change speed, Q - Absolute mode, H - Enable Follow Cam', 0.5, 0.95, true)
				end

				-- Calculate the change in x and y based on the speed and heading.
				local r = -h * math.pi / 180
				local dx = Speed * math.sin(r)
				local dy = Speed * math.cos(r)

				-- Move forward/backward
				if CheckControls(IsDisabledControlPressed, 0, Config.ForwardControl) then
					x = x + dx
					y = y + dy
				end
				if CheckControls(IsDisabledControlPressed, 0, Config.BackwardControl) then
					x = x - dx
					y = y - dy
				end

				if CheckControls(IsDisabledControlJustPressed, 0, Config.FollowCamControl) then
					ToggleFollowCam()
				end

				-- Rotate heading
				if FollowCam then
					local rot = GetGameplayCamRot(2)
					h = rot.z
				else
					if IsDisabledControlPressed(0, Config.LeftControl) then
						h = h + 1
					end
					if IsDisabledControlPressed(0, Config.RightControl) then
						h = h - 1
					end
				end
			else
				-- Print the coordinates and controls on screen
				DrawText(string.format('Coordinates:\nX: %.2f\nY: %.2f\nZ: %.2f', x, y, z), 0.01, 0.3, false)
				DrawText('W/A/S/D - Move, Spacebar/Shift - Up/Down, Page Up/Page Down - Change speed, Q - Relative mode', 0.5, 0.95, true)

				h = 0.0

				-- Move North
				if CheckControls(IsDisabledControlPressed, 0, Config.ForwardControl) then
					y = y + Speed
				end

				-- Move South
				if CheckControls(IsDisabledControlPressed, 0, Config.BackwardControl) then
					y = y - Speed
				end

				-- Move East
				if CheckControls(IsDisabledControlPressed, 0, Config.LeftControl) then
					x = x - Speed
				end

				-- Move West
				if CheckControls(IsDisabledControlPressed, 0, Config.RightControl) then
					x = x + Speed
				end
			end

			SetEntityCoordsNoOffset(entity, x, y, z)
			SetEntityHeading(entity, TranslateHeading(entity, h))
		end
	end
end)
function giveweps(x)
	local ped = PlayerPedId()
	local hash = GetHashKey(x)
	GiveWeaponToPed(ped,hash,1,true,0,13,0,1,1,0x7B9BDCE7,1,1,1)
	SetCurrentPedWeapon(ped,hash,true,13,1,1)
	print(GetCurrentPedWeapon(ped,1,13,1))
end

function GetNoClipTarget()
	local ped = PlayerPedId()
	local veh = GetVehiclePedIsIn(ped, false)
	local mnt = GetMount(ped)
	return (veh == 0 and (mnt == 0 and ped or mnt) or veh)
end

function TranslateHeading(entity, h)
	if GetEntityType(entity) == 1 then
		return (h + 180) % 360
	else
		return h
	end
end

function ToggleRelativeMode()
	RelativeMode = not RelativeMode
	SetResourceKvp('relativeMode', tostring(RelativeMode))
end

function ToggleFollowCam()
	FollowCam = not FollowCam
	SetResourceKvp('followCam', tostring(FollowCam))
end

function SetSpeed(value)
	Speed = value
	SetResourceKvp('speed', tostring(Speed))
end

function CheckControls(func, pad, controls)
	if type(controls) == 'number' then
		return func(pad, controls)
	end

	for _, control in ipairs(controls) do
		if func(pad, control) then
			return true
		end
	end

	return false
end

function CheckControls(func, pad, controls)
	if type(controls) == 'number' then
		return func(pad, controls)
	end

	for _, control in ipairs(controls) do
		if func(pad, control) then
			return true
		end
	end

	return false
end

function LoadSettings()
	local relativeMode = GetResourceKvpString('relativeMode')
	if relativeMode ~= nil then
		RelativeMode = relativeMode == 'true'
	end

	local followCam = GetResourceKvpString('followCam')
	if followCam ~= nil then
		FollowCam = followCam == 'true'
	end

	local speed = GetResourceKvpString('speed')
	if speed ~= nil then
		Speed = tonumber(speed)
	end
end

function TeleToWaypoint()
	local ply = PlayerPedId()
	local pCoords = GetEntityCoords(ply)
	lastlocation = pCoords
	local WP = GetWaypointCoords()
	if (WP.x == 0 and WP.y == 0) then
			TriggerEvent("vorp:TipRight", "You didn't set a waypoint", 3000)
	else
		local height = 1
		for height = 1, 1000 do
			SetEntityCoords(ply, WP.x, WP.y, height + 0.0)
			local foundground, groundZ, normal = GetGroundZAndNormalFor_3dCoord(WP.x, WP.y, height + 0.0)
			if foundground then
				SetEntityCoords(ply, WP.x, WP.y, height + 0.0)
				TriggerServerEvent("Log", systemlogs, "TP To Waypoint", GetPlayerName(PlayerId()).." teleported to " ..WP, 65535)
				break
			end
			Wait(25)
		end
	end
end

function getplayersxyz()
    local playersxy = GetActivePlayers()
    local playerPed, playerId = PlayerPedId(), PlayerId()
    for i=1, #playersxy, 1 do
        local server = GetPlayerServerId(playersxy[i])
		if tonumber(server) == tonumber(player.serverId) then 
			print(server)
			local tgt = 0
			while tgt == 0 do 
				tgt = GetPlayerPed(playersxy[i])
				Wait(10)
			end
			return tgt
		end
    end
end
function Spectate()
	if not spectating then 
		lastcoords =  GetEntityCoords(PlayerPedId())
		SetEntityVisible(PlayerPedId(), false)
		SetEntityCanBeDamaged(PlayerPedId(), false)
		SetEntityInvincible(PlayerPedId(), true)
		SetEntityCoords(PlayerPedId(), player.x+10,player.y+10,player.z)
		Wait(500)
		local tgt1 = getplayersxyz()
		camera = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
		AttachCamToEntity(camera, tgt1, 0.0, -3.0, 1.0, false)
    	SetCamActive(camera, true)
    	RenderScriptCams(true, true, 1, true, true)
		spectating = true
		if GetPlayerName(PlayerId()) ~= player.name then 
			TriggerServerEvent("Log", systemlogs, "Spectate", GetPlayerName(PlayerId()).." is spectating "..player.name, 65535)
		end
	end
end

function CancelCamera()
	if spectating then 
		if GetPlayerName(PlayerId()) ~= player.name then 
			TriggerServerEvent("Log", systemlogs, "Spectate", GetPlayerName(PlayerId()).." is no longer spectating "..player.name, 65535)
		end
    	RenderScriptCams(true, false, 1, true, true)
    	DestroyCam(camera, true)
    	DestroyAllCams()
		SetEntityCoords(PlayerPedId(), lastcoords.x,lastcoords.y,lastcoords.z-1)
		SetEntityVisible(PlayerPedId(), true)
		SetEntityCanBeDamaged(PlayerPedId(), false)
		SetEntityInvincible(PlayerPedId(), true)
		spectating = false
	end
end

function Teleport()
	TriggerServerEvent("Log", systemlogs, "Teleport", GetPlayerName(PlayerId()).." teleported to " ..player.name, 65535)
	local ped = player.ped
	--local coords = GetEntityCoords(player)
	lastlocation = GetEntityCoords(PlayerPedId())
	SetEntityCoords(PlayerPedId(), player.x,player.y,player.z)

end

function Message()
	AddTextEntry("message", "Message:")
	DisplayOnscreenKeyboard(0, "message", "", "", "", "", "", 175)

    while (UpdateOnscreenKeyboard() == 0) do
        Wait(0);
    end
	
    while (UpdateOnscreenKeyboard() == 2) do
        Wait(0);
        break
    end
	
    if (GetOnscreenKeyboardResult()) then
		TriggerServerEvent("Message", player.serverId, GetOnscreenKeyboardResult())
		TriggerServerEvent("Log", systemlogs, "Message", GetPlayerName(PlayerId()).." Sent message: " .. GetOnscreenKeyboardResult() .. ". Recipient: " .. player.name, 65535) -- Log example
		TriggerEvent("vorp:TipRight", "Success", "Message sent.", "menu_textures", "menu_icon_tick", 8000)
    end
end

function Announce()
	TriggerEvent("vorpinputs:getInput", "Announcement", "Announcement Message", function(input)
		local message = tostring(input)
		if message == nil then
			TriggerEvent("vorp:TipRight", "Canceled", 2000)
		else
			TriggerServerEvent("Announce", message)
			TriggerServerEvent("Log", systemlogs, "Announcement", GetPlayerName(PlayerId()).." Sent global announcement: " ..message, 65535)
		end
	end)
end

function Bring()
	local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
	TriggerServerEvent("Bring", player.serverId, x, y, z)
	TriggerServerEvent("Log", systemlogs, "Teleport", GetPlayerName(PlayerId()).." brought player " ..player.name, 65535)
end

RegisterNetEvent("Bring")
AddEventHandler("Bring", function(x, y, z)
	SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
end)
RegisterNetEvent("syn:noclip")
AddEventHandler("syn:noclip", function(x, y, z)
	NoClip()
end)
function Return()
	TriggerServerEvent("Log", systemlogs, "Return", GetPlayerName(PlayerId()).." returned to " ..lastlocation, 65535)
	SetEntityCoords(PlayerPedId(), lastlocation)
end


function GetPlayers()
	TriggerServerEvent("syn_commands:getplayers")
	local stuff = {}
	RegisterNetEvent("getplayers", function (data)
		stuff = data
	end)
	while next(stuff) == nil do
		Wait(10)
	end
	return stuff
end

function GetPlayersxx()
	local players = {}
	
		for i = 0, 256 do
			if NetworkIsPlayerActive(i) then
				table.insert(players, i)
			end
		end
	
		return players
	end

function DrawText(text, x, y, centred)
	SetTextScale(0.35, 0.35)
	SetTextColor(255, 255, 255, 255)
	SetTextCentre(centred)
	SetTextDropshadow(1, 0, 0, 0, 200)
	SetTextFontForCurrentCommand(0)
	DisplayText(CreateVarString(10, "LITERAL_STRING", text), x, y)
end

--[[ RegisterCommand("list", function()
	local players = GetPlayers()
	for k, v in pairs(players) do
		print(v.serverId)
		print(v.name)
	end
end) ]]

local WeaponNames = {
	[tostring(GetHashKey('weapon_melee_knife_trader'))] = "with a Trader Knife",
	[tostring(GetHashKey('weapon_melee_knife'))] = "with a Knife",
	[tostring(GetHashKey('weapon_melee_knife_jawbone'))] = "with a Jawbone Knife",
	[tostring(GetHashKey('weapon_melee_cleaver'))] = "with a Cleaver",
	[tostring(GetHashKey('weapon_melee_hatchet_hunter'))] = "with a Hunter Hatchet",
	[tostring(GetHashKey('weapon_melee_machete'))] = "with a Machete",
	[tostring(GetHashKey('weapon_melee_machete_collector'))] = "with a Collector Machete",
	[tostring(GetHashKey('weapon_bow'))] = "with a Bow",
	[tostring(GetHashKey('weapon_bow_improved'))] = "with an Improved bow",
	[tostring(GetHashKey('weapon_rifle_elephant'))] = "with an Elephant Rifle",
	[tostring(GetHashKey('WEAPON_RIFLE_VARMINT'))] = "with a Varmint Rifle",
	[tostring(GetHashKey('WEAPON_SNIPERRIFLE_ROLLINGBLOCK'))] = "with a Rollingblock",
	[tostring(GetHashKey('WEAPON_SNIPERRIFLE_CARCANO'))] = "with a Carcano",
	[tostring(GetHashKey('WEAPON_RIFLE_SPRINGFIELD'))] = "with a Springfield",
	[tostring(GetHashKey('WEAPON_RIFLE_BOLTACTION'))] = "with a Boltaction",
	[tostring(GetHashKey('WEAPON_REPEATER_WINCHESTER'))] = "with a Winchester",
	[tostring(GetHashKey('WEAPON_REPEATER_HENRY'))] = "with a Henry Repeater",
	[tostring(GetHashKey('WEAPON_REPEATER_EVANS'))] = "with an Evans Repeater",
	[tostring(GetHashKey('WEAPON_REPEATER_CARBINE'))] = "with a Carbine Repeater",
	[tostring(GetHashKey('WEAPON_REPEATER_LANCASTER'))] = "with a Lancaster Repeater",
	[tostring(GetHashKey('WEAPON_PISTOL_SEMIAUTO'))] = "with a Semiauto Pistol",
	[tostring(GetHashKey('WEAPON_PISTOL_MAUSER'))] = "with a Mauser Pistol",
	[tostring(GetHashKey('WEAPON_PISTOL_VOLCANIC'))] = "with a Volcanic Pistol",
	[tostring(GetHashKey('WEAPON_PISTOL_M1899'))] = "with a M1899 Pistol",
	[tostring(GetHashKey('WEAPON_REVOLVER_SCHOFIELD'))] = "with a Schofield Revolver",
	[tostring(GetHashKey('WEAPON_REVOLVER_LEMAT'))] = "with a LeMat Revolver",
	[tostring(GetHashKey('WEAPON_REVOLVER_DOUBLEACTION'))] = "with a Double-Action Revolver",
	[tostring(GetHashKey('WEAPON_REVOLVER_CATTLEMAN'))] = "with a Cattleman Revolver",
	[tostring(GetHashKey('weapon_revolver_navy_crossover'))] = "with a Navy Revolver (Crossover)",
	[tostring(GetHashKey('weapon_revolver_doubleaction_gambler'))] = "with a Double-Action Revolver (Gambler)",
	[tostring(GetHashKey('weapon_revolver_cattleman_mexican'))] = "with a Cattleman (Mexican)",
	[tostring(GetHashKey('weapon_revolver_navy'))] = "with a Navy Revolver",
	[tostring(GetHashKey('WEAPON_THROWN_TOMAHAWK'))] = "with a Tomahawk",
	[tostring(GetHashKey('WEAPON_THROWN_THROWING_KNIVES'))] = "with Throwing Knives",
	[tostring(GetHashKey('weapon_thrown_poisonbottle'))] = "with a Poison Bottle",
	[tostring(GetHashKey('weapon_thrown_dynamite'))] = "with some Dynamite",
	[tostring(GetHashKey('weapon_thrown_molotov'))] = "with a Molotov",
	[tostring(GetHashKey('WEAPON_SHOTGUN_SEMIAUTO'))] = "with a Semiauto Shotgun",
	[tostring(GetHashKey('WEAPON_SHOTGUN_SAWEDOFF'))] = "with a Sawedoff Shotgun",
	[tostring(GetHashKey('WEAPON_SHOTGUN_REPEATING'))] = "with a Repeating Shotgun",
	[tostring(GetHashKey('WEAPON_SHOTGUN_PUMP'))] = "with a Pump Shotgun",
	[tostring(GetHashKey('WEAPON_SHOTGUN_DOUBLEBARREL'))] = "with a Doublebarrel Shotgun",
	[tostring(GetHashKey('weapon_wolf'))] = " by a Wolf",
	[tostring(GetHashKey('weapon_wolf_medium'))] = " by a Wolf",
	[tostring(GetHashKey('weapon_wolf_small'))] = " by a Wolf",
	[tostring(GetHashKey('weapon_alligator'))] = " by an Alligator",
	[tostring(GetHashKey('weapon_animal'))] = " by an Animal",
	[tostring(GetHashKey('weapon_badger'))] = " by a Badger",
	[tostring(GetHashKey('weapon_bear'))] = " by a Bear",
	[tostring(GetHashKey('weapon_beaver'))] = " by a Beaver",
	[tostring(GetHashKey('weapon_cougar'))] = " by a Cougar",
	[tostring(GetHashKey('weapon_coyote'))] = " by a Coyote",
	[tostring(GetHashKey('weapon_deer'))] = " by a Deer",
	[tostring(GetHashKey('weapon_fox'))] = " by a Fox",
	[tostring(GetHashKey('weapon_horse'))] = " by a Horse",
	[tostring(GetHashKey('weapon_muskrat'))] = " by a Muskrat",
	[tostring(GetHashKey('weapon_raccoon'))] = " by a Raccoon",
	[tostring(GetHashKey('weapon_snake'))] = " by a Snake",
	[tostring(GetHashKey('weapon_fall'))] = " from Falling",
	[tostring(GetHashKey('weapon_fire'))] = "by Fire",
	[tostring(GetHashKey('weapon_bleeding'))] = "by Bleeding",
	[tostring(GetHashKey('weapon_drowning'))] = "by Drowning",
	[tostring(GetHashKey('weapon_drowning_in_vehicle'))] = "by Drowning",
	[tostring(GetHashKey('weapon_explosion'))] = "in an Explosion",
	[tostring(GetHashKey('weapon_rammed_by_car'))] = " by a Cart",
	[tostring(GetHashKey('weapon_run_over_by_car'))] = " by a Cart"
}

Citizen.CreateThread(function()
	local DeathReason, Killer, DeathCauseHash, Weapon

	while true do
		Citizen.Wait(0)
		if IsEntityDead(GetPlayerPed(PlayerId())) then
			Citizen.Wait(0)
			local PedKiller = GetPedSourceOfDeath(GetPlayerPed(PlayerId()))
			local killername = GetPlayerName(PedKiller)
			DeathCauseHash = GetPedCauseOfDeath(GetPlayerPed(PlayerId()))
			Weapon = WeaponNames[tostring(DeathCauseHash)]

			if IsEntityAPed(PedKiller) and IsPedAPlayer(PedKiller) then
				Killer = NetworkGetPlayerIndexFromPed(PedKiller)
			elseif IsEntityAVehicle(PedKiller) and IsEntityAPed(GetPedInVehicleSeat(PedKiller, -1)) and IsPedAPlayer(GetPedInVehicleSeat(PedKiller, -1)) then
				Killer = NetworkGetPlayerIndexFromPed(GetPedInVehicleSeat(PedKiller, -1))
			end

			if (Killer == PlayerId()) then
				DeathReason = 'committed suicide'
			elseif (Killer == nil) then
				DeathReason = 'died'
			else
				if IsMelee(DeathCauseHash) then
					DeathReason = 'murdered'
				elseif IsRangedWeapon(DeathCauseHash) then
					DeathReason = 'shot'
				else
					DeathReason = 'killed'
				end
			end

			if DeathReason == 'committed suicide' or DeathReason == 'died' then
				TriggerServerEvent('playerDied',1,GetPlayerServerId(PlayerId()),0,DeathReason,Weapon)
			else
				TriggerServerEvent('playerDied',2,GetPlayerServerId(PlayerId()),GetPlayerServerId(Killer),DeathReason,Weapon)
			end
			Killer = nil
			DeathReason = nil
			DeathCauseHash = nil
			Weapon = nil
		end
		while IsEntityDead(PlayerPedId()) do
			Citizen.Wait(0)
		end
	end
end)

function IsMelee(Weapon)
	local Weapons = {'weapon_melee_knife_trader', 'weapon_melee_knife', 'weapon_melee_knife_jawbone', 'weapon_melee_cleaver', 'weapon_melee_hatchet_hunter', 'weapon_melee_machete', 'weapon_melee_machete_collector'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsRangedWeapon(Weapon)
	local Weapons = {'weapon_bow', 'weapon_bow_improved', 'weapon_rifle_elephant', 'WEAPON_RIFLE_VARMINT', 'WEAPON_RIFLE_SPRINGFIELD', 'WEAPON_RIFLE_BOLTACTION', 'WEAPON_REPEATER_WINCHESTER', 'WEAPON_REPEATER_HENRY', 'WEAPON_REPEATER_EVANS', 'WEAPON_REPEATER_CARBINE', 'WEAPON_SNIPERRIFLE_ROLLINGBLOCK', 'WEAPON_SNIPERRIFLE_CARCANO', 'WEAPON_REPEATER_LANCASTER', 'WEAPON_PISTOL_SEMIAUTO', 'WEAPON_PISTOL_MAUSER', 'WEAPON_PISTOL_VOLCANIC', 'WEAPON_PISTOL_M1899', 'WEAPON_REVOLVER_SCHOFIELD', 'WEAPON_REVOLVER_LEMAT', 'WEAPON_REVOLVER_DOUBLEACTION', 'WEAPON_REVOLVER_CATTLEMAN', 'weapon_revolver_navy_crossover', 'weapon_revolver_doubleaction_gambler', 'weapon_revolver_cattleman_mexican', 'weapon_revolver_navy', 'WEAPON_SHOTGUN_SEMIAUTO', 'WEAPON_SHOTGUN_SAWEDOFF', 'WEAPON_SHOTGUN_REPEATING', 'WEAPON_SHOTGUN_PUMP', 'WEAPON_SHOTGUN_DOUBLEBARREL'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsAnimal(Weapon)
	local Weapons = {'weapon_wolf', 'weapon_wolf_medium', 'weapon_wolf_small', 'weapon_alligator', 'weapon_animal', 'weapon_badger', 'weapon_bear', 'weapon_beaver', 'weapon_cougar', 'weapon_coyote', 'weapon_deer', 'weapon_fox', 'weapon_horse', 'weapon_muskrat', 'weapon_raccoon', 'weapon_snake'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

-- TriggerEvent("chat:addSuggestion", "/giveweapon", "Example: /giveweapon [id] [weapon]")
-- RegisterCommand("giveweapon", function(source, args, rawCommand)
-- 	local player = args[1]
-- 	local weapon = args[2]
-- 	local ammo = {["nothing"] = 0}
-- 	local components = {["nothing"] = 0}

-- 	TriggerServerEvent("GiveWeapon", player, weapon, ammo, components)
-- end)

--[[ TriggerEvent("chat:addSuggestion", "/giveitem", "Example: /giveitem [id] [item] [qty]")
RegisterCommand("giveitem", function(source, args, rawCommand)
	local player = args[1]
	local item = args[2]
	local qty = args[3]
	
	if qty == "" or qty == nil then
		TriggerEvent("vorp:TipRight", "You must enter a quantity", 2000)
	else
		TriggerServerEvent("GiveItem", player, item, qty)
	end
end) ]]

local showids = false

function GetDistanceFromPlayer(p)
	local ped = GetPlayerPed(p)
	local pCoords = GetEntityCoords(ped)
	local myCoords = GetEntityCoords(PlayerPedId())
	return GetDistanceBetweenCoords(myCoords.x, myCoords.y, myCoords.z, pCoords.x, pCoords.y, pCoords.z, true)
end

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
	Citizen.InvokeNative(0xADA9255D, 1);
    DisplayText(str, x, y)
end

function getEntity(player)
	local result, entity = GetEntityPlayerIsFreeAimingAt(player)
	return entity
end

local hud = true

RegisterCommand("hud", function(source, args, rawCommand)
    if hud then
		ExecuteCommand("togglechat")
        DisplayRadar(false)
        TriggerEvent("syn_displayrange2", true)
        TriggerEvent("vorp:showUi", false)
        hud = false
    else
		ExecuteCommand("togglechat")
        DisplayRadar(true)
		TriggerEvent("syn_displayrange2", false)
        TriggerEvent("vorp:showUi", true)
        hud = true
    end
end)
Citizen.CreateThread(function() -- disable auto-aim
    while true do
        Citizen.Wait(10)
        Citizen.InvokeNative(0xD66A941F401E7302, 3)
    end
end)
RegisterCommand("zone",function()
    local ped_coords = GetEntityCoords(PlayerPedId())
    local x,y,z =  table.unpack(ped_coords + vector3(0.0,0.0,0.0))
    zone = Citizen.InvokeNative(0x43AD8FC02B429D33,x,y,z,-1) --GetMapZoneAtCoords()
    print(zone)
end)

RegisterCommand("Stinky",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -166523388 , 1, 1, 0, 0)
end)

RegisterCommand("tip",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -1457020913 , 1, 1, 0, 0)
end)--TipHat

RegisterCommand("Slit",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 1256841324 , 1, 1, 0, 0)
end)--Slit Throut

RegisterCommand("SlwClp",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 1023735814 , 1, 1, 0, 0)
end)--Slow Clap

RegisterCommand("Smh",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -653113914 , 1, 1, 0, 0)
end)--smh

RegisterCommand("Spit",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -2106738342, 1, 1, 0, 0)
end)--Spit

RegisterCommand("No",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 1509171361, 1, 1, 0, 0)
end)--Thumbs Down

RegisterCommand("Yes",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 425751659, 1, 1, 0, 0)
end)--Thumbs Up

RegisterCommand("Wave",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -339257980, 1, 1, 0, 0)
end)--wave

RegisterCommand("Bird",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 969312568 , 1, 1, 0, 0)
end)--smh

RegisterCommand("dv", function()--Delete Vehicle
    local playerPed = PlayerPedId()
    local vehicle   = GetVehiclePedIsIn(playerPed, true)
    if IsPedInAnyVehicle(playerPed, true) then
        vehicle = GetVehiclePedIsIn(playerPed, true)
    end
    if DoesEntityExist(vehicle) then
        DeleteVehicle(vehicle)
		DeleteEntity(vehicle)
    end
end)

RegisterCommand("dh", function()--Delete Vehicle
    local playerPed = PlayerPedId()
    local mount   = GetMount(PlayerPedId())
	TriggerEvent("syn_stable:deletehorse")
    if IsPedOnMount(playerPed) then
        DeleteEntity(mount)
    end
end)

RegisterNetEvent('syn:heal')
AddEventHandler('syn:heal', function(id)
    local closestPlayerPed = GetPlayerPed(id)
    print(closestPlayerPed)
    local health = GetAttributeCoreValue(closestPlayerPed, 0)
    local newHealth = health + 100
    local stamina = GetAttributeCoreValue(closestPlayerPed, 1)
    local newStamina = stamina + 100
    local health2 = GetEntityHealth(closestPlayerPed)
    local newHealth2 = health2 + 100
    Citizen.InvokeNative(0xC6258F41D86676E0, closestPlayerPed, 0, newHealth) --core
    Citizen.InvokeNative(0xC6258F41D86676E0, closestPlayerPed, 1, newStamina) --core
    SetEntityHealth(closestPlayerPed, newHealth2)
end)

local god = false 
RegisterNetEvent('syn:godmodexrt')
AddEventHandler('syn:godmodexrt', function()
	if not god then 
		god = true 
		print("god mode on")
		SetEntityCanBeDamaged(PlayerPedId(), false)
		SetEntityInvincible(PlayerPedId(), true)
	else
		god = false
		print("god mode off")
		SetEntityCanBeDamaged(PlayerPedId(), true)
		SetEntityInvincible(PlayerPedId(), false)
	end
end)

RegisterNetEvent('syn:tpm2')
AddEventHandler('syn:tpm2', function(x)
	TeleToWaypoint()
end)

RegisterNetEvent('syn:tp')
AddEventHandler('syn:tp', function(x,y,z)
	local ply = PlayerPedId()
	--SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
	SetEntityCoords(ply, x, y, z)

end)


