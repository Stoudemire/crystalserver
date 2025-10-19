local config = {
	boss = {
		name = "The Pale Worm",
		position = Position(33805, 31504, 14),
	},
	requiredLevel = 250,
	timeToDefeat = 25 * 60,
	playerPositions = {
		{ pos = Position(33772, 31504, 14), teleport = Position(33808, 31513, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(33773, 31504, 14), teleport = Position(33808, 31513, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(33774, 31504, 14), teleport = Position(33808, 31513, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(33775, 31504, 14), teleport = Position(33808, 31513, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(33773, 31503, 14), teleport = Position(33808, 31513, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(33774, 31503, 14), teleport = Position(33808, 31513, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(33775, 31503, 14), teleport = Position(33808, 31513, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(33773, 31505, 14), teleport = Position(33808, 31513, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(33774, 31505, 14), teleport = Position(33808, 31513, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(33775, 31505, 14), teleport = Position(33808, 31513, 14), effect = CONST_ME_TELEPORT },
	},
	monsters = {
		{ name = "A Weak Spot", pos = Position(33805, 31505, 15) },
		{ name = "A Stone", pos = Position(33808, 31499, 14) },
	},
	specPos = {
		from = Position(33793, 31496, 14),
		to = Position(33819, 31518, 14),
	},
	exit = Position(33572, 31451, 10),
}

local lever = BossLever(config)
lever:position({ x = 33771, y = 31504, z = 14 })
lever:register()
