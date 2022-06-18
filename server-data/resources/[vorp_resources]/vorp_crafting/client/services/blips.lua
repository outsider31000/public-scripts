Blips = {}

Blips.addBlipForCoords = function(blipid, blipname,bliphash,x,y,z)
	local blip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, x, y, z)
	SetBlipSprite(blip,bliphash,true)
	SetBlipScale(blip,0.2)
	Citizen.InvokeNative(0x9CB1A1623062F402, blip, blipname)
end