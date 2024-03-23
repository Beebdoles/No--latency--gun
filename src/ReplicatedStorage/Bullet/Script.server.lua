local part = script.Parent


local getFinalParent = function(part)
	local condition = true
	while(condition) do
		if part ~= workspace and part.Parent ~= workspace then
			part = part.Parent
		else
			condition = false
		end
	end
	return part
end

part.Touched:Connect(function(otherpart)
	local Humanoid = getFinalParent(otherpart):FindFirstChild("Humanoid")
	
	if Humanoid then
		Humanoid:TakeDamage(10)
	end
end)