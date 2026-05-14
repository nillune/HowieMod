 G.ILoveTV = 0
Howie = SMODS.current_mod
-- ...existing code...
Howie.config = SMODS.current_mod.config or {}

-- Load the persistent global from config on mod init


if next(SMODS.find_card('j_howie_peterin', false)) then
	familycardArray = {"m_howie_familycard", "m_howie_green"}
else
	familycardArray = {"m_howie_familycard", "m_howie_nothing"}
end
if 	Howie.config.GasterFound == nil then
    Howie.config.GasterFound = 0
   
end
if  Howie.config.GreenCount == nil then
     Howie.config.GreenCount = 0
end
if  Howie.config.ClipsWatched == nil then
     Howie.config.ClipsWatched = 0
end
--CONFIG
if  Howie.config.ErinSubs == nil then
     Howie.config.ErinSubs = 0
end
--Kindly took this from Prism :D

local old_config = copy_table(Howie.config)
local function should_restart()
	for k, v in pairs(old_config) do
		if v ~= Howie.config[k] then
			SMODS.full_restart = 1
			return
		end
	end
	SMODS.full_restart = 0
end
local mod_path = "" .. SMODS.current_mod.path -- this path changes when each mod is loaded, but the local variable will retain Cryptid's path
Howie.path = mod_path
Howie.config = SMODS.current_mod.config or {} --is this nil check needed? idk but i saw crash reports related to this
Howie.config_tab = function()
	return {
		n = G.UIT.ROOT,
		config = { align = "cm", padding = 0.07, emboss = 0.05, r = 0.1, colour = G.C.BLACK, minh = 4.5, minw = 7 },
		nodes = {
			{
				n = G.UIT.R,
				nodes = {
					{
						n = G.UIT.C,
						nodes = {
							create_toggle({
								label = "hi",
								ref_table = Howie.config,
								ref_value = "hi",
                               -- callback = should_restart,
							}),
							create_toggle({
								label = "Disable Family Guy jokers*",
								ref_table = Howie.config,
								ref_value = "no_family",
								callback = should_restart,
							}),
							create_toggle({
								label = "No new music",
								ref_table = Howie.config,
								ref_value = "no_music",
								--callback = should_restart,
							}),
							create_toggle({
								label = "Legacy Abilties*",
								ref_table = Howie.config,
								ref_value = "legacy_version",
								callback = should_restart,
							}),
                            create_toggle({
								label = "Unstable Features",
								ref_table = Howie.config,
								ref_value = "unstable_features",
                                callback = should_restart,
							}),
						},
					},
				},
			},
            
			{
				n = G.UIT.R,
				config = { align = "cm", minh = 0.6 },
				nodes = {
					{ n = G.UIT.T, config = { text = "*" .. "Requires restart", colour = G.C.WHITE, scale = 0.4 } },
				},
                
			},
            
		},
	}
end

SMODS.ObjectType({
	key = "howie_jokers",
	default = "j_reserved_parking",
	cards = {},
	inject = function(self)
		SMODS.ObjectType.inject(self)
		
	end,
})
SMODS.ObjectType({
	key = "erin",
	default = "j_reserved_parking",
	cards = {},
	inject = function(self)
		SMODS.ObjectType.inject(self)
		
	end,
})
SMODS.ObjectType({
	key = "Blueprints",
	default = "j_joker",
	cards = {"j_blueprint", "j_brainstorm"},
	inject = function(self)
		SMODS.ObjectType.inject(self)
		
	end,
})
SMODS.ObjectType({
	key = "fish",
	default = "c_howie_catfish",
	--cards = {"j_blueprint", "j_brainstorm"},
	inject = function(self)
		SMODS.ObjectType.inject(self)
		
	end,
})



SMODS.Sound({
    key = "music_triplebaka", 
    path = "music_triplebaka.ogg",
    pitch = 1,
    
    volume = 0.6,
    
        select_music_track = function()
    if(not Howie.config["no_music"]) then
        return  next(SMODS.find_card("j_howie_triplebaka")) and 410
    end
end
})
SMODS.Sound({
    key = "music_piano", 
    path = "music_piano.ogg",
    pitch = 1,
    
    volume = 0.6,
    
        select_music_track = function()
    if(not Howie.config["no_music"]) then
        return  next(SMODS.find_card("j_howie_pianozombie")) and 411
    end
end
})
SMODS.Sound({
    key = "music_knight", 
    path = "music_knight.ogg",
    pitch = 1,
    
    volume = 0.5,
    
        select_music_track = function()
    if(not Howie.config["no_music"]  and type(G) == 'table' and type(G.GAME) == 'table' 
    and type(G.GAME.blind) == 'table' and G.GAME.blind.name == 'boss_knight') then
        return   409
    end
end
})
SMODS.Sound({
    key = "music_woody", 
    path = "music_woody.ogg",
    pitch = 1,
    volume = 1,
    
        select_music_track = function()
    if(not Howie.config["no_music"]  and type(G) == 'table' and type(G.GAME) == 'table' 
    and type(G.GAME.blind) == 'table' and G.GAME.blind.name == 'boss_woody') then
        return   409
    end
end
})
SMODS.Sound({
    key = "music_pumpkin", 
    path = "music_pumpkin.ogg",
    pitch = 1,
    
    volume = 0.6,
    
        select_music_track = function()
    if(not Howie.config["no_music"] and type(G) == 'table' and type(G.GAME) == 'table' 
    and type(G.GAME.blind) == 'table' and G.GAME.blind.name == 'boss_pumpkin') then
        return  409
    end
end
})
SMODS.Sound({
    key = "music_silent", 
    path = "music_silent.ogg",
    pitch = 1,
    
    volume = 0.1,
    
        select_music_track = function()
    if true == false then
        return   
    end
end
})
SMODS.Sound({
    key = "music_tenna", 
    path = "music_tenna.ogg",
    pitch = 1,
    
    volume = 1,
    
        select_music_track = function()
  if(not Howie.config["no_music"] and type(G) == 'table' and type(G.GAME) == 'table' 
    and type(G.GAME.blind) == 'table' and G.GAME.blind.name == 'boss_tenna') then
        return   409
    end
end
})

if not howie then
	howie = {}
end
local mod_path = "" .. SMODS.current_mod.path
howie.path = mod_path
local NFS = require("nativefs")
to_big = to_big or function(a) return a end
lenient_bignum = lenient_bignum or function(a) return a end

local function load_jokers_folder()
    local mod_path = SMODS.current_mod.path
    local jokers_path = mod_path .. "/items"
    local files = NFS.getDirectoryItemsInfo(jokers_path)
    for i = 1, #files do
        local file_name = files[i].name
        if file_name:sub(-4) == ".lua" then
            assert(SMODS.load_file("items/" .. file_name))()
        end
    end
    if(Howie.config["unstable_features"]) then
        print("unstable loaded")
        jokers_path = mod_path .. "/items/unstable/"
   
     files = NFS.getDirectoryItemsInfo(jokers_path)
    for i = 1, #files do
        local file_name = files[i].name
        if file_name:sub(-4) == ".lua" then
            assert(SMODS.load_file("/items/unstable/" .. file_name))()
        end
    end
    end
end
local function load_jokers_folder2()
    local mod_path = SMODS.current_mod.path
    local jokers_path = mod_path .. "/items/jokers"
    local files = NFS.getDirectoryItemsInfo(jokers_path)
    for i = 1, #files do
        local file_name = files[i].name
        if file_name:sub(-4) == ".lua" then
            assert(SMODS.load_file("items/jokers/" .. file_name))()
        end
    end
end
--[[
local function load_consumables_folder()
    local mod_path = SMODS.current_mod.path
    local consumables_path = mod_path .. "/consumables"
    local files = NFS.getDirectoryItemsInfo(consumables_path)
    for i = 1, #files do
        local file_name = files[i].name
        if file_name:sub(-4) == ".lua" then
            assert(SMODS.load_file("consumables/" .. file_name))()
        end
    end
end

local function load_rarities_file()
    local mod_path = SMODS.current_mod.path
    assert(SMODS.load_file("rarities.lua"))()
end

load_rarities_file()
local function load_boosters_file()
    local mod_path = SMODS.current_mod.path
    assert(SMODS.load_file("boosters.lua"))()
end
local function load_enhancements_folder()
    local mod_path = SMODS.current_mod.path
    local enhancements_path = mod_path .. "/enhancements"
    local files = NFS.getDirectoryItemsInfo(enhancements_path)
    for i = 1, #files do
        local file_name = files[i].name
        if file_name:sub(-4) == ".lua" then
            assert(SMODS.load_file("enhancements/" .. file_name))()
        end
    end
end

load_boosters_file()

load_enhancements_folder()
load_consumables_folder()
--]]
SMODS.Atlas({
    key = "modicon", 
    path = "ModIcon.png", 
    px = 34,
    py = 34,
    atlas_table = "ASSET_ATLAS"
})


SMODS.Atlas({
    key = "Gaster", 
    path = "Gaster.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
}):register()
SMODS.Atlas({
    key = "Greenster", 
    path = "Greenster.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
}):register()
SMODS.Atlas({
    key = "CustomJokers", 
    path = "CustomJokers.png", 
    px = 71,
    py = 95, 
	disable_mipmap = true,
    atlas_table = "ASSET_ATLAS"
}):register()

SMODS.Atlas({
    key = "CustomConsumables", 
    path = "CustomConsumables.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
}):register()
SMODS.Atlas({
    key = "MrUncanny",
    path = "uncanny.png",
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
}):register()

SMODS.Atlas({
    key = "CustomBoosters", 
    path = "CustomBoosters.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
}):register()
SMODS.Atlas({
    key = "CustomEnhancements", 
    path = "CustomEnhancements.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
}):register()
SMODS.Atlas{
    key = 'erinMoon', 
    path = "erinMoon.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
}
SMODS.Atlas({
    key = "VoucherAtlas", 
    path = "Vouchers.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
}):register()
SMODS.Atlas({
    key = "Stakes",
    path = "mintflower.png",
    px = 29,
    py = 29,
    atlas_table = "ASSET_ATLAS"
}):register()
SMODS.Atlas({
    key = "stickers",
    path = "stickers.png",
    px = 71,
    py = 95,
    atlas_table = "ASSET_ATLAS"
}):register()
load_jokers_folder()
load_jokers_folder2()
SMODS.Sound:register_global()
local config = SMODS.current_mod.config

-- Inject a "peter" button into the main menu next to the Play button.
-- This follows the same pattern other mods use: keep a reference to the
-- original function and return a modified UI definition.
do
    if type(create_UIBox_main_menu_buttons) == 'function' then
        local create_UIBox_main_menu_buttonsRef = create_UIBox_main_menu_buttons
        function create_UIBox_main_menu_buttons()
            local peterButton = UIBox_button({
                id = "peter_button",
                minh = 1.55,
                minw = 1.85,
                col = true,
                button = "peter",
                colour = G.C.PALE_GREEN,
                label = {"Peter"},
                scale = 0.45 * 1.2,
            })

            local menu = create_UIBox_main_menu_buttonsRef()
            -- Insert the button after the main Play button so it appears bottom-left next to it.
            -- The layout used by the UI definitions places the Play button at menu.nodes[1].nodes[1].nodes[1].
            -- Insert at index 2 to place our button immediately after Play.
            if menu and menu.nodes and menu.nodes[1] and menu.nodes[1].nodes and menu.nodes[1].nodes[1] and menu.nodes[1].nodes[1].nodes then
                table.insert(menu.nodes[1].nodes[1].nodes, 2, peterButton)
                menu.nodes[1].nodes[1].config = {align = "cm", padding = 0.15, r = 0.1, emboss = 0.1, colour = G.C.L_BLACK, mid = true}
            end
            return menu
        end
    end

    -- Register a handler so the UI button can call the watchTV function.
    G.FUNCS = G.FUNCS or {}
    G.FUNCS.peter = function(e)
        -- Debug: log that the handler ran and what event was passed
        local id = (type(e) == 'table' and e.ID) and e.ID or tostring(e)
        print("G.FUNCS.peter invoked, event ID:", id)

        -- If watchTV isn't available, try to (re)load the file that defines it as a fallback.
        if type(watchTV) ~= 'function' then
            local ok, err = pcall(function()
                if SMODS and SMODS.load_file then
                    local loader = SMODS.load_file("items/videos.lua")
                    if loader then loader() end
                end
            end)
            if not ok then print("Attempt to load items/videos.lua failed:", err) end
        end

        -- Call watchTV safely and report any runtime error
        if type(watchTV) == 'function' then
            local ok, err = pcall(watchTV)
            if not ok then print("watchTV() threw an error:", err) end
        else
            print("peter button pressed but watchTV() still not found after attempting to load it")
        end
    end
end

-- Inject an End Run button into the in-game play buttons when the active blind is the special boss 'boss_endrun'.
do
    if type(create_UIBox_buttons) == 'function' then
        local create_UIBox_buttonsRef = create_UIBox_buttons
        function create_UIBox_buttons()
            local t = create_UIBox_buttonsRef()

            -- Only modify when in a run and the current blind matches our boss key
            local on_endrun_boss = false
            if type(G) == 'table' and type(G.GAME) == 'table' and type(G.GAME.blind) == 'table' and G.GAME.blind.name then
                on_endrun_boss = (G.GAME.blind.name == 'boss_endrun') or (G.GAME.blind.key == 'boss_endrun')
            end

            if on_endrun_boss and t and t.nodes and type(t.nodes) == 'table' then
                -- Create a standalone End Run UI node (top-level sibling) using UIBox_button so it has a proper background.
                local endRunNode = UIBox_button({
                    id = 'end_run_button',
                    label = {'End Run'},
                    button = 'end_run',
                    minw = 1.8,
                    minh = 1.3,
                    scale = 0.4,
                    col = true,
                    colour = G.C.PALE_RED,
                    one_press = true,
                })

                -- Try to find the index of the play/discard button node at the top-level and insert BEFORE it (so End Run is left of Play).
                local insert_index = nil
                for idx, node in ipairs(t.nodes) do
                    -- direct button node
                    if node and node.config and node.config.button and (node.config.button == 'play_cards_from_highlighted' or node.config.button == 'discard_cards_from_highlighted') then
                        insert_index = idx
                        break
                    end
                    -- or a wrapper that contains the button
                    if node and node.nodes and type(node.nodes) == 'table' then
                        for _, sub in ipairs(node.nodes) do
                            if sub and sub.config and sub.config.button and (sub.config.button == 'play_cards_from_highlighted' or sub.config.button == 'discard_cards_from_highlighted') then
                                insert_index = idx
                                break
                            end
                        end
                        if insert_index then break end
                    end
                end

                if insert_index then
                    table.insert(t.nodes, insert_index + 1, endRunNode)
                else
                    -- fallback: append to the end
                    table.insert(t.nodes, endRunNode)
                end
            end

            return t
        end
    end

    -- Handler to end the run: set the game state to GAME_OVER safely while in a run.
    G.FUNCS.end_run = function(e)
        print("End Run button pressed")
        if G.STAGE == G.STAGES.RUN then
            -- Move to game over safely
            G.STATE = G.STATES.GAME_OVER
            G.STATE_COMPLETE = false
            -- Ensure any HUD updates happen
            if G.HUD_blind and type(G.HUD_blind.recalculate) == 'function' then
                pcall(function() G.HUD_blind:recalculate() end)
            end
        else
            print("End Run pressed but not in a run (stage:", tostring(G.STAGE), ")")
        end
    end
end
