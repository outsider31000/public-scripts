local backoff = 500
local dlq = 0
job = nil

function CheckJob(joblist)
    -- job = nil

    if joblist == 0 then
        return true
    end

    if joblist ~= 0 then
        if job == nil then
            TriggerServerEvent('vorp:findjob')
        end    
    
        while(job == nil and dlq < backoff) do
            dlq = dlq + 1
            Wait(1)
        end

        for k, v in pairs(joblist) do
            if v == job then
                return true
            end
        end
    end

    return false
end

RegisterNetEvent("vorp:setjob")
AddEventHandler("vorp:setjob", function(rjob)
    job = rjob
end)