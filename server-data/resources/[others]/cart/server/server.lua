RegisterServerEvent('EveryoneTeleportEntity')
AddEventHandler('EveryoneTeleportEntity', function(ent,x,y,z) 
nent = NetworkGetEntityFromNetworkId(ent)
--print("EveryoneTeleportEntity",ent,nent)

TriggerClientEvent('EveryoneTeleportEntity',-1,ent,x,y,z)
end)
