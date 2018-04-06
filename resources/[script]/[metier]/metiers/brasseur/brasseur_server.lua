

RegisterServerEvent('brasseur:Car')
AddEventHandler('brasseur:Car', function()
	TriggerClientEvent('brasseur:getCar',source)
end)

RegisterServerEvent('brasseur:serverRequest')
AddEventHandler('brasseur:serverRequest', function (typeRequest)
	local mysource= source
	TriggerEvent ('es:getPlayerFromId', mysource, function(user)
		local player = user.getIdentifier()

		if typeRequest == "GetOrge" then
			MySQL.Async.fetchScalar("SELECT quantity FROM user_inventory WHERE item_id="..brasseur_ressourceBase.." AND user_id=@identifier", {['@identifier'] = player},
				function(qte)
					TriggerClientEvent('brasseur:drawGetOrge', mysource, qte)
				end)

		elseif typeRequest == "GetBiere" then
			MySQL.Async.fetchScalar("SELECT quantity FROM user_inventory WHERE item_id="..brasseur_ressourceBase.." AND user_id=@identifier", {['@identifier'] = player},
				function(resultBois)
					MySQL.Async.fetchScalar("SELECT quantity FROM user_inventory WHERE item_id="..brasseur_ressourceTraite.." AND user_id=@identifier", {['@identifier'] = player},
						function(resultPlanche)
							TriggerClientEvent('brasseur:drawGetBiere',mysource, resultBois, resultPlanche)
						end)
				end)

		elseif typeRequest == "SellBiere" then
			MySQL.Async.fetchScalar("SELECT quantity FROM user_inventory WHERE item_id="..brasseur_ressourceTraite.." AND user_id=@identifier", {['@identifier'] = player},
				function(resultBois)
					TriggerClientEvent('brasseur:drawSellBiere', mysource, resultBois)
				end)
		else
			print('DEBUG : Une erreur de type de requête à été détectée')
		end

	end)
end)

RegisterServerEvent('brasseur:setService')
AddEventHandler('brasseur:setService', function (inService)
	TriggerEvent('es:getPlayerFromId', source , function (Player)
		Player.setSessionVar('brasseurInService', inService)
	end)
end)
