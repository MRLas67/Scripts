local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
Rayfield:Notify({
    Title = "Executing Script",
    Content = "LuaLabu is executing...",
    Duration = 3,
    Image = 4483362458,
})
local Window = Rayfield:CreateWindow({
    Name = "LuaLabu",
    Icon = 0,
    LoadingTitle = "by MRLas",
    LoadingSubtitle = "Last Updated 06.11.2025",
    ShowText = "LuaLabu",
    Theme = "DarkBlue",
    ToggleUIKeybind = "K",
    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false,
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "LuaLabu",
        FileName = "Settings"
    },
    Discord = {
        Enabled = false,
        Invite = "noinvitelink",
        RememberJoins = true6
    },
    KeySystem = true, 
    KeySettings = {
        Title = "LuaLabu | KeySystem",
        Subtitle = "The KeySystem is copied✅",
        Note = "Join Our Discord U Can get a Free Permanent Key",
        FileName = "Key",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = {"FREE_LuaLabuKey15667858"}
    }
})
Rayfield:Notify({
    Title = "Script Executed",
    Content = "LuaLabu was successfully executed.",
    Duration = 3,
    Image = 4483362458,
})
local Tab = Window:CreateTab("🏠 Home", nil)
local Section = Tab:CreateSection("Movement")
local infiniteJumpStarted = false
Tab:CreateToggle({
    Name = "Infinite Jump (Only PC)",
    CurrentValue = false,
    Flag = "InfiniteJump",
    Callback = function(Value)
        _G.infinjump = Value
        if not infiniteJumpStarted then
            infiniteJumpStarted = true
            local plr = game:GetService('Players').LocalPlayer
            local m = plr:GetMouse()
            m.KeyDown:Connect(function(k)
                if _G.infinjump and k:byte() == 32 then
                    local humanoid = plr.Character and plr.Character:FindFirstChildOfClass('Humanoid')
                    if humanoid then
                        humanoid:ChangeState('Jumping')
                        wait()
                        humanoid:ChangeState('Seated')
                    end
                end
            end)
        end
    end,
})
Tab:CreateSlider({
    Name = "WalkSpeed",
    Range = {16, 200},
    Increment = 1,
    Suffix = "Speed",
    CurrentValue = 16,
    Flag = "WalkSpeed",
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        character:WaitForChild("Humanoid").WalkSpeed = Value
    end,
})
local noclipEnabled = false
local RunService = game:GetService("RunService")
local plr = game:GetService('Players').LocalPlayer

Tab:CreateToggle({
    Name = "Precod cez steny",
    CurrentValue = false,
    Flag = "NoClip",
    Callback = function(Value)
        noclipEnabled = Value
    end,
})

RunService.Stepped:Connect(function()
    if noclipEnabled then
        local character = plr.Character
        if character then
            for _, part in pairs(character:GetChildren()) do
                if part:IsA("BasePart") and part.CanCollide then
                    part.CanCollide = false
                end
            end
        end
    end
end)
Tab:CreateSection("Executor")
local userCode = ""
Tab:CreateInput({
    Name = "Executor",
    PlaceholderText = "Enter Code...",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        userCode = Text
    end,
})
Tab:CreateButton({
    Name = "Execute",
    Callback = function()
        local success, err = pcall(function()
            loadstring(userCode)()
        end)
        if not success then
            warn("Execution Error: " .. tostring(err))
        end
    end
})
Tab:CreateSection("Teleporter")

local tpTarget = nil

Tab:CreateInput({
    Name = "Teleport to Player",
    PlaceholderText = "Enter Name...",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        tpTarget = text:lower()
    end,
})

Tab:CreateButton({
    Name = "Teleport",
    Callback = function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local ClosestMatch = nil
        local ShortestDistance = math.huge

        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local name = player.Name:lower()
                local displayName = player.DisplayName:lower()

                if name:find(tpTarget) or displayName:find(tpTarget) then
                    local dist = (LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                    if dist < ShortestDistance then
                        ClosestMatch = player
                        ShortestDistance = dist
                    end
                end
            end
        end

        if ClosestMatch then
            Character:MoveTo(ClosestMatch.Character.HumanoidRootPart.Position + Vector3.new(0, 3, 0))
        else
            warn("No One with that name was found 😢")
        end
    end,
})

local SectionESP = Tab:CreateSection("ESP")

--===[ Mená ESP ]===--
local espEnabled = false
local espColor = Color3.fromRGB(255, 0, 0)
local nameDrawings = {}

Tab:CreateToggle({
    Name = "Enable ESP Names",
    CurrentValue = false,
    Flag = "ESPEnabled",
    Callback = function(Value)
        espEnabled = Value

        for _, v in pairs(nameDrawings) do
            if v.Text then v.Text:Remove() end
        end
        nameDrawings = {}

        if espEnabled then
            local runService = game:GetService("RunService")
            local players = game:GetService("Players")
            local localPlayer = players.LocalPlayer
            local camera = workspace.CurrentCamera

            runService.RenderStepped:Connect(function()
                if not espEnabled then return end

                for _, player in pairs(players:GetPlayers()) do
                    if player ~= localPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local hrp = player.Character.HumanoidRootPart
                        local pos, visible = camera:WorldToViewportPoint(hrp.Position)

                        if visible then
                            if not nameDrawings[player] then
                                local text = Drawing.new("Text")
                                text.Size = 16
                                text.Center = true
                                text.Outline = true
                                text.Font = 2
                                nameDrawings[player] = {Text = text}
                            end

                            local distance = math.floor((localPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude)
                            local name = player.DisplayName or player.Name
                            local textObj = nameDrawings[player].Text
                            textObj.Position = Vector2.new(pos.X, pos.Y)
                            textObj.Text = string.format("[%dm] %s", distance, name)
                            textObj.Color = espColor
                            textObj.Visible = true
                        elseif nameDrawings[player] then
                            nameDrawings[player].Text.Visible = false
                            nameDrawings[player].Text.Position = Vector2.new(-1000, -1000)
                        end
                    elseif nameDrawings[player] then
                        nameDrawings[player].Text.Visible = false
                        nameDrawings[player].Text.Position = Vector2.new(-1000, -1000)
                    end
                end

                -- Odstráni hráčov čo opustili
                for player, obj in pairs(nameDrawings) do
                    if not player.Parent then
                        if obj.Text then obj.Text:Remove() end
                        nameDrawings[player] = nil
                    end
                end
            end)
        end
    end,
})

Tab:CreateColorPicker({
    Name = "ESP Name Color",
    Color = espColor,
    Flag = "ESPNAMEColor",
    Callback = function(Color)
        espColor = Color
    end,
})

--===[ Boxy ESP ]===--
local espBoxesEnabled = false
local espBoxColor = Color3.fromRGB(0, 255, 0)
local espBoxFilled = false
local espBoxTransparency = 0.5
local boxDrawings = {}

Tab:CreateToggle({
    Name = "Enable ESP Boxes",
    CurrentValue = false,
    Flag = "ESPBoxes",
    Callback = function(Value)
        espBoxesEnabled = Value

        for _, box in pairs(boxDrawings) do
            if box.Quad then box.Quad:Remove() end
        end
        boxDrawings = {}

        if espBoxesEnabled then
            local RunService = game:GetService("RunService")
            local Players = game:GetService("Players")
            local Camera = workspace.CurrentCamera
            local LocalPlayer = Players.LocalPlayer

            RunService.RenderStepped:Connect(function()
                if not espBoxesEnabled then return end

                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local hrp = player.Character.HumanoidRootPart
                        local size = Vector3.new(2, 3, 1.5)
                        local corners = {
                            hrp.CFrame * CFrame.new(-size.X, size.Y, -size.Z),
                            hrp.CFrame * CFrame.new(size.X, size.Y, -size.Z),
                            hrp.CFrame * CFrame.new(size.X, -size.Y, -size.Z),
                            hrp.CFrame * CFrame.new(-size.X, -size.Y, -size.Z),
                        }

                        local screenPoints = {}
                        local onScreen = true

                        for _, corner in pairs(corners) do
                            local screenPos, visible = Camera:WorldToViewportPoint(corner.Position)
                            if not visible then
                                onScreen = false
                                break
                            end
                            table.insert(screenPoints, Vector2.new(screenPos.X, screenPos.Y))
                        end

                        if onScreen then
                            if not boxDrawings[player] then
                                local box = Drawing.new("Quad")
                                box.Thickness = 1
                                box.Filled = espBoxFilled
                                box.Transparency = 1 - espBoxTransparency
                                box.Color = espBoxColor
                                box.Visible = true
                                boxDrawings[player] = {Quad = box}
                            end

                            local box = boxDrawings[player].Quad
                            box.Visible = true
                            box.Color = espBoxColor
                            box.Filled = espBoxFilled
                            box.Transparency = 1 - espBoxTransparency
                            box.PointA = screenPoints[1]
                            box.PointB = screenPoints[2]
                            box.PointC = screenPoints[3]
                            box.PointD = screenPoints[4]
                        elseif boxDrawings[player] then
                            local box = boxDrawings[player].Quad
                            box.Visible = false
                            box.PointA = Vector2.new(0, 0)
                            box.PointB = Vector2.new(0, 0)
                            box.PointC = Vector2.new(0, 0)
                            box.PointD = Vector2.new(0, 0)
                        end
                    elseif boxDrawings[player] then
                        local box = boxDrawings[player].Quad
                        box.Visible = false
                        box.PointA = Vector2.new(0, 0)
                        box.PointB = Vector2.new(0, 0)
                        box.PointC = Vector2.new(0, 0)
                        box.PointD = Vector2.new(0, 0)
                    end
                end

                -- Čistenie po hráčoch čo odišli
                for player, obj in pairs(boxDrawings) do
                    if not player.Parent then
                        if obj.Quad then obj.Quad:Remove() end
                        boxDrawings[player] = nil
                    end
                end
            end)
        end
    end,
})
Tab:CreateColorPicker({
    Name = "ESP Box Color",
    Color = espBoxColor,
    Flag = "ESPBoxColor",
    Callback = function(Color)
        espBoxColor = Color
    end,
})
local Section = Tab:CreateSection("Credits")
local Button = Tab:CreateButton({
   Name = "Copy Our Discord",
   Callback = function()
   setclipboard("https://discord.gg/GehDC2AbwR")
   Rayfield:Notify({
   Title = "Discord Server Is Copyied ✅",
   Content = "Thanks For Copying Our Discord server",
   Duration = 3.5,
   Image = 4483362458,
})
   end,
})
Rayfield:Notify({
   Title = "Copy Our Website",
   Content = "Our Website Isnt Fully Maked U Can Join Our Discord",
   Duration = 6.5,
   Image = 4483362458,
})
local Tab = Window:CreateTab("🎮 Hry", nil)
Tab:CreateButton({
    Name = "Dead Rails | Ez Win",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/refs/heads/main/DeadRails", true))()
    end,
})
Tab:CreateButton({
    Name = "Dead Rails | Bonds",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/hungquan99/HungHub/main/loader.lua"))()
    end,
})
Tab:CreateButton({
    Name = "Murder Mystery 2",
    Callback = function()
        loadstring(game:HttpGet('loadstring(game:HttpGet("https://soluna-script.vercel.app/murder-mystery-2.lua",true))()'))()
    end,
})
local Button = Tab:CreateButton({
   Name = "Steal a Brainrot",
   Callback = function()
   loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/ffdfeadf0af798741806ea404682a938.lua"))() 
   end,
})
local Button = Tab:CreateButton({
   Name = "Blade Ball",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/SoyAdriYT/PitbullHubX/refs/heads/main/PitbullHubX.lua", true))()
   end,
})
local Button = Tab:CreateButton({
   Name = "Doors",
   Callback = function()
   loadstring(game:HttpGet("https://rawscripts.net/raw/FLOOR-2-DOORS-Sensation-V2-20105"))()
   end,
})
local Tab = Window:CreateTab("💼 Admin", nil) -- Title, Image
local Button = Tab:CreateButton({
   Name = "LuaLabu Yield",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/MRLas67/Scripts/refs/heads/main/INF_Yield.lua"))()
   end,
})
local Button = Tab:CreateButton({
   Name = "Dex",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))()
   end,
})
local Button = Tab:CreateButton({
    Name = "UNC Test",
    Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/unified-naming-convention/NamingStandard/refs/heads/main/UNCCheckEnv.lua"))()
    end,
})
local Button = Tab:CreateButton({
    Name = "SUNC Test (More Accurate)",
    Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/HummingBird8/HummingRn/main/sUNCTestGET"))()
    end,
})
local Button = Tab:CreateButton({
    Name = "Auto Wallhopper (Najlepší na Telefón)",
    Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/ScpGuest666/Random-Roblox-script/refs/heads/main/Roblox%20WallHop%20V4%20script"))()
    end,
})
local Button = Tab:CreateButton({
    Name = "Naughty Dances",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/FWwdST5Y"))()
    end,
})
