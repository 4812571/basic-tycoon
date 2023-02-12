local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage:WaitForChild("Packages")

local Component = require(Packages.Component)

local ConveyorServer = Component.new({
    Tag = "Conveyor",
    Ancestors = {workspace},
})

function ConveyorServer:Construct()
    self.Speed = self.Instance:GetAttribute("Speed")
end

function ConveyorServer:Start()
    self.Instance.AssemblyLinearVelocity = self.Instance.CFrame.LookVector * self.Speed
end

return ConveyorServer