print("Hello world, from server!")

-- services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SHARED = ReplicatedStorage.Common

local BetterTween = require(SHARED.BetterTween)

local newPart = Instance.new("Part")
newPart.Anchored = true
newPart.Position = Vector3.new(0, 2, 0)
newPart.Size = Vector3.new(1, 1, 1)
newPart.Parent = workspace

local newTween = BetterTween.new(newPart)

wait(5)
print("start")
newTween:Play()

while true do
	newTween:SetTarget(
		{Size = Vector3.new(10, 10, 10)},
		TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.In)
	)
    -- newTween.Completed:Wait()
    wait(2)
	newTween:SetTarget(
        {Size = Vector3.new(1, 1, 1)},
        TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.In)
    )
    newTween.Completed:Wait()
end
