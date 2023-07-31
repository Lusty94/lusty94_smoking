

# Lusty94_Smoking

# A Simple smoking script for qb-core that gives the player a health buff / nerf and adds armour [all toggleable]

- Moveable shop location to purchase smoking supplies
- Useable cigarette packets that gives the players a set amount of cigarettes
- Useable vape that requires juice to smoke - gives a health boost and adds armour [config file to edit]
- Useable cigarette that requires a lighter to smoke - removes a small bit of health and adds armour [config file to edit]

- Item checks to prevent exploits and abuse

- Support for multiple scripts


``Notify``

- qb-notify
- okokNotify
- mythic_notify
- boii_ui notify

``Targets``

- qb-target
- ox_target



# Insert files found in [images] to inventory/html/images



# Insert items to core/shared/items.lua [adjust weights to suit your server needs]


```
	['redwoodpack'] 			= {['name'] = 'redwoodpack', 			 	  	  	['label'] = 'Redwood Cigarette Pack', 		['weight'] = 200, 		['type'] = 'item', 					['image'] = 'redwoodpack.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Pack of Cigarettes'},
	['debonairepack'] 			= {['name'] = 'debonairepack', 			 	  	  	['label'] = 'Debonaire Cigarette Pack', 	['weight'] = 200, 		['type'] = 'item', 					['image'] = 'debonairepack.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Pack of Cigarettes'},
	['yukonpack'] 				= {['name'] = 'yukonpack', 			 	  	  	    ['label'] = 'Yukon Cigarette Pack', 		['weight'] = 200, 		['type'] = 'item', 					['image'] = 'yukonpack.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Pack of Cigarettes'},
	['69brandpack'] 			= {['name'] = '69brandpack', 			 	  	  	['label'] = '69 Brand Cigarette Pack', 		['weight'] = 200, 		['type'] = 'item', 					['image'] = '69brandpack.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Pack of Cigarettes'},

	['cigs'] 					= {['name'] = 'cigs', 			 	  	  		    ['label'] = 'Cigarettes', 				    ['weight'] = 200, 		['type'] = 'item', 					['image'] = 'cigs.png', 					['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'A Single Cigarette'},
	['vape'] 					= {['name'] = 'vape', 			 	  	  		    ['label'] = 'Electronic Vape', 				['weight'] = 200, 		['type'] = 'item', 					['image'] = 'vape.png', 					['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'An Electronic Vape'},
	['vapejuice'] 				= {['name'] = 'vapejuice', 			 	  	  		['label'] = 'Vape Juice', 				    ['weight'] = 200, 		['type'] = 'item', 					['image'] = 'vapejuice.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Vape Juice'},
```
