-- ========== STATUS MESSAGES ==========
print("[XyqwHub] Loading...")

-- ========== CREATE GUI ==========
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "XyqwHub"
screenGui.Parent = game:GetService("CoreGui")

-- ========== DOCK BUTTON ==========
local dockButton = Instance.new("TextButton")
dockButton.Size = UDim2.new(0, 120, 0, 40)
dockButton.Position = UDim2.new(0.5, -60, 0.05, 10)
dockButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
dockButton.TextColor3 = Color3.fromRGB(255, 0, 0)
dockButton.Text = "XyqwHub"
dockButton.TextScaled = true
dockButton.Font = Enum.Font.GothamBold
dockButton.Parent = screenGui
dockButton.Visible = false

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = dockButton

-- ========== MAIN FRAME ==========
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 350, 0, 450)
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -225)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 10)
mainCorner.Parent = mainFrame

-- ========== TITLE BAR ==========
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 45)
titleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 10)
titleCorner.Parent = titleBar

local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(1, 0, 1, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "XyqwHub"
titleText.TextColor3 = Color3.fromRGB(255, 50, 50)
titleText.TextScaled = true
titleText.Font = Enum.Font.GothamBold
titleText.Parent = titleBar

-- ========== CLOSE BUTTON ==========
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 40, 0, 40)
closeBtn.Position = UDim2.new(1, -45, 0, 3)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = titleBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeBtn

-- ========== SCROLLING FRAME ==========
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -10, 1, -55)
scrollFrame.Position = UDim2.new(0, 5, 0, 50)
scrollFrame.BackgroundTransparency = 1
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.ScrollBarThickness = 5
scrollFrame.Parent = mainFrame

-- ========== FUNCTION: CREATE BUTTON ==========
local function CreateButton(name, yPos, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 40)
    btn.Position = UDim2.new(0, 5, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamSemibold
    btn.Parent = scrollFrame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn
    
    btn.MouseButton1Click:Connect(callback)
    
    -- Hover effect
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(80, 80, 120)
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
    end)
end

-- ========== FUNCTION: RUN SCRIPT ==========
local function RunScript(name, url)
    local success, err = pcall(function()
        loadstring(game:HttpGet(url))()
    end)
    
    if success then
        print("[XyqwHub] " .. name .. " - LOADED!")
    else
        print("[XyqwHub] " .. name .. " - ERROR: " .. tostring(err))
    end
end

-- ========== ADD BUTTONS ==========
local yPos = 10

CreateButton("AntiKillParts", yPos, function()
    RunScript("AntiKillParts", "https://raw.githubusercontent.com/sovetskii-shashlik/Anti-kill-parts-updated-/refs/heads/main/Anti%20kill%20parts%20by%20Zephyr")
end)
yPos = yPos + 50

CreateButton("PulseHub", yPos, function()
    RunScript("PulseHub", "https://raw.githubusercontent.com/PulseZax/Loader/refs/heads/main/.lua")
end)
yPos = yPos + 50

CreateButton("RUNAWAYS", yPos, function()
    RunScript("RUNAWAYS", "https://raw.githubusercontent.com/Bac0nHck/Scripts/refs/heads/main/RUNAWAYS.lua")
end)
yPos = yPos + 50

CreateButton("Universal FE", yPos, function()
    RunScript("Universal FE script", "https://rawscripts.net/raw/Universal-Script-Universal-FE-Free-keyless-FE-script-242513")
end)
yPos = yPos + 50

CreateButton("UwU Hub", yPos, function()
    RunScript("UwU hub", "https://raw.githubusercontent.com/platinww/UwU/refs/heads/main/INK-GAME")
end)
yPos = yPos + 50

CreateButton("FakeVR", yPos, function()
    RunScript("FakeVR", "https://pastefy.app/MvKHpycG/raw")
end)
yPos = yPos + 50

CreateButton("WallHop", yPos, function()
    RunScript("WallHop", "https://raw.githubusercontent.com/ScpGuest666/Random-Roblox-script/refs/heads/main/Roblox%20WallHop%20script")
end)
yPos = yPos + 50

-- Update canvas size
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 20)

-- ========== FUNCTIONS ==========
local function OpenGUI()
    mainFrame.Visible = true
    dockButton.Visible = false
end

local function CloseGUI()
    mainFrame.Visible = false
    dockButton.Visible = true
end

-- ========== BUTTON EVENTS ==========
closeBtn.MouseButton1Click:Connect(CloseGUI)

dockButton.MouseButton1Click:Connect(OpenGUI)

-- ========== DRAG FUNCTION ==========
local dragging = false
local dragStart, startPos

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

titleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(
            startPos.X.Scale, 
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- ========== START ==========
print("[XyqwHub] XyqwHub loaded!")
mainFrame.Visible = true
