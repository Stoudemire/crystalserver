local hungerWormDeath = CreatureEvent("HungerWormDeath")

function hungerWormDeath.onDeath(creature, corpse, killer, mostDamageKiller, lastHitUnjustified)
	if creature:getName():lower() == "hunger worm" then
		local deathPosition = creature:getPosition()
		local tile = Tile(deathPosition)

		if tile then
			local itemsToRemove = { 2890, 2889, 2891 }
			for _, itemId in ipairs(itemsToRemove) do
				local item = tile:getItemById(itemId)
				if item then
					item:remove()
				end
			end

			local createdItem = Game.createItem(394, 1, deathPosition)
			if createdItem then
				createdItem:setActionId(33050)

				addEvent(function()
					local item = Tile(deathPosition):getItemById(394)
					if item then
						item:remove()

						Game.createItem(351, 1, deathPosition)
					end
				end, 20000)
			end
		end
	end
	return true
end

hungerWormDeath:register()
