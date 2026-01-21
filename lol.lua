local HttpService = game:GetService("HttpService")
if not game:IsLoaded() then
    local notLoaded = Instance.new("Message")
    notLoaded.Parent = game.CoreGui
    notLoaded.Text = "DQ KA is waiting for the game to load."
    game.Loaded:Wait()
    notLoaded:Destroy()
end

local Conf = game.CoreGui:FindFirstChild("DQKA")
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
    Conf.Name = "DQKA"
    Conf.Parent = game.CoreGui
end

local Settings = {
    Range = 15,
    Degrees = 90,

    Filter = false,
    Anti_Streamer = true,

    Default_Anim_Delay = 0.13,
    Auto = 0.1,

    Mode = "Slight",
    Visible = false,
    lol = false,
}

local function Save_Settings()
    local S, E = pcall(function()
        local Saved_Settings = HttpService:JSONEncode(Settings)

        if Saved_Settings and writefile then
            writefile("DQSETTINGS.DQKA", Saved_Settings)
        end
    end)
end

local Store = { --// DONT EDIT ANYTHING HERE
    Attack_Remote = game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("node_modules"):WaitForChild("@rbxts"):WaitForChild("net"):WaitForChild("out"):WaitForChild("_NetManaged"):WaitForChild("SwordHit"),

    Inventory = {},

    Block_Hit = 0.3,

    Swords = { 
        [1] = {
            Name = "wood_sword",
        },
        [2] = {
            Name = "stone_sword",
        },
        [3] = {
            Name = "iron_sword",
        },
        [4] = {
            Name = "diamond_sword",
        },
        [5] = {
            Name = "emerald_sword",
        },
        [6] = {
            Name = "rageblade",
        },
        [7] = {
            Name = "noctium_blade"
        },
        [8] = {
            Name = "noctium_blade_2"
        },
        [9] = {
            Name = "noctium_blade_3"
        },
        [10] = {
            Name = "noctium_blade_4"
        },
        [11] = {
            Name = "ice_sword"
        },
        [12] = {
            Name = "wood_dao"
        },
        [13] = {
            Name = "stone_dao"
        },
        [14] = {
            Name = "iron_dao"
        },
        [15] = {
            Name = "diamond_dao"
        },
        [16] = {
            Name = "emerald_dao"
        }
    },

    Tools = {
        [1] = {
            Name = "wood_pickaxe",
        },
        [2] = {
            Name = "wood_axe"
        },

        [3] = {
            Name = "stone_pickaxe",
        },
        [4] = {
            Name = "stone_axe"
        },

        [5] = {
            Name = "iron_pickaxe",
        },
        [6] = {
            Name = "iron_axe"
        },

        [7] = {
            Name = "diamond_pickaxe",
        },
        [8] = {
            Name = "diamond_axe"
        },

        [9] = {
            Name = "wool_shear"
        },
        [10] = {
            Name = "shears"
        },
    },

    Kits = {
        ["none"] = { Kit_Image = "rbxassetid://16493320215", Kit_Title = "None" },
        ["winter_lady"] = { Kit_Image = "rbxassetid://83274578564074", Kit_Title = "Sophia"},
        ["mimic"] = { Kit_Image = "rbxassetid://14783283296", Kit_Title = "Milo" },
        ["star_collector"] = { Kit_Image = "rbxassetid://9872356516", Kit_Title = "Star Collector Stella" },
        ["angel"] = { Kit_Image = "rbxassetid://9166208240", Kit_Title = "Trinity" },
        ["scarab"] = { Kit_Image = "rbxassetid://137137517627492", Kit_Title = "Abaddon" },
        ["sword_shield"] = { Kit_Image = "rbxassetid://131690429591874", Kit_Title = "Isabel" },
        ["defender"] = { Kit_Image = "rbxassetid://116567110607862", Kit_Title = "Marcel" },
        ["cactus"] = { Kit_Image = "rbxassetid://104436517801089", Kit_Title = "Martin" },
        ["oasis"] = { Kit_Image = "rbxassetid://120283205213823", Kit_Title = "Nahla" },
        ["berserker"] = { Kit_Image = "rbxassetid://90258047545241", Kit_Title = "Ragnar" },
        ["airbender"] = { Kit_Image = "rbxassetid://74712750354593", Kit_Title = "Ramil" },
        ["gun_blade"] = { Kit_Image = "rbxassetid://138231219644853", Kit_Title = "Zarrah" },
        ["frost_hammer_kit"] = { Kit_Image = "rbxassetid://11838567073", Kit_Title = "Adetunde" },
        ["spider_queen"] = { Kit_Image = "rbxassetid://95237509752482", Kit_Title = "Arachne" },
        ["archer"] = { Kit_Image = "rbxassetid://9224796984", Kit_Title = "Archer" },
        ["axolotl"] = { Kit_Image = "rbxassetid://9155466713", Kit_Title = "Axolotl Amy" },
        ["baker"] = { Kit_Image = "rbxassetid://9155463919", Kit_Title = "Baker" },
        ["barbarian"] = { Kit_Image = "rbxassetid://9166207628", Kit_Title = "Barbarian" },
        ["builder"] = { Kit_Image = "rbxassetid://9155463708", Kit_Title = "Builder" },
        ["necromancer"] = { Kit_Image = "rbxassetid://11343458097", Kit_Title = "Crypt" },
        ["cyber"] = { Kit_Image = "rbxassetid://9507126891", Kit_Title = "Cyber" },
        ["sorcerer"] = { Kit_Image = "rbxassetid://97940108361528", Kit_Title = "Death Adder" },
        ["bigman"] = { Kit_Image = "rbxassetid://9155467211", Kit_Title = "Eldertree" },
        ["warlock"] = { Kit_Image = "rbxassetid://15186338366", Kit_Title = "Eldric" },
        ["ember"] = { Kit_Image = "rbxassetid://9630017904", Kit_Title = "Ember" },
        ["spirit_assassin"] = { Kit_Image = "rbxassetid://10406002412", Kit_Title = "Evelynn" },
        ["farmer_cletus"] = { Kit_Image = "rbxassetid://9155466936", Kit_Title = "Farmer Cletus" },
        ["ice_queen"] = { Kit_Image = "rbxassetid://9155466204", Kit_Title = "Freiya" },
        ["grim_reaper"] = { Kit_Image = "rbxassetid://9155467410", Kit_Title = "Grim Reaper" },
        ["spirit_gardener"] = { Kit_Image = "rbxassetid://132108376114488", Kit_Title = "Grove" },
        ["hannah"] = { Kit_Image = "rbxassetid://10726577232", Kit_Title = "Hannah" },
        ["shielder"] = { Kit_Image = "rbxassetid://9155464114", Kit_Title = "Infernal Shielder" },
        ["summoner"] = { Kit_Image = "rbxassetid://18922378956", Kit_Title = "Kaida" },
        ["glacial_skater"] = { Kit_Image = "rbxassetid://84628060516931", Kit_Title = "Krystal" },
        ["cowgirl"] = { Kit_Image = "rbxassetid://9155462968", Kit_Title = "Lassy" },
        ["dragon_sword"] = { Kit_Image = "rbxassetid://16215630104", Kit_Title = "Lian" },
        ["lumen"] = { Kit_Image = "rbxassetid://9630018371", Kit_Title = "Lumen" },
        ["flower_bee"] = { Kit_Image = "rbxassetid://101569742252812", Kit_Title = "Lyla" },
        ["jellyfish"] = { Kit_Image = "rbxassetid://18129974852", Kit_Title = "Marina" },
        ["melody"] = { Kit_Image = "rbxassetid://9155464915", Kit_Title = "Melody" },
        ["miner"] = { Kit_Image = "rbxassetid://9166208461", Kit_Title = "Miner" },
        ["nazar"] = { Kit_Image = "rbxassetid://18926951849", Kit_Title = "Nazar" },
        ["davey"] = { Kit_Image = "rbxassetid://9155464612", Kit_Title = "Pirate Davey" },
        ["seahorse"] = { Kit_Image = "rbxassetid://11902552560", Kit_Title = "Sheila" },
        ["elk_master"] = { Kit_Image = "rbxassetid://15714972287", Kit_Title = "Sigrid" },
        ["rebellion_leader"] = { Kit_Image = "rbxassetid://18926409564", Kit_Title = "Silas" },
        ["void_hunter"] = { Kit_Image = "rbxassetid://122370766273698", Kit_Title = "Skoll" },
        ["taliyah"] = { Kit_Image = "rbxassetid://13989437601", Kit_Title = "Taliyah" },
        ["harpoon"] = { Kit_Image = "rbxassetid://18250634847", Kit_Title = "Triton" },
        ["void_walker"] = { Kit_Image = "rbxassetid://78915127961078", Kit_Title = "Trixie" },
        ["spirit_summoner"] = { Kit_Image = "rbxassetid://95760990786863", Kit_Title = "Uma" },
        ["triple_shot"] = { Kit_Image = "rbxassetid://9166208149", Kit_Title = "Vanessa" },
        ["void_knight"] = { Kit_Image = "rbxassetid://73636326782144", Kit_Title = "Void Knight" },
        ["regent"] = { Kit_Image = "rbxassetid://9166208904", Kit_Title = "Void Regent" },
        ["vulcan"] = { Kit_Image = "rbxassetid://9155465543", Kit_Title = "Vulcan" },
        ["owl"] = { Kit_Image = "rbxassetid://12509401147", Kit_Title = "Whisper" },
        ["black_market_trader"] = { Kit_Image = "rbxassetid://18922642482", Kit_Title = "Wren" },
        ["dasher"] = { Kit_Image = "rbxassetid://9155467645", Kit_Title = "Yuzi" },
        ["disruptor"] = { Kit_Image = "rbxassetid://11596993583", Kit_Title = "Zenith" },
        ["wizard"] = { Kit_Image = "rbxassetid://13353923546", Kit_Title = "Zeno" },
        ["aery"] = { Kit_Image = "rbxassetid://9155463221", Kit_Title = "Aery" },
        ["agni"] = { Kit_Image = "rbxassetid://17024640133", Kit_Title = "Agni" },
        ["alchemist"] = { Kit_Image = "rbxassetid://9155462512", Kit_Title = "Alchemist" },
        ["spearman"] = { Kit_Image = "rbxassetid://9166207341", Kit_Title = "Ares" },
        ["beekeeper"] = { Kit_Image = "rbxassetid://9312831285", Kit_Title = "Beekeeper Beatrix" },
        ["falconer"] = { Kit_Image = "rbxassetid://17022941869", Kit_Title = "Bekzat" },
        ["bounty_hunter"] = { Kit_Image = "rbxassetid://9166208649", Kit_Title = "Bounty Hunter" },
        ["blood_assassin"] = { Kit_Image = "rbxassetid://12520290159", Kit_Title = "Caitlyn" },
        ["battery"] = { Kit_Image = "rbxassetid://10159166528", Kit_Title = "Cobalt" },
        ["steam_engineer"] = { Kit_Image = "rbxassetid://15380413567", Kit_Title = "Cogsworth" },
        ["vesta"] = { Kit_Image = "rbxassetid://9568930198", Kit_Title = "Conqueror" },
        ["beast"] = { Kit_Image = "rbxassetid://9155465124", Kit_Title = "Crocowolf" },
        ["dino_tamer"] = { Kit_Image = "rbxassetid://9872357009", Kit_Title = "Dino Tamer Dom" },
        ["drill"] = { Kit_Image = "rbxassetid://12955100280", Kit_Title = "Drill" },
        ["elektra"] = { Kit_Image = "rbxassetid://13841413050", Kit_Title = "Elektra" },
        ["fisherman"] = { Kit_Image = "rbxassetid://9166208359", Kit_Title = "Fisherman" },
        ["queen_bee"] = { Kit_Image = "rbxassetid://12671498918", Kit_Title = "Flora" },
        ["card"] = { Kit_Image = "rbxassetid://13841410580", Kit_Title = "Fortuna" },
        ["frosty"] = { Kit_Image = "rbxassetid://9166208762", Kit_Title = "Frosty" },
        ["gingerbread_man"] = { Kit_Image = "rbxassetid://9155464364", Kit_Title = "Gingerbread Man" },
        ["ghost_catcher"] = { Kit_Image = "rbxassetid://9224802656", Kit_Title = "Gompy" },
        ["tinker"] = { Kit_Image = "rbxassetid://17025762404", Kit_Title = "Hephaestus" },
        ["ignis"] = { Kit_Image = "rbxassetid://13835258938", Kit_Title = "Ignis" },
        ["oil_man"] = { Kit_Image = "rbxassetid://9166206259", Kit_Title = "Jack" },
        ["jade"] = { Kit_Image = "rbxassetid://9166306816", Kit_Title = "Jade" },
        ["dragon_slayer"] = { Kit_Image = "rbxassetid://10982192175", Kit_Title = "Kaliyah" },
        ["paladin"] = { Kit_Image = "rbxassetid://11202785737", Kit_Title = "Lani" },
        ["pinata"] = { Kit_Image = "rbxassetid://10011261147", Kit_Title = "Lucía" },
        ["merchant"] = { Kit_Image = "rbxassetid://9872356790", Kit_Title = "Merchant Marco" },
        ["metal_detector"] = { Kit_Image = "rbxassetid://9378298061", Kit_Title = "Metal Detector" },
        ["slime_tamer"] = { Kit_Image = "rbxassetid://15379766168", Kit_Title = "Noelle" },
        ["nyoka"] = { Kit_Image = "rbxassetid://17022941410", Kit_Title = "Nyoka" },
        ["midnight"] = { Kit_Image = "rbxassetid://9155462763", Kit_Title = "Nyx" },
        ["pyro"] = { Kit_Image = "rbxassetid://9155464770", Kit_Title = "Pyro" },
        ["raven"] = { Kit_Image = "rbxassetid://9166206554", Kit_Title = "Raven" },
        ["santa"] = { Kit_Image = "rbxassetid://9166206101", Kit_Title = "Santa" },
        ["sheep_herder"] = { Kit_Image = "rbxassetid://9155465730", Kit_Title = "Sheep Herder" },
        ["smoke"] = { Kit_Image = "rbxassetid://9155462247", Kit_Title = "Smoke" },
        ["spirit_catcher"] = { Kit_Image = "rbxassetid://9166207943", Kit_Title = "Spirit Catcher" },
        ["styx"] = { Kit_Image = "rbxassetid://17014536631", Kit_Title = "Styx" },
        ["block_kicker"] = { Kit_Image = "rbxassetid://15382536098", Kit_Title = "Terra" },
        ["trapper"] = { Kit_Image = "rbxassetid://9166206875", Kit_Title = "Trapper" },
        ["hatter"] = { Kit_Image = "rbxassetid://12509388633", Kit_Title = "Umbra" },
        ["ninja"] = { Kit_Image = "rbxassetid://15517037848", Kit_Title = "Umeko" },
        ["jailor"] = { Kit_Image = "rbxassetid://11664116980", Kit_Title = "Warden" },
        ["warrior"] = { Kit_Image = "rbxassetid://9166207008", Kit_Title = "Warrior" },
        ["mage"] = { Kit_Image = "rbxassetid://10982191792", Kit_Title = "Whim" },
        ["void_dragon"] = { Kit_Image = "rbxassetid://10982192753", Kit_Title = "Xu'rot" },
        ["cat"] = { Kit_Image = "rbxassetid://15350740470", Kit_Title = "Yamini" },
        ["yeti"] = { Kit_Image = "rbxassetid://9166205917", Kit_Title = "Yeti" },
        ["wind_walker"] = { Kit_Image = "rbxassetid://9872355499", Kit_Title = "Zephyr" },
    }
}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local CollectionService = game:GetService("CollectionService")

local queueteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
local httprequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request

local plr = game.Players.LocalPlayer
local Chr = plr.Character
local root = Chr and Chr:FindFirstChild("HumanoidRootPart")
local rpos = root and root.Position
local hum = Chr and Chr:FindFirstChildOfClass("Humanoid")
local Sword, Sword_Table, Sword_Meta = nil, nil, nil

local Is_Clicking = false
local Click_Tick = tick()
local Enabled = true
local Deleted = false
local Break_Hold = true

local Focused = true
local LastInput = tick()
local Animation_Tick = tick()
local Break_Tick = tick()

local Entities = nil
local Closest = nil
local Target = nil

local TP_Check = false
local Connections = {}
local Player_Inventory_Folder:Folder = nil
local Detection_Ray = RaycastParams.new()
local Break_Ray = RaycastParams.new()
local Break_Filter = {}
local Map = workspace:FindFirstChild("Map")

local lastSwingServerTime = 0
local lastSwingServerTimeDelta = 0

if not Map and game.PlaceId ~= 6872265039 then 
    repeat
        Map = workspace:FindFirstChild("Map")
        task.wait()
    until Map
end

Detection_Ray.FilterDescendantsInstances = {Map}
Break_Filter = {Map}


Detection_Ray.FilterType = Enum.RaycastFilterType.Include
Break_Ray.FilterType = Enum.RaycastFilterType.Include

table.insert(Connections, plr.OnTeleport:Connect(function()
	if queueteleport and not TP_Check then
        TP_Check = true
        
        Save_Settings()

        local Script = ""
        if isfile("BedwarsEnhanced.lua") then
            Script = "loadstring(readfile('BedwarsEnhanced.lua'))()"
        else
            Script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/Disqualifi3d/k/refs/heads/main/lol.lua'))()"
        end

		queueteleport(Script)
	end
end))

if isfile and isfile("DQSETTINGS.DQKA") and readfile then
    local New_Settings = HttpService:JSONDecode(readfile("DQSETTINGS.DQKA"))

    if not New_Settings then return end

    Settings = New_Settings

    --for Setting, Value in pairs(New_Settings) do
    --    if Settings[Setting] then
    --        Settings[Setting] = Value
    --
    --        warn(tostring(Setting) .." = ".. tostring(Value))
    --    else
    --        warn("Couldn't find for: " .. tostring(Setting) .. " V: " .. tostring(Value))
    --    end
    --end
end

if game.PlaceId == 6872265039 then

    local Part = Instance.new("Part")

    Part.CFrame = CFrame.new(0,50,0)
    Part.Transparency = 0.75
    Part.CanCollide = false
    Part.Anchored = true
    Part.Size = Vector3.one
    Part.Parent = workspace
     return
end

local function Dump_Remote(tab)
	for i,v in pairs(tab) do
		if v == "Client" then
			return tab[i + 1]
		end
	end
	return ""
end

local KnitGotten, KnitClient
repeat
	KnitGotten, KnitClient = pcall(function()
		return debug.getupvalue(require(plr.PlayerScripts.TS.knit).setup, 9)
	end)
	if KnitGotten then break end
	task.wait()
until KnitGotten
repeat task.wait() until debug.getupvalue(KnitClient.Start, 1)
local Flamework = require(ReplicatedStorage["rbxts_include"]["node_modules"]["@flamework"].core.out).Flamework


for _, Bed in pairs(CollectionService:GetTagged("bed")) do
    if Bed.Name ~= "bed" then continue end
    if Bed.Parent == nil then continue end
    if Bed:GetAttribute("TeamId") == plr:GetAttribute("Team") then continue end

    table.insert(Break_Filter, Bed)
end

Break_Ray.FilterDescendantsInstances = Break_Filter


local Bedwars = setmetatable({
	AnimationType = require(ReplicatedStorage.TS.animation["animation-type"]).AnimationType,
	AnimationUtil = require(ReplicatedStorage["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out["shared"].util["animation-util"]).AnimationUtil,
	AppController = require(ReplicatedStorage["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out.client.controllers["app-controller"]).AppController,
	AbilityController = Flamework.resolveDependency("@easy-games/game-core:client/controllers/ability/ability-controller@AbilityController"),
	AbilityUIController = Flamework.resolveDependency("@easy-games/game-core:client/controllers/ability/ability-ui-controller@AbilityUIController"),
	AttackRemote = Dump_Remote(debug.getconstants(KnitClient.Controllers.SwordController.sendServerRequest)),
	BalanceFile = require(ReplicatedStorage.TS.balance["balance-file"]).BalanceFile,
	--BatteryRemote = Dump_Remote(debug.getconstants(debug.getproto(debug.getproto(KnitClient.Controllers.BatteryController.KnitStart, 1), 1))),
	BlockBreaker = KnitClient.Controllers.BlockBreakController.blockBreaker,
	BlockController = require(ReplicatedStorage["rbxts_include"]["node_modules"]["@easy-games"]["block-engine"].out).BlockEngine,
	BlockPlacer = require(ReplicatedStorage["rbxts_include"]["node_modules"]["@easy-games"]["block-engine"].out.client.placement["block-placer"]).BlockPlacer,
	BlockEngine = require(plr.PlayerScripts.TS.lib["block-engine"]["client-block-engine"]).ClientBlockEngine,
	BlockEngineClientEvents = require(ReplicatedStorage["rbxts_include"]["node_modules"]["@easy-games"]["block-engine"].out.client["block-engine-client-events"]).BlockEngineClientEvents,
	BowConstantsTable = debug.getupvalue(KnitClient.Controllers.ProjectileController.enableBeam, 6),
	CannonAimRemote = Dump_Remote(debug.getconstants(debug.getproto(KnitClient.Controllers.CannonController.startAiming, 5))),
	CannonLaunchRemote = Dump_Remote(debug.getconstants(KnitClient.Controllers.CannonHandController.launchSelf)),
	ClickHold = require(ReplicatedStorage["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out.client.ui.lib.util["click-hold"]).ClickHold,
	--Client = Client,
	ClientConstructor = require(ReplicatedStorage["rbxts_include"]["node_modules"]["@rbxts"].net.out.client),
	ClientDamageBlock = require(ReplicatedStorage["rbxts_include"]["node_modules"]["@easy-games"]["block-engine"].out.shared.remotes).BlockEngineRemotes.Client,
	ClientStoreHandler = require(plr.PlayerScripts.TS.ui.store).ClientStore,
	CombatConstant = require(ReplicatedStorage.TS.combat["combat-constant"]).CombatConstant,
	ConstantManager = require(ReplicatedStorage["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out["shared"].constant["constant-manager"]).ConstantManager,
	ConsumeSoulRemote = Dump_Remote(debug.getconstants(KnitClient.Controllers.GrimReaperController.consumeSoul)),
	CooldownController = Flamework.resolveDependency("@easy-games/game-core:client/controllers/cooldown/cooldown-controller@CooldownController"),
	DamageIndicator = KnitClient.Controllers.DamageIndicatorController.spawnDamageIndicator,
	--DefaultKillEffect = require(plr.PlayerScripts.TS.controllers.game.locker["kill-effect"].effects["default-kill-effect"]),
	DropItem = KnitClient.Controllers.ItemDropController.dropItemInHand,
	DropItemRemote = Dump_Remote(debug.getconstants(KnitClient.Controllers.ItemDropController.dropItemInHand)),
	--DragonRemote = Dump_Remote(debug.getconstants(debug.getproto(debug.getproto(KnitClient.Controllers.DragonSlayerController.KnitStart, 2), 1))),
	EatRemote = Dump_Remote(debug.getconstants(debug.getproto(KnitClient.Controllers.ConsumeController.onEnable, 1))),
	EquipItemRemote = Dump_Remote(debug.getconstants(debug.getproto(require(ReplicatedStorage.TS.entity.entities["inventory-entity"]).InventoryEntity.equipItem, 3))),
	EmoteMeta = require(ReplicatedStorage.TS.locker.emote["emote-meta"]).EmoteMeta,
	--ForgeConstants = debug.getupvalue(KnitClient.Controllers.ForgeController.getPurchaseableForgeUpgrades, 2),
	--ForgeUtil = debug.getupvalue(KnitClient.Controllers.ForgeController.getPurchaseableForgeUpgrades, 5),
	GameAnimationUtil = require(ReplicatedStorage.TS.animation["animation-util"]).GameAnimationUtil,
	EntityUtil = require(ReplicatedStorage.TS.entity["entity-util"]).EntityUtil,
	GuitarHealRemote = Dump_Remote(debug.getconstants(KnitClient.Controllers.GuitarController.performHeal)),
	ItemTable = debug.getupvalue(require(ReplicatedStorage.TS.item["item-meta"]).getItemMeta, 1),
	KillEffectMeta = require(ReplicatedStorage.TS.locker["kill-effect"]["kill-effect-meta"]).KillEffectMeta,
	KnockbackUtil = require(ReplicatedStorage.TS.damage["knockback-util"]).KnockbackUtil,
	--MatchEndScreenController = Flamework.resolveDependency("client/controllers/game/match/match-end-screen-controller@MatchEndScreenController"),
	--MinerRemote = Dump_Remote(debug.getconstants(debug.getproto(KnitClient.Controllers.MinerController.onKitEnabled, 1))),
	MageRemote = Dump_Remote(debug.getconstants(debug.getproto(KnitClient.Controllers.MageController.registerTomeInteraction, 1))),
	MageKitUtil = require(ReplicatedStorage.TS.games.bedwars.kit.kits.mage["mage-kit-util"]).MageKitUtil,
	--PickupMetalRemote = Dump_Remote(debug.getconstants(debug.getproto(debug.getproto(KnitClient.Controllers.MetalDetectorController.KnitStart, 1), 2))),
	PickupRemote = Dump_Remote(debug.getconstants(KnitClient.Controllers.ItemDropController.checkForPickup)),
	PinataRemote = Dump_Remote(debug.getconstants(debug.getproto(debug.getproto(KnitClient.Controllers.PiggyBankController.KnitStart, 2), 5))),
	ProjectileMeta = require(ReplicatedStorage.TS.projectile["projectile-meta"]).ProjectileMeta,
	ProjectileRemote = Dump_Remote(debug.getconstants(debug.getupvalue(KnitClient.Controllers.ProjectileController.launchProjectileWithValues, 2))),
	QueryUtil = require(ReplicatedStorage["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out).GameQueryUtil,
	QueueCard = require(plr.PlayerScripts.TS.controllers.global.queue.ui["queue-card"]).QueueCard,
	QueueMeta = require(ReplicatedStorage.TS.game["queue-meta"]).QueueMeta,
	ReportRemote = Dump_Remote(debug.getconstants(require(plr.PlayerScripts.TS.controllers.global.report["report-controller"]).default.reportPlayer)),
	ResetRemote = Dump_Remote(debug.getconstants(debug.getproto(KnitClient.Controllers.ResetController.createBindable, 1))),
	--DinoRemote = Dump_Remote(debug.getconstants(debug.getproto(KnitClient.Controllers.DinoTamerController.KnitStart, 3))),
	Roact = require(ReplicatedStorage["rbxts_include"]["node_modules"]["@rbxts"]["roact"].src),
	RuntimeLib = require(ReplicatedStorage["rbxts_include"].RuntimeLib),
	Shop = require(ReplicatedStorage.TS.games.bedwars.shop["bedwars-shop"]).BedwarsShop,
	ShopItems = debug.getupvalue(debug.getupvalue(require(ReplicatedStorage.TS.games.bedwars.shop["bedwars-shop"]).BedwarsShop.getShopItem, 1), 3),
	SoundList = require(ReplicatedStorage.TS.sound["game-sound"]).GameSound,
	SoundManager = require(ReplicatedStorage["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out).SoundManager,
	SpawnRavenRemote = Dump_Remote(debug.getconstants(KnitClient.Controllers.RavenController.spawnRaven)),
	--TreeRemote = Dump_Remote(debug.getconstants(debug.getproto(debug.getproto(KnitClient.Controllers.BigmanController.KnitStart, 1), 2))),
	--TrinityRemote = Dump_Remote(debug.getconstants(debug.getproto(KnitClient.Controllers.AngelController.onKitEnabled, 1))),
	UILayers = require(ReplicatedStorage['rbxts_include']['node_modules']['@easy-games']['game-core'].out).UILayers,
	WeldTable = require(ReplicatedStorage.TS.util["weld-util"]).WeldUtil
}, {
	__index = function(self, ind)
		rawset(self, ind, KnitClient.Controllers[ind])
		return rawget(self, ind)
	end
})


local function Store_Items()
    if not Player_Inventory_Folder or not Player_Inventory_Folder.Parent then return end

    Store.Inventory = {}
    for _, Item in pairs(Player_Inventory_Folder:GetChildren()) do
        --print("Stored", tostring(Item))
        table.insert(Store.Inventory, Item)
    end
end

local function Obtain_Inventory(S_Items)
    for _, Inventory_Search in pairs(ReplicatedStorage.Inventories:GetChildren()) do
        if Inventory_Search.Name ~= plr.Name or Player_Inventory_Folder then continue end
        if #Inventory_Search:GetChildren() > 1 then Player_Inventory_Folder = Inventory_Search end
    end

    if S_Items and Player_Inventory_Folder and Player_Inventory_Folder.Parent then
        table.insert(Connections, Player_Inventory_Folder.ChildAdded:Connect(Store_Items))
        table.insert(Connections, Player_Inventory_Folder.ChildRemoved:Connect(Store_Items))
        Store_Items() 
    end
end

local function Get_Kit(Player: Player)
    if not Player then return end

    local P_Kit = Player:GetAttribute("PlayingAsKits")
    if P_Kit and Store.Kits[P_Kit] then
        
        return Store.Kits[P_Kit].Kit_Title, Store.Kits[P_Kit].Kit_Image
    end
end

local function Retrieve_All_Line_Of_Sight_Entities()
    if not rpos or not root or not Chr or not Chr:GetAttribute("Team") then return {} end

    local Received = {}
    local Players = {}
    local Entities = {}
    for _, Entity:Model in pairs(workspace:GetChildren()) do
        if not Entity:IsA("Model") then continue end
        --if not Entity:FindFirstChild("Humanoid") then continue end
        if not Entity.PrimaryPart then continue end
        if not Entity:GetAttribute("Health") then continue end
        if Entity:GetAttribute("Health") <= 0 then continue end
        if Entity:GetAttribute("Team") and Entity:GetAttribute("Team") == Chr:GetAttribute("Team") then continue end
        if Entity == Chr then continue end

        local EntityPrimary = Entity.PrimaryPart
        local Entity_Pos = EntityPrimary.Position

        if Settings.Mode == "Slight" then
            local HB = Entity:FindFirstChild("NEWHITBOXTHING")
            if not HB then
                HB = Instance.new("Part")
                HB.Transparency = 1
                HB.Anchored = true
                HB.Parent = Entity
                HB.Size = Vector3.new(10, 10, 10)
                HB.CanCollide = false
                HB.Name = "NEWHITBOXTHING"
            end

            HB.CFrame = (Entity == Target and root.CFrame * CFrame.new(0, 0, 1))
                 or CFrame.new(0, 10000, 0)
        end

        local Delta = (Entity_Pos - rpos)

        if Delta.Magnitude > Settings.Range then continue end

        local Result = workspace:Raycast(
            rpos,
            CFrame.new(rpos, Entity_Pos).LookVector.Unit * Delta.Magnitude,
            Detection_Ray
        )

        if Result and Result.Instance then continue end

        if game.Players:GetPlayerFromCharacter(Entity) or Entity.Name == "Titan" then
            table.insert(Players, Entity)
        else
            table.insert(Entities, Entity)
        end

        table.insert(Received, Entity)
    end

    if Settings.Filter then
        if #Players == 0 then
            return Entities
        else
            return Players
        end
    else
        return Received
    end
    
    return {}
end

local function Get_Closest_Entity(Folder)
    if not Folder then return end
    if #Folder == 0 then return end
    
    local Closest_Distance = math.huge
    local Closest = nil
    for _, Entity in pairs(Folder) do
        if not Entity:IsA("Model") then continue end
        --if not Entity:FindFirstChild("Humanoid") then continue end
        if not Entity.PrimaryPart then continue end
        if Entity == Chr then continue end

        local EntityPrimary = Entity.PrimaryPart
        local Entity_Pos = EntityPrimary.Position
        local Distance = (Entity_Pos - rpos).Magnitude

        if Distance < Closest_Distance then
            Closest = Entity
            Closest_Distance = Distance
        end
    end

    return Closest
end

local function Get_Sword_Meta(Sword)
    return Bedwars.ItemTable[Sword.Name]
end

local function Verify_If_Player_Is_Holding_A_Sword()
    if not Chr then return end
    local Hand_Inv_Item = Chr:FindFirstChild("HandInvItem")
    if not Hand_Inv_Item then return end
    if not Player_Inventory_Folder then return end

    for _, Sword in pairs(Store.Swords) do
        if Hand_Inv_Item.Value and Hand_Inv_Item.Value.Name == Sword.Name then
            return Hand_Inv_Item.Value, Sword, Get_Sword_Meta(Sword)
        end
    end

    return
end

local function Verify_If_Player_Is_Holding_A_Tool()
    if not Chr then return end
    local Hand_Inv_Item = Chr:FindFirstChild("HandInvItem")
    if not Hand_Inv_Item then return end
    if not Player_Inventory_Folder then return end

    for _, Tool in pairs(Store.Tools) do
        if Hand_Inv_Item.Value and Hand_Inv_Item.Value.Name == Tool.Name then
            return true, Hand_Inv_Item.Value
        end
    end

    return
end

local function Open(Main: UIBase)
    TS:Create(
        Main,
        TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
        {
            Position = UDim2.new(0.95, 0, Main.Position.Y.Scale, 0)
        }
    ):Play()
end

local function Close(Main: UIBase)
    TS:Create(
        Main,
        TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
        {
            Position = UDim2.new(1.1, 0, Main.Position.Y.Scale, 0)
        }
    ):Play()
end

local function Get_Box()
    local Found = false

    for _, Part: BasePart in pairs(workspace:GetChildren()) do
        if not Part:IsA("BasePart") then continue end
        local SelectionBox = Part:FindFirstChildOfClass("SelectionBox")
        if not SelectionBox then continue end
        if SelectionBox.LineThickness >= 0.05 or SelectionBox.Transparency > 0 or SelectionBox.SurfaceTransparency < 1 then continue end
        Found = true
    end
    
    return Found
end

local function Anti_Streamer_This(This:Player)
    if not This or not This:IsA("Player") then return end
    if This == plr then return end
    if This:GetAttribute("Disguised") ~= nil then This:SetAttribute("Disguised", not Settings.Anti_Streamer) end


    if not This.Character then return end
    local Head:Instance = This.Character:FindFirstChild("Head")
    local Name_Tag:BillboardGui = Head and Head:FindFirstChild("Nametag")
    local DisplayNameContainer:Frame = Name_Tag and Name_Tag:FindFirstChild("DisplayNameContainer")
    local Display_Name:TextLabel = DisplayNameContainer and DisplayNameContainer:FindFirstChild("DisplayName")

    if Display_Name then
        Display_Name.Text = (Settings.Anti_Streamer and (This.DisplayName or This.Name)) or (This:GetAttribute("DisguiseDisplayName") or (This.DisplayName or This.Name))
    end

    if plr.PlayerGui:FindFirstChild("MatchDraftApp") then
        
        for _, v in pairs(plr.PlayerGui.MatchDraftApp:GetDescendants()) do
            if v:IsA("TextLabel") and (v.Text == This.DisplayName or string.find(v.Text, This.DisplayName)) then

                local Player_Kit_Title, Player_Kit_Image = Get_Kit(This)

                local Player_Card = v.Parent.Parent
                local Text_Container = v.Parent
                local KoA = Text_Container:FindFirstChild("KitOrActionName")

                if KoA then KoA.Text = Player_Kit_Title or "unknown" end
                v.Text = "[" .. This:GetAttribute("PlayerLevel") .. "] " .. This.DisplayName

                local Image = Player_Card:FindFirstChild("KitImage")
                if not Image then
                    Image = Instance.new("ImageLabel")

                    Image.AnchorPoint = Vector2.new(1, 0.5)
                    Image.Position = UDim2.new(1.05, 0, 0.5, 0)
                    Image.ImageTransparency = 0.4
                    Image.Size = UDim2.new(1.5, 0, 1.5, 0)
                    Image.BackgroundTransparency = 1
                    Image.SizeConstraint = Enum.SizeConstraint.RelativeYY
                    Image.Name = "KitImage"
                    Image.Parent = Player_Card
                end

                Image.Image = Player_Kit_Image or ""
            end
        end
    end
end

local function Clear_To_KA()
    if plr.PlayerGui:FindFirstChild("ItemShop") then return false end
    if plr.PlayerGui:FindFirstChild("ChestApp") then return false end
    if plr.PlayerGui:FindFirstChild("TeamUpgradeApp") then return false end
    if plr.PlayerGui:FindFirstChild("InventoryApp") then return false end
    if plr.PlayerGui:FindFirstChild("EnchantTable") then return false end
    if plr.PlayerGui:FindFirstChild("DasherCharge") then return false end
    if UIS:GetFocusedTextBox() then return false end
    if not Focused then return false end
    if tick() - LastInput >= 2.5 then return false end
    if not hum then return false end
    if workspace.CurrentCamera.CameraSubject ~= hum then return false end
    

    return true
end

local function Clear_To_Break()
    if not Verify_If_Player_Is_Holding_A_Tool() then return false end
   
    if Get_Box() then return false end
    if plr:GetAttribute("DenyBlockBreak") then return false end

    return true
end


local function Vec_This(Vec)
    return vector.create(Vec.X, Vec.Y, Vec.Z)
end

local function Get_Block_Position(Pos: Vector3)
    if not Pos then return end
    if typeof(Pos) == "CFrame" then
        Pos = Pos.Position
    end

    local X = Pos.X / 3
    local Y = Pos.Y / 3
    local Z = Pos.Z / 3

    local SemiFinal = Vector3.new(X, Y, Z)
    --local Finalised = Vec_This(SemiFinal)

    return SemiFinal
end

local function Check_Which_Block_Is_Closer_For_Bed(Block, Mouse_Position)
    
    local Upper = (Block.Position - Mouse_Position).Magnitude
    local Lower = ((Block.CFrame * CFrame.new(0, 0, 3)).Position - Mouse_Position).Magnitude

    if Upper < Lower then
        return Block.Position
    else 
        return (Block.CFrame * CFrame.new(0, 0, 3)).Position
    end
end


local function Break_This_Block(Block_Position, Block, Normal, anim)
	if Block_Position and Block then
		if Bedwars.BlockEngineClientEvents.DamageBlock:fire(Block.Name, Block_Position, Block):isCancelled() then
			return
		end

		if Block and Block.Parent ~= nil then
			if ((root.Position) - (Block_Position * 3)).magnitude > 30 then return end
            
            local HealthbarBlockTable = {
                blockHealth = -1,
                breakingBlockPosition = Vector3.zero
            }
            local BlockHealthBarPos = {blockPosition = Block_Position}
            local blockdmg = 0

			task.spawn(function()

				Bedwars.ClientDamageBlock:Get("DamageBlock"):CallServerAsync({
					blockRef = {blockPosition = Block_Position},
					hitPosition = Block_Position * 3,
					hitNormal = Normal
				}):andThen(function(result)
					if result ~= "failed" then
                        if HealthbarBlockTable.blockHealth == -1 or Block_Position ~= HealthbarBlockTable.breakingBlockPosition then
							local blockdata = Bedwars.BlockController:getStore():getBlockData(Block_Position)
							local blockhealth = blockdata and (blockdata:GetAttribute("Health") or blockdata:GetAttribute(plr.Name .. "_Health")) or Block:GetAttribute("Health")
							HealthbarBlockTable.blockHealth = blockhealth
							HealthbarBlockTable.breakingBlockPosition = Block_Position
						end

						HealthbarBlockTable.blockHealth = result == "destroyed" and 0 or HealthbarBlockTable.blockHealth
						blockdmg = Bedwars.BlockController:calculateBlockDamage(plr, BlockHealthBarPos)
						HealthbarBlockTable.blockHealth = math.max(HealthbarBlockTable.blockHealth - blockdmg, 0)
						if true then
							--Bedwars.BlockBreaker:updateHealthbar(BlockHealthBarPos, HealthbarBlockTable.blockHealth, Block:GetAttribute("MaxHealth"), blockdmg, Block)
							
                            if HealthbarBlockTable.blockHealth <= 0 then
								Bedwars.BlockBreaker.breakEffect:playBreak(Block.Name, Block_Position, plr)
								Bedwars.BlockBreaker.healthbarMaid:DoCleaning()
								HealthbarBlockTable.breakingBlockPosition = Vector3.zero
							else
								Bedwars.BlockBreaker.breakEffect:playHit(Block.Name, Block_Position, plr)
							end
						end

                        local animation
						if anim then
							animation = Bedwars.AnimationUtil:playAnimation(plr, Bedwars.BlockController:getAnimationController():getAssetId(1))
							Bedwars.ViewmodelController:playAnimation(15)
						end

                        repeat
                            task.wait()
                        until not Break_Hold

						if animation ~= nil then
							animation:Stop()
							animation:Destroy()
						end
					end
				end)
			end)
		end
	end
end

--// Setup


local lobotomy_KA = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local Delete = Instance.new("TextButton")
local UIGradient = Instance.new("UIGradient")
local Toggle = Instance.new("TextButton")
local UIGradient_2 = Instance.new("UIGradient")
local KA_Mode = Instance.new("TextButton")
local UIGradient_3 = Instance.new("UIGradient")
local Attack_Range = Instance.new("TextLabel")
local UIGradient_4 = Instance.new("UIGradient")
local RangeTextbox = Instance.new("TextBox")
local Title = Instance.new("TextLabel")
local UIGradient_5 = Instance.new("UIGradient")
local Entity_Filter = Instance.new("TextButton")
local UIGradient_6 = Instance.new("UIGradient")
local Anti_Streamer = Instance.new("TextButton")
local UIGradient_7 = Instance.new("UIGradient")
local Degrees_Ui = Instance.new("TextLabel")
local UIGradient_8 = Instance.new("UIGradient")
local DegreesTextbox = Instance.new("TextBox")
local Main_Toggle = Instance.new("Frame")

--Properties:

lobotomy_KA.Name = "lobotomy_KA"
lobotomy_KA.Parent = game.CoreGui
lobotomy_KA.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Main.Name = "Main"
Main.Parent = lobotomy_KA
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Main.BackgroundTransparency = 1.000
Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.949999988, 0, 0.467000008, 0)
Main.Size = UDim2.new(0.0973017141, 0, 0.231920198, 0)

Delete.Name = "Delete"
Delete.Parent = Main
Delete.AnchorPoint = Vector2.new(0.5, 0.5)
Delete.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Delete.BorderColor3 = Color3.fromRGB(0, 0, 0)
Delete.BorderSizePixel = 0
Delete.Position = UDim2.new(0.403360784, 0, 1.05086029, 0)
Delete.Size = UDim2.new(0.60504204, 0, 0.0915806293, 0)
Delete.Font = Enum.Font.SourceSans
Delete.Text = "Delete"
Delete.TextColor3 = Color3.fromRGB(0, 0, 0)
Delete.TextSize = 14.000
Delete.TextWrapped = true

UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(50, 50, 50)), ColorSequenceKeypoint.new(0.50, Color3.fromRGB(150, 150, 150)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(50, 50, 50))}
UIGradient.Rotation = 45
UIGradient.Parent = Delete

Toggle.Name = "Toggle"
Toggle.Parent = Main
Toggle.AnchorPoint = Vector2.new(0.5, 0.5)
Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
Toggle.BorderSizePixel = 0
Toggle.Position = UDim2.new(0.407563031, 0, 0.553548515, 0)
Toggle.Size = UDim2.new(1, 0, 0.268999994, 0)
Toggle.Font = Enum.Font.SourceSans
Toggle.Text = "Toggle: [nil]"
Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
Toggle.TextSize = 14.000

UIGradient_2.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(50, 50, 50)), ColorSequenceKeypoint.new(0.50, Color3.fromRGB(150, 150, 150)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(50, 50, 50))}
UIGradient_2.Rotation = 45
UIGradient_2.Parent = Toggle

KA_Mode.Name = "KA_Mode"
KA_Mode.Parent = Main
KA_Mode.AnchorPoint = Vector2.new(0.5, 0.5)
KA_Mode.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
KA_Mode.BorderColor3 = Color3.fromRGB(0, 0, 0)
KA_Mode.BorderSizePixel = 0
KA_Mode.Position = UDim2.new(0.407563031, 0, 0.325053871, 0)
KA_Mode.Size = UDim2.new(1, 0, 0.102333337, 0)
KA_Mode.Font = Enum.Font.SourceSans
KA_Mode.Text = "KA_Mode: [nil]"
KA_Mode.TextColor3 = Color3.fromRGB(0, 0, 0)
KA_Mode.TextScaled = true
KA_Mode.TextSize = 14.000
KA_Mode.TextWrapped = true

UIGradient_3.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(50, 50, 50)), ColorSequenceKeypoint.new(0.50, Color3.fromRGB(150, 150, 150)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(50, 50, 50))}
UIGradient_3.Rotation = 45
UIGradient_3.Parent = KA_Mode

Attack_Range.Name = "Attack_Range"
Attack_Range.Parent = Main
Attack_Range.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Attack_Range.BorderColor3 = Color3.fromRGB(0, 0, 0)
Attack_Range.BorderSizePixel = 0
Attack_Range.Position = UDim2.new(-0.0920000002, 0, 0.0199999996, 0)
Attack_Range.Size = UDim2.new(1.00043702, 0, 0.0860000029, 0)
Attack_Range.Font = Enum.Font.SourceSans
Attack_Range.Text = "Attack Range:"
Attack_Range.TextColor3 = Color3.fromRGB(0, 0, 0)
Attack_Range.TextSize = 14.000
Attack_Range.TextXAlignment = Enum.TextXAlignment.Left

UIGradient_4.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(50, 50, 50)), ColorSequenceKeypoint.new(0.50, Color3.fromRGB(150, 150, 150)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(50, 50, 50))}
UIGradient_4.Rotation = 45
UIGradient_4.Parent = Attack_Range

RangeTextbox.Name = "HitTextbox"
RangeTextbox.Parent = Attack_Range
RangeTextbox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
RangeTextbox.BackgroundTransparency = 1.000
RangeTextbox.BorderColor3 = Color3.fromRGB(0, 0, 0)
RangeTextbox.BorderSizePixel = 0
RangeTextbox.Position = UDim2.new(0.191315711, 0, 0, 0)
RangeTextbox.Size = UDim2.new(0.80868423, 0, 1, 0)
RangeTextbox.Font = Enum.Font.SourceSans
RangeTextbox.PlaceholderColor3 = Color3.fromRGB(0, 0, 0)
RangeTextbox.Text = "0.3"
RangeTextbox.TextColor3 = Color3.fromRGB(0, 0, 0)
RangeTextbox.TextSize = 14.000
RangeTextbox.TextWrapped = true

Title.Name = "Title"
Title.Parent = Main
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1.000
Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
Title.BorderSizePixel = 0
Title.Position = UDim2.new(-0.108182222, 0, -0.354838699, 0)
Title.Size = UDim2.new(1.03189194, 0, 0.268817216, 0)
Title.Font = Enum.Font.SourceSans
Title.Text = "DQ CLOSET"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.TextSize = 14
Title.TextWrapped = true

UIGradient_5.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(100, 100, 100)), ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(100, 100, 100))}
UIGradient_5.Rotation = 90
UIGradient_5.Parent = Title

Entity_Filter.Name = "Entity_Filter"
Entity_Filter.Parent = Main
Entity_Filter.AnchorPoint = Vector2.new(0.5, 0.5)
Entity_Filter.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Entity_Filter.BorderColor3 = Color3.fromRGB(0, 0, 0)
Entity_Filter.BorderSizePixel = 0
Entity_Filter.Position = UDim2.new(0.415883899, 0, 0.77666676, 0)
Entity_Filter.Size = UDim2.new(1, 0, 0.102333337, 0)
Entity_Filter.Font = Enum.Font.SourceSans
Entity_Filter.Text = "Entity Filter: [nil]"
Entity_Filter.TextColor3 = Color3.fromRGB(0, 0, 0)
Entity_Filter.TextSize = 14.000
Entity_Filter.TextWrapped = true

UIGradient_6.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(50, 50, 50)), ColorSequenceKeypoint.new(0.50, Color3.fromRGB(150, 150, 150)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(50, 50, 50))}
UIGradient_6.Rotation = 45
UIGradient_6.Parent = Entity_Filter

Anti_Streamer.Name = "Anti_Streamer"
Anti_Streamer.Parent = Main
Anti_Streamer.AnchorPoint = Vector2.new(0.5, 0.5)
Anti_Streamer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Anti_Streamer.BorderColor3 = Color3.fromRGB(0, 0, 0)
Anti_Streamer.BorderSizePixel = 0
Anti_Streamer.Position = UDim2.new(0.415883899, 0, 0.916451752, 0)
Anti_Streamer.Size = UDim2.new(1, 0, 0.102333337, 0)
Anti_Streamer.Font = Enum.Font.SourceSans
Anti_Streamer.Text = "Anti Streamer: [nil]"
Anti_Streamer.TextColor3 = Color3.fromRGB(0, 0, 0)
Anti_Streamer.TextSize = 14.000
Anti_Streamer.TextWrapped = true

UIGradient_7.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(50, 50, 50)), ColorSequenceKeypoint.new(0.50, Color3.fromRGB(150, 150, 150)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(50, 50, 50))}
UIGradient_7.Rotation = 45
UIGradient_7.Parent = Anti_Streamer

Degrees_Ui.Name = "Degrees_Ui"
Degrees_Ui.Parent = Main
Degrees_Ui.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Degrees_Ui.BorderColor3 = Color3.fromRGB(0, 0, 0)
Degrees_Ui.BorderSizePixel = 0
Degrees_Ui.Position = UDim2.new(-0.0924369767, 0, 0.140000045, 0)
Degrees_Ui.Size = UDim2.new(1.00043702, 0, 0.0860000029, 0)
Degrees_Ui.Font = Enum.Font.SourceSans
Degrees_Ui.Text = "Degrees:"
Degrees_Ui.TextColor3 = Color3.fromRGB(0, 0, 0)
Degrees_Ui.TextSize = 14.000
Degrees_Ui.TextXAlignment = Enum.TextXAlignment.Left

UIGradient_8.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(50, 50, 50)), ColorSequenceKeypoint.new(0.50, Color3.fromRGB(150, 150, 150)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(50, 50, 50))}
UIGradient_8.Rotation = 45
UIGradient_8.Parent = Degrees_Ui

DegreesTextbox.Name = "DegreesTextbox"
DegreesTextbox.Parent = Degrees_Ui
DegreesTextbox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
DegreesTextbox.BackgroundTransparency = 1.000
DegreesTextbox.BorderColor3 = Color3.fromRGB(0, 0, 0)
DegreesTextbox.BorderSizePixel = 0
DegreesTextbox.Position = UDim2.new(0.191315711, 0, 0, 0)
DegreesTextbox.Size = UDim2.new(0.80868423, 0, 1, 0)
DegreesTextbox.Font = Enum.Font.SourceSans
DegreesTextbox.PlaceholderColor3 = Color3.fromRGB(0, 0, 0)
DegreesTextbox.Text = "80"
DegreesTextbox.TextColor3 = Color3.fromRGB(0, 0, 0)
DegreesTextbox.TextSize = 14.000
DegreesTextbox.TextWrapped = true

Main_Toggle.Name = "Main_Toggle"
Main_Toggle.Parent = lobotomy_KA
Main_Toggle.Active = true
Main_Toggle.AnchorPoint = Vector2.new(0.5, 0.5)
Main_Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Main_Toggle.BackgroundTransparency = 1.000
Main_Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
Main_Toggle.BorderSizePixel = 0
Main_Toggle.Position = UDim2.new(0.946177542, 0, 0.47630924, 0)
Main_Toggle.Size = UDim2.new(0.107645161, 0, 0.270573556, 0)
Main_Toggle.ZIndex = 2

local Stroke_1 = Instance.new("UIStroke")
Stroke_1.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
Stroke_1.Thickness = 1
Stroke_1.Parent = Delete

local Stroke_2, Stroke_3, Stroke_4, Stroke_5, Stroke_6, Stroke_7 =
    Stroke_1:Clone(),
    Stroke_1:Clone(),
    Stroke_1:Clone(),
    Stroke_1:Clone(),
    Stroke_1:Clone(),
    Stroke_1:Clone()

Stroke_2.Parent, Stroke_3.Parent, Stroke_4.Parent, Stroke_5.Parent, Stroke_6.Parent, Stroke_7.Parent =
    KA_Mode,
    Toggle,
    Degrees_Ui,
    Entity_Filter,
    Anti_Streamer,
    Attack_Range

Main.Position = UDim2.new(1.1, 0, 0.467000008, 0)
lobotomy_KA.Parent = game.CoreGui

DegreesTextbox.Text = tostring(Settings.Degrees)
RangeTextbox.Text = tostring(Settings.Range)
Anti_Streamer.Text = "Anti Streamer: [" .. tostring(Settings.Anti_Streamer) .."]"
Entity_Filter.Text = "Entity Filter: [" .. tostring(Settings.Filter) .. "]"
KA_Mode.Text = "KA Mode: [" .. tostring(Settings.Mode) .. "]"
Toggle.Text = "Toggle: [" .. tostring(Enabled) .. "]"
lobotomy_KA.Enabled = Settings.Visible

Obtain_Inventory(true)
task.wait(0.25)

Close(Main)

table.insert(Connections, Main_Toggle.MouseEnter:Connect(function()
    Open(Main)
end))

table.insert(Connections, Main_Toggle.MouseLeave:Connect(function()
    Close(Main)
end))

table.insert(Connections, Toggle.MouseButton1Click:Connect(function()
    Enabled = not Enabled
    Toggle.Text = "Toggle: [" .. tostring(Enabled) .. "]"
end))

table.insert(Connections, KA_Mode.MouseButton1Click:Connect(function()
    Settings.Mode = (Settings.Mode == "Slight" and "Full") or "Slight"
    KA_Mode.Text = "KA Mode: [" .. tostring(Settings.Mode) .. "]"
end))

table.insert(Connections, Anti_Streamer.MouseButton1Click:Connect(function()
    Settings.Anti_Streamer = not Settings.Anti_Streamer
    Anti_Streamer.Text = "Anti Streamer: [" .. tostring(Settings.Anti_Streamer) .."]"
end))

table.insert(Connections, Entity_Filter.MouseButton1Click:Connect(function()
    Settings.Filter = not Settings.Filter
    Entity_Filter.Text = "Entity Filter: [" .. tostring(Settings.Filter) .. "]"
end))

table.insert(Connections, DegreesTextbox:GetPropertyChangedSignal("Text"):Connect(function()
    if DegreesTextbox.Focused then
        if not tonumber(DegreesTextbox.Text) then
            DegreesTextbox.Text = DegreesTextbox.Text:gsub('%D+', '');
            return
        end

        if tonumber(DegreesTextbox.Text) >= 360 then DegreesTextbox.Text = "360" end
        if tonumber(DegreesTextbox.Text) < 0 then DegreesTextbox.Text = "0" end

        Settings.Degrees = tonumber(DegreesTextbox.Text)
    end
end))

table.insert(Connections, RangeTextbox:GetPropertyChangedSignal("Text"):Connect(function()
    if RangeTextbox.Focused then
        if not tonumber(RangeTextbox.Text) then
            RangeTextbox.Text = RangeTextbox.Text:gsub('%D+', '');
            return
        end

        Settings.Range = tonumber(RangeTextbox.Text)
    end
end))

table.insert(Connections, Delete.MouseButton1Click:Connect(function()
    Deleted = true
end))

table.insert(Connections, plr.CharacterAdded:Connect(function()
    Chr = plr.Character
    root = Chr:WaitForChild("HumanoidRootPart")
    Obtain_Inventory(true)
end))

table.insert(Connections, UIS.InputBegan:Connect(function(Input, Processed)
    LastInput = tick()

    if Input.KeyCode == Enum.KeyCode.Equals and not Processed then
        lobotomy_KA.Enabled = not lobotomy_KA.Enabled
        Settings.Visible = lobotomy_KA.Enabled
    end

    if Input.UserInputType == Enum.UserInputType.MouseButton1 and Verify_If_Player_Is_Holding_A_Tool() then
        Break_Hold = true

        while Break_Hold and task.wait() do
            if Break_Tick + Store.Block_Hit < tick() and Clear_To_Break() then
                Break_Tick = tick()

                local Result: RaycastResult = workspace:Raycast(
                    workspace.CurrentCamera.CFrame.Position,
                    CFrame.new(workspace.CurrentCamera.CFrame.Position, plr:GetMouse().Hit.Position).LookVector.Unit * 100,
                    Break_Ray
                )

                if Result and Result.Instance and root and (root.Position - Result.Instance.Position).Magnitude < 21 then

                    local Block = 
                    (Result.Instance:GetAttribute("Block") and Result.Instance)
                    or (Result.Instance.Parent and Result.Instance.Parent:GetAttribute("Block") and Result.Instance.Parent)

                    local Block_Position = Get_Block_Position(Block.Position)

                    if Block.Name == "bed" or Block.Name == "Bed" then
                        Block_Position = Get_Block_Position(Check_Which_Block_Is_Closer_For_Bed(Block, Result.Position))
                    end

                    Break_This_Block(Block_Position, Block, Result.Normal, true)
                end
            end
        end
    end

    if not Sword or not Sword_Table or not Sword_Meta then return end

    if Input.UserInputType == Enum.UserInputType.MouseButton1 and not Processed and Settings.Mode == "Slight" then
        
        if Target and math.random(1, 100) <= 66 and rpos then
            local ePrim = Target.PrimaryPart
            local ePos: Vector3 = ePrim.Position
            local selfpos = rpos + ((rpos - root.Position).Magnitude > 14.4 and (CFrame.lookAt(rpos, ePos).LookVector * ((rpos - ePos).magnitude - 14)) or Vector3.zero)

            Bedwars.SwordController.lastAttack = workspace:GetServerTimeNow()
            Bedwars.SwordController.lastSwingServerTime = workspace:GetServerTimeNow()
            lastSwingServerTimeDelta = workspace:GetServerTimeNow() - lastSwingServerTime
            lastSwingServerTime = workspace:GetServerTimeNow()
            Bedwars.SwordController.lastAttack = workspace:GetServerTimeNow()
            local CD = CFrame.new(selfpos, ePos).LookVector
            Store.Attack_Remote:FireServer({
            ["weapon"] = Sword,
                ["chargedAttack"] = {
                    ["chargeRatio"] = 0
                },
                ["entityInstance"] = Target,
                ["lastSwingServerTimeDelta"] = lastSwingServerTimeDelta,
                validate = {
                    raycast = {
                        cameraPosition = {value = Vec_This(ePos)},
                        cursorDirection = {value = Vec_This(CD)}
                    },
                    targetPosition = {value = Vec_This(ePos)},
                    selfPosition = {value = Vec_This(selfpos)}
                }
            })

        end

    end

    if Input.UserInputType == Enum.UserInputType.MouseButton1 and not Processed and Settings.Mode == "Full" then

        if not Is_Clicking then
            Click_Tick = tick() + Settings.Auto
            while Click_Tick > tick() and Sword and Sword_Meta and Sword_Table do
                Is_Clicking = true
                task.wait()
            end
            Is_Clicking = false
        else
            Click_Tick = tick() + Settings.Auto
        end

    end
end))

table.insert(Connections, UIS.InputEnded:Connect(function(Input, Processed)
    if Input.UserInputType == Enum.UserInputType.MouseButton1 and Break_Hold then
        Break_Hold = false
    end
end))

table.insert(Connections, UIS.WindowFocused:Connect(function(Input, Processed)
    Focused = true
end))

table.insert(Connections, UIS.WindowFocusReleased:Connect(function(Input, Processed)
    Focused = false
end))

while Deleted == false do
    Chr = plr.Character
    root = (Chr and Chr:FindFirstChild("HumanoidRootPart"))
    rpos = (root and root.Position) or nil

    hum = (Chr and Chr:FindFirstChildOfClass("Humanoid"))

    Sword, Sword_Table, Sword_Meta = Verify_If_Player_Is_Holding_A_Sword()
    Entities = rpos and Retrieve_All_Line_Of_Sight_Entities()
    Closest = Entities and Get_Closest_Entity(Entities)

    if Closest and Sword and rpos and Sword_Table and Sword_Meta and Enabled and Clear_To_KA() == true then

        local ePrim = Closest.PrimaryPart
        local ePos: Vector3 = ePrim.Position

        local selfpos = rpos + ((rpos - root.Position).Magnitude > 14.4 and (CFrame.lookAt(rpos, ePos).LookVector * ((rpos - ePos).magnitude - 14)) or Vector3.zero)

        local localfacing = root.CFrame.LookVector
        local vec = (ePos - rpos).unit
        local angle = math.acos(localfacing:Dot(vec))

        local angle_deg = math.deg(angle)
        local Hit = (ePos - rpos).Magnitude < Settings.Range and angle_deg < Settings.Degrees

        if Hit then

            Target = Closest

            if Settings.Mode == "Full" and Is_Clicking then
                Bedwars.SwordController.lastAttack = workspace:GetServerTimeNow()
                Bedwars.SwordController.lastSwingServerTime = workspace:GetServerTimeNow()

                lastSwingServerTimeDelta = workspace:GetServerTimeNow() - lastSwingServerTime
                lastSwingServerTime = workspace:GetServerTimeNow()

                Bedwars.SwordController.lastAttack = workspace:GetServerTimeNow()

                local CD = CFrame.new(selfpos, ePos).LookVector

                Store.Attack_Remote:FireServer({
                ["weapon"] = Sword,
                    ["chargedAttack"] = {
                        ["chargeRatio"] = 0
                    },
                    ["entityInstance"] = Closest,
                    ["lastSwingServerTimeDelta"] = lastSwingServerTimeDelta,
                    validate = {
                        raycast = {
                            cameraPosition = {value = Vec_This(ePos)},
                            cursorDirection = {value = Vec_This(CD)}
                        },
                        targetPosition = {value = Vec_This(ePos)},
                        selfPosition = {value = Vec_This(selfpos)}
                    }
                })
            end
        else
            Target = nil
        end
    else
        Target = nil
    end

    if (not Player_Inventory_Folder or not Player_Inventory_Folder.Parent or #Player_Inventory_Folder:GetChildren() < 2) then
        Obtain_Inventory(true)
    end

    for _, Player in pairs(game.Players:GetPlayers()) do
        Anti_Streamer_This(Player)
    end

    

    task.wait()
end

Settings.Anti_Streamer = false
for _, Player in pairs(game.Players:GetPlayers()) do
    Anti_Streamer_This(Player)
end

for _, v:RBXScriptConnection in pairs(Connections) do
    if v then v:Disconnect() end
end

Save_Settings()
if Conf then Conf:Destroy() end
if lobotomy_KA then lobotomy_KA:Destroy() end
