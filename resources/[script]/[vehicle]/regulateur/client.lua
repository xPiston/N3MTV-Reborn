
local TEXT = {
    PasVehicule = "~r~Il faut être dans le vehicule",
    VehiculeDeverrouilleOk = '~g~Le véhicule est ouvert pour tous',
    VehiculeDeverrouilleKo = '~o~Quelque chose ne se passe pas comme prévu...',    
}

local notificationParam = 1 -- 1 = LockSystem notification | 2 = chatMessage notification | 3 = nothing
local keyParam = 246 -- e.g : Keys["H"] will be change the U key to the H key for lock/unlock a vehicle
local soundEnable = false -- Set to false for disable sounds

Citizen.CreateThread(function()
	while true do
		Wait(0)

		if IsControlJustPressed(1, keyParam) then

			lockunlock()
			
		end
	end
end)

RegisterNetEvent("ls:lock")
AddEventHandler("ls:lock", function(lockStatus, plate)

	isPlayerInside = IsPedInAnyVehicle(player, true)
	
	player = GetPlayerPed(-1)
	local vehicle = GetVehiclePedIsIn(player, false)

			--player = GetPlayerPed(-1)
			lastVehicle = GetPlayersLastVehicle()

			playerCoords = GetEntityCoords(player, true)
			px, py, pz = playerCoords.x, playerCoords.y, playerCoords.z

			isPlayerInside = IsPedInAnyVehicle(player, true)

			coordA = GetEntityCoords(player, true)
			
			for i = 1, 32 do
				coordB = GetOffsetFromEntityInWorldCoords(player, 0.0, (6.281)/i, 0.0)	
				targetVehicle = GetVehicleInDirection(coordA, coordB)
				if targetVehicle ~= nil and targetVehicle ~= 0 then
					vx, vy, vz = table.unpack(GetEntityCoords(targetVehicle, false))
						if GetDistanceBetweenCoords(px, py, pz, vx, vy, vz, false) then
							distance = GetDistanceBetweenCoords(px, py, pz, vx, vy, vz, false)
							vehicle = targetVehicle
							break
						end
				end
			end
			
	local platetest = GetVehicleNumberPlateText(vehicle)	
if plate == platetest then
	if lockStatus == 1 or lockStatus == 0 then

		SetVehicleDoorsLocked(vehicle, 2)
		SetVehicleDoorsLockedForPlayer(vehicle, PlayerId(), false)

		TriggerEvent("ls:sendNotification", notificationParam, "Véhicule fermé.", 0.080)

		if soundEnable then
			TriggerEvent('InteractSound_CL:PlayOnOne', 'lock', 1.0)
		end

		TriggerServerEvent("ls:changeLockStatus", 2, plate)
		
		if not isPlayerInside then
			engineStatus = SetVehicleEngineOn(vehicle, false, true, true)
		end
	else

		SetVehicleDoorsLocked(vehicle, 1)

		TriggerEvent("ls:sendNotification", notificationParam, "Véhicule ouvert.", 0.080)

		if soundEnable then
			TriggerEvent('InteractSound_CL:PlayOnOne', 'unlock', 1.0)
		end

		TriggerServerEvent("ls:changeLockStatus", 1, plate)
	end
end
end)

RegisterNetEvent("ls:notify")
AddEventHandler("ls:notify", function(text, time)

	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	Citizen.InvokeNative(0x1E6611149DB3DB6B, "CHAR_LIFEINVADER", "CHAR_LIFEINVADER", true, 1, "Porte-Clés", " ", time)
	DrawNotification_4(false, true)
end)

-- function GetVehicleInDirection(coordFrom, coordTo)

	-- local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed(-1), 0)
	-- local a, b, c, d, vehicle = GetRaycastResult(rayHandle)
	-- return vehicle
-- end

RegisterNetEvent("ls:sendNotification")
AddEventHandler("ls:sendNotification", function(param, message, duration)
	if param == 1 then
		TriggerEvent("ls:notify", message, duration)
	elseif param == 2 then
		TriggerEvent('chatMessage', 'Porte-Clés', { 255, 128, 0 }, message)
	end
end)


function GetVehicleInDirection( coordFrom, coordTo )
    local rayHandle = CastRayPointToPoint( coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed( -1 ), 0 )
    local _, _, _, _, vehicle = GetRaycastResult( rayHandle )
    return vehicle
end

function GetVehicleLookByPlayer(ped, dist)
    local playerPos =GetOffsetFromEntityInWorldCoords( ped, 0.0, 0.0, 0.0 )
    local inFrontOfPlayer = GetOffsetFromEntityInWorldCoords( ped, 0.0, dist, -0.8 )
    return GetVehicleInDirection( playerPos, inFrontOfPlayer )
end

function unlockVehiculeForAll()
    local myPed = GetPlayerPed(-1)
    local vehicle = GetVehicleLookByPlayer(myPed, 3.0)
    if vehicle ~= 0 then 
        if math.random() > -0.25 then
            TaskWarpPedIntoVehicle(myPed, vehicle, -1)
            SetVehicleDoorsLocked(vehicle, 1)
            showMessageInformation(TEXT.VehiculeDeverrouilleOk)
        else   
            startAlarm(vehicle)
            showMessageInformation(TEXT.VehiculeDeverrouilleKo) 
        end
    else
        showMessageInformation(TEXT.PasVehicule)
    end
end

function openVehicleDoorData(data)
    local myPed = GetPlayerPed(-1)
   -- local myCoord = GetEntityCoords(myPed)
    local vehicle = GetVehiclePedIsIn(myPed, false)
    if vehicle ~= 0 then
        local porte = data.Porte or -1 
        if porte == -1 then 
            SetVehicleDoorOpen(vehicle, 0, 0, 0)
            SetVehicleDoorOpen(vehicle, 1, 0, 0)
            SetVehicleDoorOpen(vehicle, 2, 0, 0)
            SetVehicleDoorOpen(vehicle, 3, 0, 0)
            SetVehicleDoorOpen(vehicle, 4, 0, 0)
            SetVehicleDoorOpen(vehicle, 5, 0, 0)
            SetVehicleDoorOpen(vehicle, 6, 0, 0)
            SetVehicleDoorOpen(vehicle, 7, 0, 0)
        else
            SetVehicleDoorOpen(vehicle, porte, 0, 0)
        end
    else
        showMessageInformation(TEXT.PasVehicule)
    end
end

function closeVehicleDoorData(data)
    local myPed = GetPlayerPed(-1)
   -- local myCoord = GetEntityCoords(myPed)
    local vehicle = GetVehiclePedIsIn(myPed, false)
	
    if vehicle ~= 0 then
        local porte = data.Porte or -1 
        if porte == -1 then 
            SetVehicleDoorShut(vehicle, 0, 0)
            SetVehicleDoorShut(vehicle, 1, 0)
            SetVehicleDoorShut(vehicle, 2, 0)
            SetVehicleDoorShut(vehicle, 3, 0)
            SetVehicleDoorShut(vehicle, 4, 0)
            SetVehicleDoorShut(vehicle, 5, 0)
            SetVehicleDoorShut(vehicle, 6, 0)
            SetVehicleDoorShut(vehicle, 7, 0)
        else
            SetVehicleDoorShut(vehicle, porte, 0, 0)
        end
    else
        showMessageInformation(TEXT.PasVehicule)
    end
end


function ToggleDoorData(data)
    local myPed = GetPlayerPed(-1)
   -- local myCoord = GetEntityCoords(myPed)
    local vehicle = GetVehiclePedIsIn(myPed, false)
	
	if vehicle ~= 0 then
	
		local porte = data.Porte
		local doorAngle = GetVehicleDoorAngleRatio(vehicle, porte)
        if (doorAngle == 0) then -- Door is closed
			SetVehicleDoorOpen(vehicle, porte, 0, 0)
        else
			SetVehicleDoorShut(vehicle, porte, 0, 0)
    	end
    else
        showMessageInformation(TEXT.PasVehicule)
    end
end


function lockunlock()
	player = GetPlayerPed(-1)
	local vehicle = GetVehiclePedIsIn(player, false)

			--player = GetPlayerPed(-1)
			lastVehicle = GetPlayersLastVehicle()

			playerCoords = GetEntityCoords(player, true)
			px, py, pz = playerCoords.x, playerCoords.y, playerCoords.z

			isPlayerInside = IsPedInAnyVehicle(player, true)

			coordA = GetEntityCoords(player, true)
			
			for i = 1, 32 do
				coordB = GetOffsetFromEntityInWorldCoords(player, 0.0, (6.281)/i, 0.0)	
				targetVehicle = GetVehicleInDirection(coordA, coordB)
				if targetVehicle ~= nil and targetVehicle ~= 0 then
					vx, vy, vz = table.unpack(GetEntityCoords(targetVehicle, false))
						if GetDistanceBetweenCoords(px, py, pz, vx, vy, vz, false) then
							distance = GetDistanceBetweenCoords(px, py, pz, vx, vy, vz, false)
							break
						end
				end
			end

				
				
			if distance ~= nil and distance <= 5 and targetVehicle ~= 0 or vehicle ~= 0 then
					
				if IsEntityAMissionEntity(vehicle) or IsEntityAMissionEntity(targetVehicle)then

					if vehicle ~= 0 then
						plate = GetVehicleNumberPlateText(vehicle)
					else
						vehicle = targetVehicle
						plate = GetVehicleNumberPlateText(vehicle)
					end

					TriggerServerEvent("ls:check", plate, isPlayerInside, notificationParam)
				else
					drawNotification("Ceci est un véhicule Moldu, tu ne peux pas le vérrouiller !")
				end

			end
				
end

function EngineToggle()
	player = GetPlayerPed(-1)
	local vehicle = GetVehiclePedIsIn(player, false)
	if IsVehicleEngineOn(vehicle) then
		--SetVehiclePetrolTankHealth( vehicle, 0 )
		SetVehicleEngineOn(vehicle, false, false, true)
	else
		SetVehicleEngineOn(vehicle, true, false, true)
		--SetVehiclePetrolTankHealth( vehicle, 1000 )
	end
end

local speedLimit = 0
Citizen.CreateThread( function()
    while true do 
        Citizen.Wait( 0 )   
        local ped = GetPlayerPed(-1)
        local vehicle = GetVehiclePedIsIn(ped, false)
        local vehicleModel = GetEntityModel(vehicle)
        local speed = GetEntitySpeed(vehicle)
        local inVehicle = IsPedSittingInAnyVehicle(ped)
        local float Max = GetVehicleMaxSpeed(vehicleModel)
        if ped and inVehicle then
            if IsControlJustPressed(1, 97) then
                if (GetPedInVehicleSeat(vehicle, -1) == ped) then
                    if CruiseControl == 0 then
                        speedLimit = speed
                        SetEntityMaxSpeed(vehicle, speedLimit)
						drawNotification("~y~Régulateur: ~g~Active\n~s~MAX speed ".. math.floor(speedLimit*3.6).."kmh")
						Citizen.Wait(1000)
				        DisplayHelpText("Ajuster votre vitesse avec ~Page Up~ - ~Page Down~")
						PlaySound(-1, "COLLECTED", "HUD_AWARDS", 0, 0, 1)
                        CruiseControl = 1
                    else
                        SetEntityMaxSpeed(vehicle, Max)
						drawNotification("~y~Régulateur: ~r~Désactivé")						
                        CruiseControl = 0
                    end
                else
				    drawNotification("Action disponible en voiture")						
                end
            elseif IsControlJustPressed(1, 10) then
                if CruiseControl == 1 then
                    speedLimit = speedLimit + 1.38
                    SetEntityMaxSpeed(vehicle, speedLimit)
					PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
					DisplayHelpText("Vitesse Maximale ".. math.floor(speedLimit*3.6).. "kmh")
                end
            elseif IsControlJustPressed(1, 11) then
                if CruiseControl == 1 then
                    speedLimit = speedLimit - 1.38
					if speedLimit < 0 then speedLimit = 0 end
                    SetEntityMaxSpeed(vehicle, speedLimit)
					PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)	
					DisplayHelpText("Vitesse Maximale ".. math.floor(speedLimit*3.6).. "kmh")
                end
            end
        end
    end
end)

function drawNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

function DrawMissionText2(m_text, showtime)
    ClearPrints()
	SetTextEntry_2("STRING")
	AddTextComponentString(m_text)
	DrawSubtitleTimed(showtime, 1)
end

function Notify(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    DrawNotification(false, false)
end

function drawNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(true, true)
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function showMessageInformation(message, duree)
    duree = duree or 2000
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(message)
    DrawSubtitleTimed(duree, 1)
end