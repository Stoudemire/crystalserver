local transformEvent = CreatureEvent("TransformOnDeath")

function transformEvent.onDeath(creature, corpse, killer, mostDamageKiller, unjustified, mostDamageUnjustified)
	local position = creature:getPosition()
	local creatureName = creature:getName():lower()

	if creatureName == "phobia" then
		Game.createMonster("Horror", position)
	elseif creatureName == "horror" then
		Game.createMonster("Fear", position)
	elseif creatureName == "fear" then
		Game.createMonster("Phobia", position)
	end
	return true
end

transformEvent:register()
