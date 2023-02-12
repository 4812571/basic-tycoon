local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Packages = ReplicatedStorage:WaitForChild("Packages")

local Knit = require(Packages.Knit)

local ButtonComponent = require(ServerScriptService.Source.InstanceComponents.Button)
local TycoonComponent = require(ServerScriptService.Source.InstanceComponents.Tycoon)

local ButtonService = Knit.CreateService({
    Name = "ButtonService",
    Client = {},
})

local MoneyService = require(script.Parent.MoneyService)

function ButtonService:BindButton(button)
    button.Pressed:Connect(function(player)
        local tycoon = TycoonComponent:FromInstance(button.Instance.Parent.Parent)

        if not tycoon then
            return
        end

        MoneyService:AttemptPurchase(player, button.Cost, function()
            tycoon:Unlock(button.Unlocks)
            button.Instance:Destroy()
        end)
    end)
end

function ButtonService:KnitStart()
    for _, button in ButtonComponent:GetAll() do
        self:BindButton(button)
    end

    ButtonComponent.Started:Connect(function(button)
        self:BindButton(button)
    end)
end

return ButtonService