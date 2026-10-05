local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
    
local Window = Rayfield:CreateWindow({
   Name = "Universal Script",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Noitra Hub",
   LoadingSubtitle = "by Noitra",
   ShowText = "Rayfield", -- for mobile users to unhide Rayfield, change if you'd like
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   ToggleUIKeybind = "F", -- The keybind to toggle the UI visibility (string like "K" or Enum.KeyCode)

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from emitting warnings when the script has a version mismatch with the interface.

   -- Heartbeat = "https://www.sentivel.com/api/heartbeat/<your token>", -- Pings your Sentivel heartbeat while Rayfield is open, so you can see whether your script is running

   -- ScriptID = "sid_xxxxxxxxxxxx", -- Your Script ID from developer.sirius.menu — enables analytics, managed keys, and script hosting

   ConfigurationSaving = {
      Enabled = false,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "ExampleHub"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "noinvitelink", -- The Discord invite code, do not include Discord.gg/. E.g. Discord.gg/ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the Discord every time they load it up
   },

KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique, as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"Hello"} -- List of keys that the system will accept, can be RAW file links (pastebin, github, etc.) or simple strings ("hello", "key22")
   }
})

local MainTab = Window:CreateTab("🏠 Home", nil) -- Title, Image
local MainSection = MainTab:CreateSection("Main")

 local Button = MainTab:CreateButton({
   Name = "Fling",
   Callback = function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/K1LAS1K/Ultimate-Fling-GUI/main/flingscript.lua"))()
   end,
}) 

local Button = MainTab:CreateButton({
   Name = "God Mod",
   Callback = function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/gzami401-dev/Grezzy-god-mode/refs/heads/main/Grezzy%20god%20mode"))() 
   end,
})

local Slider = MainTab:CreateSlider({
   Name = "WalkSpeed slider",
   Range = {0, 1000},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "Slider1", -- A flag is the identifier for the configuration file; make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = (Value)
   end,
}) 

local Dropdown = MainTab:CreateDropdown({
   Name = "Select Players",
   Options = {"Player"},
   CurrentOption = {"nil"},
   MultipleOptions = false,
   Flag = "Teleport", -- A flag is the identifier for the configuration file; make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Options)
  --[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local teleportTarget = nil

-- Create GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 250, 0, 300)
Frame.Position = UDim2.new(0.5, -125, 0.4, 0)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.BorderSizePixel = 2
Frame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title.Text = "Player Teleport GUI"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.Parent = Frame

-- Scrolling list
local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(1, -10, 1, -70)
ScrollingFrame.Position = UDim2.new(0, 5, 0, 35)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 5, 0)
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ScrollingFrame.Parent = Frame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = ScrollingFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- TP Button
local TPButton = Instance.new("TextButton")
TPButton.Size = UDim2.new(1, -10, 0, 30)
TPButton.Position = UDim2.new(0, 5, 1, -35)
TPButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
TPButton.Text = "Teleport"
TPButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TPButton.Font = Enum.Font.GothamBold
TPButton.TextSize = 14
TPButton.Parent = Frame

-- Update player list function
local function updatePlayerList()
    for _, child in pairs(ScrollingFrame:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local PlayerButton = Instance.new("TextButton")
            PlayerButton.Size = UDim2.new(1, 0, 0, 25)
            PlayerButton.Text = player.Name
            PlayerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            PlayerButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            PlayerButton.Font = Enum.Font.Gotham
            PlayerButton.TextSize = 12
            PlayerButton.Parent = ScrollingFrame
            
            PlayerButton.MouseButton1Click:Connect(function()
                teleportTarget = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                TPButton.Text = "Teleport to: " .. player.Name
            end)
        end
    end
end

-- Teleport function
TPButton.MouseButton1Click:Connect(function()
    if teleportTarget then
        LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = teleportTarget.CFrame + Vector3.new(0, 3, 0)
    end
end)

-- Update list on player join/leave
Players.PlayerAdded:Connect(updatePlayerList)
Players.PlayerRemoving:Connect(updatePlayerList)
updatePlayerList()

-- Dragging the GUI
local dragging, dragInput, dragStart, startPos
Title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Frame.Position
    end
end)

Title.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

Title.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)
    
   end,
})

local MainTab = Window:CreateTab("Fly", nil) -- Title, Image
local MainSection = MainTab:CreateSection("Main")

local Button = MainTab:CreateButton({
   Name = "Fly V3",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
   end,
})

local Button = MainTab:CreateButton({
   Name = "NoClip",
   Callback = function()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local noclipEnabled = false
local connection

-- Création du bouton
local ScreenGui = Instance.new("ScreenGui")
local Button = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
Button.Parent = ScreenGui

Button.Size = UDim2.new(0, 150, 0, 50)
Button.Position = UDim2.new(0.5, -75, 0.5, 0)
Button.Text = "NOCLIP : OFF"
Button.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.TextScaled = true

-- Fonction Noclip
local function toggleNoclip()

    noclipEnabled = not noclipEnabled

    if noclipEnabled then
        Button.Text = "NOCLIP : ON"
        Button.BackgroundColor3 = Color3.fromRGB(50, 200, 50)

        connection = RunService.Stepped:Connect(function()
            if player.Character then
                for _, part in pairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)

    else
        Button.Text = "NOCLIP : OFF"
        Button.BackgroundColor3 = Color3.fromRGB(200, 50, 50)

        if connection then
            connection:Disconnect()
            connection = nil
        end
    end
end

Button.MouseButton1Click:Connect(toggleNoclip)
   end,
})

local MainTab = Window:CreateTab("🦈Fisch🦈", nil) -- Title, Image
local MainSection = MainTab:CreateSection("Main")

local Button = MainTab:CreateButton({
   Name = "Fisch Script",
   Callback = function()
  loadstring(game:HttpGet("https://rawscripts.net/raw/Fisch-Blackhub-Best-Undetected-Script-53591"))()
   end,
})

local MainTab = Window:CreateTab("99 Days", nil) -- Title, Image
local MainSection = MainTab:CreateSection("Main")

local Button = MainTab:CreateButton({
   Name = "99 Days Script",
   Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/loader.lua", true))()
   end,
})

local MainTab = Window:CreateTab("🍈Blox Fruit🍈", nil) -- Title, Image
local MainSection = MainTab:CreateSection("Main")

local Button = MainTab:CreateButton({
   Name = "Blox Fruit",
   Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/tlredz/Scripts/refs/heads/main/main.luau"))()
  
   end,
})