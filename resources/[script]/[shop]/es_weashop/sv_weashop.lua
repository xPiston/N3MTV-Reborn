--fonction pour identifier
function getIdentifiant(id)

	for _, v in ipairs(id) do
	    return v
	end

end


-- Loading MySQL Class

local max_number_weapons = 6 --maximum number of weapons that the player can buy. Weapons given at spawn doesn't count.
local cost_ratio = 100 --Ratio for withdrawing the weapons. This is price/cost_ratio = cost.

RegisterServerEvent('CheckMoneyForWea')
AddEventHandler('CheckMoneyForWea', function(weapon,price)
	local mySource = source
	TriggerEvent('es:getPlayerFromId', mySource, function(user)

		if (tonumber(user.getDirtyMoney()) >= tonumber(price)) then
			local player = user.getIdentifier()
			local nb_weapon = 0
			MySQL.Async.fetchAll("SELECT * FROM user_weapons WHERE identifier = @username",{['@username'] = player}, function (result)
				if result then
					for k,v in ipairs(result) do
						nb_weapon = nb_weapon + 1
					end
				end
				if (tonumber(max_number_weapons) > tonumber(nb_weapon)) then
					-- Pay the shop (price)
					user.removeDirtyMoney((price))
					MySQL.Async.execute("INSERT INTO user_weapons (identifier,weapon_model,withdraw_cost) VALUES (@username,@weapon,@cost)",
						{['@username'] = player, ['@weapon'] = weapon, ['@cost'] = (price)/cost_ratio})
					-- Trigger some client stuff
					TriggerClientEvent('FinishMoneyCheckForWea',mySource)
					TriggerClientEvent("es_freeroam:notify", mySource, "CHAR_MP_ROBERTO", 1, "Gangsta", false, "Amuse toi bien avec ces joujous!\n")
				else
					TriggerClientEvent('ToManyWeapons',mySource)
					TriggerClientEvent("es_freeroam:notify", mySource, "CHAR_MP_ROBERTO", 1, "Gangsta", false, "Tu as atteint la limite d armes ! (max: "..max_number_weapons..")\n")
				end
			end)
		else
			-- Inform the player that he needs more money
			TriggerClientEvent("es_freeroam:notify", mySource, "CHAR_MP_ROBERTO", 1, "Gangsta", false, "Reviens quand tu auras plus d'argent !\n")
		end
	end)
end)

RegisterServerEvent("weaponshop:playerSpawned")
AddEventHandler("weaponshop:playerSpawned", function(spawn)
	local mySource = source
	TriggerEvent('es:getPlayerFromId', mySource, function(user)
		TriggerEvent('weaponshop:GiveWeaponsToPlayer', mySource)
	end)
end)

RegisterServerEvent("weaponshop:GiveWeaponsToPlayer")
AddEventHandler("weaponshop:GiveWeaponsToPlayer", function(player)
	TriggerEvent('es:getPlayerFromId', player, function(user)
		local playerID = user.getIdentifier()
		local delay = nil

		MySQL.Async.fetchAll("SELECT * FROM user_weapons WHERE identifier = @username",{['@username'] = playerID}, function (result)
			delay = 2000
			if(result)then
				for k,v in ipairs(result) do
					TriggerClientEvent("giveWeapon", player, v.weapon_model, delay)
				end
			end
		end)
	end)
end)

RegisterServerEvent("weaponshop:RemoveWeaponsToPlayer")
AddEventHandler("weaponshop:RemoveWeaponsToPlayer", function()
	local identifiers = GetPlayerIdentifiers(source)
	local perso = getIdentifiant(identifiers)
	MySQL.Async.execute("DELETE FROM user_weapons WHERE identifier = @username",{['@username'] = perso})
end)

RegisterServerEvent("weaponshop:RemoveWeaponsToPlayerFouille")
AddEventHandler("weaponshop:RemoveWeaponsToPlayerFouille", function(target)
		local identifiers = GetPlayerIdentifiers(target)
		local perso = getIdentifiant(identifiers)
		MySQL.Sync.execute("DELETE FROM user_weapons WHERE identifier = @identifier and weapon_model not like 'WEAPON_SNSPISTOL'",{['@identifier'] = perso})
		TriggerClientEvent('weaponshop:removeall',target)
		TriggerEvent('weaponshop:GiveWeaponsToPlayer',target)
end)
