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

--remove items
local function removeItem(src, item, amount)
    if InvType == 'qb' then
        if exports['qb-inventory']:RemoveItem(src, item, amount, false, false, false) then
            TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'remove', amount)
        end
    elseif InvType == 'ox' then
        exports.ox_inventory:RemoveItem(src, item, amount)
    end
end

--add items
local function addItem(src, item, amount)
    if InvType == 'qb' then
        if exports['qb-inventory']:AddItem(src, item, amount, false, false, false) then
            TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add', amount)
        end
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, item, amount) then
            exports.ox_inventory:AddItem(src, item, amount)
        else
            SendNotify(src, Config.Language.Notifications.CantCarry, 'error', 5000)
        end
    end
end



local smokeItems = {
    { name = 'cigs', event = 'lusty94_smoking:client:SmokeCig'},
    { name = 'vape', event = 'lusty94_smoking:client:SmokeVape'},
}

for k,v in pairs(smokeItems) do
    QBCore.Functions.CreateUseableItem(v.name, function(source, item)
        TriggerClientEvent(v.event, source)
    end)
end

for k,_ in pairs(Config.SmokingItems) do
    QBCore.Functions.CreateUseableItem(k, function(source, item)
        TriggerClientEvent("lusty94_smoking:client:OpenPack", source, item.name)
    end)
end



QBCore.Functions.CreateCallback('lusty94_smoking:get:CigPacks', function(source, cb)
    local src = source
    local Ply = QBCore.Functions.GetPlayer(src)
    local pack1 = Ply.Functions.GetItemByName("redwoodpack")
    local pack2 = Ply.Functions.GetItemByName("debonairepack")
    local pack3 = Ply.Functions.GetItemByName("sixtyninepack")
    local pack4 = Ply.Functions.GetItemByName("yukonpack")
    if pack1 and pack1.amount >= 1 or pack2 and pack2.amount >= 1 or pack3 and pack3.amount >= 1 or pack4 and pack4.amount >= 1 then
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
    if cig and cig.amount >= 1 and lighter and lighter.amount >= 1 then
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
    if vape and vape.amount >= 1 and juice and juice.amount >= 1 then
        cb(true)
    else
        cb(false)
    end
end)


--sopen cig packets
RegisterNetEvent('lusty94_smoking:server:OpenPack', function(item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    local cigItem = nil
    for k in pairs(Config.SmokingItems) do
        if k == item then
            cigItem = k
            break
        end
    end
    if not cigItem then return end
    if Player then
        removeItem(src, cigItem, 1)
        Wait(250)
        addItem(src, 'cigs', 20)
    end
end)

--smoke cig
RegisterNetEvent('lusty94_smoking:server:SmokeCig', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        removeItem(src, 'cigs', 1)
    end
end)

--smoke vape
RegisterNetEvent('lusty94_smoking:server:SmokeVape', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local chance = math.random(1,100)
    local remove = 25 -- edit this value for the chance of juice to be removed when smoking a vape currently a 1 in 4 chance
    if Player then
        if remove >= chance then
            removeItem(src, 'vapejuice', 1)
        end
    end
end)

--qb inventory shop
RegisterNetEvent('lusty94_smoking:server:openShop', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local smokingShop = {
        { name = "redwoodpack",      price = 250, amount = 100, info = {}, type = "item", slot = 1,}, 
        { name = "debonairepack",    price = 250, amount = 100, info = {}, type = "item", slot = 2,},
        { name = "sixtyninepack",    price = 250, amount = 100, info = {}, type = "item", slot = 3,},
        { name = "yukonpack",        price = 250, amount = 100, info = {}, type = "item", slot = 4,},
        { name = "vape",             price = 100, amount = 100, info = {}, type = "item", slot = 5,},
        { name = "vapejuice",        price = 50,  amount = 100, info = {}, type = "item", slot = 6,},
        { name = "lighter",          price = 5,   amount = 100, info = {}, type = "item", slot = 7,},
    }
    exports['qb-inventory']:CreateShop({
        name = 'smokingShop',
        label = 'Smoking Shop',
        slots = 7,
        items = smokingShop
    })
    if Player then
        exports['qb-inventory']:OpenShop(source, 'smokingShop')
    end
end)

--ox_ivnentory shop
AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        if InvType == 'ox' then
            exports.ox_inventory:RegisterShop('smokingShop', {
                name = 'Smoking Shop',
                inventory = {
                    { name = 'redwoodpack',     price = 250 },
                    { name = 'yukonpack',       price = 250 },
                    { name = 'sixtyninepack',   price = 250 },
                    { name = 'debonairepack',   price = 250 },
                    { name = 'vape',            price = 100 },
                    { name = 'vapejuice',       price = 50 },
                    { name = 'lighter',         price = 5 },
                },
            })
        end
    end
end)


--------------< VERSION CHECK >-------------

local function CheckVersion()
    PerformHttpRequest('https://raw.githubusercontent.com/Lusty94/UpdatedVersions/main/Smoking/version.txt', function(err, newestVersion, headers)
        local currentVersion = GetResourceMetadata(GetCurrentResourceName(), 'version')
        if not newestVersion then
            print('^1[Lusty94_Smoking]^7: Unable to fetch the latest version.')
            return
        end
        newestVersion = newestVersion:gsub('%s+', '')
        currentVersion = currentVersion and currentVersion:gsub('%s+', '') or "Unknown"
        if newestVersion == currentVersion then
            print(string.format('^2[Lusty94_Smoking]^7: ^6You are running the latest version.^7 (^2v%s^7)', currentVersion))
        else
            print(string.format('^2[Lusty94_Smoking]^7: ^3Your version: ^1v%s^7 | ^2Latest version: ^2v%s^7\n^1Please update to the latest version | Changelogs can be found in the support discord.^7', currentVersion, newestVersion))
        end
    end)
end

CheckVersion()