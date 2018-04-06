	
Drawing = setmetatable({}, Drawing)
Drawing.__index = Drawing


	function Drawing.draw3DText(x,y,z,textInput,fontId,scaleX,scaleY,r, g, b, a)
		local px,py,pz=table.unpack(GetGameplayCamCoords())
		local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

		local scale = (1/dist)*20
		local fov = (1/GetGameplayCamFov())*100
		local scale = scale*fov

		SetTextScale(scaleX*scale, scaleY*scale)
		SetTextFont(fontId)
		SetTextProportional(1)
		SetTextColour(r, g, b, a)
		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextEdge(2, 0, 0, 0, 150)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(textInput)
		SetDrawOrigin(x,y,z+2, 0)
		DrawText(0.0, 0.0)
		ClearDrawOrigin()
	end

	function metier_callSE(id)
		Menu.hidden = not Menu.hidden
		TriggerServerEvent("metiers:jobs", id)
	end
	
	function menuJobsChomeur()
		local MenujobsList = {
			{name="Fermier", id=6},
			{name="Bucheron", id=7},
			{name="Mineur", id=9},
			{name="Pecheur", id=10},
			--{name="Docker", id=11},
			{name="Brasseur", id=12},
			{name="Vigneron", id=13},
			--{name="Livreur", id=14},
			--{name="Ambulancier", id=15},
			--{name="Mecano", id=16},
			--{name="Taxi", id=17}
		}
		MenuTitle = "Jobs"
		ClearMenu()
		for _, item in pairs(MenujobsList) do
			Menu.addButton(item.name, "metier_callSE", item.id)
		end
	end

	function menuJobs()
		local MenujobsList = {
			{name="Démissionner", id=1}
		}
		MenuTitle = "Jobs"
		ClearMenu()
		for _, item in pairs(MenujobsList) do
			Menu.addButton(item.name, "metier_callSE", item.id)
		end
	end
	
	function IsNearPlaces()
		local playerCoords = GetEntityCoords(GetPlayerPed(-1), 0)
		for _, item in pairs(metiers_blips) do
		--	if(GetDistanceBetweenCoords(item.x, item.y, item.z, playerCoords["x"], playerCoords["y"], playerCoords["z"], true) <= item.distanceBetweenCoords) then
		--		DrawMarker(1, item.x, item.y, item.z, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
		--		Drawing.draw3DText(item.x, item.y, item.z, "coucou tu veux voir ma bite", 1, 0.2, 0.1, 255, 255, 255, 215)
		--		return true
		--	end
			if(Vdist(playerCoords["x"], playerCoords["y"], playerCoords["z"], item.x, item.y, item.z) < 150.0)then
				DrawMarker(1, item.x, item.y, item.z, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 0.801, 0, 168, 183,255, 0, 0, 0,0)
				if(Vdist(playerCoords["x"], playerCoords["y"], playerCoords["z"], item.x, item.y, item.z) < 5.0)then
					Drawing.draw3DText(item.x, item.y, item.z , "choisir son metier", 1, 0.2, 0.1, 0, 168, 183, 215)
					if(Vdist(playerCoords["x"], playerCoords["y"], playerCoords["z"],  item.x, item.y, item.z) < 2.0)then
						return true
					end
				end
			end
		end
	end
	
	RegisterNetEvent('metiers:defineJobMenu')
	AddEventHandler('metiers:defineJobMenu', function(jobId)
		if jobId == 1 then
			menuJobsChomeur()
		else  	
			menuJobs()
		end
	end)
	
	RegisterNetEvent('metiers:getmyjob')
	AddEventHandler('metiers:getmyjob', function(id)
		TriggerServerEvent("metiers:jobs", id)
	end)
	
	RegisterNetEvent('metiers:updateJob')
	AddEventHandler('metiers:updateJob', function(nameJob)
		local id = PlayerId()
		local playerName = GetPlayerName(id)
		
		SendNUIMessage({
			updateJob = true,
			job = nameJob,
			player = playerName
		})
	end)
	
	Citizen.CreateThread( function()	
		for key, item in pairs(metiers_blips) do
			local blip = AddBlipForCoord(item.x, item.y, item.z)
			SetBlipSprite(blip, item.id)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(key)
			EndTextCommandSetBlipName(blip)
		end
		while true do
			Citizen.Wait(2)	
			if (IsNearPlaces() == true) then				
				ClearPrints()
				SetTextEntry_2("STRING")
				AddTextComponentString("Appuyez sur 'Utiliser / E' pour selectionner un ~b~job")
				DrawSubtitleTimed(2000, 1)
				if IsControlJustPressed(1, 51) then
					Menu.hidden = not Menu.hidden 
					TriggerServerEvent('metiers:isChomeur')
				end
				Menu.renderGUI()
			end
		end
	end)
	
	