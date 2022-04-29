WeatherTypes = {
	'blizzard',
	'clouds',
	'drizzle',
	'fog',
	'groundblizzard',
	'hail',
	'highpressure',
	'hurricane',
	'misty',
	'overcast',
	'overcastdark',
	'rain',
	'sandstorm',
	'shower',
	'sleet',
	'snow',
	'snowlight',
	'sunny',
	'thunder',
	'thunderstorm',
	'whiteout'
}

function TimeToHMS(time)
	local hour = math.floor(time / 60 / 60)
	local minute = math.floor(time / 60) % 60
	local second = time % 60

	return hour, minute, second
end

function HMSToTime(hour, minute, second)
	return hour * 3600 + minute * 60 + second
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
