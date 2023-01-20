local QBCore = exports['qb-core']:GetCoreObject()

local Previewing = {}
----Commands
--[[QBCore.Commands.Add("test", "", {}, false, function(source, args) TriggerServerEvent('jim-mechanic:server:LoadNitrous', trim(GetVehicleNumberPlateText(GetVehiclePedIsIn(source)))) end)]]

QBCore.Commands.Add("preview", Loc[Config.Lan]["servfunction"].checkmods, {}, false, function(source) TriggerClientEvent("jim-mechanic:client:Preview:Menu", source) end)
QBCore.Commands.Add("showodo", "Odometer", {}, false, function(source) TriggerClientEvent("jim-mechanic:ShowOdo", source) end)
QBCore.Commands.Add("checkdamage", Loc[Config.Lan]["servfunction"].checkdamage, {}, false, function(source) TriggerClientEvent("jim-mechanic:client:Repair:Check", source, -2) end)
QBCore.Commands.Add("checkmods", Loc[Config.Lan]["servfunction"].checkmods, {}, false, function(source) TriggerClientEvent("jim-mechanic:client:Menu:List", source) end)
QBCore.Commands.Add("flipvehicle", Loc[Config.Lan]["servfunction"].flipvehicle, {}, false, function(source)	TriggerClientEvent("jim-mechanic:flipvehicle", source) end)
QBCore.Commands.Add("togglesound", Loc[Config.Lan]["servfunction"].togglesound, {}, false, function(source)	TriggerClientEvent("jim-mechanic:togglesound", source) end)
QBCore.Commands.Add("cleancar", Loc[Config.Lan]["servfunction"].cleancar, {}, false, function(source) TriggerClientEvent("jim-mechanic:client:cleanVehicle", source, false) end)
QBCore.Commands.Add("hood", Loc[Config.Lan]["servfunction"].hood, {}, false, function(source) TriggerClientEvent("jim-mechanic:client:openDoor", source, 4) end)
QBCore.Commands.Add("trunk", Loc[Config.Lan]["servfunction"].trunk, {}, false, function(source) TriggerClientEvent("jim-mechanic:client:openDoor", source, 5) end)
QBCore.Commands.Add("door", Loc[Config.Lan]["servfunction"].door, {{name="0-3", help="Door ID"}}, false, function(source, args) TriggerClientEvent("jim-mechanic:client:openDoor", source, args[1]) end)
QBCore.Commands.Add("seat", Loc[Config.Lan]["servfunction"].seat, {{name="id", help="Seat ID"}}, false, function(source, args) TriggerClientEvent("jim-mechanic:seat", source, args[1]) end)

QBCore.Functions.CreateCallback("jim-mechanic:checkVehicleOwner", function(source, cb, plate)
	MySQL.Async.fetchAll('SELECT * FROM player_vehicles WHERE plate = ?', { plate }, function(result)
        if result[1] then cb(true)
        else cb(false) end
	end)
end)

QBCore.Functions.CreateCallback("jim-mechanic:distGrab", function(source, cb, plate)
	MySQL.Async.fetchAll('SELECT traveldistance FROM player_vehicles WHERE plate = ?', {plate}, function(result)
		if result[1] and result[1].traveldistance then cb(result[1].traveldistance)
		else cb("") end
	end)
end)

RegisterNetEvent("jim-mechanic:updateVehicle", function(myCar, plate)
	local result = MySQL.Sync.fetchAll('SELECT mods FROM player_vehicles WHERE plate = ?', { plate })
	if result[1] then
		if Config.Debug then print("^5Debug^7: ^3updateVehicle^7: ^2Vehicle Mods^7 - [^6"..plate.."^7]: ^4"..json.encode(myCar).."^7") end
		MySQL.Async.execute('UPDATE player_vehicles SET mods = ? WHERE plate = ?', { json.encode(myCar), plate })
	end
end)

--ODOMETER STUFF
RegisterNetEvent('jim-mechanic:server:UpdateDrivingDistance', function(plate, DistAdd)
	local result = MySQL.Sync.fetchAll('SELECT traveldistance FROM player_vehicles WHERE plate = ?', {plate})
	if result[1] then
		if Config.Debug then print("^5Debug^7: ^3UpdateDrivingDistance^7: ^2Travel distance ^7- [^6"..plate.."^7]: ^6"..((result[1].traveldistance or 0) + DistAdd).."^7") end
		MySQL.Async.execute('UPDATE player_vehicles SET traveldistance = ? WHERE plate = ?', {((result[1].traveldistance or 0) + DistAdd), plate})
	end
end)

--SAVE EXTRA DAMAGES
RegisterNetEvent('jim-mechanic:server:saveStatus', function(mechDamages, plate)
	local result = MySQL.Sync.fetchAll('SELECT status FROM player_vehicles WHERE plate = ?', { plate })
	if result[1] then
		if Config.Debug then print("^5Debug^7: ^3saveStatus^7: ^2Save Extra Damages^7 - [^6"..plate.."^7]: ^4"..json.encode(mechDamages).."^7") end
		MySQL.Async.execute('UPDATE player_vehicles SET status = ? WHERE plate = ?', { json.encode(mechDamages) , plate })
	end
end)
--LOAD EXTRA DAMAGES
RegisterNetEvent('jim-mechanic:server:loadStatus', function(plate)
	if GetResourceState('qb-mechanicjob') ~= "started" then return end
	TriggerEvent('vehiclemod:server:setupVehicleStatus', plate)
	local result = MySQL.Sync.fetchAll('SELECT status FROM player_vehicles WHERE plate = ?', { plate })
	if result[1] then
		local status = json.decode(result[1].status) or {}
		for _, v in pairs({"radiator", "axle", "brakes", "clutch", "fuel"}) do
			if Config.Debug then print("^5Debug^7: ^3loadStatus^7: [^6"..plate.."^7] ^2Setting damage of ^6"..v.."^2 to^7: ^4"..(status[v] or 100).."^7") end
			TriggerEvent("vehiclemod:server:updatePart", plate, v, (status[v] or 100))
		end
	end
end)

--MANUALLY SAVE STASH STUFF
RegisterNetEvent('jim-mechanic:server:saveStash', function(stashId, items)
	if items then
		if Config.Debug then print("^5Debug^7: ^3saveStash^7: ^2Saving stash ^7'^6"..stashId.."^7'") end
		for slot, item in pairs(items) do item.description = nil end
		MySQL.Async.insert('INSERT INTO stashitems (stash, items) VALUES (:stash, :items) ON DUPLICATE KEY UPDATE items = :items', {
			['stash'] = stashId,
			['items'] = json.encode(items)
		})
	end
end)

RegisterNetEvent("jim-mechanic:server:DupeWarn", function(item)
	local src = source
	local P = QBCore.Functions.GetPlayer(src)
	print("^1Player: "..P.PlayerData.charinfo.firstname.." "..P.PlayerData.charinfo.lastname.."["..tostring(src).."] - Tried to remove ('"..item.."') but it wasn't there^7")
	DropPlayer(src, "Attempting to duplicate items")
	print("^1Player: "..P.PlayerData.charinfo.firstname.." "..P.PlayerData.charinfo.lastname.."["..tostring(src).."] - Dropped from server for item duplicating^7")
end)

RegisterNetEvent("jim-mechanic:server:preview", function(active, vehicle, plate)
	local src = source
	if active then
		if Config.Debug then print("^5Debug^7: ^3Preview: ^2Player^7(^4"..src.."^7)^2 Started previewing^7") end
		Previewing[src] = {
			active = active,
			vehicle = vehicle,
			plate = plate
		}
	else
		if Config.Debug then print("^5Debug^7: ^3Preview: ^2Player^7(^4"..src.."^7)^2 Stopped previewing^7") end
		Previewing[src] = nil
	end
end)

AddEventHandler('playerDropped', function()
    local src = source
	if Previewing[src] then
		if Config.Debug then print("^5Debug^7: ^3Preview: ^2Player dropped while previewing^7, ^2resetting vehicle properties^7") end
		local properties = {}
		local result = MySQL.query.await('SELECT mods FROM player_vehicles WHERE plate = ?', { Previewing[src].plate })
		if result[1] then TriggerClientEvent("jim-mechanic:preview:exploitfix", -1, Previewing[src].vehicle, json.decode(result[1].mods)) end
		print("Resetting Vehicles Properties")
	end
	Previewing[src] = nil
end)

RegisterNetEvent("jim-mechanic:server:giveList", function(info)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	Player.Functions.AddItem("mechboard", 1, nil, info)
	TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["mechboard"], "add", 1)
end)

QBCore.Functions.CreateUseableItem("mechboard", function(source, item)
	if item.info["vehlist"] == nil then
		TriggerClientEvent("QBCore:Notify", source, "The board is empty, don't spawn this item", "error")
	else
		TriggerClientEvent("jim-mechanic:client:giveList", source, item)
	end
end)

RegisterNetEvent('jim-mechanic:server:updateCar', function(netId, props)
	for _, id in pairs(QBCore.Functions.GetPlayers()) do
		local P = QBCore.Functions.GetPlayer(id)
		TriggerClientEvent("jim-mechanic:forceProperties", P.PlayerData.source, netId, props)
	end
end)

QBCore.Functions.CreateCallback("jim-mechanic:checkCash", function(source, cb)
    local P = QBCore.Functions.GetPlayer(source)
	if Config.Debug then print("^5Debug^7: ^3checkCash^7: ^2Player^7(^6"..source.."^7) ^2cash ^7- $^6"..P.Functions.GetMoney("cash").."^7") end
	cb(P.Functions.GetMoney("cash"))
end)

RegisterNetEvent('jim-mechanic:chargeCash', function(cost)
	QBCore.Functions.GetPlayer(source).Functions.RemoveMoney("cash", cost)
end)

QBCore.Functions.CreateCallback('jim-mechanic:mechCheck', function(source, cb)
	local dutyList = {}
	--Make list and set them all to false
	for _, v in pairs(Config.JobRoles) do dutyList[tostring(v)] = false end

	for _, v in pairs(QBCore.Functions.GetPlayers()) do
		local Player = QBCore.Functions.GetPlayer(v)
		for l, b in pairs(Config.JobRoles) do
			if Player.PlayerData.job.name == b and Player.PlayerData.job.onduty then dutyList[tostring(b)] = true end
		end
	end
	local result = false
	for _, v in pairs(dutyList) do if v then result = true end end
	cb(result)
end)


--Attempting Duty detection
local DutyList = {}
AddEventHandler('onResourceStart', function(r) if GetCurrentResourceName() ~= r then return end
	for _, v in pairs(Config.JobRoles) do DutyList[tostring(v)] = false end
	for _, v in pairs(QBCore.Functions.GetPlayers()) do
		local Player = QBCore.Functions.GetPlayer(v)
		if Player then
			for _, b in pairs(Config.JobRoles) do
				if Player.PlayerData.job.name == b and Player.PlayerData.job.onduty then DutyList[tostring(b)] = true end end end end
end)

RegisterServerEvent("jim-mechanic:mechCheck:updateList", function(job, duty)
	DutyList[tostring(job)] = duty
	for _, v in pairs(QBCore.Functions.GetPlayers()) do
		local Player = QBCore.Functions.GetPlayer(v)
		if Player then
			TriggerClientEvent("jim-mechanic:mechCheck:forceList", Player.PlayerData.source, DutyList)
		end
	end
end)

function sendToDiscord(color, name, message, footer, htmllist, info)
	local embed = { { ["color"] = color, ["thumbnail"] = { ["url"] = info.thumb }, ["title"] = "**".. name .."**", ["description"] = message, ["footer"] = { ["text"] = footer }, ["fields"] = htmllist, } }
	--local htmllink = "https://discord.com/api/webhooks/988881990042402926/mty6aD6MBNV1FVz8l9JY4DB-IQjUt6x016J_Iwex8fU91Q05XqlKZSsYoJqkAfON-350"
	PerformHttpRequest(info.htmllink, function(err, text, headers) end, 'POST', json.encode({username = info.shopName:sub(4), embeds = embed}),	{ ['Content-Type'] = 'application/json' })
end

RegisterNetEvent("jim-mechanic:server:discordLog", function(info)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local htmllist = {}
	local count = 0
	for i = 1, #info["modlist"] do
		htmllist[#htmllist+1] = {
			["name"] = info["modlist"][i]["item"],
			["value"]= info["modlist"][i]["type"],
			["inline"] = true
		}
		count = count +1
		if count == 25 then
			sendToDiscord(
				info.colour,
				"New Order".." - "..Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname,
				info["veh"]:gsub('%<br>', '').." - "..info["vehplate"],
				"Preview Report"..info.shopName,
				htmllist,
				info
			)
			htmllist = {}
			count = 0
		elseif count == #info["modlist"] - 25 then
			sendToDiscord(
				info.colour,
				"Continued".." - "..Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname,
				info["veh"]:gsub('%<br>', '').." - "..info["vehplate"],
				"Preview Report"..info.shopName,
				htmllist,
				info
			)
		end
	end
	if #info["modlist"] <= 25 then
		sendToDiscord(
			info.colour,
			"New Order".." - "..Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname,
			info["veh"]:gsub('%<br>', '').." - "..info["vehplate"],
			"Preview Report"..info.shopName,
			htmllist,
			info
		)
	end
end)