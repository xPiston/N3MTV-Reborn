--require "resources/mysql-async/lib/MySQL"

metiersList = {
	{name="chomeur", id=1},
	{name="police", id=2},
	{name="mineur", id=9},
	{name="bucheron", id=7},
	{name="fermier", id=6},
	{name="pecheur", id=10},
	--{name="docker", id=11},
	{name="brasseur", id=12},
	{name="vigneron", id=13},
	--{name="livreur", id=13},
	{name="ambulancier", id=15},
	{name="mecano", id=16},
	{name="taxi", id=17}
}

function MineGetPlayerJobID(playerId)
	return MySQL.Sync.fetchScalar("SELECT job FROM users WHERE identifier = @name", {['@name'] = playerId})
end

function MineGetPlayerJobName(JobId)
	return MySQL.Sync.fetchScalar("SELECT job_name FROM jobs WHERE job_id = @namejob", {['@namejob'] = JobId})
end

RegisterServerEvent('metiers:isChomeur')
AddEventHandler('metiers:isChomeur', function()
	local mysource = source
	TriggerEvent('es:getPlayerFromId', mysource, function(user)
		local playerJobID = MineGetPlayerJobID(user.getIdentifier())
		TriggerClientEvent('metiers:defineJobMenu', mysource, playerJobID)
	end)
end)

RegisterServerEvent('metiers:jobs')
AddEventHandler('metiers:jobs', function(id)
	local mysource = source
	TriggerEvent('es:getPlayerFromId', mysource, function(user)

		local playerJobID = MineGetPlayerJobID(user.getIdentifier())
		local playerJobName = MineGetPlayerJobName(playerJobID)
		local NewJobName = MineGetPlayerJobName(id)

		for _, item in pairs(metiersList) do
			if playerJobID == item.id then
				TriggerClientEvent(item.name..":deleteBlips", mysource)
			end
		end

		MySQL.Async.execute("UPDATE users SET `job`=@value WHERE identifier = @identifier", {['@value'] = id, ['@identifier'] = user.getIdentifier()})

		TriggerClientEvent("metiers:updateJob", mysource, NewJobName)

		for _, item in pairs(metiersList) do
			if id == item.id then
				TriggerClientEvent(item.name..":drawBlips", mysource)
				TriggerClientEvent(item.name..":drawMarker", mysource, true)
				TriggerClientEvent(item.name..":marker", mysource)
				--TriggerClientEvent(item.name..":getSkin", source)
			end
		end
		TriggerClientEvent("es_freeroam:notify", mysource, "CHAR_MP_STRIPCLUB_PR", 1, "Entreprise", false, "Votre métier est maintenant : ".. NewJobName..". Récuperez votre vehicule special a l'entreprise")
	end)
end)

AddEventHandler('es:playerLoaded', function(source)
	TriggerEvent('es:getPlayerFromId', source, function(user)
		local playerJobID = MineGetPlayerJobID(user.getIdentifier())
		local playerJobName = MineGetPlayerJobName(playerJobID)

		for _, item in pairs(metiersList) do
			if playerJobID == item.id then
				TriggerClientEvent(item.name..":drawBlips", source)
				TriggerClientEvent(item.name..":drawMarker", source, true)
				TriggerClientEvent(item.name..":marker", source)
			end
		end
		TriggerClientEvent("metiers:updateJob", source, playerJobName)
	end)
end)


-----------------------------------------------------------------------
---------------------COMMANDE ADMIN AJOUT / SUPP MECANO-------------------
-----------------------------------------------------------------------
TriggerEvent('es:addGroupCommand', 'mecadd', "admin", function(source, args, user)
	if(not args[2]) then
		TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "Usage : /mecadd [ID]")
	else
		if(GetPlayerName(tonumber(args[2])) ~= nil)then
			local player = tonumber(args[2])
			TriggerEvent("es:getPlayerFromId", player, function(target)
				TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "Roger that !")
				TriggerClientEvent("es_freeroam:notify", player, "CHAR_ANDREAS", 1, "Government", false, "Congrats, you're now a mecano !~w~.")
				TriggerClientEvent('metiers:getmyjob',player,16)
			end)
		else
			TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "No player with this ID !")
		end
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "You haven't the permission to do that !")
end)

TriggerEvent('es:addGroupCommand', 'mecrem', "admin", function(source, args, user)
	if(not args[2]) then
		TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "Usage : /mecrem [ID]")
	else
		if(GetPlayerName(tonumber(args[2])) ~= nil)then
			local player = tonumber(args[2])
			TriggerEvent("es:getPlayerFromId", player, function(target)
				TriggerClientEvent("es_freeroam:notify", player, "CHAR_ANDREAS", 1, "Government", false, "You're no longer a mecano !~w~.")
				TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "Roger that !")
				--TriggerClientEvent('chatMessage', player, 'GOVERNMENT', {255, 0, 0}, "You're no longer a cop !")
				TriggerClientEvent('metiers:getmyjob',player,1)
			end)
		else
			TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "No player with this ID !")
		end
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "You haven't the permission to do that !")
end)

-----------------------------------------------------------------------
---------------------COMMANDE ADMIN AJOUT / SUPP AMBULANCIER-------------------
-----------------------------------------------------------------------

TriggerEvent('es:addGroupCommand', 'ambadd', "admin", function(source, args, user)
	if(not args[2]) then
		TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "Usage : /ambadd [ID]")
	else
		if(GetPlayerName(tonumber(args[2])) ~= nil)then
			local player = tonumber(args[2])
			TriggerEvent("es:getPlayerFromId", player, function(target)
				TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "Roger that !")
				TriggerClientEvent("es_freeroam:notify", player, "CHAR_ANDREAS", 1, "Government", false, "Congrats, you're now a ambulancier !~w~.")
				TriggerClientEvent('metiers:getmyjob',player,15)
			end)
		else
			TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "No player with this ID !")
		end
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "You haven't the permission to do that !")
end)

TriggerEvent('es:addGroupCommand', 'ambrem', "admin", function(source, args, user)
	if(not args[2]) then
		TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "Usage : /ambrem [ID]")
	else
		if(GetPlayerName(tonumber(args[2])) ~= nil)then
			local player = tonumber(args[2])
			TriggerEvent("es:getPlayerFromId", player, function(target)
				TriggerClientEvent("es_freeroam:notify", player, "CHAR_ANDREAS", 1, "Government", false, "You're no longer a ambulancier !~w~.")
				TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "Roger that !")
				--TriggerClientEvent('chatMessage', player, 'GOVERNMENT', {255, 0, 0}, "You're no longer a cop !")
				TriggerClientEvent('metiers:getmyjob',player,1)
			end)
		else
			TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "No player with this ID !")
		end
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "You haven't the permission to do that !")
end)

-----------------------------------------------------------------------
---------------------COMMANDE ADMIN AJOUT / SUPP TAXI-------------------
-----------------------------------------------------------------------

TriggerEvent('es:addGroupCommand', 'taxadd', "admin", function(source, args, user)
	if(not args[2]) then
		TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "Usage : /taxadd [ID]")
	else
		if(GetPlayerName(tonumber(args[2])) ~= nil)then
			local player = tonumber(args[2])
			TriggerEvent("es:getPlayerFromId", player, function(target)
				TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "Roger that !")
				TriggerClientEvent("es_freeroam:notify", player, "CHAR_ANDREAS", 1, "Government", false, "Congrats, you're now a Taxi !~w~.")
				TriggerClientEvent('metiers:getmyjob',player,17)
			end)
		else
			TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "No player with this ID !")
		end
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "You haven't the permission to do that !")
end)

TriggerEvent('es:addGroupCommand', 'taxrem', "admin", function(source, args, user)
	if(not args[2]) then
		TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "Usage : /taxrem [ID]")
	else
		if(GetPlayerName(tonumber(args[2])) ~= nil)then
			local player = tonumber(args[2])
			TriggerEvent("es:getPlayerFromId", player, function(target)
				TriggerClientEvent("es_freeroam:notify", player, "CHAR_ANDREAS", 1, "Government", false, "You're no longer a Taxi !~w~.")
				TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "Roger that !")
				--TriggerClientEvent('chatMessage', player, 'GOVERNMENT', {255, 0, 0}, "You're no longer a cop !")
				TriggerClientEvent('metiers:getmyjob',player,1)
			end)
		else
			TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "No player with this ID !")
		end
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "You haven't the permission to do that !")
end)





	