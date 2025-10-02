local fearFeasterTeleport = CreatureEvent("FearFeasterTeleport")

local targetPosition = Position(33777, 31471, 14)
local roomFromPosition = Position(33703, 31461, 14)
local roomToPosition = Position(33720, 31479, 14)

local teleportHealthPercentages = { 90, 70, 55, 35, 15, 5 }

local usedTeleportPercentages = {}

function fearFeasterTeleport.onThink(creature)
	if not creature:isMonster() or creature:getName():lower() ~= "the fear feaster" then
		return true
	end

	local creatureId = creature:getId()
	local healthPercentage = math.floor((creature:getHealth() / creature:getMaxHealth()) * 100)

	if not usedTeleportPercentages[creatureId] then
		usedTeleportPercentages[creatureId] = {}
	end

	for _, percentage in ipairs(teleportHealthPercentages) do
		if healthPercentage <= percentage and not usedTeleportPercentages[creatureId][percentage] then
			usedTeleportPercentages[creatureId][percentage] = true

			local spectators = Game.getSpectators(creature:getPosition(), false, false, 15, 15, 15, 15)
			for _, spectator in ipairs(spectators) do
				if spectator:isPlayer() then
					local pos = spectator:getPosition()
					if pos.x >= roomFromPosition.x and pos.x <= roomToPosition.x and pos.y >= roomFromPosition.y and pos.y <= roomToPosition.y and pos.z == roomFromPosition.z then
						spectator:teleportTo(targetPosition)
						targetPosition:sendMagicEffect(CONST_ME_TELEPORT)
					end
				end
			end
			break
		end
	end

	return true
end

fearFeasterTeleport:register()
