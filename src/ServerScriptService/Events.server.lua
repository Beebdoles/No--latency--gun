local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local event = ReplicatedStorage:WaitForChild("RemoteEvent")
local cosmetic = ReplicatedStorage:WaitForChild("cosmetic")

local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = {script.Parent.Parent}
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.IgnoreWater = true
raycastParams.CollisionGroup = "Default"

event.OnServerEvent:Connect(function(player, origin, final, duration)
	local playerTable = game:GetService("Players"):GetPlayers()
	for i = 1, #playerTable do
		if playerTable[i] ~= player then
			cosmetic:FireClient(playerTable[i], origin, final, duration, player)
		end
	end
	
	local bullet = ReplicatedStorage:FindFirstChild("Bullet"):Clone()
	bullet.Position = origin
	bullet.Parent = workspace
	bullet.Color = Color3.new(1, 0, 0.0156863)
	bullet.CanTouch = true
	bullet.Transparency = 1

	local hit = final

	local tween = TweenService:Create(bullet, TweenInfo.new(duration, Enum.EasingStyle.Linear), {Position = hit}):Play()
	task.wait(duration)
	game:GetService("Debris"):AddItem(bullet, duration)
end)