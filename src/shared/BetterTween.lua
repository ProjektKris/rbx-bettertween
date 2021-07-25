local TweenService = game:GetService("TweenService")

type Array<T> = {[number]: T}
export type TweenController = {
	Instance: Instance,
	Tween: Tween,

	Completed: any,

	_Connections: Array<RBXScriptConnection>,
}

local BetterTween = {}
BetterTween.__index = BetterTween

-- constructor
function BetterTween.new(instance: Instance)
	-- checks
	assert(instance, "Missing argument #1 to betterTween.new;")
	assert(
		typeof(instance) == "Instance", 
		("Bad argument #1 to betterTween.new; Expected 'Instance', got '%s';"):format(typeof(instance))
	)

	local self = {
		Instance = instance,
		Tween = nil,
		Playing = false,
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
	self.Tween:Cancel()
	self.Tween = nil
end

return BetterTween