FaceChooser =  {}
FaceChooser.Type = {
    {index = 0,  display = 'Largeur du nez',            min = -1.0, max = 3.0, currentValue = 0},
    {index = 1,  display = 'Hauteur du nez',            min = -1.0, max = 2.0, currentValue = 0},
    {index = 2,  display = 'Profondeur du nez',         min = -2.0, max = 1.0, currentValue = 0},
    {index = 3,  display = 'Hauteur de la bosse nasale',min = -1.5, max = 1.0, currentValue = 0},
    {index = 4,  display = 'Hauteur du bout du nez',    min = -1.5, max = 1.0, currentValue = 0},
    {index = 5,  display = 'Distorsion latéral du nez', min = -1.5, max = 1.5, currentValue = 0},
    {index = 6,  display = 'Hauteurs des sourcils',     min = -1.5, max = 2.0, currentValue = 0},
    {index = 7,  display = 'Profondeurs des sourcils',  min = -1.0, max = 2.0, currentValue = 0},
    {index = 8,  display = 'Hauteurs des paumettes',    min = -1.5, max = 1.5, currentValue = 0},
    {index = 9,  display = 'Epaisseurs des paumettes',  min = -1.0, max = 2.0, currentValue = 0},
    {index = 10, display = 'Creux des joues',           min = -1.5, max = 3.0, currentValue = 0},
    {index = 11, display = 'Ouvertures des yeux',       min = -1.0, max = 1.5, currentValue = 0},
    {index = 12, display = 'Epaisseurs des levres',     min = -1.0, max = 1.0, currentValue = 0},
    {index = 13, display = 'Largeur de la machoire',    min = -2.0, max = 3.0, currentValue = 0},
    {index = 14, display = 'Hauteur de la machoire',    min = -1.5, max = 1.5, currentValue = 0},
    {index = 15, display = 'Hauteurs du menton',        min = -1.5, max = 2.0, currentValue = 0},
    {index = 16, display = 'Profondeur du menton',      min = -1.0, max = 2.0, currentValue = 0},
    {index = 17, display = 'Largeurdu  menton',         min = -1.0, max = 1.5, currentValue = 0},
    {index = 18, display = 'Fossette du menton',        min = -2.0, max = 2.5, currentValue = 0},
    {index = 19, display = 'Epaisseur du cou',          min = -1.5, max = 2.5, currentValue = 0}
}


local inEdit = false
local currentItem = 0
local distanceCam = 0.35
function startEditFace()
    Citizen.CreateThread(function()
        currentItem = 0 
        inEdit = true 
        local me = GetPlayerPed(-1) 
        local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
        local boneIndex = 65068
        
        SetCamActive(cam, true)
        RenderScriptCams(true, false, 0, 1, 0)
        index = 0
        value = 0.0
        local h = GetEntityHeading(me)
        
        -- PED_FLAG_FREEZE 292
        SetPedConfigFlag(me, 292, 1)

        while inEdit == true do

            --GET_GAMEPLAY_CAM_ROT
            local YawCam = Citizen.InvokeNative(0x837765A25378F0BB, 0, Citizen.ResultAsVector()).z
            AttachCamToPedBone(cam, me, boneIndex, math.cos(YawCam * 0.01745329251) * distanceCam, math.sin(YawCam * 0.01745329251) * distanceCam ,0.05 , true)
            SetCamRot(cam, 0.0, 0.0, YawCam + h + 90, true)
            DrawMenu()
            if IsControlJustPressed(1, 172) then
                currentItem = (currentItem + #FaceChooser.Type) % (#FaceChooser.Type + 1)
            elseif IsControlJustPressed(1, 173) then
                currentItem = (currentItem + 1) % (#FaceChooser.Type + 1)
            elseif IsControlJustPressed(1, 176) then
                if currentItem == #FaceChooser.Type then 
                    saveFace()
                    inEdit = false 
                    break
                end
            elseif IsControlPressed(1, 174) and currentItem ~= #FaceChooser.Type then
                FaceChooser.Type[currentItem+1].currentValue = math.max(FaceChooser.Type[currentItem+1].currentValue - 0.05, FaceChooser.Type[currentItem + 1].min)
                changeFace(me)
            elseif IsControlPressed(1, 175) and currentItem ~= #FaceChooser.Type then
                FaceChooser.Type[currentItem+1].currentValue = math.min(FaceChooser.Type[currentItem+1].currentValue + 0.05, FaceChooser.Type[currentItem + 1].max)
                changeFace(me)
            end
            Citizen.Wait(0)
        end
   
        SetPedConfigFlag(me, 292, 0)
        RenderScriptCams(false, false, 0, 1, 0)
        DestroyCam(cam, false)
    end)
end

local Colors = {
    background = {0, 0, 0, 210},
    backgroundActive = {10, 180, 25, 210},
    sliderColor = {255, 255, 255, 255},
    cursorColor = {255, 0, 0, 255},
    btnBackColorActive = {10, 180, 25, 210}
}
function DrawRect2(x, y, w, h, color)
    DrawRect(x + w / 2, y + h / 2, w, h, color[1], color[2], color[3], color[4])
end

function DrawMenu()
    local cx = 0.02
    local cy = 0.005 
    local w  = 0.3
    local h = 0.03

    local sx = w / 2
    local sy = h / 2 
    local sw  = 0.14
    local sh = 0.005 

    local scw = 0.005
    local sch = sh

    for k, v in ipairs(FaceChooser.Type) do 
        local backColor = Colors.background 
        if currentItem + 1 == k then 
            backColor = Colors.backgroundActive
        end
        DrawRect2(cx, cy + h * (k - 1), w, h, backColor)

        SetTextFont(0)
        SetTextScale(0.0,0.25)
        SetTextCentre(false)
        SetTextDropShadow(0, 0, 0, 0, 0)
        SetTextEdge(0, 0, 0, 0, 0)
        SetTextColour(255, 255, 255, 255)
        SetTextEntry("STRING")
        AddTextComponentString(v.display)
        DrawText(cx + 0.005, cy + h * (k - 1 + 0.5) - 0.01)
        
        DrawRect2(cx + sx, cy + h * (k - 1) + sy , sw, sh, Colors.sliderColor)
        local offset = sw * ((v.currentValue - v.min) / (v.max - v.min)) 
        DrawRect2(cx + sx + offset - scw /2 , cy + h * (k - 1) + sy  , scw, sch, Colors.cursorColor)
    end

    if currentItem == #FaceChooser.Type then 
        DrawRect2(cx, cy + h * #FaceChooser.Type, w, h, Colors.btnBackColorActive)
    else
        DrawRect2(cx, cy + h * #FaceChooser.Type, w, h, Colors.background)
    end
    
    SetTextFont(0)
    SetTextScale(0.0,0.4)
    SetTextCentre(true)
    SetTextDropShadow(0, 0, 0, 0, 0)
    SetTextEdge(0, 0, 0, 0, 0)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    AddTextComponentString("Valider")
    DrawText(cx + w /2 , cy + h * (#FaceChooser.Type + 0.5) - 0.015)

end

function changeFace(ped)
    for _, v in ipairs(FaceChooser.Type) do 
        SetPedFaceFeature(ped, v.index, v.currentValue)
    end
end

function saveFace()
    local data = {}
    for _, v in ipairs(FaceChooser.Type) do 
        table.insert(data, v.currentValue)
    end
    TriggerServerEvent('face:save', data)
end



RegisterNetEvent("face:openface")
AddEventHandler("face:openface", function()
    Citizen.CreateThread(function () 
        startEditFace()
    end)
end)

-- TriggerEvent("face:openface") ADD To skin/client.lua @ line 380

RegisterNetEvent("face:setFace")
AddEventHandler("face:setFace", function(data)
    Citizen.CreateThread(function ()
        Citizen.Wait(10000)
        local me = GetPlayerPed(-1) 
        for k, v in ipairs(data) do 
            local value = 1.0 * v
            SetPedFaceFeature(me, k - 1, value)
        end
    end)
end)
