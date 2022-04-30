Log = {}


function Log.Warning(text)
    print("^3WARNING: ^7".. tostring(text) .."^7")
end

function Log.error(text)
    print("^1ERROR: ^7".. tostring(text) .."^7")
end

function Log.print(text)
    print("^2Inventory: ^7"..tostring(text))
end