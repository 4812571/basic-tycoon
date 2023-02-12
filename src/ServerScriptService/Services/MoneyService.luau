local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Packages = ReplicatedStorage:WaitForChild("Packages")

local Knit = require(Packages.Knit)

local MoneyService = Knit.CreateService({
    Name = "MoneyService",
    Client = {},
})

function MoneyService:CreateLeaderstats(player)
    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player

    local money = Instance.new("IntValue")
    money.Name = "Money"
    money.Value = 0
    money.Parent = leaderstats
end

function MoneyService:AddMoney(amount)
    for _, player in Players:GetPlayers() do
        player.leaderstats.Money.Value += amount
    end
end

function MoneyService:AttemptPurchase(player, cost, callback)
    if player.leaderstats.Money.Value >= cost then
        player.leaderstats.Money.Value -= cost
        callback()
    end
end

function MoneyService:KnitStart()
    for _, player in Players:GetPlayers() do
        self:CreateLeaderstats(player)
    end

    Players.PlayerAdded:Connect(function(player)
        self:CreateLeaderstats(player)
    end)
end

return MoneyService