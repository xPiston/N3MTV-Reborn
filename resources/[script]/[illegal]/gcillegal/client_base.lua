--=============================================================================
--  Jonathan D @ Gannon
--=============================================================================
GcUtils = nil
nbPolice = 0

RegisterNetEvent('illegal:setcop')
AddEventHandler("illegal:setcop", function(nbPolicier)
	nbPolice = nbPolicier
	-- Citizen.Trace('illegal:setcop' .. nbPolice)
end)


Citizen.CreateThread(function()
	while true do
        Citizen.Wait(30000)
        TriggerServerEvent('illegal:requestNbCop')
	end
end)



Citizen.CreateThread(function () 
    Citizen.Wait(6000) -- Wait load GcUtils
    GcUtils = exports.gc_utils:getGcUtils()
    Citizen.Trace('gcIllegal START')
    Weeds.start()
    Meth.start()
    Transform.start()
end)

function ShowVerticalLineAtPos(pos)
    DrawLine(pos.x, pos.y, pos.z-2, pos.x, pos.y, pos.z+2, 255,0,0,255)
end

function showMessageInformation(message, duree)
    duree = duree or 500
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(message)
    DrawSubtitleTimed(duree, 1)
end

function showActionInfo(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

-- GET_POSIX_TIME
function getTime()
    return Citizen.InvokeNative(0x9A73240B49945C76)
end

function PlayEmote(name, duration) 
    Citizen.CreateThread(function()
        TaskStartScenarioInPlace(GetPlayerPed(-1), name, 0, true)
        Citizen.Wait(duration)
        ClearPedTasks(GetPlayerPed(-1))
    end)
end


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
