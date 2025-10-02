local teleportWithItemCheck = MoveEvent()

function teleportWithItemCheck.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if item:getActionId() == 33010 then
		local itemCount = player:getItemCount(32703)

		if itemCount >= 2 then
			local destination = Position(33776, 31505, 13)
			player:teleportTo(destination)
			fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
			destination:sendMagicEffect(CONST_ME_TELEPORT)

			player:removeItem(32703, 2)
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need at least 2 death tolls to be teleported.")
		end
	end
	return true
end

teleportWithItemCheck:type("stepin")
teleportWithItemCheck:aid(33010)
teleportWithItemCheck:register()
