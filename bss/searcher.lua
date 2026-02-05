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
    Duration = 5
}


queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/Disqualifi3d/Exp/refs/heads/main/bss/searcher.lua'))()")

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


--[[
BSSLIST.DQ -> {}.List -> {{id = 1}, {id = 1}}
VICIOUSLIST.DQ -> {}.List -> {{id = 1}, {id = 1}}
]]

local function Get_New_Server()
    local file = readfile and readfile("BSSLIST.DQ")

    if file then
        local Decoded = HttpService:JSONDecode(file)
        local Selected = Decoded.List and Decoded.List[math.random(1, #Decoded.List)]

        local Selected_Server_Index = table.find(Decoded.List, Selected)
        table.remove(Decoded.List, Selected_Server_Index)

        if writefile then
            local New_File = HttpService:JSONEncode(Decoded.List)

            writefile("BSSLIST.DQ", New_File)
        end

        if Selected and Selected.id then return Selected.id end
    end
end

local function Insert_Server()
    local file = readfile and readfile("VICIOUSLIST.DQ")

    if not file and readfile then
        local Decoded = {
            List = {}
        }
        local Encoded = HttpService:JSONEncode(Decoded)
        if writefile then
            writefile("VICIOUSLIST.DQ", Encoded)
        end
    end

    local file = readfile and readfile("VICIOUSLIST.DQ")

    if file then
        local Decoded = HttpService:JSONDecode(file)

        local Data = {id = game.JobId}

        table.insert(Decoded.List, Data)

        if writefile then
            local New_File = HttpService:JSONEncode(Decoded.List)

            writefile("VICIOUSLIST.DQ", New_File)
        end
    end
end

local start = tick()
while task.wait() and start + Settings.Duration > tick() and Done == false do
    local WaitingThorn = WTs:FindFirstChild("WaitingThorn")
    local Vicious = Particles:FindFirstChild("Vicious")

    if (WaitingThorn or Vicious) and found == false then
        Insert_Server()
        Done = true
    end
end

while true do
    
    local New, Err = pcall(function()
        local id = Get_New_Server()
        Teleport_Service:TeleportToPlaceInstance(1537690962, id, game.Players.LocalPlayer)
    end)

    task.wait(15)
end
