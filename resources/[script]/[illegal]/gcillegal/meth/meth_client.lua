--=============================================================================
-- #Author: Jonathan D @ Gannon
--=============================================================================

--=============================================================================
--  Config
--=============================================================================
local myPed = GetPlayerPed(-1)
local myPos = GetEntityCoords(myPed)
local currentVehicle = 0 
local isGoodVehcile = false
local currentCharge = 0

DecorRegister('illegal_chargeMeth', 3)

Meth = {}
Meth.coords = {
    produitChimique = { x = 970.728 , y = -1623.96 , z = 30.1107},
    --produitChimique = { x = 2459.34 , y = 3449.22 , z = 49.84},
    tranformeToMeth = { x = 1414.11 , y = 3813.29 , z = 32.3067},
    venteMeth = { x = 15.417, y = 3733.67, z = 39.6772}
}
Meth.vehicle = GetHashKey('journey')
Meth.objectId = 11
Meth.prixVente = 220
Meth.Text = {
    NeedVehicle = '~b~Methylamine\n~g~Un labo mobile Ã  la breaking bad, tu connais ?',
    BadVehicle = '~o~ Ce véhicule ne va pas faire l\'affaire, trouve autre chose',
    ChargementVehicle = '~b~ Chargement du véhicule',
    ChargementFullVehicle = '~g~ Le véhicule est plein\n~r~ Mettez vous en route, trouve le bon endroit',
    TransformToMeth = '~o~Fabrication de meth',
    CreateMeth = '~o~ +1 Meth',
    VenteEnCours = '~b~Vente de meth',
    -- VenteMeth = '~o~ + ' .. Meth.prixVente .. ' $',
}

Meth.lastVehcile = 0
Meth.lastDommageVehcile = 0
--restart gcillegal
Meth.recolte = function(currentVehicle, isGoodVehcile)
    if currentVehicle == 0 then
        showMessageInformation(Meth.Text.NeedVehicle)
        return
    end
    if isGoodVehcile == false then
        showMessageInformation(Meth.Text.BadVehicle)
    else
        -- SetVehicleExclusiveDriver(vehicle, true) 41062318F23ED854 
        --Citizen.InvokeNative(0x41062318F23ED854,currentVehicle, true)
        if currentCharge >= 10000 then
            showMessageInformation(Meth.Text.ChargementFullVehicle)
            currentCharge = 10000
        else
            currentCharge = math.min(10000, currentCharge + 2)
            DecorSetInt(currentVehicle,'illegal_chargeMeth', currentCharge)
            showMessageInformation(Meth.Text.ChargementVehicle)
        end
    end
end

Meth.tranformeToMeth = function(vehicle)
    if currentCharge > 0 then
        currentCharge = DecorGetInt(vehicle,'illegal_chargeMeth')
        currentCharge = math.max(0,currentCharge - 100)
        DecorSetInt(vehicle,'illegal_chargeMeth', currentCharge)

        local pos = GetEntityCoords(vehicle)
        TriggerServerEvent('illegal:showSmoke', pos.x, pos.y, pos.z)

        -- RequestNamedPtfxAsset("core")
        -- SetPtfxAssetNextCall("core")
        -- local effet = StartParticleFxLoopedOnEntity("exp_grd_grenade_smoke", myPed,
        --     0.0,-2.0,5.0,
        --     0.0,0.0,0.0,
        --     3.0,
        --     1,1,1)
        --SetParticleFxLoopedColour(effet, 0, 255, 0 , 0)
        GcUtils.showProgressBarTimer(8000, Meth.Text.TransformToMeth, Meth.Text.CreateMeth)
        Citizen.Wait(8000)
        --StopParticleFxLooped(effet, 0)
        TriggerEvent("player:receiveItem", Meth.objectId , 1)
    end
end


Meth.venteMeth = function ()
    local totalItem = exports.vdk_inventory:getQuantity(Meth.objectId)
    if totalItem == 0 then
        return
    end
    -- showMessageInformation(Meth.Text.VenteEnCours, 8000)
    local prixVente = math.floor(Meth.prixVente * math.min(2, 1 + 0.2 * nbPolice))
    GcUtils.showProgressBarTimer(8000, Meth.Text.VenteEnCours, '~o~ + ' .. prixVente .. ' $')
    Citizen.Wait(8000)
    TriggerEvent("player:sellItemSale", Meth.objectId, prixVente)
    Citizen.Wait(2000)
end

Meth.checkPoint = function(currentVehicle, isGoodVehcile)
    local dist = GetDistanceBetweenCoords(myPos.x, myPos.y, myPos.z, Meth.coords.produitChimique.x, Meth.coords.produitChimique.y, Meth.coords.produitChimique.z, true)
    if dist < 10.0 then
        Meth.recolte(currentVehicle, isGoodVehcile)
        return
    end
    dist = GetDistanceBetweenCoords(myPos.x, myPos.y, myPos.z, Meth.coords.venteMeth.x, Meth.coords.venteMeth.y, Meth.coords.venteMeth.z, true)
    if dist < 10.0 then
        Meth.venteMeth()
        return
    end
    
    if isGoodVehcile then
        dist = GetDistanceBetweenCoords(myPos.x, myPos.y, myPos.z, Meth.coords.tranformeToMeth.x, Meth.coords.tranformeToMeth.y, Meth.coords.tranformeToMeth.z, true)
        if dist < 10.0 then
            Meth.tranformeToMeth(currentVehicle)
        end
    end
end

Meth.CheckDomamgeVehcile = function(vehicle)
    local cDmg = GetEntityHealth(vehicle)
    local deltaDmg =  Meth.lastDommageVehcile - cDmg
    if deltaDmg ~= 0 then
        Citizen.Trace('dmg !')
        currentCharge = math.max(currentCharge - deltaDmg * 100, 0)
        DecorSetInt(vehicle, 'illegal_chargeMeth', currentCharge)
        if currentCharge == 0 then
            showMessageInformation('~r~Vous avez perdu tout votre chargement', 15000)
        end
    end
    Meth.lastDommageVehcile = cDmg
end

Meth.showChargement = function()
    DrawRect(0.065, 0.04, 0.1, 0.033, 0,0,0,225)
    SetTextFont(6)
    SetTextScale(0.0,0.5)
    SetTextCentre(false)
    SetTextDropShadow(0, 0, 0, 0, 0)
    SetTextEdge(0, 0, 0, 0, 0)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    AddTextComponentString('~r~Methylamine: ~b~' .. (currentCharge/100) .. ' %')
    DrawText(0.020, 0.04 - 0.017)
end

Meth.start = function ()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(100)
            myPed = GetPlayerPed(-1)
            myPos = GetEntityCoords(myPed)
            currentVehicle = GetVehiclePedIsIn(myPed, false)
            if currentVehicle ~= 0 then
                isGoodVehcile = IsVehicleModel(currentVehicle, Meth.vehicle)
            else
                isGoodVehcile = false
            end
              
            if isGoodVehcile  then 
                if Meth.lastVehcile == 0 then
                    currentCharge = DecorGetInt(currentVehicle, 'illegal_chargeMeth')
                    Citizen.Trace('currentCharge : ' .. currentCharge)
                    Meth.lastVehcile = currentVehicle
                    Meth.lastDommageVehcile = GetEntityHealth(currentVehicle)
                end
                if currentCharge ~= 0 then
                    Meth.CheckDomamgeVehcile(currentVehicle)
                end
            elseif Meth.lastVehcile ~= 0 and currentCharge ~= 0 then 
                Citizen.Trace('set ' .. currentCharge)
                DecorSetInt(Meth.lastVehcile, 'illegal_chargeMeth', currentCharge)
                currentCharge = 0
                Meth.lastVehcile = 0
                Meth.lastDommageVehcile = 0
                Meth.PedInGoodVehicle = false
            end
            Meth.checkPoint(currentVehicle, isGoodVehcile)
        end
    end)

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            if currentCharge ~= 0 then
                Meth.showChargement()
            end
        end
    end)

end


--SetEntityCoords(GetPlayerPed(-1),Meth.coords.produitChimique.x, Meth.coords.produitChimique.y, Meth.coords.produitChimique.z)

-- SetEntityCoords(GetPlayerPed(-1),Meth.coords.tranformeToMeth.x, Meth.coords.tranformeToMeth.y, Meth.coords.tranformeToMeth.z)


--             SetParticleFxLoopedColour(effet, 0 , 255 ,0 , 0)
RegisterNetEvent('illegal:showSmoke')
AddEventHandler('illegal:showSmoke', function(posX, posY, posZ)
    RequestNamedPtfxAsset("core")
    SetPtfxAssetNextCall("core")
    -- exp_grd_bzgas_smoke
    -- exp_grd_flare
    -- exp_grd_grenade_smoke
    local effet = Citizen.InvokeNative(0xE184F4F0DC5910E7, "exp_grd_flare",
        posX, posY, posZ + 1.2,
        0.0,180.0,0.0,
        1.0,
        1,1,1)
    Citizen.Wait(8000)
    StopParticleFxLooped(effet, 0)
end)

-- Citizen.CreateThread( function () 
--     -- while true do 

--     local veh = GetVehiclePedIsIn(GetPlayerPed(-1))
    

--     if veh ~= 0 then 
--         Citizen.Trace('enter')
--          DecorSetInt(veh,'illegal_chargeMeth', 10000)

--         local pos = GetEntityCoords(veh)
--         TriggerServerEvent('illegal:showSmoke', pos.x, pos.y, pos.z)
       
--     end

--     -- end
-- end)
        

        --    Citizen.Wait(2000)
        --     Citizen.Trace('effet : ' .. effet)
        --     StopParticleFxLooped(effet)
  

    --  local effet = StartParticleFxLoopedOnEntity("exp_grd_bzgas_smoke", veh ,
    --         0.0,-2.0,2.2,
    --         0.0,180.0,0.0,
    --         1.32,
    --         1,1,1)
    --         --SetParticleFxLoopedColour(effet, 0 , 255 ,0 , 0)


    
--  RequestNamedPtfxAsset("core")
--         SetPtfxAssetNextCall("core")
--         local effet = StartParticleFxLoopedOnEntity("exp_grd_flare", GetVehiclePedIsIn(GetPlayerPed(-1)),
--             0.0,-2.0,1.2,
--             0.0,180.0,0.0,
--             2.0,
--             1,1,1)

-- end
       

-- end)

