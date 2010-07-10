local addon, ns = ...

ns.config = {

	core = {
		classif = {
			["worldboss"] = "Boss",
			["rareelite"] = "+ Rare",
			["rare"] = "Rare",
			["elite"] = "+",
		},

		flagOff = "(Off)",
		flagPvP = "(PvP)",

		colorFriendly = "ff00ff00",
		colorHostile = "ffff0000",
	},

	anchor = {
		mouse = {
			enabled = true,
			anchor = "TOPLEFT",
			offsetX = 25,
			offsetY = -25,
		},

		fixed = { "BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -13, 34 },
	},

	raidIcon = {
		width = 18,
		height = 18,
		point = { "TOP", "GameTooltip", "TOP", 0, 5 },
	},

	colors = {
		backdrop = {
			bgFile = [[Interface\Tooltips\UI-Tooltip-Background]],
			edgeFile = [[Interface\AddOns\ProTip\media\border]],
			tile = false, tileSize = 8,
			edgeSize = 16,
			insets = { left = 3, right = 3, top = 3, bottom = 3 },
		},

		border = { r = 0.2, g = 0.2, b = 0.2 },
	},

	healthbar = {
		texture = [[Interface\AddOns\ProTip\media\statusbar]],
		color = { 0.3, 0.9, 0.3, 1 },
		height = 2,
		bgColor = { 0.4, 0.4, 0.4, 0.4 },
	},

	talents = {
		primary = "|cffddff55<|r",
		secondary = "|cffdddd55<<|r",
		
		colorMain = "ffffcc22",
		colorTalent = "ff00ddbb",
	},

	targetline = true,
	disablefade = true,
}
