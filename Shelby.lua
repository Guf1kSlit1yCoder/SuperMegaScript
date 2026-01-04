local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local CurrentTheme = Color3.fromRGB(160, 130, 255)
local CurrentFont = Enum.Font.GothamBold
local AnimStyle = Enum.EasingStyle.Back 
local AnimSpeed = 0.5

-- Конфиг Shelby
_G.ShelbyConfig = {
    Aimbot = false, AimSens = 0.15, FovRadius = 150,
    EspSkeletons = false, EspHealth = false, EspNames = false,
    Speed = false, WalkSpeed = 100
}

-- Очистка
for _, v in pairs(game.CoreGui:GetChildren()) do
    if v.Name == "Shelby_Pro_Custom" then v:Destroy() end
end

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "Shelby_Pro_Custom"
ScreenGui.ResetOnSpawn = false

-- [ЭФФЕКТЫ ЛОГИНА]
local Blackout = Instance.new("Frame", ScreenGui)
Blackout.Size = UDim2.new(1, 0, 1, 100); Blackout.Position = UDim2.new(0, 0, 0, -50)
Blackout.BackgroundColor3 = Color3.fromRGB(0, 0, 0); Blackout.ZIndex = 5; Blackout.BackgroundTransparency = 0

-- [ГЛАВНОЕ МЕНЮ]
local MainMenu = Instance.new("Frame", ScreenGui)
MainMenu.Size = UDim2.new(0, 620, 0, 420); MainMenu.Position = UDim2.new(0.5, -310, 0.5, -210)
MainMenu.BackgroundColor3 = Color3.fromRGB(15, 15, 22); MainMenu.BackgroundTransparency = 0.1; MainMenu.Visible = false; MainMenu.ZIndex = 20
Instance.new("UICorner", MainMenu).CornerRadius = UDim.new(0, 12)
local MenuStroke = Instance.new("UIStroke", MainMenu)
MenuStroke.Color = CurrentTheme; MenuStroke.Thickness = 1.8

-- КНОПКА СКРЫТИЯ (S)
local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.Size = UDim2.new(0, 55, 0, 55); ToggleBtn.Position = UDim2.new(0, 15, 0.5, -27)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(10, 10, 15); ToggleBtn.Text = "S"; ToggleBtn.TextColor3 = CurrentTheme
ToggleBtn.Font = Enum.Font.GothamBlack; ToggleBtn.TextSize = 28; ToggleBtn.ZIndex = 100; ToggleBtn.Visible = false
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", ToggleBtn).Color = CurrentTheme
ToggleBtn.MouseButton1Click:Connect(function() MainMenu.Visible = not MainMenu.Visible end)

-- САЙДБАР
local Sidebar = Instance.new("Frame", MainMenu)
Sidebar.Size = UDim2.new(0, 170, 1, 0); Sidebar.BackgroundColor3 = Color3.fromRGB(5, 5, 10); Sidebar.BackgroundTransparency = 0.3; Sidebar.ZIndex = 21
Instance.new("UICorner", Sidebar)

local Title = Instance.new("TextLabel", Sidebar)
Title.Size = UDim2.new(1, 0, 0, 60); Title.Text = "SHELBY PROJECT"; Title.TextColor3 = CurrentTheme; Title.Font = CurrentFont; Title.TextSize = 16; Title.BackgroundTransparency = 1; Title.ZIndex = 22

-- СТАТИСТИКА (FPS/PING)
local StatBox = Instance.new("Frame", Sidebar); StatBox.Size = UDim2.new(1, -20, 0, 60); StatBox.Position = UDim2.new(0, 10, 1, -70); StatBox.BackgroundTransparency = 1; StatBox.ZIndex = 22
local function AddStat(p)
    local l = Instance.new("TextLabel", StatBox); l.Size = UDim2.new(1,0,0,18); l.Position = UDim2.new(0,0,0,p); l.TextColor3 = Color3.fromRGB(200,200,200); l.Font = "Gotham"; l.TextSize = 10; l.TextXAlignment = "Left"; l.BackgroundTransparency = 1; l.ZIndex = 23; return l
end
local f_l = AddStat(0); local p_l = AddStat(18)
task.spawn(function() while task.wait(0.5) do f_l.Text = "FPS: "..math.floor(1/RunService.RenderStepped:Wait()) p_l.Text = "Ping: "..math.floor(LocalPlayer:GetNetworkPing()*1000).."ms" end end)

-- КОНТЕНТ
local Content = Instance.new("Frame", MainMenu)
Content.Position = UDim2.new(0, 185, 0, 20); Content.Size = UDim2.new(1, -205, 1, -40); Content.BackgroundTransparency = 1; Content.ClipsDescendants = true; Content.ZIndex = 21

local Pages = {}; local CurrentPage = nil

local function CreatePage(name)
    local Page = Instance.new("ScrollingFrame", Content)
    Page.Size = UDim2.new(1, 0, 1, 0); Page.Position = UDim2.new(1.2, 0, 0, 0); Page.BackgroundTransparency = 1; Page.Visible = false; Page.ScrollBarThickness = 0; Page.ZIndex = 22
    Instance.new("UIListLayout", Page).Padding = UDim.new(0, 8)
    Pages[name] = Page; return Page
end

local function ShowPage(name)
    if CurrentPage == Pages[name] then return end
    if CurrentPage then TweenService:Create(CurrentPage, TweenInfo.new(AnimSpeed/1.5), {Position = UDim2.new(-1.2, 0, 0, 0)}):Play() end
    CurrentPage = Pages[name]; CurrentPage.Visible = true; CurrentPage.Position = UDim2.new(1.2, 0, 0, 0)
    TweenService:Create(CurrentPage, TweenInfo.new(AnimSpeed, AnimStyle, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, 0)}):Play()
end

-- ТУГЛЫ
local function CreateToggle(parent, text, key)
    local f = Instance.new("Frame", parent); f.Size = UDim2.new(1, -10, 0, 42); f.BackgroundColor3 = Color3.fromRGB(30, 30, 40); f.ZIndex = 23; Instance.new("UICorner", f)
    local l = Instance.new("TextLabel", f); l.Size = UDim2.new(1, 0, 1, 0); l.Position = UDim2.new(0, 12, 0, 0); l.Text = text; l.TextColor3 = Color3.fromRGB(255, 255, 255); l.Font = CurrentFont; l.TextSize = 12; l.TextXAlignment = "Left"; l.BackgroundTransparency = 1; l.ZIndex = 24
    local s_bg = Instance.new("Frame", f); s_bg.Size = UDim2.new(0, 34, 0, 16); s_bg.Position = UDim2.new(1, -45, 0.5, -8); s_bg.BackgroundColor3 = Color3.fromRGB(20, 20, 25); s_bg.ZIndex = 24; Instance.new("UICorner", s_bg)
    local circ = Instance.new("Frame", s_bg); circ.Size = UDim2.new(0, 12, 0, 12); circ.Position = UDim2.new(0, 2, 0.5, -6); circ.BackgroundColor3 = Color3.fromRGB(255, 255, 255); circ.ZIndex = 25; Instance.new("UICorner", circ)
    local btn = Instance.new("TextButton", f); btn.Size = UDim2.new(1,0,1,0); btn.BackgroundTransparency = 1; btn.Text = ""; btn.ZIndex = 26
    btn.Activated:Connect(function()
        _G.ShelbyConfig[key] = not _G.ShelbyConfig[key]
        TweenService:Create(circ, TweenInfo.new(0.2), {Position = _G.ShelbyConfig[key] and UDim2.new(1, -14, 0.5, -6) or UDim2.new(0, 2, 0.5, -6), BackgroundColor3 = _G.ShelbyConfig[key] and CurrentTheme or Color3.fromRGB(255,255,255)}):Play()
    end)
end

-- ВКЛАДКИ
local TabHolder = Instance.new("Frame", Sidebar); TabHolder.Size = UDim2.new(1, -10, 0, 200); TabHolder.Position = UDim2.new(0, 8, 0, 70); TabHolder.BackgroundTransparency = 1; TabHolder.ZIndex = 22
Instance.new("UIListLayout", TabHolder).Padding = UDim.new(0, 8)
local function Tab(n)
    local b = Instance.new("TextButton", TabHolder); b.Size = UDim2.new(1, 0, 0, 32); b.BackgroundColor3 = Color3.fromRGB(30, 30, 40); b.Text = n; b.TextColor3 = Color3.fromRGB(220, 220, 220); b.Font = CurrentFont; b.ZIndex = 23; Instance.new("UICorner", b)
    b.Activated:Connect(function() ShowPage(n) end)
end

-- СОЗДАНИЕ КОНТЕНТА
CreateToggle(CreatePage("Main"), "SPEED HACK", "Speed")
CreateToggle(CreatePage("Combat"), "SOFT AIMBOT", "Aimbot")
CreateToggle(CreatePage("Visuals"), "HIGHLIGHT ESP", "EspSkeletons")
CreateToggle(Pages["Visuals"], "SHOW NAMES", "EspNames")
CreateToggle(Pages["Visuals"], "SHOW HEALTH", "EspHealth")
Tab("Main"); Tab("Combat"); Tab("Visuals"); Tab("Settings")

-- [ЛОГИКА ФУНКЦИЙ]
RunService.RenderStepped:Connect(function()
    if _G.ShelbyConfig.Aimbot then
        local target = nil; local shortestDist = _G.ShelbyConfig.FovRadius
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") and p.Character.Humanoid.Health > 0 then
                local pos, vis = Camera:WorldToViewportPoint(p.Character.Head.Position)
                if vis then
                    local dist = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                    if dist < shortestDist then shortestDist = dist; target = p end
                end
            end
        end
        if target then Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, target.Character.Head.Position), _G.ShelbyConfig.AimSens) end
    end
    if _G.ShelbyConfig.Speed and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.WalkSpeed = _G.ShelbyConfig.WalkSpeed end
end)

-- [УЛУЧШЕННЫЙ ESP]
local function ApplyESP(p)
    local function Create()
        if p == LocalPlayer or not p.Character then return end
        local char = p.Character; local head = char:WaitForChild("Head", 10)
        local high = char:FindFirstChild("S_High") or Instance.new("Highlight", char); high.Name = "S_High"; high.FillColor = CurrentTheme
        local bGui = head:FindFirstChild("S_Gui") or Instance.new("BillboardGui", head); bGui.Name = "S_Gui"; bGui.AlwaysOnTop = true; bGui.Size = UDim2.new(0, 100, 0, 40); bGui.ExtentsOffset = Vector3.new(0, 3, 0)
        local txt = bGui:FindFirstChild("L") or Instance.new("TextLabel", bGui); txt.Name = "L"; txt.Size = UDim2.new(1,0,1,0); txt.BackgroundTransparency = 1; txt.TextColor3 = Color3.new(1,1,1); txt.Font = CurrentFont; txt.TextSize = 12
        RunService.Heartbeat:Connect(function()
            if not char:FindFirstChild("Humanoid") then bGui:Destroy(); return end
            high.Enabled = _G.ShelbyConfig.EspSkeletons
            bGui.Enabled = (_G.ShelbyConfig.EspNames or _G.ShelbyConfig.EspHealth)
            local s = ""
            if _G.ShelbyConfig.EspNames then s = s .. p.Name .. "\n" end
            if _G.ShelbyConfig.EspHealth then s = s .. "HP: " .. math.floor(char.Humanoid.Health) end
            txt.Text = s
        end)
    end
    Create(); p.CharacterAdded:Connect(Create)
end
for _, p in pairs(Players:GetPlayers()) do ApplyESP(p) end; Players.PlayerAdded:Connect(ApplyESP)

-- [ЛОГИН - ТВОЯ ОРИГИНАЛЬНАЯ АНИМАЦИЯ]
local LoginFrame = Instance.new("Frame", ScreenGui); LoginFrame.Size = UDim2.new(0, 340, 0, 300); LoginFrame.Position = UDim2.new(0.5, -170, 0.5, -150); LoginFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20); LoginFrame.ZIndex = 60; Instance.new("UICorner", LoginFrame)
local KeyIn = Instance.new("TextBox", LoginFrame); KeyIn.Size = UDim2.new(0, 260, 0, 45); KeyIn.Position = UDim2.new(0.5, -130, 0.4, 0); KeyIn.PlaceholderText = "Key..."; KeyIn.ZIndex = 61; Instance.new("UICorner", KeyIn)
local LogBtn = Instance.new("TextButton", LoginFrame); LogBtn.Size = UDim2.new(0, 260, 0, 50); LogBtn.Position = UDim2.new(0.5, -130, 0.65, 0); LogBtn.BackgroundColor3 = CurrentTheme; LogBtn.Text = "LOG IN"; LogBtn.ZIndex = 61; Instance.new("UICorner", LogBtn)

local IntroText = Instance.new("TextLabel", ScreenGui); IntroText.Size = UDim2.new(1, 0, 1, 0); IntroText.BackgroundTransparency = 1; IntroText.Text = "S H E L B Y"; IntroText.TextColor3 = Color3.new(1, 1, 1); IntroText.Font = Enum.Font.GothamBold; IntroText.TextSize = 80; IntroText.TextTransparency = 1; IntroText.ZIndex = 100

LogBtn.MouseButton1Click:Connect(function()
    TweenService:Create(LoginFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back), {Position = UDim2.new(0.5, -170, 1.5, 0)}):Play()
    task.wait(0.6); IntroText.Visible = true; TweenService:Create(IntroText, TweenInfo.new(0.8), {TextTransparency = 0}):Play()
    task.wait(1.5); TweenService:Create(IntroText, TweenInfo.new(0.8), {TextTransparency = 1}):Play()
    task.wait(1); TweenService:Create(Blackout, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
    MainMenu.Visible = true; ToggleBtn.Visible = true; ShowPage("Main")
end)

UserInputService.InputBegan:Connect(function(i) if i.KeyCode == Enum.KeyCode.RightShift then MainMenu.Visible = not MainMenu.Visible end end)
