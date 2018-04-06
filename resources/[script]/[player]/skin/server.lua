AddEventHandler("es:newPlayerLoaded", function(source, user)
	TriggerClientEvent('skin:openSkinCreator', source)
end)

RegisterServerEvent('skin:getOutfits')
AddEventHandler('skin:getOutfits', function(model)
	print('getOutfits' .. model)
	local mysource = source
	MySQL.Async.fetchAll("SELECT * FROM clothes_outfits WHERE category = 'skincreator' AND skin_model=@model", {['@model'] = model}, function(outfits)
		local outfitsList = {}
		if outfits[1] then
			for k,outfit in ipairs(outfits)do
				outfitsList[k] = outfit
			end
			TriggerClientEvent('skin:setOutfitList', mysource, outfitsList )
		end

	end)
end)

RegisterServerEvent('skin:saveOutfitForNewPlayer')
AddEventHandler('skin:saveOutfitForNewPlayer', function(current_skin)
	local mysource = source
	TriggerEvent('es:getPlayerFromId', mysource, function(user)
		MySQL.Async.execute("INSERT INTO skin (identifier, model, head, body_color, hair, hair_color, beard, beard_color, eyebrows, eyebrows_color) VALUES (@id, @a, @b, @c, @d, @e, @f, @g, @h, @i)",
			{
				['@id'] = user.getIdentifier(),
				['@a']  = current_skin.model,
				['@b']  = tonumber(current_skin.head) or 0,
				['@c']  = tonumber(current_skin.body_color) or 0,
				['@d']  = tonumber(current_skin.hair) or 0,
				['@e']  = tonumber(current_skin.hair_color) or 0,
				['@f']  = tonumber(current_skin.beard) or 0,
				['@g']  = tonumber(current_skin.beard_color) or 0,
				['@h']  = tonumber(current_skin.eyebrows) or 0,
				['@i']  = tonumber(current_skin.eyebrows_color) or 0,
			})
		MySQL.Async.execute("INSERT INTO clothes_users_outfits (identifier, current, outfit_id ) VALUES (@id, @b, @c)",
			{
				['@id'] = user.getIdentifier(),
				['@b']  = 1,
				['@c']  = current_skin.outfit_id
			})
		MySQL.Async.execute("UPDATE users SET `isFirstConnection`=0 WHERE identifier=@id", { ['@id'] = user.getIdentifier() })
		TriggerEvent('skin:firstSkinCreated', mysource)
	end)
end)

function getSkin(player, source)
	local mysource = source
	MySQL.Async.fetchAll("SELECT * FROM skin WHERE identifier = @username", {['@username'] = player}, function(skin)
		if(skin)then
			for k,v in ipairs(skin)do
				if v.head ~= nil then
					TriggerClientEvent("skin:setPlayerSkin", mysource, v)
				end
			end
		end
	end)
end

function getOutfit(player, source)
	local mysource = source
	MySQL.Async.fetchAll("SELECT * FROM clothes_users_outfits JOIN clothes_outfits ON `clothes_users_outfits`.`outfit_id` = `clothes_outfits`.`id` WHERE identifier = @username AND current= 1", {['@username'] = player},
	  function(outfits)
		if outfits~= nil and outfits[1]~= nil then
			for k,outfit in ipairs(outfits)do
								print(k .. ' -> ' .. json.encode(outfit))
				TriggerClientEvent("skin:setPlayerOutfit", mysource, outfit)
			end
		end
	end)
end

function getPlayerID(source)
	local identifiers = GetPlayerIdentifiers(source)
	local player = getIdentifiant(identifiers)
	return player
end

function getIdentifiant(id)
	for _, v in ipairs(id) do
		return v
	end
end

RegisterServerEvent("skin:reloadSkin")
AddEventHandler('skin:reloadSkin', function()
	local source = source
	local player = getPlayerID(source)
	getSkin(player, source)
end)


RegisterServerEvent('skin:getPlayerModel')
AddEventHandler('skin:getPlayerModel', function()
	print('CALL skin:getPlayerModelskin:getPlayerModelskin:getPlayerModelskin:getPlayerModel')
	local mysource = source
	local player = getPlayerID(source)
	local model = MySQL.Sync.fetchScalar("SELECT model FROM skin WHERE identifier = @username", {['@username'] = player})
	if model~= nil then
		TriggerClientEvent('skin:getPlayerModelFromDb', mysource, model)
	else
		TriggerClientEvent('skin:getPlayerModelFromDb', mysource,  "mp_m_freemode_01")
	end
end)

RegisterServerEvent('skin:firstSpawn')
AddEventHandler('skin:firstSpawn', function()
	local source = source
	local player = getPlayerID(source)
	getSkin(player, source)
	getOutfit(player, source)
end)

RegisterServerEvent("skin:loadSkinAndPosition")
AddEventHandler("skin:loadSkinAndPosition", function()
	local source = source
	local player = getPlayerID(source)
	getSkin(player, source)
	getOutfit(player, source)
	getProps(player, source)
end)

RegisterServerEvent("skin_customization:SpawnPlayer")
AddEventHandler("skin_customization:SpawnPlayer", function()
	local source = source
	local player = getPlayerID(source)
	getSkin(player, source)
	getOutfit(player, source)
	getProps(player, source)
end)

function getProps(player, source)
	local mysource = source
	MySQL.Async.fetchAll("SELECT clothes_props.*, clothes_users_props.prop_txt FROM clothes_users_props JOIN clothes_props ON `clothes_users_props`.`prop_id` = `clothes_props`.`id` WHERE `clothes_users_props`.`identifier` = @username AND current= 1", {['@username'] = player}, function(props)
		if props~= nil and props[1]~= nil then
			for k,prop in ipairs(props) do
				TriggerClientEvent("skin:setPlayerProps", mysource, prop)
			end
		end
	end)
end
