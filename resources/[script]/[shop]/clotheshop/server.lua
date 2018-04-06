--
-- Created by IntelliJ IDEA.
-- User: Djyss
-- Date: 22/05/2017
-- Time: 07:59
-- To change this template use File | Settings | File Templates.
--
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

RegisterServerEvent("clotheshop:getModelAndList")
AddEventHandler("clotheshop:getModelAndList", function()
    local pedSource = source
    MySQL.Async.fetchAll("SELECT * FROM skin WHERE identifier = @id", {['@id'] = getPlayerID(pedSource)},
      function(model)
	    if model and model[1] then
	        TriggerEvent('clotheshop:getOutfits',           { source = pedSource, model = model[1].model })
	        TriggerEvent('clotheshop:getHats',              { source = pedSource, model = model[1].model })
	        TriggerEvent('clotheshop:getGlasses',           { source = pedSource, model = model[1].model })
	        TriggerEvent('clotheshop:getDressing',          { source = pedSource, identifier = model[1].identifier})
	        TriggerEvent('clotheshop:getDressingGlasses',   { source = pedSource, identifier = model[1].identifier})
	        TriggerEvent('clotheshop:getDressingHats',   { source = pedSource, identifier = model[1].identifier})
	    else
	        return false
	    end
      end)
end)

RegisterServerEvent('clotheshop:getOutfits')
AddEventHandler('clotheshop:getOutfits', function(arg)
	MySQL.Async.fetchAll("SELECT * FROM clothes_outfits WHERE skin_model=@model", {['@model'] = arg.model},
      function(outfits)
		local outfitsList = {}
	    if outfits and outfits[1] then
	        for k,outfit in ipairs(outfits)do
	            outfitsList[k] = outfit
	        end
	        TriggerClientEvent('clotheshop:setOutfitList', arg.source, outfitsList )
	    end
      end)
end)

RegisterServerEvent('clotheshop:getDressing')
AddEventHandler('clotheshop:getDressing', function(arg)
    MySQL.Async.fetchAll("SELECT * FROM clothes_users_outfits JOIN clothes_outfits ON `clothes_users_outfits`.`outfit_id` = `clothes_outfits`.`id` WHERE identifier = @username", {['@username'] = arg.identifier},
      function(outfits)
	    local dressingList = {}
	    if outfits and outfits[1] then
	        for k,outfit in ipairs(outfits)do
	            dressingList[k] = outfit
	        end
	        TriggerClientEvent('clotheshop:setDressingList', arg.source, dressingList )
	    end
      end)
end)

RegisterServerEvent('clotheshop:getDressingGlasses')
AddEventHandler('clotheshop:getDressingGlasses', function(arg)
    MySQL.Async.fetchAll("SELECT clothes_props.*, clothes_users_props.prop_txt FROM clothes_users_props JOIN clothes_props ON `clothes_users_props`.`prop_id` = `clothes_props`.`id` WHERE identifier = @username AND `clothes_users_props`.`category`='glasses'", {['@username'] = arg.identifier},
      function(props)
	    local dressingGlassesList = {}
	    if props and props[1] then
	        for k,prop in ipairs(props)do
	            dressingGlassesList[k] = prop
	        end
	        TriggerClientEvent('clotheshop:setDressingGlassesList', arg.source, dressingGlassesList )
	    end
      end)
end)
RegisterServerEvent('clotheshop:getDressingHats')
AddEventHandler('clotheshop:getDressingHats', function(arg)
    MySQL.Async.fetchAll("SELECT clothes_props.*, clothes_users_props.prop_txt FROM clothes_users_props JOIN clothes_props ON `clothes_users_props`.`prop_id` = `clothes_props`.`id` WHERE identifier = @username AND `clothes_users_props`.`category`='hat'", {['@username'] = arg.identifier},
      function(props)
	    if props and props[1] then
		    local dressingHatList = {}
	        for k,prop in ipairs(props)do
	            dressingHatList[k] = prop
	        end
	        TriggerClientEvent('clotheshop:setDressingHatsList', arg.source, dressingHatList )
	    end
      end)
end)
RegisterServerEvent('clotheshop:getHats')
AddEventHandler('clotheshop:getHats', function(arg)
    MySQL.Async.fetchAll("SELECT * FROM clothes_props WHERE model=@model AND category='hat'", {['@model'] = arg.model},
      function(props)
	    if props and props[1] then
		    local propsList = {}
	        for k,prop in ipairs(props)do
	            propsList[k] = prop
	        end
	        TriggerClientEvent('clotheshop:setHatsList', arg.source, propsList )
	    end
      end)
end)

RegisterServerEvent('clotheshop:getGlasses')
AddEventHandler('clotheshop:getGlasses', function(arg)
    MySQL.Async.fetchAll("SELECT * FROM clothes_props WHERE model=@model AND category='glasses'", {['@model'] = arg.model},
      function(props)
	    local propsList = {}
	    if props and props[1] then
	        for k,prop in ipairs(props)do
	            propsList[k] = prop
	        end
	        TriggerClientEvent('clotheshop:setGlassesList', arg.source, propsList )
	    end
      end)
end)

RegisterServerEvent('clotheshop:buyOutfit')
AddEventHandler('clotheshop:buyOutfit', function(outfit)
	local mysource = source
    if not checkOutfit(mysource, outfit.id) then
        TriggerEvent('es:getPlayerFromId', mysource, function(user)
            if tonumber(user.getMoney()) >= tonumber(outfit.price) and tonumber(user.getMoney()) > 0 then
                MySQL.Async.execute("UPDATE clothes_users_outfits SET `current`=0 WHERE identifier=@id",
                    {['@id']     = user.getIdentifier()})
                MySQL.Async.execute("INSERT INTO clothes_users_outfits ( outfit_id, identifier, current ) VALUES ( @outfit, @id, 1)", {
                    ['@outfit'] = outfit.id,
                    ['@id'] = user.getIdentifier()
                })
                user.removeMoney(outfit.price)
                TriggerEvent('clotheshop:getDressing', {identifier = user.getIdentifier(), source = mysource})
                TriggerClientEvent('clotheshop:notifs', mysource, "Vous venez de payer ~y~"..outfit.price.." pour cet article"  )
                TriggerClientEvent('clotheshop:notifs', mysource, "Cet article à été enregistré dans votre garde robe !"  )
            else
                TriggerClientEvent('clotheshop:notifs', mysource, "Vous n'avez pas assez d'argent en poche"  )
            end
        end)
    end
end)

RegisterServerEvent('clotheshop:buyProp')
AddEventHandler('clotheshop:buyProp', function(prop)
    local source = source
    if not checkProp(source, prop.id) then
        TriggerEvent('es:getPlayerFromId', source, function(user)
            if tonumber(user.getMoney()) >= tonumber(prop.price) and tonumber(user.getMoney()) > 0 then
                MySQL.Async.execute("UPDATE clothes_users_props SET `current`=0 WHERE identifier=@id AND category=@category",
                    {
                        ['@id']         = user.getIdentifier(),
                        ['@category']   = prop.category
                    })
                MySQL.Async.execute("INSERT INTO clothes_users_props ( prop_id, identifier, current, category ) VALUES ( @prop, @id, 1, @category)", {
                    ['@prop']       = prop.id,
                    ['@id']         = user.getIdentifier(),
                    ['@category']   = prop.category
                })
                user.removeMoney(prop.price)
                TriggerEvent('clotheshop:getDressingGlasses', {identifier = user.getIdentifier(), source = source})
                TriggerEvent('clotheshop:getDressingHats', {identifier = user.getIdentifier(), source = source})
                TriggerClientEvent('clotheshop:notifs', source, "Vous venez de payer ~y~"..prop.price.." pour cet article"  )
                TriggerClientEvent('clotheshop:notifs', source, "Cet article à été enregistré dans votre garde robe !"  )
            else
                TriggerClientEvent('clotheshop:notifs', source, "Vous n'avez pas assez d'argent en poche"  )
            end
        end)
    end
end)



RegisterServerEvent('clotheshop:wearOutfit')
AddEventHandler('clotheshop:wearOutfit', function(outfit)
	local mysource= source
    MySQL.Async.execute("UPDATE clothes_users_outfits SET `current`=0 WHERE identifier=@id",
        {
            ['@id']     = getPlayerID(mysource)
        })
    MySQL.Async.execute("UPDATE clothes_users_outfits SET `current`=1 WHERE identifier=@id AND outfit_id=@outfit_id",
        {
            ['@id']     = getPlayerID(mysource),
            ['@outfit_id'] = tonumber(outfit.id)
        })
    TriggerClientEvent('clotheshop:notifs', mysource, "Vous avez changé de tenue !"  )
end)

RegisterServerEvent('clotheshop:wearGlassesProp')
AddEventHandler('clotheshop:wearGlassesProp', function(prop)
	local mysource= source
    MySQL.Async.execute("UPDATE clothes_users_props SET `current`=0 WHERE identifier=@id AND category='glasses'",
        {
            ['@id']     = getPlayerID(mysource)
        })
    MySQL.Async.execute("UPDATE clothes_users_props SET `current`=1 WHERE identifier=@id AND prop_id=@prop_id",
        {
            ['@id']     = getPlayerID(mysource),
            ['@prop_id'] = tonumber(prop.id)
        })
    TriggerClientEvent('clotheshop:notifs', mysource, "Vous avez changé de tenue !"  )
end)

RegisterServerEvent('clotheshop:wearHatProp')
AddEventHandler('clotheshop:wearHatProp', function(prop)
	local mysource= source
    MySQL.Async.execute("UPDATE clothes_users_props SET `current`=0 WHERE identifier=@id AND category='hat'",
        {
            ['@id']     = getPlayerID(mysource)
        })
    MySQL.Async.execute("UPDATE clothes_users_props SET `current`=1 WHERE identifier=@id AND prop_id=@prop_id",
        {
            ['@id']     = getPlayerID(mysource),
            ['@prop_id'] = tonumber(prop.id)
        })
    TriggerClientEvent('clotheshop:notifs', mysource, "Vous avez changé de tenue !"  )
end)

function checkOutfit(source, outfit)
    local user_outfit = MySQL.Sync.fetchScalar("SELECT outfit_id FROM clothes_users_outfits WHERE outfit_id=@outfit AND identifier=@id", {['@outfit'] = outfit, ['@id'] =  getPlayerID(source)})
    if user_outfit ~= nil then
        TriggerClientEvent('clotheshop:notifs', source, "Vous possédez déjà cette article" )
        return true
    end
    return false
end

function checkProp(source, prop)
    local user_prop = MySQL.Sync.fetchScalar("SELECT prop_id FROM clothes_users_props WHERE prop_id=@prop AND identifier=@id", {['@prop'] = prop, ['@id'] =  getPlayerID(source)})
    if user_prop ~= nil then
        TriggerClientEvent('clotheshop:notifs', source, "Vous possédez déjà cette article" )
        return true
    end
    return false
end