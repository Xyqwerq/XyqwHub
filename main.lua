-- ========== XYQWHUB SMART LAUNCHER (v2.1 - 4 Modes) ==========
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")

local function Notify(title, text, duration)
    pcall(function() StarterGui:SetCore("SendNotification", {Title = title, Text = text, Duration = duration or 5}) end)
end

Notify("XyqwHub", "Check for the game... (Please, Wait!)", 3)
task.wait(1.5)

local mode = "Default"
local detectedAC = "None"

-- 1. Проверка на игры с BAC (Extra Mode) — Steal an Egg и Steal a Brainrot
local bacGames = {
    [107778070777162] = true, -- Steal an Egg
    [112410758658181] = true, -- Steal a Brainrot
    [13772394625] = true,     -- Blade Ball
}

if bacGames[game.PlaceId] then
    mode = "Extra"
    detectedAC = "BAC-6519 (Game ID)"
else
    -- 2. Проверка на ремоуты BAC в ReplicatedStorage
    local rs = game:GetService("ReplicatedStorage")
    for _, obj in ipairs(rs:GetDescendants()) do
        local name = string.lower(obj.Name)
        if string.find(name, "adEggBoostRemotes") or string.find(name, "rVBillboard_Cash_Reward") or string.find(name, "logtelemetry") then
            mode = "Extra"
            detectedAC = "BAC (Remote Detected)"
            break
        end
    end
end

-- 3. Проверка на Adonis (Ghost Mode)
if mode == "Default" then
    local ws = game:GetService("Workspace")
    for _, obj in ipairs(ws:GetDescendants()) do
        local name = string.lower(obj.Name)
        if string.find(name, "adonis") or string.find(name, "anticheat") or string.find(name, "hdadmin") then
            mode = "Ghost"
            detectedAC = "Adonis/Admin"
            break
        end
    end
end

-- 4. Проверка на известные безопасные игры (Default Mode)
local safeGames = {
    [95206881] = true,      -- Baseplate
    [142823291] = true,     -- MM2
    [6516141723] = true,    -- Doors
    [920587237] = true,     -- Adopt Me
}

if safeGames[game.PlaceId] then
    mode = "Default"
    detectedAC = "None"
end

-- ========== ВЫБОР РЕЖИМА ==========
if mode == "Extra" then
    Notify("XyqwHub", "AntiCheat detected: " .. detectedAC, 5)
    task.wait(1.5)
    Notify("XyqwHub", "Enabling Extra Mode (Safe Shell + Timer)...", 5)
    task.wait(1)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Xyqwerq/XyqwHub-Extra/main/main.lua"))()
    
elseif mode == "Ghost" then
    Notify("XyqwHub", "AntiCheat detected: " .. detectedAC, 5)
    task.wait(1.5)
    Notify("XyqwHub", "Enabling Ghost Mode...", 5)
    task.wait(1)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Xyqwerq/XyqwHub-Ghost/main/main.lua"))()
    
else
    Notify("XyqwHub", "Safe game detected. Enabling Default Mode...", 5)
    task.wait(1)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Xyqwerq/XyqwHub-Default/main/main.lua"))()
end
