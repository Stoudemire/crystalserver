local redSoulStealerActionId = 33016
local redSoulStealerPositions = { Position(33709, 31507, 14), Position(33715, 31499, 14) }

local blueSoulStealerActionId = 33014
local blueSoulStealerPositions = { Position(33710, 31498, 14), Position(33716, 31508, 14) }

local greenSoulStealerActionId = 33015
local greenSoulStealerPositions = { Position(33707, 31504, 14), Position(33718, 31501, 14) }

local hasSentVulnerabilityMessage = false

local dreadMaidenImmunity = CreatureEvent("DreadMaidenImmunity")

function dreadMaidenImmunity.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
	if creature and creature:isMonster() and creature:getName():lower() == "the dread maiden" then
		if hasSentVulnerabilityMessage then
			return primaryDamage, primaryType, secondaryDamage, secondaryType
		end
		return false
	end
	return primaryDamage, primaryType, secondaryDamage, secondaryType
end

dreadMaidenImmunity:register()

function Monster:setInvulnerable()
	self:registerEvent("DreadMaidenImmunity")
	return true
end

function Monster:removeInvulnerable()
	self:unregisterEvent("DreadMaidenImmunity")
	return true
end

local moveEvent = MoveEvent()

function moveEvent.onStepIn(creature, item, position, fromPosition)
	if not creature:isMonster() then
		return true
	end

	local monsterName = creature:getName():lower()
	local actionId = item:getActionId()

	if monsterName == "the dread maiden" then
		return true
	end

	local validPass = false
	local dreadMaiden = nil

	if
		(monsterName == "red soul stealers" and actionId == redSoulStealerActionId and (position == redSoulStealerPositions[1] or position == redSoulStealerPositions[2]))
		or (monsterName == "blue soul stealers" and actionId == blueSoulStealerActionId and (position == blueSoulStealerPositions[1] or position == blueSoulStealerPositions[2]))
		or (monsterName == "green soul stealers" and actionId == greenSoulStealerActionId and (position == greenSoulStealerPositions[1] or position == greenSoulStealerPositions[2]))
	then
		validPass = true
	end

	if validPass then
		creature:remove()
		position:sendMagicEffect(CONST_ME_MORTAREA)

		local creatures = Game.getSpectators(Position(33713, 31504, 14), false, false, 20, 20, 20, 20)
		for _, c in ipairs(creatures) do
			if c:isMonster() and c:getName():lower() == "the dread maiden" then
				dreadMaiden = c
				break
			end
		end

		if dreadMaiden then
			if math.random(1, 100) <= 6 then
				dreadMaiden:removeInvulnerable()

				if not hasSentVulnerabilityMessage then
					local players = Game.getSpectators(dreadMaiden:getPosition(), false, false, 10, 10, 10, 10)
					for _, player in ipairs(players) do
						if player:isPlayer() then
							player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The Dread Maiden has become vulnerable!")
						end
					end
					hasSentVulnerabilityMessage = true
				end
			end
		end
	else
		local players = Game.getSpectators(position, false, false, 10, 10, 10, 10)
		for _, player in ipairs(players) do
			if player:isPlayer() then
				player:addHealth(-1000)
			end
		end
		position:sendMagicEffect(CONST_ME_ENERGYHIT)
		creature:remove()
	end

	return true
end

moveEvent:type("stepin")
moveEvent:aid(greenSoulStealerActionId, redSoulStealerActionId, blueSoulStealerActionId)
moveEvent:register()

local dreadMaidenResetThink = GlobalEvent("DreadMaidenResetThink")

function dreadMaidenResetThink.onThink(interval)
	local centerPos = Position(33713, 31504, 14)
	local creatures = Game.getSpectators(centerPos, false, false, 30, 30, 30, 30)

	for _, creature in ipairs(creatures) do
		if creature:isMonster() and creature:getName():lower() == "the dread maiden" then
			if creature:getStorageValue(99991) ~= 1 then
				creature:setInvulnerable()
				hasSentVulnerabilityMessage = false
				creature:setStorageValue(99991, 1)
			end
		end
	end
	return true
end

dreadMaidenResetThink:interval(1000)
dreadMaidenResetThink:register()
