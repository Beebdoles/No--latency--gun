local tool = script.Parent.Parent
local point = script.Parent:WaitForChild("Part")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local localPlayer = Players.LocalPlayer
local mouse = localPlayer:GetMouse()
local debounce = true
local speed = 200

local event = ReplicatedStorage:WaitForChild("RemoteEvent")

UserInputService.InputBegan:Connect(function(input, e)
	if input.UserInputType == Enum.UserInputType.MouseButton1 and debounce and localPlayer.Character:FindFirstChild("Tool") then
		local bullet = ReplicatedStorage:FindFirstChild("Bullet"):Clone()
		bullet.Position = point.Position
		bullet.Parent = workspace
		
		local hit = mouse.Hit.Position
		if hit == nil then
			hit = mouse.UnitRay.Direction * 5
		end
		
		local distance = (hit - point.Position).Magnitude
		
		local tween = TweenService:Create(bullet, TweenInfo.new(distance/speed, Enum.EasingStyle.Linear), {Position = hit}):Play()
		event:FireServer(point.Position, hit, distance/speed)
		game:GetService("Debris"):AddItem(bullet, distance/speed)
	end
end)