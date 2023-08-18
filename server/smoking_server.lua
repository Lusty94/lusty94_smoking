local QBCore = exports['qb-core']:GetCoreObject()


QBCore.Functions.CreateUseableItem("redwoodpack", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("lusty94_smoking:client:openPack", source)
    Player.Functions.RemoveItem("redwoodpack", 1)
        TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items["redwoodpack"], "remove")
end)
QBCore.Functions.CreateUseableItem("debonairepack", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("lusty94_smoking:client:openPack", source)
    Player.Functions.RemoveItem("debonairepack", 1)
        TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items["debonairepack"], "remove")
end)
QBCore.Functions.CreateUseableItem("69brandpack", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("lusty94_smoking:client:openPack", source)
    Player.Functions.RemoveItem("69brandpack", 1)
        TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items["69brandpack"], "remove")
end)
QBCore.Functions.CreateUseableItem("yukonpack", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("lusty94_smoking:client:openPack", source)
    Player.Functions.RemoveItem("yukonpack", 1)
        TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items["yukonpack"], "remove")
end)



QBCore.Functions.CreateUseableItem("cigs", function(source, item)
    TriggerClientEvent("lusty94_smoking:client:SmokeCig", source)
end)

QBCore.Functions.CreateUseableItem("vape", function(source, item)
    TriggerClientEvent("lusty94_smoking:client:SmokeVape", source)
end)


RegisterNetEvent('lusty94_smoking:server:OpenPack', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

        Player.Functions.AddItem("cigs", 20)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["cigs"], "add")
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
        Player.Functions.RemoveItem("vapejuice", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["vapejuice"], "remove")
    end
end)

RegisterNetEvent('lusty94_smoking:server:SmokeCig', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

        Player.Functions.RemoveItem("cigs", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["cigs"], "remove")
end)


AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end
    print('^5--<^3!^5>-- ^7Lusty94 ^5| ^5--<^3!^5>-- ^5Smoking V1.1.0 Started Successfully ^5--<^3!^5>--^7')
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