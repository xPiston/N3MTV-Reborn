local myVehiculeEntity = nil
local inService = false
local spawnVehicleChoix = {}
local VehicleModelKeyTaxi = GetHashKey('taxi')
local KEY_E = 38
local KEY_UP = 96 -- N+
local KEY_DOWN = 97 -- N-
local KEY_CLOSE = 177
local currentBlip = nil
local listMissions = {}
local currentMissions = nil
local myCallMission = nil
local taxi_nbMissionEnAttenteText = '-- Aucune Info --'
local taxi_Bliptaxi = {}
local taxi_call_accept = 0
local taxi_nbtaxiInService = 0
local taxi_nbtaxiDispo = 0

isTaxi = false

local TEXT = {
  AutoTaxiGetIn = '~INPUT_PICKUP~ Entrer dans le de taxi',
  AutoTaxiGetOut = 'Vous pouvez sortir du taxi',
  AutoTaxiMute = '~INPUT_PICKUP~ Allumer/Eteindre la radio',
  AutoTaxiNextRadio = '~INPUT_VEH_NEXT_RADIO~ Prochaine station',
  AutoTaxiSetWayPoint = '~INPUT_PICKUP~ Mettez un point GPS puis appuyer pour partir',

  PrendreService = '~INPUT_PICKUP~ Prendre son service de taxi',
  QuitterService = '~INPUT_PICKUP~ Quitter son service de taxi',
  SpawnVehicle = '~INPUT_PICKUP~ Recuprer son véhicule de ~b~service',
  SpawnVehicleImpossible = '~R~ Impossible, aucune place disponible',

  Blip = 'Course en cours',
  BlipGarage = "Taxi",
  MissionCancel = 'Votre course à été annuler',
  MissionClientAccept = 'Un taxi a prit votre appel',
  MissionClientCancel = 'Votre mécano vous à abandonné',
  InfotaxiNoAppel = '~g~Aucun appel en attente',
  InfotaxiNbAppel = '~w~ Appel en attente',
  BliptaxiService = 'Prise de service',
  BliptaxiVehicle = 'Prise du véhicule de service',

  CALL_INFO_NO_PERSONNEL = '~r~Aucun taxi en service',
  CALL_INFO_ALL_BUSY = '~o~Tous nos taxis sont occupés',
  CALL_INFO_WAIT = '~b~Votre appel est sur attente',
  CALL_INFO_OK = '~g~Un taxi va arriver sur les lieux de l\'appel',
  CALL_INFO_IA_DRIVER = '~g~Un taxi automatique va arriver',
  CALL_INFO_IA_WAITING = '~g~Votre taxi vous attend',
  CALL_INFO_IA_LEAVING = '~o~Votre taxi est reparti',

  CALL_RECU = 'Confirmation\nVotre appel à été enregistré',
  CALL_ACCEPT = 'Votre appel a été accepté, un taxi est en route',
  CALL_CANCEL = 'Le taxi vient d\'abandonné votre appel',
  CALL_FINI = 'Votre appel a été résolu',
  CALL_EN_COURS = 'Vous avez déjà une demande en cours ...',

  MISSION_NEW = 'Une nouvelle course est disponible',
  MISSION_ACCEPT = 'Course acceptée, mettez vous en route',
  MISSION_ANNULE = 'Votre client s\'est décommandé',
  MISSION_CONCURENCE = 'Vous étes plusieurs sur le coup',
  MISSION_INCONNU = 'Cette course n\'est plus d\'actualité',
  MISSION_EN_COURS = 'Il y à deja un collègue sur le coup'

}
-- restart depanneur
local coords = {
  {
    ['PriseDeService'] = {x = 895.18, y = -179.19, z = 74.70},
    ['SpawnVehicleAction'] = { x = 900.08, y = -171.57, z = 74.07},
    ['SpawnVehicle'] = {
      {x = 920.15, y = -163.88, z = 74.40, h = 281.23, type = VehicleModelKeyTaxi},
      {x = 913.68, y = -159.34, z = 74.42, h = 13.135, type = VehicleModelKeyTaxi},
      {x = 911.46, y = -163.10, z = 73.99, h = 14.988, type = VehicleModelKeyTaxi},
      {x = 918.00, y = -167.15, z = 74.19, h = 280.71, type = VehicleModelKeyTaxi},
      {x = 916.37, y = -170.75, z = 74.04, h = 281.02, type = VehicleModelKeyTaxi},
    },
  }
}

--====================================================================================
-- TAXI AUTOMATIQUE
--====================================================================================
local IAspawnPoint = {x = 0.37, y = 0.75, z = 0.04, h = 0.02}       --Spawn point
local IAdriver = nil      --Ped of the IA driver
local IAcar = nil         --Vehicle of the IA driver
local IAstate = 0         --Logical state of the IA
local IAmissionId = 0     --Id of the mission the IA take care of
local IATarget = nil      --GPS point set by the player
local IAactionKey = 38    --E key
local IAradio = true      --Radio State
local IAprice = 0         --Price of the taxi ride
local IAnbrPeople = 1     --number of people
local IAtimeout = 3000    --Timeout of the taxi
local IAfoundZ = true
local IAblip
local IAcurrenttimeout = IAtimeout

local function IAgotoPlayer(type)
  IAstate = 0
  IAfoundZ = true
  IAcurrenttimeout = IAtimeout
  local myPed = GetPlayerPed(-1)
  local myPos = GetEntityCoords(myPed)

  IAnbrPeople = type

  --get spawnpoint
  local x = 0
  local spawnZ = 0
  local isok = false
  local coords = GetOffsetFromEntityInWorldCoords(myPed, x, 70.002, spawnZ)
  isok, spawnZ = GetGroundZFor_3dCoord(coords.x, coords.y, coords.z +1000)
  local isfree = GetClosestVehicle(coords.x, coords.y, spawnZ, 2.0, 0, 70)
  while not IsPointOnRoad(coords.x, coords.y, spawnZ, 0) or isok == false or isfree ~= 0 do --last param is useless https://wiki.rage.mp/index.php?title=Pathfind::isPointOnRoad
    coords = GetOffsetFromEntityInWorldCoords(myPed, x, 70.002, 0)
    isok, spawnZ = GetGroundZFor_3dCoord(coords.x, coords.y, coords.z +1000)
    isfree = GetClosestVehicle(coords.x, coords.y, spawnZ, 2.0, 0, 70)
    Wait(1) -- care for the client
    x = x + 1
  end
  IAspawnPoint.x = coords.x
  IAspawnPoint.y = coords.y
  IAspawnPoint.z = spawnZ
  IAspawnPoint.h = 0.1

  --create the car
  RequestModel(VehicleModelKeyTaxi)
  while not HasModelLoaded(VehicleModelKeyTaxi) do
    Wait(1)
  end
  IAcar = CreateVehicle(VehicleModelKeyTaxi, IAspawnPoint.x, IAspawnPoint.y, IAspawnPoint.z, IAspawnPoint.h, true, false)
  local ObjectId = NetworkGetNetworkIdFromEntity(IAcar)
  SetNetworkIdExistsOnAllMachines(ObjectId, true)
  SetNetworkIdCanMigrate(ObjectId, true)
  SetVehicleOnGroundProperly(IAcar)

  --create the driver
  local hashDriver = GetHashKey('player_zero')
  local random = math.random(0, 2)
  if random == 1 then
    hashDriver = GetHashKey('player_one')
  elseif random == 2 then
    hashDriver = GetHashKey('player_two')
  end
  RequestModel(hashDriver)
  while not HasModelLoaded(hashDriver) do
    Wait(1)
  end
  IAdriver = CreatePed(5, hashDriver, myPos.x, myPos.y, myPos.z, 0, true, true)
  local ObjectId2 = NetworkGetNetworkIdFromEntity(IAdriver)
  SetNetworkIdExistsOnAllMachines(ObjectId2, true)
  SetNetworkIdCanMigrate(ObjectId2, true)

  -- set driver abilities and put it into the vehicle
  SetBlockingOfNonTemporaryEvents(IAdriver, true)
  SetPedCombatAttributes(IAdriver, 46, true)
  SetPedFleeAttributes(IAdriver, 0, 0)
  SetPedRelationshipGroupHash(IAdriver, GetHashKey("CIVFEMALE"))
  SetPedIntoVehicle(IAdriver, IAcar, -1)

  --SetDriverAggressiveness(IAdriver, 0.99)
--  SetDriverAbility(IAdriver, 0.99)
  -- drive to the player pos
--  TaskVehicleDriveToCoord(IAdriver, IAcar, myPos.x, myPos.y, myPos.z, 80.001, 1.1, GetHashKey(vehicle), 786859, 10.0001, true) --http://gtaforums.com/topic/822314-guide-driving-styles/
--  Citizen.InvokeNative(0x158BB33F920D360C, IAdriver, IAcar, myPos.x, myPos.y, myPos.z, 80.001, 1.1, GetHashKey(vehicle), 786859, 10.0001, true) --http://gtaforums.com/topic/822314-guide-driving-styles/
Citizen.InvokeNative(0x158BB33F920D360C, IAdriver, IAcar, myPos.x, myPos.y, myPos.z, 10.01, 0xC00AB, 20.0001)
end

local function IAgotoGPS(myPos)
  -- go to the gps blip
  IATarget = Citizen.InvokeNative(0xFA7C7F0AADF25D09, GetFirstBlipInfoId(8), Citizen.ResultAsVector())
  IAfoundZ, targetZ = GetGroundZFor_3dCoord(IATarget.x, IATarget.y, IATarget.z +1000)
  if IAfoundZ then
    IATarget = vector3(IATarget.x, IATarget.y, targetZ)
  end
  Citizen.Trace("IAfoundZ " .. tostring(IAfoundZ) .. " z " .. targetZ)
--  TaskVehicleDriveToCoord(IAdriver, IAcar, IATarget.x, IATarget.y, IATarget.z, 80.001, 1.1, GetHashKey(vehicle), 786859, 20.0001, true) -- task hash : 0x93a5526e (https://pastebin.com/R9iK6M9W)
  Citizen.InvokeNative(0x158BB33F920D360C, IAdriver, IAcar, IATarget.x, IATarget.y, IATarget.z, 20.0, 0xC00AB, 20.0001) -- task hash : 0x21d33957 (https://pastebin.com/R9iK6M9W)
  --  Citizen.InvokeNative(0x158BB33F920D360C, IAdriver, IAcar, myPos.x, myPos.y, myPos.z, 80.001, 1.1, GetHashKey(vehicle), 786859, 10.0001, true) --http://gtaforums.com/topic/822314-guide-driving-styles/

  -- get the distance aproximatively, i cannot get other Distance fct to work, so i take the distance as the crow flies then qdd 50%
  local distance = GetDistanceBetweenCoords(myPos.x, myPos.y, myPos.z, IATarget.x, IATarget.y, IATarget.z, true) * 1.5
  if distance < 2000 then
    IAprice = 250
  elseif distance >= 2000 and distance < 4000 then
    IAprice = 300
  elseif distance >= 4000 and distance < 6000 then
    IAprice = 350
  elseif distance >= 6000 and distance < 8000 then
    IAprice = 400
  else
    IAprice = 450
  end
end

local function IAtimeoutLoop(taxiPos)
   IAcurrenttimeout = IAcurrenttimeout - 1
  if IAcurrenttimeout <= 0 then -- timeout
    Citizen.Trace('IAcurrenttimeout : ')
    IAstate = 5 -- we release the taxi
  end
end

local function IAactionsLoop()
  if IAdriver ~= nil then
    if IAblip then
      RemoveBlip(IAblip)
    end
    local myPed = GetPlayerPed(-1)
    local myPos = GetEntityCoords(myPed)
    local taxiPos = GetEntityCoords(IAdriver)

    if IAstate == 0 then
      IAblip = AddBlipForCoord(taxiPos.x, taxiPos.y, taxiPos.z)
      SetBlipSprite(currentBlip, 357)
      SetBlipColour(currentBlip, 3)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString("Taxi")
      EndTextCommandSetBlipName(currentBlip)
      if GetScriptTaskStatus(IAdriver, 0x21d33957) == 7 and taxi_call_accept ~= 4 then
        StartVehicleHorn(IAcar, 10000, 0 , 0)
        taxi_call_accept = 4
      end
      if GetDistanceBetweenCoords(myPos.x, myPos.y, myPos.z, taxiPos.x, taxiPos.y, taxiPos.z, true) <= 10 then
        SetTextComponentFormat("STRING")
        AddTextComponentString(TEXT.AutoTaxiGetIn)
        DisplayHelpTextFromStringLabel(0, 0, 1, -1)
        if IsControlJustPressed(0, IAactionKey) then
          taxi_call_accept = 10
          TaskEnterVehicle(myPed, IAcar, -1, 2, 1.5, 1, 0)
          IAstate = 0.5
        end
      end
      if GetScriptTaskStatus(IAdriver, 0x21d33957) == 7 then
        IAtimeoutLoop(taxiPos)
      end
    elseif IAstate == 0.5 then
      if IsPedSittingInVehicle(myPed, IAcar) then
        IAstate = 1
      end
    elseif IAstate == 1 then
      SetTextComponentFormat("STRING")
      AddTextComponentString(TEXT.AutoTaxiSetWayPoint)
      DisplayHelpTextFromStringLabel(0, 0, 1, -1)
      if IsControlJustPressed(0, IAactionKey) then
        IAgotoGPS(myPos)
        Citizen.Wait(500) -- to be sure that the script is launch before calling GetScriptTaskStatus
        IAstate = 2
      end
    elseif IAstate == 2 then
      if IsControlJustPressed(0, IAactionKey) then -- E : key
        IAradio = not IAradio
        SetFrontendRadioActive(IAradio)
      end
      SetTextComponentFormat("STRING")
      AddTextComponentString(TEXT.AutoTaxiMute)
      DisplayHelpTextFromStringLabel(0, 0, 1, -1)
--      if not IAfoundZ then
        if GetDistanceBetweenCoords(taxiPos.x, taxiPos.y, IATarget.z, IATarget.x, IATarget.y, IATarget.z, true) <= 50 then
          Citizen.InvokeNative(0x158BB33F920D360C, IAdriver, IAcar, taxiPos.x, taxiPos.y, taxiPos.z, 15.5, 0xC00AB, 20.0001)
          Wait(100)
        end
--      end
      if GetScriptTaskStatus(IAdriver, 0x21d33957) == 7 then
        IAstate = 3
      end
    elseif IAstate == 3 then
      SetTextComponentFormat("STRING")
      AddTextComponentString(TEXT.AutoTaxiGetOut)
      DisplayHelpTextFromStringLabel(0, 0, 1, -1)
      if IsControlJustPressed(0, 23) then -- F == key F
        IAstate = 4
        Citizen.Wait(3000) -- to be sure that the script is launch before calling GetScriptTaskStatus
      end
    elseif IAstate == 4 then
      if GetScriptTaskStatus(myPed, 0x1ae73569) == 7 then -- 0x1ae73569 == TASK_LEAVE_VEHICLE (https://pastebin.com/R9iK6M9W)
        IAstate = 5
        Citizen.Wait(1000) -- to be sure that the script is launch before calling GetScriptTaskStatus
      end
    elseif IAstate == 5 then
      TriggerServerEvent('taxi:PayAutomaticTaxi', IAprice)
      TaskVehicleDriveWander(IAdriver, IAcar, 10.0, 786859)
      taxi_call_accept = 0
      IAstate = 0
      SetModelAsNoLongerNeeded(IAcar) -- srv will destroy it later
      SetModelAsNoLongerNeeded(IAdriver) -- same

      IAdriver = nil
      IAcar = nil
    end

    if IAstate >= 1 and not IsPedSittingInVehicle(myPed, IAcar) and IAstate < 3 then -- if the player leave the car before the end
      IAstate = 5 -- we release the taxi
    end
  end
end

--====================================================================================
--  Utils function
--====================================================================================
local function showMessageInformation(message, duree)
  duree = duree or 2000
  ClearPrints()
  SetTextEntry_2("STRING")
  AddTextComponentString(message)
  DrawSubtitleTimed(duree, 1)
end


--====================================================================================
--  Gestion de prise et d'abandon de service
--====================================================================================
local function showBliptaxi()
  for _ , c in pairs(coords) do
    local currentBlip = AddBlipForCoord(c.PriseDeService.x, c.PriseDeService.y, c.PriseDeService.z)
    SetBlipSprite(currentBlip, 17)
    SetBlipColour(currentBlip, 25)
    SetBlipAsShortRange(currentBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(TEXT.BliptaxiService)
    EndTextCommandSetBlipName(currentBlip)
    SetBlipAsMissionCreatorBlip(currentBlip, true)
    table.insert(taxi_Bliptaxi, currentBlip)

    local currentBlip2 = AddBlipForCoord(c.SpawnVehicleAction.x, c.SpawnVehicleAction.y, c.SpawnVehicleAction.z)
    SetBlipSprite(currentBlip2, 18)
    SetBlipColour(currentBlip2, 64)
    SetBlipAsShortRange(currentBlip2, true)
    --SetBlipFlashes(currentBlip,1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(TEXT.BliptaxiVehicle)
    EndTextCommandSetBlipName(currentBlip2)
    SetBlipAsMissionCreatorBlip(currentBlip2, true)
    table.insert(taxi_Bliptaxi, currentBlip2)
  end
end

local function removeBliptaxi()
  for _ , c in pairs(taxi_Bliptaxi) do
    RemoveBlip(c)
  end
  taxi_Bliptaxi = {}
end

function spawnVehicle(coords, type)
  deleteVehicle()
  for _, pos in pairs(coords) do
    if pos.type == type then
      local vehi = GetClosestVehicle(pos.x, pos.y, pos.z, 2.0, 0, 70)
      -- Citizen.Trace('vehi : ' .. vehi)
      if vehi == 0 then
        RequestModel(type)
        while not HasModelLoaded(type) do
          Wait(1)
        end
        myVehiculeEntity = CreateVehicle(type, pos.x, pos.y, pos.z, pos.h , true, false)
        SetVehicleNumberPlateText(myVehiculeEntity, "Taxi-" .. math.random(100,999))
        local ObjectId = NetworkGetNetworkIdFromEntity(myVehiculeEntity)
        SetNetworkIdExistsOnAllMachines(ObjectId, true)

        local p = GetEntityCoords(myVehiculeEntity, 0)
        local h = GetEntityHeading(myVehiculeEntity)
        --showMessageInformation('Pos: ' .. p.x .. ' ' .. p.y .. ' ' .. p.z .. ' ' .. h)
        return
      end
    end
  end
  -- Citizen.Trace('impossible')
  notifIcon("CHAR_BLANK_ENTRY", 1, "taxi", false, TEXT.SpawnVehicleImpossible)
  -- local myPed = GetPlayerPed(-1)
  -- local player = PlayerId()
  -- RequestModel(VehicleModelKeyTowTruck)
  -- while not HasModelLoaded(VehicleModelKeyTowTruck) do
  --     Wait(1)
  -- end

  -- local coords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, 5.0, 0)
  -- myVehiculeEntity = CreateVehicle(VehicleModelKeyTowTruck, coords.x, coords.y, coords.z, 0 , true, false)
  -- DecorSetInt(myVehiculeEntity, 'VehicleDepa', 1)
  -- SetVehicleNumberPlateText(myVehiculeEntity, "Depa001")
  -- local ObjectId = NetworkGetNetworkIdFromEntity(myVehiculeEntity)
  -- SetNetworkIdExistsOnAllMachines(ObjectId, true)
end


local function toogleService()
  inService = not inService
  if inService then
    local myPed = GetPlayerPed(-1)
    TriggerServerEvent('taxi:takeService')
    TriggerServerEvent('taxi:requestMission')
  else
    -- Restaure Ped
    TriggerServerEvent('taxi:endService')
    TriggerServerEvent("skin_customization:SpawnPlayer")
  end
end

local function gestionService()
  local myPed = GetPlayerPed(-1)
  local myPos = GetEntityCoords(myPed)
  for _, coordData in pairs(coords) do
    local pos = coordData.PriseDeService
    local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, myPos.x, myPos.y, myPos.z, false)
    if dist <= 20 then
      DrawMarker(1, pos.x, pos.y, pos.z - 1.0, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.5, 0, 0, 255, 200, 0, 0, 0, 0)
    end
    if dist <= 1 then
      if inService then
        --showMessageInformation(TEXT.QuitterService, 60)
        SetTextComponentFormat("STRING")
        AddTextComponentString(TEXT.QuitterService)
        DisplayHelpTextFromStringLabel(0, 0, 1, -1)
      else
        SetTextComponentFormat("STRING")
        AddTextComponentString(TEXT.PrendreService)
        DisplayHelpTextFromStringLabel(0, 0, 1, -1)
        --showMessageInformation(TEXT.PrendreService, 60)
      end
      if IsControlJustPressed(0, KEY_E) then
        toogleService()
      end
    end

    if inService then
      local pos = coordData.SpawnVehicleAction
      local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, myPos.x, myPos.y, myPos.z, false)
      if dist <= 20 then
        DrawMarker(1, pos.x, pos.y, pos.z - 1.0, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.5, 0, 128, 0, 200, 0, 0, 0, 0)
      end
      if dist <= 1 then
        -- showMessageInformation(TEXT.SpawnVehicle, 60)
        SetTextComponentFormat("STRING")
        AddTextComponentString(TEXT.SpawnVehicle)
        DisplayHelpTextFromStringLabel(0, 0, 1, -1)
        if IsControlJustPressed(0, KEY_E) then
          spawnVehicle(coordData.SpawnVehicle, VehicleModelKeyTaxi)
        end
      end
    end
  end
end


--====================================================================================
--
--====================================================================================

function showInfoClient()
  if taxi_call_accept ~= 0 and taxi_call_accept ~= 10 then

    local offsetX = 0.87
    local offsetY = 0.785
    DrawRect(offsetX, offsetY, 0.23, 0.035, 0, 0, 0, 215)

    SetTextFont(1)
    SetTextScale(0.0,0.5)
    SetTextCentre(true)
    SetTextDropShadow(0, 0, 0, 0, 0)
    SetTextEdge(0, 0, 0, 0, 0)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    if taxi_call_accept == 1 then
      AddTextComponentString(TEXT.CALL_INFO_OK)
    elseif taxi_call_accept == 3 then
      AddTextComponentString(TEXT.CALL_INFO_IA_DRIVER)
    elseif taxi_call_accept == 4 then
      AddTextComponentString(TEXT.CALL_INFO_IA_WAITING)
    elseif taxi_call_accept == 5 then
      AddTextComponentString(TEXT.CALL_INFO_IA_LEAVING)
    else
      if taxi_nbtaxiInService == 0 then
        AddTextComponentString(TEXT.CALL_INFO_NO_PERSONNEL)
      elseif taxi_nbtaxiDispo == 0 then
        AddTextComponentString(TEXT.CALL_INFO_ALL_BUSY)
      else
        AddTextComponentString(TEXT.CALL_INFO_WAIT)
      end
    end
    DrawText(offsetX, offsetY - 0.015 )
  end
end

function showInfoJobs()
  local offsetX = 0.9
  local offsetY = 0.845
  DrawRect(offsetX, offsetY, 0.15, 0.07, 0, 0, 0, 215)

  SetTextFont(1)
  SetTextScale(0.0,0.5)
  SetTextCentre(true)
  SetTextDropShadow(0, 0, 0, 0, 0)
  SetTextEdge(0, 0, 0, 0, 0)
  SetTextColour(255, 255, 255, 255)
  SetTextEntry("STRING")
  AddTextComponentString('~o~Taxi Info')
  DrawText(offsetX, offsetY - 0.03)

  SetTextFont(1)
  SetTextScale(0.0,0.5)
  SetTextCentre(false)
  SetTextDropShadow(0, 0, 0, 0, 0)
  SetTextEdge(0, 0, 0, 0, 0)
  SetTextColour(255, 255, 255, 255)
  SetTextEntry("STRING")

  AddTextComponentString(taxi_nbMissionEnAttenteText)
  DrawText(offsetX - 0.065, offsetY -0.002)
end

function deleteVehicle()
  if myVehiculeEntity ~= nil then
    DeleteVehicle(myVehiculeEntity)
    myVehiculeEntity = nil
  end
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(10)

    IAactionsLoop()

    if isTaxi then
      gestionService()
      if inService then
        showInfoJobs()
      end
    end

    if taxi_call_accept ~= 0 then
      showInfoClient()
    end
  end
end)

--
RegisterNetEvent("taxi:callAutoTaxi")
AddEventHandler("taxi:callAutoTaxi",function(source, position, type)
  if taxi_call_accept == 0 then
    IAgotoPlayer(type)
  end
end)

RegisterNetEvent('taxi:drawMarker')
AddEventHandler('taxi:drawMarker', function (boolean)
  isTaxi = boolean
  if isTaxi then
    showBliptaxi()
  else
    removeBliptaxi()
  end
end)
RegisterNetEvent('taxi:drawBlips')
AddEventHandler('taxi:drawBlips', function ()
end)
RegisterNetEvent('taxi:marker')
AddEventHandler('taxi:marker', function ()
end)

RegisterNetEvent('taxi:deleteBlips')
AddEventHandler('taxi:deleteBlips', function ()
  isTaxi = false
  removeBliptaxi()
end)

--====================================================================================
-- Serveur - Client Trigger
-- restart depanneur
--====================================================================================

function notifIcon(icon, type, sender, title, text)
  Citizen.CreateThread(function()
    Wait(1)
    SetNotificationTextEntry("STRING");
    if TEXT[text] ~= nil then
      text = TEXT[text]
    end
    AddTextComponentString(text);
    SetNotificationMessage(icon, icon, true, type, sender, title, text);
    DrawNotification(false, true);
  end)
end

RegisterNetEvent("taxi:PersonnelMessage")
AddEventHandler("taxi:PersonnelMessage",function(message)
  if inService then
    notifIcon("CHAR_BLANK_ENTRY", 1, "Taxi Info", false, message)
  end
end)

RegisterNetEvent("taxi:ClientMessage")
AddEventHandler("taxi:ClientMessage",function(message)
  notifIcon("CHAR_BLANK_ENTRY", 1, "Taxi", false, message)
end)


--=== restart depanneur
function acceptMission(data)
  local mission = data.mission
  TriggerServerEvent('taxi:AcceptMission', mission.id)
end

function finishCurrentMission()
  TriggerServerEvent('taxi:FinishMission', currentMissions.id)
  currentMissions = nil
  if currentBlip ~= nil then
    RemoveBlip(currentBlip)
  end
end

function updateMenuMission()
  local items = {}
  for _,m in pairs(listMissions) do
    local item = {
      Title = 'Mission ' .. m.id .. ' [' .. m.type .. ']',
      mission = m,
      Function = acceptMission
    }
    if #m.acceptBy ~= 0 then
      item.Title = item.Title .. ' (En cours)'
      item.TextColor = {39, 174, 96, 255}
    end
    table.insert(items, item)
  end
  if currentMissions ~= nil then
    table.insert(items, {['Title'] = 'Terminer la mission', ['Function'] = finishCurrentMission})
  end
  table.insert(items, {['Title'] = 'Fermer'})

  menu = items
  updateMenu(menu)
end

RegisterNetEvent('taxi:MissionAccept')
AddEventHandler('taxi:MissionAccept', function (mission)
  currentMissions = mission
  SetNewWaypoint(mission.pos[1], mission.pos[2])
  currentBlip= AddBlipForCoord(mission.pos[1], mission.pos[2], mission.pos[3])
  SetBlipSprite(currentBlip, 309)
  SetBlipColour(currentBlip, 5)
  SetBlipAsShortRange(currentBlip, true)
  --SetBlipFlashes(currentBlip,1)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString(TEXT.Blip)
  EndTextCommandSetBlipName(currentBlip)
  SetBlipAsMissionCreatorBlip(currentBlip, true)

end)


RegisterNetEvent('taxi:MissionCancel')
AddEventHandler('taxi:MissionCancel', function ()
  currentMissions = nil
  if currentBlip ~= nil then
    RemoveBlip(currentBlip)
  end
end)

RegisterNetEvent('taxi:MissionChange')
AddEventHandler('taxi:MissionChange', function (missions)
  if not inService then
    return
  end
  listMissions = missions

  local nbMissionEnAttente = 0

  for _,m in pairs(listMissions) do

    if #m.acceptBy == 0 then
      nbMissionEnAttente = nbMissionEnAttente + 1
    end
  end
  if nbMissionEnAttente == 0 then
    taxi_nbMissionEnAttenteText = TEXT.InfotaxiNoAppel
  else
    taxi_nbMissionEnAttenteText = '~g~ ' .. nbMissionEnAttente .. ' ' .. TEXT.InfotaxiNbAppel
  end

  updateMenuMission()
end)


function callService(type)
  local myPed = GetPlayerPed(-1)
  local myCoord = GetEntityCoords(myPed)
  TriggerServerEvent('taxi:Call', myCoord.x, myCoord.y, myCoord.z, type)
end

function toogleHelperLine()
  ShowLineGrueHelp = not ShowLineGrueHelp
end
RegisterNetEvent('taxi:openMenu')
AddEventHandler('taxi:openMenu', function()
  if inService then
    TriggerServerEvent('taxi:requestMission')
    openMenuGeneral()
  else
    showMessageInformation("~r~Vous devais etre en service pour accedez au menu")
  end
end)

RegisterNetEvent('taxi:callService')
AddEventHandler('taxi:callService',function(data)
  callService(data.type)
end)

RegisterNetEvent('taxi:callServiceCustom')
AddEventHandler('taxi:callServiceCustom',function(data)
  local info = openTextInput('', '', 128)
  if info ~= nil and info ~= '' then
    callService(info)
  end
end)

RegisterNetEvent('taxi:callStatus')
AddEventHandler('taxi:callStatus',function(status)
  taxi_call_accept = status
end)

RegisterNetEvent('taxi:personnelChange')
AddEventHandler('taxi:personnelChange',function(nbPersonnel, nbDispo)
  taxi_nbtaxiInService = nbPersonnel
  taxi_nbtaxiDispo = nbDispo
end)

RegisterNetEvent('taxi:cancelCall')
AddEventHandler('taxi:cancelCall',function(data)
  TriggerServerEvent('taxi:cancelCall')
  if IAdriver then
    IAstate = 5
  end
end)



function openTextInput(title, defaultText, maxlength)
  DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", defaultText or "", "", "", "", maxlength or 180)
  while (UpdateOnscreenKeyboard() == 0) do
    DisableAllControlActions(0);
    Wait(0);
  end
  if (GetOnscreenKeyboardResult()) then
    return GetOnscreenKeyboardResult()
  end
  return nil
end


--Citizen.Trace("taxi load")
TriggerServerEvent('taxi:requestPersonnel')



-- isTaxi = true
-- toogleService()


-- ----[[ DEBUG
-- local myPed = GetPlayerPed(-1)
-- local myCoord = GetEntityCoords(myPed)
-- -- toogleService()
-- Citizen.Trace('Pos init: ' .. myCoord.x .. ', ' .. myCoord.y .. ', ' .. myCoord.z)

-- -- local l = math.floor(math.random() * #coords) + 1
-- -- -- Citizen.Trace('Tp at ' .. l )
-- -- local pos = coords[l].SpawnVehicleAction
-- -- --SetEntityCoords(myPed, pos.x, pos.y, pos.z)

-- -- --]]
-- toogleService()
-- isTaxi = true
-- -- local myPed = GetPlayerPed(-1)
-- -- local myCoord = GetEntityCoords(myPed)
-- -- local any = nil
-- -- AddRope(
-- -- myCoord.x, myCoord.y, myCoord.z,
-- -- 0.0, 0.0, 0.0,
-- -- 5.0, 1, 4.5, 5.5,
-- -- 0,0,0,
-- -- 0,0,0,Citizen.ReturnResultAnyway())
-- local function GetVehicleInDirection( coordFrom, coordTo )
--     local rayHandle = CastRayPointToPoint( coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed( -1 ), 0 )
--     local _, _, _, _, vehicle = GetRaycastResult( rayHandle )
--     return vehicle
-- end

-- local function GetVehicleLookByPlayer(ped, dist)
--     local playerPos =GetOffsetFromEntityInWorldCoords( ped, 0.0, 0.0, 0.0 )
--     local inFrontOfPlayer = GetOffsetFromEntityInWorldCoords( ped, 0.0, dist, -0.8 )
--     return GetVehicleInDirection( playerPos, inFrontOfPlayer )
-- end
-- local my= GetPlayerPed(-1)
-- local vi = GetVehicleLookByPlayer(my, 3.0)
-- if vi ~= nil then
--     local myCoord = GetEntityCoords(vi)
--     local h = GetEntityHeading(vi)
--     Citizen.Trace('Car init: ' .. myCoord.x .. ', ' .. myCoord.y .. ', ' .. myCoord.z ..  ', h :  ' .. h)
-- end

-- Citizen.CreateThread(function()
--     while true do
--     Citizen.Wait(1)
--     local ped = GetPlayerPed(-1)
--            local playerPos = GetEntityCoords( ped, 1 )
--            local p = GetOffsetFromEntityInWorldCoords( ped, 0.0, 0.0, 0.0 )
--         local p1 = GetOffsetFromEntityInWorldCoords( ped, 0.0, 3.0, -0.8)
--         DrawLine(p.x, p.y, p.z, p1.x, p1.y, p1.z, 255,0,0,255)
--     end
-- end)
