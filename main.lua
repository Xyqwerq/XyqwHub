-- ========== XyqwHub - Версия 4.0 ==========
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "XyqwHub",
    Text = "XyqwHub Loading...",
    Duration = 3
})
print("[XyqwHub] Loading...")

-- ========== ЗАЩИТА ОТ ПОВТОРНОГО ЗАПУСКА ==========
if getgenv().XyqwHubRunning then
    local msg = "Повторный запуск скрипта был заблокирован!"
    if getgenv().XyqwLanguage == "EN" then
        msg = "Script re-launch has been blocked!"
    end
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "XyqwHub",
        Text = msg,
        Duration = 5
    })
    print("[XyqwHub] " .. msg)
    return
end

getgenv().XyqwHubRunning = true

-- ========== ВЕРСИЯ ==========
local VERSION = "4.0"

-- ========== USER ID ==========
local OWNER_IDS = {
    4396977722,
    8527910367
}

local BETA_IDS = {
    9686718765,
    3701387385
}

-- ========== ЯЗЫК ==========
if getgenv().XyqwLanguage == nil then
    getgenv().XyqwLanguage = "EN"
end

-- ========== ТЕМА ==========
if getgenv().XyqwTheme == nil then
    getgenv().XyqwTheme = "Red"
end

-- ========== FAVORITES / RECENT / HISTORY ==========
if getgenv().XyqwFavorites == nil then
    getgenv().XyqwFavorites = {}
end

if getgenv().XyqwRecent == nil then
    getgenv().XyqwRecent = {}
end

if getgenv().XyqwHistory == nil then
    getgenv().XyqwHistory = {}
end

-- ========== ТЕМЫ ==========
local THEMES = {
    Red = {
        Main = Color3.fromRGB(200, 0, 0),
        Dark = Color3.fromRGB(60, 0, 0),
        Background = Color3.fromRGB(0, 0, 0),
        Title = Color3.fromRGB(20, 0, 0),
        Text = Color3.fromRGB(255, 0, 0)
    },
    Purple = {
        Main = Color3.fromRGB(150, 0, 200),
        Dark = Color3.fromRGB(60, 0, 80),
        Background = Color3.fromRGB(0, 0, 0),
        Title = Color3.fromRGB(20, 0, 30),
        Text = Color3.fromRGB(200, 0, 255)
    },
    Blue = {
        Main = Color3.fromRGB(0, 100, 200),
        Dark = Color3.fromRGB(0, 40, 80),
        Background = Color3.fromRGB(0, 0, 0),
        Title = Color3.fromRGB(0, 15, 30),
        Text = Color3.fromRGB(0, 150, 255)
    },
    Green = {
        Main = Color3.fromRGB(0, 200, 80),
        Dark = Color3.fromRGB(0, 80, 30),
        Background = Color3.fromRGB(0, 0, 0),
        Title = Color3.fromRGB(0, 30, 15),
        Text = Color3.fromRGB(0, 255, 100)
    }
}

local function GetTheme()
    return THEMES[getgenv().XyqwTheme] or THEMES.Red
end

-- ========== ТЕКСТЫ ==========
local LANG = {
    EN = {
        WindowTitle = "XyqwHub",
        DockText = "XyqwHub",
        LangButton = "EN",
        ChangeLogBtn = "ChangeLog",
        RemoveTagBtn = "Remove XyqwHub Tag",
        Loaded = "loaded",
        Error = "error",
        Failed = "failed to load",
        WalkOnWalls = "To reset Walk on walls, rejoin the server",
        WalkOnWallsBottom = "Script should be loaded",
        AetherX = "This script is outdated. Some features may not work",
        AetherXBottom = "Script should be loaded",
        BC9 = "This script is weak, but it can bring you fun :)",
        BC9Bottom = "Script loaded",
        DoorsV2 = "Sorry, Doors V2 cannot be run using XyqwHub",
        DoorsV2Bottom = "Script copied to clipboard. Paste it into your executor",
        Beta = "Script in beta",
        BetaBottom = "Script should be loaded",
        Destroy = "XyqwHub DESTROYED",
        LangChanged = "Language changed to English",
        DeathOrder = "Simon Says script loaded",
        DeathOrderBottom = "Have fun!",
        CheesyKey = "Key: joincheesydsc",
        CheesyBottom = "Script should be loaded",
        CopyFailed = "Failed to copy! Please copy manually",
        TagRemoved = "XyqwHub tag has been removed!",
        OwnerWelcome = "Welcome, my father :3",
        BetaWelcome = "Glad you're here, tester ♡",
        ScriptExecuted = "Script executed!",
        Search = "Search...",
        Favorites = "Favorites",
        RecentlyUsed = "Recently Used",
        CustomScript = "Custom Script",
        CustomPlaceholder = "Paste URL here...",
        RunCustom = "Run",
        PlayerList = "Player List",
        ServerInfo = "Server Info",
        Theme = "Theme",
        AntiAFK = "Anti-AFK",
        JobIdCopied = "JobId copied!",
        ChangeLogTitle = "ChangeLog",
        ChangeLogText = [[XyqwHub ChangeLog

Version 4.0
- Top bar with executor, name, FPS, Ping
- Search bar
- Tabs (All, Blade Ball, MM2, INK, Misc, Favorites, Recent)
- Favorites system
- Recently used
- Script history
- Theme switcher (Red, Purple, Blue, Green)
- Custom script runner
- Player list
- Server info
- Copy JobId
- Animations
- Keybinds
- Anti-AFK

Version 3.9
- Added Script executed notification
- Added Doors v4
- Added Kiti (MM2)

Version 3.8
- Fixed tag not restoring after respawn

Version 3.7
- Added tester tag (blue gradient)

Version 3.6
- Fixed accidental button clicks

Version 3.5
- Added owner welcome message

Version 3.4
- Darker red tag

Version 3.3
- Fixed tag size and gradient

Version 3.2
- Gradient animation

Version 3.1
- Rewrote tag system

Version 3.0
- Removed gradient

Version 2.9
- Added XyqwHub OWNER tag

Version 2.8
- XyqwHub Loaded appears immediately

Version 2.7
- Roblox notifications

Version 2.6
- Notifications bottom right

Version 2.5
- EN/RU translation

Version 2.4
- Re-launch protection

Version 2.3
- Adopt me

Version 2.2
- bLockman, Cheating

Version 2.1
- DropKick, Evade, A Dusty Trip

Version 2.0
- Removed Auto Execute

Version 1.9
- Doors V3 key

Version 1.8
- Death Order, CandyWare

Version 1.7
- Troll script

Version 1.6
- Steal an egg, Universal, Corridor

Version 1.5
- EN/RU hint

Version 1.4
- Hint in welcome

Version 1.3
- Hint after welcome

Version 1.2
- Fixed lang button

Version 1.1
- Language change

Version 1.0
- First release]]
    },
    RU = {
        WindowTitle = "XyqwHub",
        DockText = "XyqwHub",
        LangButton = "RU",
        ChangeLogBtn = "Ченджлог",
        RemoveTagBtn = "Убрать тег XyqwHub",
        Loaded = "загружен",
        Error = "ошибка",
        Failed = "не удалось загрузить",
        WalkOnWalls = "Чтобы сбросить Walk on walls, перезайдите на сервер",
        WalkOnWallsBottom = "Скрипт должен запуститься",
        AetherX = "Этот скрипт устарел. Некоторые функции могут не работать",
        AetherXBottom = "Скрипт должен запуститься",
        BC9 = "Этот скрипт слабый, но он может принести вам веселье :)",
        BC9Bottom = "Скрипт загружен",
        DoorsV2 = "Извините, Doors V2 не может запуститься с помощью XyqwHub",
        DoorsV2Bottom = "Скрипт скопирован в буфер обмена. Вставьте его в свой executor",
        Beta = "Скрипт в бете",
        BetaBottom = "Скрипт должен запуститься",
        Destroy = "XyqwHub УНИЧТОЖЕН",
        LangChanged = "Язык изменён на Русский",
        DeathOrder = "Скрипт Simon Says загружен",
        DeathOrderBottom = "Приятной игры!",
        CheesyKey = "Ключ: joincheesydsc",
        CheesyBottom = "Скрипт должен запуститься",
        CopyFailed = "Не удалось скопировать! Скопируйте вручную",
        TagRemoved = "Тег XyqwHub был удалён!",
        OwnerWelcome = "Welcome, my father :3",
        BetaWelcome = "Glad you're here, tester ♡",
        ScriptExecuted = "Скрипт выполнен!",
        Search = "Поиск...",
        Favorites = "Избранное",
        RecentlyUsed = "Недавние",
        CustomScript = "Свой скрипт",
        CustomPlaceholder = "Вставьте ссылку...",
        RunCustom = "Запустить",
        PlayerList = "Список игроков",
        ServerInfo = "Инфо о сервере",
        Theme = "Тема",
        AntiAFK = "Анти-АФК",
        JobIdCopied = "JobId скопирован!",
        ChangeLogTitle = "Ченджлог",
        ChangeLogText = [[XyqwHub Ченджлог

Версия 4.0
- Верхняя панель: executor, ник, FPS, Ping
- Поиск
- Вкладки (All, Blade Ball, MM2, INK, Misc, Favorites, Recent)
- Избранное
- Недавние
- История скриптов
- Темы (Red, Purple, Blue, Green)
- Свой скрипт
- Список игроков
- Инфо о сервере
- Копировать JobId
- Анимации
- Кейбинды
- Анти-АФК

Версия 3.9
- Добавлено сообщение Script executed
- Добавлен Doors v4
- Добавлен Kiti (MM2)

Версия 3.8
- Исправлено восстановление тега после респавна

Версия 3.7
- Добавлен тег тестера (синий градиент)

Версия 3.6
- Исправлены случайные нажатия

Версия 3.5
- Добавлено приветствие овнеров

Версия 3.4
- Насыщенный красный тег

Версия 3.3
- Исправлен размер и градиент

Версия 3.2
- Градиентная анимация

Версия 3.1
- Переписана система тегов

Версия 3.0
- Убран градиент

Версия 2.9
- Добавлен тег OWNER

Версия 2.8
- Loaded появляется сразу

Версия 2.7
- Уведомления Roblox

Версия 2.6
- Уведомления справа снизу

Версия 2.5
- Перевод EN/RU

Версия 2.4
- Защита от повторного запуска

Версия 2.3
- Adopt me

Версия 2.2
- bLockman, Cheating

Версия 2.1
- DropKick, Evade, A Dusty Trip

Версия 2.0
- Убран Auto Execute

Версия 1.9
- Ключ Doors V3

Версия 1.8
- Death Order, CandyWare

Версия 1.7
- Troll script

Версия 1.6
- Steal an egg, Universal, Corridor

Версия 1.5
- Подсказка EN/RU

Версия 1.4
- Подсказка в приветствии

Версия 1.3
- Подсказка после приветствия

Версия 1.2
- Исправлена кнопка языка

Версия 1.1
- Смена языка

Версия 1.0
- Первый релиз]]
    }
}

-- ========== ФУНКЦИЯ ТЕКСТА ==========
local function _(key)
    local lang = getgenv().XyqwLanguage or "EN"
    return LANG[lang][key] or key
end

-- ========== УВЕДОМЛЕНИЯ ROBLOX ==========
local function ShowRobloxNotification(text, duration)
    duration = duration or 3.5
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "XyqwHub",
            Text = text,
            Duration = duration
        })
    end)
    
end
-- ========== ПРОВЕРКА РОЛИ ==========
local function IsLocalPlayerOwner()
    local LocalPlayer = game:GetService("Players").LocalPlayer
    for _, id in ipairs(OWNER_IDS) do
        if LocalPlayer.UserId == id then
            return true
        end
    end
    return false
end

local function IsLocalPlayerBeta()
    local LocalPlayer = game:GetService("Players").LocalPlayer
    for _, id in ipairs(BETA_IDS) do
        if LocalPlayer.UserId == id then
            return true
        end
    end
    return false
end

if IsLocalPlayerOwner() then
    task.wait(0.5)
    ShowRobloxNotification(_("OwnerWelcome"), 5)
    print("[XyqwHub] " .. _("OwnerWelcome"))
elseif IsLocalPlayerBeta() then
    task.wait(0.5)
    ShowRobloxNotification(_("BetaWelcome"), 5)
    print("[XyqwHub] " .. _("BetaWelcome"))
end

-- ========== СИСТЕМА ТЕГОВ ==========
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local tagsEnabled = true
local activeTags = {}

local function GetRole(plr)
    for _, id in ipairs(OWNER_IDS) do
        if plr.UserId == id then
            return "OWNER"
        end
    end
    for _, id in ipairs(BETA_IDS) do
        if plr.UserId == id then
            return "TESTER"
        end
    end
    return nil
end

local function CreateTagForPlayer(plr)
    if not tagsEnabled then return end
    local role = GetRole(plr)
    if not role then return end
    if activeTags[plr] and activeTags[plr].Parent then return end

    local char = plr.Character
    if not char then return end

    local rootPart = char:FindFirstChild("HumanoidRootPart")
    if not rootPart then return end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "XyqwTag"
    billboard.Size = UDim2.new(0, 160, 0, 20)
    billboard.StudsOffset = Vector3.new(0, 4, 0)
    billboard.AlwaysOnTop = true
    billboard.LightInfluence = 0
    billboard.MaxDistance = 500
    billboard.Adornee = rootPart
    billboard.Parent = char

    local label = Instance.new("TextLabel")
    label.Name = "XyqwLabel"
    label.Size = UDim2.new(0, 150, 0, 18)
    label.Position = UDim2.new(0.5, -75, 0.5, -9)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.GothamBold
    label.TextSize = 14
    label.TextScaled = false
    label.TextWrapped = false
    label.TextStrokeTransparency = 0
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    label.Parent = billboard

    local gradient = Instance.new("UIGradient")
    if role == "OWNER" then
        label.Text = "XyqwHub OWNER"
        gradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 0, 0)),
            ColorSequenceKeypoint.new(0.25, Color3.fromRGB(60, 0, 0)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(200, 0, 0)),
            ColorSequenceKeypoint.new(0.75, Color3.fromRGB(60, 0, 0)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 0, 0))
        })
    else
        label.Text = "XyqwHub Tester"
        gradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 120, 255)),
            ColorSequenceKeypoint.new(0.25, Color3.fromRGB(10, 20, 60)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(50, 120, 255)),
            ColorSequenceKeypoint.new(0.75, Color3.fromRGB(10, 20, 60)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 120, 255))
        })
    end
    gradient.Rotation = 0
    gradient.Parent = label

    local glow = Instance.new("UIStroke")
    if role == "OWNER" then
        glow.Color = Color3.fromRGB(255, 0, 0)
    else
        glow.Color = Color3.fromRGB(50, 120, 255)
    end
    glow.Thickness = 1
    glow.Transparency = 0.3
    glow.Parent = label

    task.spawn(function()
        local rotation = 0
        while label.Parent and tagsEnabled do
            rotation = (rotation + 2) % 360
            gradient.Rotation = rotation
            task.wait(0.03)
        end
    end)

    activeTags[plr] = billboard
end

local function RemoveTagForPlayer(plr)
    if activeTags[plr] then
        activeTags[plr]:Destroy()
        activeTags[plr] = nil
    end
end

local function RemoveAllTags()
    tagsEnabled = false
    for plr, tag in pairs(activeTags) do
        if tag then tag:Destroy() end
    end
    activeTags = {}
end

local function CheckAllPlayers()
    if not tagsEnabled then return end
    for _, plr in ipairs(Players:GetPlayers()) do
        if GetRole(plr) and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            CreateTagForPlayer(plr)
        end
    end
end

local function SetupCharacterTag(plr)
    task.spawn(function()
        local char = plr.Character or plr.CharacterAdded:Wait()
        local rootPart = char:WaitForChild("HumanoidRootPart", 5)
        if not rootPart then return end
        local oldTag = char:FindFirstChild("XyqwTag")
        if oldTag then oldTag:Destroy() end
        activeTags[plr] = nil
        task.wait(0.5)
        if GetRole(plr) then
            CreateTagForPlayer(plr)
        end
    end)
end

CheckAllPlayers()

local heartbeatConn
heartbeatConn = RunService.Heartbeat:Connect(function()
    if not tagsEnabled then
        if heartbeatConn then heartbeatConn:Disconnect() end
        return
    end
    CheckAllPlayers()
end)

Players.PlayerAdded:Connect(function(plr)
    SetupCharacterTag(plr)
    plr.CharacterAdded:Connect(function()
        SetupCharacterTag(plr)
    end)
end)

Players.PlayerRemoving:Connect(function(plr)
    RemoveTagForPlayer(plr)
end)

for _, plr in ipairs(Players:GetPlayers()) do
    SetupCharacterTag(plr)
    plr.CharacterAdded:Connect(function()
        SetupCharacterTag(plr)
    end)
end
-- ========== АНТИ-АФК ==========
local VirtualUser = game:GetService("VirtualUser")
local antiAfkEnabled = true

local function StartAntiAFK()
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        if antiAfkEnabled then
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end
    end)
end

StartAntiAFK()

-- ========== FPS / PING ==========
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")

local fpsValue = 0
local fpsCounter = 0
local fpsTime = 0

RunService.RenderStepped:Connect(function(dt)
    fpsCounter = fpsCounter + 1
    fpsTime = fpsTime + dt
    if fpsTime >= 1 then
        fpsValue = fpsCounter
        fpsCounter = 0
        fpsTime = 0
    end
end)

local function GetPing()
    local ok, ping = pcall(function()
        return math.floor(game:GetService("Players").LocalPlayer:GetNetworkPing() * 1000)
    end)
    return ok and ping or 0
end

-- ========== ИМЯ EXECUTOR ==========
local function GetExecutorName()
    local ok, name = pcall(function()
        if identifyexecutor then
            local n = identifyexecutor()
            return n
        end
        return "Unknown"
    end)
    return ok and name or "Unknown"
end

-- ========== GUI ==========
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "XyqwHubGui"
screenGui.Parent = game:GetService("CoreGui")

-- ВЕРХНЯЯ ПАНЕЛЬ
local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(0, 500, 0, 25)
topBar.Position = UDim2.new(0.5, -250, 0, 10)
topBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
topBar.BorderSizePixel = 2
topBar.BorderColor3 = GetTheme().Main
topBar.Parent = screenGui

local topBarCorner = Instance.new("UICorner")
topBarCorner.CornerRadius = UDim.new(0, 6)
topBarCorner.Parent = topBar

local topBarText = Instance.new("TextLabel")
topBarText.Name = "TopBarText"
topBarText.Size = UDim2.new(1, 0, 1, 0)
topBarText.Position = UDim2.new(0, 0, 0, 0)
topBarText.BackgroundTransparency = 1
topBarText.Font = Enum.Font.GothamBold
topBarText.TextSize = 12
topBarText.TextColor3 = GetTheme().Text
topBarText.Text = "Loading..."
topBarText.Parent = topBar

task.spawn(function()
    while topBarText.Parent do
        topBarText.Text = string.format("%s  |  %s  |  FPS: %d  |  Ping: %d ms",
            GetExecutorName(),
            game:GetService("Players").LocalPlayer.Name,
            fpsValue,
            GetPing()
        )
        task.wait(1)
    end
end)

-- ДОК-КНОПКА
local dockButton = Instance.new("TextButton")
dockButton.Name = "DockButton"
dockButton.Size = UDim2.new(0, 90, 0, 30)
dockButton.Position = UDim2.new(0.5, -45, 0.05, 45)
dockButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
dockButton.TextColor3 = GetTheme().Text
dockButton.Text = "XyqwHub"
dockButton.TextScaled = true
dockButton.Font = Enum.Font.GothamBold
dockButton.BorderSizePixel = 2
dockButton.BorderColor3 = GetTheme().Main
dockButton.Parent = screenGui
dockButton.Visible = false
dockButton.AutoButtonColor = false

local dockCorner = Instance.new("UICorner")
dockCorner.CornerRadius = UDim.new(0, 6)
dockCorner.Parent = dockButton

-- ГЛАВНОЕ ОКНО
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 380, 0, 480)
mainFrame.Position = UDim2.new(0.5, -190, 0.5, -240)
mainFrame.BackgroundColor3 = GetTheme().Background
mainFrame.BorderSizePixel = 3
mainFrame.BorderColor3 = GetTheme().Main
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 8)
mainCorner.Parent = mainFrame

-- ЗАГОЛОВОК
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.BackgroundColor3 = GetTheme().Title
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(0.4, 0, 1, 0)
titleLabel.Position = UDim2.new(0, 5, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "XyqwHub"
titleLabel.TextColor3 = GetTheme().Text
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = titleBar

-- Кнопка темы
local themeButton = Instance.new("TextButton")
themeButton.Name = "ThemeButton"
themeButton.Size = UDim2.new(0, 60, 0.8, 0)
themeButton.Position = UDim2.new(0.4, 5, 0.1, 0)
themeButton.BackgroundColor3 = GetTheme().Dark
themeButton.TextColor3 = Color3.fromRGB(255, 200, 0)
themeButton.Text = "Theme"
themeButton.TextScaled = true
themeButton.Font = Enum.Font.GothamBold
themeButton.BorderSizePixel = 1
themeButton.BorderColor3 = GetTheme().Main
themeButton.Parent = titleBar
themeButton.AutoButtonColor = false
themeButton.Active = true

-- Кнопка ChangeLog
local changelogButton = Instance.new("TextButton")
changelogButton.Name = "ChangelogButton"
changelogButton.Size = UDim2.new(0, 60, 0.8, 0)
changelogButton.Position = UDim2.new(0.4, 70, 0.1, 0)
changelogButton.BackgroundColor3 = GetTheme().Dark
changelogButton.TextColor3 = Color3.fromRGB(255, 200, 0)
changelogButton.Text = _("ChangeLogBtn")
changelogButton.TextScaled = true
changelogButton.Font = Enum.Font.GothamBold
changelogButton.BorderSizePixel = 1
changelogButton.BorderColor3 = GetTheme().Main
changelogButton.Parent = titleBar
changelogButton.AutoButtonColor = false
changelogButton.Active = true

-- Кнопка языка
local langButton = Instance.new("TextButton")
langButton.Name = "LangButton"
langButton.Size = UDim2.new(0, 35, 1, 0)
langButton.Position = UDim2.new(1, -65, 0, 0)
langButton.BackgroundTransparency = 1
langButton.Text = getgenv().XyqwLanguage
langButton.TextColor3 = Color3.fromRGB(255, 200, 0)
langButton.TextScaled = true
langButton.Font = Enum.Font.GothamBold
langButton.Parent = titleBar
langButton.AutoButtonColor = false
langButton.Active = true

-- Крестик
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 30, 1, 0)
closeButton.Position = UDim2.new(1, -30, 0, 0)
closeButton.BackgroundTransparency = 1
closeButton.Text = "X"
closeButton.TextColor3 = GetTheme().Text
closeButton.TextScaled = true
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = titleBar
closeButton.AutoButtonColor = false
closeButton.Active = true

-- SEARCH BAR
local searchBar = Instance.new("Frame")
searchBar.Name = "SearchBar"
searchBar.Size = UDim2.new(1, -10, 0, 28)
searchBar.Position = UDim2.new(0, 5, 0, 35)
searchBar.BackgroundColor3 = GetTheme().Dark
searchBar.BorderSizePixel = 1
searchBar.BorderColor3 = GetTheme().Main
searchBar.Parent = mainFrame

local searchCorner = Instance.new("UICorner")
searchCorner.CornerRadius = UDim.new(0, 6)
searchCorner.Parent = searchBar

local searchBox = Instance.new("TextBox")
searchBox.Name = "SearchBox"
searchBox.Size = UDim2.new(1, -10, 1, 0)
searchBox.Position = UDim2.new(0, 5, 0, 0)
searchBox.BackgroundTransparency = 1
searchBox.PlaceholderText = _("Search")
searchBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
searchBox.Text = ""
searchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
searchBox.TextSize = 14
searchBox.Font = Enum.Font.Gotham
searchBox.TextXAlignment = Enum.TextXAlignment.Left
searchBox.ClearTextOnFocus = false
searchBox.Parent = searchBar

-- TABS
local tabBar = Instance.new("Frame")
tabBar.Name = "TabBar"
tabBar.Size = UDim2.new(1, -10, 0, 28)
tabBar.Position = UDim2.new(0, 5, 0, 68)
tabBar.BackgroundTransparency = 1
tabBar.Parent = mainFrame

local tabList = {"All", "BladeBall", "MM2", "INK", "Misc", "Fav", "Recent"}
local tabButtons = {}
local currentTab = "All"

local function SwitchTab(tabName)
    currentTab = tabName
    for name, btn in pairs(tabButtons) do
        if name == tabName then
            btn.BackgroundColor3 = GetTheme().Main
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        else
            btn.BackgroundColor3 = GetTheme().Dark
            btn.TextColor3 = GetTheme().Text
        end
    end
    if RefreshButtons then RefreshButtons() end
end

local tabX = 0
for _, tabName in ipairs(tabList) do
    local tabBtn = Instance.new("TextButton")
    tabBtn.Name = tabName
    tabBtn.Size = UDim2.new(0, 50, 1, 0)
    tabBtn.Position = UDim2.new(0, tabX, 0, 0)
    tabBtn.BackgroundColor3 = GetTheme().Dark
    tabBtn.TextColor3 = GetTheme().Text
    tabBtn.Text = tabName
    tabBtn.TextScaled = true
    tabBtn.Font = Enum.Font.GothamBold
    tabBtn.BorderSizePixel = 1
    tabBtn.BorderColor3 = GetTheme().Main
    tabBtn.Parent = tabBar
    tabBtn.AutoButtonColor = false
    tabButtons[tabName] = tabBtn
    tabBtn.MouseButton1Click:Connect(function()
        SwitchTab(tabName)
    end)
    tabX = tabX + 52
end

-- SCROLL FRAME ДЛЯ КНОПОК
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Name = "ScrollFrame"
scrollFrame.Size = UDim2.new(1, -10, 1, -140)
scrollFrame.Position = UDim2.new(0, 5, 0, 100)
scrollFrame.BackgroundTransparency = 1
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.ScrollBarThickness = 4
scrollFrame.ScrollBarImageColor3 = GetTheme().Main
scrollFrame.Parent = mainFrame
-- ========== ГЕНЕРАЦИЯ КНОПОК СКРИПТОВ ==========
local SCRIPTS = {
    -- Формат: {Name = "Название", Category = "Категория", URL = "ссылка"}
    {Name = "Blade Ball", Category = "BladeBall", URL = "https://raw.githubusercontent.com/joshhhie/rise/refs/heads/main/loader.lua"},
    {Name = "Blade Ball 2", Category = "BladeBall", URL = "https://wings.ac/loader"},
    {Name = "Blade Ball 3", Category = "BladeBall", URL = "https://raw.githubusercontent.com/2xrW/return/refs/heads/main/hub"},
    {Name = "AntiKillParts", Category = "Misc", URL = "https://raw.githubusercontent.com/sovetskii-shashlik/Anti-kill-parts-updated-/refs/heads/main/Anti%20kill%20parts%20by%20Zephyr"},
    {Name = "PulseHub", Category = "Misc", URL = "https://raw.githubusercontent.com/PulseZax/Loader/refs/heads/main/.lua"},
    {Name = "RUNAWAYS", Category = "Misc", URL = "https://raw.githubusercontent.com/Bac0nHck/Scripts/refs/heads/main/RUNAWAYS.lua"},
    {Name = "Universal FE", Category = "Misc", URL = "https://rawscripts.net/raw/Universal-Script-Universal-FE-Free-keyless-FE-script-242513"},
    {Name = "UwU hub", Category = "INK", URL = "https://raw.githubusercontent.com/platinww/UwU/refs/heads/main/INK-GAME"},
    {Name = "Ringta (INK)", Category = "INK", URL = "https://rawscripts.net/raw/Universal-Script-RINGTA-best-script-for-ink-game-206674"},
    {Name = "AX Scripts (INK)", Category = "INK", URL = "https://officialaxscripts.vercel.app/scripts/AX-Loader.lua"},
    {Name = "FakeVR", Category = "Misc", URL = "https://pastefy.app/MvKHpycG/raw"},
    {Name = "WallHop", Category = "Misc", URL = "https://raw.githubusercontent.com/ScpGuest666/Random-Roblox-script/refs/heads/main/Roblox%20WallHop%20script"},
    {Name = "RuzHub (MM2)", Category = "MM2", URL = "https://raw.githubusercontent.com/pruzgar242-rgb/Update/refs/heads/main/out.lua%20(17).txt"},
    {Name = "RemainsHub V2", Category = "Misc", URL = "https://rawscripts.net/raw/Universal-Script-RemainsHub-V2-50805"},
    {Name = "R6 Emotes", Category = "Misc", URL = "https://rawscripts.net/raw/Universal-Script-r6-emotes-OPEN-SOURCE-69464"},
    {Name = "Jujutsu Sheninagouns", Category = "Misc", URL = "https://raw.githubusercontent.com/peeky-co/scripts/refs/heads/main/tbo"},
    {Name = "Free Cam", Category = "Misc", URL = "https://rawscripts.net/raw/Universal-Script-Free-cam-script-pc-and-mobile-223089"},
    {Name = "Doors (Abysall)", Category = "Misc", URL = "https://rawscripts.net/raw/DOORS-Abysall-hub-OP-205906"},
    {Name = "Fling Gui", Category = "Misc", URL = "https://rawscripts.net/raw/Universal-Script-fling-gui-99753"},
    {Name = "Infinite Yield", Category = "Misc", URL = "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"},
    {Name = "Walk on walls", Category = "Misc", URL = "https://rawscripts.net/raw/The-patience-obby-Universal-Walk-on-walls-18129"},
    {Name = "AetherX (Death Penalty)", Category = "Misc", URL = "https://api.luarmor.net/files/v3/loaders/8c08b8f2252eec7dbb77d253d269bb65.lua"},
    {Name = "Voidware", Category = "Misc", URL = "https://files.vapevoidware.xyz/VapeVoidware/VW-Add/main/loader.lua"},
    {Name = "LaLol Hub", Category = "Misc", URL = "https://raw.githubusercontent.com/Miygteet/Hacker101/refs/heads/main/LALOL-Backdoor-Secure.lua"},
    {Name = "FTAP", Category = "Misc", URL = "https://api.jnkie.com/api/v1/luascripts/public/4078649e4397f0e2cdaddde241d69bfd67b2b7107917891384735129c85cae18/download"},
    {Name = "MinhNat Hub (TSB)", Category = "Misc", URL = "https://rawscripts.net/raw/Universal-Script-MinhNhat-Tsb-62161"},
    {Name = "BC9 (UTG)", Category = "Misc", URL = "https://rawscripts.net/raw/untitled-tag-game-BC9-UTG-MENU-116806"},
    {Name = "FTAP (WITH KEY)", Category = "Misc", URL = "https://raw.githubusercontent.com/BlizTBr/scripts/main/FTAP.lua"},
    {Name = "RadiumHub (Pressure)", Category = "Misc", URL = "https://rawscripts.net/raw/UPDATE-Pressure-God-Mode-Auto-Loot-ESP-Full-Bright-No-Eyefestation-224409"},
    {Name = "Steal an egg", Category = "Misc", URL = "https://raw.githubusercontent.com/joustingmatch/Ouroboros/main/loader.lua"},
    {Name = "Universal script", Category = "Misc", URL = "https://raw.githubusercontent.com/fleecelolll/Fleece-s-Utility-Panel/refs/heads/main/Script.lua"},
    {Name = "Corridor", Category = "Misc", URL = "https://saga2015.b-cdn.net/corridor.luau"},
    {Name = "BloxStrike", Category = "Misc", URL = "https://raw.githubusercontent.com/Bac0nHck/Scripts/refs/heads/main/BloxStrike.lua"},
    {Name = "RIVALS", Category = "Misc", URL = "https://raw.githubusercontent.com/imshrak/rivals/refs/heads/main/main"},
    {Name = "Troll script", Category = "Misc", URL = "https://mois7.xyz/loader"},
    {Name = "Death Order [SIMON]", Category = "Misc", URL = "https://rawscripts.net/raw/Death-Order:-Simon-Says-BEST-DEATH-ORDER-SCRIPT-226542"},
    {Name = "CandyWare (MM2)", Category = "MM2", URL = "https://raw.githubusercontent.com/Be1for/Scripts/refs/heads/main/candyware.luau"},
    {Name = "Kiti (MM2)", Category = "MM2", URL = "https://pastefy.app/gPuS4n3Q/raw"},
    {Name = "DropKick", Category = "Misc", URL = "https://raw.githubusercontent.com/yes-d3v-scripts/drop-kick-fling/refs/heads/main/script"},
    {Name = "Evade", Category = "Misc", URL = "https://github.com/imc72s/LaztDex/raw/refs/heads/main/EvadeScriptLaztDex"},
    {Name = "A dusty trip", Category = "Misc", URL = "https://raw.githubusercontent.com/BalintTheDevXBack/Games/refs/heads/main/aDustyTrip"},
    {Name = "A dusty trip v2", Category = "Misc", URL = "https://raw.githubusercontent.com/VoxlarWIP/Src/refs/heads/main/adustytrip.lua"},
    {Name = "bLockman's minesweaper", Category = "Misc", URL = "https://pastefy.app/T5XIfiMo/raw"},
    {Name = "Cheating during test", Category = "Misc", URL = "https://files.catbox.moe/pkulzc.txt"},
    {Name = "Adopt me", Category = "Misc", URL = "https://raw.githubusercontent.com/JaxRol/ZeroPoint/refs/heads/main/KeySystem"},
    {Name = "Doors v4", Category = "Misc", URL = "https://raw.githubusercontent.com/sillyleo67/Doors/refs/heads/main/Twinkhook.lua"},
}

-- ========== ПЕРЕМЕННЫЕ ==========
local buttons = {}  -- {Btn = buttonInstance, Data = data}
local y = 5
local buttonHeight = 42

-- ========== ФУНКЦИЯ СОЗДАНИЯ КНОПКИ ==========
local function CreateScriptButton(data)
    local btn = Instance.new("TextButton")
    btn.Name = "Script_" .. data.Name
    btn.Size = UDim2.new(1, -35, 0, 40)
    btn.Position = UDim2.new(0, 5, 0, 0)
    btn.BackgroundColor3 = GetTheme().Dark
    btn.TextColor3 = GetTheme().Text
    btn.Text = data.Name
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 2
    btn.BorderColor3 = GetTheme().Main
    btn.Parent = scrollFrame
    btn.AutoButtonColor = false
    btn.Visible = true

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn

    -- Звёздочка (Favorites)
    local star = Instance.new("TextButton")
    star.Name = "Star"
    star.Size = UDim2.new(0, 30, 1, 0)
    star.Position = UDim2.new(1, 0, 0, 0)
    star.BackgroundColor3 = GetTheme().Background
    star.TextColor3 = Color3.fromRGB(255, 200, 0)
    star.Text = "☆"
    star.TextScaled = true
    star.Font = Enum.Font.GothamBold
    star.BorderSizePixel = 1
    star.BorderColor3 = GetTheme().Main
    star.Parent = btn
    star.AutoButtonColor = false

    local function UpdateStar()
        if getgenv().XyqwFavorites[data.Name] then
            star.Text = "★"
        else
            star.Text = "☆"
        end
    end

    UpdateStar()

    star.MouseButton1Click:Connect(function()
        if getgenv().XyqwFavorites[data.Name] then
            getgenv().XyqwFavorites[data.Name] = nil
        else
            getgenv().XyqwFavorites[data.Name] = true
        end
        UpdateStar()
    end)

    -- Клик на кнопку = запуск скрипта
    local isRunning = false
    local lastRun = 0

    btn.MouseEnter:Connect(function()
        if not isRunning then
            btn.BackgroundColor3 = GetTheme().Main
        end
    end)

    btn.MouseLeave:Connect(function()
        if not isRunning then
            btn.BackgroundColor3 = GetTheme().Dark
        end
    end)

    btn.MouseButton1Click:Connect(function()
        if isRunning then return end
        local now = tick()
        if now - lastRun < 1.5 then return end
        lastRun = now
        isRunning = true

        btn.BackgroundColor3 = GetTheme().Main

        -- Добавляем в недавние
        local found = false
        for i, name in ipairs(getgenv().XyqwRecent) do
            if name == data.Name then
                table.remove(getgenv().XyqwRecent, i)
                found = true
                break
            end
        end
        table.insert(getgenv().XyqwRecent, 1, data.Name)
        if #getgenv().XyqwRecent > 10 then
            table.remove(getgenv().XyqwRecent)
        end

        -- Добавляем в историю
        table.insert(getgenv().XyqwHistory, 1, data.Name .. " - " .. os.date("%H:%M:%S"))
        if #getgenv().XyqwHistory > 50 then
            table.remove(getgenv().XyqwHistory)
        end

        -- Запускаем
        print("[XyqwHub] " .. data.Name .. " - STARTING...")
        local success, err = pcall(function()
            loadstring(game:HttpGet(data.URL))()
        end)
        if success then
            print("[XyqwHub] " .. data.Name .. " - " .. _("Loaded") .. "!")
            ShowRobloxNotification(data.Name .. " - " .. _("ScriptExecuted"), 3)
        else
            print("[XyqwHub] " .. data.Name .. " - " .. _("Error") .. ": " .. tostring(err))
            ShowRobloxNotification(data.Name .. " - " .. _("Error") .. ": " .. tostring(err), 5)
        end

        task.wait(0.3)
        isRunning = false
        btn.BackgroundColor3 = GetTheme().Dark
    end)

    return btn
end

-- ========== ФИЛЬТРАЦИЯ + ПЕРЕРИСОВКА ==========
local function RefreshButtons()
    local search = string.lower(searchBox.Text)
    local visibleIndex = 0

    for _, entry in ipairs(buttons) do
        local data = entry.Data
        local btn = entry.Btn

        local show = true

        -- Фильтр по категории
        if currentTab == "Fav" then
            if not getgenv().XyqwFavorites[data.Name] then
                show = false
            end
        elseif currentTab == "Recent" then
            local found = false
            for _, name in ipairs(getgenv().XyqwRecent) do
                if name == data.Name then found = true break end
            end
            if not found then show = false end
        elseif currentTab ~= "All" then
            if data.Category ~= currentTab then
                show = false
            end
        end

        -- Фильтр по поиску
        if search ~= "" and not string.find(string.lower(data.Name), search, 1, true) then
            show = false
        end

        if show then
            btn.Visible = true
            btn.Position = UDim2.new(0, 5, 0, visibleIndex * buttonHeight + 5)
            visibleIndex = visibleIndex + 1
        else
            btn.Visible = false
        end
    end

    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, visibleIndex * buttonHeight + 20)
end

RefreshButtons = RefreshButtons

-- ========== СОЗДАНИЕ ВСЕХ КНОПОК ==========
for _, data in ipairs(SCRIPTS) do
    local btn = CreateScriptButton(data)
    table.insert(buttons, {Btn = btn, Data = data})
end

RefreshButtons()

-- ========== ПОИСК ==========
searchBox:GetPropertyChangedSignal("Text"):Connect(function()
    RefreshButtons()
end)
-- ========== CHANGE LOG ==========
local function ShowChangeLog()
    local frame = Instance.new("Frame")
    frame.Name = "ChangeLogFrame"
    frame.Size = UDim2.new(0, 400, 0, 350)
    frame.Position = UDim2.new(0.5, -200, 0.5, -175)
    frame.BackgroundColor3 = GetTheme().Background
    frame.BorderSizePixel = 2
    frame.BorderColor3 = GetTheme().Main
    frame.Parent = screenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -40, 0, 30)
    title.Position = UDim2.new(0, 5, 0, 5)
    title.BackgroundTransparency = 1
    title.TextColor3 = GetTheme().Text
    title.Text = _("ChangeLogTitle")
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = frame

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -35, 0, 0)
    closeBtn.BackgroundTransparency = 1
    closeBtn.Text = "X"
    closeBtn.TextColor3 = GetTheme().Text
    closeBtn.TextScaled = true
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Parent = frame
    closeBtn.AutoButtonColor = false

    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, -20, 1, -50)
    scroll.Position = UDim2.new(0, 10, 0, 40)
    scroll.BackgroundTransparency = 1
    scroll.CanvasSize = UDim2.new(0, 0, 0, 1700)
    scroll.ScrollBarThickness = 4
    scroll.ScrollBarImageColor3 = GetTheme().Main
    scroll.Parent = frame

    local text = Instance.new("TextLabel")
    text.Size = UDim2.new(1, -10, 0, 1690)
    text.Position = UDim2.new(0, 5, 0, 5)
    text.BackgroundTransparency = 1
    text.TextColor3 = Color3.fromRGB(255, 255, 255)
    text.TextWrapped = true
    text.TextXAlignment = Enum.TextXAlignment.Left
    text.TextYAlignment = Enum.TextYAlignment.Top
    text.TextSize = 14
    text.Font = Enum.Font.Gotham
    text.Text = _("ChangeLogText")
    text.Parent = scroll

    closeBtn.MouseButton1Click:Connect(function()
        frame:Destroy()
    end)
end

changelogButton.MouseButton1Click:Connect(ShowChangeLog)

-- ========== СМЕНА ТЕМЫ ==========
local THEME_LIST = {"Red", "Purple", "Blue", "Green"}
local themeIndex = 1
for i, name in ipairs(THEME_LIST) do
    if name == getgenv().XyqwTheme then themeIndex = i end
end

themeButton.MouseButton1Click:Connect(function()
    themeIndex = themeIndex + 1
    if themeIndex > #THEME_LIST then themeIndex = 1 end
    getgenv().XyqwTheme = THEME_LIST[themeIndex]
    ShowRobloxNotification(_("Theme") .. ": " .. getgenv().XyqwTheme, 2)
    -- Простое обновление цветов без перезагрузки
    topBar.BorderColor3 = GetTheme().Main
    topBarText.TextColor3 = GetTheme().Text
    dockButton.TextColor3 = GetTheme().Text
    dockButton.BorderColor3 = GetTheme().Main
    mainFrame.BorderColor3 = GetTheme().Main
    titleBar.BackgroundColor3 = GetTheme().Title
    titleLabel.TextColor3 = GetTheme().Text
    closeButton.TextColor3 = GetTheme().Text
    changelogButton.BorderColor3 = GetTheme().Main
    themeButton.BorderColor3 = GetTheme().Main
    searchBar.BackgroundColor3 = GetTheme().Dark
    searchBar.BorderColor3 = GetTheme().Main
    scrollFrame.ScrollBarImageColor3 = GetTheme().Main
    for name, btn in pairs(tabButtons) do
        if name == currentTab then
            btn.BackgroundColor3 = GetTheme().Main
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        else
            btn.BackgroundColor3 = GetTheme().Dark
            btn.TextColor3 = GetTheme().Text
        end
        btn.BorderColor3 = GetTheme().Main
    end
    for _, entry in ipairs(buttons) do
        entry.Btn.BackgroundColor3 = GetTheme().Dark
        entry.Btn.TextColor3 = GetTheme().Text
        entry.Btn.BorderColor3 = GetTheme().Main
        local star = entry.Btn:FindFirstChild("Star")
        if star then
            star.BorderColor3 = GetTheme().Main
            star.BackgroundColor3 = GetTheme().Background
        end
    end
end)

-- ========== СМЕНА ЯЗЫКА ==========
langButton.MouseButton1Click:Connect(function()
    if getgenv().XyqwLanguage == "EN" then
        getgenv().XyqwLanguage = "RU"
    else
        getgenv().XyqwLanguage = "EN"
    end
    langButton.Text = getgenv().XyqwLanguage
    changelogButton.Text = _("ChangeLogBtn")
    searchBox.PlaceholderText = _("Search")
    ShowRobloxNotification(_("LangChanged"), 2)
end)

-- ========== PLAYER LIST ==========
local function ShowPlayerList()
    local frame = Instance.new("Frame")
    frame.Name = "PlayerListFrame"
    frame.Size = UDim2.new(0, 350, 0, 400)
    frame.Position = UDim2.new(0.5, -175, 0.5, -200)
    frame.BackgroundColor3 = GetTheme().Background
    frame.BorderSizePixel = 2
    frame.BorderColor3 = GetTheme().Main
    frame.Parent = screenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -40, 0, 30)
    title.Position = UDim2.new(0, 5, 0, 5)
    title.BackgroundTransparency = 1
    title.TextColor3 = GetTheme().Text
    title.Text = _("PlayerList") .. " (" .. #Players:GetPlayers() .. ")"
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = frame

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -35, 0, 0)
    closeBtn.BackgroundTransparency = 1
    closeBtn.Text = "X"
    closeBtn.TextColor3 = GetTheme().Text
    closeBtn.TextScaled = true
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Parent = frame
    closeBtn.AutoButtonColor = false

    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, -20, 1, -50)
    scroll.Position = UDim2.new(0, 10, 0, 40)
    scroll.BackgroundTransparency = 1
    scroll.CanvasSize = UDim2.new(0, 0, 0, #Players:GetPlayers() * 25 + 10)
    scroll.ScrollBarThickness = 4
    scroll.ScrollBarImageColor3 = GetTheme().Main
    scroll.Parent = frame

    local yPos = 5
    for _, plr in ipairs(Players:GetPlayers()) do
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -10, 0, 22)
        label.Position = UDim2.new(0, 5, 0, yPos)
        label.BackgroundColor3 = GetTheme().Dark
        label.TextColor3 = GetTheme().Text
        label.Text = plr.Name .. " | ID: " .. plr.UserId .. " | Age: " .. plr.AccountAge .. "d"
        label.TextScaled = true
        label.Font = Enum.Font.Gotham
        label.BorderSizePixel = 1
        label.BorderColor3 = GetTheme().Main
        label.Parent = scroll
        yPos = yPos + 25
    end

    closeBtn.MouseButton1Click:Connect(function()
        frame:Destroy()
    end)
end

-- ========== SERVER INFO ==========
local function ShowServerInfo()
    local frame = Instance.new("Frame")
    frame.Name = "ServerInfoFrame"
    frame.Size = UDim2.new(0, 350, 0, 250)
    frame.Position = UDim2.new(0.5, -175, 0.5, -125)
    frame.BackgroundColor3 = GetTheme().Background
    frame.BorderSizePixel = 2
    frame.BorderColor3 = GetTheme().Main
    frame.Parent = screenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -40, 0, 30)
    title.Position = UDim2.new(0, 5, 0, 5)
    title.BackgroundTransparency = 1
    title.TextColor3 = GetTheme().Text
    title.Text = _("ServerInfo")
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = frame

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -35, 0, 0)
    closeBtn.BackgroundTransparency = 1
    closeBtn.Text = "X"
    closeBtn.TextColor3 = GetTheme().Text
    closeBtn.TextScaled = true
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Parent = frame
    closeBtn.AutoButtonColor = false

    local infoText = Instance.new("TextLabel")
    infoText.Size = UDim2.new(1, -20, 0, 150)
    infoText.Position = UDim2.new(0, 10, 0, 40)
    infoText.BackgroundTransparency = 1
    infoText.TextColor3 = Color3.fromRGB(255, 255, 255)
    infoText.TextWrapped = true
    infoText.TextXAlignment = Enum.TextXAlignment.Left
    infoText.TextYAlignment = Enum.TextYAlignment.Top
    infoText.TextSize = 14
    infoText.Font = Enum.Font.Gotham
    infoText.Text = "PlaceId: " .. game.PlaceId .. "\n" ..
                     "JobId: " .. game.JobId .. "\n" ..
                     "Players: " .. #Players:GetPlayers() .. "/" .. Players.MaxPlayers .. "\n" ..
                     "Creator: " .. game.CreatorId
    infoText.Parent = frame

    local copyBtn = Instance.new("TextButton")
    copyBtn.Size = UDim2.new(1, -20, 0, 30)
    copyBtn.Position = UDim2.new(0, 10, 1, -40)
    copyBtn.BackgroundColor3 = GetTheme().Main
    copyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    copyBtn.Text = "Copy JobId"
    copyBtn.TextScaled = true
    copyBtn.Font = Enum.Font.GothamBold
    copyBtn.BorderSizePixel = 0
    copyBtn.Parent = frame
    copyBtn.AutoButtonColor = false

    copyBtn.MouseButton1Click:Connect(function()
        pcall(function()
            setclipboard(game.JobId)
        end)
        ShowRobloxNotification(_("JobIdCopied"), 2)
    end)

    closeBtn.MouseButton1Click:Connect(function()
        frame:Destroy()
    end)
end

-- ========== CUSTOM SCRIPT ==========
local function ShowCustomScript()
    local frame = Instance.new("Frame")
    frame.Name = "CustomScriptFrame"
    frame.Size = UDim2.new(0, 400, 0, 180)
    frame.Position = UDim2.new(0.5, -200, 0.5, -90)
    frame.BackgroundColor3 = GetTheme().Background
    frame.BorderSizePixel = 2
    frame.BorderColor3 = GetTheme().Main
    frame.Parent = screenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -40, 0, 30)
    title.Position = UDim2.new(0, 5, 0, 5)
    title.BackgroundTransparency = 1
    title.TextColor3 = GetTheme().Text
    title.Text = _("CustomScript")
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = frame

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -35, 0, 0)
    closeBtn.BackgroundTransparency = 1
    closeBtn.Text = "X"
    closeBtn.TextColor3 = GetTheme().Text
    closeBtn.TextScaled = true
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Parent = frame
    closeBtn.AutoButtonColor = false

    local input = Instance.new("TextBox")
    input.Size = UDim2.new(1, -20, 0, 40)
    input.Position = UDim2.new(0, 10, 0, 45)
    input.BackgroundColor3 = GetTheme().Dark
    input.TextColor3 = Color3.fromRGB(255, 255, 255)
    input.PlaceholderText = _("CustomPlaceholder")
    input.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
    input.Text = ""
    input.TextSize = 14
    input.Font = Enum.Font.Gotham
    input.BorderSizePixel = 1
    input.BorderColor3 = GetTheme().Main
    input.Parent = frame

    local inputCorner = Instance.new("UICorner")
    inputCorner.CornerRadius = UDim.new(0, 6)
    inputCorner.Parent = input

    local runBtn = Instance.new("TextButton")
    runBtn.Size = UDim2.new(1, -20, 0, 40)
    runBtn.Position = UDim2.new(0, 10, 0, 95)
    runBtn.BackgroundColor3 = GetTheme().Main
    runBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    runBtn.Text = _("RunCustom")
    runBtn.TextScaled = true
    runBtn.Font = Enum.Font.GothamBold
    runBtn.BorderSizePixel = 0
    runBtn.Parent = frame
    runBtn.AutoButtonColor = false

    runBtn.MouseButton1Click:Connect(function()
        local url = input.Text
        if url == "" then return end
        print("[XyqwHub] Custom - STARTING...")
        local success, err = pcall(function()
            loadstring(game:HttpGet(url))()
        end)
        if success then
            print("[XyqwHub] Custom - " .. _("Loaded") .. "!")
            ShowRobloxNotification("Custom - " .. _("ScriptExecuted"), 3)
        else
            print("[XyqwHub] Custom - " .. _("Error") .. ": " .. tostring(err))
            ShowRobloxNotification("Custom - " .. _("Error") .. ": " .. tostring(err), 5)
        end
    end)

    closeBtn.MouseButton1Click:Connect(function()
        frame:Destroy()
    end)
end

-- ========== КНОПКИ ФУНКЦИЙ ==========
local functionButtonY = -1

-- Кнопка Custom Script
local customBtn = Instance.new("TextButton")
customBtn.Name = "CustomBtn"
customBtn.Size = UDim2.new(0, 60, 1, 0)
customBtn.Position = UDim2.new(0, 5, 0, 0)
customBtn.BackgroundColor3 = GetTheme().Dark
customBtn.TextColor3 = Color3.fromRGB(255, 200, 0)
customBtn.Text = "Custom"
customBtn.TextScaled = true
customBtn.Font = Enum.Font.GothamBold
customBtn.BorderSizePixel = 1
customBtn.BorderColor3 = GetTheme().Main
customBtn.Parent = titleBar
customBtn.AutoButtonColor = false

-- Кнопка Player List
local playerBtn = Instance.new("TextButton")
playerBtn.Name = "PlayerBtn"
playerBtn.Size = UDim2.new(0, 60, 1, 0)
playerBtn.Position = UDim2.new(1, -195, 0, 0)
playerBtn.BackgroundColor3 = GetTheme().Dark
playerBtn.TextColor3 = Color3.fromRGB(255, 200, 0)
playerBtn.Text = "Players"
playerBtn.TextScaled = true
playerBtn.Font = Enum.Font.GothamBold
playerBtn.BorderSizePixel = 1
playerBtn.BorderColor3 = GetTheme().Main
playerBtn.Parent = titleBar
playerBtn.AutoButtonColor = false

-- Кнопка Server Info
local serverBtn = Instance.new("TextButton")
serverBtn.Name = "ServerBtn"
serverBtn.Size = UDim2.new(0, 60, 1, 0)
serverBtn.Position = UDim2.new(1, -130, 0, 0)
serverBtn.BackgroundColor3 = GetTheme().Dark
serverBtn.TextColor3 = Color3.fromRGB(255, 200, 0)
serverBtn.Text = "Server"
serverBtn.TextScaled = true
serverBtn.Font = Enum.Font.GothamBold
serverBtn.BorderSizePixel = 1
serverBtn.BorderColor3 = GetTheme().Main
serverBtn.Parent = titleBar
serverBtn.AutoButtonColor = false

customBtn.MouseButton1Click:Connect(ShowCustomScript)
playerBtn.MouseButton1Click:Connect(ShowPlayerList)
serverBtn.MouseButton1Click:Connect(ShowServerInfo)

-- ========== REMOVE TAG ==========
local removeTagBtn = Instance.new("TextButton")
removeTagBtn.Name = "RemoveTagBtn"
removeTagBtn.Size = UDim2.new(1, -10, 0, 35)
removeTagBtn.Position = UDim2.new(0, 5, 1, -40)
removeTagBtn.BackgroundColor3 = GetTheme().Dark
removeTagBtn.TextColor3 = GetTheme().Text
removeTagBtn.Text = _("RemoveTagBtn")
removeTagBtn.TextScaled = true
removeTagBtn.Font = Enum.Font.GothamBold
removeTagBtn.BorderSizePixel = 2
removeTagBtn.BorderColor3 = GetTheme().Main
removeTagBtn.Parent = mainFrame
removeTagBtn.AutoButtonColor = false

removeTagBtn.MouseButton1Click:Connect(function()
    RemoveAllTags()
    ShowRobloxNotification(_("TagRemoved"), 3)
end)

-- ========== ПЕРЕТАСКИВАНИЕ ==========
local dragging = false
local dragStart, startPos

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        local mousePos = input.Position
        local function IsOverButton(btn)
            local btnPos = btn.AbsolutePosition
            local btnSize = btn.AbsoluteSize
            return mousePos.X >= btnPos.X and mousePos.X <= btnPos.X + btnSize.X and
                   mousePos.Y >= btnPos.Y and mousePos.Y <= btnPos.Y + btnSize.Y
        end
        if IsOverButton(changelogButton) or IsOverButton(langButton) or IsOverButton(closeButton)
           or IsOverButton(themeButton) or IsOverButton(customBtn) or IsOverButton(playerBtn)
           or IsOverButton(serverBtn) then
            return
        end
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

titleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

-- Док-кнопка перетаскивание
local dockDragging = false
local dockDragStart, dockStartPos

dockButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dockDragging = true
        dockDragStart = input.Position
        dockStartPos = dockButton.Position
    end
end)

dockButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dockDragging = false
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dockDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dockDragStart
        dockButton.Position = UDim2.new(
            dockStartPos.X.Scale, dockStartPos.X.Offset + delta.X,
            dockStartPos.Y.Scale, dockStartPos.Y.Offset + delta.Y
        )
    end
end)

-- Закрытие / открытие
local function closeGUI()
    mainFrame.Visible = false
    dockButton.Visible = true
end

local function openGUI()
    mainFrame.Visible = true
    dockButton.Visible = false
end

closeButton.MouseButton1Click:Connect(closeGUI)
dockButton.MouseButton1Click:Connect(openGUI)

-- ========== WELCOME MESSAGE ==========
local function ShowWelcomeMessage()
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 320, 0, 175)
    frame.Position = UDim2.new(0.5, -160, 0.5, -87)
    frame.BackgroundColor3 = GetTheme().Background
    frame.BorderSizePixel = 2
    frame.BorderColor3 = GetTheme().Main
    frame.Parent = screenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame

    local top = Instance.new("TextLabel")
    top.Size = UDim2.new(1, -10, 0, 20)
    top.Position = UDim2.new(0, 5, 0, 5)
    top.BackgroundTransparency = 1
    top.TextColor3 = Color3.fromRGB(255, 200, 100)
    top.Text = "Press EN/RU in the top right corner to change language"
    top.TextScaled = true
    top.Font = Enum.Font.Gotham
    top.Parent = frame

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -10, 0, 25)
    title.Position = UDim2.new(0, 5, 0, 28)
    title.BackgroundTransparency = 1
    title.TextColor3 = GetTheme().Text
    title.Text = "Welcome to XyqwHub!"
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = frame

    local tiktok = Instance.new("TextLabel")
    tiktok.Size = UDim2.new(1, -10, 0, 22)
    tiktok.Position = UDim2.new(0, 5, 0, 56)
    tiktok.BackgroundTransparency = 1
    tiktok.TextColor3 = Color3.fromRGB(255, 255, 255)
    tiktok.Text = "TikTok: xyqwerq.tvink"
    tiktok.TextScaled = true
    tiktok.Font = Enum.Font.Gotham
    tiktok.Parent = frame

    local tg = Instance.new("TextLabel")
    tg.Size = UDim2.new(1, -10, 0, 22)
    tg.Position = UDim2.new(0, 5, 0, 80)
    tg.BackgroundTransparency = 1
    tg.TextColor3 = Color3.fromRGB(255, 255, 255)
    tg.Text = "Telegram: t.me/xyqwsquad"
    tg.TextScaled = true
    tg.Font = Enum.Font.Gotham
    tg.Parent = frame

    local dc = Instance.new("TextLabel")
    dc.Size = UDim2.new(1, -10, 0, 22)
    dc.Position = UDim2.new(0, 5, 0, 104)
    dc.BackgroundTransparency = 1
    dc.TextColor3 = Color3.fromRGB(255, 255, 255)
    dc.Text = "Discord: xyqwerqyt"
    dc.TextScaled = true
    dc.Font = Enum.Font.Gotham
    dc.Parent = frame

    local bottom = Instance.new("TextLabel")
    bottom.Size = UDim2.new(1, -10, 0, 20)
    bottom.Position = UDim2.new(0, 5, 0, 130)
    bottom.BackgroundTransparency = 1
    bottom.TextColor3 = Color3.fromRGB(255, 200, 100)
    bottom.Text = "Нажмите EN/RU в правом верхнем углу, чтобы сменить язык"
    bottom.TextScaled = true
    bottom.Font = Enum.Font.Gotham
    bottom.Parent = frame

    local ver = Instance.new("TextLabel")
    ver.Size = UDim2.new(1, -10, 0, 18)
    ver.Position = UDim2.new(0, 5, 0, 153)
    ver.BackgroundTransparency = 1
    ver.TextColor3 = Color3.fromRGB(150, 150, 150)
    ver.Text = "Version: " .. VERSION
    ver.TextScaled = true
    ver.Font = Enum.Font.Gotham
    ver.Parent = frame

    task.wait(5)
    frame:Destroy()
end

-- ========== ФИНАЛ ==========
ShowRobloxNotification("XyqwHub Loaded!", 3)
print("[XyqwHub] XyqwHub loaded! Version: " .. VERSION)

task.wait(0.3)
ShowWelcomeMessage()
