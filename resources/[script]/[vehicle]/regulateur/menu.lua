--====================================================================================
-- #Author: Jonathan D @ Gannon
-- 
-- Développée pour la communauté n3mtv
--      https://www.twitch.tv/n3mtv
--      https://twitter.com/n3m_tv
--      https://www.facebook.com/lan3mtv
--====================================================================================





--===================================================================================================================================================--
--                Build Menu -- playAmination = joue l'aniamtion une fois et playAminationLoop pour jouer l'animation en boucle.                     -- 
-- site des emotes = http://docs.ragepluginhook.net/html/62951c37-a440-478c-b389-c471230ddfc5.htm#amb@code_human_wander_idles_cop@male@staticSection --
--===================================================================================================================================================--
local KeyOpenJobsMenu = 166 -- F5
local currentJobs = ''
local hasMenuJob = false
RegisterNetEvent('metiers:updateJob')
AddEventHandler('metiers:updateJob', function(nameJob)
    -- if hasMenuJob then
        -- table.remove(Menu.item.Items, 1)
    -- end
    -- hasMenuJob = false

    -- if nameJob == 'Policier' or 
       -- nameJob == 'Ambulancier' or 
       -- nameJob == 'Taxi' or 
       -- nameJob == 'Mecano' then
       -- table.insert(Menu.item.Items, 1, {['Title'] = 'Menu ' .. nameJob, ['Function'] = openMenuJobs } )
       -- hasMenuJob = true
       -- --Citizen.Trace('-----------------------')
    -- end
    -- if nameJob == 'Policier' then
        -- currentJobs = 'police'
    -- else
        -- currentJobs = string.lower(nameJob)
    -- end
end)

function openMenuJobs()
    TriggerEvent(currentJobs .. ':openMenu')
end

Menu = {}
Menu.item = {
    ['Title'] = 'Controle du véhicule',
    ['Items'] = {
		{['Title'] = 'Démarer/éteindre le moteur', ['Function'] = EngineToggle},
		-- {['Title'] = 'Ouverture Porte', ['SubMenu'] = {
            -- ['Title'] = 'Ouverture Porte',  ['Items'] = {
                -- {['Title'] = 'Porte conducteur', ['Function'] = openVehicleDoorData, ['Porte'] = 0, ['Close'] = false},
                -- {['Title'] = 'Porte passager', ['Function'] = openVehicleDoorData, ['Porte'] = 1, ['Close'] = false},
                -- {['Title'] = 'Porte conducteur arrière', ['Function'] = openVehicleDoorData, ['Porte'] = 2, ['Close'] = false},
                -- {['Title'] = 'Porte passager arrière', ['Function'] = openVehicleDoorData, ['Porte'] = 3, ['Close'] = false},
                -- {['Title'] = 'Capot', ['Function'] = openVehicleDoorData, ['Porte'] = 4, ['Close'] = false},
                -- {['Title'] = 'Coffre', ['Function'] = openVehicleDoorData, ['Porte'] = 5, ['Close'] = false},
                -- {['Title'] = 'Porte camion droit', ['Function'] = openVehicleDoorData, ['Porte'] = 6, ['Close'] = false},
                -- {['Title'] = 'Porte camion gauche', ['Function'] = openVehicleDoorData, ['Porte'] = 7, ['Close'] = false},
                -- {['Title'] = 'Toute les porte', ['Function'] = openVehicleDoorData, ['Porte'] = -1, ['Close'] = false},
            -- }
        -- }},
        -- {['Title'] = 'Fermeture Porte', ['SubMenu'] = {
            -- ['Title'] = 'Fermeture Porte', ['Items'] = {
                -- {['Title'] = 'Porte conducteur', ['Function'] = closeVehicleDoorData, ['Porte'] = 0, ['Close'] = false},
                -- {['Title'] = 'Porte passager', ['Function'] = closeVehicleDoorData, ['Porte'] = 1, ['Close'] = false},
                -- {['Title'] = 'Porte conducteur arrière', ['Function'] = closeVehicleDoorData, ['Porte'] = 2, ['Close'] = false},
                -- {['Title'] = 'Porte passager arrière', ['Function'] = closeVehicleDoorData, ['Porte'] = 3, ['Close'] = false},
                -- {['Title'] = 'Capot', ['Function'] = closeVehicleDoorData, ['Porte'] = 4, ['Close'] = false},
                -- {['Title'] = 'Coffre', ['Function'] = closeVehicleDoorData, ['Porte'] = 5, ['Close'] = false},
                -- {['Title'] = 'Porte camion droit', ['Function'] = closeVehicleDoorData, ['Porte'] = 6, ['Close'] = false},
                -- {['Title'] = 'Porte camion gauche', ['Function'] = closeVehicleDoorData, ['Porte'] = 7, ['Close'] = false},
                -- {['Title'] = 'Toute les porte', ['Function'] = closeVehicleDoorData, ['Porte'] = -1, ['Close'] = false},
            -- }
		-- }},
		{['Title'] = 'Toggle Porte', ['SubMenu'] = {
            ['Title'] = 'Toggle Porte', ['Items'] = {
                {['Title'] = 'Porte conducteur', ['Function'] = ToggleDoorData, ['Porte'] = 0, ['Close'] = false},
                {['Title'] = 'Porte passager', ['Function'] = ToggleDoorData, ['Porte'] = 1, ['Close'] = false},
                {['Title'] = 'Porte conducteur arrière', ['Function'] = ToggleDoorData, ['Porte'] = 2, ['Close'] = false},
                {['Title'] = 'Porte passager arrière', ['Function'] = ToggleDoorData, ['Porte'] = 3, ['Close'] = false},
                {['Title'] = 'Capot', ['Function'] = ToggleDoorData, ['Porte'] = 4, ['Close'] = false},
                {['Title'] = 'Coffre', ['Function'] = ToggleDoorData, ['Porte'] = 5, ['Close'] = false},
                {['Title'] = 'Porte camion droit', ['Function'] = ToggleDoorData, ['Porte'] = 6, ['Close'] = false},
                {['Title'] = 'Porte camion gauche', ['Function'] = ToggleDoorData, ['Porte'] = 7, ['Close'] = false},
                --{['Title'] = 'Toute les porte', ['Function'] = ToggleDoorData, ['Porte'] = -1, ['Close'] = false},
            }
		}},
		{['Title'] = 'Récupèrer les Clés', ['Function'] = lockunlock},
		{['Title'] = 'Vérouiller/Dévérrouiller le vehicule', ['Function'] = lockunlock},
    }
}
--====================================================================================
--  Option Menu
--====================================================================================
Menu.backgroundColor = { 52, 73, 94, 196 }
Menu.backgroundColorActive = { 22, 160, 134, 255 }
Menu.tileTextColor = { 22, 160, 134, 255 }
Menu.tileBackgroundColor = { 255,255,255, 255 }
Menu.textColor = { 255,255,255,255 }
Menu.textColorActive = { 255,255,255, 255 }

Menu.keyOpenMenu = 288 -- F1    
Menu.keyUp = 172 -- PhoneUp
Menu.keyDown = 173 -- PhoneDown
Menu.keyLeft = 174 -- PhoneLeft || Not use next release Maybe 
Menu.keyRight =	175 -- PhoneRigth || Not use next release Maybe 
Menu.keySelect = 176 -- PhoneSelect
Menu.KeyCancel = 177 -- PhoneCancel

Menu.posX = 0.05
Menu.posY = 0.05

Menu.ItemWidth = 0.20
Menu.ItemHeight = 0.03

Menu.isOpen = false   -- /!\ Ne pas toucher
Menu.currentPos = {1} -- /!\ Ne pas toucher

--====================================================================================
--  Menu System
--====================================================================================

function Menu.drawRect(posX, posY, width, heigh, color)
    DrawRect(posX + width / 2, posY + heigh / 2, width, heigh, color[1], color[2], color[3], color[4])
end

function Menu.initText(textColor, font, scale)
    font = font or 0
    scale = scale or 0.35
    SetTextFont(font)
    SetTextScale(0.0,scale)
    SetTextCentre(true)
    SetTextDropShadow(0, 0, 0, 0, 0)
    SetTextEdge(0, 0, 0, 0, 0)
    SetTextColour(textColor[1], textColor[2], textColor[3], textColor[4])
    SetTextEntry("STRING")
end

function Menu.draw() 
    -- Draw Rect
    local pos = 0
    local menu = Menu.getCurrentMenu()
    local selectValue = Menu.currentPos[#Menu.currentPos]
    local nbItem = #menu.Items
    -- draw background title & title
    Menu.drawRect(Menu.posX, Menu.posY , Menu.ItemWidth, Menu.ItemHeight * 2, Menu.tileBackgroundColor)    
    Menu.initText(Menu.tileTextColor, 4, 0.7)
    AddTextComponentString(menu.Title)
    DrawText(Menu.posX + Menu.ItemWidth/2, Menu.posY)

    -- draw bakcground items
    Menu.drawRect(Menu.posX, Menu.posY + Menu.ItemHeight * 2, Menu.ItemWidth, Menu.ItemHeight + (nbItem-1)*Menu.ItemHeight, Menu.backgroundColor)
    -- draw all items
    for pos, value in pairs(menu.Items) do
        if pos == selectValue then
            Menu.drawRect(Menu.posX, Menu.posY + Menu.ItemHeight * (1+pos), Menu.ItemWidth, Menu.ItemHeight, Menu.backgroundColorActive)
            Menu.initText(Menu.textColorActive)
        else
            Menu.initText(Menu.textColor)
        end
        AddTextComponentString(value.Title)
        DrawText(Menu.posX + Menu.ItemWidth/2, Menu.posY + Menu.ItemHeight * (pos+1))
    end
    
end

function Menu.getCurrentMenu()
    local currentMenu = Menu.item
    for i=1, #Menu.currentPos - 1 do
        local val = Menu.currentPos[i]
        currentMenu = currentMenu.Items[val].SubMenu
    end
    return currentMenu
end

function Menu.initMenu()
    for i,v in ipairs(Menu.item.Items)do
            if( v['Title'] == 'Ambulancier')then
                table.remove(Menu.item.Items,i)
                
            end
    end
    TriggerEvent("ambulancier:menu")
    Menu.currentPos = {1}
    
end

function Menu.keyControl()
    if IsControlJustPressed(1, Menu.keyDown) then 
        local cMenu = Menu.getCurrentMenu()
        local size = #cMenu.Items
        local slcp = #Menu.currentPos
        Menu.currentPos[slcp] = (Menu.currentPos[slcp] % size) + 1

    elseif IsControlJustPressed(1, Menu.keyUp) then 
        local cMenu = Menu.getCurrentMenu()
        local size = #cMenu.Items
        local slcp = #Menu.currentPos
        Menu.currentPos[slcp] = ((Menu.currentPos[slcp] - 2 + size) % size) + 1

    elseif IsControlJustPressed(1, Menu.KeyCancel) then 
        table.remove(Menu.currentPos)
        if #Menu.currentPos == 0 then
            Menu.isOpen = false 
        end

    elseif IsControlJustPressed(1, Menu.keySelect)  then
        local cSelect = Menu.currentPos[#Menu.currentPos]
        local cMenu = Menu.getCurrentMenu()
        if cMenu.Items[cSelect].SubMenu ~= nil then
            Menu.currentPos[#Menu.currentPos + 1] = 1
        else
            if cMenu.Items[cSelect].Function ~= nil then
                cMenu.Items[cSelect].Function(cMenu.Items[cSelect])
            end
            if cMenu.Items[cSelect].Event ~= nil then
                TriggerEvent(cMenu.Items[cSelect].Event, cMenu.Items[cSelect])
            end
            if cMenu.Items[cSelect].Close == nil or cMenu.Items[cSelect].Close == true then
                Menu.isOpen = false
            end
        end
    end

end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if IsControlJustPressed(1, Menu.keyOpenMenu) then
            Menu.initMenu()
            Menu.isOpen = not Menu.isOpen
        end
        if Menu.isOpen then
            Menu.draw()
            Menu.keyControl()
        end
        -- if IsControlJustPressed(1, KeyOpenJobsMenu) then
            -- openMenuJobs()
        -- end
    end
end)