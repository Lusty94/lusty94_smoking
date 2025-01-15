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


Config.CoreSettings = {
    Notify = {
        Type = 'qb', -- support for qb-core notify, okokNotify, mythic_notify and ox_lib notify,
        --use 'qb' for default qb-core notify
        --use 'okok' for okokNotify
        --use 'mythic' for mythic_notify
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
}

Config.Blips = { -- if using the target zones for a smoking shop then you can enabled a blip for the location here
    {
        useblip = true,
        title = 'Smoking Shop',
        colour = 5,
        id = 648,
        coords = vector3(172.19, -1336.0, 29.3),
        scale = 0.7,
    },
}

Config.DebugPoly = true -- displays zones if using target locations for shops
Config.UseTargetShop = true -- if set to true this creates target zones for players to purchase smoking items - set to false if you have used your own methods of obtaining the items

Config.InteractionLocations = { 
    --name must be unique
    --coords is location
    --size is for ox target only
    --width is width of zone
    --height is height of zone
    --heading is direction
    --icon is target icon
    --label is target label
    --distance is target distance
    { 
        Name = 'shop1', 
        Coords = vector3(170.03, -1337.09, 29.3), 
        Size = vec3(1.5,1.5,3), --for ox_target only
        Width = 1.5, 
        Height = 1.5, 
        Heading = 100,
        Icon = 'fa-solid fa-smoking', 
        Label = 'Open Smoking Shop', 
        Distance = 2.0, 
    },
}

Config.Consumables = {
    --<<!! IMPORTANT NOTES !!>>--

    --["redwoodpack"] - this is the useable item name
    --label - this is the label for progressCircle
    --duration - in seconds the duration to use the item so 10 would be 10 seconds
    --requiredItem = name of the item that is required to use this item
    --requiredLabel = label of required item for notification
    --returnItem - boolean value if the useable item should return something [packs return cigarettes]
    --returned = item name to be returned for example 'cigs' are returned from the packets
    --amountReturned = amount of returned item recieved for example 20 cigs from a pack
    --dict = animation dict
    --anim - animation name
    --flags = animation flags
    --prop = prop name for animation
    --bone = bone index for animation
    --pos = vec3 value for position of prop during animation
    --rot = vec3 value for rotation of prop during animation
    --stress = amount of stress reduction received from using item
    --armour = amount of armour received from using item
    --damageHealth = amount of health to be removed from using item

    ["redwoodpack"] = {
        label = 'Opening redwoods pack',
        duration = 10,
        requiredItem = nil,
        requiredLabel = '',
        returnItem = true,
        returned = 'cigs',
        amountReturned = 20,
        dict = 'amb@prop_human_parking_meter@female@base',
        anim = 'base_female',
        flags = 49,
        prop = 'v_ret_ml_cigs',
        bone = 57005,
        pos = vec3(0.14, 0.01, -0.03),
        rot = vec3(2.0, 68.0, -32.0),
        stress = 0,
        armour = 0,
        damageHealth = 0,
    },
    ["debonairepack"] = {
        label = 'Opening debonaire pack',
        duration = 10,
        requiredItem = nil,
        requiredLabel = '',
        returnItem = true,
        returned = 'cigs',
        amountReturned = 20,
        dict = 'amb@prop_human_parking_meter@female@base',
        anim = 'base_female',
        flags = 49,
        prop = 'v_ret_ml_cigs3',
        bone = 57005,
        pos = vec3(0.14, 0.01, -0.03),
        rot = vec3(2.0, 68.0, -32.0),
        stress = 0,
        armour = 0,
        damageHealth = 0,
    },
    ["sixtyninepack"] = {
        label = 'Opening sixty nine pack',
        duration = 10,
        requiredItem = nil,
        requiredLabel = '',
        returnItem = true,
        returned = 'cigs',
        amountReturned = 20,
        dict = 'amb@prop_human_parking_meter@female@base',
        anim = 'base_female',
        flags = 49,
        prop = 'p_cigar_pack_02_s',
        bone = 57005,
        pos = vec3(0.14, 0.01, -0.03),
        rot = vec3(2.0, 68.0, -32.0),
        stress = 0,
        armour = 0,
        damageHealth = 0,
    },
    ["yukonpack"] = {
        label = 'Opening yukon pack',
        duration = 10,
        requiredItem = nil,
        requiredLabel = '',
        returnItem = true,
        returned = 'cigs',
        amountReturned = 20,
        dict = 'amb@prop_human_parking_meter@female@base',
        anim = 'base_female',
        flags = 49,
        prop = 'p_cigar_pack_02_s',
        bone = 57005,
        pos = vec3(0.14, 0.01, -0.03),
        rot = vec3(2.0, 68.0, -32.0),
        stress = 0,
        armour = 0,
        damageHealth = 0,
    },
    ["cigs"] = {
        label = 'Smoking cigarette',
        duration = 20,
        requiredItem = 'lighter',
        requiredLabel = 'Lighter',
        returnItem = false,
        returned = nil,
        amountReturned = 0,
        dict = 'amb@world_human_aa_smoke@male@idle_a',
        anim = 'idle_c',
        flags = 49,
        prop = 'prop_cs_ciggy_01',
        bone = 28422,
        pos = vec3(0.0, 0.0, 0.0),
        rot = vec3(0.0, 0.0, 0.0),
        stress = 25,
        armour = 10,
        damageHealth = 5,
    },
    ["vape"] = {
        label = 'Smoking vape',
        duration = 20,
        requiredItem = 'vapejuice',
        requiredLabel = 'Vape Juice',
        returnItem = false,
        returned = nil,
        amountReturned = 0,
        dict = 'amb@world_human_smoking@male@male_b@base',
        anim = 'base',
        flags = 49,
        prop = 'ba_prop_battle_vape_01',
        bone = 28422,
        pos = vec3(-0.029, 0.007, -0.005),
        rot = vec3(91.0, 270.0, -360.0),
        stress = 25,
        armour = 10,
        damageHealth = 0,
    },
}




Config.Language = {
    Notifications = {
        Busy = 'You are already doing something!',
        Cancelled = 'Action cancelled!',
    },
}
