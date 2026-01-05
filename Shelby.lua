-- [[ SHELBY PROJECT // ENHANCED LAUNCHER // v2.0 ]] --
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

-- Очистка старого
if CoreGui:FindFirstChild("ShelbyGlassUI") then 
    CoreGui.ShelbyGlassUI:Destroy() 
end

-- ЭФФЕКТ РАЗМЫТИЯ
local Blur = Instance.new("BlurEffect", game:GetService("Lighting"))
Blur.Size = 15

-- ГЛАВНЫЙ ЭКРАН
local Screen = Instance.new("ScreenGui", CoreGui)
Screen.Name = "ShelbyGlassUI"
Screen.IgnoreGuiInset = true

-- ФОН
local Background = Instance.new("Frame", Screen)
Background.Size = UDim2.new(1, 0, 1, 0)
Background.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
Background.BackgroundTransparency = 0.3
Background.BorderSizePixel = 0

-- ГЛАВНОЕ МЕНЮ (ЛОАДЕР)
local MainLoader = Instance.new("Frame", Screen)
MainLoader.AnchorPoint = Vector2.new(0.5, 0.5)
MainLoader.Position = UDim2.new(0.5, 0, 0.5, 0)
MainLoader.Size = UDim2.new(0, 800, 0, 500)
MainLoader.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainLoader.BackgroundTransparency = 0.15
MainLoader.BorderSizePixel = 0

local LoaderCorner = Instance.new("UICorner", MainLoader)
LoaderCorner.CornerRadius = UDim.new(0, 12)

local LoaderStroke = Instance.new("UIStroke", MainLoader)
LoaderStroke.Color = Color3.fromRGB(100, 100, 150)
LoaderStroke.Transparency = 0.7
LoaderStroke.Thickness = 1

-- ЗАГОЛОВОК ЛОАДЕРА
local LoaderTitle = Instance.new("TextLabel", MainLoader)
LoaderTitle.Size = UDim2.new(1, 0, 0, 80)
LoaderTitle.Position = UDim2.new(0, 0, 0, 20)
LoaderTitle.Text = "SHELBY PROJECT LAUNCHER"
LoaderTitle.TextColor3 = Color3.fromRGB(220, 220, 255)
LoaderTitle.Font = Enum.Font.GothamBold
LoaderTitle.TextSize = 32
LoaderTitle.BackgroundTransparency = 1
LoaderTitle.TextStrokeTransparency = 0.8

local SubTitle = Instance.new("TextLabel", MainLoader)
SubTitle.Size = UDim2.new(1, 0, 0, 30)
SubTitle.Position = UDim2.new(0, 0, 0, 60)
SubTitle.Text = "Выберите конфигурацию для вашей игры"
SubTitle.TextColor3 = Color3.fromRGB(180, 180, 220)
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextSize = 18
SubTitle.BackgroundTransparency = 1

-- КОНТЕЙНЕР ДЛЯ КНОПОК ИГР
local GamesContainer = Instance.new("ScrollingFrame", MainLoader)
GamesContainer.Size = UDim2.new(1, -40, 0, 300)
GamesContainer.Position = UDim2.new(0, 20, 0, 120)
GamesContainer.BackgroundTransparency = 1
GamesContainer.ScrollBarThickness = 3
GamesContainer.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 150)
GamesContainer.CanvasSize = UDim2.new(0, 0, 0, 0)

local GamesLayout = Instance.new("UIGridLayout", GamesContainer)
GamesLayout.CellSize = UDim2.new(0, 180, 0, 180)
GamesLayout.CellPadding = UDim2.new(0, 15, 0, 15)
GamesLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- БАЗА КОНФИГУРАЦИЙ ДЛЯ КАЖДОЙ ИГРЫ
local GameConfigs = {
    ["Counter-Strike 2"] = {
        color = Color3.fromRGB(255, 100, 50),
        icon = "🎯",
        features = {
            "Legit Aimbot",
            "Wallhack CS2 Style",
            "Trigger Bot",
            "RCS System",
            "Skin Changer"
        },
        vh_style = "CS2_Skeleton",
        legit_settings = {
            fov = 4,
            smooth = 2.5,
            rcs = true,
            autowall = true
        }
    },
    ["Murder Mystery 2"] = {
        color = Color3.fromRGB(255, 50, 100),
        icon = "🔪",
        features = {
            "Murder ESP",
            "Weapon ESP",
            "Auto-Gun",
            "Speed Hack"
        },
        vh_style = "Highlight",
        legit_settings = {
            fov = 6,
            smooth = 3.0,
            rcs = false
        }
    },
    ["Arsenal"] = {
        color = Color3.fromRGB(255, 200, 50),
        icon = "🔫",
        features = {
            "Aimbot",
            "ESP Boxes",
            "Hit Sound",
            "FOV Changer"
        },
        vh_style = "2D_Box",
        legit_settings = {
            fov = 5,
            smooth = 2.0,
            rcs = true
        }
    },
    ["Doors"] = {
        color = Color3.fromRGB(50, 200, 100),
        icon = "🚪",
        features = {
            "Entity ESP",
            "Auto-Avoid",
            "Item Finder",
            "Room Hack"
        },
        vh_style = "Tracer",
        legit_settings = {
            fov = 8,
            smooth = 1.5,
            rcs = false
        }
    },
    ["Blox Fruits"] = {
        color = Color3.fromRGB(50, 150, 255),
        icon = "🍇",
        features = {
            "Fruit ESP",
            "Auto-Farm",
            "Teleport",
            "Auto-Dodge"
        },
        vh_style = "Highlight",
        legit_settings = {
            fov = 10,
            smooth = 2.0,
            rcs = false
        }
    }
}

-- ФУНКЦИЯ СОЗДАНИЯ КАРТОЧКИ ИГРЫ
local function CreateGameCard(gameName, config)
    local Card = Instance.new("TextButton", GamesContainer)
    Card.Size = UDim2.new(0, 180, 0, 180)
    Card.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    Card.BackgroundTransparency = 0.2
    Card.AutoButtonColor = false
    Card.Text = ""
    
    local CardCorner = Instance.new("UICorner", Card)
    CardCorner.CornerRadius = UDim.new(0, 10)
    
    local CardStroke = Instance.new("UIStroke", Card)
    CardStroke.Color = config.color
    CardStroke.Thickness = 2
    CardStroke.Transparency = 0.7
    
    -- ИКОНКА
    local Icon = Instance.new("TextLabel", Card)
    Icon.Size = UDim2.new(1, 0, 0, 60)
    Icon.Position = UDim2.new(0, 0, 0, 20)
    Icon.Text = config.icon
    Icon.TextColor3 = config.color
    Icon.Font = Enum.Font.GothamBold
    Icon.TextSize = 48
    Icon.BackgroundTransparency = 1
    
    -- НАЗВАНИЕ ИГРЫ
    local Title = Instance.new("TextLabel", Card)
    Title.Size = UDim2.new(1, -20, 0, 30)
    Title.Position = UDim2.new(0, 10, 0, 90)
    Title.Text = gameName
    Title.TextColor3 = Color3.fromRGB(240, 240, 255)
    Title.Font = Enum.Font.GothamMedium
    Title.TextSize = 18
    Title.BackgroundTransparency = 1
    
    -- ФУНКЦИОНАЛ
    local Features = Instance.new("TextLabel", Card)
    Features.Size = UDim2.new(1, -20, 0, 40)
    Features.Position = UDim2.new(0, 10, 0, 120)
    Features.Text = table.concat(config.features, "\n")
    Features.TextColor3 = Color3.fromRGB(180, 180, 200)
    Features.Font = Enum.Font.Gotham
    Features.TextSize = 12
    Features.TextXAlignment = Enum.TextXAlignment.Left
    Features.BackgroundTransparency = 1
    
    -- ИНДИКАТОР ВЫБОРА
    local SelectionIndicator = Instance.new("Frame", Card)
    SelectionIndicator.Size = UDim2.new(1, 0, 0, 4)
    SelectionIndicator.Position = UDim2.new(0, 0, 1, -4)
    SelectionIndicator.BackgroundColor3 = config.color
    SelectionIndicator.BorderSizePixel = 0
    SelectionIndicator.Visible = false
    
    -- АНИМАЦИИ НАВЕДЕНИЯ
    Card.MouseEnter:Connect(function()
        TweenService:Create(CardStroke, TweenInfo.new(0.2), {Transparency = 0.3}):Play()
        TweenService:Create(Card, TweenInfo.new(0.2), {BackgroundTransparency = 0.1}):Play()
    end)
    
    Card.MouseLeave:Connect(function()
        TweenService:Create(CardStroke, TweenInfo.new(0.2), {Transparency = 0.7}):Play()
        TweenService:Create(Card, TweenInfo.new(0.2), {BackgroundTransparency = 0.2}):Play()
    end)
    
    -- НАЖАТИЕ НА КАРТОЧКУ
    Card.MouseButton1Click:Connect(function()
        -- Анимация выбора
        SelectionIndicator.Visible = true
        TweenService:Create(SelectionIndicator, TweenInfo.new(0.3), {Size = UDim2.new(1, 0, 0, 4)}):Play()
        
        -- Переход к настройкам
        wait(0.3)
        OpenSettingsMenu(gameName, config)
    end)
    
    return Card
end

-- ФУНКЦИЯ СОЗДАНИЯ МЕНЮ НАСТРОЕК
local currentSettingsMenu = nil

local function OpenSettingsMenu(gameName, config)
    -- Скрываем лоадер
    TweenService:Create(MainLoader, TweenInfo.new(0.5), {
        Position = UDim2.new(-0.5, 0, 0.5, 0)
    }):Play()
    
    -- Удаляем предыдущее меню
    if currentSettingsMenu then
        currentSettingsMenu:Destroy()
    end
    
    -- СОЗДАЕМ МЕНЮ НАСТРОЕК (как в скриншотах)
    local SettingsMenu = Instance.new("Frame", Screen)
    SettingsMenu.AnchorPoint = Vector2.new(0.5, 0.5)
    SettingsMenu.Position = UDim2.new(1.5, 0, 0.5, 0)
    SettingsMenu.Size = UDim2.new(0, 700, 0, 500)
    SettingsMenu.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    SettingsMenu.BackgroundTransparency = 0.1
    SettingsMenu.BorderSizePixel = 0
    
    local MenuCorner = Instance.new("UICorner", SettingsMenu)
    MenuCorner.CornerRadius = UDim.new(0, 12)
    
    local MenuStroke = Instance.new("UIStroke", SettingsMenu)
    MenuStroke.Color = config.color
    MenuStroke.Thickness = 1
    MenuStroke.Transparency = 0.3
    
    currentSettingsMenu = SettingsMenu
    
    -- ЗАГОЛОВОК
    local MenuTitle = Instance.new("TextLabel", SettingsMenu)
    MenuTitle.Size = UDim2.new(1, 0, 0, 60)
    MenuTitle.Position = UDim2.new(0, 20, 0, 10)
    MenuTitle.Text = gameName .. " - КОНФИГУРАЦИЯ"
    MenuTitle.TextColor3 = Color3.fromRGB(240, 240, 255)
    MenuTitle.Font = Enum.Font.GothamBold
    MenuTitle.TextSize = 24
    MenuTitle.BackgroundTransparency = 1
    MenuTitle.TextXAlignment = Enum.TextXAlignment.Left
    
    -- ВКЛАДКИ (как в скриншотах)
    local TabsContainer = Instance.new("Frame", SettingsMenu)
    TabsContainer.Size = UDim2.new(1, -40, 0, 40)
    TabsContainer.Position = UDim2.new(0, 20, 0, 70)
    TabsContainer.BackgroundTransparency = 1
    
    local Tabs = {"General", "Extra", "Visuals", "Misc", "Settings"}
    local TabButtons = {}
    
    for i, tabName in ipairs(Tabs) do
        local TabButton = Instance.new("TextButton", TabsContainer)
        TabButton.Size = UDim2.new(0, 100, 1, 0)
        TabButton.Position = UDim2.new(0, (i-1)*110, 0, 0)
        TabButton.Text = tabName
        TabButton.TextColor3 = Color3.fromRGB(200, 200, 220)
        TabButton.Font = Enum.Font.Gotham
        TabButton.TextSize = 14
        TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        TabButton.BackgroundTransparency = 0.5
        
        local TabCorner = Instance.new("UICorner", TabButton)
        TabCorner.CornerRadius = UDim.new(0, 6)
        
        local TabIndicator = Instance.new("Frame", TabButton)
        TabIndicator.Size = UDim2.new(1, 0, 0, 3)
        TabIndicator.Position = UDim2.new(0, 0, 1, -3)
        TabIndicator.BackgroundColor3 = config.color
        TabIndicator.BorderSizePixel = 0
        TabIndicator.Visible = (i == 1)
        
        TabButton.MouseButton1Click:Connect(function()
            -- Подсветка активной вкладки
            for _, btn in pairs(TabButtons) do
                btn.Indicator.Visible = false
            end
            TabIndicator.Visible = true
            
            -- Здесь можно добавить смену контента вкладки
        end)
        
        TabButton.Indicator = TabIndicator
        TabButtons[i] = TabButton
    end
    
    -- ОБЛАСТЬ С НАСТРОЙКАМИ
    local SettingsScroll = Instance.new("ScrollingFrame", SettingsMenu)
    SettingsScroll.Size = UDim2.new(1, -40, 0, 340)
    SettingsScroll.Position = UDim2.new(0, 20, 0, 120)
    SettingsScroll.BackgroundTransparency = 1
    SettingsScroll.ScrollBarThickness = 3
    SettingsScroll.CanvasSize = UDim2.new(0, 0, 0, 500)
    
    -- НАСТРОЙКИ ДЛЯ КАЖДОЙ ИГРЫ (пример для CS2)
    if gameName == "Counter-Strike 2" then
        -- Global Enable
        CreateToggle(SettingsScroll, "Global Enable", true, 0, 0)
        CreateSlider(SettingsScroll, "FOV", 0, 20, config.legit_settings.fov, 0, 40)
        CreateSlider(SettingsScroll, "Smooth", 0, 10, config.legit_settings.smooth, 0, 80)
        CreateToggle(SettingsScroll, "Silent Aim", false, 0, 120)
        CreateToggle(SettingsScroll, "Disable when flashed", true, 0, 160)
        CreateToggle(SettingsScroll, "Disable in smoke", true, 0, 200)
        CreateToggle(SettingsScroll, "Aim on key", true, 0, 240)
        CreateToggle(SettingsScroll, "Autowall", config.legit_settings.autowall, 0, 280)
        CreateToggle(SettingsScroll, "RCS", config.legit_settings.rcs, 0, 320)
    else
        -- Настройки для других игр
        local InfoText = Instance.new("TextLabel", SettingsScroll)
        InfoText.Size = UDim2.new(1, 0, 0, 200)
        InfoText.Position = UDim2.new(0, 0, 0, 50)
        InfoText.Text = "Настройки " .. gameName .. "\n\n" .. table.concat(config.features, "\n")
        InfoText.TextColor3 = Color3.fromRGB(200, 200, 220)
        InfoText.Font = Enum.Font.Gotham
        InfoText.TextSize = 16
        InfoText.BackgroundTransparency = 1
        InfoText.TextYAlignment = Enum.TextYAlignment.Top
    end
    
    -- КНОПКИ УПРАВЛЕНИЯ
    local ButtonContainer = Instance.new("Frame", SettingsMenu)
    ButtonContainer.Size = UDim2.new(1, -40, 0, 50)
    ButtonContainer.Position = UDim2.new(0, 20, 1, -60)
    ButtonContainer.BackgroundTransparency = 1
    
    -- Кнопка НАЗАД
    local BackButton = Instance.new("TextButton", ButtonContainer)
    BackButton.Size = UDim2.new(0, 120, 1, 0)
    BackButton.Position = UDim2.new(0, 0, 0, 0)
    BackButton.Text = "← НАЗАД"
    BackButton.TextColor3 = Color3.fromRGB(200, 200, 220)
    BackButton.Font = Enum.Font.GothamMedium
    BackButton.TextSize = 16
    BackButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    BackButton.BackgroundTransparency = 0.3
    
    local BackCorner = Instance.new("UICorner", BackButton)
    BackCorner.CornerRadius = UDim.new(0, 8)
    
    BackButton.MouseButton1Click:Connect(function()
        TweenService:Create(SettingsMenu, TweenInfo.new(0.5), {
            Position = UDim2.new(1.5, 0, 0.5, 0)
        }):Play()
        
        TweenService:Create(MainLoader, TweenInfo.new(0.5), {
            Position = UDim2.new(0.5, 0, 0.5, 0)
        }):Play()
    end)
    
    -- Кнопка АКТИВИРОВАТЬ
    local ActivateButton = Instance.new("TextButton", ButtonContainer)
    ActivateButton.Size = UDim2.new(0, 200, 1, 0)
    ActivateButton.Position = UDim2.new(1, -200, 0, 0)
    ActivateButton.Text = "АКТИВИРОВАТЬ " .. config.icon
    ActivateButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ActivateButton.Font = Enum.Font.GothamBold
    ActivateButton.TextSize = 18
    ActivateButton.BackgroundColor3 = config.color
    ActivateButton.BackgroundTransparency = 0.2
    
    local ActivateCorner = Instance.new("UICorner", ActivateButton)
    ActivateCorner.CornerRadius = UDim.new(0, 8)
    
    local ActivateStroke = Instance.new("UIStroke", ActivateButton)
    ActivateStroke.Color = config.color
    ActivateStroke.Thickness = 2
    
    ActivateButton.MouseButton1Click:Connect(function()
        -- Активация чита для выбранной игры
        ActivateCheat(gameName, config)
    end)
    
    -- Анимация появления
    TweenService:Create(SettingsMenu, TweenInfo.new(0.5), {
        Position = UDim2.new(0.5, 0, 0.5, 0)
    }):Play()
end

-- ФУНКЦИЯ СОЗДАНИЯ ПЕРЕКЛЮЧАТЕЛЯ
local function CreateToggle(parent, name, defaultValue, x, y)
    local ToggleFrame = Instance.new("Frame", parent)
    ToggleFrame.Size = UDim2.new(1, 0, 0, 30)
    ToggleFrame.Position = UDim2.new(0, x, 0, y)
    ToggleFrame.BackgroundTransparency = 1
    
    local ToggleLabel = Instance.new("TextLabel", ToggleFrame)
    ToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
    ToggleLabel.Position = UDim2.new(0, 0, 0, 0)
    ToggleLabel.Text = name
    ToggleLabel.TextColor3 = Color3.fromRGB(220, 220, 240)
    ToggleLabel.Font = Enum.Font.Gotham
    ToggleLabel.TextSize = 14
    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local ToggleButton = Instance.new("TextButton", ToggleFrame)
    ToggleButton.Size = UDim2.new(0, 50, 0, 25)
    ToggleButton.Position = UDim2.new(1, -50, 0, 2)
    ToggleButton.Text = ""
    ToggleButton.BackgroundColor3 = defaultValue and Color3.fromRGB(50, 200, 100) or Color3.fromRGB(100, 100, 120)
    
    local ToggleCorner = Instance.new("UICorner", ToggleButton)
    ToggleCorner.CornerRadius = UDim.new(1, 0)
    
    local ToggleKnob = Instance.new("Frame", ToggleButton)
    ToggleKnob.Size = UDim2.new(0, 21, 0, 21)
    ToggleKnob.Position = defaultValue and UDim2.new(1, -23, 0, 2) or UDim2.new(0, 2, 0, 2)
    ToggleKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ToggleKnob.BorderSizePixel = 0
    
    local KnobCorner = Instance.new("UICorner", ToggleKnob)
    KnobCorner.CornerRadius = UDim.new(1, 0)
    
    ToggleButton.MouseButton1Click:Connect(function()
        defaultValue = not defaultValue
        TweenService:Create(ToggleButton, TweenInfo.new(0.2), {
            BackgroundColor3 = defaultValue and Color3.fromRGB(50, 200, 100) or Color3.fromRGB(100, 100, 120)
        }):Play()
        
        TweenService:Create(ToggleKnob, TweenInfo.new(0.2), {
            Position = defaultValue and UDim2.new(1, -23, 0, 2) or UDim2.new(0, 2, 0, 2)
        }):Play()
    end)
    
    return ToggleFrame
end

-- ФУНКЦИЯ СОЗДАНИЯ СЛАЙДЕРА
local function CreateSlider(parent, name, min, max, defaultValue, x, y)
    local SliderFrame = Instance.new("Frame", parent)
    SliderFrame.Size = UDim2.new(1, 0, 0, 40)
    SliderFrame.Position = UDim2.new(0, x, 0, y)
    SliderFrame.BackgroundTransparency = 1
    
    local SliderLabel = Instance.new("TextLabel", SliderFrame)
    SliderLabel.Size = UDim2.new(0.7, 0, 0, 20)
    SliderLabel.Position = UDim2.new(0, 0, 0, 0)
    SliderLabel.Text = name .. ": " .. defaultValue
    SliderLabel.TextColor3 = Color3.fromRGB(220, 220, 240)
    SliderLabel.Font = Enum.Font.Gotham
    SliderLabel.TextSize = 14
    SliderLabel.BackgroundTransparency = 1
    SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local SliderTrack = Instance.new("Frame", SliderFrame)
    SliderTrack.Size = UDim2.new(1, 0, 0, 6)
    SliderTrack.Position = UDim2.new(0, 0, 0, 25)
    SliderTrack.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    SliderTrack.BorderSizePixel = 0
    
    local TrackCorner = Instance.new("UICorner", SliderTrack)
    TrackCorner.CornerRadius = UDim.new(1, 0)
    
    local SliderFill = Instance.new("Frame", SliderTrack)
    SliderFill.Size = UDim2.new((defaultValue - min) / (max - min), 0, 1, 0)
    SliderFill.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
    SliderFill.BorderSizePixel = 0
    
    local FillCorner = Instance.new("UICorner", SliderFill)
    FillCorner.CornerRadius = UDim.new(1, 0)
    
    local SliderButton = Instance.new("TextButton", SliderTrack)
    SliderButton.Size = UDim2.new(0, 16, 0, 16)
    SliderButton.Position = UDim2.new((defaultValue - min) / (max - min), -8, 0.5, -8)
    SliderButton.Text = ""
    SliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SliderButton.BorderSizePixel = 0
    
    local ButtonCorner = Instance.new("UICorner", SliderButton)
    ButtonCorner.CornerRadius = UDim.new(1, 0)
    
    local dragging = false
    
    local function UpdateSlider(value)
        local percent = math.clamp((value - min) / (max - min), 0, 1)
        SliderFill.Size = UDim2.new(percent, 0, 1, 0)
        SliderButton.Position = UDim2.new(percent, -8, 0.5, -8)
        SliderLabel.Text = name .. ": " .. math.floor(value * 10) / 10
    end
    
    SliderButton.MouseButton1Down:Connect(function()
        dragging = true
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mousePos = UserInputService:GetMouseLocation()
            local trackPos = SliderTrack.AbsolutePosition.X
            local trackSize = SliderTrack.AbsoluteSize.X
            local percent = math.clamp((mousePos.X - trackPos) / trackSize, 0, 1)
      local value = min + (max - min) * percent
            UpdateSlider(value)
        end
    end)
    
    return SliderFrame
end

-- ФУНКЦИЯ АКТИВАЦИИ ВХ ДЛЯ КАЖДОЙ ИГРЫ
local function ActivateCheat(gameName, config)
    print("[SHELBY] Активирован чит для: " .. gameName)
    
    -- УНИКАЛЬНЫЙ ВХ ДЛЯ КАЖДОЙ ИГРЫ
    if gameName == "Counter-Strike 2" then
        -- CS2 СТИЛЬ ВХ (скелетоны как на скриншотах)
        RunService.RenderStepped:Connect(function()
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LP and player.Character then
                    local char = player.Character
                    local humanoid = char:FindFirstChild("Humanoid")
                    local root = char:FindFirstChild("HumanoidRootPart")
                    
                    if humanoid and root and humanoid.Health > 0 then
                        -- СКЕЛЕТОН ВХ
                        if config.vh_style == "CS2_Skeleton" then
                            -- Создаем или обновляем скелетон
                            if not char:FindFirstChild("CS2_Skeleton") then
                                local highlight = Instance.new("Highlight")
                                highlight.Name = "CS2_Skeleton"
                                highlight.OutlineColor = config.color
                                highlight.OutlineTransparency = 0
                                highlight.FillColor = config.color
                                highlight.FillTransparency = 0.9
                                highlight.Parent = char
                            end
                            
                            -- ИНФО О ИГРОКЕ
                            local head = char:FindFirstChild("Head")
                            if head then
                                local billboard = head:FindFirstChild("CS2_Info") or Instance.new("BillboardGui", head)
                                billboard.Name = "CS2_Info"
                                billboard.Size = UDim2.new(0, 200, 0, 50)
                                billboard.AlwaysOnTop = true
                                billboard.MaxDistance = 1000
                                
                                local textLabel = billboard:FindFirstChild("Text") or Instance.new("TextLabel", billboard)
                                textLabel.Name = "Text"
                                textLabel.Size = UDim2.new(1, 0, 1, 0)
                                textLabel.Text = player.Name .. "\nHP: " .. math.floor(humanoid.Health)
                                textLabel.TextColor3 = Color3.new(1, 1, 1)
                                textLabel.BackgroundTransparency = 1
                                textLabel.TextStrokeTransparency = 0.5
                            end
                        end
                    else
                        -- Очистка если игрок мертв
                        if char:FindFirstChild("CS2_Skeleton") then
                            char.CS2_Skeleton:Destroy()
                        end
                    end
                end
            end
        end)
        
    elseif gameName == "Murder Mystery 2" then
        -- MM2 ВХ
        RunService.RenderStepped:Connect(function()
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LP and player.Character then
                    local char = player.Character
                    if not char:FindFirstChild("MM2_Highlight") then
                        local highlight = Instance.new("Highlight")
                        highlight.Name = "MM2_Highlight"
                        highlight.FillColor = config.color
                        highlight.FillTransparency = 0.8
                        highlight.OutlineColor = config.color
                        highlight.Parent = char
                    end
                end
            end
        end)
        
    elseif gameName == "Arsenal" then
        -- ARSENAL ВХ (2D Boxes)
        RunService.RenderStepped:Connect(function()
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LP and player.Character then
                    local char = player.Character
                    local root = char:FindFirstChild("HumanoidRootPart")
                    
                    if root and not char:FindFirstChild("Arsenal_Box") then
                        local billboard = Instance.new("BillboardGui", char)
                        billboard.Name = "Arsenal_Box"
                        billboard.Size = UDim2.new(4, 0, 6, 0)
                        billboard.AlwaysOnTop = true
                        
                        local frame = Instance.new("Frame", billboard)
                        frame.Size = UDim2.new(1, 0, 1, 0)
                        frame.BackgroundTransparency = 1
                        
                        local stroke = Instance.new("UIStroke", frame)
                        stroke.Color = config.color
                        stroke.Thickness = 2
                        
                        -- Линия до игрока
                        local line = Instance.new("Frame", Screen)
                        line.Name = "Arsenal_Line_" .. player.Name
                        line.BackgroundColor3 = config.color
                        line.BorderSizePixel = 0
                        line.Size = UDim2.new(0, 2, 0, 100)
                        line.Visible = false
                    end
                end
            end
        end)
        
    elseif gameName == "Doors" then
        -- DOORS ВХ (трассеры к сущностям)
        RunService.RenderStepped:Connect(function()
            -- Ищем NPC/монстров
            for _, npc in pairs(workspace:GetChildren()) do
                if npc.Name:find("Figure") or npc.Name:find("Rush") or npc.Name:find("Ambush") then
                    if npc:FindFirstChild("HumanoidRootPart") then
                        if not npc:FindFirstChild("Doors_Highlight") then
                            local highlight = Instance.new("Highlight")
                            highlight.Name = "Doors_Highlight"
                            highlight.FillColor = config.color
                            highlight.FillTransparency = 0.7
                            highlight.OutlineColor = Color3.new(1, 0, 0)
                            highlight.Parent = npc
                        end
                    end
                end
            end
        end)
        
    elseif gameName == "Blox Fruits" then
        -- BLOX FRUITS ВХ
        RunService.RenderStepped:Connect(function()
            -- Подсветка игроков
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LP and player.Character then
                    local char = player.Character
                    if not char:FindFirstChild("BloxFruits_Highlight") then
                        local highlight = Instance.new("Highlight")
                        highlight.Name = "BloxFruits_Highlight"
                        highlight.FillColor = config.color
                        highlight.FillTransparency = 0.85
                        highlight.OutlineColor = config.color
                        highlight.Parent = char
                    end
                end
            end
            
            -- Подсветка фруктов
            for _, obj in pairs(workspace:GetChildren()) do
                if obj.Name:find("Fruit") or obj.Name:find("Demon") then
                    if not obj:FindFirstChild("Fruit_Highlight") then
                        local highlight = Instance.new("Highlight")
                        highlight.Name = "Fruit_Highlight"
                        highlight.FillColor = Color3.fromRGB(255, 215, 0)
                        highlight.FillTransparency = 0.5
                        highlight.OutlineColor = Color3.fromRGB(255, 215, 0)
                        highlight.Parent = obj
                    end
                end
            end
        end)
    end
    
    -- УВЕДОМЛЕНИЕ ОБ АКТИВАЦИИ
    local Notification = Instance.new("Frame", Screen)
    Notification.AnchorPoint = Vector2.new(0.5, 0)
    Notification.Size = UDim2.new(0, 300, 0, 60)
    Notification.Position = UDim2.new(0.5, 0, 0, -60)
    Notification.BackgroundColor3 = Color3.fromRGB(30, 40, 50)
    Notification.BackgroundTransparency = 0.2
    
    local NotifCorner = Instance.new("UICorner", Notification)
    NotifCorner.CornerRadius = UDim.new(0, 10)
    
    local NotifStroke = Instance.new("UIStroke", Notification)
    NotifStroke.Color = config.color
    NotifStroke.Thickness = 2
    
    local NotifText = Instance.new("TextLabel", Notification)
    NotifText.Size = UDim2.new(1, -20, 1, -20)
    NotifText.Position = UDim2.new(0, 10, 0, 10)
    NotifText.Text = config.icon .. " " .. gameName .. " активирован!\nФункции: " .. table.concat(config.features, ", ")
    NotifText.TextColor3 = Color3.new(1, 1, 1)
    NotifText.Font = Enum.Font.Gotham
    NotifText.TextSize = 14
    NotifText.BackgroundTransparency = 1
    NotifText.TextYAlignment = Enum.TextYAlignment.Top
    
    -- Анимация уведомления
    TweenService:Create(Notification, TweenInfo.new(0.5), {
        Position = UDim2.new(0.5, 0, 0, 20)
    }):Play()
    
    wait(3)
    
    TweenService:Create(Notification, TweenInfo.new(0.5), {
        Position = UDim2.new(0.5, 0, 0, -60)
    }):Play()
    
    wait(0.5)
    Notification:Destroy()
end

-- ИНИЦИАЛИЗАЦИЯ КАРТОЧЕК ИГР
for gameName, config in pairs(GameConfigs) do
    CreateGameCard(gameName, config)
end

-- АВТОМАТИЧЕСКИЙ РАСЧЁТ РАЗМЕРА КОНТЕЙНЕРА
local gamesCount = 0
for _ in pairs(GameConfigs) do
    gamesCount = gamesCount + 1
end
local rows = math.ceil(gamesCount / 4)
GamesContainer.CanvasSize = UDim2.new(0, 0, 0, rows * 195)

-- АНИМАЦИЯ ПОЯВЛЕНИЯ ЛОАДЕРА
MainLoader.Size = UDim2.new(0, 0, 0, 0)
TweenService:Create(MainLoader, TweenInfo.new(0.8, Enum.EasingStyle.Back), {
    Size = UDim2.new(0, 800, 0, 500)
}):Play()

-- КНОПКА ВЫХОДА
local ExitButton = Instance.new("TextButton", MainLoader)
ExitButton.Size = UDim2.new(0, 40, 0, 40)
ExitButton.Position = UDim2.new(1, -50, 0, 10)
ExitButton.Text = "✕"
ExitButton.TextColor3 = Color3.fromRGB(200, 200, 220)
ExitButton.Font = Enum.Font.GothamBold
ExitButton.TextSize = 20
ExitButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
ExitButton.BackgroundTransparency = 0.3

local ExitCorner = Instance.new("UICorner", ExitButton)
ExitCorner.CornerRadius = UDim.new(0, 8)

ExitButton.MouseButton1Click:Connect(function()
    TweenService:Create(MainLoader, TweenInfo.new(0.5), {
        Size = UDim2.new(0, 0, 0, 0)
    }):Play()
    
    TweenService:Create(Blur, TweenInfo.new(0.5), {
        Size = 0
    }):Play()
    
    wait(0.5)
    Screen:Destroy()
    Blur:Destroy()
end)

-- ИНФОРМАЦИЯ О ВЕРСИИ
local VersionText = Instance.new("TextLabel", MainLoader)
VersionText.Size = UDim2.new(1, 0, 0, 30)
VersionText.Position = UDim2.new(0, 0, 1, -30)
VersionText.Text = "SHELBY PROJECT v2.0 | CS2 Style Interface"
VersionText.TextColor3 = Color3.fromRGB(150, 150, 180)
VersionText.Font = Enum.Font.Gotham
VersionText.TextSize = 12
VersionText.BackgroundTransparency = 1

print("[SHELBY] Лаунчер успешно загружен!")
```
