local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()

local variables = {
	degree = 0,
	radius = script:GetAttribute("radius") or 10,
	speed = script:GetAttribute("speed") or 0.01,
	sine_force = script:GetAttribute("sine_force") or 5,
}

local MovePart = Instance.new("Part")
MovePart.BrickColor = BrickColor.new("Bright yellow")
MovePart.Material = Enum.Material.Neon
MovePart.Anchored = true
MovePart.Parent = workspace
MovePart.Size = Vector3.new(1, 1, 1)

RunService.RenderStepped:Connect(function()
	if (MovePart.Position - Character:GetPivot().Position).Magnitude >= variables.radius then
		MovePart.Position = move()
	else
		MovePart.Position = rotate()
	end
end)

script.AttributeChanged:Connect(function(attributeName: string)
	variables[attributeName] = script:GetAttribute(attributeName)
end)

function rotate()
	 variables.degree =  variables.degree + 1

	local x = math.cos(math.rad( variables.degree)) * variables.radius
	local y = math.sin(math.rad( variables.degree)) * variables.sine_force
	local z = math.sin(math.rad( variables.degree)) * variables.radius

	return MovePart.Position:Lerp(Vector3.new(x, y, z) + Character:GetPivot().Position, variables.speed)
end

function move()
	return MovePart.Position:Lerp(Character:GetPivot().Position, variables.speed)
end