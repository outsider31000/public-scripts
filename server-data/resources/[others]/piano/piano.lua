local play = false
local duration = 0   -- in miliseconds 0 means play forever
local time_between_tip = 30000  -- this is the number of miliseconds between tips and xp default is 30 seconds


function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    SetTextFontForCurrentCommand(15) 
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
    DisplayText(str, x, y)
end

---------------------------------------DO NOT EDIT BEYOND THIS POINT
-- Check Gender -- 
local ismale = IsPedMale( PlayerPedId() )
local rnd = 1

Citizen.CreateThread(function()
    local _source = source
 


	while true do 
        	Citizen.Wait(1)
        

---------------------------Valentine ----------------------------------------
        if IsPlayerNearCoords(-312.3, 799.01, 118.46) then
            if not play then 
            DrawTxt("[~e~SPACEBAR~q~] to play piano for tips, [~e~]~q~] to stop", 0.50, 0.95, 0.7, 0.5, true, 223, 44, 53, 255, true)
            end

            if IsControlJustPressed(0, 0xD9D0E1C0) then
                play = true 
                 if ismale == false then
		       
		        TaskStartScenarioAtPosition(PlayerPedId(), GetHashKey('PROP_HUMAN_ABIGAIL_PIANO'), -312.22 - 0.08, 799.01, 118.43 + 0.03, 102.37, duration, true, true, 0, true)

		else
			rnd = math.random(1,100)
			if rnd <= 25 then
				TaskStartScenarioAtPosition(PlayerPedId(), GetHashKey('PROP_HUMAN_PIANO'), -312.22 - 0.08, 799.01, 118.43 + 0.03, 102.37, duration, true, true, 0, true)
			elseif rnd <=50 then
                        	TaskStartScenarioAtPosition(PlayerPedId(), GetHashKey('PROP_HUMAN_PIANO_UPPERCLASS'), -312.22 - 0.08, 799.01, 118.43 + 0.03, 102.37, duration, true, true, 0, true)
			elseif rnd <=75 then
                        	TaskStartScenarioAtPosition(PlayerPedId(), GetHashKey('PROP_HUMAN_PIANO_RIVERBOAT'), -312.22 - 0.08, 799.01, 118.43 + 0.03, 102.37, duration, true, true, 0, true)
			else
				TaskStartScenarioAtPosition(PlayerPedId(), GetHashKey('PROP_HUMAN_PIANO_SKETCHY'), -312.22 - 0.08, 799.01, 118.43 + 0.03, 102.37, duration, true, true, 0, true)         
			end
                	
		
                end		
while play == true do
			Citizen.Wait( time_between_tip )      
			TriggerServerEvent('piano:AddSomeMoney')
		end
            end
        end
        
--------------------------- ST Denis  ----------------------------------------        
        if IsPlayerNearCoords(2632.282, -1232.0, 54.19) then
            if not play then 

            end
            if IsControlJustPressed(0, 0x760A9C6F) then
                play = true 
                if ismale == false then
		        TaskStartScenarioAtPosition(PlayerPedId(), GetHashKey('PROP_HUMAN_ABIGAIL_PIANO'), 2631.946 - 0.22, -1232.617 + 0.3, 54.19 - 0.46, 67.788, duration, true, true, 0, true)
		else
                	TaskStartScenarioAtPosition(PlayerPedId(), GetHashKey('PROP_HUMAN_PIANO'), 2631.946 - 0.22, -1232.617 + 0.3, 54.19 - 0.46, 67.788, duration, true, true, 0, true)
		end
		while play == true do
			Citizen.Wait( time_between_tip )      
			TriggerServerEvent('piano:AddSomeMoney')
		end
            end
        end

--------------------------- ST Denis  doyels ----------------------------------------            
        if IsPlayerNearCoords(2799.582, -1163.929, 47.92) then
            if not play then 
            end
            if IsControlJustPressed(0, 0x760A9C6F) then
                play = true
		if ismale == false then
		        TaskStartScenarioAtPosition(PlayerPedId(), GetHashKey('PROP_HUMAN_ABIGAIL_PIANO'), 2799.582 + 1.0, -1163.929 - 0.3, 47.92 - 0.40, 237.40, duration, true, true, 0, true)
		else
              		TaskStartScenarioAtPosition(PlayerPedId(), GetHashKey('PROP_HUMAN_PIANO'), 2799.582 + 1.0, -1163.929 - 0.3, 47.92 - 0.40, 237.40, duration, true, true, 0, true)
		end
		while play == true do
			Citizen.Wait( time_between_tip )      
			TriggerServerEvent('piano:AddSomeMoney')
		end
            end
        end
--------------------------- Black Water  ----------------------------------------   
        if IsPlayerNearCoords(-814.99, -1313.581, 43.68) then
            if not play then 
            end 
 
            if IsControlJustPressed(0, 0x760A9C6F) then
                play = true
		if ismale == false then
		        TaskStartScenarioAtPosition(PlayerPedId(), GetHashKey('PROP_HUMAN_ABIGAIL_PIANO'), -814.99 - 0.03, -1313.581 + 0.5, 43.68 - 0.53, 359.25, duration, true, true, 0, true)
		else
			TaskStartScenarioAtPosition(PlayerPedId(), GetHashKey('PROP_HUMAN_PIANO'), -814.99 - 0.03, -1313.581 + 0.5, 43.68 - 0.53, 359.25,  duration, true, true, 0, true)
		end
		while play == true do
			Citizen.Wait( time_between_tip )      
			TriggerServerEvent('piano:AddSomeMoney')
		end
            end
        end
--------------------------- Tumble Weed  ----------------------------------------   
        if IsPlayerNearCoords(-5515.401, -2914.091, -1.75) then
            if not play then 
            end 
 
            if IsControlJustPressed(0, 0x760A9C6F) then
                play = true
		if ismale == false then
		        TaskStartScenarioAtPosition(PlayerPedId(), GetHashKey('PROP_HUMAN_ABIGAIL_PIANO'), -5515.401 - 0.5,  -2914.091 - 0.5 , -1.75 - 0.43, 114.87, duration, true, true, 0, true)
		else
			TaskStartScenarioAtPosition(PlayerPedId(), GetHashKey('PROP_HUMAN_PIANO'), -5515.401 - 0.5,  -2914.091 - 0.5 , -1.75 - 0.43, 114.87, duration, true, true, 0, true)
		end
		while play == true do
			Citizen.Wait( time_between_tip )      
			TriggerServerEvent('piano:AddSomeMoney')
		end
            end
        end
    end    
end)
    
Citizen.CreateThread(function()    
    while true do 
        Citizen.Wait(1)
        if play then

            if IsControlJustPressed(0, 0x8FD015D8) then
                play = false
                ClearPedTasks(PlayerPedId())
                --SetCurrentPedWeapon(PlayerPedId(), -1569615261, true)
            end    
        end
    end
end)

function IsPlayerNearCoords(x, y, z)
    local playerx, playery, playerz = table.unpack(GetEntityCoords(PlayerPedId(), 0))
    local distance = GetDistanceBetweenCoords(playerx, playery, playerz, x, y, z, true)

    if distance < 3 then
        return true
    end
end