local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage:WaitForChild("Packages")

local Component = require(Packages.Component)
local Trove = require(Packages.Trove)

local TycoonServer = Component.new({
    Tag = "Tycoon",
    Ancestors = {workspace},
})

function TycoonServer:Construct()
    self._trove = Trove.new()
    self.UnloadedTycoonAssets = self._trove:Construct(Instance, "Folder")
end

function TycoonServer:Start()
    for _, asset in self.Instance.Assets:GetChildren() do
        asset.Parent = self.UnloadedTycoonAssets
    end

    for _, asset in self.Instance.StarterAssets:GetChildren() do
        asset.Parent = self.Instance.Assets
    end

    self.Instance.StarterAssets:Destroy()
    self.UnloadedTycoonAssets.Parent = ServerStorage
end

function TycoonServer:Unlock(name)
    local asset = self.UnloadedTycoonAssets:FindFirstChild(name)

    if asset then
        asset.Parent = self.Instance.Assets
    end
end

function TycoonServer:Stop()
    self._trove:Clean()
end

return TycoonServer