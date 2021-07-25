--!nocheck
local TweenService = game:GetService("TweenService")

export type BetterTweenClass = {
	-- properties
	Instance: Instance,
	Tween: Tween,
	Playing: boolean,
	Completed: RBXScriptSignal,

	-- methods/functions
	new: (instance: Instance) -> BetterTweenClass,
	SetTarget: (targetValues: any, tweenInfo: TweenInfo) -> (),
	Play: () -> (),
	Stop: () -> (),
}

local BetterTween = {}
BetterTween.__index = BetterTween

-- constructor
function BetterTween.new(instance: Instance): BetterTweenClass
	-- checks
	assert(instance, "Missing argument #1 to betterTween.new;")
	assert(
		typeof(instance) == "Instance",
		("Bad argument #1 to betterTween.new; Expected 'Instance', got '%s';"):format(typeof(instance))
	)

	local self: BetterTweenClass = {
		Instance = instance,
		Tween = nil,
		Playing = false,

		Completed = nil,
	}
	setmetatable(self, BetterTween)
	return self
end

function BetterTween:SetTarget(targetValues: any, tweenInfo: TweenInfo)
	if self.Tween then
		self:Stop()
	end

	local newTween = TweenService:Create(self.Instance, tweenInfo, targetValues)
	self.Tween = newTween

	self.Completed = self.Tween.Completed

	if self.Playing then
		self.Tween:Play()
	end
end

function BetterTween:Play()
	if not self.Playing then
		self.Playing = true
		if self.Tween then
			self.Tween:Play()
		end
	end
end

function BetterTween:Stop()
	self.Playing = false
	self.Tween:Cancel()
	-- self.Tween = nil
end

return BetterTween
