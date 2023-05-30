INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES 
('trafi', 'Trafilappu', '5', '0', '1');


-- ox inventory -- 

ox_inventory/data/items.lua

	["trafi"] = {
		label = "Trafilappu",
		weight = 100,
		stack = true,
		close = true,
	},

-- ox inventory --