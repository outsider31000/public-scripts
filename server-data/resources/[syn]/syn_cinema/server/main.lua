local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

Schedule = {}
RegisterCommand("startshow", function(source, args)
    local _source = source
	local Character = VorpCore.getUser(_source).getUsedCharacter
	local job = Character.job

	if job == Config.job then 
		for index,arg in ipairs(args) do args[index] = arg:upper() end

		if Globals.Shows[args[1]] then
			TriggerClientEvent("syn_cinema:startShow", -1, args[1])
		elseif Globals.Movies[args[1]] and Globals.Projections[args[2]] then
			TriggerClientEvent("syn_cinema:startShow", -1, { name = args[1], town = args[2] })
		else print("Invalid show/movie.") end
	else
		TriggerClientEvent("vorp:TipRight", _source, Config.Language..Config.job , 50000)
	end
end)
RegisterCommand("scheduleshow", function(source, args)
	local _source = source
	local Character = VorpCore.getUser(_source).getUsedCharacter
	local job = Character.job

	if job == Config.job then 

		for index,arg in ipairs(args) do args[index] = arg:upper() end

		if Globals.Shows[args[1]] and tonumber(args[2]) and tonumber(args[3]) then
			table.insert(Schedule, {
				time = { h = tonumber(args[2]), m = tonumber(args[3]), d = tonumber(args[4]) },
				show = args[1]
			})
			SaveSchedule()

		elseif Globals.Movies[args[1]] and Globals.Projections[args[2]] and tonumber(args[3]) and tonumber(args[4]) then
			table.insert(Schedule, {
				time = { h = tonumber(args[3]), m = tonumber(args[4]), d = tonumber(args[5]) },
				show = {
					name = args[1],
					town = args[2]
				}
			})
			SaveSchedule()

		else 
			print("Invalid show/movie or time.") 
		end
	else
		TriggerClientEvent("vorp:TipRight", _source, Config.Language..Config.job , 50000)
	end
end)


LoadSchedule = function()
	Schedule = LoadResourceFile(GetCurrentResourceName(), "server/schedule.json")

	if Schedule then
		Schedule = json.decode(Schedule)
	else
		Schedule = {}
	end
end
SaveSchedule = function()
	SaveResourceFile(GetCurrentResourceName(), "server/schedule.json", json.encode(Schedule), -1)
end


Timer = function()
	local time, save = os.time(), false
	local d, h, m = os.date('*t',time).day, os.date('*t',time).hour, os.date('*t',time).min

	for index,show in ipairs(Schedule) do
		if show.time then
			if ((show.time.d and (show.time.d == d)) or not show.time.d) and show.time.h == h and show.time.m == m then
				TriggerClientEvent("syn_cinema:startShow", -1, show.show)

				table.remove(Schedule, index)
				save = true
			end
		end
	end

	if save then
		SaveSchedule()
	end

	Citizen.SetTimeout(60000, Timer)
end
Citizen.SetTimeout(0, Timer)
Citizen.SetTimeout(0, LoadSchedule)
