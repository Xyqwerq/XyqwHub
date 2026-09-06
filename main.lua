-- ========== STATUS MESSAGES ==========
print("[XyqwHub] Loading...")

-- ========== LOAD RAYFIELD MODAL (исправленная ссылка) ==========
local success, err = pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/vyvegroup/RayfieldModal/main/source.lua"))()
end)

if not success then
    print("[XyqwHub] XyqwGui failed to load :(")
    print("[XyqwHub] Error: " .. tostring(err))
    return
end

print("[XyqwHub] XyqwHub loaded!")

-- ========== CREATE DOCK BUTTON ==========
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "XyqwHubGui"
screenGui.Parent = game:GetService("CoreGui")

local dockButton = Instance.new("TextButton")
dockButton.Size = UDim2.new(0, 120, 0, 40)
dockButton.Position = UDim2.new(0.5, -60, 0.05, 10)
dockButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
dockButton.TextColor3 = Color3.fromRGB(255, 0, 0)
dockButton.Text = "XyqwHub"
dockButton.TextScaled = true
dockButton.Font = Enum.Font.GothamBold
dockButton.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = dockButton

-- ========== CREATE MAIN WINDOW ==========
local Window = RayfieldModal:CreateWindow({
    Name = "XyqwHub",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "XyqwHub",
        FileName = "Config"
    }
})

Window:SetCloseFunction(function()
    dockButton.Visible = true
end)

dockButton.Visible = false

-- ========== CREATE TAB ==========
local MainTab = Window:CreateTab("Scripts", 0)

-- ========== RUN SCRIPT FUNCTION ==========
local function RunScript(name, url)
    local success, err = pcall(function()
        loadstring(game:HttpGet(url))()
    end)
    
    if success then
        print("[XyqwHub] " .. name .. " - LOADED!")
        RayfieldModal:Notify({
            Title = "Success!",
            Content = name .. " loaded",
            Duration = 3
        })
    else
        print("[XyqwHub] " .. name .. " - ERROR: " .. tostring(err))
        RayfieldModal:Notify({
            Title = "Error!",
            Content = name .. " failed to load",
            Duration = 3
        })
    end
end

-- ========== BUTTONS ==========
MainTab:CreateLabel("Blade Ball")

MainTab:CreateButton({
    Name = "AntiKillParts",
    Callback = function()
        RunScript("AntiKillParts", "https://raw.githubusercontent.com/sovetskii-shashlik/Anti-kill-parts-updated-/refs/heads/main/Anti%20kill%20parts%20by%20Zephyr")
    end
})

MainTab:CreateButton({
    Name = "PulseHub",
    Callback = function()
        RunScript("PulseHub", "https://raw.githubusercontent.com/PulseZax/Loader/refs/heads/main/.lua")
    end
})

MainTab:CreateButton({
    Name = "RUNAWAYS",
    Callback = function()
        RunScript("RUNAWAYS", "https://raw.githubusercontent.com/Bac0nHck/Scripts/refs/heads/main/RUNAWAYS.lua")
    end
})

MainTab:CreateButton({
    Name = "Universal FE script",
    Callback = function()
        RunScript("Universal FE script", "https://rawscripts.net/raw/Universal-Script-Universal-FE-Free-keyless-FE-script-242513")
    end
})

MainTab:CreateButton({
    Name = "UwU hub",
    Callback = function()
        RunScript("UwU hub", "https://raw.githubusercontent.com/platinww/UwU/refs/heads/main/INK-GAME")
    end
})

MainTab:CreateButton({
    Name = "FakeVR",
    Callback = function()
        RunScript("FakeVR", "https://pastefy.app/MvKHpycG/raw")
    end
})

MainTab:CreateButton({
    Name = "WallHop",
    Callback = function()
        RunScript("WallHop", "https://raw.githubusercontent.com/ScpGuest666/Random-Roblox-script/refs/heads/main/Roblox%20WallHop%20script")
    end
})

-- ========== OPEN DOCK BUTTON ==========
dockButton.MouseButton1Click:Connect(function()
    Window:Open()
    dockButton.Visible = false
end)
