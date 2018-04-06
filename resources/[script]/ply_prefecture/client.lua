--[[Register]]--

RegisterNetEvent("ply_prefecture:GetLicences")
RegisterNetEvent("ply_prefecture:CheckForRealVeh")
RegisterNetEvent("ply_prefecture:VehRegistered")
RegisterNetEvent("ply_prefecture:LicenseFalse")
RegisterNetEvent("ply_prefecture:LicenseTrue")
RegisterNetEvent("ply_prefecture:CanPurchase")

--[[Local/Global]]--

LICENCES = {}
local prefecture_location = {239.318984985352, -405.901733398438,  46.9243583679199}
local prefecture = {title = "Prefecture", currentpos = nil, marker = { r = 0, g = 155, b = 255, a = 200, type = 1 }}

local dmvped = {
  {type=4, hash=0xD768B228, x=239.672119140625, y=-407.178192138672, z=46.9243583679199, a=343.231719970703},
}

local dmvpedpos = {
	{ ['x'] =239.672119140625, ['y'] =-407.178192138672, ['z'] =46.9243583679199 },
}

Citizen.CreateThread(function()

  RequestModel(GetHashKey("S_M_M_Security_01"))
  while not HasModelLoaded(GetHashKey("S_M_M_Security_01")) do
    Wait(1)
  end

  RequestAnimDict("mini@strip_club@idles@bouncer@base")
  while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
    Wait(1)
  end

 	    -- Spawn the DMV Ped
  for _, item in pairs(dmvped) do
    dmvmainped =  CreatePed(item.type, item.hash, item.x, item.y, item.z, item.a, false, true)
    SetEntityHeading(dmvmainped, 332.890655517578)
    FreezeEntityPosition(dmvmainped, true)
	SetEntityInvincible(dmvmainped, true)
	SetBlockingOfNonTemporaryEvents(dmvmainped, true)
    TaskPlayAnim(dmvmainped,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
    end
end)


hasLicense = false
noTest = false
CanBuyLicense = false

RegisterNetEvent('dmv:CheckLicStatus')
AddEventHandler('dmv:CheckLicStatus', function(status)
	--Check if player has completed theory test
	if status == "Passed" or status == "Required" then
		noTest = true
	elseif status == "Completed" then
		CanBuyLicense = true
	elseif status == "Completed" or status == "hasLicense" then
		hasLicense = true
	end
end)

AddEventHandler('ply_prefecture:CanPurchase', function(status)
	CanBuyLicense = true
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if(IsPedInAnyVehicle(GetPlayerPed(-1), false)) and CanBuyLicense == true then
			DrawMissionText2("~b~Allez à la prefecture pour prendre votre permis", 2000)			
		end
	end
end)

--[[Functions]]--

function configLang(lang)
	local lang = lang
	if lang == "FR" then
		lang_string = {
			menu1 = "Acheter un permis",
			menu2 = "Enregistrer un véhicule",
			menu3 = "Fermer",
			menu4 = "Permis",
			menu5 = "Retour",
			menu10 = "~g~E~s~ pour ouvrir le menu",
			text1 = "Ce n'est pas la bon vehicule",
			text2 = "Aucun véhicule présent",
			text3 = "Vehicule enregistré",
			text4 = "Ce permis est déjà acheté",
			text5 = "Permis acheté"
	}

	elseif lang == "EN" then
		lang_string = {
			menu1 = "Buy a license",
			menu2 = "Register a vehicle",
			menu3 = "Close",
			menu4 = "Licenses",
			menu5 = "Back",
			menu10 = "~g~E~s~ to open menu",
			text1 = "This is not the right vehicle",
			text2 = "No vehicles present",
			text3 = "Vehicle registered",
			text4 = "This license is already purchased",
			text5 = "License purchased"
	}
	end
end

function drawNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(true, true)
end

function DrawMissionText2(m_text, showtime)
    ClearPrints()
	SetTextEntry_2("STRING")
	AddTextComponentString(m_text)
	DrawSubtitleTimed(showtime, 1)
end


function MenuPrefecture()
	ped = GetPlayerPed(-1);
	MenuTitle = "Prefecture"
	ClearMenu()
	Menu.addButton("Acheter un permis","AcheterPermis",nil)
	--Menu.addButton("Register a vehicle","EnregistrerVehicule",nil)
	Menu.addButton("Fermer","CloseMenu",nil)
end

function EnregistrerVehicule()
	TriggerServerEvent('ply_prefecture:CheckForVeh',source)
	CloseMenu()
end

function AcheterPermis()
	ped = GetPlayerPed(-1);
	MenuTitle = "Permis"
	ClearMenu()
	--for ind, value in pairs(LICENCES) do
	--	Menu.addButton(tostring(value.name) .. " : " .. tostring(value.price), "OptionPermis", value.id)
	--end
	Menu.addButton("Permis de conduire : 200$", "OptionPermis", 1)
	Menu.addButton("Retour","MenuPrefecture",nil)
end

function OptionPermis(licID)
	
	if CanBuyLicense == true then
		CanBuyLicense = false
		hasLicense = true
		DrawMissionText2("~b~Bravo ! Vous venez d'obtenir votre permis de conduire", 5000)
		local licID = licID
		TriggerServerEvent("ply_prefecture:CheckForLicences", licID)

	elseif noTest == true then
		DrawMissionText2("~r~Vous n'avez pas passé les épreuves du permis de conduire, revenez plus tard", 5000)
	elseif hasLicense == true then
		drawNotification("Vous possedez déjà un permis de conduire valide")
	else 
		drawNotification("Le vigile semble être petrifié par votre beauté")
	end
	CloseMenu()
end

function CloseMenu()
	Menu.hidden = true
	TriggerServerEvent("ply_prefecture:GetLicences")
end

function ShowInfo(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, state, 0, -1)
end

function drawNotification(text)
  SetNotificationTextEntry("STRING")
  AddTextComponentString(text)
  DrawNotification(false, false)
end


--[[Events]]--

AddEventHandler("playerSpawned", function()
	local lang = "FR"
	TriggerServerEvent("ply_prefecture:GetLicences")
	--TriggerServerEvent("ply_prefecture:Lang", lang)
	--configLang(lang)
end)

AddEventHandler("ply_prefecture:GetLicences", function(THELICENCES)
	LICENCES = {}
	LICENCES = THELICENCES
end)


AddEventHandler("ply_prefecture:CheckForRealVeh", function(personalvehicle)
	Citizen.CreateThread(function()
		checkvname1 = true
		checkvname2 = true
		local brutmodel = personalvehicle
		local personalvehicle = string.lower(personalvehicle)
		local caisse = GetClosestVehicle(prefecture_location[1],prefecture_location[2],prefecture_location[3], 5.000, 0, 70)
		SetEntityAsMissionEntity(caisse, true, true)
		if DoesEntityExist(caisse) then
			local vname = GetDisplayNameFromVehicleModel(GetEntityModel(caisse))
			local vname1 = GetLabelText(vname)
			local vname1 = string.lower(vname1)
			local vname1 = vname1:gsub("%s+", "")
			local vname1 = vname1.gsub(vname1, "%s+", "")

			local vname2 = string.lower(vname)
			local vname2 = vname2:gsub("%s+", "")
			local vname2 = vname2.gsub(vname2, "%s+", "")
			print(vname)
			print(vname1)
			print(vname2)
			if personalvehicle ~= vname1 then
				checkvname1 = false
			end
			if vname2 == "cogcabri" then
				vname2 = "cogcabrio"
			end
			if vname2 == "oracle" then
				vname2 = "oracle2"
			end
			if vname2 == "buffalo02" then
				vname2 = "buffalo2"
			end
			if personalvehicle ~= vname2 then
				checkvname2 = false
			end
			if checkvname1 == false and checkvname2 == false then
				exports.pNotify:SendNotification({text = "It's not your vehicle", type = "error", queue = "left", timeout = 3000, layout = "centerRight"})
			else
				local name = personalvehicle
				local plate = GetVehicleNumberPlateText(caisse)

				TriggerServerEvent('ply_prefecture:SetLicenceForVeh', name, brutmodel, plate)
			end
		else
			exports.pNotify:SendNotification({text = "No vehicles present", type = "error", queue = "left", timeout = 3000, layout = "centerRight"})
		end
	end)
end)

AddEventHandler("ply_prefecture:VehRegistered", function()
	exports.pNotify:SendNotification({text = "Vehicle registered", type = "success", queue = "left", timeout = 3000, layout = "centerRight"})
	TriggerServerEvent("ply_basemod:getPlayerVehicle")
end)

AddEventHandler("ply_prefecture:LicenseFalse", function()
	exports.pNotify:SendNotification({text = "This license is already purchased", type = "error", queue = "left", timeout = 3000, layout = "centerRight"})

end)

AddEventHandler("ply_prefecture:LicenseTrue", function()
	exports.pNotify:SendNotification({text = "License purchased", type = "success", queue = "left", timeout = 3000, layout = "centerRight"})
end)



--[[Citizen]]--

Citizen.CreateThread(function()
	local loc = prefecture_location
	pos = prefecture_location
	local blip = AddBlipForCoord(pos[1],pos[2],pos[3])
	SetBlipSprite(blip,267)
	SetBlipColour(blip,1)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Prefecture')
	EndTextCommandSetBlipName(blip)
	SetBlipAsShortRange(blip,true)
	SetBlipAsMissionCreatorBlip(blip,true)
	while true do
		Wait(0)
		--DrawMarker(1,prefecture_location[1],prefecture_location[2],prefecture_location[3],0,0,0,0,0,0,4.001,4.0001,0.5001,0,0,0,200,0,0,0,0)
		if GetDistanceBetweenCoords(prefecture_location[1],prefecture_location[2],prefecture_location[3],GetEntityCoords(GetPlayerPed(-1))) < 2 and IsPedInAnyVehicle(GetPlayerPed(-1), true) == false then
			ShowInfo("appuyez sur ~INPUT_PICKUP~ pour interagir ", 0)
			if IsControlJustPressed(1, 38) then
				MenuPrefecture()
				Menu.hidden = not Menu.hidden
			end
			Menu.renderGUI()
		end
	end
end)