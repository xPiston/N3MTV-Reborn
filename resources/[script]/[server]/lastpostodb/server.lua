--Version 1.3

--Intégration de la position dans MySQL
RegisterServerEvent("project:savelastpos")
AddEventHandler("project:savelastpos", function( LastPosX , LastPosY , LastPosZ , LastPosH )
	local mysource=source
	TriggerEvent('es:getPlayerFromId', mysource, function(user)
		--Récupération du SteamID.
		local player = user.getIdentifier()
		--Formatage des données en JSON pour intégration dans MySQL.
		local lastPosition = "{" .. LastPosX .. ", " .. LastPosY .. ",  " .. LastPosZ .. ", " .. LastPosH .. "}"
		--Exécution de la requêtes SQL.
		MySQL.Async.execute("UPDATE users SET `lastPosition`=@lastPosition WHERE identifier = @username", {['@username'] = player, ['@lastPosition'] = lastPosition})
		--Affichage d'un message confirmant la sauvegarde de la position du joueurs.
		TriggerClientEvent("project:notify", mysource, "Position Sauvegardée")
	end)
end)


--Récupération de la position depuis MySQL
RegisterServerEvent("project:SpawnPlayer")
AddEventHandler("project:SpawnPlayer", function()
	local mysource=source
	TriggerEvent('es:getPlayerFromId', mysource, function(user)
		--Récupération du SteamID.
		local player = user.getIdentifier()
		--Exécution de la requêtes SQL.
		MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @username", {['@username'] = player}, function(result)
			-- Vérification de la présence d'un résultat avant de lancer le traitement.
			if(result)then
				for k,v in ipairs(result)do
					if v.lastPosition ~= "" then
						-- Décodage des données récupérées
						local ToSpawnPos = json.decode(v.lastPosition)
						-- Intégration des données dans les variables dédiées
						local PosX = ToSpawnPos[1]
						local PosY = ToSpawnPos[2]
						local PosZ = ToSpawnPos[3]
						local PosH = ToSpawnPos[4]
						-- On envoie la derniere position vers le client pour le spawn
						TriggerClientEvent("project:spawnlaspos", mysource, PosX, PosY, PosZ)
					end
				end
			end
		end)
	end)
end)