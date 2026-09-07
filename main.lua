-- ========== СТАТУСЫ ==========
print("[XyqwHub] Loading...")

-- ========== СОЗДАЁМ GUI ==========
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "XyqwHubGui"
screenGui.Parent = game:GetService("CoreGui")

-- ========== ДОК-КНОПКА ==========
local dockButton = Instance.new("TextButton")
dockButton.Name = "DockButton"
dockButton.Size = UDim2.new(0, 90, 0, 30)
dockButton.Position = UDim2.new(0.5, -45, 0.05, 10)
dockButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
dockButton.TextColor3 = Color3.fromRGB(255, 0, 0)
dockButton.Text = "XyqwHub"
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

-- ========== ГЛАВНОЕ ОКНО ==========
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 280, 0, 380)
mainFrame.Position = UDim2.new(0.5, -140, 0.5, -190)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.BorderSizePixel = 3
mainFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

-- Заголовок
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -40, 1, 0)
titleLabel.Position = UDim2.new(0, 5, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "XyqwGui PRIVATE v3"
titleLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = titleBar

-- Крестик
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 1, 0)
closeButton.Position = UDim2.new(1, -30, 0, 0)
closeButton.BackgroundTransparency = 1
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 0, 0)
closeButton.TextScaled = true
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = titleBar
closeButton.AutoButtonColor = false

-- ========== СКРОЛЛ ==========
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -10, 1, -40)
scrollFrame.Position = UDim2.new(0, 5, 0, 35)
scrollFrame.BackgroundTransparency = 1
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.ScrollBarThickness = 4
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 0, 0)
scrollFrame.Parent = mainFrame

-- ========== БЛОКИРОВКА КНОПОК ПРИ ОТКРЫТИИ ==========
local buttonsBlocked = false

local function blockButtonsTemporarily()
    buttonsBlocked = true
    task.wait(0.5)
    buttonsBlocked = false
end

-- ========== АНТИ-СПАМ ==========
local cooldowns = {}

local function CanRun(name)
    local lastRun = cooldowns[name] or 0
    if tick() - lastRun < 1.5 then
        return false
    end
    cooldowns[name] = tick()
    return true
end

-- ========== ФУНКЦИЯ ДЛЯ КОПИРОВАНИЯ В БУФЕР ==========
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

-- ========== ФУНКЦИЯ ДЛЯ СООБЩЕНИЙ ==========
local function ShowNotification(topText, bottomText, duration)
    duration = duration or 3.5
    
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

-- ========== ФУНКЦИЯ КНОПКИ ==========
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

-- ========== ФУНКЦИЯ ЗАПУСКА ==========
local function RunScript(name, url)
    print("[XyqwHub] " .. name .. " - STARTING...")
    local success, err = pcall(function()
        loadstring(game:HttpGet(url))()
    end)
    if success then
        print("[XyqwHub] " .. name .. " - LOADED!")
    else
        print("[XyqwHub] " .. name .. " - ERROR: " .. tostring(err))
    end
end

-- ========== ВСЕ КНОПКИ ==========
local y = 5

-- ===== BLADE BALL =====
local bladeBtn = CreateButton("Blade Ball", function()
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/joshhhie/rise/refs/heads/main/loader.lua"))()
    end)
    if success then
        print("[XyqwHub] Blade Ball - LOADED!")
    else
        print("[XyqwHub] Blade Ball - ERROR: " .. tostring(err))
    end
end)
bladeBtn.Position = UDim2.new(0, 5, 0, y)
y = y + 45

-- ===== ОСНОВНЫЕ СКРИПТЫ =====
local function addButton(text, url)
    local btn = CreateButton(text, function()
        RunScript(text, url)
    end)
    btn.Position = UDim2.new(0, 5, 0, y)
    y = y + 45
end

addButton("AntiKillParts", "https://raw.githubusercontent.com/sovetskii-shashlik/Anti-kill-parts-updated-/refs/heads/main/Anti%20kill%20parts%20by%20Zephyr")
addButton("PulseHub", "https://raw.githubusercontent.com/PulseZax/Loader/refs/heads/main/.lua")
addButton("RUNAWAYS", "https://raw.githubusercontent.com/Bac0nHck/Scripts/refs/heads/main/RUNAWAYS.lua")
addButton("Universal FE", "https://rawscripts.net/raw/Universal-Script-Universal-FE-Free-keyless-FE-script-242513")
addButton("UwU hub", "https://raw.githubusercontent.com/platinww/UwU/refs/heads/main/INK-GAME")
addButton("FakeVR", "https://pastefy.app/MvKHpycG/raw")
addButton("WallHop", "https://raw.githubusercontent.com/ScpGuest666/Random-Roblox-script/refs/heads/main/Roblox%20WallHop%20script")

-- ===== НОВЫЕ СКРИПТЫ =====
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

-- ===== DOORS V2 (КОПИРОВАНИЕ В БУФЕР) =====
local doorsV2Btn = CreateButton("Doors V2 (Copy)", function()
    local scriptText = [[getgenv().SCRIPT_KEY = "KEYLESS"
loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/abd3cc54d2dc7de4a091fb19c8f4ea9e15e939e7ecc88b475e6956e8af94ad6f/download"))()]]
    
    local copied = CopyToClipboard(scriptText)
    
    if copied then
        ShowNotification(
            "Sorry, Doors V2 cannot be run using XyqwHub",
            "Script copied to clipboard. Paste it into your executor"
        )
    else
        ShowNotification(
            "Sorry, Doors V2 cannot be run using XyqwHub",
            "Failed to copy! Please copy manually"
        )
    end
end)
doorsV2Btn.Position = UDim2.new(0, 5, 0, y)
y = y + 45

-- ===== DOORS V3 (Cheesy) =====
addButton("Doors V3 (Cheesy)", "https://raw.githubusercontent.com/doram44/cheesy/refs/heads/main/cheesy.lua")

-- ===== INFINITE YIELD =====
addButton("Infinite Yield", "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source")

-- ===== WALK ON WALLS (С СООБЩЕНИЕМ) =====
local walkBtn = CreateButton("Walk on walls", function()
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/The-patience-obby-Universal-Walk-on-walls-18129"))()
    end)
    if success then
        print("[XyqwHub] Walk on walls - LOADED!")
        ShowNotification(
            "To reset Walk on walls, rejoin the server",
            "Script should be loaded"
        )
    else
        print("[XyqwHub] Walk on walls - ERROR: " .. tostring(err))
        ShowNotification(
            "To reset Walk on walls, rejoin the server",
            "Failed to load: " .. tostring(err)
        )
    end
end)
walkBtn.Position = UDim2.new(0, 5, 0, y)
y = y + 45

-- ========== КНОПКА DESTROY XyqwHub (В САМОМ НИЗУ) ==========
local destroyBtn = CreateButton("DESTROY XyqwHub", function()
    screenGui:Destroy()
    print("[XyqwHub] XyqwHub DESTROYED")
end)
destroyBtn.Position = UDim2.new(0, 5, 0, y)
destroyBtn.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
destroyBtn.BorderColor3 = Color3.fromRGB(255, 50, 50)
y = y + 45

scrollFrame.CanvasSize = UDim2.new(0, 0, 0, y + 10)

-- ========== ПЕРЕТАСКИВАНИЕ ОКНА ==========
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

-- ========== ПЕРЕТАСКИВАНИЕ ДОК-КНОПКИ ==========
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

-- ========== ЗАКРЫТИЕ (крестик) ==========
local function closeGUI()
    mainFrame.Visible = false
    dockButton.Visible = true
end

closeButton.MouseButton1Click:Connect(closeGUI)
closeButton.TouchTap:Connect(closeGUI)

-- ========== ОТКРЫТИЕ (док-кнопка) ==========
local function openGUI()
    mainFrame.Visible = true
    dockButton.Visible = false
    blockButtonsTemporarily()
end

dockButton.MouseButton1Click:Connect(openGUI)
dockButton.TouchTap:Connect(openGUI)

-- ========== ФИНАЛ ==========
print("[XyqwHub] XyqwHub loaded!")
