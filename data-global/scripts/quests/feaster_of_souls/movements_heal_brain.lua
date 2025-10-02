local badThoughtProximity = MoveEvent()

function badThoughtProximity.onStepIn(creature, item, position, fromPosition)
	if creature:getName():lower() == "bad thought" and item:getId() == 12355 then
		local centralPosition = Position(31954, 32325, 10)
		local radius = 1
		local isInRadius = math.abs(position.x - centralPosition.x) <= radius and math.abs(position.y - centralPosition.y) <= radius and position.z == centralPosition.z

		if isInRadius then
			local searchRadius = 5
			local spectors = Game.getSpectators(position, false, false, searchRadius, searchRadius, searchRadius, searchRadius)
			for _, espectador in ipairs(spectors) do
				if espectador:isMonster() and espectador:getName():lower() == "brain head" then
					espectador:addHealth(1000)
					espectador:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
				end
			end
		end
	end
	return true
end

badThoughtProximity:type("stepin")
badThoughtProximity:id(12355)
badThoughtProximity:register()
