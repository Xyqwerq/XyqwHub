-- ========== XYQWHUB LAUNCHER (v1.0) ==========
local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")

local HUB_NAME = "XyqwHub"
local TELEGRAM_URL = "https://t.me/XyqwerqHelper_Bot"

-- Ссылки на наши репозитории
local URL_GHOST = "https://raw.githubusercontent.com/Xyqwerq/XyqwHub-Ghost/main/main.lua"
local URL_DEFAULT = "https://raw.githubusercontent.com/Xyqwerq/XyqwHub-Default/main/main.lua"

-- Папки для логов
local FOLDER = "XyqwHub/Logs"
local LOG_FILE = FOLDER .. "/latestlog.txt"

pcall(function()
    if not isfolder("XyqwHub") then makefolder("XyqwHub") end
    if not isfolder(FOLDER) then makefolder(FOLDER) end
end)

local function Notify(title, text, duration)
    pcall(function()
        StarterGui:SetCore("SendNotification", {Title = title, Text = text, Duration = duration or 5})
    end)
end

-- ========== ОКНО КРАША ==========
local function ShowCrashUI(logData, onContinue)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "CrashUI_" .. math.random(1000, 9999)
    screenGui.ResetOnSpawn = false
    pcall(function() screenGui.Parent = game:GetService("CoreGui") end)
    if not screenGui.Parent then screenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui") end

    -- Главное окно
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 420, 0, 320)
    frame.Position = UDim2.new(0.5, -210, 0.5, -160)
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    frame.BorderSizePixel = 2
    frame.BorderColor3 = Color3.fromRGB(255, 0, 0)
    frame.Parent = screenGui

    -- Заголовок
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Position = UDim2.new(0, 0, 0, 10)
    title.BackgroundTransparency = 1
    title.Text = "Oops! The last session was crashed :("
    title.TextColor3 = Color3.fromRGB(255, 0, 0)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 16
    title.Parent = frame

    -- Кнопка ТГ (копирует ссылку)
    local tgBtn = Instance.new("TextButton")
    tgBtn.Size = UDim2.new(1, -20, 0, 30)
    tgBtn.Position = UDim2.new(0, 10, 0, 45)
    tgBtn.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
    tgBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    tgBtn.Text = "Please send this to @XyqwerqHelper_Bot (click here to copy link)"
    tgBtn.Font = Enum.Font.Gotham
    tgBtn.TextSize = 12
    tgBtn.BorderSizePixel = 1
    tgBtn.BorderColor3 = Color3.fromRGB(255, 0, 0)
    tgBtn.Parent = frame
    tgBtn.MouseButton1Click:Connect(function()
        pcall(function() setclipboard(TELEGRAM_URL) end)
        tgBtn.Text = "Link copied!"
        tgBtn.TextColor3 = Color3.fromRGB(0, 255, 100)
    end)

    -- Окно с логами
    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, -20, 0, 140)
    scroll.Position = UDim2.new(0, 10, 0, 85)
    scroll.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
    scroll.BorderSizePixel = 1
    scroll.BorderColor3 = Color3.fromRGB(255, 0, 0)
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroll.Parent = frame

    local logText = Instance.new("TextLabel")
    logText.Size = UDim2.new(1, -10, 0, 0)
    logText.Position = UDim2.new(0, 5, 0, 5)
    logText.BackgroundTransparency = 1
    logText.Text = "Logs (latestlog.txt):\n\n" .. logData
    logText.TextColor3 = Color3.fromRGB(200, 200, 200)
    logText.Font = Enum.Font.Code
    logText.TextSize = 11
    logText.TextWrapped = true
    logText.TextXAlignment = Enum.TextXAlignment.Left
    logText.TextYAlignment = Enum.TextYAlignment.Top
    logText.Size = UDim2.new(1, -10, 0, math.max(50, #logData * 2))
    logText.Parent = scroll
    scroll.CanvasSize = UDim2.new(0, 0, 0, logText.Size.Y.Offset + 10)

    -- Кнопка Копировать
    local copyBtn = Instance.new("TextButton")
    copyBtn.Size = UDim2.new(0.5, -15, 0, 30)
    copyBtn.Position = UDim2.new(0, 10, 1, -40)
    copyBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
    copyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    copyBtn.Text = "Copy Logs"
    copyBtn.Font = Enum.Font.GothamBold
    copyBtn.BorderSizePixel = 0
    copyBtn.Parent = frame
    copyBtn.MouseButton1Click:Connect(function()
        pcall(function() setclipboard(logData) end)
        copyBtn.Text = "Copied!"
    end)

    -- Кнопка Закрыть и продолжить
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0.5, -15, 0, 30)
    closeBtn.Position = UDim2.new(0.5, 5, 1, -40)
    closeBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    closeBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    closeBtn.Text = "Close and continue"
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.BorderSizePixel = 0
    closeBtn.Parent = frame
    closeBtn.MouseButton1Click:Connect(function()
        pcall(function() delfile(LOG_FILE) end) -- Удаляем лог после прочтения
        screenGui:Destroy()
        if onContinue then onContinue() end -- Продолжаем загрузку
    end)
end

-- ========== ОСНОВНАЯ ЛОГИКА ==========
local function StartLauncher()
    Notify(HUB_NAME, "Check for the game... (Please, Wait!)", 3)
    task.wait(1.5)

    -- Определяем режим
    local isGhostMode = false

    -- 1. Проверка на Steal an Egg
    if game.PlaceId == 107778070777162 then
        isGhostMode = true
    else
        -- 2. Проверка на наличие античитов в ReplicatedStorage
        local rs = game:GetService("ReplicatedStorage")
        for _, obj in ipairs(rs:GetChildren()) do
            local name = string.lower(obj.Name)
            if string.find(name, "adonis") or string.find(name, "anticheat") or string.find(name, "bac") then
                isGhostMode = true
                break
            end
        end
    end

    local modeName = isGhostMode and "Ghost" or "Default"
    local url = isGhostMode and URL_GHOST or URL_DEFAULT

    -- Собираем инфу для лога краша (на случай, если скрипт крашнется)
    local executor = "Unknown"
    pcall(function() if identifyexecutor then executor = identifyexecutor() end end)
    
    local logData = string.format(
        "Crashed: XyqwHub %s\nExecutor: %s\nUsername: %s\nPlace: %s\nPlaceId: %d\nTime: %s",
        modeName, 
        executor, 
        Players.LocalPlayer.Name, 
        tostring(game.Name), 
        game.PlaceId, 
        os.date("%d.%m.%Y in %H:%M (Moscow, Russia)")
    )
    pcall(function() writefile(LOG_FILE, logData) end)

    -- Запуск нужной версии
    if isGhostMode then
        Notify(HUB_NAME, "AntiCheat has been detected! Enabling Ghost Mode...", 5)
        task.wait(1.5)
        pcall(function() loadstring(game:HttpGet(url))() end)
    else
        Notify(HUB_NAME, "successfully checked. Enabling Default Mode...", 5)
        task.wait(1.5)
        pcall(function() loadstring(game:HttpGet(url))() end)
    end
end

-- ========== ПРОВЕРКА КРАША ПРИ СТАРТЕ ==========
local hasCrashed = false
local crashLogs = ""

if isfile and isfile(LOG_FILE) then
    local ok, data = pcall(function() return readfile(LOG_FILE) end)
    if ok and data and #data > 0 then
        hasCrashed = true
        crashLogs = data
    end
end

-- Если был краш - показываем окно, иначе запускаем сразу
if hasCrashed then
    ShowCrashUI(crashLogs, function()
        StartLauncher()
    end)
else
    StartLauncher()
end
