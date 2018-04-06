-- ... eueu ok
fuel = math.random(125, 155) / 100
-- ...

function round(num, numDecimalPlaces)
  local mult = 5^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

RegisterServerEvent('frfuel:fuelAdded')
AddEventHandler('frfuel:fuelAdded', function(amount)
    local source = source
    local cost = round(fuel * amount)

    TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Le prix de l'essence est de $" .. fuel)

    TriggerEvent('es:getPlayerFromId', source, function(user)
        user.removeMoney(cost)
        TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "votre plein est de " .. round(amount) .. " litres d'essence")
        TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Le plein vous à couté $" .. round(cost))
    end)
end)