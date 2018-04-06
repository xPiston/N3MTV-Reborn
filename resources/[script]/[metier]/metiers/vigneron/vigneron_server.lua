RegisterServerEvent('vigneron:Car')
AddEventHandler('vigneron:Car', function()
	TriggerClientEvent('vigneron:getCar',source)
end)

RegisterServerEvent('vigneron:serverRequest')
AddEventHandler('vigneron:serverRequest', function (typeRequest)
	local mysource = source
	TriggerEvent ('es:getPlayerFromId', mysource, function(user)
		local player = user.getIdentifier()

		if typeRequest == "GetRaisin" then
			MySQL.Async.fetchScalar("SELECT quantity FROM user_inventory WHERE item_id="..vigneron_ressourceBase.." AND user_id=@identifier", {['@identifier'] = player},
				function(qte)
					TriggerClientEvent('vigneron:drawGetRaisin', mysource, qte)
				end)

		elseif typeRequest == "GetVin" then
			MySQL.Async.fetchScalar("SELECT quantity FROM user_inventory WHERE item_id="..vigneron_ressourceBase.." AND user_id=@identifier", {['@identifier'] = player},
				function(qteVign)

					MySQL.Async.fetchScalar("SELECT quantity FROM user_inventory WHERE item_id="..vigneron_ressourceTraite.." AND user_id=@identifier", {['@identifier'] = player},
						function(qteTraite)
							TriggerClientEvent('vigneron:drawGetVin',mysource, qteVign, qteTraite)
						end)
				end)

		elseif typeRequest == "SellVin" then
			MySQL.Async.fetchScalar("SELECT quantity FROM user_inventory WHERE item_id="..vigneron_ressourceTraite.." AND user_id=@identifier", {['@identifier'] = player},
				function(qte)
					TriggerClientEvent('vigneron:drawSellVin', mysource, qte)
				end)
		else
			print('DEBUG : Une erreur de type de requête à été détectée')
		end

	end)
end)


RegisterServerEvent('vigneron:setService')
AddEventHandler('vigneron:setService', function (inService)
	TriggerEvent('es:getPlayerFromId', source , function (Player)
		Player.setSessionVar('vigneronInService', inService)
	end)
end)
