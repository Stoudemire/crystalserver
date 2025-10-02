local teleportOnStep = MoveEvent()

function teleportOnStep.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if item:getActionId() == 33011 then
		local destination = Position(33768, 31504, 13)
		player:teleportTo(destination)
		fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
		destination:sendMagicEffect(CONST_ME_TELEPORT)
	end
	return true
end

teleportOnStep:type("stepin")
teleportOnStep:aid(33011)
teleportOnStep:register()
