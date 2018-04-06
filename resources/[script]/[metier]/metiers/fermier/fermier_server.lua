RegisterServerEvent('fermier:Car')
AddEventHandler('fermier:Car', function()
	TriggerClientEvent('fermier:getCar',source)
end)

RegisterServerEvent('fermier:serverRequest')
AddEventHandler('fermier:serverRequest', function (typeRequest)
	local mysource=source
	TriggerEvent ('es:getPlayerFromId', mysource, function(user)
		local player = user.getIdentifier()

		if typeRequest == "GetBle" then
			MySQL.Async.fetchScalar("SELECT quantity FROM user_inventory WHERE item_id=10 AND user_id=@identifier", {['@identifier'] = player},
				function(qte)
					TriggerClientEvent('fermier:drawGetBle',mysource,qte)
				end)
		elseif typeRequest == "GetFarine" then
			MySQL.Async.fetchScalar("SELECT quantity FROM user_inventory WHERE item_id=10 AND user_id=@identifier", {['@identifier'] = player},
				function(qteBle)
					MySQL.Async.fetchScalar("SELECT quantity FROM user_inventory WHERE item_id=5 AND user_id=@identifier", {['@identifier'] = player},
						function(qteFarine)
							TriggerClientEvent('fermier:drawGetFarine',mysource,qteBle,qteFarine)
						end)
				end)

		elseif typeRequest == "SellFarine" then
			MySQL.Async.fetchScalar("SELECT quantity FROM user_inventory WHERE item_id=5 AND user_id=@identifier", {['@identifier'] = player},
				function(qte)
					TriggerClientEvent('fermier:drawSellFarine',mysource,qte)
				end)
		else
			print('DEBUG : Une erreur de type de requête à été détectée')
		end
	end)
end)

RegisterServerEvent('fermier:setService')
AddEventHandler('fermier:setService', function (inService)
	TriggerEvent('es:getPlayerFromId', source , function (Player)
		Player.setSessionVar('fermierInService', inService)
	end)
end)
