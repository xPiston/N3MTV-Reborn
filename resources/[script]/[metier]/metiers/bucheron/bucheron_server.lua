RegisterServerEvent('bucheron:Car')
AddEventHandler('bucheron:Car', function()
	TriggerClientEvent('bucheron:getCar',source)
end)

RegisterServerEvent('bucheron:serverRequest')
AddEventHandler('bucheron:serverRequest', function (typeRequest)
	local mysource = source
	TriggerEvent ('es:getPlayerFromId', mysource, function(user)
		local player = user.getIdentifier()

		if typeRequest == "GetBois" then
			MySQL.Async.fetchScalar("SELECT quantity FROM user_inventory WHERE item_id=19 AND user_id=@identifier", {['@identifier'] = player},
				function(result)
					TriggerClientEvent('bucheron:drawGetBois', mysource, result)
				end)
		elseif typeRequest == "GetPlanche" then
			MySQL.Async.fetchScalar("SELECT quantity FROM user_inventory WHERE item_id=19 AND user_id=@identifier", {['@identifier'] = player},
				function(qteBois)
					MySQL.Async.fetchScalar("SELECT quantity FROM user_inventory WHERE item_id=20 AND user_id=@identifier", {['@identifier'] = player},
						function(qtePlanche)
							TriggerClientEvent('bucheron:drawGetPlanche',mysource, qteBois, qtePlanche)
						end)
				end)
		elseif typeRequest == "SellPlanche" then
			MySQL.Async.fetchScalar("SELECT quantity FROM user_inventory WHERE item_id=20 AND user_id=@identifier", {['@identifier'] = player},
				function(qte)
					TriggerClientEvent('bucheron:drawSellPlanche', mysource, qte)
				end)
		else
			print('DEBUG : Une erreur de type de requête à été détectée')
		end

	end)
end)

RegisterServerEvent('bucheron:setService')
AddEventHandler('bucheron:setService', function (inService)
	TriggerEvent('es:getPlayerFromId', source , function (Player)
		Player.setSessionVar('bucheronInService', inService)
	end)
end)