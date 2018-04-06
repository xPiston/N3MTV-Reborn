RegisterServerEvent('CheckMoneyForVeh')
RegisterServerEvent('BuyForVeh')

AddEventHandler('CheckMoneyForVeh', function(name, vehicle, price)
    local mysource = source
    TriggerEvent('es:getPlayerFromId', mysource, function(user)
        local player = user.getIdentifier()
        local vehicle = vehicle
        local name = name
        local price = tonumber(price)

        MySQL.Async.fetchAll("SELECT * FROM user_vehicle WHERE owner = @username",{['@username'] = player}, function (result)

           if (user.getBank() + user.getMoney() >= tonumber(price)) then
                -- user.removeBank((price))
                TriggerClientEvent('FinishMoneyCheckForVeh', mysource, name, vehicle, price)
                TriggerClientEvent("es_freeroam:notify", mysource, "CHAR_SIMEON", 1, "Simeon", false, "Bonne route!\n")
           --elseif ( (tonumber(user.dirty_money) + tonumber(user.money)) >= tonumber(price) ) then
           --     user:removeDirty_Money((price - user.money))
           --     user:removeMoney((user.money))
           --     TriggerClientEvent('FinishMoneyCheckForVeh', mysource, name, vehicle, price)
           --     TriggerClientEvent("es_freeroam:notify", mysource, "CHAR_SIMEON", 1, "Simeon", false, "Bonne route!\n")
           else
                TriggerClientEvent("es_freeroam:notify", mysource, "CHAR_SIMEON", 1, "Simeon", false, "Fonds insuffisants!\n")
           end
        end)
    end)
end)

AddEventHandler('BuyForVeh', function(name, vehicle, vprice, plate, currentVhl)
    local mysource = source
    local price = tonumber(vprice)
--    print('price :::::::::::::' .. price)
    TriggerEvent('es:getPlayerFromId', mysource, function(user)
        if user.getBank() + user.getMoney() >= price then
            local miss = price - user.getBank()
            if miss > 0 then 
                user.removeBank(user.getBank())
                user.removeMoney(miss)
            else
                user.removeBank(price)
            end
            
            local player = user.getIdentifier()
            local name = name
            local price = price
            local vehicle = vehicle
            local plate = string.gsub(plate, "^%s*(.-)%s*$", "%1")
            local state = 1
            local type  = 1
            local customs = {
                color = {
                    primary = { type= currentVhl.primary_type, red = currentVhl.primary_red,green= currentVhl.primary_green, blue = currentVhl.primary_blue},
                    secondary = { type= currentVhl.secondary_type,  red = currentVhl.secondary_red,green= currentVhl.secondary_green, blue = currentVhl.secondary_blue},
                    pearlescent = currentVhl.extra
                },
                wheels = {
                    type = 0,
                    color = currentVhl.wheelcolor,
                },
                neons = { enabled= 0, red = 255,green= 255, blue = 255},
                windows = 0,
                tyreburst = {enabled=0, red = 255,green= 255, blue = 255},
                mods = {},
            }

            MySQL.Async.execute("INSERT INTO user_vehicle (`owner`, `name`, `model`, `price`, `plate`, `state`, `type`, `customs`) VALUES (@username, @name, @vehicle, @price, @plate, @state, @type, @customs)",
                {['@username'] = player, ['@name'] = name, ['@vehicle'] = vehicle, ['@price'] = price, ['@plate'] = plate, ['@state'] = state, ['@type'] = type, ['@customs'] = json.encode(customs) })
            user.log('Buy Car Name: ' .. name .. ' model:' .. vehicle .. ' price: ' .. price)
        end
    end)
end)
