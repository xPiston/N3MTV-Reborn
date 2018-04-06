ITEMS = {}
-- flag to keep track of whether player died to prevent
-- multiple runs of player dead code
local playerdead = false
local maxCapacity = 100

-- register events, only needs to be done once
RegisterNetEvent("item:reset")
RegisterNetEvent("item:getItems")
RegisterNetEvent("item:updateQuantity")
RegisterNetEvent("item:setItem")
RegisterNetEvent("item:sell")
RegisterNetEvent("gui:getItems")
RegisterNetEvent("player:receiveItem")
RegisterNetEvent("player:looseItem")
RegisterNetEvent("player:sellItem")
RegisterNetEvent("player:sellItemSale")

function Chat(t)
	TriggerEvent("chatMessage", 'TRUCKER', { 0, 255, 255}, "" .. tostring(t))
end

-- handles when a player spawns either from joining or after death
AddEventHandler("playerSpawned", function()
    TriggerServerEvent("item:getItems")
    -- reset player dead flag
    playerdead = false
	TriggerServerEvent("skin_customization:SpawnPlayer")	
end)

AddEventHandler("gui:getItems", function(THEITEMS)
    ITEMS = {}
    ITEMS = THEITEMS
end)

AddEventHandler("player:receiveItem", function(item, quantity)
    if (getPods() + quantity < maxCapacity) then
        item = tonumber(item)
        if (ITEMS[item] == nil) then
            new(item, quantity)
        else
            add({ item, quantity })
        end
    end
end)

AddEventHandler("player:looseItem", function(item, quantity)
    item = tonumber(item)
    if (ITEMS[item].quantity >= quantity) then
        delete({ item, quantity })
    end
end)

AddEventHandler("player:sellItem", function(item, price)
    item = tonumber(item)
    if (ITEMS[item].quantity > 0) then
        sell({ item, price })
    end
end)

AddEventHandler("player:sellItemSale", function(item, price)
    item = tonumber(item)
    if (ITEMS[item].quantity > 0) then
        sellsale({ item, price })
    end
end)

function sell(arg)
    local itemId = tonumber(arg[1])
    local price = arg[2]
    local item = ITEMS[itemId]
    item.quantity = item.quantity - 1
    TriggerServerEvent("item:sell", itemId, item.quantity, price)
    InventoryMenu()
end

function sellsale(arg)
    local itemId = tonumber(arg[1])
    local price = arg[2]
    local item = ITEMS[itemId]
    item.quantity = item.quantity - 1
    TriggerServerEvent("item:sellsale", itemId, item.quantity, price)
    InventoryMenu()
end

function delete(arg)
    local itemId = tonumber(arg[1])
    local qty = arg[2]
    local item = ITEMS[itemId]
    item.quantity = item.quantity - qty
    TriggerServerEvent("item:updateQuantity", item.quantity, itemId)
	--TriggerEvent("es_freeroam:notify", "CHAR_MP_STRIPCLUB_PR", 1, "System", false, "Vous avez detruit un objet de votre inventaire")
    InventoryMenu()
end

function add(arg)
    local itemId = tonumber(arg[1])
    local qty = arg[2]
    local item = ITEMS[itemId]
    item.quantity = item.quantity + qty
    TriggerServerEvent("item:updateQuantity", item.quantity, itemId)
    InventoryMenu()
end

function new(item, quantity)
    TriggerServerEvent("item:setItem", item, quantity)
    TriggerServerEvent("item:getItems")
end

function getQuantity(itemId)
    if ITEMS[tonumber(itemId)] ~= nil then
        return ITEMS[tonumber(itemId)].quantity
    end
    return 0
end

function getPods()
    local pods = 0
    for _, v in pairs(ITEMS) do
        pods = pods + v.quantity
    end
    return pods
end

function notFull()
    local pods = 0
    for _, v in pairs(ITEMS) do
        pods = pods + v.quantity
    end
    if (pods < (maxCapacity-1)) then return true end
end

function InventoryMenu()
    ped = GetPlayerPed(-1);
    MenuTitle = "Items: " .. (getPods() or 0) .. "/" .. maxCapacity
    ClearMenu()
    for ind, value in pairs(ITEMS) do
        if (value.quantity > 0) then
            Menu.addButton(tostring(value.libelle) .. " : " .. tostring(value.quantity), "ItemMenu", ind)
        end
    end
end

function ItemMenu(itemId)
    ClearMenu()
	--local destroy = {itemId , 1}
    MenuTitle = "Details:"
	Menu.addButton("Utiliser", "use", itemId)
    Menu.addButton("Donner", "give", itemId)
	Menu.addButton("Detruire", "delete", {itemId , 1})

end

function give(item)
	
	player, distance = GetClosestPlayer()
	
	--Chat(distance)
	--Chat(player)
	
    if(distance ~= -1 and distance < 3) and (IsPedInAnyVehicle(GetPlayerPed(-1), true) == false) then
        DisplayOnscreenKeyboard(1, "Quantité :", "", "", "", "", "", 3)
        while (UpdateOnscreenKeyboard() == 0) do
            DisableAllControlActions(0);
            Wait(0);
        end
        if (GetOnscreenKeyboardResult()) then
            local res = math.ceil(tonumber(GetOnscreenKeyboardResult() or 0))

            if ( res > 0 and ITEMS[item].quantity - res >= 0) then
                TriggerServerEvent("player:giveItem", item, ITEMS[item].libelle, res, GetPlayerServerId(player))
                local ped = GetPlayerPed(-1)
                if ped then
                    TaskStartScenarioInPlace(ped, "PROP_HUMAN_PARKING_METER", 0, false)
                    Citizen.Wait(1500)
                    ClearPedTasks(GetPlayerPed(-1))
                end
                
            end
            Menu.hidden = not Menu.hidden
        end
    else
		TriggerEvent("es_freeroam:notify", "CHAR_MP_STRIPCLUB_PR", 1, "Mairie", false, "Pas de joueur proche ou dans un vehicule")
		Menu.hidden = not Menu.hidden
	end
end

function use(item)
	TriggerServerEvent("player:useItem", item, ITEMS[item].libelle,1)

	Menu.hidden = not Menu.hidden
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(1, 311) then
            InventoryMenu() -- Menu to draw
            Menu.hidden = not Menu.hidden -- Hide/Show the menu
        end
        Menu.renderGUI() -- Draw menu on each tick if Menu.hidden = false
        -- if IsEntityDead(PlayerPedId()) then
            -- PlayerIsDead()
            -- -- prevent the death check from overloading the server
            -- playerdead = true
        -- end
    end
end)

-- function PlayerIsDead()
    -- -- do not run if already ran
    -- if playerdead then
        -- return
    -- end
    -- TriggerServerEvent("item:reset")
-- end

----------------------------------------------------------------

function GetClosestPlayer()
	local players = GetPlayers()
	local closestDistance = -1
	local closestPlayer = -1
	local ply = GetPlayerPed(-1)
	local plyCoords = GetEntityCoords(ply, 0)
	
	for index,value in ipairs(players) do
		local target = GetPlayerPed(value)
		--Chat(target.." TARGET")
		--Chat(ply.. " PLY")
		if(target ~= ply) then
			local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
			local distance = GetDistanceBetweenCoords(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
			if(closestDistance == -1 or closestDistance > distance) then
				closestPlayer = value
				closestDistance = distance
			end
		end
	end
	
	return closestPlayer, closestDistance
end

function GetPlayers()
    local players = {}

    for i = 0, 31 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end

