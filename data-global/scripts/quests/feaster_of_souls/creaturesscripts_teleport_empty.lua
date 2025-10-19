local emptyTeleport = CreatureEvent("emptyTeleport")

local targetPosition = Position(33768, 31504, 13)

function emptyTeleport.onThink(creature)
	if not creature:isMonster() or creature:getName():lower() ~= "emptys" then
		return true
	end

	local chance = math.random(1, 100)
	if chance <= 50 then
		local spectators = Game.getSpectators(creature:getPosition(), false, false, 1, 1, 1, 1)
		for _, spectator in ipairs(spectators) do
			if spectator:isPlayer() then
				spectator:teleportTo(targetPosition)
				targetPosition:sendMagicEffect(CONST_ME_TELEPORT)
			end
		end
	end

	return true
end

emptyTeleport:register()
