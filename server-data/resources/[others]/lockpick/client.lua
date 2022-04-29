local pass 

function lockpick()
    Wait(100)
    openui()

    while pass == nil do
        Citizen.Wait(1)
        
    end

    if pass == true then
        closeui()
        pass = nil 
        return true 
    elseif pass == false then 
        closeui()
        pass = nil 
        return false
    end 
   
end

function openui()
    SetNuiFocus(true,true)
    SendNUIMessage({
        action = "ui",
        toggle = true
    })
end

function closeui()
    SetNuiFocus(false,false)
    SendNUIMessage({
        action = "ui",
        toggle = false
    })
end

RegisterNUICallback('callback', function(data)
    pass = data.success
    
end)
