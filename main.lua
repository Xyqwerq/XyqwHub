-- ========== XyqwHub - Версия 4.2 ==========
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "XyqwHub",
    Text = "XyqwHub Loading...",
    Duration = 3
})
print("[XyqwHub] Loading...")

if getgenv().XyqwHubRunning then
    local msg = "Повторный запуск скрипта был заблокирован!"
    if getgenv().XyqwLanguage == "EN" then
        msg = "Script re-launch has been blocked!"
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
if getgenv().TopBarHidden == nil then getgenv().TopBarHidden = false end

local RED_MAIN = Color3.fromRGB(255, 0, 0)
local RED_DARK = Color3.fromRGB(40, 0, 0)
local RED_BG = Color3.fromRGB(0, 0, 0)
local RED_TITLE = Color3.fromRGB(20, 0, 0)

local LANG = {
    EN = {
        WindowTitle = "XyqwHub",
        ChangeLogBtn = "ChLog",
        RemoveTagBtn = "Remove Tag",
        Loaded = "loaded",
        Error = "error",
        Search = "Search...",
        CustomScript = "Custom",
        CustomPlaceholder = "Paste URL...",
        RunCustom = "Run",
        PlayerList = "Players",
        ServerInfo = "Server",
        JobIdCopied = "JobId copied!",
        HideTopBarOn = "Hide Top Bar: ON",
        HideTopBarOff = "Hide Top Bar: OFF",
        ScriptExecuted = "Script executed!",
        OwnerWelcome = "Welcome, my father :3",
        BetaWelcome = "Glad you're here, tester ♡",
        ChangeLogText = [[XyqwHub ChangeLog

Version 4.1
- All buttons squared
- Bright red instead of yellow
- Resize in bottom right corner
- Small start size (250x300)
- Buttons in 1 row
- Removed GetTheme()

Version 4.0
- First 4.0 release

Version 3.9
- Script executed notification

Version 1.0
- First release]]
    },
    RU = {
        WindowTitle = "XyqwHub",
        ChangeLogBtn = "Ченджлог",
        RemoveTagBtn = "Убрать тег",
        Loaded = "загружен",
        Error = "ошибка",
        Search = "Поиск...",
        CustomScript = "Свой скрипт",
        CustomPlaceholder = "Ссылка...",
        RunCustom = "Запустить",
        PlayerList = "Игроки",
        ServerInfo = "Сервер",
        JobIdCopied = "JobId скопирован!",
        HideTopBarOn = "Скрыть топ бар: включено",
        HideTopBarOff = "Скрыть топ бар: выключено",
        ScriptExecuted = "Скрипт выполнен!",
        OwnerWelcome = "Welcome, my father :3",
        BetaWelcome = "Glad you're here, tester ♡",
        ChangeLogText = [[XyqwHub Ченджлог

Версия 4.1
- Все кнопки квадратные
- Ярко-красный вместо жёлтого
- Ресайз в правом нижнем углу
- Маленький стартовый размер (250x300)
- Кнопки в 1 ряд
- Убран GetTheme()

Версия 4.0
- Первый релиз 4.0

Версия 3.9
- Уведомление Script executed

Версия 1.0
- Первый релиз]]
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
local function IsOwner()
    local lp = game:GetService("Players").LocalPlayer
    for _, id in ipairs(OWNER_IDS) do
        if lp.UserId == id then return true end
    end
    return false
end

local function IsBeta()
    local lp = game:GetService("Players").LocalPlayer
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
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
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
    for _, tag in pairs(activeTags) do
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
        return math.floor(Players.LocalPlayer:GetNetworkPing() * 1000)
    end)
    return ok and ping or 0
end

local function GetExecutorName()
    local ok, name = pcall(function()
        if identifyexecutor then return identifyexecutor() end
        return "Unknown"
    end)
    return ok and name or "Unknown"
end
-- SEARCH
local searchBar = Instance.new("TextBox")
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

-- TABS (в 1 ряд)
local tabBar = Instance.new("Frame")
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

-- SCROLL
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -10, 1, -170)
scrollFrame.Position = UDim2.new(0, 5, 0, 93)
scrollFrame.BackgroundTransparency = 1
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.ScrollBarThickness = 4
scrollFrame.ScrollBarImageColor3 = RED_MAIN
scrollFrame.Parent = mainFrame

-- КНОПКА
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

    return container, data
end

-- СПИСОК СКРИПТОВ
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
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, visible * buttonHeight + 20)
end

RefreshButtons()
searchBar:GetPropertyChangedSignal("Text"):Connect(RefreshButtons)
-- ========== CHANGE LOG ==========
local function ShowChangeLog()
    local frame = Instance.new("Frame")
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

changelogButton.MouseButton1Click:Connect(ShowChangeLog)

-- ========== СМЕНА ЯЗЫКА ==========
langButton.MouseButton1Click:Connect(function()
    if getgenv().XyqwLanguage == "EN" then
        getgenv().XyqwLanguage = "RU"
    else
        getgenv().XyqwLanguage = "EN"
    end
    langButton.Text = getgenv().XyqwLanguage
    searchBar.PlaceholderText = _("Search")
    ShowRobloxNotification("Language: " .. getgenv().XyqwLanguage, 2)
end)

-- ========== PLAYER LIST ==========
local function ShowPlayerList()
    local frame = Instance.new("Frame")
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

    runBtn.MouseButton1Click:Connect(function()
        if input.Text == "" then return end
        print("[XyqwHub] Custom - STARTING...")
        local success, err = pcall(function()
            loadstring(game:HttpGet(input.Text))()
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

-- Привязка кнопок
themeBtn.MouseButton1Click:Connect(function()
    ShowRobloxNotification("Theme: Red (default)", 2)
end)
customBtn.MouseButton1Click:Connect(ShowCustomScript)
playerBtn.MouseButton1Click:Connect(ShowPlayerList)
serverBtn.MouseButton1Click:Connect(ShowServerInfo)

-- ========== RESIZE ==========
local resizeHandle = Instance.new("TextButton")
resizeHandle.Name = "ResizeHandle"
resizeHandle.Size = UDim2.new(0, 14, 0, 14)
resizeHandle.Position = UDim2.new(1, -14, 1, -14)
resizeHandle.BackgroundColor3 = RED_MAIN
resizeHandle.Text = ""
resizeHandle.BorderSizePixel = 0
resizeHandle.Parent = mainFrame
resizeHandle.AutoButtonColor = false

local resizing = false
local resizeStart, resizeStartSize

resizeHandle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        resizing = true
        resizeStart = input.Position
        resizeStartSize = mainFrame.Size
    end
end)

resizeHandle.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        resizing = false
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if resizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - resizeStart
        local newX = math.clamp(resizeStartSize.X.Offset + delta.X, 250, 800)
        local newY = math.clamp(resizeStartSize.Y.Offset + delta.Y, 300, 900)
        mainFrame.Size = UDim2.new(0, newX, 0, newY)
    end
end)

-- ========== ПЕРЕТАСКИВАНИЕ ОКНА ==========
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
           or IsOverButton(themeBtn) or IsOverButton(customBtn) or IsOverButton(playerBtn)
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

-- ========== ДОК-КНОПКА (перетаскивание) ==========
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

-- ========== ЗАКРЫТИЕ / ОТКРЫТИЕ ==========
closeButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    dockButton.Visible = true
end)

dockButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    dockButton.Visible = false
end)

-- ========== WELCOME ==========
local function ShowWelcomeMessage()
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 170)
    frame.Position = UDim2.new(0.5, -150, 0.5, -85)
    frame.BackgroundColor3 = RED_BG
    frame.BorderSizePixel = 2
    frame.BorderColor3 = RED_MAIN
    frame.Parent = screenGui

    local top = Instance.new("TextLabel")
    top.Size = UDim2.new(1, -10, 0, 20)
    top.Position = UDim2.new(0, 5, 0, 5)
    top.BackgroundTransparency = 1
    top.TextColor3 = RED_MAIN
    top.Text = "Press EN/RU in the top right corner"
    top.TextScaled = true
    top.Font = Enum.Font.Gotham
    top.Parent = frame

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -10, 0, 25)
    title.Position = UDim2.new(0, 5, 0, 28)
    title.BackgroundTransparency = 1
    title.TextColor3 = RED_MAIN
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

    local ver = Instance.new("TextLabel")
    ver.Size = UDim2.new(1, -10, 0, 18)
    ver.Position = UDim2.new(0, 5, 0, 145)
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
