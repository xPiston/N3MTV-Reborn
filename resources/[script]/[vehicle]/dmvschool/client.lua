maxErrors = 6 -- Change the amount of Errors allowed for the player to pass the driver test, any number above this will result in a failed test

local options = {
    x = 0.1,
    y = 0.2,
    width = 0.2,
    height = 0.04,
    scale = 0.4,
    font = 0,
    menu_title = "NPC",
    menu_subtitle = "Categories",
    color_r = 0,
    color_g = 128,
    color_b = 255,
}


local dmvped = {
  {type=4, hash=0x9AD32FE9, x=-828.746948242188, y=-696.640625, z=27.0565605163574, a=89.5493240356445},
}

local dmvpedpos = {
	{ ['x'] =-828.746948242188, ['y'] =-696.640625, ['z'] =28.0565605163574 },
}

--[[Locals]]--

local dmvschool_location = {-827.746948242188, -699.640625, 28.0565605163574}

local kmh = 3.6
local VehSpeed = 0

local speed_limit_resi = 50.0
local speed_limit_town = 70.0
local speed_limit_freeway = 140
local speed = kmh

local DTutOpen = false
local monitorPed
--[[Events]]--

AddEventHandler("playerSpawned", function()
	TriggerServerEvent('dmv:LicenseStatus')	
end)
TestDone = 0
Unlock = 0
haveTest = false;
haveLicense = false;



--[[Functions]]--

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

function LocalPed()
	return GetPlayerPed(-1)
end

function GetCar() 
	return GetVehiclePedIsIn(GetPlayerPed(-1),false) 
end

function Chat(debugg)
    TriggerEvent("chatMessage", '', { 0, 0x99, 255 }, tostring(debugg))
end

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x , y)
end

--[[Arrays]]--

onTestEvent = 0
theorylock = 0
onTtest = 0
onPtest = false
testblock = 0
DamageControl = 0
SpeedControl = 0
CruiseControl = 0
Error = 0
forgive = 0

function startintro()
	if TestDone == 0 then
		DrawMissionText2("~r~Vous ne pouvez pas passer le test pour le moment", 5000)
	else
		DIntro()   
	end
end

function startttest()

	if theorylock == 1 or TestDone == 0 or testblock == 1 then
		DrawMissionText2("~r~Vous ne pouvez pas passer l'épreuve théorique", 5000)			
	else
		onTtest = 1
		TriggerServerEvent('dmv:ttcharge')
		openGui()
		Menu.hidden = not Menu.hidden
	end
end

function startptest()
	if theorylock == 3 or Unlock == 0 or testblock == 1 then
		DrawMissionText2("~r~Vous ne pouvez pas passer l'épreuve pratique", 5000)
	else
		local vehiculeDetected = GetClosestVehicle(-812.180969238281,-748.602844238281,22.1563491821289, 6.0, 0, 70)
					
		if not DoesEntityExist(vehiculeDetected) then
			TriggerServerEvent('dmv:dtcharge')
			onPtest = true;
			onTestBlipp = AddBlipForCoord(-845.306335449219,-750.004150390625, 22.9157829284668)
			N_0x80ead8e2e1d5d52e(onTestBlipp)
			SetBlipRoute(onTestBlipp, 1)
			onTestEvent = 1
			DamageControl = 1
			SpeedControl = 1
			onTtest = 0
			DTut()
			else
				vehiculeDetected = nil
				DrawMissionText2("~r~La zone d'epreuve est encombrée", 5000)
		end
	end
end

function EndDTest()
	if Error >= maxErrors then
		drawNotification("vous avez echoué\nVous avez accumulé ".. Error.." ~r~Erreurs")
		EndTestTasks()
	elseif forgive == 1 then
		testblock = 1
		drawNotification("vous avez ~r~Abandonné")
		EndTestTasks()
	else
		--local licID = 1
		--TriggerServerEvent('ply_prefecture:CheckForLicences', licID)	--Uncomment this if youre using ply_prefecture, also make sure your drivers license has 1 as ID
		testblock = 1
		haveTest = true
		TriggerServerEvent("ply_prefecture:CanBuyLicense")
		TriggerServerEvent('dmv:successCompleted')
		drawNotification("Vous avez réussie\nVous avez accumulé ".. Error.." ~r~Erreurs")
		DrawMissionText2("~b~Allez a la prefecture pour recuperer votre permis", 5000)
		EndTestTasks()
	end
end

function EndTestTasks()
		onTestBlipp = nil
		onTestEvent = 0
		DamageControl = 0
		Error = 0
		TaskLeaveVehicle(GetPlayerPed(-1), veh, 0)
		Wait(1000)
		CarTargetForLock = GetPlayersLastVehicle(GetPlayerPed(-1))
		lockStatus = GetVehicleDoorLockStatus(CarTargetForLock)
		SetVehicleDoorsLocked(CarTargetForLock, 2)
		SetVehicleDoorsLockedForPlayer(CarTargetForLock, PlayerId(), false)
		SetEntityAsMissionEntity(CarTargetForLock, true, true)
		Wait(2000)
		Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( CarTargetForLock ) )
		SetPedAsNoLongerNeeded(monitorPed)
		onPtest = false;
end


function SpawnTestCar()
	Citizen.Wait(0)
	local myPed = GetPlayerPed(-1)
	local player = PlayerId()
	local vehicle = GetHashKey('blista')

    RequestModel(vehicle)

	while not HasModelLoaded(vehicle) do
		Wait(1)
	end

	colors = table.pack(GetVehicleColours(veh))
	extra_colors = table.pack(GetVehicleExtraColours(veh))
	plate = math.random(100, 900)
	local spawned_car = CreateVehicle(vehicle, -812.180969238281,-748.602844238281,22.1563491821289, 0.0, true, false)
	SetVehicleColours(spawned_car,4,5)
	SetVehicleExtraColours(spawned_car,extra_colors[1],extra_colors[2])
	SetEntityHeading(spawned_car, 85.069953918457)
	SetVehicleOnGroundProperly(spawned_car)
	SetPedIntoVehicle(myPed, spawned_car, -1)
	SetModelAsNoLongerNeeded(vehicle)
	Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(spawned_car))
	CruiseControl = 0
	DTutOpen = false
	SetEntityVisible(myPed, true)
	SetVehicleDoorsLocked(GetCar(), 1)
	FreezeEntityPosition(myPed, false)
	SetVehicleNumberPlateText(GetCar(), "Permis"..math.random(0,1000).." ")

	RequestModel(GetHashKey("A_M_Y_BusiCas_01"))
	while not HasModelLoaded(GetHashKey("A_M_Y_BusiCas_01")) do
		Wait(1)
	end

	monitorPed = CreatePed(4, 0x9AD32FE9,-811.237243652344, -746.732299804688,  22.4649505615234, 183.998657226563, true, true)
	SetPedMaxHealth(monitorPed, 100)
	SetPedRelationshipGroupHash(monitorPed, GetHashKey("CIVFEMALE")) -- GANG_1 ?
	--TaskStartScenarioInPlace(monitorPed, "WORLD_HUMAN_GUARD_STAND_PATROL", 0, true)
	--SetPedCanRagdoll(monitorPed, false)
	--SetPedDiesWhenInjured(monitorPed, false)
	TaskEnterVehicle(monitorPed, spawned_car, -1, 0, 2.0001, 1)

end

function DIntro()
	Citizen.Wait(0)
	local myPed = GetPlayerPed(-1)
	DTutOpen = true
		SetEntityCoords(myPed,173.01181030273, -1391.4141845703, 29.408880233765,true, false, false,true)
		TriggerEvent("pNotify:SendNotification",{
            text = "<b style='color:#1E90FF'>DMV Introduction</b> <br /><br />Theory and practice are both important elements of driving instruction.<br />This introduction will cover the basics and ensure you are prepared with enough information and knowledge for your test.<br /><br />The information from your theory lessons combined with the experience from your practical lesson are vital for negotiating the situations and dilemmas you will face on the road.<br /><br />Sit back and enjoy the ride as we start. It is highly recommended that you pay attention to every detail, most of these questions can be existent under your theory test.",
            type = "alert",
            timeout = (0),
            layout = "center",
            queue = "global"
        })
		Citizen.Wait(16500)
		SetEntityCoords(myPed,-428.49026489258, -993.306640625, 46.008815765381,true, false, false,true)
		TriggerEvent("pNotify:SendNotification",{
            text = "<b style='color:#1E90FF'>Accidents, incidents and environmental concerns</b><br /><br /><b style='color:#87CEFA'>Duty to yield</b><br />All drivers have a duty to obey the rules of the road in order to avoid foreseeable harm to others. Failure to yield the right of way when required by law can lead to liability for any resulting accidents.<br /><br /> When you hear a siren coming, you should yield to the emergency vehicle, simply pull over to your right.<br />You must always stop when a traffic officer tells you to.<br /><br /><b style='color:#87CEFA'>Aggressive Driving</b><br />A car that endangers or is likely to endanger people or property is considered to be aggressive driving.<br />However, aggressive driving, can lead to tragic accidents. It is far wiser to drive defensively and to always be on the lookout for the potential risk of crashes.<br />",
            type = "alert",
            timeout = (1000),
            layout = "center",
            queue = "global"
        })
		Citizen.Wait(1000)
		SetEntityCoords(myPed,-282.55557250977, -282.55557250977, 31.633310317993,true, false, false,true)
		TriggerEvent("pNotify:SendNotification",{
            text = "<b style='color:#1E90FF'>Residential Area</b> <br /><br /> Maintain an appropriate speed - Never faster than the posted limit, slower if traffic is heavy.<br /><br />Stay centered in your lane. Never drive in the area reserved for parked cars.<br /><br />Maintain a safe following distance - an least 1 car length for every 10 mph.<br /><br />The speed limit in a Residential Area is 50 km/h.<br />",
            type = "alert",
            timeout = (15000),
            layout = "center",
            queue = "global"
        })	
		Citizen.Wait(16500)
		SetEntityCoords(myPed,246.35220336914, -1204.3403320313, 43.669715881348,true, false, false,true)
		TriggerEvent("pNotify:SendNotification",{
            text = "<b style='color:#1E90FF'>Built-Up Areas/Towns</b> <br /><br />The 80 km/h limit usually applies to all traffic on all roads with street lighting unless otherwise specified.<br />Driving at speeds too fast for the road and driving conditions can be dangerous.<br /><br />You should always reduce your speed when:<br /><br />&bull; Sharing the road with pedestrians<br />&bull; Driving at night, as it is more difficult to see other road users<br />&bull; Weather conditions make it safer to do so<br /><br />Remember, large vehicles and motorcycles need a greater distance to stop<br />",
            type = "alert",
            timeout = (15000),
            layout = "center",
            queue = "global"
        })
		Citizen.Wait(16500)
		SetEntityCoords(myPed,-138.413, -2498.53, 52.2765,true, false, false,true)
		TriggerEvent("pNotify:SendNotification",{
            text = "<b style='color:#1E90FF'>Freeways/Motorways</b> <br /><br />Traffic on motorways usually travels faster than on other roads, so you have less time to react.<br />It is especially important to use your sences earlier and look much further ahead than you would on other roads.<br /><br />Check the traffic on the motorway and match your speed to fit safely into the traffic flow in the left-hand lane.<br /><br />The speed limit in a Freeway/Motorway Area is 120 km/h.<br />",
            type = "alert",
            timeout = (15000),
            layout = "center",
            queue = "global"
        })				
		Citizen.Wait(16500)		
		SetEntityCoords(myPed,187.465, -1428.82, 43.9302,true, false, false,true)
		TriggerEvent("pNotify:SendNotification",{
            text = "<b style='color:#1E90FF'>Alcohol</b> <br /><br />Drinking while driving is very dangerous, alcohol and/or drugs impair your judgment. Impaired judgment affects how you react to sounds and what you see. However, the DMV allows a certain amount of alcohol concentration for those driving with a valid drivers license.<br /><br />0.08% is the the legal limit for a driver's blood alcohol concentration (BAC)<br />",
            type = "alert",
            timeout = (15000),
            layout = "center",
            queue = "global"
        })				
		Citizen.Wait(16500)			
		SetEntityCoords(myPed,238.756, -1381.65, 32.743,true, false, false,true)
		SetEntityVisible(myPed, true)
		FreezeEntityPosition(myPed, false)
		DTutOpen = false
end

function DTut()
	Citizen.Wait(0)
	local myPed = GetPlayerPed(-1)
	DTutOpen = true
		SetEntityCoords(myPed,-812.180969238281, -748.602844238281,22.1563491821289,true, false, false,true)
	    SetEntityHeading(myPed, 314.39)
		TriggerEvent("pNotify:SendNotification",{
            text = "<b style='color:#1E90FF'>Instructeur:</b> <br /><br /> We are currently preparing your vehicle for the test, meanwhile you should read a few important lines.<br /><br /><b style='color:#87CEFA'>Speed limit:</b><br />- Pay attention to the traffic, and stay under the <b style='color:#A52A2A'>speed</b> limit<br /><br />- By now, you should know the basics, however we will try to remind you whenever you <b style='color:#DAA520'>enter/exit</b> an area with a posted speed limit",
            type = "alert",
            timeout = (0),
            layout = "center",
            queue = "global"
        })
		Citizen.Wait(0)
		TriggerEvent("pNotify:SendNotification",{
            text = "<b style='color:#1E90FF'>Instructeur:</b> <br /><br /> Use the <b style='color:#DAA520'>Cruise Control</b> feature to avoid <b style='color:#87CEFA'>speeding</b>, activate this during the test by pressing the <b style='color:#20B2AA'>X</b> button on your keyboard.<br /><br /><b style='color:#87CEFA'>Evaluation:</b><br />- Try not to crash the vehicle or go over the posted speed limit. You will receive <b style='color:#A52A2A'>Error Points</b> whenever you fail to follow these rules<br /><br />- Too many <b style='color:#A52A2A'>Error Points</b> accumulated will result in a <b style='color:#A52A2A'>Failed</b> test",
            type = "alert",
            timeout = (0),
            layout = "center",
            queue = "global"
        })
		Citizen.Wait(0)
		SpawnTestCar()
		DTutOpen = false
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local veh = GetVehiclePedIsUsing(GetPlayerPed(-1))
		local ped = GetPlayerPed(-1)
		if HasEntityCollidedWithAnything(veh) and DamageControl == 1 then
		TriggerEvent("pNotify:SendNotification",{
            text = "Le vehicule etait <b style='color:#B22222'>endommagé!</b><br /><br />regardez le!",
            type = "alert",
            timeout = (2000),
            layout = "bottomCenter",
            queue = "global"
        })			
			Citizen.Wait(1000)
			Error = Error + 1	
		elseif(IsControlJustReleased(1, 23)) and DamageControl == 1 then
			DrawMissionText2("~r~Vous avez quitté votre vehicule, l'epreuve est terminé, réessayer plus tard", 8000)
			forgive = 1
			RemoveBlip(onTestBlipp)
			EndDTest()
    	end
	if onTestEvent == 1 then
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -847.753601074219,-750.023193359375, 21.8757934570313, true) > 4.0001 then
		   DrawMarker(1,-847.753601074219,-750.023193359375, 21.8757934570313,0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
		else
		    if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
				Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
		    end
			onTestBlipp = AddBlipForCoord(-856.54638671875,-679.34375,26.6601066589355)
			N_0x80ead8e2e1d5d52e(onTestBlipp)
			DrawMissionText2("Faîte un rapide ~r~stop~s~ et regardez sur votre ~y~Gauche~s~ avant de rentrer dans le traffic", 5000)
			PlaySound(-1, "RACE_PLACED", "HUD_AWARDS", 0, 0, 1)
			FreezeEntityPosition(GetVehiclePedIsUsing(GetPlayerPed(-1)), true) -- Freeze Entity
			Citizen.Wait(6000)
			FreezeEntityPosition(GetVehiclePedIsUsing(GetPlayerPed(-1)), false) -- Freeze Entity
			DrawMissionText2("~g~Parfait!~s~ maintenant à ~y~DROITE~s~ et prenez votre couloir", 5000)
			drawNotification("Zone: ~y~ville\n~s~limite de vitesse: ~y~70 km/h\n~s~Erreur: ~y~".. Error.."/6")
			SpeedControl = 2
			onTestEvent = 2
		end
	end
	
	if onTestEvent == 2 then
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),-856.54638671875,-679.34375,26.6601066589355, true) > 4.0001 then
		   DrawMarker(1,-856.54638671875,-679.34375,26.6601066589355,0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
		else
		    if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
				Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
		    end
			onTestBlipp = AddBlipForCoord(-762.498229980469,-665.869384765625, 27.9939460754395)
			N_0x80ead8e2e1d5d52e(onTestBlipp)
			SetBlipRoute(onTestBlipp, 1)
		    DrawMissionText2("Si vous tournez à ~y~Droite~s~, ne tenez pas compte du feu, cela compte comme ~r~ceder le passage~s~", 5000)
			PlaySound(-1, "RACE_PLACED", "HUD_AWARDS", 0, 0, 1)
			FreezeEntityPosition(GetVehiclePedIsUsing(GetPlayerPed(-1)), true) -- Freeze Entity
			Citizen.Wait(2000)
			FreezeEntityPosition(GetVehiclePedIsUsing(GetPlayerPed(-1)), false) -- Freeze Entity
			onTestEvent = 3		
		end
	end
	
	if onTestEvent == 3 then
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),-762.498229980469,-665.869384765625, 28.9939460754395, true) > 4.0001 then
		   DrawMarker(1,-762.498229980469,-665.869384765625, 28.9939460754395,0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
		else
		    if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
				Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
		    end
			onTestBlipp = AddBlipForCoord(-657.403442382813, -663.372009277344,  30.5197086334229)
			N_0x80ead8e2e1d5d52e(onTestBlipp)
			SetBlipRoute(onTestBlipp, 1)
		    DrawMissionText2("Respectez les feux de signalisation !", 5000)
			onTestEvent = 4
		end
	end	
	
	if onTestEvent == 4 then
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),-657.403442382813, -663.372009277344,  30.5197086334229, true) > 4.0001 then
		   DrawMarker(1,-657.403442382813, -663.372009277344,  30.5197086334229,0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
		else
		    if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
				Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
		    end
			onTestBlipp = AddBlipForCoord(-623.419555664063, -567.777893066406,  33.7929573059082)
			N_0x80ead8e2e1d5d52e(onTestBlipp)
			SetBlipRoute(onTestBlipp, 1)
			DrawMissionText2("Pensez a vos ~y~Clignotant~s~ ", 5000)
			onTestEvent = 5
		end
	end	
	
	if onTestEvent == 5 then
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),-623.419555664063, -567.777893066406,  33.7929573059082, true) > 4.0001 then
		   DrawMarker(1,-623.419555664063, -567.777893066406,  33.7929573059082,0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
		else
		    if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
				Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
		    end
			onTestBlipp = AddBlipForCoord(-740.115173339844, -1703.5439453125,  28.0816287994385)
			N_0x80ead8e2e1d5d52e(onTestBlipp)
			SetBlipRoute(onTestBlipp, 1)
		    DrawMissionText2("Allons sur la Freeway! La zone est limitée a ~r~140 kmh~s~, mais restez prudent", 5000)
			drawNotification("Zone: ~y~Freeway\n~s~limite de vitesse: ~y~140 km/h\n~s~Erreur: ~y~".. Error.."/6")
			SpeedControl = 3
			onTestEvent = 6
		end
	end	

	if onTestEvent == 6 then
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),-740.115173339844, -1703.5439453125,  28.0816287994385, true) > 4.0001 then
		   DrawMarker(1,-740.115173339844, -1703.5439453125,  28.0816287994385,0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
		else
		    if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
				Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
		    end
			onTestBlipp = AddBlipForCoord(-725.74267578125, -1618.35229492188,  23.125280380249)
			N_0x80ead8e2e1d5d52e(onTestBlipp)
			SetBlipRoute(onTestBlipp, 1)
			DrawMissionText2("Toujours en vie ? sortons de la Freeway, la limite redeviens de ~r~70 kmh~s~", 5000)
			drawNotification("Zone: ~y~Freeway\n~s~limite de vitesse: ~y~70 km/h\n~s~Erreur: ~y~".. Error.."/6")
			SpeedControl = 2
			onTestEvent = 7
		end
	end		
		
	
	if onTestEvent == 7 then
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),-725.74267578125, -1618.35229492188,  23.125280380249, true) > 4.0001 then
		   DrawMarker(1,-725.74267578125, -1618.35229492188,  23.125280380249,0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
		else
		    if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
				Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
		    end
			onTestBlipp = AddBlipForCoord(-633.262268066406, -1317.45849609375,  9.477876663208)
			N_0x80ead8e2e1d5d52e(onTestBlipp)
			SetBlipRoute(onTestBlipp, 1)
		    DrawMissionText2("Encore une fois, on respecte les feux !", 5000)
			onTestEvent = 8
		end
	end		
		
	
	if onTestEvent == 8 then
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),-633.262268066406, -1317.45849609375,  9.477876663208, true) > 4.0001 then
		   DrawMarker(1,-633.262268066406, -1317.45849609375,  9.477876663208,0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
		else
		    if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
				Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
		    end
			onTestBlipp = AddBlipForCoord(-761.5107421875, -1131.142578125,  9.5143232345581)
			N_0x80ead8e2e1d5d52e(onTestBlipp)
			SetBlipRoute(onTestBlipp, 1)
			onTestEvent = 9
		end
	end

	if onTestEvent == 9 then
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),-761.5107421875, -1131.142578125,  9.5143232345581, true) > 4.0001 then
		   DrawMarker(1,-761.5107421875, -1131.142578125,  9.5143232345581,0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
		else
		    if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
				Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
		    end
			onTestBlipp = AddBlipForCoord(-937.99462890625, -1202.6533203125,  3.93371725082397)
			N_0x80ead8e2e1d5d52e(onTestBlipp)
			SetBlipRoute(onTestBlipp, 1)
			onTestEvent = 10
		end
	end

	if onTestEvent == 10 then
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),-937.99462890625, -1202.6533203125,  3.93371725082397, true) > 4.0001 then
		   DrawMarker(1,-937.99462890625, -1202.6533203125,  3.93371725082397,0, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
		else
		    if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
				Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
		    end
			onTestBlipp = AddBlipForCoord(-998.661865234375, -1126.78796386719,  0.98231542110443)
			N_0x80ead8e2e1d5d52e(onTestBlipp)
			SetBlipRoute(onTestBlipp, 1)
			DrawMissionText2("vous entrez dans une zone residentielle, la vitesse est limitée a  ~r~50 kmh~s~!", 5000)
			drawNotification("Zone: ~y~residentielle\n~s~limite de vitesse: ~y~50 km/h\n~s~Erreur: ~y~".. Error.."/6")
			SpeedControl = 1
			onTestEvent = 11
		end
	end

	if onTestEvent == 11 then
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),-998.661865234375, -1126.78796386719,  0.98231542110443, true) > 4.0001 then
		   DrawMarker(1,-998.661865234375, -1126.78796386719,  0.98231542110443,0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
		else
		    if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
				Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
		    end
			onTestBlipp = AddBlipForCoord(-1050.96118164063, -1035.25903320313,  0.93113338947296)
			N_0x80ead8e2e1d5d52e(onTestBlipp)
			SetBlipRoute(onTestBlipp, 1)
			DrawMissionText2("Marquez l'arret sur un ~r~Stop~s~", 5000)
			PlaySound(-1, "RACE_PLACED", "HUD_AWARDS", 0, 0, 1)
			FreezeEntityPosition(GetVehiclePedIsUsing(GetPlayerPed(-1)), true) -- Freeze Entity
			Citizen.Wait(3000)
			FreezeEntityPosition(GetVehiclePedIsUsing(GetPlayerPed(-1)), false) -- Freeze Entity
			onTestEvent = 12
		end
	end

	if onTestEvent == 12 then
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),-1050.96118164063, -1035.25903320313,  0.93113338947296, true) > 4.0001 then
		   DrawMarker(1,-1050.96118164063, -1035.25903320313,  0.93113338947296,0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
		else
		    if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
				Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
		    end
			onTestBlipp = AddBlipForCoord(-1110.10119628906, -936.233520507813,  1.42584228515625)
			N_0x80ead8e2e1d5d52e(onTestBlipp)
			SetBlipRoute(onTestBlipp, 1)
		 	DrawMissionText2("Marquez un second arrêt au ~r~Stop~s~", 5000)
			PlaySound(-1, "RACE_PLACED", "HUD_AWARDS", 0, 0, 1)
			FreezeEntityPosition(GetVehiclePedIsUsing(GetPlayerPed(-1)), true) -- Freeze Entity
			Citizen.Wait(3000)
			FreezeEntityPosition(GetVehiclePedIsUsing(GetPlayerPed(-1)), false) -- Freeze Entity
			onTestEvent = 13
		end
	end

	if onTestEvent == 13 then
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),-1110.10119628906, -936.233520507813,  1.42584228515625, true) > 4.0001 then
		   DrawMarker(1,-1110.10119628906, -936.233520507813,  1.42584228515625,0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
		else
		    if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
				Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
		    end
			onTestBlipp = AddBlipForCoord(-1158.01416015625, -859.518493652344,  12.9024276733398)
			N_0x80ead8e2e1d5d52e(onTestBlipp)
			SetBlipRoute(onTestBlipp, 1)
			DrawMissionText2("Attention, il y a un ~r~feu de signalisation~s~", 5000)
			PlaySound(-1, "RACE_PLACED", "HUD_AWARDS", 0, 0, 1)
			FreezeEntityPosition(GetVehiclePedIsUsing(GetPlayerPed(-1)), true) -- Freeze Entity
			Citizen.Wait(1000)
			FreezeEntityPosition(GetVehiclePedIsUsing(GetPlayerPed(-1)), false) -- Freeze Entity
			onTestEvent = 14
		end
	end
	
	if onTestEvent == 14 then
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),-1158.01416015625, -859.518493652344,  12.9024276733398, true) > 4.0001 then
		   DrawMarker(1,-1158.01416015625, -859.518493652344,  12.9024276733398,0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
		else
		    if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
				Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
		    end
			onTestBlipp = AddBlipForCoord(-1088.89758300781, -783.330444335938,  18.0743675231934)
			N_0x80ead8e2e1d5d52e(onTestBlipp)
			SetBlipRoute(onTestBlipp, 1)
			drawNotification("Zone: ~y~ville\n~s~limite de vitesse: ~y~70 km/h\n~s~Erreur: ~y~".. Error.."/6")
			SpeedControl = 2
			onTestEvent = 15
		end
	end	
	
	if onTestEvent == 15 then
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),-1088.89758300781, -783.330444335938,  18.0743675231934, true) > 4.0001 then
		   DrawMarker(1,-1088.89758300781, -783.330444335938,  18.0743675231934,0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
		else
		    if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
				Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
		    end
			onTestBlipp = AddBlipForCoord(-834.398132324219, -1004.77203369141,  12.326639175415)
			N_0x80ead8e2e1d5d52e(onTestBlipp)
			SetBlipRoute(onTestBlipp, 1)
			DrawMissionText2("~r~Ceder le passage~s~ puis tournez a droite", 5000)
			onTestEvent = 16
		end
	end	
	
	if onTestEvent == 16 then
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),-834.398132324219, -1004.77203369141,  12.326639175415, true) > 4.0001 then
		   DrawMarker(1,-834.398132324219, -1004.77203369141,  12.326639175415,0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
		else
		    if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
				Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
		    end
			onTestBlipp = AddBlipForCoord(-742.745422363281, -856.58349609375,  21.3169403076172)
			N_0x80ead8e2e1d5d52e(onTestBlipp)
			SetBlipRoute(onTestBlipp, 1)
			DrawMissionText2("Nous somme bientôt à la fin de l'épreuve", 5000)
			onTestEvent = 17
		end
	end		
	

	if onTestEvent == 17 then
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),-742.840270996094, -856.149597167969,  21.3244380950928, true) > 4.0001 then
		   DrawMarker(1,-742.840270996094, -856.149597167969,  21.3244380950928,0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
		else
		    if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
				Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
		    end
			onTestBlipp = AddBlipForCoord(-815.881408691406, -742.369506835938,  22.5532207489014)
			N_0x80ead8e2e1d5d52e(onTestBlipp)
			SetBlipRoute(onTestBlipp, 1)
			DrawMissionText2("Bien, l'épreuve presque est finie, quel sera le verdict?", 5000)
			onTestEvent = 18
		end
	end

	if onTestEvent == 18 then
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),-815.881408691406, -742.369506835938,  22.5532207489014, true) > 4.0001 then
		   DrawMarker(1,-815.881408691406, -742.369506835938,  22.5532207489014,0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
		else
		    if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
				Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
		    end
			forgive = 0
			EndDTest()
		end
	end
	
end
end)

----Theory Test NUI Operator

-- ***************** Open Gui and Focus NUI
function openGui()
  onTtest = 1
  SetNuiFocus(true)
  SendNUIMessage({openQuestion = true})
end

-- ***************** Close Gui and disable NUI
function closeGui()
  SetNuiFocus(false)
  SendNUIMessage({openQuestion = false})
end

-- ***************** Disable controls while GUI open
Citizen.CreateThread(function()
  while true do
    if onTtest == 1 then
      local ply = GetPlayerPed(-1)
      local active = true
      DisableControlAction(0, 1, active) -- LookLeftRight
      DisableControlAction(0, 2, active) -- LookUpDown
      DisablePlayerFiring(ply, true) -- Disable weapon firing
      DisableControlAction(0, 142, active) -- MeleeAttackAlternate
      DisableControlAction(0, 106, active) -- VehicleMouseControlOverride
      if IsDisabledControlJustReleased(0, 142) then -- MeleeAttackAlternate
        SendNUIMessage({type = "click"})
      end
    end
    Citizen.Wait(0)
  end
end)

-- ***************** NUI Callback Methods
-- Callbacks pages opening
RegisterNUICallback('question', function(data, cb)
  SendNUIMessage({openSection = "question"})
  cb('ok')
end)

-- Callback actions triggering server events
RegisterNUICallback('close', function(data, cb)
  -- if question success
  closeGui()
  cb('ok')
  TriggerServerEvent('dmv:success')
  TriggerServerEvent('dmv:LicenseStatus')
  DrawMissionText2("~b~Vous avez réussie, l'epreuve vous pouvez desormais passer a l'epreuve pratique", 2000)	
  TestDone = 0
  theorylock = 0
  onTtest = 0
end)

RegisterNUICallback('kick', function(data, cb)
    closeGui()
    cb('ok')
    DrawMissionText2("~r~Vous avez echoué l'epreuve, réessayer plus tard", 2000)	
    onTtest = 0
	theorylock = 3
	testblock = 1
end)

RegisterNetEvent('dmv:CheckLicStatus')
AddEventHandler('dmv:CheckLicStatus', function(status)
--Check if player has completed theory test
	if status == "Required" then
		TestDone = 1
		haveLicense = false
	elseif status == "Passed" then 
		Unlock = 1
		haveLicense = false
	elseif status == "Completed" or status == "hasLicense" then
		haveLicense = true
	end
end)


RegisterNetEvent('dmv:reloadLicense')
AddEventHandler('dmv:reloadLicense', function()
	haveLicense = false
	onPtest = false
	TestDone = 1
	Unlock = 0
	onTtest = 1
end)

RegisterNetEvent('dmv:haveMyLicense')
AddEventHandler('dmv:haveMyLicense', function()
	haveLicense = true	
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if(IsPedInAnyVehicle(GetPlayerPed(-1), false)) and haveLicense == false and onTtest == 0 and onPtest == false then
			DrawMissionText2("~r~Vous conduisez sans permis", 2000)			
		end
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
		CarSpeed = GetEntitySpeed(GetCar()) * speed
        if(IsPedInAnyVehicle(GetPlayerPed(-1), false)) and SpeedControl == 1 and CarSpeed >= speed_limit_resi then
		TriggerEvent("pNotify:SendNotification",{
            text = "Vous allez trop vite ! <b style='color:#B22222'>Ralentissez!</b><br /><br />vous etes dans une zone à <b style='color:#DAA520'>50 km/h</b>",
            type = "alert",
            timeout = (2000),
            layout = "bottomCenter",
            queue = "global"
        })
			Error = Error + 1	
			Citizen.Wait(10000)
		elseif(IsPedInAnyVehicle(GetPlayerPed(-1), false)) and SpeedControl == 2 and CarSpeed >= speed_limit_town then
		TriggerEvent("pNotify:SendNotification",{
            text = "Vous allez trop vite ! <b style='color:#B22222'>Ralentissez!</b><br /><br />vous etes dans une zone à <b style='color:#DAA520'>70 km/h</b>",
            type = "alert",
            timeout = (2000),
            layout = "bottomCenter",
            queue = "global"
        })
			Error = Error + 1
			Citizen.Wait(10000)
		elseif(IsPedInAnyVehicle(GetPlayerPed(-1), false)) and SpeedControl == 3 and CarSpeed >= speed_limit_freeway then
		TriggerEvent("pNotify:SendNotification",{
            text = "Vous allez trop vite ! <b style='color:#B22222'>Ralentissez!</b><br /><br />vous etes dans une zone à <b style='color:#DAA520'>140 km/h</b>",
            type = "alert",
            timeout = (2000),
            layout = "bottomCenter",
            queue = "global"
        })
			Error = Error + 1
			Citizen.Wait(10000)
		end
	end
end)


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
        if ( ped and inVehicle and DamageControl == 1 ) then
            if IsControlJustPressed(1, 73) then
                if (GetPedInVehicleSeat(vehicle, -1) == ped) then
                    if CruiseControl == 0 then
                        speedLimit = speed
                        SetEntityMaxSpeed(vehicle, speedLimit)
						drawNotification("~y~Cruise Control: ~g~enabled\n~s~Vitesse maximal ".. math.floor(speedLimit*3.6).."kmh")
						Citizen.Wait(1000)
				        DisplayHelpText("Ajusté votre vitesse maximal avec ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ ")
						PlaySound(-1, "COLLECTED", "HUD_AWARDS", 0, 0, 1)
                        CruiseControl = 1
                    else
                        SetEntityMaxSpeed(vehicle, Max)
						drawNotification("~y~Cruise Control: ~r~desactiver")						
                        CruiseControl = 0
                    end
                else
				    drawNotification("Tu dois conduire pour faire cette action")						
                end
            elseif IsControlJustPressed(1, 27) then
                if CruiseControl == 1 then
                    speedLimit = speedLimit + 0.45
                    SetEntityMaxSpeed(vehicle, speedLimit)
					PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
					DisplayHelpText("La vitesse max est à ".. math.floor(speedLimit*3.6).. "kmh")
                end
            elseif IsControlJustPressed(1, 173) then
                if CruiseControl == 1 then
                    speedLimit = speedLimit - 0.45
                    SetEntityMaxSpeed(vehicle, speedLimit)
					PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)	
					DisplayHelpText("La vitesse max est à ".. math.floor(speedLimit*3.6).. "kmh")
                end
            end
        end
    end
end)

----Theory Test NUI Operator

-- ***************** Open Gui and Focus NUI
function openGui()
  q = 1
  SetNuiFocus(true)
  SendNUIMessage({openQuestion = true})
end

-- ***************** Close Gui and disable NUI
function closeGui()
  SetNuiFocus(false)
  SendNUIMessage({openQuestion = false})
end

-- ***************** Disable controls while GUI open
Citizen.CreateThread(function()
  while true do
    if onTtest == 1 then
      local ply = GetPlayerPed(-1)
      local active = true
      DisableControlAction(0, 1, active) -- LookLeftRight
      DisableControlAction(0, 2, active) -- LookUpDown
      DisablePlayerFiring(ply, true) -- Disable weapon firing
      DisableControlAction(0, 142, active) -- MeleeAttackAlternate
      DisableControlAction(0, 106, active) -- VehicleMouseControlOverride
      if IsDisabledControlJustReleased(0, 142) then -- MeleeAttackAlternate
        SendNUIMessage({type = "click"})
      end
    end
    Citizen.Wait(0)
  end
end)

Citizen.CreateThread(function()
  while true do
    if DTutOpen then
      local ply = GetPlayerPed(-1)
      local active = true
	  SetEntityVisible(ply, false)
	  FreezeEntityPosition(ply, true)
      DisableControlAction(0, 1, active) -- LookLeftRight
      DisableControlAction(0, 2, active) -- LookUpDown
      DisablePlayerFiring(ply, true) -- Disable weapon firing
      DisableControlAction(0, 142, active) -- MeleeAttackAlternate
      DisableControlAction(0, 106, active) -- VehicleMouseControlOverride
    end
    Citizen.Wait(0)
  end
end)

-- ***************** NUI Callback Methods
-- Callbacks pages opening
RegisterNUICallback('question', function(data, cb)
  SendNUIMessage({openSection = "question"})
  cb('ok')
end)

-- Callback actions triggering server events
RegisterNUICallback('close', function(data, cb)
  -- if question success
  closeGui()
  cb('ok')
  TriggerServerEvent('dmv:success')
  DrawMissionText2("~b~Vous avez réussie, vous pouvez desormais passer l'epreuve de conduite", 2000)	
  TestDone = 0
  theorylock = 0
  onTtest = 0
end)

RegisterNUICallback('kick', function(data, cb)
    closeGui()
    cb('ok')
    DrawMissionText2("~r~Vous avez échoué, réessayer une prochaine fois", 2000)	
    onTtest = 0
	theorylock = 3
	testblock = 1
end)

---------------------------------- DMV PED ----------------------------------

Citizen.CreateThread(function()

  RequestModel(GetHashKey("A_M_Y_BusiCas_01"))
  while not HasModelLoaded(GetHashKey("A_M_Y_BusiCas_01")) do
    Wait(1)
  end

  RequestAnimDict("missexile3@trevor_idle@base")
  while not HasAnimDictLoaded("missexile3@trevor_idle@base") do
    Wait(1)
  end

 	    -- Spawn the DMV Ped
  for _, item in pairs(dmvped) do
    dmvmainped =  CreatePed(item.type, item.hash, item.x, item.y, item.z, item.a, false, true)
    SetEntityHeading(dmvmainped, 120.069953918457)
    FreezeEntityPosition(dmvmainped, true)
	SetEntityInvincible(dmvmainped, true)
	SetBlockingOfNonTemporaryEvents(dmvmainped, true)
    TaskPlayAnim(dmvmainped,"missexile3@trevor_idle@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
    end
end)

local talktodmvped = true
--DMV Ped interaction
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local pos = GetEntityCoords(GetPlayerPed(-1), false)
		for k,v in ipairs(dmvpedpos) do
			if(Vdist(v.x, v.y, v.z, pos.x, pos.y, pos.z) < 1.0)then
				DisplayHelpText("Appuyez sur ~INPUT_CONTEXT~ pour interagir")
				if(IsControlJustReleased(1, 38))then
						if talktodmvped then
						    Notify("Bienvenue à l'auto-ecole")
						    Citizen.Wait(500)
							DMVMenu()
							Menu.hidden = false
							talktodmvped = false
						else
							talktodmvped = true
						end
				end
				Menu.renderGUI(options)
			end
		end
	end
end)

------------------------
------------ DRAW MENUS
------------------------
function DMVMenu()
	ClearMenu()
    options.menu_title = "Permis"
	Menu.addButton("Obtenir mon permis","VehLicenseMenu",nil)
    Menu.addButton("Fermer","CloseMenu",nil) 
end

function VehLicenseMenu()
    ClearMenu()
    options.menu_title = "Permis de conduire"
	-- Menu.addButton("Introduction    FREE","startintro",nil)
	Menu.addButton("Epreuve Theorique  500$","startttest",nil)
	Menu.addButton("Epreuve Pratique   1000$","startptest",nil)
    Menu.addButton("Fermer","DMVMenu",nil) 
end

function CloseMenu()
		Menu.hidden = true
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

--------------------------------
----------------blip
--------------------------------



Citizen.CreateThread(function()
	pos = dmvschool_location
	local blip = AddBlipForCoord(pos[1],pos[2],pos[3])
	SetBlipSprite(blip,408)
	SetBlipColour(blip,11)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Auto ecole')
	EndTextCommandSetBlipName(blip)
	SetBlipAsShortRange(blip,true)
	SetBlipAsMissionCreatorBlip(blip,true)
end)