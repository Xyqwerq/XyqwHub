-- ========== XYQWHUB SMART LAUNCHER (v5.0) ==========
-- Изменяй MODE_STATUS на GitHub → применится при следующем запуске.

local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local CoreGui = game:GetService("CoreGui")

-- ============================================================
-- РЕЖИМЫ (true = работает, false = сломан)
-- ============================================================
local MODE_STATUS = {
    Default = true,
    Ghost   = true,
    Extra   = true,
}

local FALLBACK_ORDER = {
    Default = {"Ghost",   "Extra"},
    Ghost   = {"Extra",   "Default"},
    Extra   = {"Ghost",   "Default"},
}
local MODE_ORDER = {"Default", "Ghost", "Extra"}

-- ============================================================
-- ИЗВЕСТНЫЕ ИГРЫ (добавляй свои PlaceId)
-- ============================================================
local KNOWN_BAC_GAMES = {
    [107778070777162] = "Steal an Egg",
    [112410758658181] = "Steal a Brainrot",
    [13772394625] = "Blade Ball",
}
local KNOWN_ADONIS_GAMES = {
    [76145207802145] = "Get A Grip",
}
local KNOWN_SUSPICIOUS_GAMES = {
    -- Пример: [1234567890] = "Some Game",
}

local MODE_URLS = {
    Default = "https://raw.githubusercontent.com/Xyqwerq/XyqwHub-Default/main/main.lua",
    Ghost   = "https://raw.githubusercontent.com/Xyqwerq/XyqwHub-Ghost/main/main.lua",
    Extra   = "https://raw.githubusercontent.com/Xyqwerq/XyqwHub-Extra/main/main.lua",
}

local FOLDER = "XyqwHub/Logs"
local SESSION_FILE = FOLDER .. "/session.txt"
local DEBUG_FILE = FOLDER .. "/loader_debug.txt"

pcall(function()
    if not isfolder("XyqwHub") then makefolder("XyqwHub") end
    if not isfolder(FOLDER) then makefolder(FOLDER) end
end)

-- ============================================================
-- SAFE HTTP
-- ============================================================
local function SafeHttpGet(url)
    if typeof(syn) == "table" and syn.request then
        local ok, res = pcall(function() return syn.request({Url = url, Method = "GET"}).Body end)
        if ok and res then return res end
    end
    if typeof(http_request) == "function" then
        local ok, res = pcall(function() return http_request({Url = url, Method = "GET"}).Body end)
        if ok and res then return res end
    end
    if typeof(request) == "function" then
        local ok, res = pcall(function() return request({Url = url, Method = "GET"}).Body end)
        if ok and res then return res end
    end
    return game:HttpGet(url)
end

local function StartMode(mode)
    local url = MODE_URLS[mode]
    if not url then return end
    pcall(function()
        loadstring(SafeHttpGet(url))()
    end)
end

local function Notify(title, text, duration)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title or "XyqwHub",
            Text = tostring(text or ""),
            Duration = duration or 5,
        })
    end)
end

-- ============================================================
-- STEALTH-ОКНО (gethui → protect_gui → PlayerGui)
-- ============================================================
local function CreateStyledWindow(cfg)
    local width  = cfg.width  or 320
    local height = cfg.height or 145
    local buttons = cfg.buttons or {}
    local buttonCount = #buttons
    local isWide = buttonCount >= 3

    local screenGui = Instance.new("ScreenGui")
    local safeNames = {"Notification", "RobloxGui", "Chat", "TopBar", "Backpack"}
    screenGui.Name = safeNames[math.random(1, #safeNames)]
    screenGui.ResetOnSpawn = true
    screenGui.IgnoreGuiInset = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.DisplayOrder = math.random(1, 3)

    local parented = false
    if type(gethui) == "function" then
        pcall(function() screenGui.Parent = gethui(); parented = true end)
    end
    if not parented then
        pcall(function()
            if type(syn) == "table" and type(syn.protect_gui) == "function" then
                syn.protect_gui(screenGui); screenGui.Parent = CoreGui; parented = true
            elseif type(protect_gui) == "function" then
                protect_gui(screenGui); screenGui.Parent = CoreGui; parented = true
            end
        end)
    end
    if not parented then
        pcall(function()
            screenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
        end)
    end

    local frame = Instance.new("Frame")
    frame.Name = "NotificationCard"
    frame.Size = UDim2.new(0, width, 0, height)
    frame.Position = UDim2.new(1, -(width + 20), 0, 20)
    frame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    frame.BorderSizePixel = 0
    frame.Parent = screenGui

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(80, 80, 80)
    stroke.Thickness = 1
    stroke.Parent = frame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = frame

    local icon = Instance.new("TextLabel")
    icon.Name = "Icon"
    icon.Size = UDim2.new(0, 28, 0, 28)
    icon.Position = UDim2.new(0, 10, 0, 10)
    icon.BackgroundColor3 = cfg.iconColor or Color3.fromRGB(255, 60, 60)
    icon.Text = cfg.icon or "!"
    icon.TextColor3 = Color3.fromRGB(255, 255, 255)
    icon.Font = Enum.Font.GothamBold
    icon.TextSize = 18
    icon.BorderSizePixel = 0
    icon.Parent = frame
    local ic = Instance.new("UICorner")
    ic.CornerRadius = UDim.new(0, 4)
    ic.Parent = icon

    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, -50, 0, 22)
    title.Position = UDim2.new(0, 45, 0, 10)
    title.BackgroundTransparency = 1
    title.Text = cfg.title or "XyqwHub"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 15
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = frame

    local desc = Instance.new("TextLabel")
    desc.Name = "Description"
    desc.Size = UDim2.new(1, -20, 0, 50)
    desc.Position = UDim2.new(0, 10, 0, 42)
    desc.BackgroundTransparency = 1
    desc.Text = cfg.text or ""
    desc.TextColor3 = Color3.fromRGB(210, 210, 210)
    desc.Font = Enum.Font.Gotham
    desc.TextSize = 12
    desc.TextWrapped = true
    desc.TextXAlignment = Enum.TextXAlignment.Left
    desc.TextYAlignment = Enum.TextYAlignment.Top
    desc.Parent = frame

    local btnContainer = Instance.new("Frame")
    btnContainer.Name = "Buttons"
    btnContainer.Size = UDim2.new(1, -20, 0, 30)
    btnContainer.Position = UDim2.new(0, 10, 1, -40)
    btnContainer.BackgroundTransparency = 1
    btnContainer.Parent = frame

    local gap = 6
    local btnWidth = (width - 20 - (buttonCount - 1) * gap) / buttonCount

    for i, b in ipairs(buttons) do
        local btn = Instance.new("TextButton")
        btn.Name = "Btn" .. i
        btn.Size = UDim2.new(0, btnWidth, 1, 0)
        btn.Position = UDim2.new(0, (i - 1) * (btnWidth + gap), 0, 0)
        btn.BackgroundColor3 = b.color or Color3.fromRGB(60, 60, 60)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Text = b.text
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = isWide and 11 or 13
        btn.BorderSizePixel = 0
        btn.AutoButtonColor = false
        btn.Parent = btnContainer
        local bc = Instance.new("UICorner")
        bc.CornerRadius = UDim.new(0, 4)
        bc.Parent = btn

        local base = b.color or Color3.fromRGB(60, 60, 60)
        btn.MouseEnter:Connect(function()
            btn.BackgroundColor3 = Color3.new(
                math.min(1, base.R * 1.2),
                math.min(1, base.G * 1.2),
                math.min(1, base.B * 1.2)
            )
        end)
        btn.MouseLeave:Connect(function() btn.BackgroundColor3 = base end)

        btn.MouseButton1Click:Connect(function()
            pcall(function() screenGui:Destroy() end)
            if b.onClick then pcall(b.onClick) end
        end)
    end

    -- Автозакрытие (не блокирует запуск — просто закрывает окно)
    local timeout = cfg.autoCloseTimeout or 15
    task.delay(timeout, function()
        if screenGui and screenGui.Parent then
            pcall(function() screenGui:Destroy() end)
        end
    end)

    return screenGui
end

-- ============================================================
-- УТИЛИТЫ
-- ============================================================
local function GetAvailableModes()
    local list = {}
    for _, m in ipairs(MODE_ORDER) do
        if MODE_STATUS[m] then table.insert(list, m) end
    end
    return list
end

local function GetUnavailableModes()
    local list = {}
    for _, m in ipairs(MODE_ORDER) do
        if not MODE_STATUS[m] then table.insert(list, m) end
    end
    return list
end

local function DeepScan(service, patterns, limit)
    if not service then return nil end
    limit = limit or 5000
    local count = 0
    local result = nil
    pcall(function()
        for _, obj in ipairs(service:GetDescendants()) do
            count = count + 1
            if count > limit then break end
            local name = string.lower(obj.Name)
            for _, p in ipairs(patterns) do
                if string.find(name, p, 1, true) then
                    result = obj
                    return
                end
            end
        end
    end)
    return result
end

-- ============================================================
-- ДЕТЕКЦИЯ
-- ============================================================
local function DetectBAC()
    if KNOWN_BAC_GAMES[game.PlaceId] then
        return "Known BAC game: " .. KNOWN_BAC_GAMES[game.PlaceId]
    end
    local pat = {"adeggboostremotes", "logtelemetry", "byfron"}
    local rs = game:GetService("ReplicatedStorage")
    for _, c in ipairs(rs:GetChildren()) do
        local ln = string.lower(c.Name)
        for _, p in ipairs(pat) do
            if string.find(ln, p, 1, true) then
                return "BAC: " .. c.Name
            end
        end
    end
    local found = DeepScan(rs, pat, 4000)
    if found then return "BAC Deep: " .. found:GetFullName() end
    return nil
end

local function DetectAdonis()
    local adP = {"adonis", "adonis_loader", "adonis_loaded", "adonis_gui"}
    local acP = {"anticheat", "anti_cheat", "byfron"}

    if KNOWN_ADONIS_GAMES[game.PlaceId] then
        return "Known Adonis game: " .. KNOWN_ADONIS_GAMES[game.PlaceId]
    end

    local ok, v = pcall(function() return _G.Adonis end)
    if ok and v ~= nil then return "Global _G.Adonis" end
    if type(getgenv) == "function" then
        local ok2, v2 = pcall(function() return getgenv().Adonis end)
        if ok2 and v2 ~= nil then return "getgenv().Adonis" end
    end

    local services = {
        game:GetService("ReplicatedStorage"),
        game:GetService("ReplicatedFirst"),
        Players.LocalPlayer and Players.LocalPlayer:FindFirstChild("PlayerGui"),
        game:GetService("Workspace"),
    }
    for _, svc in ipairs(services) do
        if svc then
            for _, child in ipairs(svc:GetChildren()) do
                local ln = string.lower(child.Name)
                for _, p in ipairs(adP) do
                    if string.find(ln, p, 1, true) then
                        return "Direct: " .. child:GetFullName()
                    end
                end
            end
        end
    end

    local foundRS = DeepScan(game:GetService("ReplicatedStorage"), adP, 5000)
    if foundRS then return "Deep RS: " .. foundRS:GetFullName() end

    if DeepScan(game:GetService("ReplicatedStorage"), acP, 3000) then
        return "AntiCheat pattern"
    end

    if type(getreg) == "function" then
        local ok4, threads = pcall(getreg)
        if ok4 and type(threads) == "table" then
            for _, t in ipairs(threads) do
                if type(t) == "thread" then
                    local ok5, src = pcall(function() return debug.info(t, "s") end)
                    if ok5 and type(src) == "string" then
                        local ls = string.lower(src)
                        if string.find(ls, "adonis", 1, true)
                            or string.find(ls, ".core.anti", 1, true) then
                            return "Thread: Adonis"
                        end
                    end
                end
            end
        end
    end
    return nil
end

local function DetectSuspicious()
    if KNOWN_SUSPICIOUS_GAMES[game.PlaceId] then
        return "Known suspicious: " .. KNOWN_SUSPICIOUS_GAMES[game.PlaceId]
    end
    return nil
end

-- ============================================================
-- LAUNCH (для clean игр)
-- ============================================================
local function SafeLaunchDefault()
    if MODE_STATUS.Default then
        StartMode("Default")
        return
    end

    -- Default недоступен → fallback
    local available = GetAvailableModes()
    if #available == 0 then
        Notify("Oops! Don't worry!",
            "XyqwHub is currently in an unstable state. Please try executing it later.",
            10)
        return
    end
    local nextMode = available[1]
    Notify("XyqwHub",
        "Default is currently unavailable. Launching " .. nextMode .. "...",
        5)
    task.delay(1.5, function() StartMode(nextMode) end)
end

-- ============================================================
-- ОКНО ВЫБОРА (для Adonis / Suspicious)
-- ============================================================
local function TryLaunchFromWindow(mode)
    if MODE_STATUS[mode] then
        StartMode(mode)
        return
    end

    local available = GetAvailableModes()
    if #available == 0 then
        Notify("Oops! Don't worry!",
            "XyqwHub is currently in an unstable state. Please try executing it later.",
            10)
        return
    end

    if #available == 1 then
        local only = available[1]
        local unavailable = GetUnavailableModes()
        local unavailableStr = table.concat(unavailable, " and ")
        CreateStyledWindow({
            title = "XyqwHub",
            text = "Unfortunately, two modes (" .. unavailableStr ..
                   ") are unavailable. Launch " .. only .. "?",
            icon = "!",
            iconColor = Color3.fromRGB(255, 180, 0),
            width = 380,
            height = 150,
            buttons = {
                {text = "Yes", color = Color3.fromRGB(0, 150, 80), onClick = function()
                    StartMode(only)
                end},
                {text = "No", color = Color3.fromRGB(100, 40, 40), onClick = function() end},
            },
        })
        return
    end

    -- 2+ доступны → fallback с уведомлением
    local nextMode = nil
    for _, cand in ipairs(FALLBACK_ORDER[mode] or MODE_ORDER) do
        if MODE_STATUS[cand] then
            nextMode = cand
            break
        end
    end
    if not nextMode then nextMode = available[1] end

    Notify("XyqwHub",
        "Unfortunately, mode " .. mode .. " is currently unavailable. Launching " .. nextMode .. "...",
        6)
    task.delay(1.5, function() StartMode(nextMode) end)
end

local function ShowModeSelectionWindow(recommended, reason)
    local function ModeButton(mode)
        local isRec = (mode == recommended)
        local isAvail = MODE_STATUS[mode]
        local label
        local color
        if not isAvail then
            label = mode .. " [OFF]"
            color = Color3.fromRGB(80, 30, 30)
        elseif isRec then
            label = mode .. " (recommended)"
            color = Color3.fromRGB(0, 150, 80)
        else
            label = mode
            color = Color3.fromRGB(60, 60, 60)
        end
        return {
            text = label,
            color = color,
            onClick = function() TryLaunchFromWindow(mode) end,
        }
    end

    local text = "Suspicious game detected"
    if reason then text = text .. " (" .. reason .. ")" end
    text = text .. ". Which XyqwHub mode do you want to launch?"

    CreateStyledWindow({
        title = "XyqwHub",
        text = text,
        icon = "?",
        iconColor = Color3.fromRGB(255, 180, 0),
        width = 460,
        height = 160,
        buttons = {
            ModeButton("Default"),
            ModeButton("Ghost"),
            ModeButton("Extra"),
        },
    })
end

-- ============================================================
-- FORWARD DECL
-- ============================================================
local CheckGameAndLaunch

-- ============================================================
-- KICK WINDOW
-- ============================================================
local function ShowKickWindow()
    CreateStyledWindow({
        title = "XyqwHub",
        text = "Seems you were kicked last time. Start Ghost Mode?",
        icon = "!",
        iconColor = Color3.fromRGB(255, 60, 60),
        width = 320,
        height = 140,
        buttons = {
            {text = "Yes (Ghost)", color = Color3.fromRGB(0, 150, 80), onClick = function()
                TryLaunchFromWindow("Ghost")
            end},
            {text = "No, Continue", color = Color3.fromRGB(100, 40, 40), onClick = function()
                CheckGameAndLaunch()
            end},
        },
    })
end

-- ============================================================
-- ГЛАВНАЯ ЛОГИКА
-- ============================================================
CheckGameAndLaunch = function()
    -- 0. FORCE
    if getgenv().XyqwForceMode then
        local forced = getgenv().XyqwForceMode
        if MODE_STATUS[forced] ~= nil then
            Notify("XyqwHub Loader", "FORCED: " .. forced, 4)
            TryLaunchFromWindow(forced)
            return
        end
    end

    -- 1. BAC → silent Extra. Если Extra off → shutdown, НЕ fallback.
    local bacReason = DetectBAC()
    if bacReason then
        pcall(function()
            if writefile then
                writefile(DEBUG_FILE,
                    "Detected: BAC\nReason: " .. bacReason ..
                    "\nPlaceId: " .. tostring(game.PlaceId) ..
                    "\nExtra available: " .. tostring(MODE_STATUS.Extra) ..
                    "\nTime: " .. os.date("%Y-%m-%d %H:%M:%S"))
            end
        end)
        pcall(function()
            warn("[XyqwLoader] BAC | " .. bacReason .. " | Extra=" .. tostring(MODE_STATUS.Extra))
        end)

        if MODE_STATUS.Extra then
            Notify("XyqwHub", "BAC detected. Launching Extra...", 4)
            task.delay(1, function() StartMode("Extra") end)
        else
            Notify("Oops! Extra is unavailable!",
                "Unfortunately, Extra is currently unavailable. Shutting down XyqwHub for safety.",
                10)
        end
        return
    end

    -- 2. Adonis → окно выбора с Ghost
    local adonisReason = DetectAdonis()
    if adonisReason then
        pcall(function()
            if writefile then
                writefile(DEBUG_FILE,
                    "Detected: Adonis\nReason: " .. adonisReason ..
                    "\nPlaceId: " .. tostring(game.PlaceId) ..
                    "\nModes: D=" .. tostring(MODE_STATUS.Default) ..
                        " G=" .. tostring(MODE_STATUS.Ghost) ..
                        " E=" .. tostring(MODE_STATUS.Extra) ..
                    "\nTime: " .. os.date("%Y-%m-%d %H:%M:%S"))
            end
        end)
        pcall(function()
            warn("[XyqwLoader] Adonis | " .. adonisReason)
        end)
        ShowModeSelectionWindow("Ghost", adonisReason)
        return
    end

    -- 3. Suspicious (ручной список) → окно с Ghost
    local suspReason = DetectSuspicious()
    if suspReason then
        pcall(function()
            if writefile then
                writefile(DEBUG_FILE,
                    "Detected: Suspicious\nReason: " .. suspReason ..
                    "\nPlaceId: " .. tostring(game.PlaceId) ..
                    "\nTime: " .. os.date("%Y-%m-%d %H:%M:%S"))
            end
        end)
        pcall(function()
            warn("[XyqwLoader] Suspicious | " .. suspReason)
        end)
        ShowModeSelectionWindow("Ghost", suspReason)
        return
    end

    -- 4. Clean → Default
    pcall(function()
        if writefile then
            writefile(DEBUG_FILE,
                "Detected: Clean\nReason: clean game" ..
                "\nPlaceId: " .. tostring(game.PlaceId) ..
                "\nModes: D=" .. tostring(MODE_STATUS.Default) ..
                    " G=" .. tostring(MODE_STATUS.Ghost) ..
                    " E=" .. tostring(MODE_STATUS.Extra) ..
                "\nTime: " .. os.date("%Y-%m-%d %H:%M:%S"))
        end
    end)
    pcall(function()
        warn("[XyqwLoader] Clean | Default=" .. tostring(MODE_STATUS.Default))
    end)
    SafeLaunchDefault()
end

-- ============================================================
-- KICK DETECTION + СТАРТ
-- ============================================================
local wasKicked = false
pcall(function()
    if isfile and isfile(SESSION_FILE) then
        wasKicked = true
        delfile(SESSION_FILE)
    end
end)

if wasKicked and not shared.XyqwModeStarted then
    ShowKickWindow()
else
    Notify("XyqwHub", "Detecting game... Please wait!", 3)
    task.wait(1.5)
    CheckGameAndLaunch()
end
