local ESX = nil
local allBlips = {}
local gpsCarState = false

if not Config.newEsx then
    Citizen.CreateThread(function()
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    
        while ESX == nil do Citizen.Wait(100) end
    
        while ESX.GetPlayerData().job == nil do
            Citizen.Wait(10)
        end
    
        ESX.PlayerData = ESX.GetPlayerData()
    end)
else
    ESX = exports["es_extended"]:getSharedObject()
end


RegisterNetEvent('rGpsCar:addCarGpsClient')
AddEventHandler('rGpsCar:addCarGpsClient', function(allGpsCars)
    for k, v in pairs(allBlips) do
        RemoveBlip(v)
    end

    allBlips = {}
    if gpsCarState then
        for k, v in pairs(allGpsCars) do
            if ESX.PlayerData.job.name == v.job then
                local blip = AddBlipForEntity(v.entity)
                SetBlipSprite(blip, 1)
                SetBlipDisplay(blip, 4)
                SetBlipScale(blip, 0.8)
                BeginTextCommandSetBlipName('STRING')
                AddTextComponentSubstringPlayerName("Véhicule collège - "..ESX.PlayerData.job.label)
                EndTextCommandSetBlipName(blip)
                table.insert(allBlips, blip)
            end
        end
    end
end)


RegisterCommand("gpscar", function()
    if not gpsCarState then
        gpsCarState = true
        ESX.ShowNotification("~g~GPS activer")
        TriggerServerEvent("rGpsCar:enableGps")
    else
        gpsCarState = false
        ESX.ShowNotification("~r~GPS désactiver")
        TriggerServerEvent("rGpsCar:enableGps")
    end
end)

TriggerEvent('chat:addSuggestion', '/gpscar', 'Activer / Désactiver GPS véhicules collèges')