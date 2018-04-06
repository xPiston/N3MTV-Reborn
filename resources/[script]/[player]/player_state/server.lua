-- PARAMS
local malusfood = 1
local bonusfood = 100
local maluswater = 2
local bonuswater = 100
local malusneeds = 100
local bonusneeds = 1
local timingsave = 1200


--ADD CUSTOM NEEDS
RegisterServerEvent('player_state:change')
AddEventHandler('player_state:change', function(source, calories, waterdrops, wc)
    local identifiers = GetPlayerIdentifiers(source)
    local currentSource = source
    MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @name", {['@name'] = identifiers[1]}, function(result)
        local new_food = result[1].food + calories
        local new_water = result[1].water + waterdrops
        local new_needs = result[1].needs - wc        
        if new_food > 100 then
            new_food = 100
        end
        if new_water > 100 then
            new_water = 100
        end
        if new_needs > 100 then
            new_needs = 100
        end
        if new_food < 0 then
            new_food = 0
        end
        if new_water < 0 then
            new_water = 0
        end
        if new_needs < 0 then
            new_needs = 0
        end
        MySQL.Async.execute("UPDATE users SET `food`=@foodvalue, `water`=@watervalue, `needs`=@needsvalue WHERE identifier = @identifier",{ ['@foodvalue'] = new_food, ['@watervalue'] = new_water, ['@needsvalue'] = new_needs, ['@identifier'] = identifiers[1]}, function()
            if calories > 0 then
                TriggerClientEvent('player_state:eat', currentSource)
            end
            if waterdrops > 0 then
                TriggerClientEvent('player_state:drink', currentSource)
            end
            if new_needs == 0 then
                TriggerClientEvent('player_state:pee', currentSource)
            end            
            TriggerClientEvent("player_state:set", currentSource, {food = new_food, water = new_water, needs = new_needs})
        end)
    end)   
end)

RegisterServerEvent('player_state:check')
AddEventHandler('player_state:check', function()
    local currentSource = source
    local identifiers = GetPlayerIdentifiers(currentSource)
    
    MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @name", {['@name'] = identifiers[1]}, function(result)
        if (tonumber(result[1].food) >= 1) and (tonumber(result[1].water) >= 1) and (tonumber(result[1].needs) < tonumber(malusneeds)) then
            TriggerClientEvent('player_state:set', currentSource, {food = result[1].food, water = result[1].water, needs = result[1].needs})
            if (tonumber(result[1].food) <= 0) or (tonumber(result[1].water) <= 0) or (tonumber( result[1].needs) >= tonumber(malusneeds)) then
                TriggerClientEvent('player_state:death', currentSource)
            end
        else
            TriggerClientEvent('player_state:death', currentSource)    
        end
	    TriggerEvent('player_state:change',currentSource, -1, -2, -2)        
    end)
end)

RegisterServerEvent('player_state:removeneeds')
AddEventHandler('player_state:removeneeds', function(source)
    local identifiers = GetPlayerIdentifiers(source)
    local currentSource = source
    MySQL.Async.execute("UPDATE users SET `needs`=@needsvalue WHERE identifier = @identifier",{ ['@needsvalue'] = 0, ['@identifier'] = identifiers[1]}, function()
        TriggerEvent("player_state:change", currentSource, 0, 0, 0)
    end)
end)

RegisterServerEvent('player_state:setdefaultneeds')
AddEventHandler('player_state:setdefaultneeds', function()
    local currentSource = source
    TriggerEvent("player_state:change", currentSource, {food = bonusfood, water = bonuswater, needs = 0})
end)
-- START NEEDS
AddEventHandler('es:playerLoaded', function(source)
    local identifiers = GetPlayerIdentifiers(source)
    local currentSource = source
    MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @name", {['@name'] = identifiers[1]}, function(result)
        TriggerClientEvent("player_state:set", currentSource, {food = result[1].food, water = result[1].water, needs = result[1].needs})      
    end)
end)

