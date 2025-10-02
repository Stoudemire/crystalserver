local teleportPlayersEvent = CreatureEvent("TeleportPlayersOnSymbolOfFearDeath")

function teleportPlayersEvent.onDeath(creature, corpse, killer, mostDamageKiller, unjustified, mostDamageUnjustified)
	local creatureName = creature:getName():lower()

	if creatureName == "symbol of fear" then
		local teleportPosition = Position(33711, 31474, 14)
		local spectators = Game.getSpectators(creature:getPosition(), false, false, 10, 10, 10, 10)

		for _, spectator in ipairs(spectators) do
			if spectator:isPlayer() then
				spectator:teleportTo(teleportPosition)
				teleportPosition:sendMagicEffect(CONST_ME_TELEPORT)
			end
		end
	end

	return true
end

teleportPlayersEvent:register()
