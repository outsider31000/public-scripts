local infoOn = false   
local coordsText = ""   
local headingText = "" 
local modelText = ""    



Citizen.CreateThread(function()                
    while true do                                        
        local pause = 250                                 
        if infoOn then                                    
            pause = 5                                      
            local player = PlayerPedId()                 
            if IsPlayerFreeAiming(PlayerId()) then         
                local entity = getEntity(PlayerId())       
                local coords = GetEntityCoords(entity)     
                local heading = GetEntityHeading(entity)    
                local model = GetEntityModel(entity)       
                coordsText = coords                         
                headingText = heading                       
                modelText = model    
            end                                             
            local _text = ("Coords: " .. coordsText .. "\nHeading: " .. headingText .. "\nHash: " .. modelText)
            DrawTxt(_text, 0.0, 0.5, 0.4, 0.4, true, 255, 255, 255, 150, false) 
            
        end                                                
        Citizen.Wait(pause)                           
    end                                                    
end)                                                        

function getEntity(player)                                          
    local result, entity = GetEntityPlayerIsFreeAimingAt(player)    
    return entity                                                   
end                                                                


function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
    DisplayText(str, x, y)
end
    
function CreateVarString(p0, p1, variadic)
    return Citizen.InvokeNative(0xFA925AC00EB830B9, p0, p1, variadic, Citizen.ResultAsLong())
end

ToggleInfos = function()              
    infoOn = not infoOn               
end                                   

RegisterCommand("devgun", function()     
    ToggleInfos()                      
end)                                   