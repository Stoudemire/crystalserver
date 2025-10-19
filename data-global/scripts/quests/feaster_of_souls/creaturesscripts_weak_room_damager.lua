local goshnarsSpiteDamageEvent = CreatureEvent("WeakSpotDamage")
local storageValue = 65100
local resetTime = 1800
local radius = 30

local function applyStorageToPlayers(position)
	local players = Game.getSpectators(position, false, true, radius, radius, radius, radius)
	for _, player in ipairs(players) do
		if player:isPlayer() then
			player:setStorageValue(storageValue, 1)

			-- Reset the storage value after the specified time
			addEvent(function()
				player:setStorageValue(storageValue, -1)
			end, resetTime * 1000)
		end
	end
end

function goshnarsSpiteDamageEvent.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
	if creature and creature:isMonster() and creature:getName():lower() == "a weak spot" then
		if attacker and attacker:isPlayer() then
			applyStorageToPlayers(creature:getPosition())
		end
	end
	return primaryDamage, primaryType, secondaryDamage, secondaryType
end

goshnarsSpiteDamageEvent:register()
