RegisterServerEvent('garages:PayAutomaticMeca')
AddEventHandler('garages:PayAutomaticMeca', function (price)
	local currentSource = source
	
	TriggerEvent('es:getPlayerFromId', source, function(user)
		local money = tonumber(user.getMoney())
		print("--------------------------------Garage Vehicule a rentrer, payer mecano : " .. money .. " price " .. price)
		if(money > price) and (price > 0 ) then
			TriggerClientEvent("es_freeroam:notify", currentSource, "CHAR_BANK_MAZE", 1, "Maze Bank", false, "Payement de " .. price .."$ ~g~accepté.")
			user.removeMoney(price)
			TriggerClientEvent("garages:EnterResult", currentSource, true)
		else
			TriggerClientEvent("es_freeroam:notify", currentSource, "CHAR_BANK_MAZE", 1, "Maze Bank", false, "Fonds ~r~insuffisant.")
			TriggerClientEvent("garages:EnterResult", currentSource, false)
		end
	end)
end)

RegisterServerEvent('garages:storevehiculeForFix')
AddEventHandler('garages:storevehiculeForFix', function(vehicle)
    local identifiers = GetPlayerIdentifiers(source)
    local currentSource = source
    local model = tostring(vehicle.model)
    local plate = string.gsub(vehicle.plate, "^%s*(.-)%s*$", "%1")
    print("vehicule: ".. json.encode(vehicle))
    print("plaque revue: ".. plate)
    print(json.encode(vehicle))
    MySQL.Async.fetchAll("SELECT * FROM user_vehicle WHERE owner=@owner AND model=@model AND plate LIKE @plate LIMIT 1", {['@owner'] = identifiers[1], ['@model'] = model, ['@plate'] = plate }, function(vhl)
        print(json.encode(vhl))
        if vhl[1] then
            TriggerClientEvent('garages:verifowner',currentSource, true)
		else
			TriggerClientEvent('garages:close', currentSource)
			TriggerClientEvent('garages:verifowner', currentSource, false)
		end
    end)
end)

RegisterServerEvent('garages:getplayervehicle')
AddEventHandler('garages:getplayervehicle', function(spawnable)
    local identifiers = GetPlayerIdentifiers(source)
    local currentSource = source
    local spawnable = spawnable
    MySQL.Async.fetchAll("SELECT * FROM user_vehicle WHERE owner=@owner AND type=@spawnable ORDER BY name ASC", {['@owner'] = identifiers[1], ['@spawnable'] =  spawnable}, function(vehicles)

        for _, vhl in ipairs(vehicles) do
            TriggerClientEvent('garages:addvhltothelist', currentSource, vhl)
        end
    end)
end)

RegisterServerEvent('garages:storeallvehicles')
AddEventHandler('garages:storeallvehicles', function()
    local identifiers = GetPlayerIdentifiers(source)
    local currentSource = source
    MySQL.Sync.execute("UPDATE user_vehicle SET state=0 WHERE owner=@owner", {['@owner'] = identifiers[1]})
end)


RegisterServerEvent('garages:settofourriere')
AddEventHandler('garages:settofourriere', function(vehicle)
    local identifiers = GetPlayerIdentifiers(source)
    local currentSource = source
    local model = vehicle.model
    local plate = vehicle.plate
    MySQL.Sync.execute("UPDATE user_vehicle SET state=2 WHERE owner=@owner AND model=@model AND plate like @plate", {['@owner'] = identifiers[1], ['@model'] =  model, ['@plate'] = plate})
    TriggerClientEvent('garages:notifs', currentSource, 'Véhicule envoyé à la fourrière !')
end)


RegisterServerEvent('garages:getvehicle')
AddEventHandler('garages:getvehicle', function(vehicle)
    local identifiers = GetPlayerIdentifiers(source)
    local currentSource = source
    local model = tostring(vehicle.model)
    local plate = string.gsub(vehicle.plate, "^%s*(.-)%s*$", "%1")
    MySQL.Async.fetchAll("SELECT * FROM user_vehicle WHERE owner=@owner AND model=@model AND plate=@plate ORDER BY name ASC LIMIT 1", {['@owner'] = identifiers[1], ['@model'] =  model, ['@plate'] = plate }, function(vehicle)
        TriggerClientEvent('garages:spawnvehicle', currentSource, vehicle[1])
        TriggerClientEvent('garages:close', currentSource)
        MySQL.Sync.execute("UPDATE user_vehicle SET state=1 WHERE owner=@owner AND model like @model AND plate like @plate", {['@owner'] = identifiers[1], ['@model'] =  model, ['@plate'] = plate})
    end)
end)
RegisterServerEvent('garages:storevehicule')
AddEventHandler('garages:storevehicule', function(vehicle)
    local identifiers = GetPlayerIdentifiers(source)
    local currentSource = source
    local model = tostring(vehicle.model)
    local plate = string.gsub(vehicle.plate, "^%s*(.-)%s*$", "%1")
    print("vehicule: ".. json.encode(vehicle))
    print("plaque revue: ".. plate)
    print(json.encode(vehicle))
    MySQL.Async.fetchAll("SELECT * FROM user_vehicle WHERE owner=@owner AND model=@model AND plate LIKE @plate LIMIT 1", {['@owner'] = identifiers[1], ['@model'] = model, ['@plate'] = plate }, function(vhl)
        print(json.encode(vhl))
        if vhl[1] then
            MySQL.Sync.execute("UPDATE user_vehicle SET state=0 WHERE owner=@owner AND model=@model AND plate=@plate", {['@owner'] = identifiers[1], ['@model'] =  model, ['@plate'] = plate})
            TriggerClientEvent('garages:vehiculestored', currentSource, vhl[1])
        else
            TriggerClientEvent('garages:close', currentSource)
            TriggerClientEvent('garages:notifs', currentSource, "Ce n'est pas ta caisse !")
        end

    end)
end)