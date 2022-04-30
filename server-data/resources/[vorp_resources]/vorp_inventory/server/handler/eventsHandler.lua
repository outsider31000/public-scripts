function RegisterEvent(EventName, cb)
    RegisterNetEvent(EventName)
    AddEventHandler(EventName, function(...)
        cb(source, ...)
    end)
end