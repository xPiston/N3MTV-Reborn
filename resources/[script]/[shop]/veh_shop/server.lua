--
-- Created by KRISFR
-- Author: https://github.com/JcPires
--

RegisterServerEvent('veh_shop:checkMoney')
AddEventHandler('veh_shop:checkMoney', function(vhl)
    local currentSource = source
    TriggerEvent('es:getPlayerFromId', currentSource, function(user)
        if (tonumber(user.getMoney()) >= tonumber(vhl.price)) then
            TriggerClientEvent('veh_shop:writePlaque', currentSource, vhl)
        else
            TriggerClientEvent('veh_shop:notifs', currentSource, "Vous n'avez pas assez d'argent !")
        end

    end)
end)

RegisterServerEvent('veh_shop:checkPrice')
AddEventHandler('veh_shop:checkPrice', function(vhl)
    local player = GetPlayerIdentifiers(source)
    local currentSource = source
    local spawnable = spawnable
    local plate = string.gsub(vhl.plate, "^%s*(.-)%s*$", "%1")

    MySQL.Async.fetchAll("SELECT * FROM user_vehicle WHERE owner=@owner AND model=@model AND plate=@plate ORDER BY name ASC LIMIT 1", {['@owner'] = player[1], ['@model'] =  vhl.model, ['@plate'] = plate }, function(result)
       if result[1] then
        local prePrice = ( result[1].price  * 75 ) / 100
        local dmgPrice  = prePrice -  ( ( prePrice * ( vhl.damage / 10 ) ) / 100 )
        local selPrice = prePrice - dmgPrice
        
        TriggerClientEvent('veh_shop:printPrice', currentSource, {name = result[1].name, plate = result[1].plate, buyed = result[1].price, prePrice = prePrice, damage = vhl.damage, dmgPrice = dmgPrice, selPrice = selPrice})
         
       else
        TriggerClientEvent('veh_shop:notifs', currentSource, "Le ~r~meme vehicule~r~ est déjà enregistré avec cette ~r~meme plaque~r~ !")
       end
        

    end)
end)

RegisterServerEvent('veh_shop:sell')
AddEventHandler('veh_shop:sell', function(vhl)
    local player = GetPlayerIdentifiers(source)
    local currentSource = source
    local spawnable = spawnable
    local plate = string.gsub(vhl.plate, "^%s*(.-)%s*$", "%1")
    TriggerEvent('es:getPlayerFromId', currentSource, function(user)
        MySQL.Async.fetchAll("SELECT * FROM user_vehicle WHERE owner=@owner AND model=@model AND plate=@plate ORDER BY name ASC LIMIT 1", {['@owner'] = player[1], ['@model'] =  vhl.model, ['@plate'] = plate }, function(result)
            

            
            if result[1] ~= nil then
                local prePrice = (result[1].price  * 75) / 100
                local dmgPrice = prePrice - ( ( prePrice * ( vhl.damage / 10 ) ) / 100 ) 
                local selPrice = prePrice - dmgPrice
                MySQL.Async.execute("DELETE FROM user_vehicle WHERE owner=@owner AND model=@model AND plate=@plate",{
                        ['@owner'] =result[1].owner,
                        ['@model'] = result[1].model,
                        ['@plate'] = result[1].plate,
                    }, function(result2)
                        if result2 == 1 then
                            user.addMoney((selPrice))
                            user.log('Vente le véhicule ' .. result[1].model .. ' @ ' .. result[1].plate .. ' pour ' .. selPrice .. '$' )
                            TriggerClientEvent('veh_shop:vhl_selled', currentSource)
                        else
                           TriggerClientEvent('veh_shop:notifs', currentSource, "Une erreur est survenue merci de contacter le staff !") 
                        end
                        
                    end)
            else
            end
        
        end)
    end)

end)

RegisterServerEvent('veh_shop:buyit')
AddEventHandler('veh_shop:buyit', function(vhl)
    local currentSource = source
    TriggerEvent('es:getPlayerFromId', currentSource, function(user)
        local player = GetPlayerIdentifiers(currentSource)
        local name = vhl.name
        local price = vhl.price
        local plate = string.gsub(vhl.plate, "^%s*(.-)%s*$", "%1")
        local vehicle = vhl.model
        local type = vhl.type
        local state = 1
        local customs = {
            color = {
                primary = { type= 0, red = vhl.primary_red,green= vhl.primary_green, blue = vhl.primary_blue},
                secondary = { type= 0, red = vhl.secondary_red,green= vhl.secondary_green, blue = vhl.secondary_blue},
                pearlescent = vhl.extra,
                windows = 0
            },
            wheels = {
                type = 0,
                color = vhl.wheelcolor,
            },
            neons = { enabled= 0, red = 255,green= 255, blue = 255},

            tyreburst = {enabled=0, red = 255,green= 255, blue = 255},
            mods = {},
        }
        vhl.customs = json.encode(customs)
        MySQL.Async.fetchAll("SELECT * FROM user_vehicle WHERE model=@model AND plate=@plate ORDER BY name ASC LIMIT 1", {['@owner'] = player[1], ['@model'] =  vehicle, ['@plate'] = plate }, function(result)

            if not result[1] then
                MySQL.Async.execute("INSERT INTO user_vehicle (`owner`, `name`, `model`, `price`, `plate`, `state`, `type`, `customs`) VALUES (@username, @name, @vehicle, @price, @plate, @state, @type, @customs)",{
                    ['@username'] = player[1],
                    ['@name'] = name,
                    ['@vehicle'] = vehicle,
                    ['@price'] = price,
                    ['@plate'] = plate,
                    ['@state'] = state,
                    ['@type'] = type,
                    ['@customs'] = json.encode(customs)
                }, function()
                    user.removeMoney((vhl.price))
                    user.log('Achat du véhicule ' .. name .. ' @ ' .. plate .. ' pour ' .. vhl.price .. '$')
                    TriggerClientEvent('veh_shop:closeGui', currentSource)
                    TriggerClientEvent('veh_shop:spawnnewvhl', currentSource, vhl)
                end)
            else
                TriggerClientEvent('veh_shop:notifs', currentSource, "Le ~r~meme vehicule~r~ est déjà enregistré avec cette ~r~meme plaque~r~ !")
                TriggerClientEvent('veh_shop:writePlaque', currentSource, vhl)
            end


        end)

    end)
end)
