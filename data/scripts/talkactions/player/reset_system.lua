local resetInfoTalkAction = TalkAction("!resetinfo")

function resetInfoTalkAction.onSay(player, words, param)
	if not player:isResetSystemEnabled() then
		player:sendTextMessage(MESSAGE_FAILURE, "Reset system is disabled.")
		return true
	end

	local resetCount = player:getResetCount()
	local damageBonus = player:getResetDamageBonus()
	local defenseBonus = player:getResetDefenseBonus()
	local requiredLevel = configManager.getNumber(configKeys.RESET_REQUIRED_LEVEL)
	local resetMaxResets = configManager.getNumber(configKeys.RESET_MAX_RESETS)
	local resetBackToLevel = configManager.getNumber(configKeys.RESET_BACK_TO_LEVEL)

	player:sendTextMessage(MESSAGE_STATUS, "=== Reset System Info ===")
	player:sendTextMessage(MESSAGE_STATUS, "Required level: " .. requiredLevel)
	player:sendTextMessage(MESSAGE_STATUS, "Reset back to level: " .. resetBackToLevel)
	if resetMaxResets == 0 then
		player:sendTextMessage(MESSAGE_STATUS, "Maximun resets: Unlimited")
	else
		player:sendTextMessage(MESSAGE_STATUS, "Maximun resets: " .. resetMaxResets)
	end
	player:sendTextMessage(MESSAGE_STATUS, "Your resets: " .. resetCount)
	player:sendTextMessage(MESSAGE_STATUS, "Damage bonus: " .. damageBonus .. "%")
	player:sendTextMessage(MESSAGE_STATUS, "Defense bonus: " .. defenseBonus .. "%")
	return true
end

resetInfoTalkAction:groupType("normal")
resetInfoTalkAction:register()
