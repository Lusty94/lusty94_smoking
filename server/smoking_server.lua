local QBCore = exports['qb-core']:GetCoreObject()
local InvType = Config.CoreSettings.Inventory.Type
local NotifyType = Config.CoreSettings.Notify.Type

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

--useable items
for itemName, _ in pairs(Config.Consumables) do
    QBCore.Functions.CreateUseableItem(itemName, function(source, item)
        TriggerClientEvent('lusty94_smoking:client:UseItem', source, item.name)
    end)
end


--callback for items and required items
QBCore.Functions.CreateCallback('lusty94_smoking:server:hasItem', function(source, cb, itemName)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item = Config.Consumables[itemName]
    if item then
        if item.requiredItem then
            local requiredItem = Player.Functions.GetItemByName(item.requiredItem)         
            if requiredItem then
                cb(true)
            else
                SendNotify(src, 'You need a ' .. item.requiredLabel .. ' to use this!', 'error', 5000)    
                cb(false)
            end
        else
            cb(true)
        end
    else
        cb(false)       
    end
end)

--use item
RegisterNetEvent('lusty94_smoking:server:UseItem', function(itemName)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        removeItem(src, itemName, 1)
    end
end)

--return item
RegisterNetEvent('lusty94_smoking:server:returnItems', function(itemName, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        addItem(src, itemName, amount)
    end
end)

--use vape juice
RegisterNetEvent('lusty94_smoking:server:UseVapeJuice', function(itemName, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local chance = 25 -- 25% chance to remove vape juice upon use
    local juice = 'vapejuice' -- if changing the name of vapejuice make sure to change it here also so it removes correctly
    if Player then
        if chance >= math.random(1,100) then
            removeItem(src, juice, 1)
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