-- ========== XYQWHUB STEALTH LAUNCHER (v1.2 OBFUSCATED) ==========
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")

-- Зашифрованные ссылки (чтобы античит не спалил их в тексте)
-- Ghost: https://raw.githubusercontent.com/Xyqwerq/XyqwHub-Ghost/main/main.lua
-- Default: https://raw.githubusercontent.com/Xyqwerq/XyqwHub-Default/main/main.lua
local function s(...) return string.char(...) end
local URL_GHOST = s(104,116,116,112,115,58,47,47,114,97,119,46,103,105,116,104,117,98,117,115,101,114,99,111,110,116,101,110,116,46,99,111,109,47,88,121,113,119,101,114,113,47,88,121,113,119,72,117,98,45,71,104,111,115,116,47,109,97,105,110,47,109,97,105,110,46,108,117,97)
local URL_DEFAULT = s(104,116,116,112,115,58,47,47,114,97,119,46,103,105,116,104,117,98,117,115,101,114,99,111,110,116,101,110,116,46,99,111,109,47,88,121,113,119,101,114,113,47,88,121,113,119,72,117,98,45,68,101,102,97,117,108,116,47,109,97,105,110,47,109,97,105,110,46,108,117,97)

local TELEGRAM_URL = "https://t.me/XyqwerqHelper_Bot"
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

-- Безопасная загрузка
local function SafeHttpGet(url)
    if typeof(syn) == "table" and syn.request then
        return syn.request({Url = url, Method = "GET"}).Body
    elseif typeof(request) == "function" then
        return request({Url = url, Method = "GET"}).Body
    else
        return game:HttpGet(url)
    end
end

-- ========== ОКНО КРАША ==========
local function ShowCrashUI(logData, onContinue)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "CrashUI_" .. math.random(1000, 9999)
    screenGui.ResetOnSpawn = false
    pcall(function() screenGui.Parent = game:GetService("CoreGui") end)
    if not screenGui.Parent then screenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui") end

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 420, 0, 320); frame.Position = UDim2.new(0.5, -210, 0.5, -160)
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0); frame.BorderSizePixel = 2; frame.BorderColor3 = Color3.fromRGB(255, 0, 0); frame.Parent = screenGui

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 30); title.Position = UDim2.new(0, 0, 0, 10); title.BackgroundTransparency = 1
    title.Text = "Oops! The last session was crashed :("; title.TextColor3 = Color3.fromRGB(255, 0, 0); title.Font = Enum.Font.GothamBold; title.TextSize = 16; title.Parent = frame

    local tgBtn = Instance.new("TextButton")
    tgBtn.Size = UDim2.new(1, -20, 0, 30); tgBtn.Position = UDim2.new(0, 10, 0, 45); tgBtn.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
    tgBtn.TextColor3 = Color3.fromRGB(255, 255, 255); tgBtn.Text = "Please send this to @XyqwerqHelper_Bot (click here to copy link)"
    tgBtn.Font = Enum.Font.Gotham; tgBtn.TextSize = 12; tgBtn.BorderSizePixel = 1; tgBtn.BorderColor3 = Color3.fromRGB(255, 0, 0); tgBtn.Parent = frame
    tgBtn.MouseButton1Click:Connect(function() pcall(function() setclipboard(TELEGRAM_URL) end); tgBtn.Text = "Link copied!"; tgBtn.TextColor3 = Color3.fromRGB(0, 255, 100) end)

    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, -20, 0, 140); scroll.Position = UDim2.new(0, 10, 0, 85); scroll.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
    scroll.BorderSizePixel = 1; scroll.BorderColor3 = Color3.fromRGB(255, 0, 0); scroll.CanvasSize = UDim2.new(0, 0, 0, 0); scroll.Parent = frame

    local logText = Instance.new("TextLabel")
    logText.Size = UDim2.new(1, -10, 0, 0); logText.Position = UDim2.new(0, 5, 0, 5); logText.BackgroundTransparency = 1
    logText.Text = "Logs (latestlog.txt):\n\n" .. logData; logText.TextColor3 = Color3.fromRGB(200, 200, 200)
    logText.Font = Enum.Font.Code; logText.TextSize = 11; logText.TextWrapped = true; logText.TextXAlignment = Enum.TextXAlignment.Left; logText.TextYAlignment = Enum.TextYAlignment.Top
    logText.Size = UDim2.new(1, -10, 0, math.max(50, #logData * 2)); logText.Parent = scroll; scroll.CanvasSize = UDim2.new(0, 0, 0, logText.Size.Y.Offset + 10)

    local copyBtn = Instance.new("TextButton")
    copyBtn.Size = UDim2.new(0.5, -15, 0, 30); copyBtn.Position = UDim2.new(0, 10, 1, -40); copyBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
    copyBtn.TextColor3 = Color3.fromRGB(255, 255, 255); copyBtn.Text = "Copy Logs"; copyBtn.Font = Enum.Font.GothamBold; copyBtn.BorderSizePixel = 0; copyBtn.Parent = frame
    copyBtn.MouseButton1Click:Connect(function() pcall(function() setclipboard(logData) end); copyBtn.Text = "Copied!" end)

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0.5, -15, 0, 30); closeBtn.Position = UDim2.new(0.5, 5, 1, -40); closeBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    closeBtn.TextColor3 = Color3.fromRGB(0, 0, 0); closeBtn.Text = "Close and continue"; closeBtn.Font = Enum.Font.GothamBold; closeBtn.BorderSizePixel = 0; closeBtn.Parent = frame
    closeBtn.MouseButton1Click:Connect(function() pcall(function() delfile(LOG_FILE) end); screenGui:Destroy(); if onContinue then onContinue() end end)
end

-- ========== ОСНОВНАЯ ЛОГИКА ==========
local function StartLauncher()
    Notify("XyqwHub", "Check for the game... (Please, Wait!)", 3)
    task.wait(1 + math.random()) -- Случайная задержка

    local isGhostMode = false

    if game.PlaceId == 107778070777162 then
        isGhostMode = true
    else
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

    local executor = "Unknown"
    pcall(function() if identifyexecutor then executor = identifyexecutor() end end)
    
    local logData = string.format("Crashed: XyqwHub %s\nExecutor: %s\nUsername: %s\nPlace: %s\nPlaceId: %d\nTime: %s", modeName, executor, Players.LocalPlayer.Name, tostring(game.Name), game.PlaceId, os.date("%d.%m.%Y in %H:%M (Moscow, Russia)"))
    pcall(function() writefile(LOG_FILE, logData) end)

    if isGhostMode then
        Notify("XyqwHub", "AntiCheat has been detected! Enabling Ghost Mode...", 5)
        task.wait(1.5)
        pcall(function()
            local code = SafeHttpGet(url)
            loadstring(code)()
        end)
    else
        Notify("XyqwHub", "successfully checked. Enabling Default Mode...", 5)
        task.wait(1.5)
        pcall(function()
            local code = SafeHttpGet(url)
            loadstring(code)()
        end)
    end
end

local hasCrashed = false
local crashLogs = ""
if isfile and isfile(LOG_FILE) then
    local ok, data = pcall(function() return readfile(LOG_FILE) end)
    if ok and data and #data > 0 then hasCrashed = true; crashLogs = data end
end

if hasCrashed then
    ShowCrashUI(crashLogs, function() StartLauncher() end)
else
    StartLauncher()
end
