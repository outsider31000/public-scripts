local maxCulling = 350.0
local minCulling = 100.0
local stepCulling = 80.0
local playerArr = {}

RegisterNetEvent('autoCulling')
AddEventHandler('autoCulling', function(nbPlayerAround)
    local _source = source
    local curPlayerDataCulling = nil

    if #playerArr > 0 then
        for i=#playerArr,1,-1 do
            if playerArr[i].src == _source then
                curPlayerDataCulling = playerArr[i]
            end
        end
    end

    if curPlayerDataCulling == nil then
        local elem = {}
        elem['src'] = _source
        elem['culling'] = maxCulling
        table.insert(playerArr, elem)
        curPlayerDataCulling = elem
    end

    local curCulling = curPlayerDataCulling.culling

    if nbPlayerAround >= 28 then
        curCulling = minCulling - stepCulling
        if curCulling <= minCulling then
            curCulling = minCulling
        end
    else
        curCulling = minCulling + stepCulling
        if curCulling >= maxCulling then
            curCulling = maxCulling
        end
    end

    if curCulling ~= curPlayerDataCulling.culling then
        curPlayerDataCulling.culling = curCulling

        if _source ~= nil then
            SetPlayerCullingRadius(_source, curCulling)
            local playerEntity = NetworkGetEntityFromNetworkId(_source)
            if playerEntity ~= nil then
                SetEntityDistanceCullingRadius(playerEntity, curCulling)
            end
        end
    end
end)