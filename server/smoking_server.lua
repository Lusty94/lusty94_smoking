local QBCore = exports['qb-core']:GetCoreObject()
local InvType = Config.CoreSettings.Inventory.Type

--notification function
local function SendNotify(src, msg, type, time, title)
    if NotifyType == nil then print("Lusty94_Smoking: NotifyType Not Set in Config.CoreSettings.Notify.Type!") return end
    if not title then title = "Smoking" end
    if not time then time = 5000 end
    if not type then type = 'success' end
    if not msg then print("Notification Sent With No Message") return end
    if NotifyType == 'qb' then
        TriggerClientEvent('QBCore:Notify', src, msg, type, time)
    elseif NotifyType == 'okok' then
        TriggerClientEvent('okokNotify:Alert', src, title, msg, time, type, Config.CoreSettings.Notify.Sound)
    elseif NotifyType == 'mythic' then
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = type, text = msg, style = { ['background-color'] = '#00FF00', ['color'] = '#FFFFFF' } })
    elseif NotifyType == 'boii'  then
        TriggerClientEvent('boii_ui:notify', src, title, msg, type, time)
    elseif NotifyType == 'ox' then 
        TriggerClientEvent('ox_lib:notify', src, ({ title = title, description = msg, length = time, type = type, style = 'default'}))
    end
end

QBCore.Functions.CreateUseableItem("cigs", function(source, item)
    TriggerClientEvent("lusty94_smoking:client:SmokeCig", source)
end)

QBCore.Functions.CreateUseableItem("vape", function(source, item)
    TriggerClientEvent("lusty94_smoking:client:SmokeVape", source)
end)



--useable items for smoking
for k,_ in pairs(Config.SmokingItems) do
    QBCore.Functions.CreateUseableItem(k, function(source, item)
        TriggerClientEvent("lusty94_smoking:client:OpenPack", source, item.name)
    end)
end

--smoke cig
RegisterNetEvent('lusty94_smoking:server:OpenPack', function(item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end
    local cigItem = nil
    for k in pairs(Config.SmokingItems) do
        if k == item then
            cigItem = k
            break
        end
    end
    if not cigItem then return end
    if InvType == 'qb' then
        Player.Functions.RemoveItem(cigItem, 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[cigItem], "remove")
        Player.Functions.AddItem('cigs', 20)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['cigs'], "add", 20)
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, "cigs", 20) then
            exports.ox_inventory:RemoveItem(src, cigItem, 1)
            exports.ox_inventory:AddItem(src, 'cigs', 20)
        else
            SendNotify(src,"You Can\'t Carry Anymore of This Item!", 'error', 2000)
        end
    end
end)



QBCore.Functions.CreateCallback('lusty94_smoking:get:CigPacks', function(source, cb)
    local src = source
    local Ply = QBCore.Functions.GetPlayer(src)
    local pack1 = Ply.Functions.GetItemByName("redwoodpack")
    local pack2 = Ply.Functions.GetItemByName("debonairepack")
    local pack3 = Ply.Functions.GetItemByName("69brandpack")
    local pack4 = Ply.Functions.GetItemByName("yukonpack")
    if pack1 or pack2 or pack3 or pack4 then
        cb(true)
    else
        cb(false)
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
    if not Player then return end
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
    if not Player then return end
    if InvType == 'qb' then
        Player.Functions.RemoveItem("cigs", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["cigs"], "remove")
    elseif InvType == 'ox' then
        exports.ox_inventory:RemoveItem(src,"cigs", 1)
    end
end)

--smoking shop
function smokingShop()
    exports.ox_inventory:RegisterShop('smokingShop', {
        name = 'Smoking Shop',
        inventory = {
            { name = 'redwoodpack', price = 250 },
            { name = 'yukonpack', price = 250 },
            { name = 'sixtyninepack', price = 250 },
            { name = 'debonairepack', price = 250 },
            { name = 'lighter', price = 5 },
            { name = 'vape', price = 25 },
            { name = 'vapejuice', price = 25 },
        },
    })
end


-- dont touch this is for ox stashes and shops
AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        if InvType == 'ox' then
            print('^5--<^3!^5>-- ^7| Lusty94_Smoking |^5 ^5--<^3!^5>--^7')
            print('^5--<^3!^5>-- ^7| Inventory Type is set to ox |^5 ^5--<^3!^5>--^7')
            print('^5--<^3!^5>-- ^7| Registering shops automatically |^5 ^5--<^3!^5>--^7')
            smokingShop()
            print('^5--<^3!^5>-- ^7| Shops registered successfully |^5 ^5--<^3!^5>--^7')
        end
    end
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


