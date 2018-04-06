vehStorage = {}

RegisterServerEvent("ls:check")
AddEventHandler("ls:check", function(plate, isPlayerInside, notificationParam)
	local source = source
	local identifier = GetPlayerIdentifiers(source)[1]
	Search(plate, playerIdentifier, isPlayerInside, notificationParam, source)
end)

RegisterServerEvent("ls:changeLockStatus")
AddEventHandler("ls:changeLockStatus", function(param, plate)
	UpdateTable(param, plate)
end)

RegisterServerEvent("ls:refreshid")
AddEventHandler("ls:refreshid", function(plate,vehicle)

	--UpdateTheTable(plate, vehicle)
end)

function Search(plate, playerIdentifier, isPlayerInside, notificationParam, source)
	result = 0
	for i=1, #(vehStorage) do
		if vehStorage[i].plate == plate then
			result = result + 1
			if vehStorage[i].owner == playerIdentifier then
				TriggerClientEvent("ls:lock", source, vehStorage[i].lockStatus,vehStorage[i].plate)
			else
				TriggerClientEvent("ls:sendNotification", source, notificationParam, "vous n'avez pas les clés de ce véhicule.", 0.5)
			end
		end
	end

	if result == 0 and isPlayerInside then

		randomMsg = RandomMsg()
		TriggerClientEvent("ls:sendNotification", source, notificationParam, randomMsg, 0.5)
		table.insert(vehStorage, {plate=plate, owner=playerIdentifier, lockStatus=0})	
	end
end

function UpdateTable(param, plate)
	for i=1, #(vehStorage) do
		if vehStorage[i].plate == plate then
			vehStorage[i].lockStatus = param
		end
	end
end

function UpdateTheTable(plate,vehicle)
	-- for i=1, #(vehStorage) do
		-- if vehStorage[i].plate == plate then
			-- vehStorage[i].id = vehicle
		-- end
	-- end
end



function RandomMsg()
	random = math.random(1, 1)
	if random == 1 then randomMsg = "Vous avez maintenant les clés sur vous." end
	-- if random == 2 then randomMsg = "Clefs trouvees dans la boite a gants" end
	-- if random == 3 then randomMsg = "les clefs etaient sous le siege passager" end
	-- if random == 4 then randomMsg = "Clefs trouvees dans l'accoudoir" end
	-- if random == 5 then randomMsg = "Les clefs etaient deja sur le contact" end
	return randomMsg
end
