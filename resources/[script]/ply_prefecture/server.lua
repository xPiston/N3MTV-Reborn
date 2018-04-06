--[[Info]]--

-- require "resources/mysql-async/lib/MySQL"
-- require "resources/mysql-async/lib/EssentialModeApi"

--[[Register]]--

RegisterServerEvent("ply_prefecture:GetLicences")
RegisterServerEvent("ply_prefecture:CheckForVeh")
RegisterServerEvent("ply_prefecture:CheckForLicences")
RegisterServerEvent("ply_prefecture:SetLicenceForVeh")
RegisterServerEvent("ply_prefecture:Lang")
RegisterServerEvent("ply_prefecture:CanBuyLicense")



--[[Function]]--

function getPlayerID(source)
	return getIdentifiant(GetPlayerIdentifiers(source))
end

function getIdentifiant(id)
	for _, v in ipairs(id) do
		return v
	end
end

function licence(licID)
	print(source)
	return MySQL.Sync.fetchScalar("SELECT licence_id FROM user_license WHERE identifier=@identifier AND licence_id=@licID",{['@identifier'] = getPlayerID(source), ['@licID'] = licID})
end

function price(licID)
	return MySQL.Sync.fetchScalar("SELECT price FROM licences WHERE id=@licID",{['@licID'] = licID})
end

function checkForVeh()
	return MySQL.Sync.fetchScalar("SELECT personalvehicle FROM users WHERE identifier=@identifier", {['@identifier'] = getPlayerID(source)})
end

--[[Local/Global]]--

local licences = {}



--[[Events]]--
AddEventHandler("ply_prefecture:GetLicences", function()
	local source = source
	licences = {}
	MySQL.Async.fetchAll("SELECT * FROM licences",{}, function(data)
	for _, v in ipairs(data) do
		t = { ["name"] = v.name, ["price"] = v.price, ["id"] = v.id }
		table.insert(licences, tonumber(v.id), t)
	end
	TriggerClientEvent("ply_prefecture:GetLicences", source, licences)
	end)
end)

AddEventHandler('ply_prefecture:CheckForLicences', function(licID)
	local source = source
	print("===================================== " .. licID .. " sources : " .. source )
	if licence(licID) then
		TriggerClientEvent("ply_prefecture:LicenseFalse", source)
		print("===================================== IF " .. licID .. " DANS LE CODE sources : " .. source )
	else
		TriggerEvent('es:getPlayerFromId', source, function(user)
		print("===================================== ELSE " .. licID .. " DANS LE CODE sources : " .. source )
			user.removeMoney((price(licID)))
			MySQL.Sync.execute("UPDATE users SET DmvTest='hasLicense' WHERE identifier = @username", { ['@username'] = getPlayerID(source)})
			user.log('Bye permis drive')
		end)
		print("===================================== ELSE ==================== AVANT UPDATE hasLicense " .. licID .. " DANS LE sources : " .. source .. " PID " .. getPlayerID(source) )
		--MySQL.Async.execute("UPDATE users SET DmvTest='hasLicense' WHERE identifier = '@identifier'",{['@identifier'] = getPlayerID(source)})
		print("=====================================  HAS LICENSE MODIFI2  : " .. getPlayerID(source) .. " sources : " .. source )
		MySQL.Async.execute("INSERT INTO user_license (identifier,licence_id) VALUES (@identifier,@licID)",{['@identifier'] = getPlayerID(source), ['@licID'] = licID}, function(data)
		end)
		TriggerClientEvent("ply_prefecture:LicenseTrue", source)
		TriggerClientEvent("dmv:haveMyLicense", source)
	end
end)

AddEventHandler('ply_prefecture:CheckForVeh', function()
		local source = source
	TriggerClientEvent('ply_prefecture:CheckForRealVeh', source, checkForVeh())
end)

AddEventHandler('ply_prefecture:SetLicenceForVeh', function(name, brutmodel, plate)
	local source = source
	local model = brutmodel
	MySQL.Async.fetchAll("SELECT * FROM vehicles WHERE model=@model", {['@model'] = model}, function(data)
		MySQL.Async.execute("INSERT INTO user_vehicle (identifier,vehicle_name,vehicle_model,vehicle_price,vehicle_plate,vehicle_state) VALUES (@username,@name,@vehicle,@price,@plate,@state)",
			{['@username'] = getPlayerID(source), ['@name'] = data[1].name, ['@vehicle'] = model, ['@price'] = data[1].price, ['@plate'] = plate, ['@state'] = "Out"}, function(data)
		end)
		MySQL.Async.execute("UPDATE users SET personalvehicle=@state WHERE identifier=@identifier", {['@identifier'] = getPlayerID(source),['@state'] = "vide"}, function(data)
		end)
		TriggerClientEvent("ply_prefecture:VehRegistered", source)
	end)
end)


AddEventHandler("ply_prefecture:CanBuyLicense", function()
		local source = source
	TriggerClientEvent("ply_prefecture:CanPurchase", source)
end)