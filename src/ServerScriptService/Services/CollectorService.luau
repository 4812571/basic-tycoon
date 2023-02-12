local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage:WaitForChild("Packages")

local Knit = require(Packages.Knit)

local CollectorComponent = require(ServerScriptService.Source.InstanceComponents.Collector)

local MoneyService = nil

local CollectorService = Knit.CreateService({
    Name = "CollectorService",
    Client = {},
})

function CollectorService:KnitInit()
    MoneyService = Knit.GetService("MoneyService")
end

function CollectorService:BindCollector(collector)
    collector.Collected:Connect(function(amount)
        MoneyService:AddMoney(amount)
    end)
end

function CollectorService:KnitStart()
    for _, collector in CollectorComponent:GetAll() do
        self:BindCollector(collector)
    end

    CollectorComponent.Started:Connect(function(collector)
        self:BindCollector(collector)
    end)
end

return CollectorService