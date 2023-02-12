local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Packages = ReplicatedStorage:WaitForChild("Packages")

local Knit = require(Packages.Knit)

Knit.AddServices(ServerScriptService.Source.Services)
Knit.Start():await()

for _, instanceComponentModule in ServerScriptService.Source.InstanceComponents:GetChildren() do
    require(instanceComponentModule)
end