local Settings = {
    Beam_Width = 0.25,
    Closest_Color = Color3.fromRGB(0, 255, 0),
    Color = Color3.fromRGB(255, 0, 0),

    --// Metal_Detector
    Pick_Up_Speed = 1,
    Metal_Size = 2,

    --// Star Collector
    Vitality_Color = Color3.fromRGB(99, 255, 82),
    Crit_Color = Color3.fromRGB(255, 182, 92),

    --// Fisher
    Fish_Duration = 1.5,
}

if not game:IsLoaded() then
    local notLoaded = Instance.new("Message")
    notLoaded.Parent = game.CoreGui
    notLoaded.Text = "DQ ESP is waiting for the game to load."
    game.Loaded:Wait()
    notLoaded:Destroy()
end

local Conf = game.CoreGui:FindFirstChild("DQESP")
if Conf then
    local s = Instance.new("Sound")
    s.SoundId = "rbxassetid://5914602124"
    s.Parent = workspace
    s:Play()

    s.Ended:Once(function()
        s:Destroy()
    end)

    return
else
    Conf = Instance.new("Configuration")
    Conf.Name = "DQESP"
    Conf.Parent = game.CoreGui
end

local Player = game.Players.LocalPlayer
local Character = Player.Character

local queueteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
local httprequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request

local TP_Check = false
local Enabled = true
local Active = false
local Holding = false

local Connections = {}
local Queued = {}
table.insert(Connections, Player.OnTeleport:Connect(function()
	if queueteleport and not TP_Check then
        TP_Check = true

		local Script = ""
        if isfile("BedwarsGlobalEsp.lua") then
            Script = "loadstring(readfile('BedwarsGlobalEsp.lua'))()"
        else
            Script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/Disqualifi3d/Exp/refs/heads/main/externalserverproposition.lua'))()"
        end
        
        queueteleport(Script)
	end
end))

if game.PlaceId == 6872265039 then
    local Part = Instance.new("Part")

    Part.CFrame = CFrame.new(0,51,0)
    Part.Transparency = 0.75
    Part.CanCollide = false
    Part.Anchored = true
    Part.Size = Vector3.one
    Part.Parent = workspace
    Part.Color = Color3.fromRGB(0, 0, 255)


     return
end

local function Get_Player_Kit()
    return Player:GetAttribute("PlayingAsKits")
end

local function Toggle()
    for _, Object: LayerCollector in pairs(Queued) do
        if Object:IsA("Highlight") or Object:IsA("Beam") then
            Object.Enabled = Enabled
        elseif Object:IsA("BasePart") then
            Object.Transparency = (Enabled == false and 1) or 0
        elseif Object:IsA("LayerCollector") then
            Object.Enabled = Enabled
        elseif Object:IsA("ProximityPrompt") and Object:GetAttribute("OG_HD") and Object:GetAttribute("OG_MAD") and Object:GetAttribute("EH_HD") and Object:GetAttribute("EH_MAD") then
            Object.MaxActivationDistance = (Enabled and Object:GetAttribute("EH_MAD")) or Object:GetAttribute("OG_MAD")
            Object.HoldDuration = (Enabled and Object:GetAttribute("EH_HD")) or Object:GetAttribute("OG_HD")
        end
    end
end

local function Insert(Object)
    if not Object or not Object.Parent or table.find(Queued, Object) then return end
    table.insert(Queued, Object)
end

local function Highlight_All_Bees(The_Bee)
    for _, Bee:Model in pairs(workspace:GetChildren()) do
        if Bee.Name == "Bee" then
            
            local Prompt = (Bee.PrimaryPart and Bee.PrimaryPart:FindFirstChildOfClass("ProximityPrompt"))

            if Prompt then

                if not Prompt:GetAttribute("OG_MAD") then
                    Prompt:SetAttribute("OG_MAD", Prompt.MaxActivationDistance)
                end
    
                if not Prompt:GetAttribute("OG_HD") then
                    Prompt:SetAttribute("OG_HD", Prompt.HoldDuration)
                end

                Prompt.MaxActivationDistance = 15
                Prompt.HoldDuration = 0

                if not Prompt:GetAttribute("EH_MAD") then
                    Prompt:SetAttribute("EH_MAD", Prompt.MaxActivationDistance)
                end
    
                if not Prompt:GetAttribute("EH_HD") then
                    Prompt:SetAttribute("EH_HD", Prompt.HoldDuration)
                end


                Insert(Prompt)
            end

            local Billboard = Bee:FindFirstChildOfClass("BillboardGui")
            if not Billboard then
                local BillboardGui = Instance.new("BillboardGui")
                local Lifetime = Instance.new("TextLabel")

                BillboardGui.Parent = Bee
                BillboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                BillboardGui.Active = true
                BillboardGui.AlwaysOnTop = true
                BillboardGui.Size = UDim2.new(0, 50, 0, 50)
                BillboardGui.SizeOffset = Vector2.new(1, 0)

                Lifetime.Name = "Lifetime"
                Lifetime.Parent = BillboardGui
                Lifetime.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Lifetime.BackgroundTransparency = 1.000
                Lifetime.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Lifetime.BorderSizePixel = 0
                Lifetime.Size = UDim2.new(1, 0, 1, 0)
                Lifetime.Font = Enum.Font.SourceSans
                Lifetime.Text = "180"
                Lifetime.TextColor3 = Color3.fromRGB(255, 255, 255)
                Lifetime.TextScaled = true
                Lifetime.TextSize = 14.000
                Lifetime.TextWrapped = true

                Bee:SetAttribute("Spawn_Time", tick() + 180)

                Insert(BillboardGui)
            else
                local Lifetime:TextLabel = Billboard:FindFirstChild("Lifetime")
                if Lifetime then
                    local Time_Left = (Bee:GetAttribute("Spawn_Time") and math.floor(Bee:GetAttribute("Spawn_Time") - tick())) or nil
                    Lifetime.Text = (Time_Left and tostring(Time_Left))
                end
            end

            local Highlight = Bee:FindFirstChildOfClass("Highlight")
            if not Highlight then
                local Highlight = Instance.new("Highlight")
                Highlight.Parent = Bee
                Highlight.Adornee = Bee
                Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop

                Insert(Highlight)
            end

            if Highlight then
                if Bee and Bee == The_Bee then
                    Highlight.FillColor = Settings.Closest_Color
                    Highlight.OutlineColor = Settings.Closest_Color
                else
                    Highlight.FillColor = Settings.Color
                    Highlight.OutlineColor = Settings.Color
                end
            end
        end
    end
end

local function Find_Closest_Bee():Model
    if not Character or not Character:FindFirstChild("HumanoidRootPart") or not Character.PrimaryPart then return end
    
    local Root = Character:FindFirstChild("HumanoidRootPart") or Character.PrimaryPart
    if not Root then return end
    local ClosestBee = nil
    local Prompt = nil
    local Distance = math.huge
   
    
    for _, Bee:Model in pairs(workspace:GetChildren()) do
        if Bee.Name == "Bee" then
            
            local BPart = Bee.PrimaryPart
            
            if BPart and (BPart.Position - Root.Position).Magnitude < Distance then
                ClosestBee = Bee
                Distance = (BPart.Position - Root.Position).Magnitude
            end
        end
    end
    
    return ClosestBee, Prompt
end

local function Highlight_All_Metals(The_Metal)
    for _, Metal in pairs(workspace:GetChildren()) do
        if Metal.Name == "Model" then
            for _, x in pairs(Metal:GetChildren()) do
                if x.Name == "hidden-metal-prompt" then

                    local BPart:BasePart = Metal:FindFirstChildWhichIsA("BasePart")
                    local Highlight:Highlight = (BPart and BPart:FindFirstChildOfClass("Highlight"))
                    local Prompt:ProximityPrompt = Metal:FindFirstChildOfClass("ProximityPrompt")

                    local Billboard = Metal:FindFirstChildOfClass("BillboardGui")
                    if not Billboard then
                        local BillboardGui = Instance.new("BillboardGui")
                        local Lifetime = Instance.new("TextLabel")

                        BillboardGui.Parent = Metal
                        BillboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                        BillboardGui.Active = true
                        BillboardGui.AlwaysOnTop = true
                        BillboardGui.Size = UDim2.new(0, 50, 0, 50)
                        BillboardGui.SizeOffset = Vector2.new(1, 0)

                        Lifetime.Name = "Lifetime"
                        Lifetime.Parent = BillboardGui
                        Lifetime.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        Lifetime.BackgroundTransparency = 1.000
                        Lifetime.BorderColor3 = Color3.fromRGB(0, 0, 0)
                        Lifetime.BorderSizePixel = 0
                        Lifetime.Size = UDim2.new(1, 0, 1, 0)
                        Lifetime.Font = Enum.Font.SourceSans
                        Lifetime.Text = "180"
                        Lifetime.TextColor3 = Color3.fromRGB(255, 255, 255)
                        Lifetime.TextScaled = true
                        Lifetime.TextSize = 14.000
                        Lifetime.TextWrapped = true

                        Metal:SetAttribute("Spawn_Time", tick() + 180)

                        Insert(BillboardGui)

                    else
                        local Lifetime:TextLabel = Billboard:FindFirstChild("Lifetime")
                        if Lifetime then
                            local Time_Left = (Metal:GetAttribute("Spawn_Time") and math.floor(Metal:GetAttribute("Spawn_Time") - tick())) or nil
                            Lifetime.Text = (Time_Left and tostring(Time_Left))
                        end
                    end

                    if not Highlight and BPart then
                        local Highlight = Instance.new("Highlight")
                        Highlight.Parent = BPart
                        Highlight.Adornee = BPart
                        Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop

                        BPart.Size = Vector3.new(Settings.Metal_Size, Settings.Metal_Size, Settings.Metal_Size)
                        BPart.Transparency = 0
                        Insert(BPart)
                        Insert(Highlight)
                    end

                    if Prompt then
                        if not Prompt:GetAttribute("OG_MAD") then
                            Prompt:SetAttribute("OG_MAD", Prompt.MaxActivationDistance)
                        end
            
                        if not Prompt:GetAttribute("OG_HD") then
                            Prompt:SetAttribute("OG_HD", Prompt.HoldDuration)
                        end

                        Prompt.HoldDuration = Settings.Pick_Up_Speed
                        Prompt.MaxActivationDistance = 7.5
                        Prompt.Enabled = true

                        if not Prompt:GetAttribute("EH_MAD") then
                            Prompt:SetAttribute("EH_MAD", Prompt.MaxActivationDistance)
                        end
            
                        if not Prompt:GetAttribute("EH_HD") then
                            Prompt:SetAttribute("EH_HD", Prompt.HoldDuration)
                        end

                        Insert(Prompt)
                    end

                    if Highlight then
                        if The_Metal and The_Metal == Metal then
                            Highlight.FillColor = Settings.Closest_Color
                            Highlight.OutlineColor = Settings.Closest_Color
                        else
                            Highlight.FillColor = Settings.Color
                            Highlight.OutlineColor = Settings.Color
                        end
                    end
                end
            end
        end
    end
end

local function Find_Closest_Metal()
    if not Character or not Character:FindFirstChild("HumanoidRootPart") or not Character.PrimaryPart then return end
    
    local Root = Character:FindFirstChild("HumanoidRootPart") or Character.PrimaryPart
    if not Root then return end
    local ClosestMetal = nil
    local Distance = math.huge
    
    for _, Metal in pairs(workspace:GetChildren()) do
        if Metal.Name == "Model" then
            for _, x in pairs(Metal:GetChildren()) do
                if x.Name == "hidden-metal-prompt" then
                    local BPart:BasePart = Metal:FindFirstChildWhichIsA("BasePart")

                    if BPart and (BPart.Position - Root.Position).Magnitude < Distance then
                        ClosestMetal = Metal
                        Distance = (BPart.Position - Root.Position).Magnitude
                    end
                end
            end

        end
    end

    return ClosestMetal
end

local function Highlight_All_Stars()
    for _, Star in pairs(workspace:GetChildren()) do
        if Star.Name == "VitalityStar" or Star.Name == "CritStar" then

            local Highlight:Highlight = Star:FindFirstChildOfClass("Highlight")
            local Prompt:ProximityPrompt = Star:FindFirstChildOfClass("ProximityPrompt")

            if not Highlight then
                local Highlight = Instance.new("Highlight")
                Highlight.Parent = Star
                Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                Insert(Highlight)
            end

            if Prompt then

                if not Prompt:GetAttribute("OG_MAD") then
                    Prompt:SetAttribute("OG_MAD", Prompt.MaxActivationDistance)
                end
    
                if not Prompt:GetAttribute("OG_HD") then
                    Prompt:SetAttribute("OG_HD", Prompt.HoldDuration)
                end

                Prompt.MaxActivationDistance = 15
                Prompt.Enabled = true

                if not Prompt:GetAttribute("EH_MAD") then
                    Prompt:SetAttribute("EH_MAD", Prompt.MaxActivationDistance)
                end
    
                if not Prompt:GetAttribute("EH_HD") then
                    Prompt:SetAttribute("EH_HD", Prompt.HoldDuration)
                end

                Insert(Prompt)
            end

            if Highlight then
                Highlight.FillColor = (Star.Name == "VitalityStar" and Settings.Vitality_Color) or (Star.Name == "CritStar" and Settings.Crit_Color)
                Highlight.OutlineColor = (Star.Name == "VitalityStar" and Settings.Vitality_Color) or (Star.Name == "CritStar" and Settings.Crit_Color)
            end
        end
    end
end

local function Find_Closest_Vitality_Star()
    if not Character or not Character:FindFirstChild("HumanoidRootPart") or not Character.PrimaryPart then return end
    
    local Root = Character:FindFirstChild("HumanoidRootPart") or Character.PrimaryPart
    if not Root then return end
    local ClosestVitality = nil
    local Distance = math.huge
    
    for _, Star in pairs(workspace:GetChildren()) do
        if Star.Name == "VitalityStar" then
            local BPart:BasePart = Star:FindFirstChildWhichIsA("BasePart")

            if BPart and (BPart.Position - Root.Position).Magnitude < Distance then
                ClosestVitality = Star
                Distance = (BPart.Position - Root.Position).Magnitude
           end
        end
    end

    return ClosestVitality
end

local function Find_Closest_Crit_Star()
    if not Character or not Character:FindFirstChild("HumanoidRootPart") or not Character.PrimaryPart then return end
    
    local Root = Character:FindFirstChild("HumanoidRootPart") or Character.PrimaryPart
    if not Root then return end
    local ClosestCrit = nil
    local Distance = math.huge
    
    for _, Star in pairs(workspace:GetChildren()) do
        if Star.Name == "CritStar" then
            local BPart:BasePart = Star:FindFirstChildWhichIsA("BasePart")

            if BPart and (BPart.Position - Root.Position).Magnitude < Distance then
                ClosestCrit = Star
                Distance = (BPart.Position - Root.Position).Magnitude
           end
        end
    end

    return ClosestCrit
end

local function Highlight_This_Tree_Orb(AddedObject)
    local Prompt = (AddedObject and AddedObject:WaitForChild("treeOrb", 5)) or nil
    if not Prompt or not Prompt:IsA("ProximityPrompt") then return false end

    local Model = Prompt.Parent
    if not Model then return false end

    local Highlight = Instance.new("Highlight")
    Highlight.Parent = Model
    
    Highlight.FillColor = Settings.Color
    Highlight.OutlineColor = Settings.Color
    
    if AddedObject:FindFirstChildOfClass("BasePart") or AddedObject.PrimaryPart then
        local P = AddedObject:FindFirstChildOfClass("BasePart") or AddedObject.PrimaryPart

        P.Transparency = 0
    end

    Insert(Highlight)
    return true
end

local function Get_Tree_Orbs()
    local Received = {}
    for _, Object in pairs(workspace:GetDescendants()) do
        local IsAPrompt = (Object and Object.Name == "treeOrb" and Object:IsA("ProximityPrompt")) or nil
        if not IsAPrompt then continue end
        
        Highlight_This_Tree_Orb(Object.Parent)
        table.insert(Received, Object.Parent)
    end

    return Received
end

local function Find_Closest_Tree_Orb(Orbs)

    local Root: BasePart = Character and (Character:FindFirstChild("HumanoidRootPart") or Character.PrimaryPart)

    local Current = nil
    local Max_Dist = math.huge

    for _, Orb: Model in pairs(Orbs) do
        if not Root then continue end
        --if not Orb or not Orb.Parent or not Orb:FindFirstChildOfClass("BasePart") or not Orb:FindFirstChildOfCass("MeshPart") or not Orb.PrimaryPart then continue end

        local Part: BasePart = Orb:FindFirstChildOfClass("BasePart") or Orb:FindFirstChildOfClass("MeshPart") or Orb.PrimaryPart

        if Part and Part.Parent and (Part.Position - Root.Position).Magnitude < Max_Dist then
            
            Current = Orb
            Max_Dist = (Part.Position - Root.Position).Magnitude
        end
    end

    return Current
end

local function Lucia_Insert()
    if Get_Player_Kit() == "pinata" then
        for _,v in pairs(workspace.Map:GetDescendants()) do
            if v.Name == "pinata" and v:GetAttribute("Owner") and v:GetAttribute("Owner") == Player.UserId then
                local Prompt = v:FindFirstChildOfClass("ProximityPrompt")
                if Prompt then
                    fireproximityprompt(Prompt)
                end
            end
        end
    end
end

local function intialize()
    Active = false

    if Get_Player_Kit() == "beekeeper" then
        Active = true
        local The_Bee = nil
    
        while task.wait() and Active == true do
            Highlight_All_Bees(The_Bee)
            local Bee = Find_Closest_Bee()
            Character = Player.Character
            
            local Root = Character and (Character:FindFirstChild("HumanoidRootPart") or Character.PrimaryPart)
    
            if Bee and Bee.PrimaryPart and Root then
                The_Bee = Bee
                local BAttachment = Bee.PrimaryPart:FindFirstChildOfClass("Attachment") or Instance.new("Attachment", Bee.PrimaryPart)
                local Player_Attachment = Root:FindFirstChildOfClass("Attachment") or Instance.new("Attachment", Root)
                
                
                local Beam = Character:FindFirstChild("Beam")
                if not Beam then
                    
                    Beam = Instance.new("Beam")
                    Beam.FaceCamera = true
                    Beam.Width0 = Settings.Beam_Width
                    Beam.Width1 = Settings.Beam_Width
                    Beam.Transparency = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 1),
                        NumberSequenceKeypoint.new(0.5, 0),
                        NumberSequenceKeypoint.new(1, 0),
                    })
                    Beam.Brightness = 5
    
                    Beam.Parent = Character
                    Insert(Beam)
                end
                
                if BAttachment and Player_Attachment and Beam then
                    Beam.Attachment0 = Player_Attachment
                    Beam.Attachment1 = BAttachment
                end
            else
                The_Bee = nil
            end
            Toggle()
        end
    
        The_Bee = nil
    elseif Get_Player_Kit() == "metal_detector" then
        Active = true
        local The_Metal = nil
    
        while task.wait() and Active == true do
            Highlight_All_Metals(The_Metal)
            local Metal: Model = Find_Closest_Metal()
            Character = Player.Character
            
            local Root:BasePart = Character and (Character:FindFirstChild("HumanoidRootPart") or Character.PrimaryPart)
            
            local Metal_Part:BasePart = (Metal and Metal:FindFirstChildWhichIsA("BasePart"))
            
            if Metal and Metal_Part and Root then
                The_Metal = Metal
                local BAttachment:Attachment = Metal_Part:FindFirstChildOfClass("Attachment") or Instance.new("Attachment", Metal_Part)
                local Player_Attachment:Attachment = Root:FindFirstChildOfClass("Attachment") or Instance.new("Attachment", Root)
        
                local Beam:Beam = Character:FindFirstChild("Beam")
                if not Beam then
                    
                    Beam = Instance.new("Beam")
                    Beam.FaceCamera = true
                    Beam.Brightness = 5
                    Beam.Width0 = Settings.Beam_Width
                    Beam.Width1 = Settings.Beam_Width
                    Beam.Transparency = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 1),
                        NumberSequenceKeypoint.new(0.5, 0),
                        NumberSequenceKeypoint.new(1, 0),
                    })
    
    
                    Beam.Parent = Character
                    Insert(Beam)
                end
                
                
                if BAttachment and Player_Attachment and Beam then
                    Beam.Attachment0 = Player_Attachment
                    Beam.Attachment1 = BAttachment
                end
                
            else
                The_Metal = nil
            end
            Toggle()
        end
        The_Metal = nil
    elseif Get_Player_Kit() == "star_collector" then

        Active = true
        local Closest_Vitality = nil
        local Closest_Crit = nil
        
        while task.wait() and Active == true do
            Highlight_All_Stars()
            
        
            Closest_Vitality = Find_Closest_Vitality_Star()
            Closest_Crit = Find_Closest_Crit_Star()
        
            Character = Player.Character
            
            local Root:BasePart = Character and (Character:FindFirstChild("HumanoidRootPart") or Character.PrimaryPart)
            
            local VSP:BasePart = (Closest_Vitality and Closest_Vitality:IsA("Model") and (Closest_Vitality.PrimaryPart or Closest_Vitality:FindFirstChildWhichIsA("BasePart")))
            local CSP:BasePart = (Closest_Crit and Closest_Crit:IsA("Model") and (Closest_Crit.PrimaryPart or Closest_Crit:FindFirstChildWhichIsA("BasePart")))
        
            
    
            if Closest_Vitality and VSP and Root then
                local BAttachment:Attachment = VSP:FindFirstChildOfClass("Attachment") or Instance.new("Attachment", VSP)
                local Player_Attachment:Attachment = Root:FindFirstChildOfClass("Attachment") or Instance.new("Attachment", Root)
        
                local Beam:Beam = Character:FindFirstChild("Vitality_Beam")
                if not Beam then
                    
                    Beam = Instance.new("Beam")
                    Beam.Name = "Vitality_Beam"
                    Beam.FaceCamera = true
                    Beam.Brightness = 5
                    Beam.Color = ColorSequence.new(Settings.Vitality_Color)
                    Beam.Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 1),
                    NumberSequenceKeypoint.new(0.5, 0),
                    NumberSequenceKeypoint.new(1, 0),
                    })
                    Beam.Width0 = Settings.Beam_Width
                    Beam.Width1 = Settings.Beam_Width
        
                    Beam.Parent = Character
                    Insert(Beam)
                end
                
                
                if BAttachment and Player_Attachment and Beam then
                    Beam.Attachment0 = Player_Attachment
                    Beam.Attachment1 = BAttachment
                end
                
            else
                Closest_Vitality = nil
            end
        
            if Closest_Crit and CSP and Root then
                local BAttachment:Attachment = CSP:FindFirstChildOfClass("Attachment") or Instance.new("Attachment", CSP)
                local Player_Attachment:Attachment = Root:FindFirstChildOfClass("Attachment") or Instance.new("Attachment", Root)
        
                local Beam:Beam = Character:FindFirstChild("Crit_Beam")
                if not Beam then
                    
                    Beam = Instance.new("Beam")
                    Beam.Name = "Crit_Beam"
                    Beam.FaceCamera = true
                    Beam.Brightness = 5
                    Beam.Color = ColorSequence.new(Settings.Crit_Color)
                    Beam.Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 1),
                    NumberSequenceKeypoint.new(0.5, 0),
                    NumberSequenceKeypoint.new(1, 0),
                    })
                    Beam.Width0 = Settings.Beam_Width
                    Beam.Width1 = Settings.Beam_Width
        
                    Beam.Parent = Character
                    Insert(Beam)
                end
                
                
                if BAttachment and Player_Attachment and Beam then
                    Beam.Attachment0 = Player_Attachment
                    Beam.Attachment1 = BAttachment
                end
                
            else
                Closest_Crit = nil
            end
            
            Toggle()
        end
        
        Closest_Vitality = nil
        Closest_Crit = nil
    elseif Get_Player_Kit() == "bigman" then
        Active = true

        local Orbs = Get_Tree_Orbs() --// Table
        local Closest_Orb = nil

        table.insert(Connections, workspace.ChildAdded:Connect(function(child)
            if Highlight_This_Tree_Orb(child) then
                table.insert(Orbs, child)
            end
        end))

        while task.wait() and Active == true do
            
            Closest_Orb = Find_Closest_Tree_Orb(Orbs)
            Character = Player.Character

            for _, O in pairs(Orbs) do
                if not O or not O.Parent then continue end

                local Highlighter: Highlight = O:FindFirstChildOfClass("Highlight")

                if not Highlighter then continue end

                if O == Closest_Orb then
                    Highlighter.FillColor = Settings.Closest_Color
                    Highlighter.OutlineColor = Settings.Closest_Color
                else
                    Highlighter.FillColor = Settings.Color
                    Highlighter.OutlineColor = Settings.Color
                end
            end

            local Root:BasePart = Character and (Character:FindFirstChild("HumanoidRootPart") or Character.PrimaryPart)
            
            local OP:BasePart = (Closest_Orb and Closest_Orb:IsA("Model") and (Closest_Orb.PrimaryPart or Closest_Orb:FindFirstChildWhichIsA("BasePart")))
        
             if Closest_Orb and OP and Root then
                local BAttachment:Attachment = OP:FindFirstChildOfClass("Attachment") or Instance.new("Attachment", OP)
                local Player_Attachment:Attachment = Root:FindFirstChildOfClass("Attachment") or Instance.new("Attachment", Root)
        
                local Beam:Beam = Character:FindFirstChild("Beam")
                if not Beam then
                    Beam = Instance.new("Beam")
                    Beam.Name = "Beam"
                    Beam.FaceCamera = true
                    Beam.Brightness = 5
                    Beam.Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 1),
                    NumberSequenceKeypoint.new(0.5, 0),
                    NumberSequenceKeypoint.new(1, 0),
                    })
                    Beam.Width0 = Settings.Beam_Width
                    Beam.Width1 = Settings.Beam_Width
        
                    Beam.Parent = Character
                    Insert(Beam)
                end
                
                if BAttachment and Player_Attachment and Beam then
                    Beam.Attachment0 = Player_Attachment
                    Beam.Attachment1 = BAttachment
                end
                
            else
                Closest_Orb = nil
            end

            Toggle()
        end
        
    elseif Get_Player_Kit() == "fisherman" then
        Active = true

        local Player_Gui = Player.PlayerGui
        local AB = Player_Gui:WaitForChild("ActionBarScreenGui")
        local Action_Bar = AB:FindFirstChild("ActionBar")

        while task.wait() and Active == true do
            
            local FMA = Action_Bar:FindFirstChild("FishingMinigameApp")
            local Whatever_This_Is = FMA and FMA:FindFirstChild("3")
            local Progress_Bar = Whatever_This_Is and Whatever_This_Is:FindFirstChild("ProgressBar")
            local Actual_Bar = Progress_Bar and Progress_Bar:FindFirstChild("2")

            local Minigame = Whatever_This_Is and Whatever_This_Is:FindFirstChild("Minigame")
            local Fish_Zone = Minigame and Minigame:FindFirstChild("FishZone")
            local Marker = Minigame and Minigame:FindFirstChild("Marker")

            if FMA and Whatever_This_Is and Progress_Bar and Actual_Bar and Minigame and Fish_Zone and Marker and Enabled then


                local Start = tick()
                local Progress = 0
                local Dur = Settings.Fish_Duration * Random.new():NextNumber(1, 1.5)
                
                repeat 
                    task.wait()
                    
                    
                    Marker.Position = UDim2.new(Fish_Zone.Position.X.Scale - (Marker.Size.X.Scale / 2), 0, Marker.Position.Y.Scale, 0)

                    local elapsed = tick() - Start
                    Progress = elapsed / Dur
                    Actual_Bar.Size = UDim2.new(Progress, 0, 1, 0)
                until Progress >= 1 or not Enabled

                Marker.Position = UDim2.new(Fish_Zone.Position.X.Scale - (Marker.Size.X.Scale / 2), 0, Marker.Position.Y.Scale, 0)
            end

        end
    end

    
end

local function Stop()

    Active = false
    Enabled = false

    Toggle()
    for _, Connection in pairs(Connections) do
        if Connection then Connection:Disconnect() end
    end

    for _, Object: LayerCollector in pairs(Queued) do
       if Object then Object:Destroy() end
    end

    if Conf then Conf:Destroy() end
end

table.insert(Connections, game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessedEvent)
    if gameProcessedEvent then return end

    if input.KeyCode == Enum.KeyCode.Minus then

        if Get_Player_Kit() == "pinata" then 
            Lucia_Insert()
            return
        end

        Enabled = not Enabled
    end

    if input.KeyCode == Enum.KeyCode.Home and not gameProcessedEvent then
        Holding = true

        local Duration = tick() + 3


        while Duration > tick() and Holding == true do
            
            task.wait()
        end
        if Holding == false then return end

        Stop()
    end
end))

table.insert(Connections, game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessedEvent)
    if input.KeyCode == Enum.KeyCode.Home and not gameProcessedEvent then
        
        Holding = false
    end
end))

if Get_Player_Kit() == nil then 
    repeat
    task.wait()
    until Get_Player_Kit() ~= nil
end

table.insert(Connections, Player:GetAttributeChangedSignal("PlayingAsKits"):Connect(function()
    intialize()
end))



intialize()
