--====================================================================================
-- #Author: Jonathan D @ Gannon
-- 
-- Développée pour la communauté n3mtv
--      https://www.twitch.tv/n3mtv
--      https://twitter.com/n3m_tv
--      https://www.facebook.com/lan3mtv
--====================================================================================

-- Configuration BDD

--====================================================================================
--  Teste si un joueurs a donnée ces infomation identitaire
--====================================================================================
function hasIdentity(source)
    local identifier = GetPlayerIdentifiers(source)[1]
    local result = MySQL.Sync.fetchAll("SELECT nom, prenom FROM users WHERE identifier = @identifier", {
        ['@identifier'] = identifier
    })
    local user = result[1]
    return not (user['nom'] == '' or user['prenom'] == '')
end

function getIdentity(source)
    local identifier = GetPlayerIdentifiers(source)[1]
    local result = MySQL.Sync.fetchAll("SELECT users.* , jobs.job_name AS jobs FROM users JOIN jobs WHERE users.job = jobs.job_id and users.identifier = @identifier", {
        ['@identifier'] = identifier
    })
    if #result == 1 then
        result[1]['id'] = source
        return result[1]
    else
        return {}
    end
end

function setIdentity(identifier, data)
    MySQL.Async.fetchAll("UPDATE users SET nom = @nom, prenom = @prenom, dateNaissance = @dateNaissance, sexe = @sexe, taille = @taille WHERE identifier = @identifier", {
        ['@nom'] = data.nom,
        ['@prenom'] = data.prenom,
        ['@dateNaissance'] = data.dateNaissance,
        ['@sexe'] = data.sexe,
        ['@taille'] = data.taille,
        ['@identifier'] = identifier
    })
end

AddEventHandler('es:playerLoaded', function(source)
    print('playerload')
    local source = source
    local result = hasIdentity(source)
    if result == false then
        TriggerClientEvent('gc:showRegisterItentity', source, {})
    end
end)

RegisterServerEvent('gc:openIdentity')
AddEventHandler('gc:openIdentity',function(other)
    local source = source
    local data = getIdentity(source)
    if data ~= nil then
        TriggerClientEvent('gc:showItentity', other, {
            nom = data.nom,
            prenom = data.prenom,
            sexe = data.sexe,
            dateNaissance = os.date("%x",data.dateNaissance/1000),
            jobs = data.jobs,
            taille = data.taille,
            id = data.id
        })
    end
end)

RegisterServerEvent('gc:showItentityOther')
AddEventHandler('gc:showItentityOther',function(other)
    local source = source
    local data = getIdentity(other)
    if data ~= nil then
        TriggerClientEvent('gc:showItentity', source, {
            nom = data.nom,
            prenom = data.prenom,
            sexe = data.sexe,
            dateNaissance = os.date("%x",data.dateNaissance/1000),
            jobs = data.jobs,
            taille = data.taille,
            id = data.id
        })
        TriggerClientEvent('gcl:notify', other, '~o~Votre carte d\'identité à était prise')
    end
end)

RegisterServerEvent('gc:openMeIdentity')
AddEventHandler('gc:openMeIdentity',function()
    local source = source
    local data = getIdentity(source)
    if data ~= nil then
        TriggerClientEvent('gc:showItentity', source, {
            nom = data.nom,
            prenom = data.prenom,
            sexe = data.sexe,
            dateNaissance = os.date("%x",data.dateNaissance/1000),
            jobs = data.jobs,
            taille = data.taille,
            id = data.id
        })
    end
end)

RegisterServerEvent('gc:setIdentity')
AddEventHandler('gc:setIdentity', function(data)
    setIdentity(GetPlayerIdentifiers(source)[1], data)
end)

--=============================================================================
--      Licence Car
--=============================================================================
function getLicenceDriver(source)
    local identifier = GetPlayerIdentifiers(source)[1]
    local data_identity = getIdentity(source)
    local data_license = MySQL.Sync.fetchAll("SELECT * FROM user_license WHERE type = 'car'and identifier = @identifier", {
        ['@identifier'] = identifier
    })

    if #data_license == 1 then
       --var inutilisée ? local day = data_license[1]["created_at"]["day"]
       -- local month = data_license[1]["created_at"]["month"]
      --  local year = data_license[1]["created_at"]["year"]
        return {
            nom = data_identity.nom,
            prenom = data_identity.prenom,
            dateNaissance = os.date("%x",data_identity.dateNaissance/1000),
            type = 'Permis B',
            date = os.date("%x",data_license[1].created_at/1000),
            point = data_license[1]['points']
        }
    else
        return nil
    end

end


function showLicenceDriver(source, dest)
    local data = getLicenceDriver(source)
    if data ~= nil then
        TriggerClientEvent('gc:showLicenceDriver', dest, data)
    else
        TriggerClientEvent('gcl:notify', source, '~o~Vous n\'avez pas de permis de conduire')
    end
end
RegisterServerEvent('gc:openMeLicenceDriver')
AddEventHandler('gc:openMeLicenceDriver',function()
    local source = source
    showLicenceDriver(source, source)
end)

RegisterServerEvent('gc:showMeLicenceDriver')
AddEventHandler('gc:showMeLicenceDriver',function(dest)
    local source = source
    showLicenceDriver(source, dest)
end)
