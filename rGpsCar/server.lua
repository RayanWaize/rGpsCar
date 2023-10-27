local ESX = nil
local allCarsGPS = {}

if not Config.newEsx then
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
else
    ESX = exports["es_extended"]:getSharedObject()
end

RegisterServerEvent("rGpsCar:addCarGps")
AddEventHandler("rGpsCar:addCarGps", function(entityCar, jobCar)
    local _src = source
    local _entityCar = entityCar
    local _jobCar = jobCar
    if not allCarsGPS[tostring(_entityCar)] then
        allCarsGPS[tostring(_entityCar)] = {job = _jobCar, entity = _entityCar}
        TriggerClientEvent("rGpsCar:addCarGpsClient", -1, allCarsGPS)
    end
end)


RegisterServerEvent("rGpsCar:removeGpsCar")
AddEventHandler("rGpsCar:removeGpsCar", function(entityCar)
    local _src = source
    local _entityCar = entityCar
    if allCarsGPS[tostring(_entityCar)] then
        table.remove(allCarsGPS[tostring(_entityCar)])
        TriggerClientEvent("rGpsCar:addCarGpsClient", -1, allCarsGPS)
    end
end)

RegisterServerEvent("rGpsCar:enableGps")
AddEventHandler("rGpsCar:enableGps", function()
    local _src = source
    TriggerClientEvent("rGpsCar:addCarGpsClient", _src, allCarsGPS)
end)