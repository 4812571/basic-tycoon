local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Packages = ReplicatedStorage:WaitForChild("Packages")

local Component = require(Packages.Component)
local Signal = require(Packages.Signal)
local Trove = require(Packages.Trove)

local ButtonServer = Component.new({
    Tag = "Button",
    Ancestors = {workspace},
})

function ButtonServer:Construct()
    self._trove = Trove.new()
    self.Pressed = self._trove:Construct(Signal)

    self.Cost = self.Instance:GetAttribute("Cost")
    self.Unlocks = self.Instance:GetAttribute("Unlocks")
end

function ButtonServer:Start()
    self._trove:Connect(self.Instance.TouchPart.Touched, function(part)
        local humanoid = part.Parent:FindFirstChildWhichIsA("Humanoid")

        if not humanoid then
            return
        end

        local player = Players:GetPlayerFromCharacter(humanoid.Parent)

        if not player then
            return
        end

        self.Pressed:Fire(player)
    end)
end

function ButtonServer:Stop()
    self._trove:Clean()
end

return ButtonServer