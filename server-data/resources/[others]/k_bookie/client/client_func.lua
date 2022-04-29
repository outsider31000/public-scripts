-- REQUEST
function modelrequest( model )
    Citizen.CreateThread(function()
        RequestModel( model )
    end)
end

-- ROUND
function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

-- TABLE.LENGHT
function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

-- DRAW TEXT FUNCTION
function DrawText(x,y,text)
    SetTextScale(0.35,0.35)
    SetTextColor(255,255,255,255)--r,g,b,a
    SetTextCentre(true)--true,false
    SetTextDropshadow(1,0,0,0,200)--distance,r,g,b,a
    SetTextFontForCurrentCommand(0)
    DisplayText(CreateVarString(10, "LITERAL_STRING", text), x, y)
end

-- DRAW 3D-TEXT FUNCTION
function DrawText3D(x,y,z,text)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoord())
    SetTextScale(0.25, 0.25)
    SetTextFontForCurrentCommand(1)
    SetTextColor(255, 255, 255, 215)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    SetTextCentre(1)
    DisplayText(str,_x,_y)
    local factor = (string.len(text)) / 150

end

-- DRAW_LINE {{NOT USED}}
function DrawLine(x,y,z,_x,_y,_z,r,g,b,a)
    Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF, x, y, z, _x, _y, _z, r, g, b, a)
end