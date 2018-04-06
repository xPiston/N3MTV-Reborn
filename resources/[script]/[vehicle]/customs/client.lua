
local currentVhl = {
    vehicleId                   = 0,
    doorsclosed             = 0,
    primary_red              = 0,
    primary_green           = 0,
    primary_blue            = 0,
    secondary_red           = 0,
    secondary_green         = 0,
    secondary_blue          = 0,
    extra                   = 0,
    neonColorRed            = 0,
    neonColorGreen          = 0,
    neonColorBlue           = 0,
    tyresSmokeColorRed      = 0,
    tyresSmokeColorGreen    = 0,
    tyresSmokeColorBlue     = 0,
    wheelcolor              = 0,
    plate                   = "",
    model                   = "",
    is_boat                 = false,
    is_plane                = false,
    is_heli                 = false,
    is_car                  = false,
    is_bike                 = false,
    is_bicycle              = false,
    is_quad                 = false,
}

local oldVhl = {}

local currentUiState = false

local locations = {
	{ name= 'lscustoms', x = -212.784408569336, y= -1324.52233886719, z= 29.89040184021, activationDist=12.5, markerWidth = 25.05001, markerType= 72, markerColor= 5 },
	
	--{ name= 'lscustoms', x = -1287.50622558594, y= -2137.49926757813, z= 13.4786577224731, activationDist=12.5, markerWidth = 25.05001, markerType= 72, markerColor= 5 }, -- position aeroport test piste
  }

function msginf(msg, duree)
    duree = duree or 500
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(msg)
    DrawSubtitleTimed(duree, 1)
end

------------------------------------------------------ NUI CALL --------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------

function openGui()
    SetNuiFocus(true)
    SendNUIMessage({ openUI = true })
end

function closeGui()
    SetNuiFocus(false)
    SendNUIMessage({ closeUI = true })
    currentVhl.plate = GetVehicleNumberPlateText(currentVhl.vehicleId)
    currentVhl.model = GetEntityModel(GetPlayersLastVehicle(GetPlayerPed(-1), true))
    TriggerServerEvent('customs:resetvhl', currentVhl)
    currentUiState = false
end

RegisterNetEvent('customs:resetvhlfromdb')
AddEventHandler('customs:resetvhlfromdb', function(veh)
    local vhl = GetVehiclePedIsUsing(GetPlayerPed(-1))
    local customs = json.decode(veh.customs)
    -- Set ModKit to changes apply
    SetVehicleModKit(vhl, 0 )
    -- Set color Primary
    SetVehicleModColor_1(vhl, customs.color.primary.type, 0,0)
    SetVehicleCustomPrimaryColour(vhl, customs.color.primary.red,  customs.color.primary.green,  customs.color.primary.blue)
    -- Set color Secondary
    SetVehicleModColor_2(vhl, customs.color.secondary.type, 0,0)
    SetVehicleCustomSecondaryColour(vhl, customs.color.secondary.red,  customs.color.secondary.green,  customs.color.secondary.blue)
    -- Set perlescent
    SetVehicleExtraColours(vhl, customs.color.pearlescent, customs.wheels.color)
    for i = 0, 49 do  
        if i ~= 11 and i ~= 12 and i ~= 13 and i ~= 15 and i ~= 18 then
            SetVehicleMod(vhl, i, -1, false)
        else
            SetVehicleMod(vhl, i, 0, false)
        end
		if i == 18 and customs.mods[""..i..""] == false then
			ToggleVehicleMod(vhl, 18, false)
		elseif i == 18 and customs.mods[""..i..""] == 1 then
			ToggleVehicleMod(vhl, 18, true)
		end
        if customs.mods[""..i..""] ~= nil then            
            SetVehicleMod(vhl, i, customs.mods[""..i..""], false)
            if i == 11 then
                --SetVehicleEnginePowerMultiplier(vhl, GetVehicleModModifierValue(vhl, i, customs.mods[""..i..""])/5 + 0.1)
            end                 
        end
    end
    SetVehicleMod(vhl, 15, customs.mods["15"], false)
    if veh.type == 1 then
        -- Set neons
        if customs.neons.enabled then
            ToggleVehicleMod(vhl, 22, false)
            SetVehicleNeonLightEnabled(vhl, 0, customs.neons.enabled)
            SetVehicleNeonLightEnabled(vhl, 1, customs.neons.enabled)
            SetVehicleNeonLightEnabled(vhl, 2, customs.neons.enabled)
            SetVehicleNeonLightEnabled(vhl, 3, customs.neons.enabled)
            SetVehicleNeonLightsColour(vhl, customs.neons.red, customs.neons.green, customs.neons.blue)
        end
        -- Set windows
        SetVehicleWindowTint(vhl, customs.windows)
        -- Set Jantes
        SetVehicleWheelType(vhl, tonumber(customs.wheels.type))
        SetVehicleMod(vhl, 23, tonumber(customs.wheels.choice), false)
        SetVehicleMod(vhl, 24, tonumber(customs.wheels.choice), false)
        -- Set Tyreburst
        if customs.tyreburst.enabled then
            ToggleVehicleMod(vhl, 20, true)
            SetVehicleTyreSmokeColor(vhl, customs.tyreburst.red, customs.tyreburst.green, customs.tyreburst.blue)
        end
		if customs.xenons == 1 then
			ToggleVehicleMod(vhl, 22, true)
		else
			ToggleVehicleMod(vhl, 22, false)
		end
		if customs.horn ~= nil then
			SetVehicleMod(vhl, 14, customs.horn)
		end
    end
	local debugvar = false
	local var87 = 10000
	local VehClassModel = GetVehicleClass(vhl) 
	local entitymdl = GetEntityModel(vhl)
	local Model = GetDisplayNameFromVehicleModel(entitymdl)
	
	blacklistedmodel = exports.garages:GetBlacklistedList()
	listedcar = exports.garages:GetBalancedList()
	classmdl = exports.garages:GetBalancedCatList()
	
	if debugvar == true then msginf("NEW CATEGORIE : " .. VehClassModel .. " " .. Model .. " Entity mdl : " .. entitymdl,10000) end
	for k, v in pairs(listedcar) do
		if not IsVehicleModel(vhl, v) then
			table.insert(listedcar, entitymdl)
		end
	end

	for k, v in pairs(listedcar) do
		if IsVehicleModel(vhl, v) then
			for j, l in pairs(classmdl) do
				local GetClassModel = GetVehicleClass(vhl) 
				local Model = GetDisplayNameFromVehicleModel(GetEntityModel(vhl))
				ResultatClassmodel = j
				if GetVehicleClass(vhl) == j then
					local resultatcalcul = GetVehicleModModifierValue(vhl, 11, GetVehicleMod(vhl,11))/l.Multiplicateur + 0.1
					SetVehicleEnginePowerMultiplier(vhl, resultatcalcul)
					globalclassmodelforblacklist = l.classmodel
					blacklistedmultip = l.BlacklistedMultiplicateur
					if debugvar == true then msginf("CATEGORIE : " .. l.classmodel .. " " .. Model .. " V : " .. l.Multiplicateur .. " result : " .. resultatcalcul .. " Vehicule n°: " .. k ,10000) end
					if k == 1080 and debugvar == true then msginf("Voiture non CATEGORISÉ : " .. l.classmodel .. " " .. Model .. " V : " .. l.Multiplicateur .. " Multipl : " .. resultatcalcul .. " Vehicule n°: " .. k ,10000) end
					break
				else
					if debugvar == true then msginf("BUG: " .. GetClassModel .. " V : " .. v .. " J : " .. ResultatClassmodel .. " l : " .. l.classmodel ,10000) end
				end
			end
		end
	end

	for k2, v2 in pairs(blacklistedmodel) do
		if IsVehicleModel(vhl, v2) then
			--Voiture buggé reelement au cas par cas:
			if IsVehicleModel(vhl, blacklistedmodel[6]) then -- PFISTER811
				resultatcalcul = GetVehicleModModifierValue(vhl, 11, GetVehicleMod(vhl,11))/8.5 + 0.1
				SetVehicleEnginePowerMultiplier(vhl, resultatcalcul)
			elseif IsVehicleModel(vhl, blacklistedmodel[2]) then -- SCHAFTERV12
				resultatcalcul = GetVehicleModModifierValue(vhl, 11, GetVehicleMod(vhl,11))/13.5 + 0.1
				SetVehicleEnginePowerMultiplier(vhl, resultatcalcul)
			elseif IsVehicleModel(vhl, blacklistedmodel[10]) then -- SLAMVAN3
				resultatcalcul = GetVehicleModModifierValue(vhl, 11, GetVehicleMod(vhl,11))/23.5 + 0.1 -- 22.5 = 250 km/h |  23.5 = 180 km/h ...
				SetVehicleEnginePowerMultiplier(vhl, resultatcalcul)
			elseif IsVehicleModel(vhl, blacklistedmodel[11]) then -- BANSHEE2
				resultatcalcul = GetVehicleModModifierValue(vhl, 11, GetVehicleMod(vhl,11))/2.5 + 0.1
				SetVehicleEnginePowerMultiplier(vhl, resultatcalcul)
			else
				SetVehicleEnginePowerMultiplier(vhl, GetVehicleModModifierValue(vhl, 11, GetVehicleMod(vhl,11))/blacklistedmultip + 0.1)
				resultatcalcul = math.ceil((GetVehicleMod(vhl,11)/blacklistedmultip + 0.1)*var87)/var87
			end
			if debugvar == true then msginf("~r~NERF CATEGORIE : ~w~" .. globalclassmodelforblacklist .. " ~r~Diviser : " .. blacklistedmultip .. " Multiplicateur : " .. resultatcalcul,10000) end
			break
		end
	end	
end)

-------------------------------------------------- NUI LISTENER --------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

function drawNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

RegisterNetEvent('customs:playsound')
AddEventHandler('customs:playsound', function(soundlib, sound)
    PlaySound(-1, soundlib, sound, 0, 0, 1)
end)

RegisterNetEvent('customs:notifs')
AddEventHandler('customs:notifs', function(notif)
    drawNotification(notif)
end)

RegisterNetEvent('customs:checkifowner_fromdb')
AddEventHandler('customs:checkifowner_fromdb', function(check)
    if not check then
        TriggerEvent("es_freeroam:notify", "CHAR_LS_CUSTOMS", 1, "LS Customs", false, "Tu me prends pour un ~r~con ~w~va t'acheter une caisse ~r~ pauvre type !")
        closeGui()
    end
end)

---------------------- GETTERS -------------------
RegisterNUICallback('changeview', function(data, cb)
    local currentViewMode = GetFollowPedCamViewMode()
    if currentViewMode == 4 then
        SetFollowVehicleCamViewMode(0)
    else
        SetFollowVehicleCamViewMode(4)
    end
    cb('ok')
end)
RegisterNUICallback('opendoors', function(data, cb)
    local doorAngle = GetVehicleDoorAngleRatio(currentVhl.vehicleId, 0)
    if (doorAngle == 0) then -- Door is closed
        for i = -1, 7 do
            SetVehicleDoorOpen(currentVhl.vehicleId, i, 0, 0)
        end
    else
        for i = -1, 7 do
            SetVehicleDoorShut(currentVhl.vehicleId, i, 0, 0)
        end
    end
    cb('ok');
end)

RegisterNUICallback('close', function(data, cb)
    closeGui()
    SetPedIntoVehicle(GetPlayerPed(-1), currentVhl.vehicleId , -1)
    cb('ok')
end)
RegisterNUICallback('nav', function(data, cb)
    PlaySound(-1, 'YES', 'HUD_FRONTEND_DEFAULT_SOUNDSET', 0, 0, 1)
    cb('ok')
end)

RegisterNUICallback('init', function(data, cb)
    currentVhl.vehicleId  = GetVehiclePedIsUsing(GetPlayerPed(-1))
    currentVhl.primary_red, currentVhl.primary_green, currentVhl.primary_blue = GetVehicleCustomPrimaryColour(currentVhl.vehicleId );
    currentVhl.secondary_red, currentVhl.secondary_green, currentVhl.secondary_blue = GetVehicleCustomSecondaryColour(currentVhl.vehicleId );
    currentVhl.neonColorRed, currentVhl.neonColorGreen, currentVhl.neonColorBlue = GetVehicleNeonLightsColour(currentVhl.vehicleId);
    currentVhl.tyresSmokeColorRed, currentVhl.tyresSmokeColorGreen, currentVhl.tyresSmokeColorBlue = GetVehicleTyreSmokeColor(currentVhl.vehicleId);
    currentVhl.extra,currentVhl.wheelcolor = GetVehicleExtraColours(currentVhl.vehicleId);
    currentVhl.wheeltype = GetVehicleWheelType(currentVhl.vehicleId)
    currentVhl.plate = GetVehicleNumberPlateText(currentVhl.vehicleId)
    currentVhl.model = GetEntityModel(currentVhl.vehicleId)

    if GetVehicleDirtLevel(currentVhl.vehicleId) > 0.50 then
        SetVehicleDirtLevel(currentVhl.vehicleId)
        TriggerEvent("es_freeroam:notify", "CHAR_LS_CUSTOMS", 1, "LS Customs", false, "La prochaine fois va laver ta caisse avant, ici c'est pas la zone !")
    end
    -- SetVehicleModKit(currentVhl.vehicleId, 0 )
    if GetVehicleBodyHealth(currentVhl.vehicleId) < 990 then
        local easterEgg = math.random(1,4)
        if easterEgg == 1 then
            TriggerEvent("es_freeroam:notify", "CHAR_LS_CUSTOMS", 1, "LS Customs", false, "Tu te crois où ? ~r~Va réparer ~w~ton véhicule je suis pas ta ~y~boniche !")
        elseif easterEgg == 2 then
            TriggerEvent("es_freeroam:notify", "CHAR_LS_CUSTOMS", 1, "LS Customs", false, "Tu te fous de ma gueule ? C'est quoi ce ~r~taudis~w~ vas ~y~réparer ça !")
        elseif easterEgg == 3 then
            TriggerEvent("es_freeroam:notify", "CHAR_LS_CUSTOMS", 1, "LS Customs", false, "T'es serieux ? ~r~Va réparer~w~ ta ~y~poubelle roulante !")
        else
            TriggerEvent("es_freeroam:notify", "CHAR_LS_CUSTOMS", 1, "LS Customs", false, "OK ... tu veut que je fasse quoi avec ~r~ta merde~w~ ~y~répare moi ça !")
        end
        closeGui()
    end

    if currentVhl.plate ~= nil then
    TriggerServerEvent('customs:checkifowner', currentVhl)
    cb('ok')
    else
        closeGui()
    end
end)



RegisterNUICallback('getbodymodlist', function(data, cb)
    local mods = {}
    local extras = {}
	local extrasMod = {}
    if DoesEntityExist(currentVhl.vehicleId) then

        table.insert(mods, {name = tostring(GetLabelText(GetModTextLabel(currentVhl.vehicleId, 0))),  mod = 0, list = getModObject( currentVhl.vehicleId, 0)})
        table.insert(mods, {name = tostring(GetLabelText(GetModTextLabel(currentVhl.vehicleId, 1))), mod = 1, list = getModObject( currentVhl.vehicleId, 1)})
        table.insert(mods, {name = tostring(GetLabelText(GetModTextLabel(currentVhl.vehicleId, 2))), mod = 2, list = getModObject( currentVhl.vehicleId, 2)})
        table.insert(mods, {name = tostring(GetLabelText(GetModTextLabel(currentVhl.vehicleId, 3))), mod = 3, list = getModObject( currentVhl.vehicleId, 3)})
        table.insert(mods, {name = tostring(GetLabelText(GetModTextLabel(currentVhl.vehicleId, 4))), mod = 4, list = getModObject( currentVhl.vehicleId, 4)})
        table.insert(mods, {name = tostring(GetLabelText(GetModTextLabel(currentVhl.vehicleId, 5))), mod = 5, list = getModObject( currentVhl.vehicleId, 5)})
        table.insert(mods, {name = tostring(GetLabelText(GetModTextLabel(currentVhl.vehicleId, 6))), mod = 6, list = getModObject( currentVhl.vehicleId, 6)})
        table.insert(mods, {name = tostring(GetLabelText(GetModTextLabel(currentVhl.vehicleId, 7))), mod = 7, list = getModObject( currentVhl.vehicleId, 7)})
        table.insert(mods, {name = tostring(GetLabelText(GetModTextLabel(currentVhl.vehicleId, 8))), mod = 8, list = getModObject( currentVhl.vehicleId, 8)})
        table.insert(mods, {name = tostring(GetLabelText(GetModTextLabel(currentVhl.vehicleId, 9))), mod = 9, list = getModObject( currentVhl.vehicleId, 9)})
        table.insert(mods, {name = tostring(GetLabelText(GetModTextLabel(currentVhl.vehicleId, 10))), mod = 10, list = getModObject( currentVhl.vehicleId, 10)})

        table.insert(mods, {name = tostring(GetLabelText(GetModTextLabel(currentVhl.vehicleId, 25))), mod = 25, list = getModObject( currentVhl.vehicleId, 25)})
        table.insert(mods, {name = tostring(GetLabelText(GetModTextLabel(currentVhl.vehicleId, 26))), mod = 26, list = getModObject( currentVhl.vehicleId, 26)})
        table.insert(mods, {name = tostring(GetLabelText(GetModTextLabel(currentVhl.vehicleId, 27))), mod = 27, list = getModObject( currentVhl.vehicleId, 27)})
        table.insert(mods, {name = tostring(GetLabelText(GetModTextLabel(currentVhl.vehicleId, 28))), mod = 28, list = getModObject( currentVhl.vehicleId, 28)})
        table.insert(mods, {name = tostring(GetLabelText(GetModTextLabel(currentVhl.vehicleId, 29))), mod = 29, list = getModObject( currentVhl.vehicleId, 29)})
        table.insert(mods, {name = tostring(GetLabelText(GetModTextLabel(currentVhl.vehicleId, 30))), mod = 30, list = getModObject( currentVhl.vehicleId, 30)})
        table.insert(mods, {name = tostring(GetLabelText(GetModTextLabel(currentVhl.vehicleId, 31))), mod = 31, list = getModObject( currentVhl.vehicleId, 31)})
        table.insert(mods, {name = tostring(GetLabelText(GetModTextLabel(currentVhl.vehicleId, 32))), mod = 32, list = getModObject( currentVhl.vehicleId, 32)})
        table.insert(mods, {name = tostring(GetLabelText(GetModTextLabel(currentVhl.vehicleId, 33))), mod = 33, list = getModObject( currentVhl.vehicleId, 33)})
        table.insert(mods, {name = tostring(GetLabelText(GetModTextLabel(currentVhl.vehicleId, 34))), mod = 34, list = getModObject( currentVhl.vehicleId, 34)})
        table.insert(mods, {name = tostring(GetLabelText(GetModTextLabel(currentVhl.vehicleId, 35))), mod = 35, list = getModObject( currentVhl.vehicleId, 35)})
        table.insert(mods, {name = tostring(GetLabelText(GetModTextLabel(currentVhl.vehicleId, 36))), mod = 36, list = getModObject( currentVhl.vehicleId, 36)})
        table.insert(mods, {name = tostring(GetLabelText(GetModTextLabel(currentVhl.vehicleId, 37))), mod = 37, list = getModObject( currentVhl.vehicleId, 37)})
        table.insert(mods, {name = tostring(GetLabelText(GetModTextLabel(currentVhl.vehicleId, 38))), mod = 38, list = getModObject( currentVhl.vehicleId, 38)})
        table.insert(mods, {name = tostring(GetLabelText(GetModTextLabel(currentVhl.vehicleId, 45))), mod = 45, list = getModObject( currentVhl.vehicleId, 45)})
        table.insert(mods, {name = tostring(GetLabelText(GetModTextLabel(currentVhl.vehicleId, 44))), mod = 44, list = getModObject( currentVhl.vehicleId, 44)})
        table.insert(mods, {name = tostring(GetLabelText(GetModTextLabel(currentVhl.vehicleId, 39))), mod = 39, list = getModObject( currentVhl.vehicleId, 39)})
        table.insert(mods, {name = tostring(GetLabelText(GetModTextLabel(currentVhl.vehicleId, 48))), mod = 48, list = getModObject( currentVhl.vehicleId, 48)})

        for i = 0, 19 do
           -- local exist = DoesExtraExist(currentVhl.vehicleId, i)
			--Citizen.Trace("trololextra ".. i .. " " ..DoesExtraExist(currentVhl.vehicleId, i))
			
			local exist = DoesExtraExist(currentVhl.vehicleId, i)
			
            if  exist then
                table.insert(extras, {n1 = i})
				table.insert(extrasMod, {extraNo = i})
				Citizen.Trace("Extra ".. i .. " " ..DoesExtraExist(currentVhl.vehicleId, i))
            end
        end
        if #extras > 0 then
            --SendNUIMessage({ addextra = json.encode({name = "Extra ", extraNo = extrasMod, list = extras })})

        end
        for i =1,#mods do
            if #mods[i].list > 0 then
                if i > 9 then
                    mods[i].visible = false
                else
                    mods[i].visible = true
                end
                SendNUIMessage({ addmodlist = json.encode(mods[i]) })
            end
        end
    end
    cb('ok')
end)

RegisterNUICallback('getperflist', function(data, cb)
    currentVhl.acceleration = GetVehicleAcceleration(currentVhl.vehicleId)
    currentVhl.brake = GetVehicleMaxBraking(currentVhl.vehicleId)
    SendNUIMessage({ resetstats = true })
    SendNUIMessage({ setperfstats = json.encode({name = 'Acceleration', value= currentVhl.acceleration}) })
    SendNUIMessage({ setperfstats = json.encode({name = 'Freins', value= currentVhl.brake}) })
    cb('ok')
end)

------------------------ TYRES --------------------------
RegisterNUICallback('setwheelcolor', function(data, cb)
    if data.color then currentVhl.wheelcolor = data.color end
    SetVehicleExtraColours(currentVhl.vehicleId, currentVhl.extra, currentVhl.wheelcolor)
    cb('ok')
end)

RegisterNUICallback('gettyreselection', function(data, cb)
    local mods = {}
    local extras = {}
    if DoesEntityExist(currentVhl.vehicleId) then
        SetVehicleWheelType(currentVhl.vehicleId, data.type)
        local list = getModObject( currentVhl.vehicleId, 23)
        for i =0,#list do
            list[i] = list[i] and list[i] or {n1 = "Jantes"} 
            local tyre = {name = list[i], visible = false, type = data.type }
            if i < 10 then
                tyre.visible = true
                tyre.type = data.type
            end
            Citizen.Trace(json.encode(a))
            SendNUIMessage({ addtyrelist = json.encode(tyre)})
        end
    end
    cb('ok')
end)

RegisterNUICallback('settyreselection', function(data, cb)
    SetVehicleMod(currentVhl.vehicleId ,23, data.id, false)
    SetVehicleMod(currentVhl.vehicleId ,24, data.id, false)
    cb('ok')
end)

RegisterNUICallback('settyreburst', function(data, cb)
    ToggleVehicleMod(currentVhl.vehicleId,20,true)
    cb('ok')
end)

RegisterNUICallback('settyreburstcolor', function(data, cb)
    if data.red then currentVhl.tyresSmokeColorRed = data.red end
    if data.green then currentVhl.tyresSmokeColorGreen = data.green end
    if data.blue then currentVhl.tyresSmokeColorBlue = data.blue end
    SetVehicleTyreSmokeColor(currentVhl.vehicleId, currentVhl.tyresSmokeColorRed, currentVhl.tyresSmokeColorGreen, currentVhl.tyresSmokeColorBlue)
    cb('ok')
end)

RegisterNUICallback('settyreburstcolor_rgb', function(data, cb)
    if data.red then currentVhl.tyresSmokeColorRed = data.red end
    if data.green then currentVhl.tyresSmokeColorGreen = data.green end
    if data.blue then currentVhl.tyresSmokeColorBlue = data.blue end
    SetVehicleTyreSmokeColor(currentVhl.vehicleId, currentVhl.tyresSmokeColorRed, currentVhl.tyresSmokeColorGreen, currentVhl.tyresSmokeColorBlue)
    cb('ok')
end)

RegisterNUICallback('extra', function(data, cb)
    for i = 0, 5 do
        SetVehicleExtra(currentVhl.vehicleId, i, 1)
    end
    SetVehicleExtra(currentVhl.vehicleId, data.id +1 , 0)
    cb('ok')
end)

RegisterNUICallback('set_custom_window_tint', function(data, cb)
    SetVehicleWindowTint(currentVhl.vehicleId, data.id)
    cb('ok')
end)
------------------------ NEONS --------------------------
RegisterNUICallback('setneonactive', function(data, cb)
    SetVehicleNeonLightEnabled(currentVhl.vehicleId, 0, data.enabled)
    SetVehicleNeonLightEnabled(currentVhl.vehicleId, 1, data.enabled)
    SetVehicleNeonLightEnabled(currentVhl.vehicleId, 2, data.enabled)
    SetVehicleNeonLightEnabled(currentVhl.vehicleId, 3, data.enabled)
    cb('ok')
end)

RegisterNUICallback('setneoncolor', function(data, cb)
    if data.red then currentVhl.neonColorRed = data.red end
    if data.green then currentVhl.neonColorGreen = data.green end
    if data.blue then currentVhl.neonColorBlue = data.blue end
    SetVehicleNeonLightsColour(currentVhl.vehicleId, currentVhl.neonColorRed,currentVhl.neonColorGreen, currentVhl.neonColorBlue)
    cb('ok')
end)

RegisterNUICallback('setneoncolor_rgb', function(data, cb)
    if data.red then currentVhl.neonColorRed = data.red end
    if data.green then currentVhl.neonColorGreen = data.green end
    if data.blue then currentVhl.neonColorBlue = data.blue end
    SetVehicleNeonLightsColour(currentVhl.vehicleId, currentVhl.neonColorRed,currentVhl.neonColorGreen, currentVhl.neonColorBlue)
    cb('ok')
end)

------------------------ HRON --------------------------
RegisterNUICallback('playhorn', function(data, cb)
    SetPlayerControl(PlayerId(), true, 768)
    cb('ok')
end)
------------------------ MODS --------------------------
RegisterNUICallback('changebodymod', function(data, cb)
    SetVehicleModKit(currentVhl.vehicleId, false )
    if data.mod == 22 and data.id == 1 then
        ToggleVehicleMod(currentVhl.vehicleId, data.mod, true)
    else
        ToggleVehicleMod(currentVhl.vehicleId, data.mod, false)
    end
	
	SetVehicleMod(currentVhl.vehicleId ,data.mod, data.id -1, true)
    if data.mod == 14 then
        SetPedIntoVehicle(GetPlayerPed(-1), currentVhl.vehicleId , 0)
        StartVehicleHorn(currentVhl.vehicleId, 10000, GetHashKey("HELDDOWN"), true)
    end
    cb('ok')
end)

RegisterNUICallback('setperfmod', function(data, cb)
    SetVehicleModKit(currentVhl.vehicleId, false )
    if data.mod == 18 and data.id == 0 then
        ToggleVehicleMod(currentVhl.vehicleId, data.mod, true)
    else
        ToggleVehicleMod(currentVhl.vehicleId, data.mod, false)
    end
    if data.mod == 15 then
        SetVehicleMod(currentVhl.vehicleId, data.mod, data.id-1, false)
    else
        SetVehicleMod(currentVhl.vehicleId, data.mod, data.id, false)
    end
    currentVhl.acceleration = GetVehicleAcceleration(currentVhl.vehicleId)
    currentVhl.brake = GetVehicleMaxBraking(currentVhl.vehicleId)
    SendNUIMessage({ resetstats = true })
    SendNUIMessage({ setperfstats = json.encode({name = 'Acceleration', value= currentVhl.acceleration}) })
    SendNUIMessage({ setperfstats = json.encode({name = 'Freins', value= currentVhl.brake}) })
    -- TriggerEvent('customs:playsound', 'SultanRS_Upgrade', 'JA16_Super_Mod_Garage_Sounds')
    cb('ok')
end)

---------------------- PAINT -------------------------
RegisterNUICallback('change_by_colorpicker', function(data, cb)
    SetVehicleModColor_1(currentVhl.vehicleId, data.type, 0,false)
    SetVehicleCustomPrimaryColour(currentVhl.vehicleId, data.red, data.green, data.blue)
    SetVehicleExtraColours(currentVhl.vehicleId, currentVhl.extra, currentVhl.wheelcolor)
    cb('ok')
end)

RegisterNUICallback('change_by_colorpicker_secondary', function(data, cb)
    SetVehicleModColor_2(currentVhl.vehicleId, data.type, 0,0)
    SetVehicleCustomSecondaryColour(currentVhl.vehicleId, data.red, data.green, data.blue)
    SetVehicleExtraColours(currentVhl.vehicleId, currentVhl.extra, currentVhl.wheelcolor)
    cb('ok')
end)
RegisterNUICallback('change_by_colorpicker_rgb', function(data, cb)
    if data.red     then currentVhl.primary_red     = data.red end
    if data.green   then currentVhl.primary_green   = data.green end
    if data.blue    then currentVhl.primary_blue    = data.blue end
    SetVehicleModColor_1(currentVhl.vehicleId, data.type, 0,0)
    SetVehicleCustomPrimaryColour(currentVhl.vehicleId, currentVhl.primary_red, currentVhl.primary_green, currentVhl.primary_blue)
    SetVehicleExtraColours(currentVhl.vehicleId, currentVhl.extra, currentVhl.wheelcolor)
    cb('ok')
end)

RegisterNUICallback('change_by_colorpicker_secondary_rgb', function(data, cb)
    if data.red     then currentVhl.secondary_red   = data.red end
    if data.green   then currentVhl.secondary_green = data.green end
    if data.blue    then currentVhl.secondary_blue  = data.blue end
    SetVehicleModColor_2(currentVhl.vehicleId, data.type, 0,false)
    SetVehicleCustomSecondaryColour(currentVhl.vehicleId, currentVhl.secondary_red, currentVhl.secondary_green, currentVhl.secondary_blue)
    SetVehicleExtraColours(currentVhl.vehicleId, currentVhl.extra, currentVhl.wheelcolor)
    cb('ok')
end)

RegisterNUICallback('setextracolor', function(data, cb)
    if data.color then currentVhl.extra = data.color end
    SetVehicleExtraColours(currentVhl.vehicleId, currentVhl.extra, currentVhl.wheelcolor)
    cb('ok')
end)

RegisterNUICallback('pay', function(data, cb)
    local tobesended = {
        model = currentVhl.model,
        plate = currentVhl.plate,
    }
    if data.data == 'primary' then
        local type = GetVehicleModColor_1(currentVhl.vehicleId)
        tobesended.mod ='color'
        tobesended.type ='primary'
        currentVhl.primary_red, currentVhl.primary_green, currentVhl.primary_blue = GetVehicleCustomPrimaryColour(currentVhl.vehicleId )
        tobesended.value = { type= type, red = currentVhl.primary_red,green= currentVhl.primary_green, blue = currentVhl.primary_blue}
    elseif data.data == 'secondary' then
        local type = GetVehicleModColor_2(currentVhl.vehicleId)
        tobesended.mod = 'color'
        tobesended.type ='secondary'
        currentVhl.secondary_red, currentVhl.secondary_green, currentVhl.secondary_blue = GetVehicleCustomSecondaryColour(currentVhl.vehicleId )
        tobesended.value ={ type= type, red = currentVhl.secondary_red,green= currentVhl.secondary_green, blue = currentVhl.secondary_blue}
    elseif data.data == 'pearlescent' then
        tobesended.mod ='color'
        tobesended.type ='pearlescent'
        currentVhl.extra,currentVhl.wheelcolor  = GetVehicleExtraColours(currentVhl.vehicleId);
        tobesended.value = currentVhl.extra
    elseif data.data == 'neons' then
        tobesended.mod ='neons'
        tobesended.type =false
        currentVhl.neonColorRed, currentVhl.neonColorGreen, currentVhl.neonColorBlue = GetVehicleNeonLightsColour(currentVhl.vehicleId);
        local enabled = IsVehicleNeonLightEnabled(currentVhl.vehicleId,0)
        tobesended.value = { enabled= enabled , red = currentVhl.neonColorRed,green= currentVhl.neonColorGreen, blue = currentVhl.neonColorBlue}
    elseif data.data == 'xenons' then
        tobesended.mod = 'xenons'
        tobesended.type =false
        local enabled = IsToggleModOn(currentVhl.vehicleId, 22)
        tobesended.value = enabled
    elseif data.data == 'windows' then
        tobesended.mod = 'windows'
        tobesended.type =false
        local value = GetVehicleWindowTint(currentVhl.vehicleId)
        tobesended.value = value
    elseif data.data == 'horn' then
        tobesended.mod = 'horn'
        tobesended.type =false
        local value = GetVehicleMod(currentVhl.vehicleId, 14)
        tobesended.value = value
    elseif data.data == 'performance' then
        tobesended.mod = data.id
        tobesended.type = data.type
        local value = GetVehicleMod(currentVhl.vehicleId, data.id)
        if data.id == 18 then
            tobesended.value = IsToggleModOn(currentVhl.vehicleId, 18)
        else
            tobesended.value = value
        end
    elseif data.data == 'wheels' then
        currentVhl.extra,currentVhl.wheelcolor  = GetVehicleExtraColours(currentVhl.vehicleId);
        tobesended.mod = data.data
        tobesended.type = false
        tobesended.wheeltype = GetVehicleWheelType(currentVhl.vehicleId)
        tobesended.wheelcolor = currentVhl.wheelcolor
        local value = GetVehicleMod(currentVhl.vehicleId ,23)
        tobesended.value = value
    elseif data.data == 'tyreburst' then
        tobesended.mod = data.data
        tobesended.type = false
        currentVhl.secondary_red, currentVhl.secondary_green, currentVhl.secondary_blue = GetVehicleTyreSmokeColor(currentVhl.vehicleId )
        local enabled = IsToggleModOn(currentVhl.vehicleId, 20)
        local value =  { enabled= enabled, red = currentVhl.tyresSmokeColorRed,green= currentVhl.tyresSmokeColorGreen, blue = currentVhl.tyresSmokeColorBlue}
        tobesended.value = value
    elseif type(data.data) == 'number' then
        tobesended.mod = data.data
        tobesended.type =false
        local value = GetVehicleMod(currentVhl.vehicleId, data.data)
        tobesended.value = value
    end
    tobesended.price = data.price
    TriggerServerEvent('customs:buy', json.encode(tobesended))
    cb('ok')
end)

---------------------------------------------------------- THREAD  -----------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
    setMapMarkers(locations)
    while true do
        Citizen.Wait(0)
        local pos = GetEntityCoords(GetPlayerPed(-1), false)
        for _,d in ipairs( locations )do
            if Vdist(d.x, d.y, d.z, pos.x, pos.y, pos.z) < 200.0 then
                DrawMarkers(1, d.x, d.y, d.z, d.markerWidth, 255, 215, 0, 200)
            end
            if(Vdist(d.x, d.y, d.z, pos.x, pos.y, pos.z) < d.activationDist ) and currentUiState == false then
                SetTextComponentFormat("STRING")
                AddTextComponentString(" ~INPUT_CONTEXT~ pour acceder au custom.")
                DisplayHelpTextFromStringLabel(0, 0, 1, -1)
            end
            if currentUiState == true then
                SetTextComponentFormat("STRING")
                AddTextComponentString("~INPUT_FRONTEND_UP~ ~INPUT_FRONTEND_DOWN~ pour naviguer ~INPUT_FRONTEND_ACCEPT~ pour acheter")
                DisplayHelpTextFromStringLabel(0, 0, 1, -1)

                SetTextEntry_2("STRING")
                AddTextComponentString("Appuyez sur ~g~V~s~ pour changer de vue et ~g~H ~s~ pour ouvrir les portes")
                DrawSubtitleTimed(2000, 1)
            end
            if(IsControlJustReleased(1, 38) and Vdist(d.x, d.y, d.z, pos.x, pos.y, pos.z) <  d.activationDist ) then
                if currentUiState == false then
                    openGui()
                    DisableControlAction(0, 38, true)
                    currentUiState = true
                else
                    closeGui()
                    currentUiState = false
                end
            end
        end
    end
end)

---------------------------------------------------- SOME FUNCTIONS ----------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

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

function DrawMarkers(type, x,y,z,markerWidth, markerColorRed, markerColorGreen, markerColorBlue, markerAlpha)
    -- drawMarker(type, posX, posY, posZ, dirX, dirY, dirZ, rotX, rotY, rotZ, scaleX, scaleY, scaleZ, colorR, colorG, colorB, alpha, bobUpAndDown, faceCamera, p19, rotate, textureDict, textureName, drawOnEnts);
    DrawMarker(type, x, y, z, 1.5, 0, 0, 0, 0, 0, markerWidth,  markerWidth,0.051, markerColorRed, markerColorGreen, markerColorBlue,markerAlpha, 0,0,0, 0, 0, 0,0)
end

function getModObject(veh, mod)
    local v = {}
    if GetNumVehicleMods(veh,mod) ~= nil and GetNumVehicleMods(veh,mod) ~= false then
        for i = 0, tonumber(GetNumVehicleMods(veh,mod)) -1 do
            local toBeInserted = {}
            local lbl = GetModTextLabel(veh,mod,i)
            if lbl ~= nil then
                local name = tostring(GetLabelText(lbl))
                if name ~= "NULL" then
                    toBeInserted.n1 = name
                else
                    toBeInserted.n1 = "0"
                end
            else
                toBeInserted.n1 = "0"
            end
            table.insert(v, toBeInserted)
        end
    end
    return v
end
