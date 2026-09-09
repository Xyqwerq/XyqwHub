-- ========== XyqwHub - Версия 2.4 ==========
-- Работает как Infinite Yield: загружается один раз и живёт в памяти

print("[XyqwHub] Loading...")

-- ========== ГЛОБАЛЬНЫЕ НАСТРОЙКИ ==========
if getgenv().XyqwAutoExecute == nil then
    getgenv().XyqwAutoExecute = true
end

if getgenv().XyqwLanguage == nil then
    getgenv().XyqwLanguage = "EN"
end

-- ========== ТЕКСТЫ ==========
local LANG = {
    EN = {
        Welcome = "Welcome to XyqwHub!",
        WindowTitle = "XyqwHub",
        DockText = "XyqwHub",
        LangButton = "EN",
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
        TikTok = "TikTok: xyqwerq.tvink",
        Telegram = "Telegram: t.me/xyqwsquad",
        Discord = "Discord: xyqwerqyt",
        LangHintTop = "Press EN/RU in the top right corner to change language",
        LangHintBottom = "Нажмите EN/RU в правом верхнем углу, чтобы сменить язык",
        DeathOrder = "Simon Says script loaded",
        DeathOrderBottom = "Have fun!",
        CheesyKey = "Key: joincheesydsc",
        CheesyBottom = "Script should be loaded",
        AutoExecuteENABLE = "Auto Execute: ENABLE",
        AutoExecuteDISABLE = "Auto Execute: DISABLE"
    },
    RU = {
        Welcome = "Добро пожаловать в XyqwHub!",
        WindowTitle = "XyqwHub",
        DockText = "XyqwHub",
        LangButton = "RU",
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
        TikTok = "TikTok: xyqwerq.tvink",
        Telegram = "Telegram: t.me/xyqwsquad",
        Discord = "Discord: xyqwerqyt",
        LangHintTop = "Press EN/RU in the top right corner to change language",
        LangHintBottom = "Нажмите EN/RU в правом верхнем углу, чтобы сменить язык",
        DeathOrder = "Скрипт Simon Says загружен",
        DeathOrderBottom = "Приятной игры!",
        CheesyKey = "Ключ: joincheesydsc",
        CheesyBottom = "Скрипт должен запуститься",
        AutoExecuteENABLE = "Авто-запуск: включен",
        AutoExecuteDISABLE = "Авто-запуск: выключен"
    }
}

-- ========== ФУНКЦИЯ ПОЛУЧЕНИЯ ТЕКСТА ==========
local function _(key)
    return LANG[getgenv().XyqwLanguage][key]
end

-- ========== ГЛОБАЛЬНЫЕ ПЕРЕМЕННЫЕ ==========
local screenGui = nil
local mainFrame = nil
local dockButton = nil
local scrollFrame = nil
local titleLabel = nil
local autoExecButton = nil
local langButton = nil
local closeButton = nil
local isGUIVisible = true
local buttonsBlocked = false
local cooldowns = {}
local isFirstLaunch = true

-- ========== ВСПОМОГАТЕЛЬНЫЕ ФУНКЦИИ ==========
local function blockButtonsTemporarily()
    buttonsBlocked = true
    task.wait(0.5)
    buttonsBlocked = false
end

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

local function ShowNotification(topText, bottomText, duration)
    duration = duration or 3.5
    if not screenGui then return end
    
    local notificationFrame = Instance.new("Frame")
    notificationFrame.Size = UDim2.new(0, 320, 0, 80)
    notificationFrame.Position = UDim2.new(0.5, -160, 0.5, -40)
    notificationFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    notificationFrame.BorderSizePixel = 2
    notificationFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
    notificationFrame.Parent = screenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = notificationFrame
    
    local topLabel = Instance.new("TextLabel")
    topLabel.Size = UDim2.new(1, -10, 0, 30)
    topLabel.Position = UDim2.new(0, 5, 0, 5)
    topLabel.BackgroundTransparency = 1
    topLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    topLabel.Text = topText
    topLabel.TextScaled = true
    topLabel.Font = Enum.Font.GothamBold
    topLabel.Parent = notificationFrame
    
    local bottomLabel = Instance.new("TextLabel")
    bottomLabel.Size = UDim2.new(1, -10, 0, 30)
    bottomLabel.Position = UDim2.new(0, 5, 0, 40)
    bottomLabel.BackgroundTransparency = 1
    bottomLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    bottomLabel.Text = bottomText
    bottomLabel.TextScaled = true
    bottomLabel.Font = Enum.Font.Gotham
    bottomLabel.Parent = notificationFrame
    
    task.wait(duration)
    notificationFrame:Destroy()
end

local function ShowWelcomeMessage()
    if not screenGui then return end
    
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
    topHint.Text = _("LangHintTop")
    topHint.TextScaled = true
    topHint.Font = Enum.Font.Gotham
    topHint.Parent = welcomeFrame
    
    local titleLabelW = Instance.new("TextLabel")
    titleLabelW.Size = UDim2.new(1, -10, 0, 25)
    titleLabelW.Position = UDim2.new(0, 5, 0, 28)
    titleLabelW.BackgroundTransparency = 1
    titleLabelW.TextColor3 = Color3.fromRGB(255, 100, 100)
    titleLabelW.Text = _("Welcome")
    titleLabelW.TextScaled = true
    titleLabelW.Font = Enum.Font.GothamBold
    titleLabelW.Parent = welcomeFrame
    
    local tiktokLabel = Instance.new("TextLabel")
    tiktokLabel.Size = UDim2.new(1, -10, 0, 22)
    tiktokLabel.Position = UDim2.new(0, 5, 0, 56)
    tiktokLabel.BackgroundTransparency = 1
    tiktokLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    tiktokLabel.Text = _("TikTok")
    tiktokLabel.TextScaled = true
    tiktokLabel.Font = Enum.Font.Gotham
    tiktokLabel.Parent = welcomeFrame
    
    local telegramLabel = Instance.new("TextLabel")
    telegramLabel.Size = UDim2.new(1, -10, 0, 22)
    telegramLabel.Position = UDim2.new(0, 5, 0, 80)
    telegramLabel.BackgroundTransparency = 1
    telegramLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    telegramLabel.Text = _("Telegram")
    telegramLabel.TextScaled = true
    telegramLabel.Font = Enum.Font.Gotham
    telegramLabel.Parent = welcomeFrame
    
    local discordLabel = Instance.new("TextLabel")
    discordLabel.Size = UDim2.new(1, -10, 0, 22)
    discordLabel.Position = UDim2.new(0, 5, 0, 104)
    discordLabel.BackgroundTransparency = 1
    discordLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    discordLabel.Text = _("Discord")
    discordLabel.TextScaled = true
    discordLabel.Font = Enum.Font.Gotham
    discordLabel.Parent = welcomeFrame
    
    local bottomHint = Instance.new("TextLabel")
    bottomHint.Size = UDim2.new(1, -10, 0, 20)
    bottomHint.Position = UDim2.new(0, 5, 0, 130)
    bottomHint.BackgroundTransparency = 1
    bottomHint.TextColor3 = Color3.fromRGB(255, 200, 100)
    bottomHint.Text = _("LangHintBottom")
    bottomHint.TextScaled = true
    bottomHint.Font = Enum.Font.Gotham
    bottomHint.Parent = welcomeFrame
    
    local versionLabel = Instance.new("TextLabel")
    versionLabel.Size = UDim2.new(1, -10, 0, 18)
    versionLabel.Position = UDim2.new(0, 5, 0, 153)
    versionLabel.BackgroundTransparency = 1
    versionLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
    versionLabel.Text = "Version: 2.4"
    versionLabel.TextScaled = true
    versionLabel.Font = Enum.Font.Gotham
    versionLabel.Parent = welcomeFrame
    
    task.wait(5)
    welcomeFrame:Destroy()
end

-- ========== ФУНКЦИЯ СОЗДАНИЯ КНОПКИ ==========
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

-- ========== ФУНКЦИЯ ЗАПУСКА СКРИПТА ==========
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

-- ========== ГЛАВНАЯ ФУНКЦИЯ СОЗДАНИЯ GUI ==========
local function CreateGUI()
    -- Удаляем старый GUI
    if screenGui then
        screenGui:Destroy()
        screenGui = nil
    end
    
    -- Ждём, пока CoreGui загрузится
    if not game:IsLoaded() then
        game.Loaded:Wait()
    end
    
    screenGui = Instance.new("ScreenGui")
    screenGui.Name = "XyqwHubGui"
    screenGui.Parent = game:GetService("CoreGui")
    
    -- Док-кнопка
    dockButton = Instance.new("TextButton")
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
    
    -- Главное окно
    mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 280, 0, 400)
    mainFrame.Position = UDim2.new(0.5, -140, 0.5, -200)
    mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    mainFrame.BorderSizePixel = 3
    mainFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
    mainFrame.ClipsDescendants = true
    mainFrame.Parent = screenGui
    
    -- Заголовок
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 60)
    titleBar.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
    titleBar.BorderSizePixel = 0
    titleBar.Parent = mainFrame
    
    -- Название
    titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(0.5, -5, 0.5, 0)
    titleLabel.Position = UDim2.new(0, 5, 0, 5)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = _("WindowTitle")
    titleLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
    titleLabel.TextScaled = true
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Parent = titleBar
    
    -- Auto Execute
    autoExecButton = Instance.new("TextButton")
    autoExecButton.Size = UDim2.new(0.5, -5, 0.4, 0)
    autoExecButton.Position = UDim2.new(0, 5, 0.5, 2)
    autoExecButton.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
    autoExecButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    if getgenv().XyqwAutoExecute then
        autoExecButton.Text = _("AutoExecuteENABLE")
    else
        autoExecButton.Text = _("AutoExecuteDISABLE")
    end
    autoExecButton.TextScaled = true
    autoExecButton.Font = Enum.Font.GothamBold
    autoExecButton.BorderSizePixel = 1
    autoExecButton.BorderColor3 = Color3.fromRGB(255, 0, 0)
    autoExecButton.Parent = titleBar
    autoExecButton.AutoButtonColor = false
    
    -- Кнопка языка
    langButton = Instance.new("TextButton")
    langButton.Size = UDim2.new(0, 35, 0.45, 0)
    langButton.Position = UDim2.new(1, -65, 0, 5)
    langButton.BackgroundTransparency = 1
    langButton.Text = getgenv().XyqwLanguage
    langButton.TextColor3 = Color3.fromRGB(255, 200, 0)
    langButton.TextScaled = true
    langButton.Font = Enum.Font.GothamBold
    langButton.Parent = titleBar
    langButton.AutoButtonColor = false
    
    -- Крестик
    closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 30, 0.45, 0)
    closeButton.Position = UDim2.new(1, -30, 0.5, 2)
    closeButton.BackgroundTransparency = 1
    closeButton.Text = "X"
    closeButton.TextColor3 = Color3.fromRGB(255, 0, 0)
    closeButton.TextScaled = true
    closeButton.Font = Enum.Font.GothamBold
    closeButton.Parent = titleBar
    closeButton.AutoButtonColor = false
    
    -- Скролл
    scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Size = UDim2.new(1, -10, 1, -70)
    scrollFrame.Position = UDim2.new(0, 5, 0, 65)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    scrollFrame.ScrollBarThickness = 4
    scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 0, 0)
    scrollFrame.Parent = mainFrame
    
    -- ===== СОЗДАНИЕ ВСЕХ КНОПОК =====
    local y = 5
    
    local function addButton(text, url)
        local btn = CreateButton(text, function()
            RunScript(text, url)
        end)
        btn.Position = UDim2.new(0, 5, 0, y)
        y = y + 45
    end
    
    -- Blade Ball
    local bladeBtn = CreateButton("Blade Ball", function()
        RunScript("Blade Ball", "https://raw.githubusercontent.com/joshhhie/rise/refs/heads/main/loader.lua")
    end)
    bladeBtn.Position = UDim2.new(0, 5, 0, y)
    y = y + 45
    
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
    
    -- Doors V2 (Copy)
    local doorsV2Btn = CreateButton("Doors V2 (Copy)", function()
        local scriptText = [[getgenv().SCRIPT_KEY = "KEYLESS"
    loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/abd3cc54d2dc7de4a091fb19c8f4ea9e15e939e7ecc88b475e6956e8af94ad6f/download"))()]]
        local copied = CopyToClipboard(scriptText)
        if copied then
            ShowNotification(_("DoorsV2"), _("DoorsV2Bottom"))
        else
            ShowNotification(_("DoorsV2"), "Failed to copy! Please copy manually")
        end
    end)
    doorsV2Btn.Position = UDim2.new(0, 5, 0, y)
    y = y + 45
    
    -- Doors V3 (Cheesy)
    local cheesyBtn = CreateButton("Doors V3 (Cheesy)", function()
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/doram44/cheesy/refs/heads/main/cheesy.lua"))()
        end)
        if success then
            print("[XyqwHub] Doors V3 (Cheesy) - " .. _("Loaded") .. "!")
            ShowNotification(_("CheesyKey"), _("CheesyBottom"))
        else
            print("[XyqwHub] Doors V3 (Cheesy) - " .. _("Error") .. ": " .. tostring(err))
            ShowNotification(_("CheesyKey"), _("Failed") .. ": " .. tostring(err))
        end
    end)
    cheesyBtn.Position = UDim2.new(0, 5, 0, y)
    y = y + 45
    
    addButton("Infinite Yield", "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source")
    
    -- Walk on walls
    local walkBtn = CreateButton("Walk on walls", function()
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://rawscripts.net/raw/The-patience-obby-Universal-Walk-on-walls-18129"))()
        end)
        if success then
            print("[XyqwHub] Walk on walls - " .. _("Loaded") .. "!")
            ShowNotification(_("WalkOnWalls"), _("WalkOnWallsBottom"))
        else
            print("[XyqwHub] Walk on walls - " .. _("Error") .. ": " .. tostring(err))
            ShowNotification(_("WalkOnWalls"), _("Failed") .. ": " .. tostring(err))
        end
    end)
    walkBtn.Position = UDim2.new(0, 5, 0, y)
    y = y + 45
    
    -- AetherX
    local aetherBtn = CreateButton("AetherX (Death Penalty)", function()
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/8c08b8f2252eec7dbb77d253d269bb65.lua"))()
        end)
        if success then
            print("[XyqwHub] AetherX - " .. _("Loaded") .. "!")
            ShowNotification(_("AetherX"), _("AetherXBottom"))
        else
            print("[XyqwHub] AetherX - " .. _("Error") .. ": " .. tostring(err))
            ShowNotification(_("AetherX"), _("Failed") .. ": " .. tostring(err))
        end
    end)
    aetherBtn.Position = UDim2.new(0, 5, 0, y)
    y = y + 45
    
    addButton("Voidware (INK/99N/Forsaken)", "https://files.vapevoidware.xyz/VapeVoidware/VW-Add/main/loader.lua")
    
    -- LaLol Hub
    local lalolBtn = CreateButton("LaLol Hub (B4ckd0or)", function()
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Miygteet/Hacker101/refs/heads/main/LALOL-Backdoor-Secure.lua"))()
        end)
        if success then
            print("[XyqwHub] LaLol Hub - " .. _("Loaded") .. "!")
            ShowNotification(_("Beta"), _("BetaBottom"))
        else
            print("[XyqwHub] LaLol Hub - " .. _("Error") .. ": " .. tostring(err))
            ShowNotification(_("Beta"), _("Failed") .. ": " .. tostring(err))
        end
    end)
    lalolBtn.Position = UDim2.new(0, 5, 0, y)
    y = y + 45
    
    -- FTAP
    local ftapBtn = CreateButton("FTAP", function()
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/4078649e4397f0e2cdaddde241d69bfd67b2b7107917891384735129c85cae18/download"))()
        end)
        if success then
            print("[XyqwHub] FTAP - " .. _("Loaded") .. "!")
            ShowNotification(_("Beta"), _("BetaBottom"))
        else
            print("[XyqwHub] FTAP - " .. _("Error") .. ": " .. tostring(err))
            ShowNotification(_("Beta"), _("Failed") .. ": " .. tostring(err))
        end
    end)
    ftapBtn.Position = UDim2.new(0, 5, 0, y)
    y = y + 45
    
    addButton("MinhNat Hub (TSB)", "https://rawscripts.net/raw/Universal-Script-MinhNhat-Tsb-62161")
    
    -- BC9 (UTG)
    local bc9Btn = CreateButton("BC9 (UTG)", function()
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://rawscripts.net/raw/untitled-tag-game-BC9-UTG-MENU-116806"))()
        end)
        if success then
            print("[XyqwHub] BC9 (UTG) - " .. _("Loaded") .. "!")
            ShowNotification(_("BC9"), _("BC9Bottom"))
        else
            print("[XyqwHub] BC9 (UTG) - " .. _("Error") .. ": " .. tostring(err))
            ShowNotification(_("BC9"), _("Failed") .. ": " .. tostring(err))
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
    
    -- Death Order
    local deathOrderBtn = CreateButton("Death Order [SIMON]", function()
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://rawscripts.net/raw/Death-Order:-Simon-Says-BEST-DEATH-ORDER-SCRIPT-226542"))()
        end)
        if success then
            print("[XyqwHub] Death Order [SIMON] - " .. _("Loaded") .. "!")
            ShowNotification(_("DeathOrder"), _("DeathOrderBottom"))
        else
            print("[XyqwHub] Death Order [SIMON] - " .. _("Error") .. ": " .. tostring(err))
            ShowNotification(_("DeathOrder"), _("Failed") .. ": " .. tostring(err))
        end
    end)
    deathOrderBtn.Position = UDim2.new(0, 5, 0, y)
    y = y + 45
    
    addButton("CandyWare (MM2)", "https://raw.githubusercontent.com/Be1for/Scripts/refs/heads/main/candyware.luau")
    
    -- Destroy
    local destroyBtn = CreateButton("DESTROY XyqwHub", function()
        if screenGui then
            screenGui:Destroy()
            screenGui = nil
        end
        print("[XyqwHub] " .. _("Destroy"))
    end)
    destroyBtn.Position = UDim2.new(0, 5, 0, y)
    destroyBtn.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
    destroyBtn.BorderColor3 = Color3.fromRGB(255, 50, 50)
    y = y + 45
    
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, y + 10)
    
    -- ===== ПЕРЕТАСКИВАНИЕ ОКНА =====
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
    
    -- ===== ПЕРЕТАСКИВАНИЕ ДОК-КНОПКИ =====
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
    
    -- ===== ЗАКРЫТИЕ (крестик) =====
    local function closeGUI()
        if mainFrame then
            mainFrame.Visible = false
        end
        if dockButton then
            dockButton.Visible = true
        end
    end
    
    closeButton.MouseButton1Click:Connect(closeGUI)
    closeButton.TouchTap:Connect(closeGUI)
    
    -- ===== ОТКРЫТИЕ (док-кнопка) =====
    local function openGUI()
        if mainFrame then
            mainFrame.Visible = true
        end
        if dockButton then
            dockButton.Visible = false
        end
        blockButtonsTemporarily()
    end
    
    dockButton.MouseButton1Click:Connect(openGUI)
    dockButton.TouchTap:Connect(openGUI)
    
    -- ===== КНОПКА AUTO EXECUTE =====
    local function ToggleAutoExecute()
        getgenv().XyqwAutoExecute = not getgenv().XyqwAutoExecute
        
        if autoExecButton then
            if getgenv().XyqwAutoExecute then
                autoExecButton.Text = _("AutoExecuteENABLE")
                print("[XyqwHub] Auto Execute: ENABLED")
            else
                autoExecButton.Text = _("AutoExecuteDISABLE")
                print("[XyqwHub] Auto Execute: DISABLED")
            end
        end
    end
    
    if autoExecButton then
        autoExecButton.MouseButton1Click:Connect(ToggleAutoExecute)
        autoExecButton.TouchTap:Connect(ToggleAutoExecute)
    end
    
    -- ===== КНОПКА ЯЗЫКА =====
    local function SwitchLanguage()
        if getgenv().XyqwLanguage == "EN" then
            getgenv().XyqwLanguage = "RU"
        else
            getgenv().XyqwLanguage = "EN"
        end
        
        -- Пересоздаём GUI с новым языком
        CreateGUI()
        print("[XyqwHub] Language changed to: " .. getgenv().XyqwLanguage)
    end
    
    if langButton then
        langButton.MouseButton1Click:Connect(SwitchLanguage)
        langButton.TouchTap:Connect(SwitchLanguage)
    end
    
    -- ===== ПРИВЕТСТВИЕ =====
    task.wait(0.5)
    ShowWelcomeMessage()
    
    print("[XyqwHub] XyqwHub loaded! Version: 2.4")
end

-- ========== ПЕРВЫЙ ЗАПУСК ==========
CreateGUI()

-- ========== АВТО-ПЕРЕЗАПУСК ПРИ ПЕРЕЗАХОДЕ ==========
local Players = game:GetService("Players")
local function onPlayerAdded(player)
    if player == Players.LocalPlayer then
        if getgenv().XyqwAutoExecute then
            print("[XyqwHub] Player rejoined! Restarting GUI...")
            task.wait(1)
            CreateGUI()
        else
            print("[XyqwHub] Auto Execute is DISABLED. GUI not restarted.")
        end
    end
end

Players.PlayerAdded:Connect(onPlayerAdded)

-- ========== ПРОВЕРКА ПРИ ПЕРЕЗАПУСКЕ СКРИПТА ==========
if getgenv().XyqwAutoExecute then
    print("[XyqwHub] Auto Execute is ENABLED. Will restart on rejoin.")
else
    print("[XyqwHub] Auto Execute is DISABLED. Will NOT restart on rejoin.")
end
