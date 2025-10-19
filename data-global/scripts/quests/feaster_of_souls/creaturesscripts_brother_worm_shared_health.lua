local sharedDamage = CreatureEvent("SharedDamage")

function sharedDamage.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
	local totalDamage = math.abs(primaryDamage) + math.abs(secondaryDamage)

	if creature:getName():lower() == "brother worm" and totalDamage > 0 then
		local paleWorm = nil
		local creaturePosition = creature:getPosition()

		for z = 0, 15 do
			local spectators = Game.getSpectators({ x = creaturePosition.x, y = creaturePosition.y, z = z }, false, false, 20, 20, 20, 20)
			for _, spectator in ipairs(spectators) do
				if spectator:isMonster() and spectator:getName():lower() == "the unwelcome" then
					paleWorm = spectator
					break
				end
			end
			if paleWorm then
				break
			end
		end

		if paleWorm then
			local newHealth = creature:getHealth() - (totalDamage * 0.99)

			local brotherWillDie = false
			if newHealth <= 0 then
				newHealth = 1 -- Prevent Brother Worm from dying
				brotherWillDie = true
			end

			paleWorm:setHealth(newHealth)

			if brotherWillDie then
				addEvent(function()
					if paleWorm and paleWorm:isMonster() then
						-- Kill the Pale Worm
						paleWorm:addHealth(-10000)

						local creaturePosition = paleWorm:getPosition()
						local sameFloorSpectators = Game.getSpectators({ x = creaturePosition.x, y = creaturePosition.y, z = creaturePosition.z }, false, false, 20, 20, 20, 20)
						for _, spectator in ipairs(sameFloorSpectators) do
							if spectator:isMonster() and spectator:getName():lower() ~= "the unwelcome" and spectator:getName():lower() ~= "brother worm" then
								spectator:remove()
							end
						end
					end
				end, 100)
			end
		end
	end

	return primaryDamage, primaryType, secondaryDamage, secondaryType
end

sharedDamage:register()
