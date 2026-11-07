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

local function CheckGameAndLaunch()
    local mode = "Default"

    -- BAC games (Steal an Egg / Steal a Brainrot / Blade Ball)
    if game.PlaceId == 107778070777162 or game.PlaceId == 112410758658181 or game.PlaceId == 13772394625 then
        mode = "Extra"
    else
        pcall(function()
            local rs = game:GetService("ReplicatedStorage")
            for _, obj in ipairs(rs:GetDescendants()) do
                local name = string.lower(obj.Name)
                if string.find(name, "adeggboostremotes") or string.find(name, "logtelemetry") then
                    mode = "Extra"
                    return
                end
            end
        end)
    end

    -- Adonis / AntiCheat detection
    if mode == "Default" then
        pcall(function()
            local ws = game:GetService("Workspace")
            for _, obj in ipairs(ws:GetDescendants()) do
                local name = string.lower(obj.Name)
                if string.find(name, "adonis") or string.find(name, "anticheat") then
                    mode = "Ghost"
                    return
                end
            end
        end)
    end
    if mode == "Default" then
        pcall(function()
            local services = {game:GetService("ReplicatedStorage"), game:GetService("ServerScriptService")}
            for _, svc in ipairs(services) do
                for _, obj in ipairs(svc:GetDescendants()) do
                    local name = string.lower(obj.Name)
                    if string.find(name, "adonis") then
                        mode = "Ghost"
                        return
                    end
                end
            end
        end)
    end

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
