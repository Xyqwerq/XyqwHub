-- ========== XyqwHub - Версия 4.2 ==========
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "XyqwHub", Text = "XyqwHub Loading...", Duration = 3
})
print("[XyqwHub] Loading...")

if getgenv().XyqwHubRunning then
    local msg = "Повторный запуск скрипта был заблокирован!"
    if getgenv().XyqwLanguage == "EN" then msg = "Script re-launch has been blocked!" end
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = "XyqwHub", Text = msg, Duration = 5})
    print("[XyqwHub] " .. msg)
    return
end
getgenv().XyqwHubRunning = true

local VERSION = "4.2"
local OWNER_IDS = {4396977722, 8527910367}
local BETA_IDS = {9686718765, 3701387385}

if getgenv().XyqwLanguage == nil then getgenv().XyqwLanguage = "EN" end
if getgenv().XyqwFavorites == nil then getgenv().XyqwFavorites = {} end
if getgenv().XyqwRecent == nil then getgenv().XyqwRecent = {} end
if getgenv().XyqwTheme == nil then getgenv().XyqwTheme = "Red" end
if getgenv().TopBarHidden == nil then getgenv().TopBarHidden = false end

local THEMES = {
    Red = {MAIN = Color3.fromRGB(255, 0, 0), DARK = Color3.fromRGB(40, 0, 0), BG = Color3.fromRGB(0, 0, 0), TITLE = Color3.fromRGB(20, 0, 0)},
    Blue = {MAIN = Color3.fromRGB(0, 140, 255), DARK = Color3.fromRGB(0, 20, 50), BG = Color3.fromRGB(0, 0, 0), TITLE = Color3.fromRGB(0, 10, 25)},
    Green = {MAIN = Color3.fromRGB(0, 220, 90), DARK = Color3.fromRGB(0, 40, 15), BG = Color3.fromRGB(0, 0, 0), TITLE = Color3.fromRGB(0, 20, 8)},
    Purple = {MAIN = Color3.fromRGB(180, 0, 255), DARK = Color3.fromRGB(30, 0, 45), BG = Color3.fromRGB(0, 0, 0), TITLE = Color3.fromRGB(15, 0, 22)},
    Rainbow = {MAIN = Color3.fromRGB(255, 0, 0), DARK = Color3.fromRGB(40, 0, 40), BG = Color3.fromRGB(0, 0, 0), TITLE = Color3.fromRGB(20, 0, 20)},
}

local RED_MAIN = THEMES[getgenv().XyqwTheme].MAIN
local RED_DARK = THEMES[getgenv().XyqwTheme].DARK
local RED_BG = THEMES[getgenv().XyqwTheme].BG
local RED_TITLE = THEMES[getgenv().XyqwTheme].TITLE

local LANG = {
    EN = {
        Loaded = "loaded", Error = "error", Search = "Search...",
        CustomPlaceholder = "Paste URL or loadstring...", RunCustom = "Run",
        JobIdCopied = "JobId copied!", ScriptExecuted = "Script executed!",
        OwnerWelcome = "Welcome, my father :3", BetaWelcome = "Glad you're here, tester <3",
        TagRemoved = "Tag removed!", HideTopBarOn = "Hide Top Bar: ON", HideTopBarOff = "Hide Top Bar: OFF",
        LangChanged = "Language changed to English",
        ChangeLogText = [[XyqwHub ChangeLog

Version 4.2
- Top bar with Hide button (H)
- 5 themes: Red, Blue, Green, Purple, Rainbow
- Remove Tags button
- Doors V2 (Copy) - copies script to clipboard
- Doors V3 (Cheesy) added
- All 48 scripts restored
- Fixed Rainbow covering header buttons
- Fixed resize corner (was hidden)
- Fixed welcome message (was blocked)
- Fixed "XyqwHub Loaded!" notification
- Fixed title label visibility
- Fixed close button (X minimizes to dock)
- Fixed dock button not opening
- Fixed resize stopping outside window
- Fixed black empty area at bottom
- Fixed EN/RU button overlapping X
- Fixed P, S buttons spacing
- Custom Script now accepts URL + loadstring

Version 4.1
- All buttons squared (no rounding)
- Bright red instead of yellow
- Resize in bottom right corner
- Small start size (250x300)
- All buttons in 1 row
- Removed GetTheme()
- Fixed button overlap

Version 4.0
- Top bar (executor, name, FPS, Ping)
- Search bar
- Tabs (All, BB, MM2, INK, Misc, Fav, Rct)
- Favorites system
- Recently used
- Script history
- Theme switcher
- Custom script runner
- Player list
- Server info
- Copy JobId
- Animations
- Keybinds
- Anti-AFK

Version 3.9
- Added "Script executed!" notification for all scripts
- Added Doors v4
- Added Kiti (MM2)
- Renamed BETA tag to Tester

Version 3.8
- Fixed tag not restoring after respawn
- Tag now uses CharacterAdded + task.wait

Version 3.7
- Added tester tag (blue gradient)
- Added tester welcome message
- Added 2 testers

Version 3.6
- Fixed accidental button clicks in title bar
- Added cooldown for ChangeLog and language buttons
- Added Active property to title buttons

Version 3.5
- Added owner-only welcome message

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
- Fixed text size (smaller, not stretched)
- Added UIStroke glow

Version 3.1
- Completely rewrote tag system
- Tag is now attached to humanoid root part
- Added Heartbeat-based positioning
- Fixed scanning logic

Version 3.0
- Removed gradient
- Added debug prints
- Simplified tag logic

Version 2.9
- Added XyqwHub OWNER tag
- Added "Remove XyqwHub Tag" button
- Added gradient animation for owner tag

Version 2.8
- XyqwHub Loaded! now appears immediately
- ChangeLog translated to EN/RU

Version 2.7
- Roblox notifications (bottom right)
- ChangeLog button added
- Loading / Loaded notifications

Version 2.6
- Notifications moved to bottom right

Version 2.5
- All messages translated to EN/RU
- Re-launch protection
- Fixed language change button

Version 2.4
- Re-launch protection added
- DESTROY button resets the flag
- Owner-only welcome message

Version 2.3
- Added Adopt me

Version 2.2
- Added bLockman's minesweaper and Cheating during test

Version 2.1
- Added DropKick, Evade, A Dusty Trip, A Dusty Trip v2

Version 2.0
- Removed Auto Execute
- All buttons in one list
- Version 2.0 stable

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
- First release]],
    },
    RU = {
        Loaded = "загружен", Error = "ошибка", Search = "Поиск...",
        CustomPlaceholder = "Ссылка или loadstring...", RunCustom = "Запустить",
        JobIdCopied = "JobId скопирован!", ScriptExecuted = "Скрипт выполнен!",
        OwnerWelcome = "Welcome, my father :3", BetaWelcome = "Glad you're here, tester <3",
        TagRemoved = "Тег убран!", HideTopBarOn = "Скрыть топ бар: включено", HideTopBarOff = "Скрыть топ бар: выключено",
        LangChanged = "Язык изменён на Русский",
        ChangeLogText = [[XyqwHub Ченджлог

Версия 4.2
- Топ-бар с кнопкой Hide (H)
- 5 тем: Red, Blue, Green, Purple, Rainbow
- Кнопка Remove Tags
- Doors V2 (Copy) - копирует скрипт в буфер
- Добавлен Doors V3 (Cheesy)
- Все 48 скриптов восстановлены
- Пофикшено перекрытие кнопок заголовка радугой
- Пофикшен угол ресайза (был невидим)
- Пофикшено приветствие (было заблокировано)
- Пофикшено уведомление "XyqwHub Loaded!"
- Пофикшена видимость заголовка
- Пофикшена кнопка закрытия (X сворачивает в док)
- Пофикшена док-кнопка (не открывала окно)
- Пофикшен ресайз (обрывался за пределами окна)
- Пофикшено чёрное поле внизу
- Пофикшено наложение EN/RU на крестик
- Пофикшено расположение кнопок P, S
- Custom Script теперь принимает URL + loadstring

Версия 4.1
- Все кнопки квадратные (без закруглений)
- Ярко-красный вместо жёлтого
- Ресайз в правом нижнем углу
- Маленький стартовый размер (250x300)
- Все кнопки в 1 ряд
- Убран GetTheme()
- Пофикшено наложение кнопок

Версия 4.0
- Топ-бар (executor, name, FPS, Ping)
- Строка поиска
- Вкладки (All, BB, MM2, INK, Misc, Fav, Rct)
- Система избранного
- Недавние
- История скриптов
- Переключатель тем
- Запуск кастомных скриптов
- Список игроков
- Инфо о сервере
- Копирование JobId
- Анимации
- Кейбинды
- Анти-АФК

Версия 3.9
- Добавлено уведомление "Скрипт выполнен!" для всех скриптов
- Добавлен Doors v4
- Добавлен Kiti (MM2)
- Тег BETA переименован в Tester

Версия 3.8
- Пофикшено восстановление тега после респавна
- Тег теперь использует CharacterAdded + task.wait

Версия 3.7
- Добавлен тег тестера (синий градиент)
- Добавлено приветствие тестера
- Добавлено 2 тестера

Версия 3.6
- Пофикшены случайные клики по кнопкам в заголовке
- Добавлен кулдаун для ChangeLog и кнопки языка
- Добавлено свойство Active для кнопок заголовка

Версия 3.5
- Добавлено приветствие только для владельца

Версия 3.4
- Более тёмный красный для тега
- Нормальный фон для кнопок Remove/Destroy
- Нормальная граница для кнопок Remove/Destroy

Версия 3.3
- Пофикшен размер тега (больше не растягивается)
- Пофикшен градиент (теперь работает через Rotation)
- Градиент виден всем
- Пофикшена позиция текста

Версия 3.2
- Возвращена анимация градиента
- Пофикшен размер текста (меньше, не растянут)
- Добавлено свечение UIStroke

Версия 3.1
- Полностью переписана система тегов
- Тег теперь привязан к humanoid root part
- Добавлено позиционирование через Heartbeat
- Пофикшена логика сканирования

Версия 3.0
- Убран градиент
- Добавлены debug-принты
- Упрощена логика тегов

Версия 2.9
- Добавлен тег XyqwHub OWNER
- Добавлена кнопка "Убрать тег XyqwHub"
- Добавлена анимация градиента для тега владельца

Версия 2.8
- XyqwHub Loaded! теперь появляется сразу
- ChangeLog переведён на EN/RU

Версия 2.7
- Roblox уведомления (снизу справа)
- Добавлена кнопка ChangeLog
- Уведомления Loading / Loaded

Версия 2.6
- Уведомления перенесены вниз справа

Версия 2.5
- Все сообщения переведены на EN/RU
- Защита от повторного запуска
- Пофикшена кнопка смены языка

Версия 2.4
- Добавлена защита от повторного запуска
- Кнопка DESTROY сбрасывает флаг
- Приветствие только для владельца

Версия 2.3
- Добавлен Adopt me

Версия 2.2
- Добавлены bLockman's minesweaper и Cheating during test

Версия 2.1
- Добавлены DropKick, Evade, A Dusty Trip, A Dusty Trip v2

Версия 2.0
- Убран Auto Execute
- Все кнопки в одном списке
- Версия 2.0 стабильная

Версия 1.9
- Добавлен ключ для Doors V3 (Cheesy)

Версия 1.8
- Добавлены Death Order [SIMON] и CandyWare (MM2)

Версия 1.7
- Добавлен Troll script

Версия 1.6
- Добавлены Steal an egg, Universal script, Corridor, BloxStrike, RIVALS

Версия 1.5
- Подсказка EN/RU сверху и снизу приветствия

Версия 1.4
- Подсказка EN/RU в приветствии

Версия 1.3
- Подсказка как сменить язык после приветствия

Версия 1.2
- Пофикшена кнопка смены языка

Версия 1.1
- Добавлена смена языка

Версия 1.0
- Первый релиз]],
    }
}

local function _(key)
    local lang = getgenv().XyqwLanguage or "EN"
    return LANG[lang][key] or key
end

local function ShowRobloxNotification(text, duration)
    duration = duration or 3.5
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "XyqwHub", Text = text, Duration = duration
        })
    end)
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local function IsOwner()
    for _, id in ipairs(OWNER_IDS) do
        if Players.LocalPlayer.UserId == id then return true end
    end
    return false
end

local function IsBeta()
    for _, id in ipairs(BETA_IDS) do
        if Players.LocalPlayer.UserId == id then return true end
    end
    return false
end

-- ========== ТЕГИ ==========
local tagsEnabled = true
local activeTags = {}

local function GetRole(plr)
    for _, id in ipairs(OWNER_IDS) do if plr.UserId == id then return "OWNER" end end
    for _, id in ipairs(BETA_IDS) do if plr.UserId == id then return "TESTER" end end
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
    label.Size = UDim2.new(0, 150, 0, 18)
    label.Position = UDim2.new(0.5, -75, 0.5, -9)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.GothamBold
    label.TextSize = 14
    label.TextStrokeTransparency = 0
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    label.Parent = billboard

    local gradient = Instance.new("UIGradient")
    if role == "OWNER" then
        label.Text = "XyqwHub OWNER"
        gradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 0, 0)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(60, 0, 0)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 0, 0))
        })
    else
        label.Text = "XyqwHub Tester"
        gradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 120, 255)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(10, 20, 60)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 120, 255))
        })
    end
    gradient.Rotation = 0
    gradient.Parent = label

    local glow = Instance.new("UIStroke")
    glow.Color = role == "OWNER" and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(50, 120, 255)
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
    if activeTags[plr] then activeTags[plr]:Destroy() activeTags[plr] = nil end
end

local function RemoveAllTags()
    tagsEnabled = false
    for _, tag in pairs(activeTags) do if tag then tag:Destroy() end end
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
        if GetRole(plr) then CreateTagForPlayer(plr) end
    end)
end

CheckAllPlayers()
RunService.Heartbeat:Connect(CheckAllPlayers)
Players.PlayerAdded:Connect(function(plr)
    SetupCharacterTag(plr)
    plr.CharacterAdded:Connect(function() SetupCharacterTag(plr) end)
end)
Players.PlayerRemoving:Connect(RemoveTagForPlayer)
for _, plr in ipairs(Players:GetPlayers()) do
    SetupCharacterTag(plr)
    plr.CharacterAdded:Connect(function() SetupCharacterTag(plr) end)
end

-- ========== АНТИ-АФК ==========
local VirtualUser = game:GetService("VirtualUser")
Players.LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

-- ========== FPS / PING ==========
local fpsValue = 60
local fpsCounter = 0
local fpsTime = 0
RunService.RenderStepped:Connect(function(dt)
    fpsCounter = fpsCounter + 1
    fpsTime = fpsTime + dt
    if fpsTime >= 1 then fpsValue = fpsCounter fpsCounter = 0 fpsTime = 0 end
end)

local function GetPing()
    local ok, ping = pcall(function() return math.floor(Players.LocalPlayer:GetNetworkPing() * 1000) end)
    return ok and ping or 0
end

local function GetExecutorName()
    local ok, name = pcall(function()
        if identifyexecutor then return identifyexecutor() end
        return "Unknown"
    end)
    return ok and name or "Unknown"
end

-- ========== GUI ==========
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "XyqwHubGui"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
pcall(function() screenGui.Parent = game:GetService("CoreGui") end)
if not screenGui.Parent then screenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui") end

-- ========== ТОП-БАР ==========
local topBar = Instance.new("TextButton")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(0, 420, 0, 24)
topBar.Position = UDim2.new(0.5, -210, 0, 10)
topBar.BackgroundColor3 = RED_BG
topBar.BorderSizePixel = 2
topBar.BorderColor3 = RED_MAIN
topBar.Text = ""
topBar.AutoButtonColor = false
topBar.Active = true
topBar.Parent = screenGui

local topBarText = Instance.new("TextLabel")
topBarText.Size = UDim2.new(1, -50, 1, 0)
topBarText.Position = UDim2.new(0, 5, 0, 0)
topBarText.BackgroundTransparency = 1
topBarText.Font = Enum.Font.GothamBold
topBarText.TextSize = 12
topBarText.TextColor3 = RED_MAIN
topBarText.TextXAlignment = Enum.TextXAlignment.Left
topBarText.Text = "Loading..."
topBarText.Parent = topBar

task.spawn(function()
    while topBarText.Parent do
        topBarText.Text = string.format("%s | %s | FPS: %d | Ping: %d ms",
            GetExecutorName(), Players.LocalPlayer.Name, fpsValue, GetPing())
        task.wait(1)
    end
end)

local hideTopBtn = Instance.new("TextButton")
hideTopBtn.Name = "HideTopBtn"
hideTopBtn.Size = UDim2.new(0, 45, 1, 0)
hideTopBtn.Position = UDim2.new(1, -45, 0, 0)
hideTopBtn.BackgroundColor3 = RED_DARK
hideTopBtn.TextColor3 = RED_MAIN
hideTopBtn.Text = "H"
hideTopBtn.TextScaled = true
hideTopBtn.Font = Enum.Font.GothamBold
hideTopBtn.BorderSizePixel = 1
hideTopBtn.BorderColor3 = RED_MAIN
hideTopBtn.Parent = topBar
hideTopBtn.AutoButtonColor = false

local topBarDragging = false
local topBarDragStart, topBarStartPos
topBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        if input.Position.X >= (topBar.AbsolutePosition.X + topBar.AbsoluteSize.X - 45) then return end
        topBarDragging = true
        topBarDragStart = input.Position
        topBarStartPos = topBar.Position
    end
end)
topBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        topBarDragging = false
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if topBarDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - topBarDragStart
        topBar.Position = UDim2.new(topBarStartPos.X.Scale, topBarStartPos.X.Offset + delta.X, topBarStartPos.Y.Scale, topBarStartPos.Y.Offset + delta.Y)
    end
end)

local function UpdateHideTopBtn()
    if getgenv().TopBarHidden then
        hideTopBtn.Text = "S"
        topBar.BackgroundTransparency = 1
        topBar.BorderSizePixel = 0
        topBarText.Visible = false
    else
        hideTopBtn.Text = "H"
        topBar.BackgroundTransparency = 0
        topBar.BorderSizePixel = 2
        topBarText.Visible = true
    end
end
UpdateHideTopBtn()

hideTopBtn.MouseButton1Click:Connect(function()
    getgenv().TopBarHidden = not getgenv().TopBarHidden
    if getgenv().TopBarHidden then
        ShowRobloxNotification(_("HideTopBarOn"), 2)
    else
        ShowRobloxNotification(_("HideTopBarOff"), 2)
    end
    UpdateHideTopBtn()
end)
local mainFrame = nil
-- ========== DOCK ==========
local dockButton = Instance.new("TextButton")
dockButton.Name = "DockButton"
dockButton.Size = UDim2.new(0, 90, 0, 26)
dockButton.Position = UDim2.new(0.5, -45, 0.05, 42)
dockButton.BackgroundColor3 = RED_BG
dockButton.TextColor3 = RED_MAIN
dockButton.Text = "XyqwHub"
dockButton.TextScaled = true
dockButton.Font = Enum.Font.GothamBold
dockButton.BorderSizePixel = 2
dockButton.BorderColor3 = RED_MAIN
dockButton.Parent = screenGui
dockButton.Visible = false
dockButton.AutoButtonColor = false
dockButton.Active = true
dockButton.ZIndex = 999

local dockDragging = false
local dockDragStart, dockStartPos
local dockDragMoved = false

dockButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dockDragging = true
        dockDragMoved = false
        dockDragStart = input.Position
        dockStartPos = dockButton.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dockDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dockDragStart
        if math.abs(delta.X) > 5 or math.abs(delta.Y) > 5 then
            dockDragMoved = true
        end
        if dockDragMoved then
            dockButton.Position = UDim2.new(
                dockStartPos.X.Scale, dockStartPos.X.Offset + delta.X,
                dockStartPos.Y.Scale, dockStartPos.Y.Offset + delta.Y
            )
        end
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        if dockDragging and not dockDragMoved then
            -- Это был КЛИК, а не перетаскивание
            mainFrame.Visible = true
            dockButton.Visible = false
            print("[XyqwHub] Dock clicked - opening window")
        end
        dockDragging = false
    end
end)
-- ========== ГЛАВНОЕ ОКНО ==========
mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 280, 0, 340)
mainFrame.Position = UDim2.new(0.5, -140, 0.5, -170)
mainFrame.BackgroundColor3 = RED_BG
mainFrame.BorderSizePixel = 3
mainFrame.BorderColor3 = RED_MAIN
mainFrame.ClipsDescendants = false
mainFrame.Parent = screenGui

local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.BackgroundColor3 = RED_TITLE
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(0, 80, 1, 0)
titleLabel.Position = UDim2.new(0, 5, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "XyqwHub"
titleLabel.TextColor3 = RED_MAIN
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

-- ========== КНОПКИ ЗАГОЛОВКА (все с обводкой, вплотную справа) ==========
-- Порядок справа налево: [X] [EN/RU] [S] [P] [C] [CL] [Th]
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseBtn"
closeButton.Size = UDim2.new(0, 22, 0.8, 0)
closeButton.Position = UDim2.new(1, -22, 0.1, 0)
closeButton.BackgroundColor3 = RED_DARK
closeButton.TextColor3 = RED_MAIN
closeButton.Text = "X"
closeButton.TextScaled = true
closeButton.Font = Enum.Font.GothamBold
closeButton.BorderSizePixel = 1
closeButton.BorderColor3 = RED_MAIN
closeButton.Parent = titleBar
closeButton.AutoButtonColor = false

local langButton = Instance.new("TextButton")
langButton.Name = "LangBtn"
langButton.Size = UDim2.new(0, 28, 0.8, 0)
langButton.Position = UDim2.new(1, -52, 0.1, 0)
langButton.BackgroundColor3 = RED_DARK
langButton.TextColor3 = RED_MAIN
langButton.Text = getgenv().XyqwLanguage
langButton.TextScaled = true
langButton.Font = Enum.Font.GothamBold
langButton.BorderSizePixel = 1
langButton.BorderColor3 = RED_MAIN
langButton.Parent = titleBar
langButton.AutoButtonColor = false

local serverBtn = Instance.new("TextButton")
serverBtn.Name = "ServerBtn"
serverBtn.Size = UDim2.new(0, 22, 0.8, 0)
serverBtn.Position = UDim2.new(1, -76, 0.1, 0)
serverBtn.BackgroundColor3 = RED_DARK
serverBtn.TextColor3 = RED_MAIN
serverBtn.Text = "S"
serverBtn.TextScaled = true
serverBtn.Font = Enum.Font.GothamBold
serverBtn.BorderSizePixel = 1
serverBtn.BorderColor3 = RED_MAIN
serverBtn.Parent = titleBar
serverBtn.AutoButtonColor = false

local playerBtn = Instance.new("TextButton")
playerBtn.Name = "PlayerBtn"
playerBtn.Size = UDim2.new(0, 22, 0.8, 0)
playerBtn.Position = UDim2.new(1, -100, 0.1, 0)
playerBtn.BackgroundColor3 = RED_DARK
playerBtn.TextColor3 = RED_MAIN
playerBtn.Text = "P"
playerBtn.TextScaled = true
playerBtn.Font = Enum.Font.GothamBold
playerBtn.BorderSizePixel = 1
playerBtn.BorderColor3 = RED_MAIN
playerBtn.Parent = titleBar
playerBtn.AutoButtonColor = false

local customBtn = Instance.new("TextButton")
customBtn.Name = "CustomBtn"
customBtn.Size = UDim2.new(0, 22, 0.8, 0)
customBtn.Position = UDim2.new(1, -124, 0.1, 0)
customBtn.BackgroundColor3 = RED_DARK
customBtn.TextColor3 = RED_MAIN
customBtn.Text = "C"
customBtn.TextScaled = true
customBtn.Font = Enum.Font.GothamBold
customBtn.BorderSizePixel = 1
customBtn.BorderColor3 = RED_MAIN
customBtn.Parent = titleBar
customBtn.AutoButtonColor = false

local changelogButton = Instance.new("TextButton")
changelogButton.Name = "ChLogBtn"
changelogButton.Size = UDim2.new(0, 26, 0.8, 0)
changelogButton.Position = UDim2.new(1, -152, 0.1, 0)
changelogButton.BackgroundColor3 = RED_DARK
changelogButton.TextColor3 = RED_MAIN
changelogButton.Text = "CL"
changelogButton.TextScaled = true
changelogButton.Font = Enum.Font.GothamBold
changelogButton.BorderSizePixel = 1
changelogButton.BorderColor3 = RED_MAIN
changelogButton.Parent = titleBar
changelogButton.AutoButtonColor = false

local themeBtn = Instance.new("TextButton")
themeBtn.Name = "ThemeBtn"
themeBtn.Size = UDim2.new(0, 24, 0.8, 0)
themeBtn.Position = UDim2.new(1, -178, 0.1, 0)
themeBtn.BackgroundColor3 = RED_DARK
themeBtn.TextColor3 = RED_MAIN
themeBtn.Text = "Th"
themeBtn.TextScaled = true
themeBtn.Font = Enum.Font.GothamBold
themeBtn.BorderSizePixel = 1
themeBtn.BorderColor3 = RED_MAIN
themeBtn.Parent = titleBar
themeBtn.AutoButtonColor = false

-- ========== SEARCH ==========
local searchBar = Instance.new("TextBox")
searchBar.Name = "SearchBar"
searchBar.Size = UDim2.new(1, -10, 0, 24)
searchBar.Position = UDim2.new(0, 5, 0, 35)
searchBar.BackgroundColor3 = RED_DARK
searchBar.PlaceholderText = _("Search")
searchBar.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
searchBar.Text = ""
searchBar.TextColor3 = RED_MAIN
searchBar.TextSize = 12
searchBar.Font = Enum.Font.Gotham
searchBar.TextXAlignment = Enum.TextXAlignment.Left
searchBar.ClearTextOnFocus = false
searchBar.BorderSizePixel = 1
searchBar.BorderColor3 = RED_MAIN
searchBar.Parent = mainFrame

-- ========== TABS ==========
local tabBar = Instance.new("Frame")
tabBar.Name = "TabBar"
tabBar.Size = UDim2.new(1, -10, 0, 24)
tabBar.Position = UDim2.new(0, 5, 0, 64)
tabBar.BackgroundTransparency = 1
tabBar.Parent = mainFrame

local TAB_LIST = {"All", "BB", "MM2", "INK", "Misc", "Fav", "Rct"}
local tabButtons = {}
local currentTab = "All"

local function SwitchTab(name)
    currentTab = name
    for n, btn in pairs(tabButtons) do
        if n == name then
            btn.BackgroundColor3 = RED_MAIN
            btn.TextColor3 = Color3.fromRGB(0, 0, 0)
        else
            btn.BackgroundColor3 = RED_DARK
            btn.TextColor3 = RED_MAIN
        end
    end
    if RefreshButtons then RefreshButtons() end
end

local tabW = 36
for i, name in ipairs(TAB_LIST) do
    local btn = Instance.new("TextButton")
    btn.Name = "Tab_" .. name
    btn.Size = UDim2.new(0, tabW, 1, 0)
    btn.Position = UDim2.new(0, (i - 1) * (tabW + 1), 0, 0)
    btn.BackgroundColor3 = RED_DARK
    btn.TextColor3 = RED_MAIN
    btn.Text = name
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 1
    btn.BorderColor3 = RED_MAIN
    btn.Parent = tabBar
    btn.AutoButtonColor = false
    tabButtons[name] = btn
    btn.MouseButton1Click:Connect(function() SwitchTab(name) end)
end

-- ========== SCROLL ==========
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Name = "ScriptScroll"
scrollFrame.Size = UDim2.new(1, -10, 1, -98)
scrollFrame.Position = UDim2.new(0, 5, 0, 93)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.ScrollBarThickness = 4
scrollFrame.ScrollBarImageColor3 = RED_MAIN
scrollFrame.Parent = mainFrame

local buttons = {}
local buttonHeight = 34

-- ========== СПИСОК СКРИПТОВ (48) ==========
local SCRIPTS = {
    {Name = "Blade Ball", Category = "BB", URL = "https://raw.githubusercontent.com/joshhhie/rise/refs/heads/main/loader.lua"},
    {Name = "Blade Ball 2", Category = "BB", URL = "https://wings.ac/loader"},
    {Name = "Blade Ball 3", Category = "BB", URL = "https://raw.githubusercontent.com/2xrW/return/refs/heads/main/hub"},
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
    {Name = "Kiti (MM2)", Category = "MM2", URL = "https://pastefy.app/gPuS4n3Q/raw"},
    {Name = "CandyWare (MM2)", Category = "MM2", URL = "https://raw.githubusercontent.com/Be1for/Scripts/refs/heads/main/candyware.luau"},
    {Name = "RemainsHub V2", Category = "Misc", URL = "https://rawscripts.net/raw/Universal-Script-RemainsHub-V2-50805"},
    {Name = "R6 Emotes", Category = "Misc", URL = "https://rawscripts.net/raw/Universal-Script-r6-emotes-OPEN-SOURCE-69464"},
    {Name = "Jujutsu Sheninagouns", Category = "Misc", URL = "https://raw.githubusercontent.com/peeky-co/scripts/refs/heads/main/tbo"},
    {Name = "Free Cam", Category = "Misc", URL = "https://rawscripts.net/raw/Universal-Script-Free-cam-script-pc-and-mobile-223089"},
    {Name = "Doors (Abysall)", Category = "Misc", URL = "https://rawscripts.net/raw/DOORS-Abysall-hub-OP-205906"},
    {Name = "Doors V2 (Copy)", Category = "Misc", URL = "SPECIAL_COPY_DOORS_V2"},
    {Name = "Doors V3 (Cheesy)", Category = "Misc", URL = "https://raw.githubusercontent.com/doram44/cheesy/refs/heads/main/cheesy.lua"},
    {Name = "Doors v4", Category = "Misc", URL = "https://raw.githubusercontent.com/sillyleo67/Doors/refs/heads/main/Twinkhook.lua"},
    {Name = "Fling Gui", Category = "Misc", URL = "https://rawscripts.net/raw/Universal-Script-fling-gui-99753"},
    {Name = "Infinite Yield", Category = "Misc", URL = "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"},
    {Name = "Walk on walls", Category = "Misc", URL = "https://rawscripts.net/raw/The-patience-obby-Universal-Walk-on-walls-18129"},
    {Name = "AetherX (Death Penalty)", Category = "Misc", URL = "https://api.luarmor.net/files/v3/loaders/8c08b8f2252eec7dbb77d253d269bb65.lua"},
    {Name = "Voidware (INK/99N/Forsaken)", Category = "Misc", URL = "https://files.vapevoidware.xyz/VapeVoidware/VW-Add/main/loader.lua"},
    {Name = "LaLol Hub (B4ckd0or)", Category = "Misc", URL = "https://raw.githubusercontent.com/Miygteet/Hacker101/refs/heads/main/LALOL-Backdoor-Secure.lua"},
    {Name = "FTAP", Category = "Misc", URL = "https://api.jnkie.com/api/v1/luascripts/public/4078649e4397f0e2cdaddde241d69bfd67b2b7107917891384735129c85cae18/download"},
    {Name = "MinhNat Hub (TSB)", Category = "Misc", URL = "https://rawscripts.net/raw/Universal-Script-MinhNhat-Tsb-62161"},
    {Name = "BC9 (UTG)", Category = "Misc", URL = "https://rawscripts.net/raw/untitled-tag-game-BC9-UTG-MENU-116806"},
    {Name = "FTAP (WITH KEY!!)", Category = "Misc", URL = "https://raw.githubusercontent.com/BlizTBr/scripts/main/FTAP.lua"},
    {Name = "RadiumHub (Pressure)", Category = "Misc", URL = "https://rawscripts.net/raw/UPDATE-Pressure-God-Mode-Auto-Loot-ESP-Full-Bright-No-Eyefestation-224409"},
    {Name = "Steal an egg", Category = "Misc", URL = "https://raw.githubusercontent.com/joustingmatch/Ouroboros/main/loader.lua"},
    {Name = "Universal script", Category = "Misc", URL = "https://raw.githubusercontent.com/fleecelolll/Fleece-s-Utility-Panel/refs/heads/main/Script.lua"},
    {Name = "Corridor", Category = "Misc", URL = "https://saga2015.b-cdn.net/corridor.luau"},
    {Name = "BloxStrike", Category = "Misc", URL = "https://raw.githubusercontent.com/Bac0nHck/Scripts/refs/heads/main/BloxStrike.lua"},
    {Name = "RIVALS", Category = "Misc", URL = "https://raw.githubusercontent.com/imshrak/rivals/refs/heads/main/main"},
    {Name = "Troll script", Category = "Misc", URL = "https://mois7.xyz/loader"},
    {Name = "Death Order [SIMON]", Category = "Misc", URL = "https://rawscripts.net/raw/Death-Order:-Simon-Says-BEST-DEATH-ORDER-SCRIPT-226542"},
    {Name = "DropKick", Category = "Misc", URL = "https://raw.githubusercontent.com/yes-d3v-scripts/drop-kick-fling/refs/heads/main/script"},
    {Name = "Evade", Category = "Misc", URL = "https://github.com/imc72s/LaztDex/raw/refs/heads/main/EvadeScriptLaztDex"},
    {Name = "A dusty trip", Category = "Misc", URL = "https://raw.githubusercontent.com/BalintTheDevXBack/Games/refs/heads/main/aDustyTrip"},
    {Name = "A dusty trip v2", Category = "Misc", URL = "https://raw.githubusercontent.com/VoxlarWIP/Src/refs/heads/main/adustytrip.lua"},
    {Name = "bLockman's minesweaper", Category = "Misc", URL = "https://pastefy.app/T5XIfiMo/raw"},
    {Name = "Cheating during test", Category = "Misc", URL = "https://files.catbox.moe/pkulzc.txt"},
    {Name = "Adopt me", Category = "Misc", URL = "https://raw.githubusercontent.com/JaxRol/ZeroPoint/refs/heads/main/KeySystem"},
}

local function CreateScriptButton(data)
    local container = Instance.new("Frame")
    container.Name = "Script_" .. data.Name
    container.Size = UDim2.new(1, -10, 0, 32)
    container.Position = UDim2.new(0, 5, 0, 0)
    container.BackgroundColor3 = RED_BG
    container.BorderSizePixel = 2
    container.BorderColor3 = RED_MAIN
    container.Parent = scrollFrame

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -26, 1, 0)
    btn.BackgroundTransparency = 1
    btn.TextColor3 = RED_MAIN
    btn.Text = data.Name
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = container
    btn.AutoButtonColor = false

    local star = Instance.new("TextButton")
    star.Name = "Star"
    star.Size = UDim2.new(0, 26, 1, 0)
    star.Position = UDim2.new(1, -26, 0, 0)
    star.BackgroundColor3 = RED_BG
    star.TextColor3 = RED_MAIN
    star.Text = "☆"
    star.TextScaled = true
    star.Font = Enum.Font.GothamBold
    star.BorderSizePixel = 1
    star.BorderColor3 = RED_MAIN
    star.Parent = container
    star.AutoButtonColor = false

    if getgenv().XyqwFavorites[data.Name] then star.Text = "★" end

    star.MouseButton1Click:Connect(function()
        if getgenv().XyqwFavorites[data.Name] then
            getgenv().XyqwFavorites[data.Name] = nil
            star.Text = "☆"
        else
            getgenv().XyqwFavorites[data.Name] = true
            star.Text = "★"
        end
    end)

    btn.MouseEnter:Connect(function() container.BackgroundColor3 = RED_DARK end)
    btn.MouseLeave:Connect(function() container.BackgroundColor3 = RED_BG end)

    local isRunning = false
    local lastRun = 0
    btn.MouseButton1Click:Connect(function()
        if isRunning then return end
        local now = tick()
        if now - lastRun < 1.5 then return end
        lastRun = now
        isRunning = true
        container.BackgroundColor3 = RED_MAIN

        for i, name in ipairs(getgenv().XyqwRecent) do
            if name == data.Name then table.remove(getgenv().XyqwRecent, i) break end
        end
        table.insert(getgenv().XyqwRecent, 1, data.Name)
        if #getgenv().XyqwRecent > 15 then table.remove(getgenv().XyqwRecent) end

        -- СПЕЦИАЛЬНАЯ ОБРАБОТКА
        if data.URL == "SPECIAL_COPY_DOORS_V2" then
            local scriptText = 'getgenv().SCRIPT_KEY = "KEYLESS"\nloadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/abd3cc54d2dc7de4a091fb19c8f4ea9e15e939e7ecc88b475e6956e8af94ad6f/download"))()'
            pcall(function() setclipboard(scriptText) end)
            print("[XyqwHub] Doors V2 - Script copied to clipboard!")
            ShowRobloxNotification("Doors V2 cannot be run via XyqwHub. Script copied to clipboard!", 5)
        else
            print("[XyqwHub] " .. data.Name .. " - STARTING...")
            local success, err = pcall(function()
                loadstring(game:HttpGet(data.URL))()
            end)
            if success then
                print("[XyqwHub] " .. data.Name .. " - " .. _("Loaded") .. "!")
                ShowRobloxNotification(data.Name .. " - " .. _("ScriptExecuted"), 3)
            else
                print("[XyqwHub] " .. data.Name .. " - " .. _("Error") .. ": " .. tostring(err))
                ShowRobloxNotification(data.Name .. " - " .. _("Error"), 5)
            end
        end

        task.wait(0.3)
        container.BackgroundColor3 = RED_BG
        isRunning = false
    end)

    table.insert(buttons, {Container = container, Btn = btn, Star = star, Data = data})
end

for _, data in ipairs(SCRIPTS) do CreateScriptButton(data) end

-- ========== SPECIAL (Remove Tags + Destroy) ==========
local specialContainer = Instance.new("Frame")
specialContainer.Name = "SpecialContainer"
specialContainer.Size = UDim2.new(1, -10, 0, 36)
specialContainer.Position = UDim2.new(0, 5, 0, 0)
specialContainer.BackgroundColor3 = RED_BG
specialContainer.BorderSizePixel = 2
specialContainer.BorderColor3 = RED_MAIN
specialContainer.Parent = scrollFrame
specialContainer.Visible = false

local removeTagsBtn = Instance.new("TextButton")
removeTagsBtn.Name = "RemoveTagsBtn"
removeTagsBtn.Size = UDim2.new(0.5, -2, 1, 0)
removeTagsBtn.BackgroundTransparency = 1
removeTagsBtn.Text = "Remove Tags"
removeTagsBtn.TextColor3 = RED_MAIN
removeTagsBtn.TextScaled = true
removeTagsBtn.Font = Enum.Font.GothamBold
removeTagsBtn.Parent = specialContainer
removeTagsBtn.AutoButtonColor = false

local destroyBtnMain = Instance.new("TextButton")
destroyBtnMain.Name = "DestroyBtn"
destroyBtnMain.Size = UDim2.new(0.5, -2, 1, 0)
destroyBtnMain.Position = UDim2.new(0.5, 2, 0, 0)
destroyBtnMain.BackgroundTransparency = 1
destroyBtnMain.Text = "Destroy XyqwHub"
destroyBtnMain.TextColor3 = RED_MAIN
destroyBtnMain.TextScaled = true
destroyBtnMain.Font = Enum.Font.GothamBold
destroyBtnMain.Parent = specialContainer
destroyBtnMain.AutoButtonColor = false

removeTagsBtn.MouseButton1Click:Connect(function()
    RemoveAllTags()
    tagsEnabled = false
    ShowRobloxNotification(_("TagRemoved"), 2)
    print("[XyqwHub] Tags removed")
end)

destroyBtnMain.MouseButton1Click:Connect(function()
    ShowRobloxNotification("XyqwHub Destroyed!", 2)
    getgenv().XyqwHubRunning = nil
    screenGui:Destroy()
end)

removeTagsBtn.MouseEnter:Connect(function() specialContainer.BackgroundColor3 = RED_DARK end)
destroyBtnMain.MouseEnter:Connect(function() specialContainer.BackgroundColor3 = RED_DARK end)
removeTagsBtn.MouseLeave:Connect(function() specialContainer.BackgroundColor3 = RED_BG end)
destroyBtnMain.MouseLeave:Connect(function() specialContainer.BackgroundColor3 = RED_BG end)

-- ========== REFRESH ==========
function RefreshButtons()
    local search = string.lower(searchBar.Text)
    local visible = 0
    for _, entry in ipairs(buttons) do
        local show = true
        if currentTab == "Fav" then
            if not getgenv().XyqwFavorites[entry.Data.Name] then show = false end
        elseif currentTab == "Rct" then
            local found = false
            for _, n in ipairs(getgenv().XyqwRecent) do
                if n == entry.Data.Name then found = true break end
            end
            if not found then show = false end
        elseif currentTab ~= "All" then
            if entry.Data.Category ~= currentTab then show = false end
        end
        if search ~= "" and not string.find(string.lower(entry.Data.Name), search, 1, true) then
            show = false
        end
        if show then
            entry.Container.Visible = true
            entry.Container.Position = UDim2.new(0, 5, 0, visible * buttonHeight + 5)
            visible = visible + 1
        else
            entry.Container.Visible = false
        end
    end
    specialContainer.Position = UDim2.new(0, 5, 0, visible * buttonHeight + 5)
    specialContainer.Visible = (currentTab == "All" and search == "")
    if specialContainer.Visible then visible = visible + 1 end
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, visible * buttonHeight + 20)
end

RefreshButtons()
searchBar:GetPropertyChangedSignal("Text"):Connect(RefreshButtons)

-- ========== CHANGE LOG ==========
local function ShowChangeLog()
    local frame = Instance.new("Frame")
    frame.Name = "ChangeLogFrame"
    frame.Size = UDim2.new(0, 350, 0, 350)
    frame.Position = UDim2.new(0.5, -175, 0.5, -175)
    frame.BackgroundColor3 = RED_BG
    frame.BorderSizePixel = 2
    frame.BorderColor3 = RED_MAIN
    frame.ZIndex = 50
    frame.Parent = screenGui

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -40, 0, 28)
    title.Position = UDim2.new(0, 5, 0, 5)
    title.BackgroundTransparency = 1
    title.TextColor3 = RED_MAIN
    title.Text = "ChangeLog"
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.ZIndex = 51
    title.Parent = frame

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 0, 28)
    closeBtn.Position = UDim2.new(1, -35, 0, 2)
    closeBtn.BackgroundTransparency = 1
    closeBtn.Text = "X"
    closeBtn.TextColor3 = RED_MAIN
    closeBtn.TextScaled = true
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.ZIndex = 51
    closeBtn.Parent = frame
    closeBtn.AutoButtonColor = false

    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, -10, 1, -45)
    scroll.Position = UDim2.new(0, 5, 0, 35)
    scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel = 0
    scroll.CanvasSize = UDim2.new(0, 0, 0, 3000)
    scroll.ScrollBarThickness = 4
    scroll.ScrollBarImageColor3 = RED_MAIN
    scroll.ZIndex = 51
    scroll.Parent = frame

    local text = Instance.new("TextLabel")
    text.Size = UDim2.new(1, -10, 0, 2990)
    text.Position = UDim2.new(0, 5, 0, 5)
    text.BackgroundTransparency = 1
    text.TextColor3 = RED_MAIN
    text.TextWrapped = true
    text.TextXAlignment = Enum.TextXAlignment.Left
    text.TextYAlignment = Enum.TextYAlignment.Top
    text.TextSize = 12
    text.Font = Enum.Font.Gotham
    text.Text = _("ChangeLogText")
    text.ZIndex = 51
    text.Parent = scroll

    closeBtn.MouseButton1Click:Connect(function() frame:Destroy() end)
end

changelogButton.MouseButton1Click:Connect(ShowChangeLog)

-- ========== СМЕНА ЯЗЫКА ==========
langButton.MouseButton1Click:Connect(function()
    if getgenv().XyqwLanguage == "EN" then getgenv().XyqwLanguage = "RU" else getgenv().XyqwLanguage = "EN" end
    langButton.Text = getgenv().XyqwLanguage
    searchBar.PlaceholderText = _("Search")
    ShowRobloxNotification(_("LangChanged"), 2)
end)

-- ========== PLAYER LIST ==========
local function ShowPlayerList()
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 350, 0, 400)
    frame.Position = UDim2.new(0.5, -175, 0.5, -200)
    frame.BackgroundColor3 = RED_BG
    frame.BorderSizePixel = 2
    frame.BorderColor3 = RED_MAIN
    frame.ZIndex = 50
    frame.Parent = screenGui

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -40, 0, 28)
    title.Position = UDim2.new(0, 5, 0, 5)
    title.BackgroundTransparency = 1
    title.TextColor3 = RED_MAIN
    title.Text = "Players (" .. #Players:GetPlayers() .. ")"
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.ZIndex = 51
    title.Parent = frame

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 0, 28)
    closeBtn.Position = UDim2.new(1, -35, 0, 2)
    closeBtn.BackgroundTransparency = 1
    closeBtn.Text = "X"
    closeBtn.TextColor3 = RED_MAIN
    closeBtn.TextScaled = true
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.ZIndex = 51
    closeBtn.Parent = frame
    closeBtn.AutoButtonColor = false

    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, -10, 1, -45)
    scroll.Position = UDim2.new(0, 5, 0, 35)
    scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel = 0
    scroll.CanvasSize = UDim2.new(0, 0, 0, #Players:GetPlayers() * 25 + 10)
    scroll.ScrollBarThickness = 4
    scroll.ScrollBarImageColor3 = RED_MAIN
    scroll.ZIndex = 51
    scroll.Parent = frame

    local yPos = 5
    for _, plr in ipairs(Players:GetPlayers()) do
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -10, 0, 22)
        label.Position = UDim2.new(0, 5, 0, yPos)
        label.BackgroundColor3 = RED_DARK
        label.TextColor3 = RED_MAIN
        label.Text = plr.Name .. " | ID: " .. plr.UserId
        label.TextScaled = true
        label.Font = Enum.Font.Gotham
        label.BorderSizePixel = 1
        label.BorderColor3 = RED_MAIN
        label.ZIndex = 51
        label.Parent = scroll
        yPos = yPos + 25
    end

    closeBtn.MouseButton1Click:Connect(function() frame:Destroy() end)
end

-- ========== SERVER INFO ==========
local function ShowServerInfo()
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 350, 0, 220)
    frame.Position = UDim2.new(0.5, -175, 0.5, -110)
    frame.BackgroundColor3 = RED_BG
    frame.BorderSizePixel = 2
    frame.BorderColor3 = RED_MAIN
    frame.ZIndex = 50
    frame.Parent = screenGui

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -40, 0, 28)
    title.Position = UDim2.new(0, 5, 0, 5)
    title.BackgroundTransparency = 1
    title.TextColor3 = RED_MAIN
    title.Text = "Server Info"
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.ZIndex = 51
    title.Parent = frame

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 0, 28)
    closeBtn.Position = UDim2.new(1, -35, 0, 2)
    closeBtn.BackgroundTransparency = 1
    closeBtn.Text = "X"
    closeBtn.TextColor3 = RED_MAIN
    closeBtn.TextScaled = true
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.ZIndex = 51
    closeBtn.Parent = frame
    closeBtn.AutoButtonColor = false

    local info = Instance.new("TextLabel")
    info.Size = UDim2.new(1, -20, 0, 130)
    info.Position = UDim2.new(0, 10, 0, 40)
    info.BackgroundTransparency = 1
    info.TextColor3 = RED_MAIN
    info.TextWrapped = true
    info.TextXAlignment = Enum.TextXAlignment.Left
    info.TextYAlignment = Enum.TextYAlignment.Top
    info.TextSize = 13
    info.Font = Enum.Font.Gotham
    info.Text = "PlaceId: " .. game.PlaceId .. "\nJobId: " .. game.JobId .. "\nPlayers: " .. #Players:GetPlayers() .. "/" .. Players.MaxPlayers .. "\nCreator: " .. game.CreatorId
    info.ZIndex = 51
    info.Parent = frame

    local copyBtn = Instance.new("TextButton")
    copyBtn.Size = UDim2.new(1, -20, 0, 28)
    copyBtn.Position = UDim2.new(0, 10, 1, -38)
    copyBtn.BackgroundColor3 = RED_MAIN
    copyBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    copyBtn.Text = "Copy JobId"
    copyBtn.TextScaled = true
    copyBtn.Font = Enum.Font.GothamBold
    copyBtn.BorderSizePixel = 0
    copyBtn.ZIndex = 51
    copyBtn.Parent = frame
    copyBtn.AutoButtonColor = false

    copyBtn.MouseButton1Click:Connect(function()
        pcall(function() setclipboard(game.JobId) end)
        ShowRobloxNotification(_("JobIdCopied"), 2)
    end)

    closeBtn.MouseButton1Click:Connect(function() frame:Destroy() end)
end

-- ========== CUSTOM SCRIPT ==========
local function ShowCustomScript()
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 350, 0, 175)
    frame.Position = UDim2.new(0.5, -175, 0.5, -87)
    frame.BackgroundColor3 = RED_BG
    frame.BorderSizePixel = 2
    frame.BorderColor3 = RED_MAIN
    frame.ZIndex = 50
    frame.Parent = screenGui

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -40, 0, 28)
    title.Position = UDim2.new(0, 5, 0, 5)
    title.BackgroundTransparency = 1
    title.TextColor3 = RED_MAIN
    title.Text = "Custom Script"
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.ZIndex = 51
    title.Parent = frame

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 0, 28)
    closeBtn.Position = UDim2.new(1, -35, 0, 2)
    closeBtn.BackgroundTransparency = 1
    closeBtn.Text = "X"
    closeBtn.TextColor3 = RED_MAIN
    closeBtn.TextScaled = true
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.ZIndex = 51
    closeBtn.Parent = frame
    closeBtn.AutoButtonColor = false

    local input = Instance.new("TextBox")
    input.Size = UDim2.new(1, -20, 0, 36)
    input.Position = UDim2.new(0, 10, 0, 40)
    input.BackgroundColor3 = RED_DARK
    input.TextColor3 = RED_MAIN
    input.PlaceholderText = _("CustomPlaceholder")
    input.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
    input.Text = ""
    input.TextSize = 12
    input.Font = Enum.Font.Gotham
    input.BorderSizePixel = 1
    input.BorderColor3 = RED_MAIN
    input.ZIndex = 51
    input.Parent = frame

    local hint = Instance.new("TextLabel")
    hint.Size = UDim2.new(1, -20, 0, 14)
    hint.Position = UDim2.new(0, 10, 0, 80)
    hint.BackgroundTransparency = 1
    hint.TextColor3 = Color3.fromRGB(150, 150, 150)
    hint.Text = "URL or loadstring(...) — both work"
    hint.TextScaled = true
    hint.Font = Enum.Font.Gotham
    hint.TextXAlignment = Enum.TextXAlignment.Left
    hint.ZIndex = 51
    hint.Parent = frame

    local runBtn = Instance.new("TextButton")
    runBtn.Size = UDim2.new(1, -20, 0, 36)
    runBtn.Position = UDim2.new(0, 10, 0, 102)
    runBtn.BackgroundColor3 = RED_MAIN
    runBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    runBtn.Text = _("RunCustom")
    runBtn.TextScaled = true
    runBtn.Font = Enum.Font.GothamBold
    runBtn.BorderSizePixel = 0
    runBtn.ZIndex = 51
    runBtn.Parent = frame
    runBtn.AutoButtonColor = false

    local function ExtractURL(text)
        if not text or text == "" then return nil end
        text = text:gsub("^%s+", ""):gsub("%s+$", "")
        local url = text:match('game:HttpGet%s*%(%s*["\']([^"\']+)["\']')
        if url then return url end
        if text:match("^https?://") then return text end
        local quoted = text:match('^["\'](https?://[^"\']+)["\']$')
        if quoted then return quoted end
        return nil
    end

    runBtn.MouseButton1Click:Connect(function()
        local url = ExtractURL(input.Text)
        if not url then
            ShowRobloxNotification("Invalid URL or loadstring!", 3)
            return
        end
        print("[XyqwHub] Custom - STARTING... (" .. url .. ")")
        local success, err = pcall(function() loadstring(game:HttpGet(url))() end)
        if success then
            print("[XyqwHub] Custom - " .. _("Loaded") .. "!")
            ShowRobloxNotification("Custom - " .. _("ScriptExecuted"), 3)
        else
            print("[XyqwHub] Custom - " .. _("Error") .. ": " .. tostring(err))
            ShowRobloxNotification("Custom - " .. _("Error"), 5)
        end
    end)

    closeBtn.MouseButton1Click:Connect(function() frame:Destroy() end)
end

customBtn.MouseButton1Click:Connect(ShowCustomScript)
playerBtn.MouseButton1Click:Connect(ShowPlayerList)
serverBtn.MouseButton1Click:Connect(ShowServerInfo)

-- ========== ТЕМЫ ==========
local themeOrder = {"Red", "Blue", "Green", "Purple", "Rainbow"}
local themeIndex = 1
for i, name in ipairs(themeOrder) do
    if name == getgenv().XyqwTheme then themeIndex = i break end
end

local function ApplyTheme(themeName)
    getgenv().XyqwTheme = themeName
    local t = THEMES[themeName]
    RED_MAIN = t.MAIN RED_DARK = t.DARK RED_BG = t.BG RED_TITLE = t.TITLE

    mainFrame.BackgroundColor3 = RED_BG
    mainFrame.BorderColor3 = RED_MAIN
    titleBar.BackgroundColor3 = RED_TITLE
    titleLabel.TextColor3 = RED_MAIN

    for _, btn in ipairs({closeButton, langButton, playerBtn, serverBtn, customBtn, changelogButton, themeBtn}) do
        btn.BackgroundColor3 = RED_DARK
        btn.TextColor3 = RED_MAIN
        btn.BorderColor3 = RED_MAIN
    end

    searchBar.BackgroundColor3 = RED_DARK
    searchBar.TextColor3 = RED_MAIN
    searchBar.BorderColor3 = RED_MAIN
    scrollFrame.ScrollBarImageColor3 = RED_MAIN

    for n, btn in pairs(tabButtons) do
        if n == currentTab then
            btn.BackgroundColor3 = RED_MAIN
            btn.TextColor3 = Color3.fromRGB(0, 0, 0)
        else
            btn.BackgroundColor3 = RED_DARK
            btn.TextColor3 = RED_MAIN
        end
        btn.BorderColor3 = RED_MAIN
    end

    for _, entry in ipairs(buttons) do
        entry.Container.BackgroundColor3 = RED_BG
        entry.Container.BorderColor3 = RED_MAIN
        entry.Btn.TextColor3 = RED_MAIN
        entry.Star.BackgroundColor3 = RED_BG
        entry.Star.TextColor3 = RED_MAIN
        entry.Star.BorderColor3 = RED_MAIN
    end

    specialContainer.BackgroundColor3 = RED_BG
    specialContainer.BorderColor3 = RED_MAIN
    removeTagsBtn.TextColor3 = RED_MAIN
    destroyBtnMain.TextColor3 = RED_MAIN

    topBar.BackgroundColor3 = RED_BG
    topBar.BorderColor3 = RED_MAIN
    topBarText.TextColor3 = RED_MAIN
    hideTopBtn.BackgroundColor3 = RED_DARK
    hideTopBtn.TextColor3 = RED_MAIN
    hideTopBtn.BorderColor3 = RED_MAIN

    dockButton.BackgroundColor3 = RED_BG
    dockButton.TextColor3 = RED_MAIN
    dockButton.BorderColor3 = RED_MAIN

    if themeName ~= "Rainbow" then ShowRobloxNotification("Theme: " .. themeName, 2) end
end

themeBtn.MouseButton1Click:Connect(function()
    themeIndex = themeIndex + 1
    if themeIndex > #themeOrder then themeIndex = 1 end
    ApplyTheme(themeOrder[themeIndex])
    if getgenv().XyqwTheme == "Rainbow" then ShowRobloxNotification("Theme: Rainbow", 2) end
end)

task.spawn(function()
    local hue = 0
    while screenGui.Parent do
        if getgenv().XyqwTheme == "Rainbow" then
            hue = (hue + 0.008) % 1
            local c = Color3.fromHSV(hue, 1, 1)
            local darkHue = Color3.fromHSV(hue, 1, 0.18)
            mainFrame.BorderColor3 = c
            titleBar.BackgroundColor3 = Color3.fromHSV(hue, 0.8, 0.08)
            titleLabel.TextColor3 = c
            for _, btn in ipairs({closeButton, langButton, playerBtn, serverBtn, customBtn, changelogButton, themeBtn}) do
                btn.BackgroundColor3 = darkHue
                btn.TextColor3 = c
                btn.BorderColor3 = c
            end
            searchBar.TextColor3 = c
            searchBar.BorderColor3 = c
            searchBar.BackgroundColor3 = darkHue
            scrollFrame.ScrollBarImageColor3 = c
            for n, btn in pairs(tabButtons) do
                if n == currentTab then
                    btn.BackgroundColor3 = c
                    btn.TextColor3 = Color3.fromRGB(0, 0, 0)
                else
                    btn.BackgroundColor3 = darkHue
                    btn.TextColor3 = c
                    btn.BorderColor3 = c
                end
            end
            for _, entry in ipairs(buttons) do
                entry.Container.BorderColor3 = c
                entry.Btn.TextColor3 = c
                entry.Star.TextColor3 = c
                entry.Star.BorderColor3 = c
                entry.Star.BackgroundColor3 = darkHue
            end
            specialContainer.BorderColor3 = c
            removeTagsBtn.TextColor3 = c
            destroyBtnMain.TextColor3 = c
            topBar.BorderColor3 = c
            topBarText.TextColor3 = c
            hideTopBtn.BackgroundColor3 = darkHue
            hideTopBtn.TextColor3 = c
            hideTopBtn.BorderColor3 = c
            dockButton.TextColor3 = c
            dockButton.BorderColor3 = c
        end
        task.wait(0.05)
    end
end)

-- ========== RESIZE ==========
local resizeHandle = Instance.new("TextButton")
resizeHandle.Name = "ResizeHandle"
resizeHandle.Size = UDim2.new(0, 14, 0, 14)
resizeHandle.Position = UDim2.new(1, -14, 1, -14)
resizeHandle.BackgroundColor3 = RED_MAIN
resizeHandle.Text = ""
resizeHandle.BorderSizePixel = 0
resizeHandle.ZIndex = 10
resizeHandle.Parent = mainFrame
resizeHandle.AutoButtonColor = false

local sizeLabel = Instance.new("TextLabel")
sizeLabel.Name = "SizeLabel"
sizeLabel.Size = UDim2.new(0, 70, 0, 14)
sizeLabel.Position = UDim2.new(1, -88, 1, -16)
sizeLabel.BackgroundTransparency = 1
sizeLabel.TextColor3 = RED_MAIN
sizeLabel.Text = "280 x 340"
sizeLabel.TextSize = 10
sizeLabel.Font = Enum.Font.Gotham
sizeLabel.TextXAlignment = Enum.TextXAlignment.Right
sizeLabel.ZIndex = 10
sizeLabel.Parent = mainFrame

local resizing = false
local resizeStart, resizeStartSize

resizeHandle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        resizing = true
        resizeStart = input.Position
        resizeStartSize = mainFrame.Size
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if resizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - resizeStart
        local newX = math.clamp(resizeStartSize.X.Offset + delta.X, 280, 900)
        local newY = math.clamp(resizeStartSize.Y.Offset + delta.Y, 340, 1000)
        mainFrame.Size = UDim2.new(0, newX, 0, newY)
        sizeLabel.Text = math.floor(newX) .. " x " .. math.floor(newY)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        resizing = false
    end
end)

-- ========== ПЕРЕТАСКИВАНИЕ ОКНА ==========
local dragging = false
local dragStart, startPos
titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        local mousePos = input.Position
        local function IsOverButton(btn)
            if not btn then return false end
            local p = btn.AbsolutePosition
            local s = btn.AbsoluteSize
            return mousePos.X >= p.X and mousePos.X <= p.X + s.X and mousePos.Y >= p.Y and mousePos.Y <= p.Y + s.Y
        end
        if IsOverButton(changelogButton) or IsOverButton(langButton) or IsOverButton(closeButton)
           or IsOverButton(themeBtn) or IsOverButton(customBtn) or IsOverButton(playerBtn) or IsOverButton(serverBtn) then
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
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- ========== ЗАКРЫТИЕ / ОТКРЫТИЕ ==========
closeButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    dockButton.Visible = true
end)

-- ========== WELCOME ==========
local function ShowWelcomeMessage()
    local frame = Instance.new("Frame")
    frame.Name = "WelcomeFrame"
    frame.Size = UDim2.new(0, 340, 0, 380)
    frame.Position = UDim2.new(0.5, -170, 0.5, -190)
    frame.BackgroundColor3 = RED_BG
    frame.BorderSizePixel = 2
    frame.BorderColor3 = RED_MAIN
    frame.ZIndex = 100
    frame.Parent = screenGui

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -10, 0, 25)
    title.Position = UDim2.new(0, 5, 0, 8)
    title.BackgroundTransparency = 1
    title.TextColor3 = RED_MAIN
    title.Text = "Welcome to XyqwHub!"
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.ZIndex = 101
    title.Parent = frame

    local tiktok = Instance.new("TextLabel")
    tiktok.Size = UDim2.new(1, -10, 0, 20)
    tiktok.Position = UDim2.new(0, 5, 0, 38)
    tiktok.BackgroundTransparency = 1
    tiktok.TextColor3 = Color3.fromRGB(255, 255, 255)
    tiktok.Text = "TikTok: xyqwerq.tvink"
    tiktok.TextScaled = true
    tiktok.Font = Enum.Font.Gotham
    tiktok.ZIndex = 101
    tiktok.Parent = frame

    local tg = Instance.new("TextLabel")
    tg.Size = UDim2.new(1, -10, 0, 20)
    tg.Position = UDim2.new(0, 5, 0, 60)
    tg.BackgroundTransparency = 1
    tg.TextColor3 = Color3.fromRGB(255, 255, 255)
    tg.Text = "Telegram: t.me/xyqwsquad"
    tg.TextScaled = true
    tg.Font = Enum.Font.Gotham
    tg.ZIndex = 101
    tg.Parent = frame

    local dc = Instance.new("TextLabel")
    dc.Size = UDim2.new(1, -10, 0, 20)
    dc.Position = UDim2.new(0, 5, 0, 82)
    dc.BackgroundTransparency = 1
    dc.TextColor3 = Color3.fromRGB(255, 255, 255)
    dc.Text = "Discord: xyqwerqyt"
    dc.TextScaled = true
    dc.Font = Enum.Font.Gotham
    dc.ZIndex = 101
    dc.Parent = frame

    local docTitle = Instance.new("TextLabel")
    docTitle.Size = UDim2.new(1, -10, 0, 18)
    docTitle.Position = UDim2.new(0, 5, 0, 110)
    docTitle.BackgroundTransparency = 1
    docTitle.TextColor3 = RED_MAIN
    docTitle.Text = "— Buttons —"
    docTitle.TextScaled = true
    docTitle.Font = Enum.Font.GothamBold
    docTitle.ZIndex = 101
    docTitle.Parent = frame

    local doc = Instance.new("TextLabel")
    doc.Size = UDim2.new(1, -10, 0, 220)
    doc.Position = UDim2.new(0, 5, 0, 130)
    doc.BackgroundTransparency = 1
    doc.TextColor3 = RED_MAIN
    doc.TextWrapped = true
    doc.TextXAlignment = Enum.TextXAlignment.Left
    doc.TextYAlignment = Enum.TextYAlignment.Top
    doc.TextSize = 11
    doc.Font = Enum.Font.Gotham
    doc.Text = "Th — Theme (Red/Blue/Green/Purple/Rainbow)\nCL — Changelog\nC — Custom Script (URL or loadstring)\nP — Players List\nS — Server Info\nH — Hide/Show Top Bar\nEN/RU — Language\nX — Close (minimize to dock)\n\nDock button: XyqwHub (click to open)\n\nBottom buttons:\nRemove Tags — remove OWNER/TESTER tags\nDestroy XyqwHub — full unload\n\nSpecial:\nDoors V2 (Copy) — copies script to clipboard\n\nResize — drag bottom-right corner\nWindow — drag by title bar"
    doc.ZIndex = 101
    doc.Parent = frame

    local ver = Instance.new("TextLabel")
    ver.Size = UDim2.new(1, -10, 0, 18)
    ver.Position = UDim2.new(0, 5, 1, -24)
    ver.BackgroundTransparency = 1
    ver.TextColor3 = Color3.fromRGB(150, 150, 150)
    ver.Text = "Version: " .. VERSION
    ver.TextScaled = true
    ver.Font = Enum.Font.Gotham
    ver.ZIndex = 101
    ver.Parent = frame

    task.wait(7)
    if frame.Parent then frame:Destroy() end
end

-- ========== ФИНАЛ ==========
task.spawn(function()
    task.wait(0.5)
    ShowRobloxNotification("XyqwHub Loaded!", 4)
    print("[XyqwHub] XyqwHub Loaded! Version: " .. VERSION)
end)

task.spawn(function()
    task.wait(1.2)
    ShowWelcomeMessage()
end)

task.spawn(function()
    task.wait(2.5)
    if IsOwner() then ShowRobloxNotification(_("OwnerWelcome"), 5)
    elseif IsBeta() then ShowRobloxNotification(_("BetaWelcome"), 5) end
end)
