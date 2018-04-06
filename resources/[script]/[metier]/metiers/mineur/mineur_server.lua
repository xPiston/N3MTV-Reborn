RegisterServerEvent('mineur:Car1')
AddEventHandler('mineur:Car1', function()
	TriggerClientEvent('mineur:getCar1',source)
end)

RegisterServerEvent('mineur:Car2')
AddEventHandler('mineur:Car2', function()
	TriggerClientEvent('mineur:getCar2',source)
end)

RegisterServerEvent('mineur:Car3')
AddEventHandler('mineur:Car3', function()
	TriggerClientEvent('mineur:getCar3',source)
end)

RegisterServerEvent('mineur:serverRequest')
AddEventHandler('mineur:serverRequest', function (typeRequest)
	local mysource=source
	TriggerEvent ('es:getPlayerFromId', mysource, function(user)
		local player = user.getIdentifier()

		if typeRequest == "GetMinerai" then

			MySQL.Async.fetchScalar("SELECT quantity FROM user_inventory WHERE item_id=1 AND user_id=@identifier", {['@identifier'] = player},
				function(qte)
					TriggerClientEvent('mineur:drawGetMinerai', mysource, qte)
				end)

		elseif typeRequest == "GetMetal" then

			MySQL.Async.fetchScalar("SELECT quantity FROM user_inventory WHERE item_id=1 AND user_id=@identifier", {['@identifier'] = player},
				function(qteMinerai)
					MySQL.Async.fetchScalar("SELECT quantity FROM user_inventory WHERE item_id=2 AND user_id=@identifier", {['@identifier'] = player},
						function(qteMetal)
							TriggerClientEvent('mineur:drawGetMetal', mysource, qteMinerai, qteMetal)
						end)
				end)

		elseif typeRequest == "SellMetal" then

			MySQL.Async.fetchScalar("SELECT quantity FROM user_inventory WHERE item_id=2 AND user_id=@identifier", {['@identifier'] = player},
				function(qte)
					TriggerClientEvent('mineur:drawSellMetal', mysource, qte)
				end)

		else
			print('DEBUG : Une erreur de type de requête à été détectée')
		end
	end)
end)

RegisterServerEvent('mineur:setService')
AddEventHandler('mineur:setService', function (inService)
	TriggerEvent('es:getPlayerFromId', source , function (Player)
		Player.setSessionVar('mineurInService', inService)
	end)
end)
