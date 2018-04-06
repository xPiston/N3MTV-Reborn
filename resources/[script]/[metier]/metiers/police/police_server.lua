local inServiceCops = {}

function addCop(identifier)
	MySQL.Async.execute("INSERT INTO police (`identifier`) VALUES (@identifier)", { ['@identifier'] = identifier})
end

function remCop(identifier)
	MySQL.Async.execute("DELETE FROM police WHERE identifier = @identifier", { ['@identifier'] = identifier})
end

RegisterServerEvent('police:removeCop')
AddEventHandler('police:removeCop', function()
	local source = source
	TriggerEvent("es:getPlayerFromId", source, function(user)
		user.log('Quitte la police')
		local identifier = user.getIdentifier()
		MySQL.Async.execute("DELETE FROM police WHERE identifier = @identifier", { ['@identifier'] = identifier})
	end)
end)

function checkIsCop(identifier, source)
	MySQL.Async.fetchScalar("SELECT rank FROM police WHERE identifier = @identifier", { ['@identifier'] = identifier},
		function(result)
			if(not result) then
				TriggerClientEvent('police:receiveIsCop', source, "inconnu")
			else
				TriggerClientEvent('police:receiveIsCop', source, result.rank)
			end
		end)
end

function s_checkIsCop(identifier)
	local result = MySQL.Sync.fetchScalar("SELECT rank FROM police WHERE identifier = @identifier", { ['@identifier'] = identifier})
	if(not result) then
		return "nil"
	else
		return result.rank
	end
end

function getIdentifiant(id)

	for _, v in ipairs(id) do
	    return v
	end

end

function checkInventory(source, police, target, player)
	local strResult = "Possede : "
	
	local dirtyMoney = player.getDirtyMoney()
	strResult = strResult .. dirtyMoney .. "$ d'argent sale , "
	player.setDirtyMoney(0)
	player.log('Argent sale perdu via controle de police')
	police.addMoney(math.floor(dirtyMoney/5))
	police.log('Prime réquisition argent sale : +' .. math.floor(dirtyMoney/5) ..'$')
	local identifiers = GetPlayerIdentifiers(target)
	local persotarget = getIdentifiant(identifiers)

	local result = MySQL.Sync.fetchAll("SELECT * FROM `user_inventory` JOIN items ON items.id = user_inventory.item_id WHERE user_id = @username", {['@username'] = persotarget})
	if (result) then
		for _, v in ipairs(result) do
			if(v.quantity ~= 0) then
				strResult = strResult .. v.quantity .. " de " .. v.libelle .. ", "
				if tonumber(v.isIllegal) == 1 then
					TriggerClientEvent('police:dropIllegalItem', target, v.item_id, v.quantity)
					print("isIllegal")
				end
			end


		end
	end

	strResult = strResult .. " / "
	local result = MySQL.Sync.fetchAll("SELECT * FROM `user_weapons` WHERE identifier = @username", { ['@username'] = player.getIdentifier()})
	if (result) then
		for _, v in ipairs(result) do
			strResult = strResult .. "possession de " .. v.weapon_model .. ", "
		end
		TriggerEvent("weaponshop:RemoveWeaponsToPlayerFouille",target)
	end

	return strResult
end

AddEventHandler('playerDropped', function()
	if(inServiceCops[source]) then
		inServiceCops[source] = nil

		for i, c in pairs(inServiceCops) do
			TriggerClientEvent("police:resultAllCopsInService", i, inServiceCops)
		end
	end
end)

AddEventHandler('es:playerDropped', function(player)
	local isCop = s_checkIsCop(player.identifier)
	if(isCop ~= "nil") then
		--TriggerEvent("jobssystem:disconnectReset", player, 7)
	end
end)

RegisterServerEvent('police:checkIsCop')
AddEventHandler('police:checkIsCop', function()
	--print(source)
	TriggerEvent("es:getPlayerFromId", source, function(user)
		local identifier = user.getIdentifier()
		--print(identifier)
		checkIsCop(identifier, source)
	end)
end)

RegisterServerEvent('police:takeService')
AddEventHandler('police:takeService', function()
	if(not inServiceCops[source]) then
		inServiceCops[source] = GetPlayerName(source)

		for i, c in pairs(inServiceCops) do
			TriggerClientEvent("police:resultAllCopsInService", i, inServiceCops)
		end
	end
end)

RegisterServerEvent('police:breakService')
AddEventHandler('police:breakService', function()
	if(inServiceCops[source]) then
		inServiceCops[source] = nil

		for i, c in pairs(inServiceCops) do
			TriggerClientEvent("police:resultAllCopsInService", i, inServiceCops)
		end
	end
end)

RegisterServerEvent('police:getAllCopsInService')
AddEventHandler('police:getAllCopsInService', function()
	TriggerClientEvent("police:resultAllCopsInService", source, inServiceCops)
end)

RegisterServerEvent('police:checkingPlate')
AddEventHandler('police:checkingPlate', function(plate, model)
	local mysource = source
	local plate = string.gsub(plate, "^%s*(.-)%s*$", "%1")
	MySQL.Async.fetchAll("SELECT users.nom, user_vehicle.name FROM user_vehicle JOIN users ON user_vehicle.owner = users.identifier WHERE model =@model AND plate like @plate", { ['@plate'] = plate, ['@model'] = model },
		function(result)
			if ( result[1]) then
				for _, v in ipairs(result) do
					TriggerClientEvent("es_freeroam:notify", mysource, "CHAR_ANDREAS", 1, "GOUVERNEMENT", false, "Model :~y~"..v.name .."~w~ numéro: ~y~"..plate.."~w~ enregistré par ~y~" .. v.nom .. "~y~")
					-- TriggerClientEvent('chatMessage', mysource, 'GOUVERNEMENT', {255, 0, 0}, "Le véhicule #"..plate.." appartient à " .. v.Nom)
				end
			else
				TriggerClientEvent("es_freeroam:notify", mysource, "CHAR_ANDREAS", 1, "GOUVERNEMENT", false, "~w~ Numéro: ~y~"..plate.."~w~ est un véhicule ~r~moldu !")
				--TriggerClientEvent('chatMessage', mysource, 'GOUVERNEMENT', {255, 0, 0}, "Le véhicule #"..plate.." n'est pas enregistré !")
			end
		end)
end)

RegisterServerEvent('police:confirmUnseat')
AddEventHandler('police:confirmUnseat', function(t)
	local source = source
	TriggerClientEvent('chatMessage', source, 'GOUVERNEMENT', {255, 0, 0}, GetPlayerName(t).. " est sorti !")
	TriggerClientEvent('police:unseatme', t)
end)

RegisterServerEvent('police:targetCheckInventory')
AddEventHandler('police:targetCheckInventory', function(t)
	local source = source
	TriggerEvent('es:getPlayerFromId', source, function(police)
		TriggerEvent('es:getPlayerFromId', t, function (user)
				local info = checkInventory(source, police, t, user)
				TriggerClientEvent('chatMessage', source, 'GOUVERNEMENT', {255, 0, 0}, info)
		end)
	end)
end)

RegisterServerEvent('police:finesGranted')
AddEventHandler('police:finesGranted', function(t, amount, reason)
	local source = source
	TriggerClientEvent('chatMessage', source, 'GOUVERNEMENT', {255, 0, 0}, GetPlayerName(t).. " a payé $"..amount.." d'amende pour" .. reason)
	TriggerClientEvent('police:payFines', t, amount, reason)
	TriggerEvent('es:getPlayerFromId', source, function(police)
		TriggerEvent('es:getPlayerFromId', t, function (user)
			police.log('Donne Amende à ' .. user.getIdentifier() .. ' de ' .. amount .. ' pour ' .. reason)
		end)
	end)
end)

RegisterServerEvent('police:cuffGranted')
AddEventHandler('police:cuffGranted', function(t)
	local source = source
	TriggerClientEvent('chatMessage', source, 'GOUVERNEMENT', {255, 0, 0}, GetPlayerName(t).. " menotes enlevées !")
	TriggerClientEvent('police:getArrested', t)
end)

RegisterServerEvent('police:forceEnterAsk')
AddEventHandler('police:forceEnterAsk', function(t, v)
	local source = source
	TriggerClientEvent('chatMessage', source, 'GOUVERNEMENT', {255, 0, 0}, GetPlayerName(t).. " entre dans la voiture)")
	TriggerClientEvent('police:forcedEnteringVeh', t, v)
end)

-----------------------------------------------------------------------
----------------------EVENT SPAWN POLICE VEH---------------------------
-----------------------------------------------------------------------
RegisterServerEvent('CheckPoliceVeh')
AddEventHandler('CheckPoliceVeh', function(vehicle)
	local source = source
	--TriggerEvent('es:getPlayerFromId', source, function(user)

		TriggerClientEvent('FinishPoliceCheckForVeh',source)
		-- Spawn police vehicle
		TriggerClientEvent('policeveh:spawnVehicle', source, vehicle)
	--end)
end)

-----------------------------------------------------------------------
---------------------COMMANDE ADMIN AJOUT / SUPP COP-------------------
-----------------------------------------------------------------------
TriggerEvent('es:addGroupCommand', 'copadd', "admin", function(source, args, user)
	if(not args[2]) then
		TriggerClientEvent('chatMessage', source, 'GOUVERNEMENT', {255, 0, 0}, "Usage : /copadd [ID]")
	else
		if(GetPlayerName(tonumber(args[2])) ~= nil)then
			local player = tonumber(args[2])
			TriggerEvent("es:getPlayerFromId", player, function(target)
				addCop(target.getIdentifier())
				TriggerClientEvent('chatMessage', source, 'GOUVERNEMENT', {255, 0, 0}, "bien compris !")
				TriggerClientEvent("es_freeroam:notify", player, "CHAR_ANDREAS", 1, "GOUVERNEMENT", false, "félicitation vous êtes maintenant Policier~w~.")
				TriggerClientEvent('police:nowCop', player)
			end)
		else
			TriggerClientEvent('chatMessage', source, 'GOUVERNEMENT', {255, 0, 0}, "Pas de joueur avec cette ID")
		end
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, 'GOUVERNEMENT', {255, 0, 0}, "Permissions refusées")
end)

TriggerEvent('es:addGroupCommand', 'coprem', "admin", function(source, args, user)
	if(not args[2]) then
		TriggerClientEvent('chatMessage', source, 'GOUVERNEMENT', {255, 0, 0}, "Usage : /coprem [ID]")
	else
		if(GetPlayerName(tonumber(args[2])) ~= nil)then
			local player = tonumber(args[2])
			TriggerEvent("es:getPlayerFromId", player, function(target)
				remCop(target.getIdentifier())
				TriggerClientEvent("es_freeroam:notify", player, "CHAR_ANDREAS", 1, "GOUVERNEMENT", false, "Vous n'êtes plus Policier~w~.")
				TriggerClientEvent('chatMessage', source, 'GOUVERNEMENT', {255, 0, 0}, "Roger that !")
				--TriggerClientEvent('chatMessage', player, 'GOUVERNEMENT', {255, 0, 0}, "You're no longer a cop !")
				TriggerClientEvent('police:noLongerCop', player)
			end)
		else
			TriggerClientEvent('chatMessage', source, 'GOUVERNEMENT', {255, 0, 0}, "Pas de joueur avec cette ID")
		end
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, 'GOUVERNEMENT', {255, 0, 0}, "Permissions refusées")
end)

RegisterServerEvent('police:setService')
AddEventHandler('police:setService', function (inService)
	TriggerEvent('es:getPlayerFromId', source , function (Player)
		Player.setSessionVar('policeInService', inService)
	end)
end)
-----------------------------------------------------------------------
---------------------COMMANDE ADMIN PROCUREUR-------------------
-----------------------------------------------------------------------

-----------------------------------------------------------------------
---------------------COMMANDE ADMIN PROCUREUR-------------------
-----------------------------------------------------------------------
TriggerEvent('es:addGroupCommand', 'procureur', "admin", function(source, args, user)
	if(not args[2]) then
		TriggerClientEvent('chatMessage', source, 'GOUVERNEMENT', {255, 0, 0}, "Usage : /procureur [ID]")
	else
		if(GetPlayerName(tonumber(args[2])) ~= nil)then
			local player = tonumber(args[2])
			TriggerClientEvent('chatMessage', source, 'GOUVERNEMENT', {255, 0, 0}, "bien compris !")
			TriggerClientEvent("es_freeroam:notify", player, "CHAR_ANDREAS", 1, "GOUVERNEMENT", false, "felicitation vous etes maintenant Procureur~w~.")
			TriggerClientEvent('police:Procureur', player)
		else
			TriggerClientEvent('chatMessage', source, 'GOUVERNEMENT', {255, 0, 0}, "Pas de joueur avec cette ID")
		end
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, 'GOUVERNEMENT', {255, 0, 0}, "Permissions refusees")
end)