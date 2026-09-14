-- ========== XyqwHub - Версия 3.4 ==========
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
local VERSION = "3.4"

-- ========== ТВОИ USER ID (OWNER) ==========
local OWNER_IDS = {
    4396977722,
    8527910367
}

-- ========== ТЕКУЩИЙ ЯЗЫК ==========
if getgenv().XyqwLanguage == nil then
    getgenv().XyqwLanguage = "EN"
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
        ChangeLogTitle = "ChangeLog",
        ChangeLogText = [[XyqwHub ChangeLog

Version 3.4
- Darker red color for tag
- Normal background for Remove/Destroy buttons
- Normal border for Remove/Destroy buttons

Version 3.3
- Fixed tag size (no longer stretches)
- Fixed gradient (now works via Rotation)
- Gradient visible for everyone
- Fixed text position

Version 3.2
- Brought back gradient animation
- Smaller text size

Version 3.1
- Rewrote tag system
- Tag attached to HumanoidRootPart

Version 3.0
- Removed gradient
- Added debug prints

Version 2.9
- Added XyqwHub OWNER tag
- Added "Remove XyqwHub Tag" button

Version 2.8
- XyqwHub Loaded! appears immediately

Version 2.7
- Roblox notifications (bottom right)

Version 2.6
- Notifications moved to bottom right

Version 2.5
- All messages translated to EN/RU

Version 2.4
- Re-launch protection added

Version 2.3
- Added Adopt me

Version 2.2
- Added bLockman's minesweaper and Cheating during test

Version 2.1
- Added DropKick, Evade, A Dusty Trip, A Dusty Trip v2

Version 2.0
- Removed Auto Execute

Version 1.9
- Added key for Doors V3 (Cheesy)

Version 1.8
- Added Death Order [SIMON] and CandyWare (MM2)

Version 1.7
- Added Troll script

Version 1.6
- Added Steal an egg, Universal script, Corridor, BloxStrike, RIVALS

Version 1.5
- EN/RU hint at top and bottom of welcome

Version 1.4
- EN/RU hint in welcome

Version 1.3
- Hint how to change language after welcome

Version 1.2
- Fixed language change button

Version 1.1
- Added language change

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
        ChangeLogTitle = "Ченджлог",
        ChangeLogText = [[XyqwHub Ченджлог

Версия 3.4
- Более насыщенный красный цвет тега
- Обычный фон для кнопок Remove/Destroy
- Обычная обводка для кнопок Remove/Destroy

Версия 3.3
- Исправлен размер тега (больше не растягивается)
- Исправлен градиент (теперь через Rotation)
- Градиент виден всем
- Исправлена позиция текста

Версия 3.2
- Возвращена градиентная анимация
- Уменьшен размер текста

Версия 3.1
- Переписана система тегов
- Тег крепится к HumanoidRootPart

Версия 3.0
- Убран градиент
- Добавлены отладочные принты

Версия 2.9
- Добавлен тег XyqwHub OWNER
- Добавлена кнопка "Убрать тег XyqwHub"

Версия 2.8
- XyqwHub Loaded! появляется сразу

Версия 2.7
- Уведомления Roblox (справа снизу)

Версия 2.6
- Уведомления перенесены вправо вниз

Версия 2.5
- Все сообщения переведены на RU/EN

Версия 2.4
- Добавлена защита от повторного запуска

Версия 2.3
- Добавлен Adopt me

Версия 2.2
- Добавлены bLockman's minesweaper и Cheating during test

Версия 2.1
- Добавлены DropKick, Evade, A Dusty Trip, A Dusty Trip v2

Версия 2.0
- Убран Auto Execute

Версия 1.9
- Добавлен ключ для Doors V3 (Cheesy)

Версия 1.8
- Добавлены Death Order [SIMON] и CandyWare (MM2)

Версия 1.7
- Добавлен Troll script

Версия 1.6
- Добавлены Steal an egg, Universal script, Corridor, BloxStrike, RIVALS

Версия 1.5
- Подсказка EN/RU вверху и внизу приветствия

Версия 1.4
- Подсказка EN/RU в приветствии

Версия 1.3
- Подсказка как сменить язык после приветствия

Версия 1.2
- Исправлена кнопка смены языка

Версия 1.1
- Добавлена смена языка

Версия 1.0
- Первый релиз]]
    }
}

-- ========== ФУНКЦИЯ ПОЛУЧЕНИЯ ТЕКСТА ==========
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

-- ========== СИСТЕМА ТЕГОВ С ГРАДИЕНТОМ ==========
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local tagsEnabled = true
local activeTags = {}

local function isOwner(plr)
    for _, id in ipairs(OWNER_IDS) do
        if plr.UserId == id then
            return true
        end
    end
    return false
end

local function CreateTagForPlayer(plr)
    if not tagsEnabled then return end
    if not isOwner(plr) then return end
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
    label.Text = "XyqwHub OWNER"
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    label.Parent = billboard

    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 0, 0)),
        ColorSequenceKeypoint.new(0.25, Color3.fromRGB(60, 0, 0)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(200, 0, 0)),
        ColorSequenceKeypoint.new(0.75, Color3.fromRGB(60, 0, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 0, 0))
    })
    gradient.Rotation = 0
    gradient.Parent = label

    local glow = Instance.new("UIStroke")
    glow.Color = Color3.fromRGB(255, 0, 0)
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
        if isOwner(plr) and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            CreateTagForPlayer(plr)
        end
    end
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
    plr.CharacterAdded:Connect(function()
        task.wait(1)
        if isOwner(plr) then
            CreateTagForPlayer(plr)
        end
    end)
    if plr.Character then
        task.wait(1)
        if isOwner(plr) then
            CreateTagForPlayer(plr)
        end
    end
end)

Players.PlayerRemoving:Connect(function(plr)
    RemoveTagForPlayer(plr)
end)

for _, plr in ipairs(Players:GetPlayers()) do
    plr.CharacterAdded:Connect(function()
        task.wait(1)
        if isOwner(plr) then
            CreateTagForPlayer(plr)
        end
    end)
end

-- ========== GUI ==========
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "XyqwHubGui"
screenGui.Parent = game:GetService("CoreGui")

local dockButton = Instance.new("TextButton")
dockButton.Name = "DockButton"
dockButton.Size = UDim2.new(0, 90, 0, 30)
dockButton.Position = UDim2.new(0.5, -45, 0.05, 10)
dockButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
dockButton.TextColor3 = Color3.fromRGB(255, 0, 0)
dockButton.Text = _("DockText")
dockButton.TextScaled = true
dockButton.Font = Enum.Font.GothamBold
dockButton.BorderSizePixel = 2
dockButton.BorderColor3 = Color3.fromRGB(255, 0, 0)
dockButton.Parent = screenGui
dockButton.Visible = false
dockButton.AutoButtonColor = false

local dockCorner = Instance.new("UICorner")
dockCorner.CornerRadius = UDim.new(0, 6)
dockCorner.Parent = dockButton

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 280, 0, 400)
mainFrame.Position = UDim2.new(0.5, -140, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.BorderSizePixel = 3
mainFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -145, 1, 0)
titleLabel.Position = UDim2.new(0, 5, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = _("WindowTitle")
titleLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = titleBar

local changelogButton = Instance.new("TextButton")
changelogButton.Size = UDim2.new(0, 70, 0.8, 0)
changelogButton.Position = UDim2.new(1, -140, 0.1, 0)
changelogButton.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
changelogButton.TextColor3 = Color3.fromRGB(255, 200, 0)
changelogButton.Text = _("ChangeLogBtn")
changelogButton.TextScaled = true
changelogButton.Font = Enum.Font.GothamBold
changelogButton.BorderSizePixel = 1
changelogButton.BorderColor3 = Color3.fromRGB(255, 0, 0)
changelogButton.Parent = titleBar
changelogButton.AutoButtonColor = false

local langButton = Instance.new("TextButton")
langButton.Size = UDim2.new(0, 35, 1, 0)
langButton.Position = UDim2.new(1, -65, 0, 0)
langButton.BackgroundTransparency = 1
langButton.Text = getgenv().XyqwLanguage
langButton.TextColor3 = Color3.fromRGB(255, 200, 0)
langButton.TextScaled = true
langButton.Font = Enum.Font.GothamBold
langButton.Parent = titleBar
langButton.AutoButtonColor = false

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 1, 0)
closeButton.Position = UDim2.new(1, -30, 0, 0)
closeButton.BackgroundTransparency = 1
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 0, 0)
closeButton.TextScaled = true
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = titleBar
closeButton.AutoButtonColor = false

local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -10, 1, -40)
scrollFrame.Position = UDim2.new(0, 5, 0, 35)
scrollFrame.BackgroundTransparency = 1
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.ScrollBarThickness = 4
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 0, 0)
scrollFrame.Parent = mainFrame

local buttonsBlocked = false

local function blockButtonsTemporarily()
    buttonsBlocked = true
    task.wait(0.5)
    buttonsBlocked = false
end

local cooldowns = {}

local function CanRun(name)
    local lastRun = cooldowns[name] or 0
    if tick() - lastRun < 1.5 then
        return false
    end
    cooldowns[name] = tick()
    return true
end

local function CopyToClipboard(text)
    local success, err = pcall(function()
        setclipboard(text)
    end)
    if success then
        print("[XyqwHub] Copied to clipboard!")
        return true
    else
        print("[XyqwHub] Failed to copy: " .. tostring(err))
        return false
    end
end

local function ShowWelcomeMessage()
    local welcomeFrame = Instance.new("Frame")
    welcomeFrame.Size = UDim2.new(0, 320, 0, 175)
    welcomeFrame.Position = UDim2.new(0.5, -160, 0.5, -87)
    welcomeFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    welcomeFrame.BorderSizePixel = 2
    welcomeFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
    welcomeFrame.Parent = screenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = welcomeFrame

    local topHint = Instance.new("TextLabel")
    topHint.Size = UDim2.new(1, -10, 0, 20)
    topHint.Position = UDim2.new(0, 5, 0, 5)
    topHint.BackgroundTransparency = 1
    topHint.TextColor3 = Color3.fromRGB(255, 200, 100)
    topHint.Text = "Press EN/RU in the top right corner to change language"
    topHint.TextScaled = true
    topHint.Font = Enum.Font.Gotham
    topHint.Parent = welcomeFrame

    local titleLabelW = Instance.new("TextLabel")
    titleLabelW.Size = UDim2.new(1, -10, 0, 25)
    titleLabelW.Position = UDim2.new(0, 5, 0, 28)
    titleLabelW.BackgroundTransparency = 1
    titleLabelW.TextColor3 = Color3.fromRGB(255, 100, 100)
    titleLabelW.Text = "Welcome to XyqwHub!"
    titleLabelW.TextScaled = true
    titleLabelW.Font = Enum.Font.GothamBold
    titleLabelW.Parent = welcomeFrame

    local tiktokLabel = Instance.new("TextLabel")
    tiktokLabel.Size = UDim2.new(1, -10, 0, 22)
    tiktokLabel.Position = UDim2.new(0, 5, 0, 56)
    tiktokLabel.BackgroundTransparency = 1
    tiktokLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    tiktokLabel.Text = "TikTok: xyqwerq.tvink"
    tiktokLabel.TextScaled = true
    tiktokLabel.Font = Enum.Font.Gotham
    tiktokLabel.Parent = welcomeFrame

    local telegramLabel = Instance.new("TextLabel")
    telegramLabel.Size = UDim2.new(1, -10, 0, 22)
    telegramLabel.Position = UDim2.new(0, 5, 0, 80)
    telegramLabel.BackgroundTransparency = 1
    telegramLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    telegramLabel.Text = "Telegram: t.me/xyqwsquad"
    telegramLabel.TextScaled = true
    telegramLabel.Font = Enum.Font.Gotham
    telegramLabel.Parent = welcomeFrame

    local discordLabel = Instance.new("TextLabel")
    discordLabel.Size = UDim2.new(1, -10, 0, 22)
    discordLabel.Position = UDim2.new(0, 5, 0, 104)
    discordLabel.BackgroundTransparency = 1
    discordLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    discordLabel.Text = "Discord: xyqwerqyt"
    discordLabel.TextScaled = true
    discordLabel.Font = Enum.Font.Gotham
    discordLabel.Parent = welcomeFrame

    local bottomHint = Instance.new("TextLabel")
    bottomHint.Size = UDim2.new(1, -10, 0, 20)
    bottomHint.Position = UDim2.new(0, 5, 0, 130)
    bottomHint.BackgroundTransparency = 1
    bottomHint.TextColor3 = Color3.fromRGB(255, 200, 100)
    bottomHint.Text = "Нажмите EN/RU в правом верхнем углу, чтобы сменить язык"
    bottomHint.TextScaled = true
    bottomHint.Font = Enum.Font.Gotham
    bottomHint.Parent = welcomeFrame

    local versionLabel = Instance.new("TextLabel")
    versionLabel.Size = UDim2.new(1, -10, 0, 18)
    versionLabel.Position = UDim2.new(0, 5, 0, 153)
    versionLabel.BackgroundTransparency = 1
    versionLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
    versionLabel.Text = "Version: " .. VERSION
    versionLabel.TextScaled = true
    versionLabel.Font = Enum.Font.Gotham
    versionLabel.Parent = welcomeFrame

    task.wait(5)
    welcomeFrame:Destroy()
end

local function ShowChangeLog()
    local changelogFrame = Instance.new("Frame")
    changelogFrame.Size = UDim2.new(0, 400, 0, 350)
    changelogFrame.Position = UDim2.new(0.5, -200, 0.5, -175)
    changelogFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    changelogFrame.BorderSizePixel = 2
    changelogFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
    changelogFrame.Parent = screenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = changelogFrame

    local titleLbl = Instance.new("TextLabel")
    titleLbl.Size = UDim2.new(1, -40, 0, 30)
    titleLbl.Position = UDim2.new(0, 5, 0, 5)
    titleLbl.BackgroundTransparency = 1
    titleLbl.TextColor3 = Color3.fromRGB(255, 100, 100)
    titleLbl.Text = _("ChangeLogTitle")
    titleLbl.TextScaled = true
    titleLbl.Font = Enum.Font.GothamBold
    titleLbl.Parent = changelogFrame

    local closeCL = Instance.new("TextButton")
    closeCL.Size = UDim2.new(0, 30, 0, 30)
    closeCL.Position = UDim2.new(1, -35, 0, 0)
    closeCL.BackgroundTransparency = 1
    closeCL.Text = "X"
    closeCL.TextColor3 = Color3.fromRGB(255, 0, 0)
    closeCL.TextScaled = true
    closeCL.Font = Enum.Font.GothamBold
    closeCL.Parent = changelogFrame
    closeCL.AutoButtonColor = false

    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, -20, 1, -50)
    scroll.Position = UDim2.new(0, 10, 0, 40)
    scroll.BackgroundTransparency = 1
    scroll.CanvasSize = UDim2.new(0, 0, 0, 1500)
    scroll.ScrollBarThickness = 4
    scroll.ScrollBarImageColor3 = Color3.fromRGB(255, 0, 0)
    scroll.Parent = changelogFrame

    local textLbl = Instance.new("TextLabel")
    textLbl.Size = UDim2.new(1, -10, 0, 1490)
    textLbl.Position = UDim2.new(0, 5, 0, 5)
    textLbl.BackgroundTransparency = 1
    textLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLbl.TextWrapped = true
    textLbl.TextXAlignment = Enum.TextXAlignment.Left
    textLbl.TextYAlignment = Enum.TextYAlignment.Top
    textLbl.TextScaled = false
    textLbl.TextSize = 14
    textLbl.Font = Enum.Font.Gotham
    textLbl.Text = _("ChangeLogText")
    textLbl.Parent = scroll

    closeCL.MouseButton1Click:Connect(function()
        changelogFrame:Destroy()
    end)
    closeCL.TouchTap:Connect(function()
        changelogFrame:Destroy()
    end)
end

local function CreateButton(text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 40)
    btn.Position = UDim2.new(0, 5, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    btn.TextColor3 = Color3.fromRGB(255, 0, 0)
    btn.Text = text
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 2
    btn.BorderColor3 = Color3.fromRGB(255, 0, 0)
    btn.Parent = scrollFrame
    btn.AutoButtonColor = false

    local defaultColor = Color3.fromRGB(0, 0, 0)
    local hoverColor = Color3.fromRGB(40, 0, 0)
    local clickColor = Color3.fromRGB(80, 0, 0)

    local function resetColor()
        btn.BackgroundColor3 = defaultColor
    end

    btn.MouseEnter:Connect(function()
        if not buttonsBlocked then
            btn.BackgroundColor3 = hoverColor
        end
    end)

    btn.MouseLeave:Connect(function()
        resetColor()
    end)

    local isRunning = false

    local function onClick()
        if buttonsBlocked or isRunning then return end
        isRunning = true

        btn.BackgroundColor3 = clickColor

        if CanRun(text) then
            pcall(callback)
        end

        task.wait(0.3)
        resetColor()
        isRunning = false
    end

    btn.MouseButton1Click:Connect(onClick)
    btn.TouchTap:Connect(onClick)

    return btn
end

local function RunScript(name, url)
    print("[XyqwHub] " .. name .. " - STARTING...")
    local success, err = pcall(function()
        loadstring(game:HttpGet(url))()
    end)
    if success then
        print("[XyqwHub] " .. name .. " - " .. _("Loaded") .. "!")
    else
        print("[XyqwHub] " .. name .. " - " .. _("Error") .. ": " .. tostring(err))
    end
end

local langCooldown = false

local function SwitchLanguage()
    if langCooldown then return end
    langCooldown = true

    if getgenv().XyqwLanguage == "EN" then
        getgenv().XyqwLanguage = "RU"
    else
        getgenv().XyqwLanguage = "EN"
    end

    titleLabel.Text = _("WindowTitle")
    dockButton.Text = _("DockText")
    langButton.Text = getgenv().XyqwLanguage
    changelogButton.Text = _("ChangeLogBtn")

    ShowRobloxNotification(_("LangChanged"), 2)

    print("[XyqwHub] Language changed to: " .. getgenv().XyqwLanguage)

    task.wait(0.5)
    langCooldown = false
end

langButton.MouseButton1Click:Connect(SwitchLanguage)
langButton.TouchTap:Connect(SwitchLanguage)

changelogButton.MouseButton1Click:Connect(ShowChangeLog)
changelogButton.TouchTap:Connect(ShowChangeLog)

local y = 5

local function addButton(text, url)
    local btn = CreateButton(text, function()
        RunScript(text, url)
    end)
    btn.Position = UDim2.new(0, 5, 0, y)
    y = y + 45
end

addButton("Blade Ball", "https://raw.githubusercontent.com/joshhhie/rise/refs/heads/main/loader.lua")
addButton("AntiKillParts", "https://raw.githubusercontent.com/sovetskii-shashlik/Anti-kill-parts-updated-/refs/heads/main/Anti%20kill%20parts%20by%20Zephyr")
addButton("PulseHub", "https://raw.githubusercontent.com/PulseZax/Loader/refs/heads/main/.lua")
addButton("RUNAWAYS", "https://raw.githubusercontent.com/Bac0nHck/Scripts/refs/heads/main/RUNAWAYS.lua")
addButton("Universal FE", "https://rawscripts.net/raw/Universal-Script-Universal-FE-Free-keyless-FE-script-242513")
addButton("UwU hub", "https://raw.githubusercontent.com/platinww/UwU/refs/heads/main/INK-GAME")
addButton("FakeVR", "https://pastefy.app/MvKHpycG/raw")
addButton("WallHop", "https://raw.githubusercontent.com/ScpGuest666/Random-Roblox-script/refs/heads/main/Roblox%20WallHop%20script")
addButton("RuzHub (MM2)", "https://raw.githubusercontent.com/pruzgar242-rgb/Update/refs/heads/main/out.lua%20(17).txt")
addButton("Ringta (INK)", "https://rawscripts.net/raw/Universal-Script-RINGTA-best-script-for-ink-game-206674")
addButton("RemainsHub V2", "https://rawscripts.net/raw/Universal-Script-RemainsHub-V2-50805")
addButton("R6 Emotes", "https://rawscripts.net/raw/Universal-Script-r6-emotes-OPEN-SOURCE-69464")
addButton("Jujutsu Sheninagouns", "https://raw.githubusercontent.com/peeky-co/scripts/refs/heads/main/tbo")
addButton("Free Cam", "https://rawscripts.net/raw/Universal-Script-Free-cam-script-pc-and-mobile-223089")
addButton("Doors (Abysall)", "https://rawscripts.net/raw/DOORS-Abysall-hub-OP-205906")
addButton("Fling Gui", "https://rawscripts.net/raw/Universal-Script-fling-gui-99753")
addButton("Blade Ball 2", "https://wings.ac/loader")
addButton("Blade Ball 3", "https://raw.githubusercontent.com/2xrW/return/refs/heads/main/hub")
addButton("AX Scripts (INK)", "https://officialaxscripts.vercel.app/scripts/AX-Loader.lua")

local doorsV2Btn = CreateButton("Doors V2 (Copy)", function()
    local scriptText = [[getgenv().SCRIPT_KEY = "KEYLESS"
loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/abd3cc54d2dc7de4a091fb19c8f4ea9e15e939e7ecc88b475e6956e8af94ad6f/download"))()]]

    local copied = CopyToClipboard(scriptText)

    if copied then
        ShowRobloxNotification(_("DoorsV2") .. " - " .. _("DoorsV2Bottom"))
    else
        ShowRobloxNotification(_("DoorsV2") .. " - " .. _("CopyFailed"))
    end
end)
doorsV2Btn.Position = UDim2.new(0, 5, 0, y)
y = y + 45

local cheesyBtn = CreateButton("Doors V3 (Cheesy)", function()
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/doram44/cheesy/refs/heads/main/cheesy.lua"))()
    end)
    if success then
        print("[XyqwHub] Doors V3 (Cheesy) - " .. _("Loaded") .. "!")
        ShowRobloxNotification(_("CheesyKey") .. " - " .. _("CheesyBottom"))
    else
        print("[XyqwHub] Doors V3 (Cheesy) - " .. _("Error") .. ": " .. tostring(err))
        ShowRobloxNotification(_("CheesyKey") .. " - " .. _("Failed"))
    end
end)
cheesyBtn.Position = UDim2.new(0, 5, 0, y)
y = y + 45

addButton("Infinite Yield", "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source")

local walkBtn = CreateButton("Walk on walls", function()
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/The-patience-obby-Universal-Walk-on-walls-18129"))()
    end)
    if success then
        print("[XyqwHub] Walk on walls - " .. _("Loaded") .. "!")
        ShowRobloxNotification(_("WalkOnWalls") .. " - " .. _("WalkOnWallsBottom"))
    else
        print("[XyqwHub] Walk on walls - " .. _("Error") .. ": " .. tostring(err))
        ShowRobloxNotification(_("WalkOnWalls") .. " - " .. _("Failed"))
    end
end)
walkBtn.Position = UDim2.new(0, 5, 0, y)
y = y + 45

local aetherBtn = CreateButton("AetherX (Death Penalty)", function()
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/8c08b8f2252eec7dbb77d253d269bb65.lua"))()
    end)
    if success then
        print("[XyqwHub] AetherX - " .. _("Loaded") .. "!")
        ShowRobloxNotification(_("AetherX") .. " - " .. _("AetherXBottom"))
    else
        print("[XyqwHub] AetherX - " .. _("Error") .. ": " .. tostring(err))
        ShowRobloxNotification(_("AetherX") .. " - " .. _("Failed"))
    end
end)
aetherBtn.Position = UDim2.new(0, 5, 0, y)
y = y + 45

addButton("Voidware (INK/99N/Forsaken)", "https://files.vapevoidware.xyz/VapeVoidware/VW-Add/main/loader.lua")

local lalolBtn = CreateButton("LaLol Hub (B4ckd0or)", function()
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Miygteet/Hacker101/refs/heads/main/LALOL-Backdoor-Secure.lua"))()
    end)
    if success then
        print("[XyqwHub] LaLol Hub - " .. _("Loaded") .. "!")
        ShowRobloxNotification(_("Beta") .. " - " .. _("BetaBottom"))
    else
        print("[XyqwHub] LaLol Hub - " .. _("Error") .. ": " .. tostring(err))
        ShowRobloxNotification(_("Beta") .. " - " .. _("Failed"))
    end
end)
lalolBtn.Position = UDim2.new(0, 5, 0, y)
y = y + 45

local ftapBtn = CreateButton("FTAP", function()
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/4078649e4397f0e2cdaddde241d69bfd67b2b7107917891384735129c85cae18/download"))()
    end)
    if success then
        print("[XyqwHub] FTAP - " .. _("Loaded") .. "!")
        ShowRobloxNotification(_("Beta") .. " - " .. _("BetaBottom"))
    else
        print("[XyqwHub] FTAP - " .. _("Error") .. ": " .. tostring(err))
        ShowRobloxNotification(_("Beta") .. " - " .. _("Failed"))
    end
end)
ftapBtn.Position = UDim2.new(0, 5, 0, y)
y = y + 45

addButton("MinhNat Hub (TSB)", "https://rawscripts.net/raw/Universal-Script-MinhNhat-Tsb-62161")

local bc9Btn = CreateButton("BC9 (UTG)", function()
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/untitled-tag-game-BC9-UTG-MENU-116806"))()
    end)
    if success then
        print("[XyqwHub] BC9 (UTG) - " .. _("Loaded") .. "!")
        ShowRobloxNotification(_("BC9") .. " - " .. _("BC9Bottom"))
    else
        print("[XyqwHub] BC9 (UTG) - " .. _("Error") .. ": " .. tostring(err))
        ShowRobloxNotification(_("BC9") .. " - " .. _("Failed"))
    end
end)
bc9Btn.Position = UDim2.new(0, 5, 0, y)
y = y + 45

addButton("FTAP (WITH KEY!!)", "https://raw.githubusercontent.com/BlizTBr/scripts/main/FTAP.lua")
addButton("RadiumHub (Pressure)", "https://rawscripts.net/raw/UPDATE-Pressure-God-Mode-Auto-Loot-ESP-Full-Bright-No-Eyefestation-224409")
addButton("Steal an egg", "https://raw.githubusercontent.com/joustingmatch/Ouroboros/main/loader.lua")
addButton("Universal script", "https://raw.githubusercontent.com/fleecelolll/Fleece-s-Utility-Panel/refs/heads/main/Script.lua")
addButton("Corridor", "https://saga2015.b-cdn.net/corridor.luau")
addButton("BloxStrike", "https://raw.githubusercontent.com/Bac0nHck/Scripts/refs/heads/main/BloxStrike.lua")
addButton("RIVALS", "https://raw.githubusercontent.com/imshrak/rivals/refs/heads/main/main")
addButton("Troll script", "https://mois7.xyz/loader")

local deathOrderBtn = CreateButton("Death Order [SIMON]", function()
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Death-Order:-Simon-Says-BEST-DEATH-ORDER-SCRIPT-226542"))()
    end)
    if success then
        print("[XyqwHub] Death Order [SIMON] - " .. _("Loaded") .. "!")
        ShowRobloxNotification(_("DeathOrder") .. " - " .. _("DeathOrderBottom"))
    else
        print("[XyqwHub] Death Order [SIMON] - " .. _("Error") .. ": " .. tostring(err))
        ShowRobloxNotification(_("DeathOrder") .. " - " .. _("Failed"))
    end
end)
deathOrderBtn.Position = UDim2.new(0, 5, 0, y)
y = y + 45

addButton("CandyWare (MM2)", "https://raw.githubusercontent.com/Be1for/Scripts/refs/heads/main/candyware.luau")
addButton("DropKick", "https://raw.githubusercontent.com/yes-d3v-scripts/drop-kick-fling/refs/heads/main/script")
addButton("Evade", "https://github.com/imc72s/LaztDex/raw/refs/heads/main/EvadeScriptLaztDex")
addButton("A dusty trip", "https://raw.githubusercontent.com/BalintTheDevXBack/Games/refs/heads/main/aDustyTrip")
addButton("A dusty trip v2", "https://raw.githubusercontent.com/VoxlarWIP/Src/refs/heads/main/adustytrip.lua")
addButton("bLockman's minesweaper", "https://pastefy.app/T5XIfiMo/raw")
addButton("Cheating during test", "https://files.catbox.moe/pkulzc.txt")
addButton("Adopt me", "https://raw.githubusercontent.com/JaxRol/ZeroPoint/refs/heads/main/KeySystem")

local removeTagBtn = CreateButton(_("RemoveTagBtn"), function()
    RemoveAllTags()
    ShowRobloxNotification(_("TagRemoved"), 3)
end)
removeTagBtn.Position = UDim2.new(0, 5, 0, y)
y = y + 45

local destroyBtn = CreateButton("DESTROY XyqwHub", function()
    screenGui:Destroy()
    getgenv().XyqwHubRunning = false
    print("[XyqwHub] " .. _("Destroy"))
end)
destroyBtn.Position = UDim2.new(0, 5, 0, y)
y = y + 45

scrollFrame.CanvasSize = UDim2.new(0, 0, 0, y + 10)

local dragging = false
local dragStart, startPos

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
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
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

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
            dockStartPos.X.Scale,
            dockStartPos.X.Offset + delta.X,
            dockStartPos.Y.Scale,
            dockStartPos.Y.Offset + delta.Y
        )
    end
end)

local function closeGUI()
    mainFrame.Visible = false
    dockButton.Visible = true
end

closeButton.MouseButton1Click:Connect(closeGUI)
closeButton.TouchTap:Connect(closeGUI)

local function openGUI()
    mainFrame.Visible = true
    dockButton.Visible = false
    blockButtonsTemporarily()
end

dockButton.MouseButton1Click:Connect(openGUI)
dockButton.TouchTap:Connect(openGUI)

ShowRobloxNotification("XyqwHub Loaded!", 3)
print("[XyqwHub] XyqwHub loaded! Version: " .. VERSION)

task.wait(0.3)
ShowWelcomeMessage()
