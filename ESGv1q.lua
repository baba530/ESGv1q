local gui = Instance.new("ScreenGui")
gui.Name = "EsgModV6"
gui.ResetOnSpawn = false
gui.Parent = game.CoreGui

local player = game.Players.LocalPlayer
local cam = workspace.CurrentCamera

-- Açma Tuşu (küçük)
local openBtn = Instance.new("TextButton")
openBtn.Parent = gui
openBtn.Text = "V1"
openBtn.Size = UDim2.new(0, 50, 0, 50)
openBtn.Position = UDim2.new(0.02, 0, 0.85, 0)
openBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
openBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
openBtn.Font = Enum.Font.SourceSansBold
openBtn.TextScaled = true
openBtn.Draggable = true

-- Ana Menü (scrollable + sürüklenebilir)
local mainFrame = Instance.new("Frame")
mainFrame.Parent = gui
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
mainFrame.Size = UDim2.new(0, 360, 0, 400)
mainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.Draggable = true

local corner = Instance.new("UICorner", mainFrame)
corner.CornerRadius = UDim.new(0, 20)

local scroll = Instance.new("ScrollingFrame", mainFrame)
scroll.Size = UDim2.new(1, 0, 1, 0)
scroll.CanvasSize = UDim2.new(0, 0, 2, 0)
scroll.ScrollBarThickness = 6
scroll.BackgroundTransparency = 1
scroll.Active = false
scroll.Draggable = false

-- Menü Açılış
openBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
end)

-- Kapatma Tuşu
local closeBtn = Instance.new("TextButton")
closeBtn.Parent = mainFrame
closeBtn.Text = "❌"
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(0.9, 0, 0, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(50, 0, 0)
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.TextScaled = true
closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
end)local function createButton(text, yPos, callback)
    local btn = Instance.new("TextButton", scroll)
    btn.Text = text
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = UDim2.new(0.05, 0, yPos, 0)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextScaled = true
    btn.MouseButton1Click:Connect(function()
        callback(btn)
    end)
    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0, 10)
    return btn
end

-- Camlock
local camlockOn = false
createButton("🎯 Camlock [Kapalı]", 0.05, function(btn)
    camlockOn = not camlockOn
    btn.Text = camlockOn and "🎯 Camlock [Açık]" or "🎯 Camlock [Kapalı]"
    spawn(function()
        while camlockOn do
            wait(0.1)
            local closest, dist = nil, math.huge
            for _, plr in pairs(game.Players:GetPlayers()) do
                if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                    local d = (plr.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                    if d < dist then
                        dist = d
                        closest = plr
                    end
                end
            end
            if closest then
                cam.CFrame = CFrame.new(cam.CFrame.Position, closest.Character.HumanoidRootPart.Position)
            end
        end
    end)
end)

-- Auto Hit
local autoHitOn = false
createButton("🗡️ Auto Hit [Kapalı]", 0.12, function(btn)
    autoHitOn = not autoHitOn
    btn.Text = autoHitOn and "🗡️ Auto Hit [Açık]" or "🗡️ Auto Hit [Kapalı]"
    spawn(function()
        while autoHitOn do
            wait(0.5)
            for _, enemy in pairs(workspace:FindFirstChild("Enemies"):GetChildren()) do
                if enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") then
                    local dist = (enemy.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                    if dist < 15 then
                        enemy.Humanoid:TakeDamage(50)
                    end
                end
            end
        end
    end)
end)-- Oyuncu ESP
local espOn = false
createButton("👁️ Oyuncu ESP [Kapalı]", 0.19, function(btn)
    espOn = not espOn
    btn.Text = espOn and "👁️ Oyuncu ESP [Açık]" or "👁️ Oyuncu ESP [Kapalı]"
    for _, plr in pairs(game.Players:GetPlayers()) do
        if plr ~= player and plr.Character and plr.Character:FindFirstChild("Head") then
            if espOn then
                local billboard = Instance.new("BillboardGui", plr.Character)
                billboard.Name = "EsgESP"
                billboard.Size = UDim2.new(0, 200, 0, 50)
                billboard.Adornee = plr.Character.Head
                billboard.AlwaysOnTop = true

                local nameLabel = Instance.new("TextLabel", billboard)
                nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
                nameLabel.Text = plr.Name
                nameLabel.TextColor3 = Color3.new(1, 1, 1)
                nameLabel.BackgroundTransparency = 1
                nameLabel.Font = Enum.Font.SourceSansBold
                nameLabel.TextScaled = true

                local healthBar = Instance.new("Frame", billboard)
                healthBar.Size = UDim2.new(1, 0, 0.5, 0)
                healthBar.Position = UDim2.new(0, 0, 0.5, 0)
                healthBar.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                healthBar.BorderSizePixel = 0

                spawn(function()
                    while espOn and plr.Character and plr.Character:FindFirstChild("Humanoid") do
                        local hp = plr.Character.Humanoid.Health / plr.Character.Humanoid.MaxHealth
                        healthBar.Size = UDim2.new(hp, 0, 0.5, 0)
                        wait(0.2)
                    end
                end)
            else
                if plr.Character:FindFirstChild("EsgESP") then
                    plr.Character.EsgESP:Destroy()
                end
            end
        end
    end
end)

-- Fruit ESP
local fruitESPOn = false
createButton("🍍 Fruit ESP [Kapalı]", 0.26, function(btn)
    fruitESPOn = not fruitESPOn
    btn.Text = fruitESPOn and "🍍 Fruit ESP [Açık]" or "🍍 Fruit ESP [Kapalı]"
    for _, fruit in pairs(workspace:GetDescendants()) do
        if fruit:IsA("Tool") and fruit.Parent == workspace then
            if fruitESPOn then
                local tag = Instance.new("BillboardGui", fruit)
                tag.Name = "FruitTag"
                tag.Size = UDim2.new(0, 100, 0, 40)
                tag.Adornee = fruit:FindFirstChild("Handle") or fruit
                tag.AlwaysOnTop = true

                local label = Instance.new("TextLabel", tag)
                label.Size = UDim2.new(1, 0, 1, 0)
                label.Text = fruit.Name
                label.TextColor3 = Color3.new(1, 1, 0)
                label.BackgroundTransparency = 1
                label.Font = Enum.Font.SourceSansBold
                label.TextScaled = true
            else
                if fruit:FindFirstChild("FruitTag") then
                    fruit.FruitTag:Destroy()
                end
            end
        end
    end
end)

-- Anti Stun
local antiStunOn = false
createButton("🛡️ Anti Stun [Kapalı]", 0.33, function(btn)
    antiStunOn = not antiStunOn
    btn.Text = antiStunOn and "🛡️ Anti Stun [Açık]" or "🛡️ Anti Stun [Kapalı]"
    spawn(function()
        while antiStunOn do
            wait(0.5)
            local hum = player.Character and player.Character:FindFirstChild("Humanoid")
            if hum then
                hum.PlatformStand = false
                hum.Sit = false
            end
        end
    end)
end)

-- Skill Spam
local spamOn = false
createButton("🔁 Skill Spam [Kapalı]", 0.40, function(btn)
    spamOn = not spamOn
    btn.Text = spamOn and "🔁 Skill Spam [Açık]" or "🔁 Skill Spam [Kapalı]"
    spawn(function()
        while spamOn do
            wait(0.3)
            for _, key in pairs({"Z", "X", "C"}) do
                game:GetService("VirtualInputManager"):SendKeyEvent(true, key, false, game)
                wait(0.1)
            end
        end
    end)
end)

-- Speed Sistemi
local speed = 16
createButton("🏃 Hız Artır [16]", 0.47, function(btn)
    speed = speed + 20
    if speed > 300 then speed = 16 end
    btn.Text = "🏃 Hız Artır [" .. speed .. "]"
    player.Character.Humanoid.WalkSpeed = speed
end)

-- Speed Reset
createButton("🔄 Hız Sıfırla", 0.54, function(btn)
    speed = 16
    player.Character.Humanoid.WalkSpeed = speed
    btn.Text = "🔄 Hız Sıfırla [16]"
end)
