local key_alt = 19
local key_RightALT = 68
local key_TAB = 37
local key_CTRL = 36
local key_SHIFT = 21
local key_RightCTRL = 70
local key_RightSHIFT = 0
local key_ECHAP = 322
local key_DEL = 178

local confirmed = 0
local PlayerResurected = false

local ALTPushed = 0
local RightALTPushed = 0
local TABPushed = 0
local CTRLPushed = 0
local RightCTRLPushed = 0
local SHIFTPushed = 0
local ECHAPPushed = 0
local DELPushed = 0
local updated = 0
local updateTimer = 0
local respawnHospital = false


RegisterNetEvent('td_health:setHealth')
AddEventHandler('td_health:setHealth', function(result)
	Citizen.Wait(3000)
	local ped = PlayerPedId()
	SetEntityHealth(PlayerPedId(),result)
end)

AddEventHandler("playerSpawned", function()
	TriggerServerEvent('td_health:spawn') -- td_health:spawn
end)

AddEventHandler("ambulancier:selfRespawn", function()
	respawnHospital = true
	TriggerServerEvent('td_health:update', 200)
end)



function check()
	local ped = PlayerId()
	
	if IsPlayerDead(ped) then
		PlayerResurected = false
		--[[if IsControlPressed(1, key_alt) then
			ALTPushed = 1
		elseif IsControlPressed(1, key_TAB) then
			TABPushed = 1
		elseif IsControlPressed(1, key_RightALT) then
			RightALTPushed = 1
		elseif IsControlPressed(1, key_CTRL) then
			CTRLPushed = 1
		elseif IsControlPressed(1, key_RightCTRL) then
			RightCTRLPushed = 1
		elseif IsControlPressed(1, key_SHIFT) then
			SHIFTPushed = 1
		elseif IsControlPressed(1, key_ECHAP) then
			ECHAPPushed = 1
		elseif IsControlPressed(1, key_DEL) then
			DELPushed = 1
		end
		
		if (ECHAPPushed == 1 and (CTRLPushed == 1 or RightCTRLPushed == 1) and SHIFTPushed == 1) or ((CTRLPushed == 1 or RightCTRLPushed == 1) and (RightALTPushed == 1 or ALTPushed == 1) and DELPushed == 1) then
			confirmed = 1
		elseif confirmed then
			confirmed = 1
		end
	
		if confirmed then
			return true
		else
			return false
		end--]]
	else --not IsEntityDead(ped) then
		PlayerResurected = true
	end
end

function resetvariable()
	print("reset variable")
	ALTPushed = 0
	RightALTPushed = 0
	TABPushed = 0
	CTRLPushed = 0
	RightCTRLPushed = 0
	SHIFTPushed = 0
	ECHAPPushed = 0
	DELPushed = 0
	updated = 0
	PlayerResurected = false
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
		Citizen.Wait(0)
		local ped = PlayerId() 
		if IsPlayerDead(ped) then
			check()
			PlayerResurected = false
		end
		if IsPlayerDead(ped) and updated == 0 then
			TriggerServerEvent('td_health:update', GetEntityHealth(ped))
			updated = 1
			print('Personnage mort ' .. GetEntityHealth(ped))
		elseif not IsPlayerDead(ped) and updated == 1 then
			resetvariable()
			PlayerResurected = false
			if not respawnHospital then
				TriggerServerEvent('td_health:update', 0)
				Citizen.Wait(1000)
				SetEntityHealth(PlayerPedId(),101)
				Citizen.Wait(10000)
				TriggerServerEvent('td_health:update', 0)
				respawnHospital = false
			end
			updated = 0
		end
	end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60000)
		local ped = PlayerPedId() -- PlayerId()
		if updated == 0 then
			--msginf("Vie mise a jour " .. GetEntityHealth(PlayerPedId()) , 10000)
			TriggerServerEvent('td_health:update', GetEntityHealth(ped))
		end
	end
end)