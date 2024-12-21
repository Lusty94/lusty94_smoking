## Lusty94_Smoking







## Script Support

- Script support is via Discord for PAID resources ONLY: https://discord.gg/BJGFrThmA8



# Installation

- Make sure to download all dependencies and ensure they start BEFORE this script
- Add items below to your items.lua
- Add all images inside [images] folder to your inventory/images folder




# QB_CORE ITEMS

```

    --smoking
    redwoodpack 			= {name = 'redwoodpack', 			 	  	  	label = 'Redwood Cigarette Pack', 		weight = 200, 		type = 'item', 					image = 'redwoodpack.png', 				unique = false, 	useable = true, 	shouldClose = true,   combinable = nil,   description = 'Pack of Cigarettes'},
	debonairepack 			= {name = 'debonairepack', 			 	  	  	label = 'Debonaire Cigarette Pack', 	weight = 200, 		type = 'item', 					image = 'debonairepack.png', 			unique = false, 	useable = true, 	shouldClose = true,   combinable = nil,   description = 'Pack of Cigarettes'},
	yukonpack 				= {name = 'yukonpack', 			 	  	  	    label = 'Yukon Cigarette Pack', 		weight = 200, 		type = 'item', 					image = 'yukonpack.png', 				unique = false, 	useable = true, 	shouldClose = true,   combinable = nil,   description = 'Pack of Cigarettes'},
	sixtyninepack 			= {name = 'sixtyninepack', 			 	  	  	label = '69 Brand Cigarette Pack', 		weight = 200, 		type = 'item', 					image = 'sixtyninepack.png', 			unique = false, 	useable = true, 	shouldClose = true,   combinable = nil,   description = 'Pack of Cigarettes'},

	cigs 					= {name = 'cigs', 			 	  	  		    label = 'Cigarette', 				    weight = 200, 		type = 'item', 					image = 'cigs.png', 					unique = false, 	useable = true, 	shouldClose = true,   combinable = nil,   description = 'A Single Cigarette'},
	vape 					= {name = 'vape', 			 	  	  		    label = 'Electronic Vape', 				weight = 200, 		type = 'item', 					image = 'vape.png', 					unique = false, 	useable = true, 	shouldClose = true,   combinable = nil,   description = 'An Electronic Vape'},
	vapejuice 				= {name = 'vapejuice', 			 	  	  		label = 'Vape Juice', 				    weight = 200, 		type = 'item', 					image = 'vapejuice.png', 				unique = false, 	useable = true, 	shouldClose = true,   combinable = nil,   description = 'Vape Juice'},

```

## OX_INVENTORY ITEMS

```

    ["redwoodpack"] = {
		label = "Redwood Cigarette Pack",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "redwoodpack.png",
		}
	},

    ["debonairepack"] = {
		label = "Debonaire Cigarette Pack",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "debonairepack.png",
		}
	},

    ["yukonpack"] = {
		label = "Yukon Cigarette Pack",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "yukonpack.png",
		}
	},

    ["sixtyninepack"] = {
		label = "Sixty Nine Cigarette Pack",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "sixtyninepack.png",
		}
	},

    ["cigs"] = {
		label = "Cigarette",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "cigs.png",
		}
	},

    ["vape"] = {
		label = "Electronic Vape",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "vape.png",
		}
	},

    ["vapejuice"] = {
		label = "Vape Juice",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "vapejuice.png",
		}
	},

```