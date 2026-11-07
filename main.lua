-- ========== XYQWHUB SMART LAUNCHER (v3.1 FIXED) ==========
-- Fixed: BindToClose removed, session detection, better fake notification.
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local CoreGui = game:GetService("CoreGui")

local FOLDER = "XyqwHub/Logs"
local SESSION_FILE = FOLDER .. "/session.txt"

pcall(function()
    if not isfolder("XyqwHub") then makefolder("XyqwHub") end
    if not isfolder(FOLDER) then makefolder(FOLDER) end
end)

local function SafeHttpGet(url)
    if typeof(syn) == "table" and syn.request then
        return syn.request({Url = url, Method = "GET"}).Body
    elseif typeof(http_request) == "function" then
        return http_request({Url = url, Method = "GET"}).Body
    elseif typeof(request) == "function" then
        return request({Url = url, Method = "GET"}).Body
    else
        return game:HttpGet(url)
    end
end

local function StartMode(mode)
    local url = (mode == "Extra" and "https://raw.githubusercontent.com/Xyqwerq/XyqwHub-Extra/main/main.lua")
             or (mode == "Ghost" and "https://raw.githubusercontent.com/Xyqwerq/XyqwHub-Ghost/main/main.lua")
             or "https://raw.githubusercontent.com/Xyqwerq/XyqwHub-Default/main/main.lua"
    pcall(function()
        local code = SafeHttpGet(url)
        loadstring(code)()
    end)
end

-- ============================================================
-- УЛУЧШЕННЫЙ ДЕТЕКТОР ADONIS / ANTICHEAT
-- ============================================================
local function DetectAdonis()
    local found = nil

    -- 1) Быстрый путь: стандартные локации Adonis
    pcall(function()
        local rs = game:GetService("ReplicatedStorage")
        local rf = game:GetService("ReplicatedFirst")
        for _, name in ipairs({"Adonis", "Adonis_Loader", "AdonisLoader", "AdonisLoaded", "AdonisCore"}) do
            if rs:FindFirstChild(name) then found = "ReplicatedStorage." .. name; return end
        end
        for _, name in ipairs({"Adonis", "Adonis_Loader"}) do
            if rf:FindFirstChild(name) then found = "ReplicatedFirst." .. name; return end
        end
    end)
    if found then return found end

    -- 2) PlayerGui: Adonis_Admin / Adonis GUI появляется у админов
    pcall(function()
        local pg = Players.LocalPlayer and Players.LocalPlayer:FindFirstChild("PlayerGui")
        if pg then
            for _, g in ipairs(pg:GetChildren()) do
                if string.find(string.lower(g.Name), "adonis", 1, true) then
                    found = "PlayerGui." .. g.Name
                    return
                end
            end
        end
    end)
    if found then return found end

    -- 3) Workspace: только прямые дети (быстро)
    pcall(function()
        local ws = game:GetService("Workspace")
        for _, o in ipairs(ws:GetChildren()) do
            local n = string.lower(o.Name)
            if string.find(n, "adonis", 1, true) or string.find(n, "anticheat", 1, true) then
                found = "Workspace." .. o.Name
                return
            end
        end
    end)
    if found then return found end

    -- 4) Глубокий скан ReplicatedStorage (лимит 5000, чтобы не фризить Delta)
    pcall(function()
        local rs = game:GetService("ReplicatedStorage")
        local count = 0
        for _, o in ipairs(rs:GetDescendants()) do
            count = count + 1
            if count > 5000 then break end
            local n = string.lower(o.Name)
            if string.find(n, "adonis", 1, true) or string.find(n, "anticheat", 1, true) then
                found = "ReplicatedStorage(deep)." .. o.Name
                return
            end
        end
    end)
    if found then return found end

    -- 5) Remotes.Adonis_* (часто единственный след в клиенте)
    pcall(function()
        local rs = game:GetService("ReplicatedStorage")
        local remotes = rs:FindFirstChild("Remotes")
        if remotes then
            for _, o in ipairs(remotes:GetChildren()) do
                if string.find(string.lower(o.Name), "adonis", 1, true) then
                    found = "Remotes." .. o.Name
                    return
                end
            end
        end
    end)

    return found
end

local function DetectAntiCheat()
    local found = nil
    pcall(function()
        local rs = game:GetService("ReplicatedStorage")
        local count = 0
        for _, o in ipairs(rs:GetDescendants()) do
            count = count + 1
            if count > 5000 then break end
            local n = string.lower(o.Name)
            if string.find(n, "anticheat", 1, true)
                or string.find(n, "byfron", 1, true)
                or string.find(n, "logtelemetry", 1, true)
                or string.find(n, "adeggboostremotes", 1, true) then
                found = o.Name
                return
            end
        end
    end)
    return found
end

-- ============================================================
-- ГЛАВНАЯ ЛОГИКА ВЫБОРА РЕЖИМА
-- ============================================================
-- ============================================================
-- УЛУЧШЕННЫЙ ДЕТЕКТОР ADONIS (глубокий скан + проверка исходников)
-- ============================================================

-- Вспомогательная функция для глубокого сканирования сервиса с лимитом
local function DeepScan(service, patterns, limit)
    local count = 0
    limit = limit or 5000
    pcall(function()
        for _, obj in ipairs(service:GetDescendants()) do
            count = count + 1
            if count > limit then break end
            local name = string.lower(obj.Name)
            for _, pattern in ipairs(patterns) do
                if string.find(name, pattern, 1, true) then
                    return obj
                end
            end
        end
    end)
    return nil
end

local function DetectAdonis()
    local adonisPatterns = {"adonis", "adonis_loader", "adonis_loaded", "adonis_gui"}
    local anticheatPatterns = {"anticheat", "anti_cheat", "byfron", "logtelemetry", "adeggboostremotes"}

    -- 1. Быстрая проверка прямых детей в ключевых сервисах (самый частый случай)
    local servicesToCheck = {
        game:GetService("ReplicatedStorage"),
        game:GetService("ReplicatedFirst"),
        game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui"),
        game:GetService("Workspace")
    }

    for _, service in ipairs(servicesToCheck) do
        if service then
            for _, child in ipairs(service:GetChildren()) do
                local lowerName = string.lower(child.Name)
                for _, pattern in ipairs(adonisPatterns) do
                    if string.find(lowerName, pattern, 1, true) then
                        return "Direct Child: " .. child:GetFullName()
                    end
                end
            end
        end
    end

    -- 2. Глубокий скан ReplicatedStorage и ReplicatedFirst (на случай, если Adonis спрятан в папках)
    local rs = game:GetService("ReplicatedStorage")
    local rf = game:GetService("ReplicatedFirst")
    
    local foundInRS = DeepScan(rs, adonisPatterns)
    if foundInRS then return "Deep Scan (RS): " .. foundInRS:GetFullName() end
    
    local foundInRF = DeepScan(rf, adonisPatterns)
    if foundInRF then return "Deep Scan (RF): " .. foundInRF:GetFullName() end

    -- 3. Проверка на общие паттерны античитов (если Adonis нет, но есть другой античит)
    if DeepScan(rs, anticheatPatterns, 3000) then
        return "AntiCheat Pattern in RS"
    end

    -- 4. Продвинутая проверка: поиск потоков Adonis через getreg() (если доступно)
    -- Это самый надёжный метод, так как Adonis работает в отдельных потоках.
    if type(getreg) == "function" then
        local success, threads = pcall(getreg)
        if success and type(threads) == "table" then
            for _, thread in ipairs(threads) do
                if type(thread) == "thread" then
                    local ok, source = pcall(function() return debug.info(thread, "s") end)
                    if ok and source and type(source) == "string" then
                        local lowerSource = string.lower(source)
                        -- Ищем характерные пути Adonis в исходном коде
                        if string.find(lowerSource, "adonis", 1, true) 
                           or string.find(lowerSource, ".core.anti", 1, true)
                           or string.find(lowerSource, "plugins.anti_cheat", 1, true) then
                            return "Thread Source: Adonis Core Found"
                        end
                    end
                end
            end
        end
    end

    return nil
end

local function DetectBAC()
    local bacPatterns = {"adeggboostremotes", "logtelemetry", "bac_", "byfron"}
    local rs = game:GetService("ReplicatedStorage")
    
    -- Быстрая проверка
    for _, child in ipairs(rs:GetChildren()) do
        local name = string.lower(child.Name)
        for _, pattern in ipairs(bacPatterns) do
            if string.find(name, pattern, 1, true) then
                return "BAC Direct: " .. child.Name
            end
        end
    end
    
    -- Глубокий скан с лимитом
    local found = DeepScan(rs, bacPatterns, 4000)
    if found then return "BAC Deep: " .. found:GetFullName() end
    
    return nil
end

-- ============================================================
-- ГЛАВНАЯ ЛОГИКА ВЫБОРА РЕЖИМА (ОБНОВЛЕНА)
-- ============================================================
local function CheckGameAndLaunch()
    -- Ручной override для дебага
    if getgenv().XyqwForceMode then
        local forced = getgenv().XyqwForceMode
        if forced == "Ghost" or forced == "Extra" or forced == "Default" then
            pcall(function()
                StarterGui:SetCore("SendNotification", {
                    Title = "XyqwHub Loader",
                    Text = "FORCED: " .. forced,
                    Duration = 4,
                })
            end)
            StartMode(forced)
            return
        end
    end

    local mode = "Default"
    local reason = "clean game"

    -- ШАГ 1: Проверка на BAC игры (по PlaceId)
    if game.PlaceId == 107778070777162 -- Steal an Egg
        or game.PlaceId == 112410758658181 -- Steal a Brainrot
        or game.PlaceId == 13772394625 then -- Blade Ball
        mode = "Extra"
        reason = "BAC PlaceId: " .. game.PlaceId
    else
        -- ШАГ 2: Проверка на BAC объекты
        local bac = DetectBAC()
        if bac then
            mode = "Extra"
            reason = bac
        end
    end

    -- ШАГ 3: Если всё ещё Default, ищем Adonis или другие античиты
    if mode == "Default" then
        local adonis = DetectAdonis()
        if adonis then
            mode = "Ghost"
            reason = adonis
        else
            -- Если Adonis не нашли, но есть другие античит-паттерны, всё равно включаем Ghost
            local genericAC = DeepScan(game:GetService("ReplicatedStorage"), {"anticheat", "anti_cheat"}, 3000)
            if genericAC then
                mode = "Ghost"
                reason = "Generic AntiCheat: " .. genericAC.Name
            end
        end
    end

    -- ШАГ 4: Уведомление и лог
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "XyqwHub Loader",
            Text = "Mode: " .. mode .. " — " .. reason,
            Duration = 5,
        })
    end)
    pcall(function()
        warn("[XyqwLoader] Mode = " .. mode .. " | Reason = " .. reason .. " | PlaceId = " .. tostring(game.PlaceId))
    end)
    pcall(function()
        if writefile then
            writefile("XyqwHub/Logs/loader_debug.txt",
                "Mode: " .. mode ..
                "\nReason: " .. reason ..
                "\nPlaceId: " .. tostring(game.PlaceId) ..
                "\nTime: " .. os.date("%Y-%m-%d %H:%M:%S"))
        end
    end)

    pcall(function()
        if delfile and isfile(SESSION_FILE) then delfile(SESSION_FILE) end
    end)

    StartMode(mode)
end

-- ========== KICK DETECTOR ==========
local wasKicked = false
pcall(function()
    if isfile and isfile(SESSION_FILE) then
        wasKicked = true
        delfile(SESSION_FILE)
    end
end)

local function CreateKickNotification()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "RobloxNotif_" .. math.random(100000, 999999)
    screenGui.ResetOnSpawn = false
    screenGui.DisplayOrder = 999999
    pcall(function() screenGui.Parent = CoreGui end)
    if not screenGui.Parent then
        pcall(function() screenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui") end)
    end

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 320, 0, 135)
    frame.Position = UDim2.new(1, -340, 0, 20)
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
    icon.Size = UDim2.new(0, 28, 0, 28)
    icon.Position = UDim2.new(0, 10, 0, 10)
    icon.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    icon.Text = "!"
    icon.TextColor3 = Color3.fromRGB(255, 255, 255)
    icon.Font = Enum.Font.GothamBold
    icon.TextSize = 18
    icon.BorderSizePixel = 0
    icon.Parent = frame
    local iconCorner = Instance.new("UICorner")
    iconCorner.CornerRadius = UDim.new(0, 4)
    iconCorner.Parent = icon

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -50, 0, 22)
    title.Position = UDim2.new(0, 45, 0, 10)
    title.BackgroundTransparency = 1
    title.Text = "XyqwHub"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 15
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = frame

    local desc = Instance.new("TextLabel")
    desc.Size = UDim2.new(1, -20, 0, 40)
    desc.Position = UDim2.new(0, 10, 0, 42)
    desc.BackgroundTransparency = 1
    desc.Text = "Seems you were kicked last time.\nStart Ghost Mode?"
    desc.TextColor3 = Color3.fromRGB(210, 210, 210)
    desc.Font = Enum.Font.Gotham
    desc.TextSize = 13
    desc.TextWrapped = true
    desc.TextXAlignment = Enum.TextXAlignment.Left
    desc.TextYAlignment = Enum.TextYAlignment.Top
    desc.Parent = frame

    local btnYes = Instance.new("TextButton")
    btnYes.Size = UDim2.new(0.5, -15, 0, 30)
    btnYes.Position = UDim2.new(0, 10, 1, -40)
    btnYes.BackgroundColor3 = Color3.fromRGB(0, 150, 80)
    btnYes.TextColor3 = Color3.fromRGB(255, 255, 255)
    btnYes.Text = "Yes (Ghost)"
    btnYes.Font = Enum.Font.GothamBold
    btnYes.TextSize = 13
    btnYes.BorderSizePixel = 0
    btnYes.AutoButtonColor = false
    btnYes.Parent = frame
    local btnYesCorner = Instance.new("UICorner")
    btnYesCorner.CornerRadius = UDim.new(0, 4)
    btnYesCorner.Parent = btnYes

    local btnNo = Instance.new("TextButton")
    btnNo.Size = UDim2.new(0.5, -15, 0, 30)
    btnNo.Position = UDim2.new(0.5, 5, 1, -40)
    btnNo.BackgroundColor3 = Color3.fromRGB(100, 40, 40)
    btnNo.TextColor3 = Color3.fromRGB(255, 255, 255)
    btnNo.Text = "No, Continue"
    btnNo.Font = Enum.Font.GothamBold
    btnNo.TextSize = 13
    btnNo.BorderSizePixel = 0
    btnNo.AutoButtonColor = false
    btnNo.Parent = frame
    local btnNoCorner = Instance.new("UICorner")
    btnNoCorner.CornerRadius = UDim.new(0, 4)
    btnNoCorner.Parent = btnNo

    local timeLeft = 10
    task.spawn(function()
        while frame.Parent do
            desc.Text = string.format("Seems you were kicked last time.\nStart Ghost Mode? (%d)", timeLeft)
            task.wait(1)
            timeLeft = timeLeft - 1
            if timeLeft <= 0 then timeLeft = 10 end
        end
    end)

    btnYes.MouseButton1Click:Connect(function()
        screenGui:Destroy()
        shared.XyqwModeStarted = true
        StartMode("Ghost")
    end)

    btnNo.MouseButton1Click:Connect(function()
        screenGui:Destroy()
        shared.XyqwModeStarted = true
        CheckGameAndLaunch()
    end)
end

if wasKicked and not shared.XyqwModeStarted then
    CreateKickNotification()
else
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "XyqwHub",
            Text = "Detecting game... Please wait!",
            Duration = 3
        })
    end)
    task.wait(1.5)
    CheckGameAndLaunch()
end
