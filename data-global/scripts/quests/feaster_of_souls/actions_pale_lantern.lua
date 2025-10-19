local itemID = 32591
local resetActionID = 33173
local triggerActionID = 33012
local resetTilePosition = { x = 33769, y = 31504, z = 13 }
local storageKey = 33014
local damageAppliedStorage = 33016
local damageDelay = 5
local allowedArea = {
	from = { x = 33793, y = 31496, z = 14 },
	to = { x = 33819, y = 31518, z = 14 },
}

local function isPlayerInAllowedArea(player)
	local playerPos = player:getPosition()
	if playerPos.x >= allowedArea.from.x and playerPos.x <= allowedArea.to.x and playerPos.y >= allowedArea.from.y and playerPos.y <= allowedArea.to.y and playerPos.z == allowedArea.from.z then
		return true
	end
	return false
end

local function applyDamage(player)
	if player and player:isPlayer() and isPlayerInAllowedArea(player) then
		local maxHealth = player:getMaxHealth()
		local damage = math.ceil(maxHealth / 2)
		player:addHealth(-damage)
		player:getPosition():sendMagicEffect(CONST_ME_MORTAREA)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your health has been reduced to half because you did not use the required item in time.")
		player:setStorageValue(damageAppliedStorage, 1)
	end
end

local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == itemID then
		if isPlayerInAllowedArea(player) then
			player:removeItem(itemID, 1)
			player:setStorageValue(storageKey, 1)
			player:setStorageValue(damageAppliedStorage, 1)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have used the item in time and avoided taking damage.")
			player:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You cannot use this item outside the allowed area.")
		end
	end
	return true
end

local playerEnterRoom = MoveEvent("PlayerEnterRoom")

function playerEnterRoom.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if player then
		if position.x == resetTilePosition.x and position.y == resetTilePosition.y and position.z == resetTilePosition.z and item:getActionId() == resetActionID then
			player:setStorageValue(damageAppliedStorage, -1)

			return true
		end

		if item:getActionId() == triggerActionID and isPlayerInAllowedArea(player) then
			player:setStorageValue(storageKey, -1)

			addEvent(function()
				local player = Player(creature:getId())
				if player then
					local itemUsed = player:getStorageValue(storageKey)
					local damageApplied = player:getStorageValue(damageAppliedStorage)

					if itemUsed == -1 and damageApplied ~= 1 and isPlayerInAllowedArea(player) then
						applyDamage(player)
					end
				end
			end, damageDelay * 1000)
		end
	end
	return true
end

action:id(itemID)
action:register()
playerEnterRoom:aid(resetActionID)
playerEnterRoom:aid(triggerActionID)
playerEnterRoom:register()
