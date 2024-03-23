local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local cosmeticBullet = ReplicatedStorage:WaitForChild("cosmetic")


cosmeticBullet.OnClientEvent:Connect(function(origin, final, duration, player)
	if game:GetService("Players").LocalPlayer ~= player then
		local bullet = ReplicatedStorage:FindFirstChild("Bullet"):Clone()
		bullet.Position = origin
		bullet.Parent = workspace

		local tween = TweenService:Create(bullet, TweenInfo.new(duration, Enum.EasingStyle.Linear), {Position = final}):Play()
		game:GetService("Debris"):AddItem(bullet, duration)
	end
end)