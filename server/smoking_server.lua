local QBCore = exports['qb-core']:GetCoreObject()
local InvType = Config.CoreSettings.Inventory.Type

QBCore.Functions.CreateUseableItem("redwoodpack", function(source, item)
    TriggerClientEvent("lusty94_smoking:client:RedwoodPack", source)
end)
QBCore.Functions.CreateUseableItem("debonairepack", function(source, item)   
    TriggerClientEvent("lusty94_smoking:client:DebonairePack", source)
end)
QBCore.Functions.CreateUseableItem("69brandpack", function(source, item)
   
    TriggerClientEvent("lusty94_smoking:client:69BrandPack", source)
end)
QBCore.Functions.CreateUseableItem("yukonpack", function(source, item)
   
    TriggerClientEvent("lusty94_smoking:client:YukonPack", source)
end)



QBCore.Functions.CreateUseableItem("cigs", function(source, item)
    TriggerClientEvent("lusty94_smoking:client:SmokeCig", source)
end)

QBCore.Functions.CreateUseableItem("vape", function(source, item)
    TriggerClientEvent("lusty94_smoking:client:SmokeVape", source)
end)








RegisterNetEvent('lusty94_smoking:server:OpenRedwoodPack', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if InvType == 'qb' then
        Player.Functions.RemoveItem("redwoodpack", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["redwoodpack"], "remove")
        Player.Functions.AddItem("cigs", 20)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["cigs"], "add")
    elseif InvType == 'ox' then
        exports.ox_inventory:RemoveItem(src,"redwoodpack", 1)
        exports.ox_inventory:AddItem(src,"cigs", 20)
    end
end)
RegisterNetEvent('lusty94_smoking:server:OpenDebonairePack', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if InvType == 'qb' then
        Player.Functions.RemoveItem("debonairepack", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["debonairepack"], "remove")
        Player.Functions.AddItem("cigs", 20)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["cigs"], "add")
    elseif InvType == 'ox' then
        exports.ox_inventory:RemoveItem(src,"debonairepack", 1)
        exports.ox_inventory:AddItem(src,"cigs", 20)
    end
end)
RegisterNetEvent('lusty94_smoking:server:Open69BrandPack', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if InvType == 'qb' then
        Player.Functions.RemoveItem("69brandpack", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["69brandpack"], "remove")
        Player.Functions.AddItem("cigs", 20)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["cigs"], "add")
    elseif InvType == 'ox' then
        exports.ox_inventory:RemoveItem(src,"69brandpack", 1)
        exports.ox_inventory:AddItem(src,"cigs", 20)
    end
end)
RegisterNetEvent('lusty94_smoking:server:OpenYukonPack', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if InvType == 'qb' then
        Player.Functions.RemoveItem("yukonpack", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["yukonpack"], "remove")
        Player.Functions.AddItem("cigs", 20)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["cigs"], "add")
    elseif InvType == 'ox' then
        exports.ox_inventory:RemoveItem(src,"yukonpack", 1)
        exports.ox_inventory:AddItem(src,"cigs", 20)
    end
end)






QBCore.Functions.CreateCallback('lusty94_smoking:get:Cigs', function(source, cb)
    local src = source
    local Ply = QBCore.Functions.GetPlayer(src)
    local cig = Ply.Functions.GetItemByName("cigs")
    local lighter = Ply.Functions.GetItemByName("lighter")
    if cig  and lighter  then
        cb(true)
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('lusty94_smoking:get:Vape', function(source, cb)
    local src = source
    local Ply = QBCore.Functions.GetPlayer(src)
    local vape = Ply.Functions.GetItemByName("vape")
    local juice = Ply.Functions.GetItemByName("vapejuice")
    if vape and juice then
        cb(true)
    else
        cb(false)
    end
end)


RegisterNetEvent('lusty94_smoking:server:SmokeVape', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    local chance = math.random(1,100)
    local chance1 = 25 -- edit this value for the chance of juice to be removed when smoking a vape currently a 1 in 4 chance

    if chance1 >= chance then
        if InvType == 'qb' then
            Player.Functions.RemoveItem("vapejuice", 1)
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["vapejuice"], "remove")
        elseif InvType == 'ox' then
            exports.ox_inventory:RemoveItem(src,"vapejuice", 1)
        end
    end
end)

RegisterNetEvent('lusty94_smoking:server:SmokeCig', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if InvType == 'qb' then
        Player.Functions.RemoveItem("cigs", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["cigs"], "remove")
    elseif InvType == 'ox' then
        exports.ox_inventory:RemoveItem(src,"cigs", 1)
    end
end)


AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end
    print('^5--<^3!^5>-- ^7Lusty94 ^5| ^5--<^3!^5>-- ^5Smoking V1.2.0 Started Successfully ^5--<^3!^5>--^7')
end)

local function CheckVersion()
	PerformHttpRequest('https://raw.githubusercontent.com/Lusty94/UpdatedVersions/main/Smoking/version.txt', function(err, newestVersion, headers)
		local currentVersion = GetResourceMetadata(GetCurrentResourceName(), 'version')
		if not newestVersion then print("Currently unable to run a version check.") return end
		local advice = "^1You are currently running an outdated version^7, ^1please update^7"
		if newestVersion:gsub("%s+", "") == currentVersion:gsub("%s+", "") then advice = '^6You are running the latest version.^7'
		else print("^3Version Check^7: ^5Current^7: "..currentVersion.." ^5Latest^7: "..newestVersion.." "..advice) end
	end)
end
CheckVersion()