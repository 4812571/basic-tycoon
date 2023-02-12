local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage:WaitForChild("Packages")

local Component = require(Packages.Component)

local DropperServer = Component.new({
    Tag = "Dropper",
    Ancestors = {workspace},
})

function DropperServer:Construct()
    self.TimePassed = 0
    self.TimeToDrop = self.Instance:GetAttribute("TimeToDrop")
    self.DropValue = self.Instance:GetAttribute("DropValue")
end

function DropperServer:DropPart()
    local part = Instance.new("Part")
    part.Size = Vector3.new(0.75, 0.75, 0.75)
    part.Material = Enum.Material.SmoothPlastic
    part:SetAttribute("Value", self.DropValue)
    part.Position = self.Instance.DropZone.Position
    part.Parent = workspace
end

function DropperServer:HeartbeatUpdate(deltaTime)
    self.TimePassed += deltaTime

    while self.TimePassed >= self.TimeToDrop do
        self.TimePassed -= self.TimeToDrop
        self:DropPart()
    end
end

return DropperServer