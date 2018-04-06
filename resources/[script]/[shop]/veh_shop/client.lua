--
-- Created by KRISFR
-- Author: https://github.com/JcPires
--

local boats = {
    { name= 'dinghy', model= 1033245328, price = 241111 },
    { name= 'jetmax', model= 861409633, price = 431702 },
    { name= 'marquis', model=  -1043459709, price = 1217000 },
    { name= 'seashark', model= -1030275036, price = 80899 },
    { name= 'speeder', model= 231083307, price = 533551 },
    { name= 'squalo', model= 400514754, price = 355065 },
    { name= 'suntrap', model= -282946103, price = 103231 },
    { name= 'toro', model= 1070967343, price = 2750000 },
    { name= 'tropic', model= 290013743, price = 91722 },
}

local copter = {
    { name= 'Buzzard2' ,model= 745926877, price = 4500000 },
    { name= 'Frogger' ,model= 744705981, price = 2300000 },
    { name= 'Maverick' ,model= -1660661558, price = 2150000 },
    { name= 'Supervolito2' ,model= -1671539132, price = 2800000 },
    { name= 'Swift' ,model= -339587598, price = 2550000 },
    { name= 'Swift2' ,model= 1075432268, price = 3250000 },
    { name= 'Volatus' ,model= -1845487887, price = 4200000 }
}

local planes = {
    { name= 'Besra' ,model=1824333165, price = 4775000 },
    { name= 'Cuban800' ,model=-644710429, price = 1850000 },
    { name= 'Dodo' ,model=-901163259, price = 2100000 },
    { name= 'Duster' ,model=970356638, price = 1680000 },
    { name= 'Luxor' ,model=621481054, price = 12365000 },
    { name= 'Luxor2' ,model=-1214293858, price = 21650000 },
    { name= 'Mammatus' ,model=-1746576111, price = 1925000 },
    { name= 'Nimbus' ,model=-1295027632, price = 9655000 },
    { name= 'Shamal' ,model=-1214505995, price = 8736000 },
    { name= 'Stunt' ,model=-2122757008, price = 985000 },
    { name= 'Velum' ,model=-1673356438, price = 1385000 },
    { name= 'Vestra' ,model=1341619767, price = 1565000 },
}

local cars = {}

local currentUiState = false
local currentspawnzone = { x=0, y=0, z=0, direction = 0 }
local currentActionZone = { x=0, y=0, z=0 }


local locations = {
    { name= 'Achat de bateau', x = -778.807312011719, y= -1494.95544433594, z= 1.94091629981995, direction =  109.849670410156, spawn_x = -800.128967285156, spawn_y= -1504.12890625, spawn_z= 1.074324464797974, activationDist=10.5, markerWidth = 1.05001, markerType= 410, markerColor= 70, spawnable=2 },
    { name= "Achat d'helicoptères", x = -734.538696289063, y= -1456.7744140625, z= 5.00052165985107, direction = 124.473701477051, spawn_x = -743.796203613281, spawn_y= -1466.3525390625, spawn_z= 5.00051927566528, activationDist=10.5, markerWidth = 1.05001, markerType= 43, markerColor= 70, spawnable=3 },
    { name= "Achat d'helicoptères", x = 1745.947265625, y= 3251.03198242188, z= 41.5154838562012, direction = 87.4193420410156, spawn_x = 1744.2939453125, spawn_y= 3238.42846679688, spawn_z= 40.8155670166016, activationDist=10.5, markerWidth = 1.05001, markerType= 43, markerColor= 70, spawnable=3 },
	{ name= "Achat d'avions", x = 1692.39074707031, y= 3250.837890625, z= 39.8957862854004, direction = 105.808212280273, spawn_x = 1692.39074707031, spawn_y= 3250.837890625, spawn_z= 39.8957862854004, activationDist=10.5, markerWidth = 1.05001, markerType= 307, markerColor= 70, spawnable=4 },
    { name= "Achat d'avions", x = -979.829467773438, y= -2994.21215820313, z= 12.9450721740723, direction = 59.6978302001953, spawn_x = -979.829467773438, spawn_y= -2994.21215820313, spawn_z= 12.9450721740723, activationDist=10.5, markerWidth = 1.05001, markerType= 307, markerColor= 70, spawnable=4 }
}
local sellers = {

    { name= 'Revente de bateau',    x = -760.130004882813, y= -1486.48815917969, z= 5.00052356719971, direction =  109.849670410156, activationDist=5.5, markerWidth = 1.05001, markerType= 434, markerColor= 6, spawnable=2 },
    { name= "Revente d'hélicoptère",x = 1750.9267578125, y= 3235.45776367188, z= 42.0117149353027, direction =  133.425750732422, activationDist=5.5, markerWidth = 1.05001, markerType= 434, markerColor= 6, spawnable=3 },
    { name= 'Revente de véhicule',  x = -42.2988891601563, y= -1677.5712890625, z=  29.4280624389648, direction =  109.849670410156, activationDist=5.5, markerWidth = 1.05001, markerType= 434, markerColor= 6, spawnable=1 },
    
}

RegisterNetEvent('garages:addvhltothelist')
AddEventHandler('garages:addvhltothelist', function(vhl)
    local toadd = { key= vhl.name, model=vhl.model, state= vhl.state, plate= vhl.plate }
    SendNUIMessage({addlist = json.encode(toadd)})
end)

function openGui(spawnable)
    SetNuiFocus(true)
    SendNUIMessage({ openUI = true })
    SendNUIMessage({ spawnable = json.encode({spawnable = spawnable}) })
end
function closeGui()
    SetNuiFocus(false)
    SendNUIMessage({ closeUI = true })
    FreezeEntityPosition(GetPlayerPed(-1),false)
    SetEntityVisible(GetPlayerPed(-1),true)
    currentUiState = false
end

-------------------------------------------------- NUI LISTENER --------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback('close', function(data, cb)
    closeGui()
    cb('ok')
end)

RegisterNetEvent('veh_shop:closeGui')
AddEventHandler('veh_shop:closeGui', function()
    closeGui()
end)

RegisterNUICallback('init', function(data, cb)
    local list = {}
    local type = 0
    if data.spawnable == 1 then
        list = cars
        type = 1
    elseif data.spawnable == 2 then
        list = boats
        type = 2
    elseif data.spawnable == 3 then
        list = copter
        type = 3
    elseif data.spawnable == 4 then
        list = planes
        type = 4
    else
        cb('ok')
        closeGui()
        CancelEvent()
    end
    for k, vhl in ipairs(list)  do
        local toadd = { key= vhl.name, model= vhl.model, visible = true, price= vhl.price, type= type }
        if k > 10 then
            toadd.visible = false
        end
        SendNUIMessage({addlist = json.encode(toadd)})
    end
    cb('ok')
end)

local oldSpawned = 0
RegisterNUICallback('showcase', function(data, cb)
    if oldSpawned then
        Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(oldSpawned))
    end
    FreezeEntityPosition(GetPlayerPed(-1),true)
    SetEntityVisible(GetPlayerPed(-1),false)
    local car = GetHashKey(data.model)
    RequestModel(car)
    if not data.model then
        SetEntityCoords(GetPlayerPed(-1), currentActionZone.x,currentActionZone.y,currentActionZone.z, 1, 0, 0, 1)
    else
        while not HasModelLoaded(car) do
            Citizen.Wait(0)
        end
        local veh = CreateVehicle(car, currentspawnzone.x,currentspawnzone.y,currentspawnzone.z,  currentspawnzone.direction, false, false)
        oldSpawned = veh
        FreezeEntityPosition(veh,true)
        SetEntityInvincible(veh,true)
        SetVehicleDoorsLocked(veh,4)
        TaskWarpPedIntoVehicle(GetPlayerPed(-1),veh,-1)
        local id = NetworkGetNetworkIdFromEntity(veh)
        SetNetworkIdCanMigrate(id, true)
    end
    cb('ok')
end)

RegisterNUICallback('buy', function(data, cb)
    data.name = GetDisplayNameFromVehicleModel(data.model)
    TriggerServerEvent('veh_shop:checkMoney', data)
    cb('ok')
end)

RegisterNUICallback('removeold', function(data, cb)
    if oldSpawned then
        Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(oldSpawned))
    end
    SetEntityCoords(GetPlayerPed(-1), currentActionZone.x,currentActionZone.y,currentActionZone.z, 1, 0, 0, 1)
    cb('ok')
end)

RegisterNetEvent('veh_shop:writePlaque')
AddEventHandler('veh_shop:writePlaque', function(vhl)
    closeGui()
    local buyer = GetPlayerPed(-1)
    vhl.primary_red, vhl.primary_green, vhl.primary_blue   = GetVehicleCustomPrimaryColour( oldSpawned )
    vhl.secondary_red, vhl.secondary_green, vhl.secondary_blue = GetVehicleCustomSecondaryColour( oldSpawned )
    vhl.extra ,vhl.wheelcolor = GetVehicleExtraColours(oldSpawned)
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "Plaque", "", "", "", 8)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        local result = tostring(GetOnscreenKeyboardResult())
        vhl.plate = result
        SetVehicleNumberPlateText(oldSpawned, result)
        TriggerServerEvent('veh_shop:buyit', vhl)
    else
        SetEntityCoords(buyer, currentActionZone.x,currentActionZone.y,currentActionZone.z, 1, 0, 0, 1)
        closeGui()
    end
end)
RegisterNetEvent('veh_shop:spawnnewvhl')
AddEventHandler('veh_shop:spawnnewvhl', function(vhl)
    FreezeEntityPosition(GetPlayerPed(-1),false)
    SetEntityVisible(GetPlayerPed(-1),true)
    local customs = json.decode(vhl.customs)
    if oldSpawned then
        Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(oldSpawned))
    end
    local model = tonumber(vhl.model)
    while not HasModelLoaded(model) do
        Citizen.Wait(0)
    end
    local veh = CreateVehicle(model, currentspawnzone.x,currentspawnzone.y,currentspawnzone.z,  currentspawnzone.direction, true, false)
    oldSpawned = veh
    SetPedIntoVehicle(GetPlayerPed(-1), veh, -1)
    SetModelAsNoLongerNeeded(model)
    SetVehicleNumberPlateText(veh, vhl.plate)
    SetVehicleOnGroundProperly(veh)
    SetVehicleHasBeenOwnedByPlayer(veh,true)
    SetEntityAsMissionEntity(veh, true, true)
    local id = NetworkGetNetworkIdFromEntity(veh)
    SetNetworkIdCanMigrate(id, true)

    -- Set ModKit to changes apply
    SetVehicleModKit(veh, 0 )
    -- Set color Primary
    SetVehicleModColor_1(veh, customs.color.type, 0,0)
    SetVehicleCustomPrimaryColour(veh, customs.color.primary.red,  customs.color.primary.green,  customs.color.primary.blue)
    -- Set color Secondary
    SetVehicleModColor_2(veh, customs.color.type, 0,0)
    SetVehicleCustomSecondaryColour(veh, customs.color.secondary.red,  customs.color.secondary.green,  customs.color.secondary.blue)

    -- Set perlescent
    SetVehicleExtraColours(veh, customs.color.perlescent, customs.wheels.color)
end)

RegisterNetEvent('veh_shop:notifs')
AddEventHandler('veh_shop:notifs', function(notif)
    drawNotification(notif)
end)

RegisterNetEvent('veh_shop:printPrice')
AddEventHandler('veh_shop:printPrice', function(calc)
    drawNotification("Vehicule: ~y~ ".. calc.name)
    drawNotification("Plaque: ~y~ ".. calc.plate)
    drawNotification("Prix d'achat: ~y~ ".. calc.buyed.."~w~$")
    drawNotification("Prix initial de vente: ~y~ ".. calc.prePrice.."~w~$")
    drawNotification("Dégats: ~y~ "..  100 - ( calc.damage / 10 ).."~w~%")
    drawNotification("Prix des réparations: ~y~ ".. calc.dmgPrice.."~w~$")
    drawNotification("Prix de revente final: ~y~ ".. calc.selPrice.."~w~$")
end)
RegisterNetEvent('veh_shop:vhl_selled')
AddEventHandler('veh_shop:vhl_selled', function()
    local current =  GetPlayersLastVehicle(GetPlayerPed(-1), true)
    SetEntityAsMissionEntity(current, true, true)
    Wait(300)
    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(current))
    drawNotification("Véhicule ~g~vendu~g~")
    
end)

function DrawMarkers(type, x,y,z,markerWidth, markerColorRed, markerColorGreen, markerColorBlue, markerAlpha)
    -- drawMarker(type, posX, posY, posZ, dirX, dirY, dirZ, rotX, rotY, rotZ, scaleX, scaleY, scaleZ, colorR, colorG, colorB, alpha, bobUpAndDown, faceCamera, p19, rotate, textureDict, textureName, drawOnEnts);
    DrawMarker(type, x, y, z, 1.5, 0, 0, 0, 0, 0, markerWidth,  markerWidth,0.751, markerColorRed, markerColorGreen, markerColorBlue,markerAlpha, 1,0,0, 0, 0, 0,0)
end

function setMapMarkers(locations)
    for k,v in ipairs(locations)do
        local blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(blip, v.markerType)
        SetBlipColour(blip, v.markerColor)
        SetBlipScale(blip, 0.8)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.name)
        EndTextCommandSetBlipName(blip)
    end
end
function drawNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end
local called = false
Citizen.CreateThread(function()
    setMapMarkers(locations)
    setMapMarkers(sellers)
    while true do
        Citizen.Wait(0)
        local pos = GetEntityCoords(GetPlayerPed(-1), false)
        -- local hotdog = GetHashKey('prop_weed_01')
        -- local stand = GetClosestObjectOfType(pos.x, pos.y, pos.z, 1.0001, hotdog, false, false, false)
        -- zCitizen.Trace(stand)
        for _,d in ipairs( sellers ) do
            if Vdist(d.x, d.y, d.z, pos.x, pos.y, pos.z) < 200.0 then
                DrawMarkers(29, d.x, d.y, d.z +1.5, d.markerWidth, 255, 0, 0, 200)
            end
            if not called then
                if(Vdist(d.x, d.y, d.z, pos.x, pos.y, pos.z) < d.activationDist ) then
                    SetTextComponentFormat("STRING")
                    local type = ""
                    if d.spawnable == 1 then
                        type = "de véhicule"
                    elseif d.spawnable == 2 then
                        type = "de bateau"
                    elseif d.spawnable == 3 then
                        type = "aérien"
                    end
                    AddTextComponentString(" ~INPUT_CONTEXT~ interroger le revendeur " .. type)
                    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
                end
                if(IsControlJustReleased(1, 38) and Vdist(d.x, d.y, d.z, pos.x, pos.y, pos.z) <  d.activationDist ) then
                    local current = GetPlayersLastVehicle(GetPlayerPed(-1), true)
                    FreezeEntityPosition(GetPlayerPed(-1), true)
                    TaskLeaveVehicle(GetPlayerPed(-1), current, 4160)
                    if current == 0 then
                        drawNotification("Aucun véhicule !")
                    else
                        called = true                        
                        local model = GetEntityModel(current)
                        local plate = GetVehicleNumberPlateText(current)
                        local damage = GetEntityHealth(current)
                        TriggerServerEvent('veh_shop:checkPrice', {model = tostring(model), plate = plate, damage = damage })
                    end
                end
            else
                if(Vdist(d.x, d.y, d.z, pos.x, pos.y, pos.z) < d.activationDist ) then
                    SetTextComponentFormat("STRING")
                    AddTextComponentString(" ~INPUT_MP_TEXT_CHAT_TEAM~ accepter ~INPUT_PUSH_TO_TALK~ refuser")
                    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
                end
                if(IsControlJustReleased(1, 246) and Vdist(d.x, d.y, d.z, pos.x, pos.y, pos.z) <  d.activationDist ) then
                    local current = GetPlayersLastVehicle(GetPlayerPed(-1), true)                    
                    local model = GetEntityModel(current)
                    local plate = GetVehicleNumberPlateText(current)
                    local damage = GetEntityHealth(current)
                    called = false
                    FreezeEntityPosition(GetPlayerPed(-1), false)
                    TriggerServerEvent('veh_shop:sell', {model = tostring(model), plate = plate, damage = damage })
                end
                if(IsControlJustReleased(1, 249) and Vdist(d.x, d.y, d.z, pos.x, pos.y, pos.z) <  d.activationDist ) then
                    called = false
                    FreezeEntityPosition(GetPlayerPed(-1), false)
                end             
            end
           
        end
        for _,d in ipairs( locations ) do
            if Vdist(d.x, d.y, d.z, pos.x, pos.y, pos.z) < 200.0 then
                DrawMarkers(29, d.x, d.y, d.z +1.5, d.markerWidth, 255, 215, 0, 200)
            end
            if(Vdist(d.x, d.y, d.z, pos.x, pos.y, pos.z) < d.activationDist ) then
                SetTextComponentFormat("STRING")
                AddTextComponentString(" ~INPUT_CONTEXT~ pour acceder au magasin.")
                DisplayHelpTextFromStringLabel(0, 0, 1, -1)
            end
            if(IsControlJustReleased(1, 38) and Vdist(d.x, d.y, d.z, pos.x, pos.y, pos.z) <  d.activationDist ) then
                if currentUiState == false then
                    openGui(d.spawnable)
                    currentActionZone = {
                        x = d.x,
                        y = d.y,
                        z= d.z,
                    }
                    currentspawnzone = {
                        x = d.spawn_x,
                        y = d.spawn_y,
                        z= d.spawn_z,
                        direction = d.direction
                    }
                    currentUiState = true
                else
                    closeGui()
                    currentUiState = false
                end
            end
        end

    end
end)
