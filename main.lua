-- ========== XyqwHub - Версия 4.1 ==========
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "XyqwHub",
    Text = "XyqwHub Loading...",
    Duration = 3
})
print("[XyqwHub] Loading...")

if getgenv().XyqwHubRunning then
    local msg = "Script re-launch has been blocked!"
    if getgenv().XyqwLanguage == "RU" then
        msg = "Повторный запуск скрипта был заблокирован!"
    end
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = "XyqwHub", Text = msg, Duration = 5})
    print("[XyqwHub] " .. msg)
    return
end

getgenv().XyqwHubRunning = true

local VERSION = "4.1"
local OWNER_IDS = {4396977722, 8527910367}
local BETA_IDS = {9686718765, 3701387385}

if getgenv().XyqwLanguage == nil then getgenv().XyqwLanguage = "EN" end
if getgenv().XyqwFavorites == nil then getgenv().XyqwFavorites = {} end
if getgenv().XyqwRecent == nil then getgenv().XyqwRecent = {} end
if getgenv().XyqwTheme == nil then getgenv().XyqwTheme = "Red" end

-- ========== ТЕМЫ ==========
local THEMES = {
    Red = {
        MAIN = Color3.fromRGB(255, 0, 0),
        DARK = Color3.fromRGB(40, 0, 0),
        BG = Color3.fromRGB(0, 0, 0),
        TITLE = Color3.fromRGB(20, 0, 0),
    },
    Blue = {
        MAIN = Color3.fromRGB(0, 140, 255),
        DARK = Color3.fromRGB(0, 20, 50),
        BG = Color3.fromRGB(0, 0, 0),
        TITLE = Color3.fromRGB(0, 10, 25),
    },
    Green = {
        MAIN = Color3.fromRGB(0, 220, 90),
        DARK = Color3.fromRGB(0, 40, 15),
        BG = Color3.fromRGB(0, 0, 0),
        TITLE = Color3.fromRGB(0, 20, 8),
    },
    Rainbow = {
        MAIN = Color3.fromRGB(255, 0, 0),
        DARK = Color3.fromRGB(40, 0, 40),
        BG = Color3.fromRGB(0, 0, 0),
        TITLE = Color3.fromRGB(20, 0, 20),
    },
}

local RED_MAIN = THEMES[getgenv().XyqwTheme].MAIN
local RED_DARK = THEMES[getgenv().XyqwTheme].DARK
local RED_BG = THEMES[getgenv().XyqwTheme].BG
local RED_TITLE = THEMES[getgenv().XyqwTheme].TITLE

local themeElements = {}
local function RegisterThemeElement(obj, key)
    table.insert(themeElements, {obj = obj, key = key})
end

-- ========== ЯЗЫКИ ==========
local LANG = {
    EN = {
        Loaded = "loaded",
        Error = "error",
        Search = "Search...",
        CustomPlaceholder = "Paste URL...",
        RunCustom = "Run",
        JobIdCopied = "JobId copied!",
        ScriptExecuted = "Script executed!",
        OwnerWelcome = "Welcome, my father :3",
        BetaWelcome = "Glad you're here, tester <3",
        ChangeLogText = [[XyqwHub ChangeLog

Version 4.1
- All buttons squared
- Bright red instead of yellow
- Resize in bottom right corner
- Small start size (250x300)
- Buttons in 1 row
- Removed GetTheme()
- Added 4 themes (Red, Blue, Green, Rainbow)
- Destroy button at bottom of script list
- Dock button "XyqwHub" rounded
- Welcome lists keybinds
- Size indicator near resize

Version 4.0
- First 4.0 release

Version 3.9
- Script executed notification

Version 3.8
- Added tabs (All, BB, MM2, INK, Misc, Fav, Rct)
- Favorites & Recent

Version 3.5
- Added 48 scripts
- Search bar

Version 3.0
- Added OWNER/TESTER tags
- Anti-AFK

Version 2.5
- Added ChangeLog
- Player list
- Server info

Version 2.0
- Added resize
- Dock button

Version 1.5
- Added language switch (EN/RU)
- Welcome message

Version 1.0
- First release]],
    },
    RU = {
        Loaded = "загружен",
        Error = "ошибка",
        Search = "Поиск...",
        CustomPlaceholder = "Ссылка...",
        RunCustom = "Запустить",
        JobIdCopied = "JobId скопирован!",
        ScriptExecuted = "Скрипт выполнен!",
        OwnerWelcome = "Welcome, my father :3",
        BetaWelcome = "Glad you're here, tester <3",
        ChangeLogText = [[XyqwHub Ченджлог

Версия 4.1
- Все кнопки квадратные
- Ярко-красный вместо жёлтого
- Ресайз в правом нижнем углу
- Маленький стартовый размер (250x300)
- Кнопки в 1 ряд
- Убран GetTheme()
- Добавлено 4 темы (Red, Blue, Green, Rainbow)
- Кнопка Destroy внизу списка скриптов
- Док-кнопка "XyqwHub" закруглённая
- Welcome список кнопок
- Индикатор размера у resize

Версия 4.0
- Первый релиз 4.0

Версия 3.9
- Уведомление Script executed

Версия 3.8
- Добавлены вкладки (All, BB, MM2, INK, Misc, Fav, Rct)
- Избранное и недавние

Версия 3.5
- Добавлено 48 скриптов
- Строка поиска

Версия 3.0
- Добавлены теги OWNER/TESTER
- Анти-АФК

Версия 2.5
- Добавлен ChangeLog
- Список игроков
- Инфо о сервере

Версия 2.0
- Добавлен ресайз
- Док-кнопка

Версия 1.5
- Добавлена смена языка (EN/RU)
- Welcome сообщение

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

-- ========== РОЛИ ==========
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local function IsOwner()
    local lp = Players.LocalPlayer
    for _, id in ipairs(OWNER_IDS) do
        if lp.UserId == id then return true end
    end
    return false
end

local function IsBeta()
    local lp = Players.LocalPlayer
    for _, id in ipairs(BETA_IDS) do
        if lp.UserId == id then return true end
    end
    return false
end

if IsOwner() then
    task.wait(0.5)
    ShowRobloxNotification(_("OwnerWelcome"), 5)
elseif IsBeta() then
    task.wait(0.5)
    ShowRobloxNotification(_("BetaWelcome"), 5)
end

-- ========== ТЕГИ ==========
local tagsEnabled = true
local activeTags = {}

local function GetRole(plr)
    for _, id in ipairs(OWNER_IDS) do
        if plr.UserId == id then return "OWNER" end
    end
    for _, id in ipairs(BETA_IDS) do
        if plr.UserId == id then return "TESTER" end
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

-- ========== СОЗДАНИЕ GUI ==========
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "XyqwHub"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
pcall(function()
    screenGui.Parent = game:GetService("CoreGui")
end)
if not screenGui.Parent then
    screenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
end

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 250, 0, 300)
mainFrame.Position = UDim2.new(0.5, -125, 0.5, -150)
mainFrame.BackgroundColor3 = RED_BG
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = RED_MAIN
mainFrame.Active = true
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 28)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundColor3 = RED_TITLE
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(0, 100, 1, 0)
titleLabel.Position = UDim2.new(0, 5, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "XyqwHub"
titleLabel.TextColor3 = RED_MAIN
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

-- Кнопки заголовка (прижаты к правому краю)
local function CreateHeaderButton(name, text, xOffset, width, bgColor, txtColor, callback)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(0, width, 0, 22)
    btn.Position = UDim2.new(1, xOffset, 0.5, -11)
    btn.BackgroundColor3 = bgColor
    btn.Text = text
    btn.TextColor3 = txtColor
    btn.TextSize = 10
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 1
    btn.BorderColor3 = RED_MAIN
    btn.AutoButtonColor = false
    btn.Parent = titleBar
    btn.MouseButton1Click:Connect(callback)
    RegisterThemeElement(btn, "HEADER")
    return btn
end

local closeButton = CreateHeaderButton("CloseBtn", "X", -22, 22, RED_MAIN, Color3.fromRGB(0, 0, 0), function() end)
local langButton = CreateHeaderButton("LangBtn", getgenv().XyqwLanguage or "EN", -52, 28, RED_DARK, RED_MAIN, function() end)
local serverBtn = CreateHeaderButton("ServerBtn", "S", -74, 22, RED_DARK, RED_MAIN, function() end)
local playerBtn = CreateHeaderButton("PlayerBtn", "P", -96, 22, RED_DARK, RED_MAIN, function() end)
local customBtn = CreateHeaderButton("CustomBtn", "C", -118, 22, RED_DARK, RED_MAIN, function() end)
local changelogButton = CreateHeaderButton("ChLogBtn", "CL", -143, 22, RED_DARK, RED_MAIN, function() end)
local themeBtn = CreateHeaderButton("ThemeBtn", "Th", -165, 22, RED_DARK, RED_MAIN, function() end)

-- Авто-скрытие имени при маленьком окне
local function UpdateHeaderText()
    local w = mainFrame.AbsoluteSize.X
    if w < 320 then
        titleLabel.Text = "XH"
    else
        titleLabel.Text = "XyqwHub"
    end
end

-- Док-кнопка
local dockButton = Instance.new("TextButton")
dockButton.Name = "DockButton"
dockButton.Size = UDim2.new(0, 110, 0, 34)
dockButton.Position = UDim2.new(0, 20, 0.5, -17)
dockButton.BackgroundColor3 = RED_BG
dockButton.Text = "XyqwHub"
dockButton.TextColor3 = RED_MAIN
dockButton.TextSize = 15
dockButton.Font = Enum.Font.GothamBold
dockButton.BorderSizePixel = 0
dockButton.AutoButtonColor = false
dockButton.Visible = false
dockButton.Parent = screenGui

local dockCorner = Instance.new("UICorner")
dockCorner.CornerRadius = UDim.new(1, 0)
dockCorner.Parent = dockButton

local dockStroke = Instance.new("UIStroke")
dockStroke.Color = RED_MAIN
dockStroke.Thickness = 2
dockStroke.Parent = dockButton

-- Индикатор размера
local sizeLabel = Instance.new("TextLabel")
sizeLabel.Name = "SizeLabel"
sizeLabel.Size = UDim2.new(0, 70, 0, 14)
sizeLabel.Position = UDim2.new(1, -86, 1, -16)
sizeLabel.BackgroundTransparency = 1
sizeLabel.TextColor3 = RED_MAIN
sizeLabel.Text = "250 x 300"
sizeLabel.TextSize = 10
sizeLabel.Font = Enum.Font.Gotham
sizeLabel.TextXAlignment = Enum.TextXAlignment.Right
sizeLabel.Parent = mainFrame
-- ========== SEARCH ==========
local searchBar = Instance.new("TextBox")
searchBar.Name = "SearchBar"
searchBar.Size = UDim2.new(1, -10, 0, 24)
searchBar.Position = UDim2.new(0, 5, 0, 32)
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
tabBar.Position = UDim2.new(0, 5, 0, 60)
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

local tabW = 33
for i, name in ipairs(TAB_LIST) do
    local btn = Instance.new("TextButton")
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
scrollFrame.Size = UDim2.new(1, -10, 1, -94)
scrollFrame.Position = UDim2.new(0, 5, 0, 88)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.ScrollBarThickness = 4
scrollFrame.ScrollBarImageColor3 = RED_MAIN
scrollFrame.Parent = mainFrame

-- ========== СПИСОК СКРИПТОВ ==========
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
    {Name = "Doors v4", Category = "Misc", URL = "https://raw.githubusercontent.com/sillyleo67/Doors/refs/heads/main/Twinkhook.lua"},
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
    {Name = "DropKick", Category = "Misc", URL = "https://raw.githubusercontent.com/yes-d3v-scripts/drop-kick-fling/refs/heads/main/script"},
    {Name = "Evade", Category = "Misc", URL = "https://github.com/imc72s/LaztDex/raw/refs/heads/main/EvadeScriptLaztDex"},
    {Name = "A dusty trip", Category = "Misc", URL = "https://raw.githubusercontent.com/BalintTheDevXBack/Games/refs/heads/main/aDustyTrip"},
    {Name = "A dusty trip v2", Category = "Misc", URL = "https://raw.githubusercontent.com/VoxlarWIP/Src/refs/heads/main/adustytrip.lua"},
    {Name = "bLockman's minesweaper", Category = "Misc", URL = "https://pastefy.app/T5XIfiMo/raw"},
    {Name = "Cheating during test", Category = "Misc", URL = "https://files.catbox.moe/pkulzc.txt"},
    {Name = "Adopt me", Category = "Misc", URL = "https://raw.githubusercontent.com/JaxRol/ZeroPoint/refs/heads/main/KeySystem"},
}

local buttons = {}
local buttonHeight = 34

-- ========== ФУНКЦИЯ СОЗДАНИЯ КНОПКИ ==========
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
    btn.Position = UDim2.new(0, 0, 0, 0)
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
        task.wait(0.3)
        container.BackgroundColor3 = RED_BG
        isRunning = false
    end)

    table.insert(buttons, {Container = container, Btn = btn, Star = star, Data = data})
end

for _, data in ipairs(SCRIPTS) do
    CreateScriptButton(data)
end

-- ========== КНОПКА DESTROY (внизу списка) ==========
local destroyContainer = Instance.new("Frame")
destroyContainer.Name = "DestroyContainer"
destroyContainer.Size = UDim2.new(1, -10, 0, 36)
destroyContainer.Position = UDim2.new(0, 5, 0, 0)
destroyContainer.BackgroundColor3 = RED_BG
destroyContainer.BorderSizePixel = 2
destroyContainer.BorderColor3 = RED_MAIN
destroyContainer.Parent = scrollFrame

local destroyBtnMain = Instance.new("TextButton")
destroyBtnMain.Size = UDim2.new(1, 0, 1, 0)
destroyBtnMain.BackgroundTransparency = 1
destroyBtnMain.Text = "Destroy XyqwHub"
destroyBtnMain.TextColor3 = RED_MAIN
destroyBtnMain.TextScaled = true
destroyBtnMain.Font = Enum.Font.GothamBold
destroyBtnMain.Parent = destroyContainer
destroyBtnMain.AutoButtonColor = false

destroyBtnMain.MouseButton1Click:Connect(function()
    ShowRobloxNotification("XyqwHub Destroyed!", 2)
    getgenv().XyqwHubRunning = nil
    screenGui:Destroy()
end)

destroyBtnMain.MouseEnter:Connect(function() destroyContainer.BackgroundColor3 = RED_DARK end)
destroyBtnMain.MouseLeave:Connect(function() destroyContainer.BackgroundColor3 = RED_BG end)

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
    destroyContainer.Position = UDim2.new(0, 5, 0, visible * buttonHeight + 5)
    visible = visible + 1
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, visible * buttonHeight + 20)
end

RefreshButtons()
searchBar:GetPropertyChangedSignal("Text"):Connect(RefreshButtons)
-- ========== CHANGE LOG ==========
local function ShowChangeLog()
    local frame = Instance.new("Frame")
    frame.Name = "ChangeLogFrame"
    frame.Size = UDim2.new(0, 350, 0, 320)
    frame.Position = UDim2.new(0.5, -175, 0.5, -160)
    frame.BackgroundColor3 = RED_BG
    frame.BorderSizePixel = 2
    frame.BorderColor3 = RED_MAIN
    frame.Parent = screenGui

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -40, 0, 28)
    title.Position = UDim2.new(0, 5, 0, 5)
    title.BackgroundTransparency = 1
    title.TextColor3 = RED_MAIN
    title.Text = "ChangeLog"
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = frame

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 0, 28)
    closeBtn.Position = UDim2.new(1, -35, 0, 2)
    closeBtn.BackgroundTransparency = 1
    closeBtn.Text = "X"
    closeBtn.TextColor3 = RED_MAIN
    closeBtn.TextScaled = true
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Parent = frame
    closeBtn.AutoButtonColor = false

    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, -10, 1, -45)
    scroll.Position = UDim2.new(0, 5, 0, 35)
    scroll.BackgroundTransparency = 1
    scroll.CanvasSize = UDim2.new(0, 0, 0, 1500)
    scroll.ScrollBarThickness = 4
    scroll.ScrollBarImageColor3 = RED_MAIN
    scroll.Parent = frame

    local text = Instance.new("TextLabel")
    text.Size = UDim2.new(1, -10, 0, 1490)
    text.Position = UDim2.new(0, 5, 0, 5)
    text.BackgroundTransparency = 1
    text.TextColor3 = RED_MAIN
    text.TextWrapped = true
    text.TextXAlignment = Enum.TextXAlignment.Left
    text.TextYAlignment = Enum.TextYAlignment.Top
    text.TextSize = 13
    text.Font = Enum.Font.Gotham
    text.Text = _("ChangeLogText")
    text.Parent = scroll

    closeBtn.MouseButton1Click:Connect(function() frame:Destroy() end)
end

-- ========== СМЕНА ЯЗЫКА ==========
local function SwitchLanguage()
    if getgenv().XyqwLanguage == "EN" then
        getgenv().XyqwLanguage = "RU"
    else
        getgenv().XyqwLanguage = "EN"
    end
    langButton.Text = getgenv().XyqwLanguage
    searchBar.PlaceholderText = _("Search")
    ShowRobloxNotification("Language: " .. getgenv().XyqwLanguage, 2)
end

-- ========== PLAYER LIST ==========
local function ShowPlayerList()
    local frame = Instance.new("Frame")
    frame.Name = "PlayerListFrame"
    frame.Size = UDim2.new(0, 350, 0, 400)
    frame.Position = UDim2.new(0.5, -175, 0.5, -200)
    frame.BackgroundColor3 = RED_BG
    frame.BorderSizePixel = 2
    frame.BorderColor3 = RED_MAIN
    frame.Parent = screenGui

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -40, 0, 28)
    title.Position = UDim2.new(0, 5, 0, 5)
    title.BackgroundTransparency = 1
    title.TextColor3 = RED_MAIN
    title.Text = "Players (" .. #Players:GetPlayers() .. ")"
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = frame

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 0, 28)
    closeBtn.Position = UDim2.new(1, -35, 0, 2)
    closeBtn.BackgroundTransparency = 1
    closeBtn.Text = "X"
    closeBtn.TextColor3 = RED_MAIN
    closeBtn.TextScaled = true
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Parent = frame
    closeBtn.AutoButtonColor = false

    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, -10, 1, -45)
    scroll.Position = UDim2.new(0, 5, 0, 35)
    scroll.BackgroundTransparency = 1
    scroll.CanvasSize = UDim2.new(0, 0, 0, #Players:GetPlayers() * 25 + 10)
    scroll.ScrollBarThickness = 4
    scroll.ScrollBarImageColor3 = RED_MAIN
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
        label.Parent = scroll
        yPos = yPos + 25
    end

    closeBtn.MouseButton1Click:Connect(function() frame:Destroy() end)
end

-- ========== SERVER INFO ==========
local function ShowServerInfo()
    local frame = Instance.new("Frame")
    frame.Name = "ServerInfoFrame"
    frame.Size = UDim2.new(0, 350, 0, 220)
    frame.Position = UDim2.new(0.5, -175, 0.5, -110)
    frame.BackgroundColor3 = RED_BG
    frame.BorderSizePixel = 2
    frame.BorderColor3 = RED_MAIN
    frame.Parent = screenGui

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -40, 0, 28)
    title.Position = UDim2.new(0, 5, 0, 5)
    title.BackgroundTransparency = 1
    title.TextColor3 = RED_MAIN
    title.Text = "Server Info"
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = frame

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 0, 28)
    closeBtn.Position = UDim2.new(1, -35, 0, 2)
    closeBtn.BackgroundTransparency = 1
    closeBtn.Text = "X"
    closeBtn.TextColor3 = RED_MAIN
    closeBtn.TextScaled = true
    closeBtn.Font = Enum.Font.GothamBold
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
    info.Text = "PlaceId: " .. game.PlaceId .. "\n" ..
                 "JobId: " .. game.JobId .. "\n" ..
                 "Players: " .. #Players:GetPlayers() .. "/" .. Players.MaxPlayers .. "\n" ..
                 "Creator: " .. game.CreatorId
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
    frame.Name = "CustomScriptFrame"
    frame.Size = UDim2.new(0, 350, 0, 160)
    frame.Position = UDim2.new(0.5, -175, 0.5, -80)
    frame.BackgroundColor3 = RED_BG
    frame.BorderSizePixel = 2
    frame.BorderColor3 = RED_MAIN
    frame.Parent = screenGui

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -40, 0, 28)
    title.Position = UDim2.new(0, 5, 0, 5)
    title.BackgroundTransparency = 1
    title.TextColor3 = RED_MAIN
    title.Text = "Custom Script"
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = frame

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 0, 28)
    closeBtn.Position = UDim2.new(1, -35, 0, 2)
    closeBtn.BackgroundTransparency = 1
    closeBtn.Text = "X"
    closeBtn.TextColor3 = RED_MAIN
    closeBtn.TextScaled = true
    closeBtn.Font = Enum.Font.GothamBold
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
    input.TextSize = 13
    input.Font = Enum.Font.Gotham
    input.BorderSizePixel = 1
    input.BorderColor3 = RED_MAIN
    input.Parent = frame

    local runBtn = Instance.new("TextButton")
    runBtn.Size = UDim2.new(1, -20, 0, 36)
    runBtn.Position = UDim2.new(0, 10, 0, 86)
    runBtn.BackgroundColor3 = RED_MAIN
    runBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    runBtn.Text = _("RunCustom")
    runBtn.TextScaled = true
    runBtn.Font = Enum.Font.GothamBold
    runBtn.BorderSizePixel = 0
    runBtn.Parent = frame
    runBtn.AutoButtonColor = false

-- Универсальный запуск: принимает и URL, и полный loadstring
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
        print("[XyqwHub] Custom - error: invalid input")
        return
    end

    print("[XyqwHub] Custom - STARTING... (" .. url .. ")")
    local success, err = pcall(function()
        loadstring(game:HttpGet(url))()
    end)
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

-- ========== ПРИВЯЗКА КНОПОК ЗАГОЛОВКА ==========
changelogButton.MouseButton1Click:Connect(ShowChangeLog)
customBtn.MouseButton1Click:Connect(ShowCustomScript)
playerBtn.MouseButton1Click:Connect(ShowPlayerList)
serverBtn.MouseButton1Click:Connect(ShowServerInfo)
langButton.MouseButton1Click:Connect(SwitchLanguage)

-- ========== ТЕМЫ ==========
local themeOrder = {"Red", "Blue", "Green", "Rainbow"}
local themeIndex = 1
for i, name in ipairs(themeOrder) do
    if name == getgenv().XyqwTheme then themeIndex = i break end
end

local function ApplyTheme(themeName)
    getgenv().XyqwTheme = themeName
    local t = THEMES[themeName]
    RED_MAIN = t.MAIN
    RED_DARK = t.DARK
    RED_BG = t.BG
    RED_TITLE = t.TITLE

    for _, el in ipairs(themeElements) do
        if el.key == "HEADER" then
            if el.obj.Name == "CloseBtn" then
                el.obj.BackgroundColor3 = RED_MAIN
                el.obj.TextColor3 = Color3.fromRGB(0, 0, 0)
            else
                el.obj.BackgroundColor3 = RED_DARK
                el.obj.TextColor3 = RED_MAIN
            end
            el.obj.BorderColor3 = RED_MAIN
        end
    end

    mainFrame.BackgroundColor3 = RED_BG
    mainFrame.BorderColor3 = RED_MAIN
    titleBar.BackgroundColor3 = RED_TITLE
    titleLabel.TextColor3 = RED_MAIN
    searchBar.BackgroundColor3 = RED_DARK
    searchBar.TextColor3 = RED_MAIN
    searchBar.BorderColor3 = RED_MAIN
    scrollFrame.ScrollBarImageColor3 = RED_MAIN
    sizeLabel.TextColor3 = RED_MAIN
    dockButton.TextColor3 = RED_MAIN
    dockStroke.Color = RED_MAIN

    for _, entry in ipairs(buttons) do
        entry.Container.BorderColor3 = RED_MAIN
        entry.Btn.TextColor3 = RED_MAIN
        entry.Star.TextColor3 = RED_MAIN
        entry.Star.BorderColor3 = RED_MAIN
    end

    destroyContainer.BorderColor3 = RED_MAIN
    destroyBtnMain.TextColor3 = RED_MAIN

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

    if themeName ~= "Rainbow" then
        ShowRobloxNotification("Theme: " .. themeName, 2)
    end
end

themeBtn.MouseButton1Click:Connect(function()
    themeIndex = themeIndex + 1
    if themeIndex > #themeOrder then themeIndex = 1 end
    ApplyTheme(themeOrder[themeIndex])
    if getgenv().XyqwTheme == "Rainbow" then
        ShowRobloxNotification("Theme: Rainbow", 2)
    end
end)

-- Rainbow loop
task.spawn(function()
    local hue = 0
    while screenGui.Parent do
        if getgenv().XyqwTheme == "Rainbow" then
            hue = (hue + 0.008) % 1
            local c = Color3.fromHSV(hue, 1, 1)
            mainFrame.BorderColor3 = c
            titleBar.BackgroundColor3 = Color3.fromHSV(hue, 0.8, 0.08)
            titleLabel.TextColor3 = c
            closeButton.BackgroundColor3 = c
            searchBar.TextColor3 = c
            searchBar.BorderColor3 = c
            scrollFrame.ScrollBarImageColor3 = c
            dockButton.TextColor3 = c
            dockStroke.Color = c
            sizeLabel.TextColor3 = c
            for _, entry in ipairs(buttons) do
                entry.Container.BorderColor3 = c
                entry.Btn.TextColor3 = c
                entry.Star.TextColor3 = c
                entry.Star.BorderColor3 = c
            end
            for n, btn in pairs(tabButtons) do
                if n == currentTab then
                    btn.BackgroundColor3 = c
                    btn.TextColor3 = Color3.fromRGB(0, 0, 0)
                else
                    btn.TextColor3 = c
                    btn.BorderColor3 = c
                end
            end
            destroyContainer.BorderColor3 = c
            destroyBtnMain.TextColor3 = c
        end
        task.wait(0.05)
    end
end)
