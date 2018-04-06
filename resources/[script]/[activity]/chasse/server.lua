RegisterServerEvent('chasse:serverRequest')
AddEventHandler('chasse:serverRequest', function (typeRequest)
	local mysource = source
	TriggerEvent ('es:getPlayerFromId', mysource, function(user)
		local player = user.getIdentifier()
		if typeRequest == "SellViande" then
			MySQL.Async.fetchAll("SELECT quantity FROM user_inventory WHERE item_id=23 AND user_id=@identifier", {['@identifier'] = player}, function(result)
				local qte
				for _, v in ipairs(result) do
					qte = v.quantity
				end
				TriggerClientEvent('chasse:drawSellViande',mysource,qte)
			end)
		end
	end)
end)

