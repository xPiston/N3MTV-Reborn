RegisterServerEvent('pecheur:Car')
AddEventHandler('pecheur:Car', function()
	TriggerClientEvent('pecheur:getCar',source)
end)

RegisterServerEvent('pecheur:Car2')
AddEventHandler('pecheur:Car2', function()
	TriggerClientEvent('pecheur:getCar2',source)
end)

RegisterServerEvent('pecheur:serverRequest')
AddEventHandler('pecheur:serverRequest', function (typeRequest)
	local mysource=source
	TriggerEvent ('es:getPlayerFromId', mysource, function(user)
		local player = user.getIdentifier()

		if typeRequest == "GetPoisson" then

			MySQL.Async.fetchScalar("SELECT quantity FROM user_inventory WHERE item_id=21 AND user_id=@identifier", {['@identifier'] = player},
				function(qte)
					TriggerClientEvent('pecheur:drawGetPoisson',mysource,qte)
				end)

		elseif typeRequest == "GetFilet" then

			MySQL.Async.fetchScalar("SELECT quantity FROM user_inventory WHERE item_id=21 AND user_id=@identifier", {['@identifier'] = player},
				function(qteBois)
					MySQL.Async.fetchScalar("SELECT quantity FROM user_inventory WHERE item_id=22 AND user_id=@identifier", {['@identifier'] = player},
						function(qtePlanche)
							TriggerClientEvent('pecheur:drawGetFilet',mysource,qteBois, qtePlanche)
						end)
				end)

		elseif typeRequest == "SellFilet" then

			MySQL.Async.fetchScalar("SELECT quantity FROM user_inventory WHERE item_id=22 AND user_id=@identifier", {['@identifier'] = player},
				function(qte)
					TriggerClientEvent('pecheur:drawSellFilet',mysource,qte)
				end)
		else
			print('DEBUG : Une erreur de type de requête à été détectée')
		end

	end)
end)


RegisterServerEvent('pecheur:setService')
AddEventHandler('pecheur:setService', function (inService)
	TriggerEvent('es:getPlayerFromId', source , function (Player)
		Player.setSessionVar('pecheurInService', inService)
	end)
end)
