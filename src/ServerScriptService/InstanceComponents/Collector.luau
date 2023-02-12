local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage:WaitForChild("Packages")

local Component = require(Packages.Component)
local Signal = require(Packages.Signal)
local Trove = require(Packages.Trove)

local CollectorServer = Component.new({
    Tag = "Collector",
    Ancestors = {workspace},
})

function CollectorServer:Construct()
    self._trove = Trove.new()
    self.Collected = self._trove:Construct(Signal)
end

function CollectorServer:HeartbeatUpdate()
    local collectionSize = self.Instance.CollectZone.Size
    local collectionCFrame = self.Instance.CollectZone.CFrame

    local parts = workspace:GetPartBoundsInBox(collectionCFrame, collectionSize)
    
    local amountCollected = 0

    for _, part in parts do
        if part:GetAttribute("Value") then
            amountCollected += part:GetAttribute("Value")
            part:Destroy()
        end
    end

    if amountCollected > 0 then
        self.Collected:Fire(amountCollected)
    end
end

function CollectorServer:Stop()
    self._trove:Clean()
end

return CollectorServer