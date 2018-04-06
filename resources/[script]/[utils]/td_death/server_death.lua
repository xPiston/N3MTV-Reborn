
function getIdentifiant(id)

	for _, v in ipairs(id) do
	    return v
	end

end

RegisterServerEvent('td_health:spawn')
AddEventHandler('td_health:spawn', function()


	local identifiers = GetPlayerIdentifiers(source)
	local perso = getIdentifiant(identifiers)
	local varsrc = source

	local varsrc = source
	print("============================ Health GET ")
	MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @name", {['@name'] = perso, ['@nb'] = tonumber(nb)}, function (result)

		if result[1].health == nil then
			print("le joueur nexiste pas")
		else		
				
				print("Le personnage " .. result[1].prenom .. " " .. result[1].nom .. " a actuellement " .. result[1].health .. " points de vie")
				local resultat = tonumber(result[1].health)
				
				TriggerClientEvent('td_health:setHealth', varsrc, resultat)
		end
	end)		
end)

--[[RegisterServerEvent('td_health:update')
AddEventHandler("td_health:update", function(health)
	local identifiers = GetPlayerIdentifiers(source)
	local perso = getIdentifiant(identifiers)
	local src = source
	
	TriggerEvent("es:getPlayerFromId", source, function(player)
		MySQL.Sync.execute("UPDATE users SET health=@health WHERE identifier = @username", { ['@health'] = health, ['@username'] = perso})
	end)
end)--]]

RegisterServerEvent('td_health:update')
AddEventHandler("td_health:update", function(health)
	local identifiers = GetPlayerIdentifiers(source)
	local perso = getIdentifiant(identifiers)
	local src = source
	if health == 0 then
		print(" =========================================== TDLC ======================== td_death ============ Mort du joueur " .. perso .. " a " .. health .. " point de vie")
	else
		print("Mise a jour de la vie du joueur " .. perso .. " a " .. health .. " points de vie")
	end
	MySQL.Sync.execute("UPDATE users SET health=@health WHERE identifier = @username", { ['@health'] = health, ['@username'] = perso})
end)