RegisterServerEvent("item:getItems")
RegisterServerEvent("item:updateQuantity")
RegisterServerEvent("item:setItem")
RegisterServerEvent("item:reset")
RegisterServerEvent("item:sell")
RegisterServerEvent("item:sellsale")
RegisterServerEvent("player:giveItem")
RegisterServerEvent("player:useItem")

local items = {}

AddEventHandler("item:getItems", function()
    local mysource = source
    items = {}
    local player = getPlayerID(mysource)
    MySQL.Async.fetchAll("SELECT * FROM user_inventory JOIN items ON `user_inventory`.`item_id` = `items`.`id` WHERE user_id = @username", { ['@username'] = player }, function(result)
        if (result) then
            for _, v in ipairs(result) do
                t = { ["quantity"] = v.quantity, ["libelle"] = v.libelle }
                -- table.insert(items, tonumber(v.item_id), t)
                items[v.item_id] = t
            end
        end
        TriggerClientEvent("gui:getItems", mysource, items)
    end)
end)

AddEventHandler("item:setItem", function(item, quantity)
    local player = getPlayerID(source)
    MySQL.Async.fetchAll("SELECT * FROM user_inventory WHERE user_id = @username AND item_id = @item", {['@username'] = player, ['@item'] = item}, function(result)
        if(result[1] ~= nil) then
             MySQL.Async.execute("UPDATE user_inventory SET `quantity` = @qty WHERE `user_id` = @username AND `item_id` = @item",
            { ['@username'] = player, ['@item'] = item, ['@qty'] = quantity})
        else
            MySQL.Async.execute("INSERT INTO user_inventory (`user_id`, `item_id`, `quantity`) VALUES (@player, @item, @qty)",
            { ['@player'] = player, ['@item'] = item, ['@qty'] = quantity })
        end   
    end)
 
end)

AddEventHandler("item:updateQuantity", function(qty, id)
    local player = getPlayerID(source)
    MySQL.Sync.execute("UPDATE user_inventory SET `quantity` = @qty WHERE `user_id` = @username AND `item_id` = @id", { ['@username'] = player, ['@qty'] = tonumber(qty), ['@id'] = tonumber(id) })
    
end)

AddEventHandler("item:reset", function()
    local mysource = source
    local player = getPlayerID(mysource)
    TriggerEvent('es:getPlayerFromId', mysource, function(user)
        local player = user.getIdentifier()
        MySQL.Async.execute("UPDATE user_inventory SET `quantity` = @qty WHERE `user_id` = @username", { ['@username'] = player, ['@qty'] = 0 })
        user.setMoney(0)
        user.setDirtyMoney(0)
        user.log('vdk RESET')
        TriggerEvent('player_state:change',mysource,50 , 50 , 50)
    end)
end)

AddEventHandler("item:sell", function(id, qty, price)
    local mysource = source
    TriggerEvent('es:getPlayerFromId', mysource, function(user)
        local player = user.getIdentifier()
        MySQL.Async.execute("UPDATE user_inventory SET `quantity` = @qty WHERE `user_id` = @username AND `item_id` = @id", { ['@username'] = player, ['@qty'] = tonumber(qty), ['@id'] = tonumber(id) })
        user.addMoney(tonumber(price))
    end)
end)

AddEventHandler("item:sellsale", function(id, qty, price)
    local mysource = source
    TriggerEvent('es:getPlayerFromId', mysource, function(user)
        local player = user.getIdentifier()
        MySQL.Async.execute("UPDATE user_inventory SET `quantity` = @qty WHERE `user_id` = @username AND `item_id` = @id", { ['@username'] = player, ['@qty'] = tonumber(qty), ['@id'] = tonumber(id) })
        user.addDirtyMoney(tonumber(price))
    end)
end)

AddEventHandler("player:giveItem", function(item, name, qty, target)
    local mysource = source
    local player = getPlayerID(mysource)
    local targetid = getPlayerID(target)
    local qty = math.floor(tonumber(qty))
    MySQL.Async.fetchScalar("SELECT SUM(quantity) FROM user_inventory WHERE user_id = @username", { ['@username'] = targetid }, function(total)
        if (total + qty < 100) then
            TriggerClientEvent("player:looseItem", mysource, item, qty)
            TriggerClientEvent("player:receiveItem", target, item, qty)
            TriggerClientEvent("es_freeroam:notify", target, "CHAR_MP_STRIPCLUB_PR", 1, "System", false, "Vous venez de recevoir " .. qty .. " " .. name)
            TriggerClientEvent("es_freeroam:notify", mysource, "CHAR_MP_STRIPCLUB_PR", 1, "System", false, "Vous venez de donner " .. qty .. " " .. name)
        else
            TriggerClientEvent("es_freeroam:notify", mysource, "CHAR_MP_STRIPCLUB_PR", 1, "System", false, "quantité trop grande pour l'inventaire du joueur " .. qty .. " " .. name)
        end
    end)
end)

AddEventHandler("player:useItem", function(item, name, qty)
    local mysource = source
    local player = getPlayerID(source)
    print("print avant event use item")
    MySQL.Async.fetchScalar("SELECT SUM(quantity) FROM user_inventory WHERE user_id = @username", { ['@username'] = player }, function(total)
        if menus[item] ~= nil then
            if (total - qty > 0) then
                print("passe dans event use item")
                TriggerEvent('player_state:change', mysource, menus[item].calories , menus[item].water , menus[item].needs)
                TriggerClientEvent("item:drunk", mysource , item)
                TriggerClientEvent("player:looseItem", mysource, item, qty)
                TriggerClientEvent("es_freeroam:notify", mysource, "CHAR_MP_STRIPCLUB_PR", 1, "System", false, "Vous utilisez " .. qty .. " " .. name)
            end
        else
            TriggerClientEvent("es_freeroam:notify", mysource, "CHAR_MP_STRIPCLUB_PR", 1, "System", false, "Vous ne pouvez pas utiliser cet item")
        end
    end)
end)

-- get's the player id without having to use bugged essentials
function getPlayerID(source)
    local identifiers = GetPlayerIdentifiers(source)
    local player = getIdentifiant(identifiers)
    return player
end

-- gets the actual player id unique to the player,
-- independent of whether the player changes their screen name
function getIdentifiant(id)
    for _, v in ipairs(id) do
        return v
    end
end


