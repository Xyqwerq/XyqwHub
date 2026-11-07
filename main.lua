-- ========== XYQWHUB SMART LAUNCHER (v3.0 - Fake Notification) ==========
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
    if typeof(syn) == "table" and syn.request then return syn.request({Url = url, Method = "GET"}).Body
    elseif typeof(request) == "function" then return request({Url = url, Method = "GET"}).Body
    else return game:HttpGet(url) end
end

local function StartMode(mode)
    local url = mode == "Extra" and "https://raw.githubusercontent.com/Xyqwerq/XyqwHub-Extra/main/main.lua" 
             or mode == "Ghost" and "https://raw.githubusercontent.com/Xyqwerq/XyqwHub-Ghost/main/main.lua" 
             or "https://raw.githubusercontent.com/Xyqwerq/XyqwHub-Default/main/main.lua"
    pcall(function() loadstring(SafeHttpGet(url))() end)
end

local function CheckGameAndLaunch()
    local mode = "Default"
    if game.PlaceId == 107778070777162 or game.PlaceId == 112410758658181 or game.PlaceId == 13772394625 then
        mode = "Extra"
    else
        local rs = game:GetService("ReplicatedStorage")
        for _, obj in ipairs(rs:GetDescendants()) do
            local name = string.lower(obj.Name)
            if string.find(name, "adEggBoostRemotes") or string.find(name, "logtelemetry") then mode = "Extra"; break end
        end
    end
    if mode == "Default" then
        local ws = game:GetService("Workspace")
        for _, obj in ipairs(ws:GetDescendants()) do
            local name = string.lower(obj.Name)
            if string.find(name, "adonis") or string.find(name, "anticheat") then mode = "Ghost"; break end
        end
    end
    StartMode(mode)
end

-- ========== ПРОВЕРКА НА КИК ==========
local wasKicked = false
if isfile and isfile(SESSION_FILE) then
    wasKicked = true
    pcall(function() delfile(SESSION_FILE) end)
end

if wasKicked then
    -- Создаем фейковое уведомление в стиле Roblox
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "RobloxNotif_" .. math.random(1000, 9999)
    screenGui.ResetOnSpawn = false
    pcall(function() screenGui.Parent = CoreGui end)
    if not screenGui.Parent then screenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui") end

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 100)
    frame.Position = UDim2.new(1, -320, 0, 20) -- Правый верхний угол
    frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    frame.BorderSizePixel = 0
    frame.Parent = screenGui

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -10, 0, 24)
    title.Position = UDim2.new(0, 5, 0, 5)
    title.BackgroundTransparency = 1
    title.Text = "XyqwHub"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 14
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = frame

    local desc = Instance.new("TextLabel")
    desc.Size = UDim2.new(1, -10, 0, 34)
    desc.Position = UDim2.new(0, 5, 0, 26)
    desc.BackgroundTransparency = 1
    desc.Text = "Seems you were kicked last time.\nStart Ghost Mode?"
    desc.TextColor3 = Color3.fromRGB(200, 200, 200)
    desc.Font = Enum.Font.Gotham
    desc.TextSize = 12
    desc.TextWrapped = true
    desc.TextXAlignment = Enum.TextXAlignment.Left
    desc.Parent = frame

    local btnYes = Instance.new("TextButton")
    btnYes.Size = UDim2.new(0.5, -10, 0, 24)
    btnYes.Position = UDim2.new(0, 5, 1, -30)
    btnYes.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    btnYes.TextColor3 = Color3.fromRGB(255, 255, 255)
    btnYes.Text = "Yes (Ghost)"
    btnYes.Font = Enum.Font.GothamBold
    btnYes.TextSize = 12
    btnYes.Parent = frame

    local btnNo = Instance.new("TextButton")
    btnNo.Size = UDim2.new(0.5, -10, 0, 24)
    btnNo.Position = UDim2.new(0.5, 5, 1, -30)
    btnNo.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    btnNo.TextColor3 = Color3.fromRGB(255, 255, 255)
    btnNo.Text = "No, Continue"
    btnNo.Font = Enum.Font.GothamBold
    btnNo.TextSize = 12
    btnNo.Parent = frame

    -- Если игрок ничего не нажимает, таймер обновляет текст
    local timeLeft = 10
    local timerTask = task.spawn(function()
        while timeLeft > 0 and frame.Parent do
            desc.Text = string.format("Seems you were kicked last time.\nStart Ghost Mode? (%d)", timeLeft)
            task.wait(1)
            timeLeft = timeLeft - 1
        end
        if frame.Parent then
            frame:Destroy() -- Окно пропало, но мы его сразу пересоздадим в цикле
            wasKicked = true
            -- Перезапускаем лоадер
            if not shared.XyqwModeStarted then
                loadstring(game:HttpGet("https://raw.githubusercontent.com/Xyqwerq/XyqwHub/main/main.lua"))()
            end
        end
    end)

    btnYes.MouseButton1Click:Connect(function()
        shared.XyqwModeStarted = true
        pcall(function() task.cancel(timerTask) end)
        frame:Destroy()
        StartMode("Ghost")
    end)

    btnNo.MouseButton1Click:Connect(function()
        shared.XyqwModeStarted = true
        pcall(function() task.cancel(timerTask) end)
        frame:Destroy()
        CheckGameAndLaunch()
    end)
else
    pcall(function() if writefile then writefile(SESSION_FILE, "active") end end)
    pcall(function() StarterGui:SetCore("SendNotification", {Title = "XyqwHub", Text = "Check for the game... (Please, Wait!)", Duration = 3}) end)
    task.wait(1.5)
    CheckGameAndLaunch()
end
