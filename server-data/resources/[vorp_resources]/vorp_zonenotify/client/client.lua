local hashstore = false

local characterselected = false

RegisterNetEvent("vorp:SelectedCharacter")
AddEventHandler("vorp:SelectedCharacter", function(charid)
	Wait(1000)
	characterselected = true
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(3000)
		local player = PlayerPedId()
		local x, y, z = table.unpack(GetEntityCoords(player))		
		local zone = nil
	
		local tempstate = Citizen.InvokeNative(0x43AD8FC02B429D33, x, y, z, 0)
		if tempstate then
			zone = tempstate
		end

		local tempwritten = Citizen.InvokeNative(0x43AD8FC02B429D33, x, y, z, 13)
		if tempwritten then
			zone = tempwritten
		end

		local tempprint = Citizen.InvokeNative(0x43AD8FC02B429D33, x, y, z, 12)
		if tempprint then
			zone = tempprint
		end

		local tempdistrict = Citizen.InvokeNative(0x43AD8FC02B429D33, x, y, z, 10)
		if tempdistrict then
			zone = tempdistrict
		end

		local temptown = Citizen.InvokeNative(0x43AD8FC02B429D33, x, y, z, 1)
		if temptown then
			zone = temptown
		end

		if hashstore ~= zone and characterselected == true then
			hashstore = zone
			alertUI()
		end
	end
end)


function alertUI()
	if Config.NativeZones == true then
		nativeAlertTop()
	else
		alertTop()
	end 
end

function GetCardinalDirection(h)
	if h <= 22.5 then
		return "N"
	elseif h <= 67.5 then
		return "NE"
	elseif h <= 112.5 then
		return "E"
	elseif h <= 157.5 then
		return "SE"
	elseif h <= 202.5 then
		return "S"
	elseif h <= 247.5 then
		return "SW"
	elseif h <= 292.5 then
		return "W"
	elseif h <= 337.5 then
		return "NW"
	else
		return "N"
	end
end

function getMapData(hash)
	if hash ~= false then
		local sd = Config.MapData[hash]
		if sd then
			return sd.ZoneName
		else
			print('No data for:', hash)
			return 'Unknown'
		end
	else
		return 'Unknown'
	end
end

function getZoneData(hash)
	if hash ~= false then
		local sd = Config.ZoneData[hash]
		if sd then
			return sd.texture
		else
			print('No data for:', hash)
			return nil
		end
	else
		return nil
	end
end

function getIGTime()
	-- Get Time for game
	local hour =  GetClockHours()
	local ap = 'am'

	if hour > 12 then
		hour = hour  - 12
		ap = 'pm'
	elseif hour == 0 then
		hour = hour + 12
		ap = 'am'
	elseif hour == 12 then
		ap = 'pm'
	end

	if hour < 10 then
		hour = '0'..hour
	end

	return hour ..":" .. GetClockMinutes() ..":" .. GetClockSeconds() .. ap
end

function getIGWindSpeed()
	-- Get Temperatures
	local metric = ShouldUseMetricTemperature();
	local windSpeed
	local windSpeedUnit
	if metric then
		windSpeed = math.floor(GetWindSpeed())
		windSpeedUnit = 'kph'
	else
		windSpeed = math.floor(GetWindSpeed() * 0.621371)
		windSpeedUnit = 'mph'
	end

	-- TODO: Figure out how to get the heading from the wind direction
	-- local wx, wy, wz = table.unpack(GetWindDirection())

	return string.format('%d °%s', windSpeed, windSpeedUnit)
end

function getIGTemp()
	-- Get Temperatures
	local metric = ShouldUseMetricTemperature();
	local temperature
	local temperatureUnit
	local windSpeed
	local windSpeedUnit
	if metric then
		temperature = math.floor(GetTemperatureAtCoords(x, y, z))
		temperatureUnit = 'C'

		windSpeed = math.floor(GetWindSpeed())
		windSpeedUnit = 'kph'
	else
		temperature = math.floor(GetTemperatureAtCoords(x, y, z) * 9/5 + 32)
		temperatureUnit = 'F'

		windSpeed = math.floor(GetWindSpeed() * 0.621371)
		windSpeedUnit = 'mph'
	end

	local wx, wy, wz = table.unpack(GetWindDirection())

	return string.format('%d °%s', temperature, temperatureUnit)
end

function nativeAlertTop() 
	local zone = getZoneData(hashstore)

	local time = getIGTime()
	local temp = getIGTemp()
	-- local wind = getIGWindSpeed()

	if zone then
		TriggerEvent("vorp:NotifyTop",  time .. ' ~COLOR_YELLOWSTRONG~' .. temp, zone, Config.Notification.TimeShowing)
	end
end

function alertTop()
	local player = PlayerPedId()
	local x, y, z = table.unpack(GetEntityCoords(player))
	local district_hash =  Citizen.InvokeNative(0x43AD8FC02B429D33, x, y, z, 10)
	local town_hash = Citizen.InvokeNative(0x43AD8FC02B429D33, x, y, z, 1)
	local state_hash = Citizen.InvokeNative(0x43AD8FC02B429D33, x, y, z, 0)
	local printed_hash = Citizen.InvokeNative(0x43AD8FC02B429D33, x, y, z, 12)
	local written_hash = Citizen.InvokeNative(0x43AD8FC02B429D33, x, y, z, 13)

	local district = getMapData(district_hash)
	local town = getMapData(town_hash)
	local state = getMapData(state_hash)
	local printed = getMapData(print_hash)
	local written = getMapData(written_hash)
	
	local time = getIGTime()
	local temp = getIGTemp()
	local wind = getIGWindSpeed()
	
	SendNUIMessage({
		type = 'openzone',
		district = district,
		town = town,
		time = time,
		temp = temp,
		state = state,
		written = written,
		printed = printed
	})
end

RegisterCommand("zoneinfo", function(source, args, rawCommand) --  COMMAND
	characterselected = true
	alertUI()
end)

RegisterCommand("debug:zoneinfo", function(source, args, rawCommand) -- Debug COMMAND
	print('town', Citizen.InvokeNative(0x43AD8FC02B429D33, x, y, z, 1))
	print('district', Citizen.InvokeNative(0x43AD8FC02B429D33, x, y, z, 10))
	print('state', Citizen.InvokeNative(0x43AD8FC02B429D33, x, y, z, 0))
	print('print', Citizen.InvokeNative(0x43AD8FC02B429D33, x, y, z, 12))
	print('written', Citizen.InvokeNative(0x43AD8FC02B429D33, x, y, z, 13))
end)

