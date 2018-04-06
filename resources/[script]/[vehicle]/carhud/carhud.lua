function drawTxt(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.004)
end

function drawRct(x,y,width,height,r,g,b,a)
	DrawRect(x + width/2, y + height/2, width, height, r, g, b, a)
end

function msginf(msg, duree)
    duree = duree or 500
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(msg)
    DrawSubtitleTimed(duree, 1)
end

Citizen.CreateThread(function()
	while true do
	
		Citizen.Wait(1)
		local get_ped = GetPlayerPed(-1) -- current ped
		local get_ped_veh = GetVehiclePedIsIn(GetPlayerPed(-1),false) -- Current Vehicle ped is in
		local plate_veh = GetVehicleNumberPlateText(get_ped_veh) -- Vehicle Plate
		local veh_stop = IsVehicleStopped(get_ped_veh) -- Parked or not
		local veh_engine_health = GetVehicleEngineHealth(get_ped_veh) -- Vehicle Engine Damage 
		local veh_body_health = GetVehicleBodyHealth(get_ped_veh)
		local veh_burnout = IsVehicleInBurnout(get_ped_veh) -- Vehicle Burnout
		
		local engineHealth = GetVehicleEngineHealth(get_ped_veh)
        local vehicleHealth = GetEntityHealth(get_ped_veh)
        local petrolTankeHealth = GetVehiclePetrolTankHealth(get_ped_veh)
        local vehicleHealth2 = GetVehicleBodyHealth_2(get_ped_veh)
		local vehicleBodyHealth = GetVehicleBodyHealth(get_ped_veh)


		if(IsPedInAnyVehicle(GetPlayerPed(-1), false))then
			local kmh = GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) * 3.6
			if GetVehicleClass(get_ped_veh) == 8 then
				
				-- drawRct(0.159, 0.809, 0.004,0.173,0,0,0,100)  -- UI:engine_damage
				if veh_body_health <= 650 then
					veh_body_health = 650
				end
				veh_body_health = veh_body_health - 650
				drawRct(0.1561, 0.809, 0.004,0.173,255,0,0,100)  -- UI:body_damage
				if veh_body_health >= 675 and veh_body_health <= 650 then
					drawRct(0.1561, 0.809, 0.004,0.173,1,254,89,100)  -- UI:body_damage
				elseif veh_body_health >= 580 and veh_body_health <= 675 then
					drawRct(0.1561, 0.809, 0.004,0.173,0,255,9,100)  -- UI:body_damage
				elseif veh_body_health >= 500 and veh_body_health <= 580 then
					drawRct(0.1561, 0.809, 0.004,0.173,14,254,1,100)  -- UI:body_damage
				elseif veh_body_health >= 420 and veh_body_health <= 500 then
					drawRct(0.1561, 0.809, 0.004,0.173,134,254,1,100)  -- UI:body_damage
				elseif veh_body_health >= 350 and veh_body_health <= 420 then
					drawRct(0.1561, 0.809, 0.004,0.173,197,254,1,100)  -- UI:body_damage
				elseif veh_body_health >= 200 and veh_body_health <= 350 then
					drawRct(0.1561, 0.809, 0.004,0.173,239,252,3,100)  -- UI:body_damage
				elseif veh_body_health >= 150 and veh_body_health <= 200 then
					drawRct(0.1561, 0.809, 0.004,0.173,252,196,3,100)  -- UI:body_damage
				elseif veh_body_health >= 100 and veh_body_health <= 150 then
					drawRct(0.1561, 0.809, 0.004,0.173,250,128,5,100)  -- UI:body_damage
				elseif veh_body_health >= 50 and veh_body_health <= 100 then
					drawRct(0.1561, 0.809, 0.004,0.173,250,54,5,100)  -- UI:body_damage
				elseif veh_body_health >= 0 and veh_body_health <= 50 then
					drawRct(0.1561, 0.809, 0.004,0.173,255,0,0,100)  -- UI:body_damage
				end
				
				drawRct(0.1561, 0.809, 0.004,veh_body_health/2000,0,0,0,1000)  -- UI:body_damage 580
				
			else
				-- drawRct(0.159, 0.809, 0.004,0.173,0,0,0,100)  -- UI:engine_damage
				if engineHealth <= 850 then
					engineHealth = 850
				end
				engineHealth = engineHealth - 850
				
				local PosX = 0.1561
				local PosY = 0.968
				local WideL = 0.004
				local WideH = -0.157
				
				--drawRct(PosX, PosY, WideL,WideH,255,0,0,100)  -- UI:body_damage
				if engineHealth >= 135 and engineHealth <= 150 then
					ColorR = 1
					ColorG = 254
					ColorB = 89
					ColorA = 180
					drawRct(PosX, PosY, WideL,WideH,1,254,89,100)  -- UI:body_damage
				elseif engineHealth >= 105 and engineHealth <= 135 then
					ColorR = 0
					ColorG = 255
					ColorB = 9
					ColorA = 180
					drawRct(PosX, PosY, WideL,WideH,0,255,9,100)  -- UI:body_damage
				elseif engineHealth >= 85 and engineHealth <= 105 then
					ColorR = 14
					ColorG = 255
					ColorB = 1
					ColorA = 180
					drawRct(PosX, PosY, WideL,WideH,14,254,1,100)  -- UI:body_damage
				elseif engineHealth >= 65 and engineHealth <= 85 then
					ColorR = 134
					ColorG = 254
					ColorB = 1
					ColorA = 190
					drawRct(PosX, PosY, WideL,WideH,134,254,1,100)  -- UI:body_damage
				elseif engineHealth >= 50 and engineHealth <= 65 then
					ColorR = 197
					ColorG = 254
					ColorB = 1
					ColorA = 190
					drawRct(PosX, PosY, WideL,WideH,197,254,1,100)  -- UI:body_damage
				elseif engineHealth >= 40 and engineHealth <= 50 then
					ColorR = 197
					ColorG = 254
					ColorB = 1
					ColorA = 190
					drawRct(PosX, PosY, WideL,WideH,239,252,3,100)  -- UI:body_damage
				elseif engineHealth >= 30 and engineHealth <= 40 then
					ColorR = 239
					ColorG = 254
					ColorB = 3
					ColorA = 210
					drawRct(PosX, PosY, WideL,WideH,252,196,3,100)  -- UI:body_damage
				elseif engineHealth >= 20 and engineHealth <= 30 then
					ColorR = 255
					ColorG = 200
					ColorB = 5
					ColorA = 255
					drawRct(PosX, PosY, WideL,WideH,250,128,5,100)  -- UI:body_damage
				elseif engineHealth >= 10 and engineHealth <= 20 then
					ColorR = 250
					ColorG = 200
					ColorB = 5
					ColorA = 255
					drawRct(PosX, PosY, WideL,WideH,250,54,5,100)  -- UI:body_damage
				elseif engineHealth >= 00 and engineHealth <= 10 then
					ColorR = 255
					ColorG = 0
					ColorB = 0
					ColorA = 255
					drawRct(PosX, PosY, WideL,WideH,255,0,0,100)  -- UI:body_damage
				end
				
				drawRct(PosX, PosY, WideL,(engineHealth*-1) /955,0,0,0,255)  -- UI:body_damage 580 855 960
				
				-- drawRct(0.159, 0.809, 0.004,0.173,0,0,0,100)  -- UI:engine_damage
				
				if vehicleBodyHealth <= 650 then
					vehicleBodyHealth = 650
				end
				
				vehicleBodyHealth = vehicleBodyHealth - 650
				
				ColorR = 255
				ColorG = 255
				ColorB = 255
				ColorA = 120
				
				local PosX = 0.151
				local PosY = 0.968
				local WideL = 0.004
				local WideH = -0.157
				
					--drawRct(0.16, 0.809, 0.004,0.173,255,0,0,100)  -- UI:body_damage
				if vehicleBodyHealth <= 315 and vehicleBodyHealth >= 350 then
					ColorR = 1
					ColorG = 254
					ColorB = 89
					ColorA = 180
					drawRct(PosX, PosY, WideL,WideH,1,254,89,100)  -- UI:body_damage
				elseif vehicleBodyHealth >= 280 and vehicleBodyHealth <= 315 then
					ColorR = 0
					ColorG = 255
					ColorB = 9
					ColorA = 180
					drawRct(PosX, PosY, WideL,WideH,0,255,9,100)  -- UI:body_damage
				elseif vehicleBodyHealth >= 245 and vehicleBodyHealth <= 280 then
					ColorR = 14
					ColorG = 255
					ColorB = 1
					ColorA = 180
					drawRct(PosX, PosY, WideL,WideH,14,254,1,100)  -- UI:body_damage
				elseif vehicleBodyHealth >= 210 and vehicleBodyHealth <= 245 then
					ColorR = 134
					ColorG = 254
					ColorB = 1
					ColorA = 190
					drawRct(PosX, PosY, WideL,WideH,134,254,1,100)  -- UI:body_damage
				elseif vehicleBodyHealth >= 175 and vehicleBodyHealth <= 210 then
					ColorR = 197
					ColorG = 254
					ColorB = 1
					ColorA = 190
					drawRct(PosX, PosY, WideL,WideH,197,254,1,100)  -- UI:body_damage
				elseif vehicleBodyHealth >= 140 and vehicleBodyHealth <= 175 then
					ColorR = 239
					ColorG = 254
					ColorB = 3
					ColorA = 210
					drawRct(PosX, PosY, WideL,WideH,239,252,3,100)  -- UI:body_damage
				elseif vehicleBodyHealth >= 105 and vehicleBodyHealth <= 140 then
					ColorR = 254
					ColorG = 175
					ColorB = 1
					ColorA = 210
					drawRct(PosX, PosY, WideL,WideH,252,196,3,100)  -- UI:body_damage
				elseif vehicleBodyHealth >= 70 and vehicleBodyHealth <= 105 then
					ColorR = 255
					ColorG = 200
					ColorB = 5
					ColorA = 255
					drawRct(PosX, PosY, WideL,WideH,250,128,5,100)  -- UI:body_damage
				elseif vehicleBodyHealth >= 35 and vehicleBodyHealth <= 70 then
					ColorR = 250
					ColorG = 200
					ColorB = 5
					ColorA = 255
					drawRct(PosX, PosY, WideL,WideH,250,54,5,100)  -- UI:body_damage
				elseif vehicleBodyHealth >= 00 and vehicleBodyHealth <= 35 then
					ColorR = 255
					ColorG = 0
					ColorB = 0
					ColorA = 255
					drawRct(PosX, PosY, WideL,WideH,255,0,0,100)  -- UI:body_damage
				end
				--]]
				drawRct(PosX, PosY, WideL,(vehicleBodyHealth*-1) / 2250,ColorR,ColorG,ColorB,ColorA)  -- UI:body_damage 580
			end
			
--			msginf(" Moteur: " ..engineHealth .. " tank: " .. petrolTankeHealth .. " eng calc: " ..tostring((engineHealth*-1) /960) .. " bdy: " .. vehicleBodyHealth .. " " .. tostring((vehicleBodyHealth*-1) / 2000), 500)
			
			if RectR == nil then
				RectR = 0
			end
			
			if engineHealth < 60 or vehicleBodyHealth < 100 then
				
				
				
				if RectR >= 255 then
					RectR = 0
				else
					RectR = RectR + 7
				end
				
				if engineHealth < 15  and RectR > 150 then
					drawTxt(0.550, 1.332, 1.0,1.0,0.4, "~r~    Panne détecté ~n~Appelez un garage !", 255, 255, 255, 255)
				end
			else
				RectR = 0
			end
			--drawRct(0.11, 0.932, 0.046,0.03,0,0,0,100) 	-- UI:panel kmh	
			drawRct(0.105, 0.930, 0.046,0.032,RectR,0,0,100) 	-- UI:panel kmh	
			drawRct(0.105, 0.930, 0.046,0.032,RectR,0,0,100) 	-- UI:panel kmh	
			-- drawRct(0.159, 0.768, 0.0122, 0.038, 0,0,0,150)        -- UI: 1
			-- drawRct(0.028, 0.777, 0.029, 0.02, 0,0,0,150)          -- UI: 2
			-- drawRct(0.1131, 0.777, 0.031, 0.02, 0,0,0,150)         -- UI: 3
			-- drawRct(0.1445, 0.777, 0.0129, 0.028, 0,0,0,150)       -- UI: 4
			-- drawRct(0.014, 0.777, 0.013, 0.028, 0,0,0,150)         -- UI: 5
			-- drawRct(0.0625, 0.768, 0.045, 0.037, 0,0,0,150)        -- UI: 6
			-- drawRct(0.014, 0.768, 0.043, 0.007, 0,0,0,150)         -- UI: 7
			-- drawRct(0.0279, 0.798, 0.0293, 0.007, 0,0,0,150)       -- UI: 8
			-- drawRct(0.0575, 0.768, 0.004, 0.037, 0,0,0,150)        -- UI: 9
			-- drawRct(0.1131, 0.768, 0.044, 0.007, 0,0,0,150)        -- UI: 10
			-- drawRct(0.1131, 0.798, 0.031, 0.007, 0,0,0,150)        -- UI: 11
			-- drawRct(0.1085, 0.768, 0.004, 0.037, 0,0,0,150)        -- UI: 12
			
			drawTxt(0.606, 1.42, 1.0,1.0,0.64 , "~w~" .. math.ceil(kmh), 255, 255, 255, 255)  -- INT: kmh
			drawTxt(0.627, 1.432, 1.0,1.0,0.4, "~w~ km/h", 255, 255, 255, 255)	-- TXT: kmh
			drawTxt(0.563, 1.2624, 1.0,1.0,0.55, "~w~" .. plate_veh, 255, 255, 255, 255) -- TXT: Plate	

			-- if veh_burnout then
			-- drawTxt(0.535, 1.266, 1.0,1.0,0.44, "~r~DSC", 255, 255, 255, 200) -- TXT: DSC {veh_burnout}
			-- else
			-- drawTxt(0.535, 1.266, 1.0,1.0,0.44, "DSC", 255, 255, 255, 150)
			-- end		
			
			-- if (veh_engine_health > 0) and (veh_engine_health < 300) then
				-- drawTxt(0.619, 1.266, 1.0,1.0,0.45, "~y~Fluid", 255, 255, 255, 200) -- TXT: Fluid
				-- drawTxt(0.514, 1.269, 1.0,1.0,0.45, "~w~~y~Oil", 255, 255, 255, 200) -- TXT: Oil
				-- drawTxt(0.645, 1.270, 1.0,1.0,0.45, "~y~AC", 255, 255, 255, 200)
			-- elseif veh_engine_health < 1 then 
				-- drawRct(0.159, 0.809, 0.004, 0,0,0,0,100)  -- panel damage
				-- drawTxt(0.645, 1.270, 1.0,1.0,0.45, "~r~AC", 255, 255, 255, 200)
				-- drawTxt(0.619, 1.266, 1.0,1.0,0.45, "~r~Fluid", 255, 255, 255, 200) -- TXT: Fluid
				-- drawTxt(0.514, 1.269, 1.0,1.0,0.45, "~w~~r~Oil", 255, 255, 255, 200) -- TXT: Oil
				-- drawTxt(0.645, 1.270, 1.0,1.0,0.45, "~r~AC", 255, 255, 255, 200)
			-- else
				-- drawTxt(0.619, 1.266, 1.0,1.0,0.45, "Fluid", 255, 255, 255, 150) -- TXT: Fluid
				-- drawTxt(0.514, 1.269, 1.0,1.0,0.45, "Oil", 255, 255, 255, 150) -- TXT: Oil
				-- drawRct(0.159, 0.809, 0.004, veh_engine_health / 5800,0,0,0,100)  -- panel damage
				-- drawTxt(0.645, 1.270, 1.0,1.0,0.45, "~w~AC", 255, 255, 255, 150)
			-- end	
			
			-- if veh_stop then
				-- drawTxt(0.6605, 1.262, 1.0,1.0,0.6, "~r~P", 255, 255, 255, 200)
			-- else
				-- drawTxt(0.6605, 1.262, 1.0,1.0,0.6, "P", 255, 255, 255, 150)
			-- end
		end		
	end
end)