SMODS.Atlas {
    key = "blinds",
    path = "blinds.png",
    px = 34,
    py = 34,
    frames = 1,
    atlas_table = "ANIMATION_ATLAS"
}

SMODS.Blind {
    name = "boss_peter",
    key = "boss_peter",
    atlas = "blinds",
    mult = 2,
    pos = {y = 0},
    dollars = 6,
    loc_txt = {
        name = 'The Guy',
        text = {'Watch a Family Guy Clip', 'After Every Hand'}
    },
    boss = {min = 1},
    boss_colour = HEX('3cc0c8'),
    press_play = function(self)
        -- print("meow")
        watchTV()
    end
}
local pumpkinCount = 0
SMODS.Blind {
    name = "boss_pumpkin",
    key = "boss_pumpkin",
    atlas = "blinds",
    mult = 2,
    pos = {y = 1},
    dollars = 6,
    loc_txt = {
        name = 'The Pumpkin',
        text = {'Increases blind if', 'YOUR TAKING TOO LONG'}
    },

    boss = {min = 4},
    boss_colour = HEX('ED1C24'),
    drawn_to_hand = function(self) end,
    press_play = function(self)
        G.E_MANAGER:add_event(Event({

            trigger = 'after',
            delay = 25,
            blockable = false,
            blocking = false,
            pause_force = false,
            func = function()
                if pumpkinCount >= 30 then
                    pumpkinCount = 0
                    G.FUNCS.overlay_menu {
                        definition = create_UIBox_custom_video1('pumpkinlong',
                                                                "Blind Increased!.",
                                                                2, 10, 5),
                        config = {no_esc = true}
                    }
                    G.GAME.blind.chips = G.GAME.blind.chips * 2
                    G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                end
                return true
            end

        }))

    end,
    calculate = function(self, blind, context)

        if context.post_trigger then
            pumpkinCount = pumpkinCount + 1
            -- print(pumpkinCount)
        end
        if context.hand_drawn then
            -- print(pumpkinCount, "0")
            pumpkinCount = 0
        end
    end

}
SMODS.Blind {
    name = "boss_knight",
    key = "boss_knight",
    atlas = "blinds",
    mult = 2,
    pos = {y = 2},
    dollars = 6,
    loc_txt = {
        name = 'The Knight',
        text = {'If Score is a divisble by', '12 or 25, {C:red,s:1.2}SWOON{}'}
    },
    boss = {min = 2},
    boss_colour = HEX('000000'),
    drawn_to_hand = function(self)
        -- print(isWholeNumber(G.GAME.chips/12))
        -- print(isWholeNumber(G.GAME.chips/25))
        if isWholeNumber(G.GAME.chips / 12) or isWholeNumber(G.GAME.chips / 25) then
            if G.GAME.chips > 0 then
                play_sound("howie_swoon")
                G.SwoonCount = 180

                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 4,
                    func = function()
                        if G.STAGE == G.STAGES.RUN then
                            G.STATE = G.STATES.GAME_OVER
                            G.STATE_COMPLETE = false

                        end
                    end
                }))
            end
        end
    end

}
SMODS.Atlas {
    key = "impossible",
    path = "impossible.png",
    px = 34,
    py = 34,
    frames = 1,
    atlas_table = "ANIMATION_ATLAS"
} -- dude this image is cursed it keeps on clipping into the other boss blind images????? 
-- it's getting sent to the time out corner
-- New boss blind: boss_endrun
SMODS.Blind {
    name = "boss_endrun",
    key = "boss_endrun",
    atlas = "impossible",
    mult = 2,
    pos = {y = 0},
    dollars = 6,
    loc_txt = {name = 'The Impossible', text = {'Adds an end run button'}},
    boss = {min = 1},
    boss_colour = HEX('FF00FF')
    -- No special press_play effect; the presence of this blind enables the End Run button in the HUD.

}
local drawhook = love.draw
function love.draw()
    drawhook()
    function loadThatFuckingImage(fn)
        local full_path = (howie.path .. fn)
        local file_data = assert(NFS.newFileData(full_path), ("Epic fail"))
        local tempimagedata = assert(love.image.newImageData(file_data),
                                     ("Epic fail 2"))
        return (assert(love.graphics.newImage(tempimagedata), ("Epic fail 3")))
    end
    local _xscale = 2 * love.graphics.getWidth() / 1920
    local _yscale = 2 * love.graphics.getHeight() / 1080
    if G.SwoonCount and (G.SwoonCount > 0) then
        if howie.Swoon == nil then
            howie.Swoon = loadThatFuckingImage("Swoon.png")
        end
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(howie.Swoon, 0 * _xscale, 0 * _yscale, 0,
                           _xscale * .5, _yscale * .5)
        G.SwoonCount = G.SwoonCount - 1
    end
end
SMODS.Blind {
    name = "boss_freddy",
    key = "boss_freddy",
    atlas = "blinds",
    mult = 2,
    pos = {y = 3},
    dollars = 6,
    loc_txt = {
        name = 'Feddy',
        text = {'Adds Freddy Fazbear', 'to your Jokers', 'for 5 Blinds'}
    },
    boss = {min = 1},
    boss_colour = HEX('FF00FF'),
    set_blind = function(self)
        G.jokers.config.card_limit = G.jokers.config.card_limit + 1
        local joker_card = SMODS.add_card({
            set = 'Joker',
            key = 'j_howie_freddy'
        })
        if joker_card then joker_card:add_sticker('eternal', true) end
        return true

    end,
    disable = function(self)
     --card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "-"..tostring(card.ability.extra.joker_slots).." Joker Slot", colour = G.C.DARK_EDITION})
                G.jokers.config.card_limit = G.jokers.config.card_limit - 1
                local target_joker = nil
                for i, joker in ipairs(G.jokers.cards) do
                    
                    if joker.config.center.key == "j_howie_freddy" and not joker.getting_sliced then
                        target_joker = joker
                        break
                    end
                end
                if target_joker then
                    if target_joker.ability.eternal then
                        target_joker.ability.eternal = nil
                    end
                    target_joker.getting_sliced = true
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            target_joker:start_dissolve({G.C.RED}, nil, 1.6)
                            return true
                        end
                    }))
                    --card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Destroyed!", colour = G.C.RED})
                end
                    return true
                end
}
SMODS.Blind {
    name = "boss_piano",
    key = "boss_piano",
    atlas = "blinds",
    mult = 2,
    pos = {y = 8},
    dollars = 6,
    loc_txt = {
        name = 'The Western',
        text = {'Adds Pianist Zombie', 'to your Jokers', 'for 5 Blinds'}
    },
    boss = {min = 1},
    boss_colour = HEX('FAD68C'),
    set_blind = function(self)
        G.jokers.config.card_limit = G.jokers.config.card_limit + 1
        local joker_card = SMODS.add_card({
            set = 'Joker',
            key = 'j_howie_pianozombie'
        })
        if joker_card then joker_card:add_sticker('eternal', true) end
        return true
    end,
     disable = function(self)
     --card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "-"..tostring(card.ability.extra.joker_slots).." Joker Slot", colour = G.C.DARK_EDITION})
                G.jokers.config.card_limit = G.jokers.config.card_limit - 1
                local target_joker = nil
                for i, joker in ipairs(G.jokers.cards) do
                    
                    if joker.config.center.key == "j_howie_pianozombie" and not joker.getting_sliced then
                        target_joker = joker
                        break
                    end
                end
                if target_joker then
                    if target_joker.ability.eternal then
                        target_joker.ability.eternal = nil
                    end
                    target_joker.getting_sliced = true
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            target_joker:start_dissolve({G.C.RED}, nil, 1.6)
                            return true
                        end
                    }))
                    --card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Destroyed!", colour = G.C.RED})
                end
                    return true
                end
}
--[[
SMODS.Blind {
    name = "boss_flappybird",
    key = "boss_flappybird",
    atlas = "blinds",
    mult = 2,
    pos = {y = 7},
    dollars = 6,
    loc_txt = {name = 'Tenna', text = {'Say "I LOVE TV!"'}},
    boss = {min = 1},
    boss_colour = HEX('DB1F53'),
    defeat = function(self)
        stopTenna = true
        G.sadCount = 0
        G.TennaSuitCount = 0
        G.TennaDanceCount = 0
    end,
    set_blind = function(self)
        -- G.TennaDanceCount = 1
        G.TennaDanceCount = 1
        local event
        event = Event {
            blockable = false,
            blocking = false,
            pause_force = false,
            no_delete = true,
            trigger = "after",
            delay = 3 / G.SETTINGS.GAMESPEED,
            timer = "UPTIME",
            func = function()
                event.start_timer = false
                if stopTenna or G.STAGE == 1 then return true end
                G.ILoveTV = G.ILoveTV - 8
                -- print(G.STAGE)
                -- print( G.ILoveTV )
                -- If ILoveTV goes below 0, triple chips and reset ILoveTV
                if G.ILoveTV < 0 then
                    G.GAME.blind.chips = G.GAME.blind.chips * 2
                    G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                    G.HUD_blind:recalculate()
                    -- print("guh")
                    G.ILoveTV = 40
                    -- print( G.ILoveTV )
                end

                -- Behavior based on ILoveTV range
                if G.ILoveTV < 20 then
                    G.sadCount = 1
                    G.TennaSuitCount = 0
                    G.TennaDanceCount = 0
                elseif G.ILoveTV > 40 and G.ILoveTV < 100 then
                    G.sadCount = 0
                    G.TennaSuitCount = 0
                    G.TennaDanceCount = 1
                elseif G.ILoveTV > 100 then
                    G.sadCount = 0
                    G.TennaSuitCount = 1
                    G.TennaDanceCount = 0
                end

                -- Prevent this event from looping automatically

            end
        }
        G.E_MANAGER:add_event(event)

    end
}
--old tenna make into flappy bird]] 


SMODS.Blind {
    name = "boss_woody",
    key = "boss_woody",
    atlas = "blinds",
    mult = 2,
    pos = {y = 5},
    vars = {},
    dollars = 6,
    loc_vars = function(self)
        local numerator, denominator = SMODS.get_probability_vars(self, 1, 17,
                                                                  'howie_boss_woody')
                                                            
                                                                    numerator = 1
                                                                
                                                                
                                                                    denominator = 17
                                                               
        return {vars = {numerator, denominator}}
    end,
    loc_txt = {
        name = 'Woody',
        text = {
            'When a card is discarded', "#1# in #2# chance to create",
            'a Monochrome copy of it in hand'
        }
    },
    boss = {min = 2},
    boss_colour = HEX('408080'),
    calculate = function(self, blind, context)
        if context.discard and not G.GAME.blind.disabled then
            for i, card in ipairs(G.hand.highlighted) do
                if SMODS.pseudorandom_probability(blind, 'howie_boss_woody', 1,
                                                  17) and
                    context.other_card.edition == nil then

                    G.playing_card = (G.playing_card and G.playing_card + 1) or
                                         1
                    local copied_card = copy_card(context.other_card, nil, nil,
                                                  G.playing_card)
                    copied_card:set_edition("e_howie_monochrome", true)
                    copied_card:add_to_deck()
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    G.hand:emplace(copied_card)
                    table.insert(G.playing_cards, copied_card)
                    playing_card_joker_effects({true})

                    G.E_MANAGER:add_event(Event({
                        func = function()
                            copied_card:start_materialize()
                            return true
                        end
                    }))
                    card_eval_status_text(context.blueprint_card or card,
                                          'extra', nil, nil, nil, {
                        message = "Copied Card!",
                        colour = G.C.GREEN
                    })
                end
            end
        end
    end
}

 local topkeys = {}
 local function thecreative()
     local used_cards = {}
    --[[
     joker_usage = joker_usage or {}
            _type, _set = joker_usage[1], joker_usage[2]
            local used_cards = {}
            local max_amt = 0
            for k, v in pairs(G.PROFILES[G.SETTINGS.profile][_type]) do
                if G.P_CENTERS[k] and (not _set or G.P_CENTERS[k].set == _set) and
                    G.P_CENTERS[k].discovered then
                    used_cards[#used_cards + 1] = {count = v.count, key = k}
                    if v.count > max_amt then
                        max_amt = v.count
                    end
                end
            end

            -- local _col = G.C.SECONDARY_SET[_set] or G.C.RED

            -- table.sort(used_cards, function (a, b) return a.count > b.count end )

            local histograms = {}

            for i = 1, 10 do
                local v = used_cards[i]
                if v then
                    print(G.P_CENTERS[v.key])
                end
            end
           
    for k, v in pairs(G.jokers.cards) do
        if v.config.center_key and v.ability.set == 'Joker' then
            if G.PROFILES[G.SETTINGS.profile].joker_usage[v.config.center_key] then
                print(G.PROFILES[G.SETTINGS.profile].joker_usage[v.config
                          .center_key].count)
            end
        end
       
    end
     print("HELLO")
      ]] --
        local max_amt = 0
        for k, v in pairs(G.PROFILES[G.SETTINGS.profile]['joker_usage']) do
            if G.P_CENTERS[k] and (not nil or G.P_CENTERS[k].set == nil) and
                G.P_CENTERS[k].discovered then

                --print("meow")
                used_cards[#used_cards + 1] = {count = v.count, key = k}
                if v.count > max_amt then max_amt = v.count end
            end
        end
    table.sort(used_cards, function (a, b) return a.count > b.count end )
    
for i = 1, 15 do
    local v = used_cards[i]
    if v then 
       if  topkeys[i] ~= v.key then
       topkeys[i]= v.key 
        print(topkeys[i])
       end
    end
end
end

SMODS.Blind {
    name = "boss_creative",
    key = "boss_creative",
    atlas = "blinds",
    mult = 2,
    pos = {y = 4},
    dollars = 6,
    loc_txt = {name = 'The Creative', text = {'Your 15 most used', 'jokers are debuffed'}},
    boss = {min = 3},
    boss_colour = HEX('36322F'),
     calculate = function(self, blind, context)
        
        if not blind.disabled then
            if context.debuff_card and context.debuff_card.area == G.jokers then
                if context.debuff_card.ability.not_creative then
                    return {
                        debuff = true
                    }
                end
            end
        end
        
        if not blind.disabled then
            	
                for j = 1,#G.jokers.cards do 
                 for k = 1,#topkeys do 
                   if G.jokers.cards[j].config.center.key == topkeys[k] then
                    --print(G.jokers.cards[j].config.center.key)
                    G.jokers.cards[j].ability.not_creative = true
                   end
                 end
            end
            end
        
    end,
    recalc_debuff = function(self, card, from_blind)
      
	
   
	end,
    set_blind = function(self)
        thecreative()
    end
}

SMODS.Blind {
    name = "boss_tenna",
    key = "boss_tenna",
    atlas = "blinds",
    mult = 2,
    pos = {y = 7},
    dollars = 6,
    loc_txt = {name = 'Tenna Again', text = {'Say "I LOVE TV!"'}},
    boss = {min = 4},
    boss_colour = HEX('DB1F53'),
    calculate = function(self, blind, context) if context.discard  or context.press_play then   for i = 1,2 do  math.randomseed(os.time()) QuizQuestion(2)  end end end,
       set_blind = function(self)
       
        for i = 1,5 do
        QuizQuestion(4)
        end
       end
}
