local input

AddEventHandler("syn_inputs:sendinputs", function(placeholder,placeholder2,cb)
getinput(placeholder,placeholder2,cb)
end)


 function getinput(placeholder,placeholder2,cb)
    local Cb = cb
Citizen.CreateThread(function()
    SetNuiFocus(true,true)
    SendNUIMessage({
        action = "open",
        title = placeholder2,
        button = placeholder
    })
    while not input do
        Citizen.Wait(50)
    end
    cb(input)
    Citizen.Wait(10)
    input = nil
    SetNuiFocus(false,false) 
end)
end 


RegisterNUICallback('sendinput', function(data)
    input = data.input
    SetNuiFocus(false,false) 
end)

RegisterNUICallback('closeui', function()
    SetNuiFocus(false,false) 
end)




RegisterCommand("testinputs",function()
    TriggerEvent("syn_inputs:sendinputs", "hello world" ,"confirm23", function(cb)
        print(cb)
    end) 
end)
RegisterCommand("unfuck",function()
    SetNuiFocus(false,false) 
end)

