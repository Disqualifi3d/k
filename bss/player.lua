if not game:IsLoaded() then
    local notLoaded = Instance.new("Message")
    notLoaded.Parent = game.CoreGui
    notLoaded.Text = "DQ BSS is waiting for the game to load."
    game.Loaded:Wait()
    notLoaded:Destroy()
end

local httprequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request

local Teleport_Service = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Particles = workspace:WaitForChild("Particles", 100)
local WTs = Particles:WaitForChild("WTs")

local found = false
local Done = false

local Settings = {
    Threshold = 10,
}

queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/Disqualifi3d/Exp/refs/heads/main/bss/player.lua'))()")

local s, e = pcall(function() 
readfile("BSSLIST.DQ")
end)

if readfile and not s then
    
    if writefile then
        
        local Data = {
            List = {}
        }

        print("Creating BSSLIST.DQ")
        
        local js_encoded = HttpService:JSONEncode(Data)

        writefile("BSSLIST.DQ", js_encoded)
    end

end

local s, e = pcall(function() 
readfile("VICIOUSLIST.DQ")
end)

if readfile and not s then
    
    if writefile then
        
        local Data = {
            List = {}
        }
        
        local js_encoded = HttpService:JSONEncode(Data)

        print("Creating VICIOUSLIST.DQ")

        writefile("VICIOUSLIST.DQ", js_encoded)
    end

end

local function getServerList(placeId)
    local cursor
    local servers = {}
    repeat
        local response = 
            httprequest(
                {
                    Url = "https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100" .. (cursor and "&cursor=" .. cursor or ""),
                    Method = "GET"
            }
        )
    
        for _, v in pairs(response) do
            table.insert(servers, v)
        end
        cursor = response.nextPageCursor
    until not cursor
    return servers
end

local function DownloadServerList()
    local Success, Error

    repeat
        Success, Error = pcall(function()
            local Servers = getServerList(1537690962)

            local Encoded_List = Servers[4]
            local List = HttpService:JSONDecode(Encoded_List) and HttpService:JSONDecode(Encoded_List).data

            local Downloaded = {
                Last_Download = tick(),
                List = List
            }

            local Encoded_File = HttpService:JSONEncode(Downloaded)

            if Encoded_File and writefile then
                writefile("BSSLIST.DQ", Encoded_File)
            end
        end)

        if not Success then warn(Error) end

        task.wait(10)
    until Success
end

local function CheckServerAmount()
    
    local file = readfile and readfile("BSSLIST.DQ")

    if file then
        local Decoded = HttpService:JSONDecode(file)

        if Decoded.List then return #Decoded.List end
    end

end

local function Check_Vicious_Bee_List()
    local file = readfile and readfile("VICIOUSLIST.DQ")

    if file then
        local Decoded = HttpService:JSONDecode(file)

        if Decoded.List then return #Decoded.List end
    end
end

local function Get_Vicious_Bee_Server()
    local file = readfile and readfile("VICIOUSLIST.DQ")

    if file then
        local Decoded = HttpService:JSONDecode(file)
        local Selected = Decoded.List and Decoded.List[math.random(1, #Decoded.List)]

        local Selected_Server_Index = table.find(Decoded.List, Selected)
        table.remove(Decoded.List, Selected_Server_Index)

        if writefile then
            local New_File = HttpService:JSONEncode(Decoded.List)

            writefile("VICIOUSLIST.DQ", New_File)
        end

        if Selected and Selected.id then return Selected.id end
    end
end

while task.wait() do
    
    local WaitingThorn = WTs:FindFirstChild("WaitingThorn")
    local Vicious = Particles:FindFirstChild("Vicious")

    if (WaitingThorn or Vicious) and found == false then
        found = true
        
        task.spawn(function()
            task.spawn(function()
                while task.wait(1) do
                    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                        game.Players.LocalPlayer.Character.Humanoid.JumpPower = 80
                    end
                end
            end)
            loadstring(game:HttpGet("https://rawscripts.net/raw/Bee-Swarm-Simulator-KEYLESS-ATLAS-HUB-BEST-SCRIPT-FARMING-BEE-SWARM-84013"))()
        end)
        
        if WaitingThorn then repeat print("waiting for thorn") task.wait() until not WaitingThorn or not WaitingThorn.Parent end
        
        local Vicious = Particles:WaitForChild("Vicious", 5)

        if Vicious then repeat print("waiting for bee") task.wait() until not Vicious or not Vicious.Parent end
    end

    if Check_Vicious_Bee_List() > 0 then
        
        local id = Get_Vicious_Bee_Server()

        local New, Err = pcall(function()
            Teleport_Service:TeleportToPlaceInstance(1537690962, id, game.Players.LocalPlayer)
        end)

        if New then print("Player should be teleporting") end

        task.wait(10)
    end

    if CheckServerAmount() <= Settings.Threshold then
        DownloadServerList()
    end

end
