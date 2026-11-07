-- ========== XYQWHUB SMART LAUNCHER (v2.5 - Fix BindToClose) ==========
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local CoreGui = game:GetService("CoreGui")

local FOLDER = "XyqwHub/Logs"
local SESSION_FILE = FOLDER .. "/session.txt"

pcall(function()
    if not isfolder("XyqwHub") then makefolder("XyqwHub") end
    if not isfolder(FOLDER) then makefolder(FOLDER) end
end)

local function Notify(title, text, duration)
    pcall(function() StarterGui:SetCore("SendNotification", {Title = title, Text = text, Duration = duration or 5}) end)
end

-- Функция запуска нужного режима
local function ProceedWithMode()
    local mode = "Default"
    local detectedAC = "None"

    -- 1. Проверка на BAC (Extra Mode)
    if game.PlaceId == 107778070777162 or game.PlaceId == 112410758658181 or game.PlaceId == 13772394625 then
        mode = "Extra"
        detectedAC = "BAC-6519"
    else
        local rs = game:GetService("ReplicatedStorage")
        for _, obj in ipairs(rs:GetDescendants()) do
            local name = string.lower(obj.Name)
            if string.find(name, "adEggBoostRemotes") or string.find(name, "rVBillboard_Cash_Reward") or string.find(name, "logtelemetry") then
                mode = "Extra"
                detectedAC = "BAC (Remote)"
                break
            end
        end
    end

    -- 2. Проверка на Adonis (Ghost Mode)
    if mode == "Default" then
        local ws = game:GetService("Workspace")
        for _, obj in ipairs(ws:GetDescendants()) do
            local name = string.lower(obj.Name)
            if string.find(name, "adonis") or string.find(name, "anticheat") or string.find(name, "hdadmin") then
                mode = "Ghost"
                detectedAC = "Adonis"
                break
            end
        end
    end

    -- Выбор режима
    if mode == "Extra" then
        Notify("XyqwHub", "AntiCheat detected: " .. detectedAC, 5)
        task.wait(1.5)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Xyqwerq/XyqwHub-Extra/main/main.lua"))()
    elseif mode == "Ghost" then
        Notify("XyqwHub", "AntiCheat detected: " .. detectedAC, 5)
        task.wait(1.5)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Xyqwerq/XyqwHub-Ghost/main/main.lua"))()
    else
        Notify("XyqwHub", "Safe game. Enabling Default Mode...", 5)
        task.wait(1)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Xyqwerq/XyqwHub-Default/main/main.lua"))()
    end
end

-- ========== ПРОВЕРКА НА КИК (БЕЗ BindToClose) ==========
local wasKicked = false
if isfile and isfile(SESSION_FILE) then
    wasKicked = true
    pcall(function() delfile(SESSION_FILE) end)
end

if wasKicked then
    Notify("XyqwHub", "Check for the game... (Please, Wait!)", 3)
    task.wait(1)

    -- Создаем UI запрос
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "KickPrompt_" .. math.random(1000, 9999)
    screenGui.ResetOnSpawn = false
    pcall(function() screenGui.Parent = CoreGui end)
    if not screenGui.Parent then screenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui") end

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 320, 0, 160)
    frame.Position = UDim2.new(0.5, -160, 0.5, -80)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BorderSizePixel = 0
    frame.Parent = screenGui

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 30)
    title.BackgroundTransparency = 1
    title.Text = "XyqwHub"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 18
    title.Parent = frame

    local desc = Instance.new("TextLabel")
    desc.Size = UDim2.new(1, -20, 0, 50)
    desc.Position = UDim2.new(0, 10, 0, 30)
    desc.BackgroundTransparency = 1
    desc.Text = "Seems you were kicked last time.\nStart Ghost Mode? (If you're kicked again, Extra will be enabled)"
    desc.TextColor3 = Color3.fromRGB(200, 200, 200)
    desc.Font = Enum.Font.Gotham
    desc.TextSize = 12
    desc.TextWrapped = true
    desc.Parent = frame

    local btnYes = Instance.new("TextButton")
    btnYes.Size = UDim2.new(0.5, -15, 0, 35)
    btnYes.Position = UDim2.new(0, 10, 1, -45)
    btnYes.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    btnYes.TextColor3 = Color3.fromRGB(255, 255, 255)
    btnYes.Text = "Yes"
    btnYes.Font = Enum.Font.GothamBold
    btnYes.Parent = frame

    local btnNo = Instance.new("TextButton")
    btnNo.Size = UDim2.new(0.5, -15, 0, 35)
    btnNo.Position = UDim2.new(0.5, 5, 1, -45)
    btnNo.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    btnNo.TextColor3 = Color3.fromRGB(255, 255, 255)
    btnNo.Text = "No, Continue"
    btnNo.Font = Enum.Font.GothamBold
    btnNo.Parent = frame

    btnYes.MouseButton1Click:Connect(function()
        screenGui:Destroy()
        Notify("XyqwHub", "Starting Ghost Mode...", 3)
        task.wait(1)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Xyqwerq/XyqwHub-Ghost/main/main.lua"))()
    end)

    btnNo.MouseButton1Click:Connect(function()
        screenGui:Destroy()
        ProceedWithMode()
    end)
else
    -- Создаем файл сессии (если его нет)
    pcall(function() if writefile then writefile(SESSION_FILE, "active") end end)
    
    Notify("XyqwHub", "Check for the game... (Please, Wait!)", 3)
    task.wait(1.5)
    ProceedWithMode()
end
