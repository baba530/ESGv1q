local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

local Window = OrionLib:MakeWindow({
    Name = "COPİLOT HUB | Reborn by Esg 💀",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "CopilotHub"
})local FarmTab = Window:MakeTab({Name = "Farm", Icon = "rbxassetid://4483345998", PremiumOnly = false})
local PvPTab = Window:MakeTab({Name = "PvP", Icon = "rbxassetid://4483345998", PremiumOnly = false})
local FruitTab = Window:MakeTab({Name = "Fruit", Icon = "rbxassetid://4483345998", PremiumOnly = false})
local MiscTab = Window:MakeTab({Name = "Misc", Icon = "rbxassetid://4483345998", PremiumOnly = false})FarmTab:AddButton({
    Name = "Auto Farm Level",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EsgCopilot/scripts/main/autofarmlevel.lua"))()
    end
})

FarmTab:AddButton({
    Name = "Auto Farm Boss",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EsgCopilot/scripts/main/autofarmboss.lua"))()
    end
})FruitTab:AddButton({
    Name = "Fruit Sniper",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EsgCopilot/scripts/main/fruitsniper.lua"))()
    end
})

FruitTab:AddButton({
    Name = "Fruit ESP",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EsgCopilot/scripts/main/fruitesptracker.lua"))()
    end
})PvPTab:AddButton({
    Name = "Camlock + Skill Spam",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EsgCopilot/scripts/main/pvpcombo.lua"))()
    end
})

PvPTab:AddButton({
    Name = "Anti Stun",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EsgCopilot/scripts/main/antistun.lua"))()
    end
})MiscTab:AddButton({
    Name = "FPS Boost",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EsgCopilot/scripts/main/fpsboost.lua"))()
    end
})

MiscTab:AddButton({
    Name = "Anti-AFK",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EsgCopilot/scripts/main/antiafk.lua"))()
    end
})OrionLib:Init()
