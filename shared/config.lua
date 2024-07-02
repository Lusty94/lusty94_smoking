Config = {}

--
--██╗░░░░░██╗░░░██╗░██████╗████████╗██╗░░░██╗░█████╗░░░██╗██╗
--██║░░░░░██║░░░██║██╔════╝╚══██╔══╝╚██╗░██╔╝██╔══██╗░██╔╝██║
--██║░░░░░██║░░░██║╚█████╗░░░░██║░░░░╚████╔╝░╚██████║██╔╝░██║
--██║░░░░░██║░░░██║░╚═══██╗░░░██║░░░░░╚██╔╝░░░╚═══██║███████║
--███████╗╚██████╔╝██████╔╝░░░██║░░░░░░██║░░░░█████╔╝╚════██║
--╚══════╝░╚═════╝░╚═════╝░░░░╚═╝░░░░░░╚═╝░░░░╚════╝░░░░░░╚═╝


-- Thank you for downloading this script!

-- Below you can change multiple options to suit your server needs.


Config.Blips = {
    {title = 'Smoking Shop', colour = 5, id = 648, coords = vector3(172.19, -1336.0, 29.3), scale = 0.7, useblip = true}, -- BLIP FOR SMOKING SHOP
}


Config.CoreSettings = {
    EventNames = {
        HudStatus = 'hud:server:RelieveStress', -- NAME OF HUD EVENT TO RELIEVE STRESS - DEFAULT EVENT NAME IS 'hud:server:RelieveStress'
    },
    Notify = {
        Type = 'qb', -- support for qb-core notify, okokNotify, mythic_notify, boii_ui notify and ox_lib notify,
        --use 'qb' for default qb-core notify
        --use 'okok' for okokNotify
        --use 'mythic' for mythic_notify
        --use 'boii' for boii_ui notify
        --use 'ox' for ox_lib notify
    },
    Target = {
        Type = 'qb', -- support for qb-target and ox_target
        -- use 'qb' for qb-target
        --use 'ox' for ox_target
    },    
    Inventory = { --support for qb-inventory and ox_inventory
        Type = 'qb',
        --use 'qb' for qb-inventory
        --use 'ox' for ox_inventory
    },
    Shop = {
        Type = 'qb', -- support for qb-inventory shops, jim-shops and ox_inventory shops
        --use 'qb' for qb-shops
        --use 'jim' for jim-shops
        --use 'ox' for ox_inventory shops
    },
    Timers = {
        OpenPack = 5000, -- time it takes in MS to open pack of cigs
        SmokeCig = 10000, -- time it takes in MS to smoke cigs
        SmokeVape = 10000, -- time it takes in MS to smoke a vape
    },
    Effects = {

        --CIGARETTES ONLY
        RemoveHealth = true, -- removes a small amount of health when the player smokes a cigarette
        HealthAmount = math.random(1,5), -- if set to true then how much health does the player lose?

        --VAPES ONLY
        AddHealth = true, -- adds a small amount of health when the player smokes a vape
        VapeHealthAmount = math.random(5,10), -- if set to true then how much health does the player gain?

        --VAPES AND CIGARETTES
        AddArmour = true, -- add armour from smoking
        ArmourAmount = math.random(5,10), -- if set to true then how much armour does the player gain?

        RemoveStress = true, -- removes stress from smoking
        RemoveStressAmount = math.random(5,10), -- if set to true then how much stress relief does the player get?
        
    },
}

Config.DebugPoly = false -- debugs polyzones if using target locations for shops
Config.UseTargetShop = true -- if set to true it creates target zones for players to purchase packs of cigs from - set to false if you have your own methods of getting the cig packs

Config.InteractionLocations = { --name must be unique, coords is location, size is for ox target only, width is width of zone, height is height of zone, heading is direction, minZ is minZ of zone, maxZ is maxZ of zone, icon is target icon, label is target label, item is required item to target zone, job is required job to target zone leave as nil if not needed, distance is target distance
    { Name = 'shop1', Coords = vector3(170.03, -1337.09, 29.3), Size = vec3(1.5,1.5,3), Width = 1.5, Height = 1.5, Heading = 100, MinZ = 28.5, MaxZ = 31, Icon = 'fa-solid fa-smoking', Label = 'Open Smoking Shop', Item = nil, Job = nil, Distance = 2.0, Event = 'lusty94_smoking:client:openShop',},
}

Config.SmokingItems = { -- names of cig packets
    ["redwoodpack"],
    ["debonairepack"],
    ["sixtyninepack"],
    ["yukonpack"],
}
