--====================================================================================
-- #Author: Jonathan D @ Gannon
-- 
-- Développée pour la communauté n3mtv
--      https://www.twitch.tv/n3mtv
--      https://twitter.com/n3m_tv
--      https://www.facebook.com/lan3mtv
--====================================================================================





--===================================================================================================================================================--
--                Build Menu -- playAmination = joue l'aniamtion une fois et playAminationLoop pour jouer l'animation en boucle.                     -- 
-- site des emotes = http://docs.ragepluginhook.net/html/62951c37-a440-478c-b389-c471230ddfc5.htm#amb@code_human_wander_idles_cop@male@staticSection --
--===================================================================================================================================================--
local KeyOpenJobsMenu = 166 -- F5
local currentJobs = ''
local hasMenuJob = false
local assis = false
RegisterNetEvent('metiers:updateJob')
AddEventHandler('metiers:updateJob', function(nameJob)
    if hasMenuJob then
        table.remove(Menu.item.Items, 1)
    end
    hasMenuJob = false

    if nameJob == 'Policier' or 
       nameJob == 'Ambulancier' or 
       nameJob == 'Taxi' or 
       nameJob == 'Mecano' then
       table.insert(Menu.item.Items, 1, {['Title'] = 'Menu ' .. nameJob, ['Function'] = openMenuJobs } )
       hasMenuJob = true
       Citizen.Trace('-----------------------')
    end
    if nameJob == 'Policier' then
        currentJobs = 'police'
    else
        currentJobs = string.lower(nameJob)
    end
end)

function openMenuJobs()
    TriggerEvent(currentJobs .. ':openMenu')
end

Menu = {}
Menu.item = {
    ['Title'] = 'Interactions',
    ['Items'] = {
        {['Title'] = 'Personnel', ['SubMenu'] = {
            ['Title'] = 'Menu',
                ['Items'] = {
                    { ['Title'] = 'Regarder sa carte d\'identité', ['Event'] = 'gcl:openMeIdentity'},
                    { ['Title'] = 'Montrer carte d\'identité', ['Event'] = 'gcl:showItentity'},
                    { ['Title'] = 'Regarder son permis de conduire', ['Event'] = 'gcl:openMeLicenceDriver'},
                    { ['Title'] = 'Montrer permis de conduire', ['Event'] = 'gcl:showMeLicenceDriver'},
                }
            }
        },
--      {['Title'] = 'Telephone' , ['Event'] = 'phone:toggleMenu'},
        {['Title'] = 'Emote', ['SubMenu'] = {
            ['Title'] = 'Menu',
            ['Items'] = {
                { ['Title'] = 'Bras tendu', ['Function'] = playAminationLoop, ['dictionaries'] = "nm@hands", ['clip'] = 'flail' },
--				{ ['Title'] = 'Emote loop', ['Function'] = playAminationLoop, ['dictionaries'] = "mini@strip_club@pole_dance@pole_dance2", ['clip'] = 'pd_dance_02' },
--                { ['Title'] = 'Emote non loop',   Function = playAmination ,  dictionaries = "amb@world_human_leaning@male@wall@back@foot_up@base", clip = "base" },
                { ['Title'] = 'Saluer', ['SubMenu'] = {
                    ['Title'] = 'Animations - Saluer',
                    ['Items'] = {
                        { ['Title'] = "Serrer la main", Function = playAmination ,  dictionaries = "mp_common", clip = 'givetake1_a'},
                        { ['Title'] = "Dire bonjour",   Function = playAmination ,  dictionaries = "gestures@m@standing@casual", clip = "gesture_hello" },
                        { ['Title'] = 'Signe de la main', ['Function'] = playAmination, ['dictionaries'] = "friends@frj@ig_1", ['clip'] = 'wave_e' },
                        { ['Title'] = "Salut militaire", Function = playAmination , dictionaries = "mp_player_int_uppersalute", clip = "mp_player_int_salute" },
                    }
                }},
                { ['Title'] = 'Humeur', ['SubMenu'] = {
                    ['Title'] = 'Animations - Humeur',
                    ['Items'] = {
						{ ['Title'] = "Craquer poings (f)", ['Function'] = playAmination, ['dictionaries'] = "anim@mp_player_intcelebrationfemale@knuckle_crunch", ['clip'] = 'knuckle_crunch' }, 
						{ ['Title'] = "Craquer poings (h)", ['Function'] = playAmination, ['dictionaries'] = "anim@mp_player_intcelebrationmale@knuckle_crunch", ['clip'] = 'knuckle_crunch' },
						{ ['Title'] = "Branleur", Function = playAmination ,  dictionaries = "mp_player_int_upperwank", clip = "mp_player_int_wank_01" },
                        { ['Title'] = "Dammed ", Function = playAmination ,  dictionaries = "gestures@m@standing@casual", clip = "gesture_damn" },
                        { ['Title'] = "Viens me voir ", Function = playAmination ,  dictionaries = "gestures@m@standing@casual", clip = "gesture_come_here_soft" },
                        { ['Title'] = "Calme toi ", Function = playAmination ,  dictionaries = "gestures@m@standing@casual", clip = "gesture_easy_now" },
                        { ['Title'] = "No way", Function = playAmination ,  dictionaries = "gestures@m@standing@casual", clip = "gesture_no_way" },
                        { ['Title'] = "Doigt d'honneur", Function = playAmination ,  dictionaries = "mp_player_int_upperfinger", clip = "mp_player_int_finger_01_enter" },
                        { ['Title'] = 'Faire un doigt', ['Function'] = playAmination, ['dictionaries'] = "mp_player_intfinger", ['clip'] = 'mp_player_int_finger' },
                        { ['Title'] = "Balle dans la tete", Function = playAmination ,  dictionaries = "mp_suicide", clip = "pistol" },
                        { ['Title'] = "Enlacer", Function = playAmination ,  dictionaries = "mp_ped_interaction", clip = "kisses_guy_a" },
--                      { ['Title'] = 'Mains en l\'air', ['Function'] = playAmination, ['dictionaries'] = "missminuteman_1ig_2", ['clip'] = 'handsup_base' },
                    }
                }},
                { ['Title'] = 'Sportives', ['SubMenu'] = {
                    ['Title'] = 'Animations - Sportives',
                    ['Items'] = {
                        { ['Title'] = "Faire du Yoga", Function = playEmote, ['EmoteName'] = "WORLD_HUMAN_YOGA"},
                        { ['Title'] = "Jogging", Function = playEmote, ['EmoteName'] = "WORLD_HUMAN_JOG_STANDING"},
                        { ['Title'] = "Faire des pompes", Function = playEmote, ['EmoteName'] = "WORLD_HUMAN_PUSH_UPS"},
                        { ['Title'] = "Faire des abdos", Function = playEmote, ['EmoteName'] = "WORLD_HUMAN_SIT_UPS"},                      
                    }
                }},
                { ['Title'] = 'Festives', ['SubMenu'] = {
                    ['Title'] = 'Animations - Festives',
                    ['Items'] = {
                        { ['Title'] = "Danse Femme",   Function = playAmination ,  dictionaries = "mini@strip_club@private_dance@part1", clip = "priv_dance_p1" }, -- Danse femme
                        { ['Title'] = "Danser", ['Function'] = playAmination, ['dictionaries'] = "amb@world_human_partying@female@partying_beer@base", ['clip'] = 'base' }, 
                        { ['Title'] = "Tappes moi en 5", Function = playAmination , dictionaries = "mp_ped_interaction", clip = "highfive_guy_a" },
                        { ['Title'] = "Boire une biere", Function = playEmote, ['EmoteName'] = "WORLD_HUMAN_DRINKING"},
                        { ['Title'] = "Jouer de la musique", Function = playEmote, ['EmoteName'] = "WORLD_HUMAN_MUSICIAN"},
                        { ['Title'] = "Applaudir", Function = playEmote, ['EmoteName'] = "WORLD_HUMAN_CHEERING"},
                        { ['Title'] = "Super", Function = playAmination ,  dictionaries = "mp_action", clip = "thanks_male_06" },
                        { ['Title'] = "Excelent",   Function = playAmination ,  dictionaries = "anim@mp_player_intcelebrationmale@thumbs_up", clip = "thumbs_up" },
                    }
                }},
                { ['Title'] = 'Prendre une pose', ['SubMenu'] = {
                    ['Title'] = 'Animations - Pose',
                    ['Items'] = {
                        { ['Title'] = 'Pose de la police', ['Function'] = playEmote, ['EmoteName'] = 'WORLD_HUMAN_COP_IDLES' }, -- Police
                        { ['Title'] = 'Accouder au comptoir', ['Function'] = playEmote, ['EmoteName'] = 'PROP_HUMAN_BUM_SHOPPING_CART' },
                        { ['Title'] = "S'assoir", ['Event'] = 'sit:chaise' },                       
                        { ['Title'] = 'Assis au sol', ['Function'] = playEmote, ['EmoteName'] = 'WORLD_HUMAN_PICNIC' },
                        { ['Title'] = 'Sur le ventre', ['Function'] = playEmote, ['EmoteName'] = 'WORLD_HUMAN_SUNBATHE' },
                        { ['Title'] = 'Sur le dos', ['Function'] = playEmote, ['EmoteName'] = 'WORLD_HUMAN_SUNBATHE_BACK' },
                    }
                }},
                { ['Title'] = 'Autres', ['SubMenu'] = {
                    ['Title'] = 'Animations - Autres',
                    ['Items'] = {
                        { ['Title'] = 'Oui', ['Function'] = playAmination, ['dictionaries'] = "gestures@m@standing@casual", ['clip'] = 'gesture_pleased' }, 
                        { ['Title'] = 'Non', ['Function'] = playAmination, ['dictionaries'] = "gestures@m@standing@casual", ['clip'] = 'gesture_head_no' },
                        { ['Title'] = "Crocheter", Function = playEmote, ['EmoteName'] = "WORLD_HUMAN_WELDING"},
                        { ['Title'] = "Prendre des notes", Function = playEmote, ['EmoteName'] = "WORLD_HUMAN_CLIPBOARD"},
                        { ['Title'] = "Fumer une clope", Function = playEmote, ['EmoteName'] = "WORLD_HUMAN_SMOKING"},
                        { ['Title'] = "Reparer le moteur",   Function = playAmination ,  dictionaries = "amb@world_human_vehicle_mechanic@male@idle_a", clip = "WORLD_HUMAN_VEHICLE_MECHANIC" },
                        { ['Title'] = "Se gratter les c**", Function = playAmination , dictionaries = "mp_player_int_uppergrab_crotch", clip = "mp_player_int_grab_crotch" },
                        { ['Title'] = "Rock and Roll", Function = playAmination , dictionaries = "mp_player_int_upperrock", clip = "mp_player_int_rock" },
                        { ['Title'] = 'Selfie', ['Function'] = playEmote, ['EmoteName'] = 'WORLD_HUMAN_TOURIST_MOBILE' },
                        { ['Title'] = 'Portable', ['Function'] = playEmote, ['EmoteName'] = 'WORLD_HUMAN_STAND_MOBILE' },
                    }
                }},
                { ['Title'] = 'Metier', ['SubMenu'] = {
                    ['Title'] = 'Animations Metier',
                    ['Items'] = {
                        { ['Title'] = 'Marteau piqueur', ['Function'] = playEmote, ['EmoteName'] = 'WORLD_HUMAN_CONST_DRILL' }, -- mineur
                        { ['Title'] = 'Circulation', ['Function'] = playEmote, ['EmoteName'] = 'WORLD_HUMAN_CAR_PARK_ATTENDANT' }, -- police
                        { ['Title'] = 'Souffleur', ['Function'] = playEmote, ['EmoteName'] = 'WORLD_HUMAN_GARDENER_LEAF_BLOWER' }, -- Jardinier
                        { ['Title'] = 'Planter', ['Function'] = playEmote, ['EmoteName'] = 'WORLD_HUMAN_GARDENER_PLANT' }, -- Jardinier
                        { ['Title'] = 'Peche', ['Function'] = playEmote, ['EmoteName'] = 'WORLD_HUMAN_STAND_FISHING' }, -- P?cheur
                        { ['Title'] = 'Soudure', ['Function'] = playEmote, ['EmoteName'] = 'WORLD_HUMAN_WELDING' }, -- soudeur / crochetage
                        { ['Title'] = 'Examiner corp 1', ['Function'] = playEmote, ['EmoteName'] = 'CODE_HUMAN_MEDIC_KNEEL' }, -- Pour medecin et ambulancier
                        { ['Title'] = 'Examiner corp 2', ['Function'] = playEmote, ['EmoteName'] = 'CODE_HUMAN_MEDIC_TEND_TO_DEAD' }, -- Pour medecin et ambulancier
                        { ['Title'] = 'Verbaliser', ['Function'] = playEmote, ['EmoteName'] = 'CODE_HUMAN_MEDIC_TIME_OF_DEATH' }, -- Verbaliser
                        { ['Title'] = 'Jumelle', ['Function'] = playEmote, ['EmoteName']  = 'WORLD_HUMAN_BINOCULARS' }, -- policier/chasseur
                    }
                }},
            },
        }},
        { ['Title'] = 'Faire Pipi', ['Event'] = 'gabs:enviepipi'},
        { ['Title'] = "Donner de l'argent", ['Event'] = 'bank:givecash'},
        { ['Title'] = "Donner de l'argent sale", ['Event'] = 'bank:givedirty'},
        { ['Title'] = 'Enlever / Mettre chapeau', ['Event'] = 'accessories_switcher:toggleHat',['Close'] = false},
        { ['Title'] = 'Enlever / mettre Lunettes', ['Event'] = 'accessories_switcher:toggleGlasses',['Close'] = false},
        { ['Title'] = 'Annuler Animation', ['Event'] = 'gc:clearAmination'},
        { ['Title'] = 'Se suicider / Respawn', ['SubMenu'] = {
                    ['Title'] = 'Validation suicide:',
                    ['Items'] = {
                                { ['Title'] = 'Quitter' },
                                { ['Title'] = 'Valider le suicide / respawn',['Event'] = 'ambulancier:selfRespawn'},
                                }
                }
        },
    }
}




------ pour la détection

--local function stopSit()
--    local ped = GetPlayerPed(-1)
--    Citizen.InvokeNative(0xD01015C7316AE176, ped, "Stop")
--    if not IsPedInjured(ped) then
--        ClearPedSecondaryTask(ped)
--    end
--    if not IsPedInAnyVehicle(ped, 1) then
--        SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
--    end
--    SetPedConfigFlag(ped, 36, 0)
--    ClearPedSecondaryTask(PlayerPedId())
--    assis = false
--end

--AddEventHandler('sit:chaise', function()
--    ped = GetPlayerPed(-1);
   
--    if ped then
--        local pos = GetEntityCoords(GetPlayerPed(-1), false)
--        head = GetEntityHeading(ped);

--        local object = GetHashKey('prop_chair_05')
--        local chaise = CreateObject('prop_chair_05', pos['x']+2, pos['y'], pos['z']-1, false, false, false)
--        FreezeEntityPosition(chaise , true)
--        PlaceObjectOnGroundProperly(chaise)
--        local PlayerNearDistrib = GetClosestObjectOfType(pos.x, pos.y, pos.z, 5, object, false, false, false)
--        if PlayerNearDistrib ~= nil then
--           local posobject = GetEntityCoords(chaise, false)
--            TaskStartScenarioAtPosition(ped, "PROP_HUMAN_SEAT_CHAIR", posobject['x'], posobject['y'], posobject['z']+0.5, 180.0, 0, 1, 0)

--        end
--        --TaskStartScenarioInPlace(ped, "PROP_HUMAN_SEAT_CHAIR", 0, false);
--        assis = true
--    end
--end)

------ 

local function stopSit()
    local ped = GetPlayerPed(-1)
    Citizen.InvokeNative(0xD01015C7316AE176, ped, "Stop")
    if not IsPedInjured(ped) then
        ClearPedSecondaryTask(ped)
    end
    if not IsPedInAnyVehicle(ped, 1) then
        SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
    end
    SetPedConfigFlag(ped, 36, 0)
    ClearPedSecondaryTask(PlayerPedId())
    assis = false
end

AddEventHandler('sit:chaise', function()
    ped = GetPlayerPed(-1);
   
    if ped then
        pos = GetEntityCoords(ped);
        head = GetEntityHeading(ped);
        TaskStartScenarioAtPosition(ped, "PROP_HUMAN_SEAT_CHAIR", pos['x'], pos['y'], pos['z'] - 1, head, 0, 1, 0);
        --TaskStartScenarioInPlace(ped, "PROP_HUMAN_SEAT_CHAIR", 0, false);
        assis = true
	end
end)

--====================================================================================
--  Option Menu
--====================================================================================
Menu.backgroundColor = { 0, 0, 0, 160 }
Menu.backgroundColorActive = { 184, 184, 184, 205 }
Menu.tileTextColor = { 255, 255, 255, 255 }
Menu.tileBackgroundColor = { 11, 129, 184, 205 }
Menu.textColor = { 255,255,255,255 }
Menu.textColorActive = { 255,255,255, 255 }

Menu.keyOpenMenu = 170 -- F3    
Menu.keyUp = 172 -- PhoneUp
Menu.keyDown = 173 -- PhoneDown
Menu.keyLeft = 174 -- PhoneLeft || Not use next release Maybe 
Menu.keyRight = 175 -- PhoneRigth || Not use next release Maybe 
Menu.keySelect = 176 -- PhoneSelect
Menu.KeyCancel = 177 -- PhoneCancel

Menu.posX = 0.05
Menu.posY = 0.05

Menu.ItemWidth = 0.20
Menu.ItemHeight = 0.03

Menu.isOpen = false   -- /!\ Ne pas toucher
Menu.currentPos = {1} -- /!\ Ne pas toucher

--====================================================================================
--  Menu System
--====================================================================================

function Menu.drawRect(posX, posY, width, heigh, color)
    DrawRect(posX + width / 2, posY + heigh / 2, width, heigh, color[1], color[2], color[3], color[4])
end

function Menu.initText(textColor, font, scale)
    font = font or 0
    scale = scale or 0.35
    SetTextFont(font)
    SetTextScale(0.0,scale)
    SetTextCentre(true)
    SetTextDropShadow(0, 0, 0, 0, 0)
    SetTextEdge(0, 0, 0, 0, 0)
    SetTextColour(textColor[1], textColor[2], textColor[3], textColor[4])
    SetTextEntry("STRING")
end

function Menu.draw() 
    -- Draw Rect
    local pos = 0
    local menu = Menu.getCurrentMenu()
    local selectValue = Menu.currentPos[#Menu.currentPos]
    local nbItem = #menu.Items
    -- draw background title & title
    Menu.drawRect(Menu.posX, Menu.posY , Menu.ItemWidth, Menu.ItemHeight * 2, Menu.tileBackgroundColor)    
    Menu.initText(Menu.tileTextColor, 4, 0.7)
    AddTextComponentString(menu.Title)
    DrawText(Menu.posX + Menu.ItemWidth/2, Menu.posY)

    -- draw bakcground items
    Menu.drawRect(Menu.posX, Menu.posY + Menu.ItemHeight * 2, Menu.ItemWidth, Menu.ItemHeight + (nbItem-1)*Menu.ItemHeight, Menu.backgroundColor)
    -- draw all items
    for pos, value in pairs(menu.Items) do
        if pos == selectValue then
            Menu.drawRect(Menu.posX, Menu.posY + Menu.ItemHeight * (1+pos), Menu.ItemWidth, Menu.ItemHeight, Menu.backgroundColorActive)
            Menu.initText(Menu.textColorActive)
        else
            Menu.initText(Menu.textColor)
        end
        AddTextComponentString(value.Title)
        DrawText(Menu.posX + Menu.ItemWidth/2, Menu.posY + Menu.ItemHeight * (pos+1))
    end
    
end

function Menu.getCurrentMenu()
    local currentMenu = Menu.item
    for i=1, #Menu.currentPos - 1 do
        local val = Menu.currentPos[i]
        currentMenu = currentMenu.Items[val].SubMenu
    end
    return currentMenu
end

function Menu.initMenu()
    for i,v in ipairs(Menu.item.Items)do
            if( v['Title'] == 'Ambulancier')then
                table.remove(Menu.item.Items,i)
                
            end
    end
    TriggerEvent("ambulancier:menu")
    Menu.currentPos = {1}
    
end

function Menu.keyControl()
    if IsControlJustPressed(1, Menu.keyDown) then 
        local cMenu = Menu.getCurrentMenu()
        local size = #cMenu.Items
        local slcp = #Menu.currentPos
        Menu.currentPos[slcp] = (Menu.currentPos[slcp] % size) + 1

    elseif IsControlJustPressed(1, Menu.keyUp) then 
        local cMenu = Menu.getCurrentMenu()
        local size = #cMenu.Items
        local slcp = #Menu.currentPos
        Menu.currentPos[slcp] = ((Menu.currentPos[slcp] - 2 + size) % size) + 1

    elseif IsControlJustPressed(1, Menu.KeyCancel) then 
        table.remove(Menu.currentPos)
        if #Menu.currentPos == 0 then
            Menu.isOpen = false 
        end

    elseif IsControlJustPressed(1, Menu.keySelect)  then
        local cSelect = Menu.currentPos[#Menu.currentPos]
        local cMenu = Menu.getCurrentMenu()
        if cMenu.Items[cSelect].SubMenu ~= nil then
            Menu.currentPos[#Menu.currentPos + 1] = 1
        else
            if cMenu.Items[cSelect].Function ~= nil then
                cMenu.Items[cSelect].Function(cMenu.Items[cSelect])
            end
            if cMenu.Items[cSelect].Event ~= nil then
                TriggerEvent(cMenu.Items[cSelect].Event, cMenu.Items[cSelect])
            end
            if cMenu.Items[cSelect].Close == nil or cMenu.Items[cSelect].Close == true then
                Menu.isOpen = false
            end
        end
    end

end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if IsControlJustPressed(1, Menu.keyOpenMenu) then
            Menu.initMenu()
            Menu.isOpen = not Menu.isOpen
        end
        if Menu.isOpen then
            Menu.draw()
            Menu.keyControl()
        end
        if IsControlJustPressed(1, KeyOpenJobsMenu) then
            openMenuJobs()
        end
    end
end)

------------------------
--- Montrer du doigt ---
------------------------
local mp_pointing = false
local keyPressed = false

local function startPointing()
    local ped = GetPlayerPed(-1)
    RequestAnimDict("anim@mp_point")
    while not HasAnimDictLoaded("anim@mp_point") do
        Wait(0)
    end
    SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
    SetPedConfigFlag(ped, 36, 1)
    Citizen.InvokeNative(0x2D537BA194896636, ped, "task_mp_pointing", 0.5, 0, "anim@mp_point", 24)
    RemoveAnimDict("anim@mp_point")
end

local function stopPointing()
    local ped = GetPlayerPed(-1)
    Citizen.InvokeNative(0xD01015C7316AE176, ped, "Stop")
    if not IsPedInjured(ped) then
        ClearPedSecondaryTask(ped)
    end
    if not IsPedInAnyVehicle(ped, 1) then
        SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
    end
    SetPedConfigFlag(ped, 36, 0)
    ClearPedSecondaryTask(PlayerPedId())
end

local once = true
local oldval = false
local oldvalped = false

Citizen.CreateThread(function()
    while true do
        Wait(0)

        if once then
            once = false
        end

        if not keyPressed then
            if IsControlPressed(0, 29) and not mp_pointing and IsPedOnFoot(PlayerPedId()) then
                Wait(200)
                if not IsControlPressed(0, 29) then
                    keyPressed = true
                    startPointing()
                    mp_pointing = true
                else
                    keyPressed = true
                    while IsControlPressed(0, 29) do
                        Wait(50)
                    end
                end
            elseif (IsControlPressed(0, 29) and mp_pointing) or (not IsPedOnFoot(PlayerPedId()) and mp_pointing) then
                keyPressed = true
                mp_pointing = false
                stopPointing()
            end
        end

        if keyPressed then
            if not IsControlPressed(0, 29) then
                keyPressed = false
            end
        end
        if Citizen.InvokeNative(0x921CE12C489C4C41, PlayerPedId()) and not mp_pointing then
            stopPointing()
        end
        if Citizen.InvokeNative(0x921CE12C489C4C41, PlayerPedId()) then
            if not IsPedOnFoot(PlayerPedId()) then
                stopPointing()
            else
                local ped = GetPlayerPed(-1)
                local camPitch = GetGameplayCamRelativePitch()
                if camPitch < -70.0 then
                    camPitch = -70.0
                elseif camPitch > 42.0 then
                    camPitch = 42.0
                end
                camPitch = (camPitch + 70.0) / 112.0

                local camHeading = GetGameplayCamRelativeHeading()
                local cosCamHeading = Cos(camHeading)
                local sinCamHeading = Sin(camHeading)
                if camHeading < -180.0 then
                    camHeading = -180.0
                elseif camHeading > 180.0 then
                    camHeading = 180.0
                end
                camHeading = (camHeading + 180.0) / 360.0

                local blocked = 0
                local nn = 0

                local coords = GetOffsetFromEntityInWorldCoords(ped, (cosCamHeading * -0.2) - (sinCamHeading * (0.4 * camHeading + 0.3)), (sinCamHeading * -0.2) + (cosCamHeading * (0.4 * camHeading + 0.3)), 0.6)
                local ray = Cast_3dRayPointToPoint(coords.x, coords.y, coords.z - 0.2, coords.x, coords.y, coords.z + 0.2, 0.4, 95, ped, 7);
                nn,blocked,coords,coords = GetRaycastResult(ray)

                Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Pitch", camPitch)
                Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Heading", camHeading * -1.0 + 1.0)
                Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isBlocked", blocked)
                Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isFirstPerson", Citizen.InvokeNative(0xEE778F8C7E1142E2, Citizen.InvokeNative(0x19CAFA3C87F7C2FF)) == 4)

            end
        end
    end
end)


-----------------------
--- Lever les mains ---
-----------------------

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local lPed = GetPlayerPed(-1)
        RequestAnimDict("random@mugging3")
        if not IsPedInAnyVehicle(lPed, false) and not IsPedSwimming(lPed) and not IsPedShooting(lPed) and not IsPedClimbing(lPed) and not IsPedCuffed(lPed) and not IsPedDiving(lPed) and not IsPedFalling(lPed) and not IsPedJumping(lPed) and not IsPedJumpingOutOfVehicle(lPed) and IsPedOnFoot(lPed) and not IsPedRunning(lPed) and not IsPedUsingAnyScenario(lPed) and not IsPedInParachuteFreeFall(lPed) then
            if IsControlPressed(1, 323) then
                if DoesEntityExist(lPed) then
                    SetCurrentPedWeapon(lPed, 0xA2719263, true)
                    Citizen.CreateThread(function()
                        RequestAnimDict("random@mugging3")
                        while not HasAnimDictLoaded("random@mugging3") do
                            Citizen.Wait(100)
                        end

                        if not handsup then
                            handsup = true
                            TaskPlayAnim(lPed, "random@mugging3", "handsup_standing_base", 8.0, -8, -1, 49, 0, 0, 0, 0)
                        end   
                    end)
                end
            end
        end
        if IsControlReleased(1, 323) then
            if DoesEntityExist(lPed) then
                Citizen.CreateThread(function()
                    RequestAnimDict("random@mugging3")
                    while not HasAnimDictLoaded("random@mugging3") do
                        Citizen.Wait(100)
                    end

                    if handsup then
                        handsup = false
                        ClearPedSecondaryTask(lPed)
                    end
                end)
            end
        end
    end
end)

-----------------------
--- stop emote ---
-----------------------
Citizen.CreateThread(function()
    while true do
            Citizen.Wait(0)
        local lPed = GetPlayerPed(-1)
             if IsControlPressed(1, 38) or IsControlPressed(1, 177) then
                            ClearPedSecondaryTask(lPed)
            end

            if IsControlPressed(1, 38) and assis == true or IsControlPressed(1, 177) and assis == true or IsControlPressed(1, 30) and assis == true then
                    ClearPedTasks(GetPlayerPed(-1))
                    ClearPedSecondaryTask(GetPlayerPed(-1))
                    stopSit()

            end
    end     
end)


------------------------------
--- retirer/mettre chapeau ---
------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlPressed(1, 303) then --Start holding U
				TriggerEvent('accessories_switcher:toggleHat')
				Citizen.Wait(500)
				-- Perform animation.
		end
	end
end)
