SMODS.Joker { -- Mark
--yes i did this just for the title screen
    key = "hero_mark",
    config = {
        extra = {
            totalDifferenceChips = 0,
            totalOtherChips = 0,
            Active = false,
            Display = "Inactive",
            xmult = 3,
            totalblindSize = .2,
            totalpercentage = 20
        }
    },
    loc_txt = {
        ['name'] = 'Invincible ',
        ['text'] = {
            [2] = 'If you scored less than {C:attention}#3#%{}',
            [3] = 'of the blind with previous hand',
            [1] = '{X:red,C:white}#2#X{} Mult',
            [4] = '{C:inactive}Currently #1#{}'
        },
        ['unlock'] = {[1] = 'Unlocked by default.'}
    },
    pos = {x = 8, y = 4},
    display_size = {w = 71 * 1, h = 95 * 1},
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = {["howie_jokers"] = true},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.Display,card.ability.extra.xmult, 100*card.ability.extra.totalblindSize}}
    end,
    calculate = function(self, card, context)
        if context.hand_drawn then
             local eval = function() return  card.ability.extra.Active == true and not G.RESET_JIGGLES end
                juice_card_until(card, eval, true)
        end
        if context.starting_shop or context.setting_blind then
            card.ability.extra.totalDifferenceChips = 0
            card.ability.extra.totalOtherChips = 0
        end
       
        if card.ability.extra.Active and context.joker_main then
            card.ability.extra.Active = false
             card.ability.extra.Display = "Inactive"
            return {Xmult = card.ability.extra.xmult}
        end

        if card.ability.extra.totalOtherChips ~= G.GAME.chips then
            --print(card.ability.extra.totalOtherChips)
           -- print(G.GAME.chips)
            -- print("please dont loop")
            card.ability.extra.totalDifferenceChips = G.GAME.chips - card.ability.extra.totalOtherChips
            card.ability.extra.totalOtherChips = G.GAME.chips
         --  print( card.ability.extra.totalDifferenceChips)
            -- print(card.ability.extra.howMany
            
            if  card.ability.extra.totalDifferenceChips < 0 then
                return --idk sometimes it happened when i used debug to insta clear
                -- dunno if it happened in normal gameplay, but figured better be safe thgan sorry
                -- kinda fucked later if i add negative blinds lol, hi future mint if i do 
            end
            if card.ability.extra.totalDifferenceChips / G.GAME.blind.chips <=
                to_big(card.ability.extra.totalblindSize) then
                card.ability.extra.Active = true
                card.ability.extra.Display = "Active!"
                
            end
            
        end
       
    end,
     add_to_deck = function(self, card, from_debuff)
            G.MarkCount = 310
            play_sound("howie_titlecard", 1,1)
        end
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
    if G.MarkCount and (G.MarkCount > 0) then
        if howie.MarkScreen == nil then
            howie.MarkScreen = loadThatFuckingImage("titlecard.png")
        end
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(howie.MarkScreen, 0 * _xscale, 0 * _yscale, 0,
                           _xscale * .5, _yscale * .5)
        G.MarkCount = G.MarkCount - 1
    end
end
SMODS.Joker{ --Shrimp Fried Rice
    key = "hairball",
    config = {
        extra = {
            Xmult = 4
        }
    },
    loc_txt = {
        ['name'] = 'Shrimp Fried Rice',
        ['text'] = {
            [1] = '{X:red,C:white}X#1#{} Mult',
            [2] = 'destroyed at',
            [3] =  'end of round'
        }
    },
    pos = {
        x = 9,
        y = 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
     no_collection = true,
    atlas = 'CustomJokers',
 --pools = { ["howie_jokers"] = true },
 loc_vars = function(self, info_queue, card)
        return {
            vars = {
               card.ability.extra.Xmult
            }
        }
    end,
    in_pool = function(self, args)
       return  args.source ~= 'sho' and args.source ~= 'buf' and args.source ~= 'jud' and args.source ~= 'rif' 
          or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    Xmult = card.ability.extra.Xmult
                    
                }
                
        end
       
        if context.end_of_round and context.game_over == false and context.main_eval  and not context.blueprint then
                return {
                    func = function()
                card:start_dissolve()
                return true
            end,
                    message = "Destroyed!"
                }
        end
    end
}
SMODS.Joker { -- Mr Uncanny
    key = "mruncanny",
    config = {
        extra = {
            howMany = 0, -- 1
            totalUncannyJudge = 100,
            dollars = -10,
            sell_value = 7,
            start_dissolve = 0,
           
            totalDifferenceChips = 0,
            totalOtherChips = 0
        }
    },
    loc_txt = {
        ['name'] = 'Mr Uncanny',
        ['text'] = {
            [1] = 'Rates your hands for 5 Blinds',
            [2] = 'then gives you effect',
            [3] = 'based on your performance',
            [4] = 'then leaves',
            [5] = '{C:inactive}#1#/5{}'
        },
        ['unlock'] = {[1] = 'Unlocked by default.'}
    },
    pos = {x = 2, y = 0},
    display_size = {w = 71 * 1, h = 95 * 1},
    cost = 4,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'MrUncanny',
    pools = {["howie_jokers"] = true},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.howMany}}
    end,
    calculate = function(self, card, context)
        if context.starting_shop then 
             card.ability.extra.totalDifferenceChips = 0
             card.ability.extra.totalOtherChips = 0
             card.ability.extra.howMany =   card.ability.extra.howMany + 1
        end
       
        if card.ability.extra.totalOtherChips ~= G.GAME.chips and G.GAME.blind.chips >
                0 then
           -- print("please dont loop")
             
            card.ability.extra.totalDifferenceChips = G.GAME.chips -
                                                     card.ability.extra
                                                         .totalOtherChips
            card.ability.extra.totalOtherChips = G.GAME.chips
            -- print(card.ability.extra.howMany)

            if card.ability.extra.totalDifferenceChips / G.GAME.blind.chips <= to_big(0.2) then
                card.children.center:set_sprite_pos({x = 0, y = 0})
                card.ability.extra.totalUncannyJudge =
                    math.max(0, (card.ability.extra.totalUncannyJudge) - 1)
                play_sound("howie_superevil", 1, 1)
            elseif (card.ability.extra.totalDifferenceChips / G.GAME.blind.chips <= to_big(0.4) and
                card.ability.extra.totalDifferenceChips / G.GAME.blind.chips >= to_big(0.2)) then
                card.children.center:set_sprite_pos({x = 1, y = 0})
                card.ability.extra.totalUncannyJudge =
                    math.max(0, (card.ability.extra.totalUncannyJudge) - .5)
                play_sound("howie_evil", 1, 1)
            elseif (card.ability.extra.totalDifferenceChips / G.GAME.blind.chips <= to_big(0.6) and
                card.ability.extra.totalDifferenceChips / G.GAME.blind.chips >= to_big(0.4)) then
                card.children.center:set_sprite_pos({x = 2, y = 0})
                play_sound("howie_normal", 1, 1)
                card.ability.extra.totalUncannyJudge =
                    math.max(0, (card.ability.extra.totalUncannyJudge) + 0)
            elseif (card.ability.extra.totalDifferenceChips / G.GAME.blind.chips <= to_big(0.8) and
                card.ability.extra.totalDifferenceChips / G.GAME.blind.chips >= to_big(0.6)) then
                card.children.center:set_sprite_pos({x = 3, y = 0})
                card.ability.extra.totalUncannyJudge =
                    math.max(0, (card.ability.extra.totalUncannyJudge) + .5)
                play_sound("howie_good", 1, 1)
            elseif (card.ability.extra.totalDifferenceChips / G.GAME.blind.chips >= to_big(0.8) and
                card.ability.extra.totalDifferenceChips / G.GAME.blind.chips <= to_big(9.99)) then
                card.children.center:set_sprite_pos({x = 4, y = 0})
                play_sound("howie_supergood", 1, 1)
                card.ability.extra.totalUncannyJudge =
                    math.max(0, (card.ability.extra.totalUncannyJudge) + 1)
            end
        end
        
        if context.starting_shop and not context.blueprint and
            card.ability.extra.howMany == 5 then
                 SMODS.destroy_cards(card, nil, nil, true)
              
              
               --print('killing self')
               
            if (card.ability.extra.totalUncannyJudge or 0) <= 93 then
                return {
                    message = "Mr. Uncanny will judge you.",
                    delay = 5,
                    extra = {
                        func = function()
                            card_eval_status_text(
                                context.blueprint_card or card, 'extra', nil,
                                nil, nil, {message = "DIE!", colour = G.C.RED})
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.5,
                                func = function()
                                    if G.STAGE == G.STAGES.RUN then
                                        G.STATE = G.STATES.GAME_OVER
                                        G.STATE_COMPLETE = false
                                    end
                                end
                            }))

                            return true
                        end,
                        colour = G.C.GREEN
                    }
                }
            elseif ((card.ability.extra.totalUncannyJudge or 0) <= 97 and
                (card.ability.extra.totalUncannyJudge or 0) > 93) then
                return {
                    message = "Mr. Uncanny will judge you.",
                    delay = 5,
                    extra = {
                        dollars = card.ability.extra.dollars,
                        message = "biggest piece of dogshit ive seen",
                        colour = G.C.MONEY,
                        extra = {
                            func = function()
                                    
                                        dollars = card.ability.extra.dollars
                                  
                                return true
                            end,
                            colour = G.C.RED
                        }
                    }
                }
            elseif ((card.ability.extra.totalUncannyJudge or 0) <= 104 and
                (card.ability.extra.totalUncannyJudge or 0) >= 102) then
                return {
                    message = "Mr. Uncanny will judge you.",
                    delay = 5,
                    extra = {
                        func = function()
                            for _, area in ipairs({G.jokers, G.consumeables}) do
                                for i, other_card in ipairs(area.cards) do
                                    if other_card.set_cost then
                                        other_card.ability.extra_value =
                                            (other_card.ability.extra_value or 0) +
                                                card.ability.extra.sell_value
                                        other_card:set_cost()
                                    end
                                end
                            end
                            return true
                        end,
                        message = "WOOOOOOO!! ",
                        delay = 5,
                        colour = G.C.MONEY,
                        
                        extra = {
                            func = function()
                                 return {
                        dollars = card.ability.extra.dollars,
                        card = self,
                   
                    message = localize('k_val_up'),
                   
                    }
                    

                                
                            end,
                            colour = G.C.RED
                        }
                    }
                }
            elseif ((card.ability.extra.totalUncannyJudge or 0) <= 102 and
                (card.ability.extra.totalUncannyJudge or 0) >= 98) then
                return {
                    message = "Mr. Uncanny will judge you.",
                    delay = 5,
                    extra = {
                        func = function()
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    local selected_tag =
                                        pseudorandom_element(G.P_TAGS,
                                                             pseudoseed(
                                                                 "create_tag")).key
                                    local tag = Tag(selected_tag)
                                    if tag.name == "Orbital Tag" then
                                        local _poker_hands = {}
                                        for k, v in pairs(G.GAME.hands) do
                                            if v.visible then
                                                _poker_hands[#_poker_hands + 1] =
                                                    k
                                            end
                                        end
                                        tag.ability.orbital_hand =
                                            pseudorandom_element(_poker_hands,
                                                                 "jokerforge_orbital")
                                    end
                                    tag:set_ability()
                                    add_tag(tag)
                                    play_sound('holo1',
                                               1.2 + math.random() * 0.1, 0.4)
                                    return true
                                end
                            }))
                            return true
                        end,
                        message = "i mean its alright like",

                        colour = G.C.GREEN,
                        extra = {
                            func = function()
                                
                                return true
                            end,
                            colour = G.C.RED
                        }
                    }
                }
            elseif (card.ability.extra.totalUncannyJudge or 0) >= 105 then

                return {
                    message = "Mr. Uncanny will judge you.",
                    delay = 5,
                    extra = {
                        func = function() return true end,
                        colour = G.C.RED,
                        extra = {
                            func = function()
                                local available_jokers = {}
                                for i, joker in ipairs(G.jokers.cards) do
                                    table.insert(available_jokers, joker)
                                end
                                local target_joker =
                                    #available_jokers > 0 and
                                        pseudorandom_element(available_jokers,
                                                             pseudoseed(
                                                                 'copy_joker')) or
                                        nil

                                if target_joker and not target_joker.config.center.key == "mruncanny" then
                                    G.GAME.joker_buffer =
                                        G.GAME.joker_buffer + 1
                                    G.E_MANAGER:add_event(Event({
                                        func = function()
                                            local copied_joker = copy_card(
                                                                     target_joker,
                                                                     nil, nil,
                                                                     nil,
                                                                     target_joker.edition and
                                                                         target_joker.edition
                                                                             .negative)
                                            copied_joker:set_edition(
                                                "e_polychrome", true)

                                            copied_joker:add_to_deck()
                                            G.jokers:emplace(copied_joker)
                                            G.GAME.joker_buffer = 0
                                            return true
                                        end
                                    }))
                                    card_eval_status_text(
                                        context.blueprint_card or card, 'extra',
                                        nil, nil, nil, {
                                            message = "THATS WHY YOURE THE GOAT!!!!",
                                            colour = G.C.GREEN
                                        })
                                end
                                return true
                            end,
                            colour = G.C.GREEN
                        }
                    }
                }
                
           
            end
        

        
              
        end
        if card.ability.extra.howMany > 5 then
            return {
                    message = "NO CHEESING!",
                    delay = 5,
                    
            }
        end
    end

}
SMODS.Joker { -- Blueprint Copy
    key = "yapdollar",
    config = {
        extra = {dollars = 1}
        -- immutable = { max_retriggers = 25 },
    },
    loc_txt = {
        ['name'] = 'Yap Dollar',
        ['text'] = {
            [1] = 'Earn {C:money}$#1#{} when Joker',
            [2] = 'to the left triggers'
        },
        ['unlock'] = {[1] = ''}
    },
    pos = {x = 3, y = 5},
    display_size = {w = 71 * 1, h = 95 * 1},
    cost = 4,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.dollars}}
    end,
    calculate = function(self, card, context)
          local other_joker
        if card.area and card.area == G.jokers then
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    other_joker = G.jokers.cards[i - 1]
                end
            end
        end
        
         if context.post_trigger then
         
            --print(context.other_card.config.center.key  )
                if context.other_card == other_joker then
                -- print("meow")
                return {dollars = card.ability.extra.dollars,   message_card = card}
                end
            end
    end

}
SMODS.Joker { -- Blueprint Copy
    key = "fortnitecard",
    config = {
        extra = {dollars = 19, moneyspent = 0}
        -- immutable = { max_retriggers = 25 },
    },
    loc_txt = {
        ['name'] = '19$ Fortnite Card',
        ['text'] = {
            [2] = 'After spending {C:money}$#1#{}',
            [3] = "on buying cards",
            [1] = "Earn {C:money}$#1#{}",
            [4] = "{C:red}self destructs{}",
            [5] = "{C:inactive}Currently #2#/#1#{}"
        },
        ['unlock'] = {[1] = ''}
    },
    pos = {x = 0, y = 6},
    display_size = {w = 71 * 1, h = 95 * 1},
    cost = 6,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.dollars, card.ability.extra.moneyspent}
        }
    end,
    calculate = function(self, card, context)

        if context.buying_card  then
            if context.card ~= card then --to fix bug where it counts itself when buying it
            card.ability.extra.moneyspent =
                context.card.config.center.cost + card.ability.extra.moneyspent
            if card.ability.extra.moneyspent >= card.ability.extra.dollars then
                SMODS.destroy_cards(card, nil, nil, true)
                return {dollars = card.ability.extra.dollars}

            end
        end        
        end
    
    end,
    add_to_deck = function(self, card, from_debuff)
        play_sound("howie_fortnitecard", 1,3)
    end,

}
-- Jolly Joker
SMODS.Joker {
    key = "wojoker",
    pos = { x = 9, y = 5 },
    rarity = 1,
    blueprint_compat = true,
    cost = 3,
    atlas = "CustomJokers",
     loc_txt = {
        ['name'] = 'Wojoker',
        ['text'] = {
            [1] ="{C:mult}+#1#{} Mult if played",
             [2] =  "{C:attention} poker hand{} isn't leveled",
        }
    },
    config = { extra = { mult = 20, type = 'Pair' }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main  then
            local target_hand = (context.scoring_name or "High Card")
            if G.GAME.hands[target_hand].level == 1 then
            return {
                mult = card.ability.extra.mult
            }
                end
        end
    end
}
SMODS.Atlas({
    key = "TalkingBaby",
    path = "talkingbaby.png",
    px = 72,
    py = 95,
    atlas_table = "ASSET_ATLAS"
}):register()
SMODS.Sound({
    key = "music_baby",
    path = "music_baby.ogg",
    pitch = 1,
    sync = false,
    volume = 1,

    select_music_track = function()
        if (not Howie.config["no_music"]) then
            return next(SMODS.find_card("j_howie_podcast")) and 405
        end
    end
})
SMODS.Joker { -- Talking Baby Podcast
    key = "podcast",
    config = {extra = {mult = 1.25, currentX = 0}},
    loc_txt = {
        ['name'] = 'Talking Baby Podcast',
        ['text'] = {
            [1] = 'Each played {C:attention}2{},',
            [2] = '{C:attention}3{}, {C:attention}4{}, or {C:attention}5{} Gives',
            [3] = '{X:red,C:white}#1#X{} Mult when scored'
        },
        ['unlock'] = {[1] = ''}
    },
    pos = {x = 0, y = 0},

    pixel_size = {h = 95, w = 72},
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'TalkingBaby',

    loc_vars = function(self, info_queue, card)

        return {vars = {card.ability.extra.mult}}
    end,
    update = function(self, card, dt)
        if card.ability.extra.currentX >= 45 then
            card.ability.extra.currentX = 0
        end

        card.children.center:set_sprite_pos({
            x = math.floor(card.ability.extra.currentX),
            y = 0
        })

        card.ability.extra.currentX = card.ability.extra.currentX + .3

    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if (context.other_card:get_id() == 2 or context.other_card:get_id() ==
                3 or context.other_card:get_id() == 4 or
                context.other_card:get_id() == 5) then
                return {xmult = card.ability.extra.mult}
            end
        end

        -- if context.discard then thecreative() end
    end,

    add_to_deck = function(self, card, from_debuff)
        card.children.center:set_sprite_pos({x = 0, y = 0})
    end
}

SMODS.Joker { -- Talking Baby Podcast
    key = "necromancer",
    config = {extra = {consumeable_array = {}, totalarraynumber = 0}},
    loc_txt = {
        ['name'] = 'Necromancer',
        ['text'] = {
            [1] = 'Tracks every consumable used',
            [2] = 'Creates a {C:dark_edition}Negative{} copy of each',
            [3] = "after being sold"
        },
        ['unlock'] = {[1] = ''}
    },
    pos = {x = 6, y = 6},

    cost = 6,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = {["howie_jokers"] = true},
    loc_vars = function(self, info_queue, card)

        return {vars = {card.ability.extra.mult}}
    end,

    calculate = function(self, card, context)

        if context.using_consumeable then
            card.ability.extra.totalarraynumber = card.ability.extra.totalarraynumber + 1
            card.ability.extra.consumeable_array[card.ability.extra.totalarraynumber] =
                context.consumeable

        end
        if context.selling_self then
            for i = 1, #card.ability.extra.consumeable_array do

                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        SMODS.add_card {
                            set = card.ability.extra.consumeable_array[i].config
                                .center.set,
                            edition = "e_negative",
                            key = card.ability.extra.consumeable_array[i].config
                                .center.key,
                            key_append = 'howie_necromancer' -- Optional, useful for manipulating the random seed and checking the source of the creation in `in_pool`.
                        }
                        G.GAME.consumeable_buffer = 0
                        return true
                    end)
                }))
            end
            return {message = "Revived!"}
        end
    end

}

SMODS.Joker { -- New Joker
    key = "smartpatrick",
    config = {extra = {totalhandsContained = 0}},
    loc_txt = {
        ['name'] = 'Smart Patrick',
        ['text'] = {
            [1] = 'Retrigger all played cards ',
            [2] = 'for every unique {C:attention}poker hand{} ',
            [3] = 'in played hand'
        },
        ['unlock'] = {[1] = 'Unlocked by default.'}
    },
    pos = {x = 8, y = 6},
    display_size = {w = 71 * 1, h = 95 * 1},
    cost = 10,
    rarity = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    -- pools = { ["modprefix_mycustom_jokers"] = true },

    calculate = function(self, card, context)
       
        if context.repetition and context.cardarea == G.play then
            card.ability.extra.totalhandsContained = 0
              if next(context.poker_hands["High Card"]) then
                card.ability.extra.totalhandsContained = card.ability.extra
                                                        .totalhandsContained + 1
            end
            if next(context.poker_hands["Pair"]) then
                card.ability.extra.totalhandsContained = card.ability.extra
                                                        .totalhandsContained + 1
            end
            if next(context.poker_hands["Three of a Kind"]) then
                card.ability.extra.totalhandsContained = card.ability.extra
                                                        .totalhandsContained + 1
            end
            if next(context.poker_hands["Four of a Kind"]) then
                card.ability.extra.totalhandsContained = card.ability.extra
                                                        .totalhandsContained + 1
            end
            if next(context.poker_hands["Five of a Kind"]) then
                card.ability.extra.totalhandsContained = card.ability.extra
                                                        .totalhandsContained + 1
            end
           
            if next(context.poker_hands["Flush Five"]) then
                card.ability.extra.totalhandsContained = card.ability.extra
                                                        .totalhandsContained + 1
            end
            if next(context.poker_hands["Two Pair"]) then
                card.ability.extra.totalhandsContained = card.ability.extra
                                                        .totalhandsContained + 1
            end
            if next(context.poker_hands["Full House"]) then
                card.ability.extra.totalhandsContained = card.ability.extra
                                                        .totalhandsContained + 1
            end
            if next(context.poker_hands["Flush"]) then
                card.ability.extra.totalhandsContained = card.ability.extra
                                                        .totalhandsContained + 1
            end
            if next(context.poker_hands["Straight"]) then
                card.ability.extra.totalhandsContained = card.ability.extra
                                                        .totalhandsContained + 1
            end
            if next(context.poker_hands["Straight Flush"]) then
                card.ability.extra.totalhandsContained = card.ability.extra
                                                        .totalhandsContained + 1
            end
            if next(context.poker_hands["Flush House"]) then
                card.ability.extra.totalhandsContained = card.ability.extra
                                                        .totalhandsContained + 1
            end
            if next(context.poker_hands["howie_Bulwark"]) then
                card.ability.extra.totalhandsContained = card.ability.extra
                                                        .totalhandsContained + 1
            end
            print( card.ability.extra.totalhandsContained)
            return {repetitions = card.ability.extra.totalhandsContained}
        end
    end
}

SMODS.Joker { -- Shaquille oneal
    key = "shaquilleoneal",
    config = {extra = {totalrespect = 0,creates = 1}},
    loc_txt = {
        ['name'] = "Shaquille O'Neal",
        ['text'] = {
            [1] = 'When {C:attention}Blind{} is selected',
            [2] = 'Create a {C:hearts}Barbecue Chicken{}',
            [3] = "{C:inactive}(Must have room){}"
        },
        ['unlock'] = {[1] = 'Unlocked by default.'}
    },
    pos = {x = 1, y = 5},
    display_size = {w = 71 * 1, h = 95 * 1},
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = {["howie_jokers"] = true},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.j_howie_chicken
    end,
    calculate = function(self, card, context)
           if context.setting_blind and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
            --[[]]
            --print()
           
           

  
-- find the subscriber count text
--print("meow:", tostring(https.request("https://www.youtube.com/@the2ndbananalol")))
--https.asyncRequest("https://www.youtube.com/@the2ndbananalol",print)
--print("Subscriber count:", https.asyncRequest("https://www.youtube.com/@the2ndbananalol",print):match("subscribers"))
--[[
if not https.request("https://www.youtube.com/@the2ndbananalol") == 200 then
    local subs = https.request("https://www.youtube.com/@the2ndbananalol"):match('"subscriberCountText".-"text":"(.-)"')
  print("Subscriber count:", subs)
else
    if not https.request("https://www.youtube.com/@the2ndbananalol") == 200 then
    local subs = 
  print("Subscriber count:", https.request("https://www.youtube.com/@the2ndbananalol"):match('"subscriberCountText".-"text":"(.-)"'))
    else
        
  print("Subscriber count:", https.request("https://www.youtube.com/@the2ndbananalol"):match('"subscriberCountText".-"text":"(.-)"'))
    end
end
--]]


         play_sound("howie_chicken",1,1.4)
            local jokers_to_create = math.min(card.ability.extra.creates,
                G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
            G.GAME.joker_buffer = G.GAME.joker_buffer + jokers_to_create
            G.E_MANAGER:add_event(Event({
                func = function()
                    for _ = 1, jokers_to_create do
                        SMODS.add_card {
                            set = 'Joker',
                            key = 'j_howie_chicken',
                            key_append = 'howie_shaq' -- Optional, useful for manipulating the random seed and checking the source of the creation in `in_pool`.
                        }
                        G.GAME.joker_buffer = 0
                    end
                    return true
                end
            }))
            return {
                message = localize('k_plus_joker'),
                colour = G.C.BLUE,
            }
        end
    end,
}
SMODS.Joker { -- Barbecue Chicken
    key = "chicken",
    config = {extra = {mult = 8}},
    loc_txt = {
        ['name'] = 'Barbecue Chicken',
        ['text'] = {[1] = '{C:red}+#1#{} Mult'},
        ['unlock'] = {[1] = 'Unlocked by default.'}
    },
    pos = {x = 2, y = 5},
    display_size = {w = 71 * 1, h = 95 * 1},
    cost = 0,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    no_collection = true,
    -- pools = { ["modprefix_mycustom_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.mult}}
    end,
    in_pool = function(self, args)
        return (not args or args.source ~= 'sho' and args.source ~= 'buf' and
                   args.source ~= 'jud' or args.source == 'rif' or args.source ==
                   'rta' or args.source == 'sou' or args.source == 'uta' or
                   args.source == 'wra') and true
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            return {mult = card.ability.extra.mult}
        end
    end
}
SMODS.Joker{ --Teto
    key = "teto",
    config = {
        extra = {
            totalmult = 0,
            multIncrease = 4
        }
    },
    loc_txt = {
        ['name'] = 'Teto',
        ['text'] = {
            [1] = 'This Baka has',
            [2] = "{C:red}+#2#{} Mult for each",
            [3] = "{C:attention}Ace{} in your {C:attention}full deck{}",
            [4] = "{C:inactive}Currently{} {C:red}+#1#{} {C:inactive}Mult{} ",
           [5] = '{C:inactive}Special effect if you{}', 
            [6] = "{C:inactive}assemble the Bakas{}",
            [7] = "{C:inactive}(Must have Room){}"
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
        y = 2
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
 pools = { ["howie_jokers"] = true },
    loc_vars = function(self, info_queue, card)
        local teto_tally = 0
         if G.playing_cards then 
         for _, playing_card in ipairs(G.playing_cards) do
                if  playing_card:get_id() == 14 then teto_tally = teto_tally + card.ability.extra.multIncrease end
            end
             card.ability.extra.totalmult = teto_tally
        end
        return {vars = {card.ability.extra.totalmult,card.ability.extra.multIncrease}}
    end,

    calculate = function(self, card, context)
        local teto_tally = 0
        if context.cardarea == G.jokers and context.joker_main  then
            
        for _, playing_card in ipairs(G.playing_cards) do
                if  playing_card:get_id() == 14 then teto_tally = teto_tally + card.ability.extra.multIncrease end
            end
            card.ability.extra.totalmult = teto_tally
                return {
                    mult = card.ability.extra.totalmult
                }
        end
       
    end
}
SMODS.Joker { -- Miku
    key = "miku",
    config = {
        extra = {
            totalchips = 9,
            baka_activate = true,
            ignore = 0,
            chipsIncrease =9
        }
    },
    loc_txt = {
        ['name'] = 'Miku',
        ['text'] = {
            [1] = 'This Baka has',
            [2] = "{C:blue}+#2#{} Chips for each",
            [3] = "{C:attention}3{} or {C:attention}9{} in your {C:attention}full deck{}",
            [4] = "{C:inactive}Currently{} {C:blue}+#1#{} {C:inactive}Chips{}",
            [5] = '{C:inactive}Special effect if you{}', 
            [6] = "{C:inactive}assemble the Bakas{}",
            [7] = "{C:inactive}(Must have Room){}"
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 6,
        y = 2
    },
    display_size = {
        w = 71,
        h = 95
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["howie_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        local miku_tally = 0
         if G.playing_cards then 
        for _, playing_card in ipairs(G.playing_cards) do
            if playing_card:get_id() == 3 or playing_card:get_id() == 9 then
                miku_tally = miku_tally + 1
            end
        end
    end
        card.ability.extra.totalchips = miku_tally * card.ability.extra.chipsIncrease
        return { vars = { card.ability.extra.totalchips,card.ability.extra.chipsIncrease } }
    end,

    calculate = function(self, card, context)
        -- Main effect: Add chips for 3s and 9s in the deck
        if context.cardarea == G.jokers and context.joker_main then
            local miku_tally = 0
            for _, playing_card in ipairs(G.playing_cards) do
                if playing_card:get_id() == 3 or playing_card:get_id() == 9 then
                    miku_tally = miku_tally + 1
                end
            end
            card.ability.extra.totalchips = miku_tally * card.ability.extra.chipsIncrease
            return {
                chips = card.ability.extra.totalchips
            }
        end

        -- Combo check for special "Baka Activate" condition
        if context.ending_shop and not context.blueprint then
            local has_teto = false
            local has_neru = false

            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].config.center.key == "j_howie_teto" then
                    has_teto = true
                elseif G.jokers.cards[i].config.center.key == "j_howie_neru" then
                    has_neru = true
                end
            end

            if has_teto and has_neru and #G.jokers.cards < G.jokers.config.card_limit
     then
                 card.ability.extra.baka_activate = false
                G.GAME.pool_flags.howie_baka_activate = true
                return {
                    message = "baka_activate",
                    extra = {
                        func = function()
                            local created_joker = true
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    local joker_card = SMODS.add_card({
                                        set = 'Joker',
                                        key = 'j_howie_triplebaka'
                                    })
                                    return true
                                end
                            }))

                            if created_joker then
                                card_eval_status_text(
                                    context.blueprint_card or card,
                                    'extra',
                                    nil, nil, nil,
                                    { message = localize('k_plus_joker'), colour = G.C.BLUE }
                                )
                            end
                            return true
                        end
                    }
                }
            end
        end
    end
}
SMODS.Joker{ --Neru
    key = "neru",
    config = {
        extra = {
            neruCash = 0,
            dollars = 8,
            totalscored = 3
        }
    },
    loc_txt = {
        ['name'] = 'Neru',
        ['text'] = {
            [1] = 'After {C:attention}#1#{} played',
            [2] = "{C:attention}Jacks{} are scored",
            [3] = 'earn {C:money}#2#${} at', 
            [4] = "end of round",
           [5] = '{C:inactive}Special effect if you{}', 
            [6] = "{C:inactive}assemble the Bakas{}",
            [7] = "{C:inactive}(Must have Room){}"
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 7,
        y = 2
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
     loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.totalscored,card.ability.extra.dollars } }
    end,
 pools = { ["howie_jokers"] = true },
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if context.other_card:get_id() == 11 then
                card.ability.extra.neruCash = (card.ability.extra.neruCash) + 1
            end
        end
         if context.starting_shop then
            card.ability.extra.neruCash = 0
    end
        
    end,
   
    calc_dollar_bonus = function(self, card)
        if card.ability.extra.neruCash >= 3 then
        return card.ability.extra.dollars
        end
    end

}
SMODS.Joker{ --Triple Baka
    key = "triplebaka",
    config = {
        extra = {
            mult = 2.5,
            chips = 2.5,
            IsRightMost = 0,
            dollars = 2,
            multIncrease = .4
        }
    },
    loc_txt = {
        ['name'] = 'Triple Baka',
        ['text'] = {
           
            [1] = '{C:attention}Triples{} the number ',
            [2] = 'of every baka ',
            [3] = 'at end of round'
           -- [3] = 'Each played {C:attention}Jack{} earns {C:money}$2{} when scored',
           -- [4] = '{C:inactive}(Currently {] {X:blue,C:white}#2#x{}{C:inactive} Chips and {}{X:red,C:white}#1#x {} {C:inactive}Mult){}',
            --[5] = '{}{C:inactive}Move to rightmost to disable music{}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 5,
        y = 2
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 20,
    rarity = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = false,
    discovered = false,
    atlas = 'CustomJokers',
    in_pool = function(self, args)
          return (
          not args 
          or args.source ~= 'sho' and args.source ~= 'buf' and args.source ~= 'jud' and args.source ~= 'rif' 
          or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
          )
          and true
      end,
 --pools = { ["howie_jokers"] = true },
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.mult, card.ability.extra.chips, card.ability.extra.multIncrease}}
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval then
            
        for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].config.center.key == "j_howie_teto" then
                   G.jokers.cards[i].ability.extra.multIncrease = G.jokers.cards[i].ability.extra.multIncrease * 3
                elseif G.jokers.cards[i].config.center.key == "j_howie_neru" then
                    G.jokers.cards[i].ability.extra.dollars = G.jokers.cards[i].ability.extra.dollars * 3
                elseif G.jokers.cards[i].config.center.key == "j_howie_miku" then
                      G.jokers.cards[i].ability.extra.chipsIncrease = G.jokers.cards[i].ability.extra.chipsIncrease * 3
                end
            end
            
        end
        --[[
        if context.individual and context.cardarea == G.play  and not context.blueprint then
            if ( context.other_card:get_id() == 14) then
                card.ability.extra.mult = (card.ability.extra.mult) + card.ability.extra.multIncrease
                return {
                message = localize('k_upgrade_ex'),
                colour = G.C.MULT,
                message_card = card
            }
            elseif (context.other_card:get_id() == 3 or context.other_card:get_id() == 9) then
                card.ability.extra.chips = (card.ability.extra.chips) + 0.1
                return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS,
                message_card = card
            }
            elseif context.other_card:get_id() == 11 then
                return {
                    dollars = card.ability.extra.dollars
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    x_chips = card.ability.extra.chips,
                    extra = {
                        Xmult = card.ability.extra.mult
                        }
                }
        end
       --]]
    end
    
}

local check_for_buy_space_ref = G.FUNCS.check_for_buy_space
G.FUNCS.check_for_buy_space = function(card)
    if card.config.center.key == "j_modprefix_triplebaka" then -- ignore slot limit when bought
        return true
    end
    return check_for_buy_space_ref(card)
end
local JohnCount
local totalframeCounter = 0
    local secondCounter = 0
SMODS.Joker{ --John Beef
    key = "johnpork",
    config = {
        extra = {
            hand_change = 1,
            totalchips = 0,
            totalodds = 6000,
            chipsGain = 30
        }
    },
    loc_txt = {
        ['name'] = 'John Pork',
        ['text'] = {
            [1] = 'This Joker gains {C:blue}+#2#{} Chips',
            [2] = 'when each played',
            [3] = '{C:attention}odd{} rank card is scored',
            [4] = '{C:inactive}(Currently{}{C:blue} +#1#{} {C:inactive}Chips){}',
            [5] = '{C:hearts}Resets when he calls you{}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 0,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.totalchips, card.ability.extra.chipsGain }}
    end,
 update = function(self,card,front)
  
  
 if SMODS.pseudorandom_probability(card, 'group_0_6cb3d782', 1, card.ability.extra.totalodds, 'j_howie_johnpork') then
                    JohnCount = 300
                    play_sound('howie_JohnCall')
                    card.ability.extra.totalchips = 0
                   
				end
                
                end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.blueprint  then
            if (context.other_card:get_id() == 13 or context.other_card:get_id() == 3 or 
                context.other_card:get_id() == 5 or context.other_card:get_id() == 7 or 
                context.other_card:get_id() == 9) then
                card.ability.extra.totalchips = card.ability.extra.totalchips + card.ability.extra.chipsGain
                return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS,
                message_card = card
            }
            end
        end
        if context.cardarea == G.jokers and context.joker_main then
            return {
                chips = card.ability.extra.totalchips
            }
        end
    end,
   
 
}
local drawhook = love.draw
function love.draw()
    drawhook()
  local  function loadThatFuckingImage(fn)
        local full_path = (howie.path .. fn)
        local file_data = assert(NFS.newFileData(full_path), ("Epic fail"))
        local tempimagedata = assert(love.image.newImageData(file_data), ("Epic fail 2"))
        return (assert(love.graphics.newImage(tempimagedata), ("Epic fail 3")))
    end
    local _xscale = 2*love.graphics.getWidth()/1920
    local _yscale = 2*love.graphics.getHeight()/1080
    if JohnCount and (JohnCount > 0) then
        if howie.JohnBeef == nil then 
            howie.JohnBeef = loadThatFuckingImage("JohnCalling.png") 
        end
        love.graphics.setColor(1, 1, 1, 1) 
        love.graphics.draw(howie.JohnBeef, 0*_xscale, 0*_yscale, 0, _xscale*.5, _yscale*.5)
        JohnCount = JohnCount - 1   
    end
end
local steveCount
SMODS.Joker { -- Steve Beef
    key = "stevebeef",
    config = {extra = {hand_change = 1, totalmult = 0, totalodds = 6000, multGain = 4}},
    loc_txt = {
        ['name'] = 'Steve Beef',
        ['text'] = {
            [1] = 'This Joker gains {C:red}+#2#{} Mult',
            [2] = 'when each played ',
            [3] = '{C:attention}even{} rank card is scored',
            [4] = '{C:inactive}(Currently{}{C:red} +#1#{} {C:inactive}Mult){}',
            [5] = '{C:hearts}Resets when he calls you{}'
        },
        ['unlock'] = {[1] = ''}
    },
    pos = {x = 1, y = 2},
    display_size = {w = 71 * 1, h = 95 * 1},
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,

    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.totalmult, card.ability.extra.multGain}}
    end,
     update = function(self,card,front) --looking back and editing its so funny seeing how bad i coded it Looks
        --my ass DID NOT need to make an event
    if SMODS.pseudorandom_probability(card, 'group_0_6cb3d782', 1,
                                                  card.ability.extra.totalodds,
                                                  'j_howie_stevebeef') then
                    steveCount = 300
                    play_sound('howie_SteveCall')
                    card.ability.extra.totalmult = 0
                   
                
               
            end
        end,

        
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  and not context.blueprint  then
            if (context.other_card:get_id() == 2 or context.other_card:get_id() ==
                4 or context.other_card:get_id() == 6 or
                context.other_card:get_id() == 8 or context.other_card:get_id() ==
                10) then
                card.ability.extra.totalmult =
                    (card.ability.extra.totalmult) + card.ability.extra.multGain
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.MULT,
                    message_card = card
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main then
            return {mult = card.ability.extra.totalmult}
        end
    end,

   
}

local drawhook = love.draw
function love.draw()
    drawhook()
   local  function loadThatFuckingImage(fn)
        local full_path = (howie.path .. fn)
        local file_data = assert(NFS.newFileData(full_path), ("Epic fail"))
        local tempimagedata = assert(love.image.newImageData(file_data),
                                     ("Epic fail 2"))
        return (assert(love.graphics.newImage(tempimagedata), ("Epic fail 3")))
    end
    local _xscale = 2 * love.graphics.getWidth() / 1920
    local _yscale = 2 * love.graphics.getHeight() / 1080
    if steveCount and (steveCount > 0) then
        if howie.steveBeef == nil then
            howie.steveBeef = loadThatFuckingImage("SteveCalling.png")
        end
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(howie.steveBeef, 0 * _xscale, 0 * _yscale, 0,
                           _xscale * .5, _yscale * .5)
        steveCount = steveCount - 1
    end
end
SMODS.Joker { -- Blueprint Copy
    key = "realmoneyprint",
    config = {
        extra = {retriggers = 0, MoneyTrack = 50}
        -- immutable = { max_retriggers = 25 },
    },
    loc_txt = {
        ['name'] = 'Moneyprint',
        ['text'] = {
            [1] = 'Retriggers the {C:attention}Joker{} to its right',
            [2] = 'once for every {C:money}$#2#{} you have,',
           -- [3] = 'doubling the cost each time',
            [3] = 'Currently retriggering {C:attention}#1#{} times'
        },
        ['unlock'] = {[1] = ''}
    },
    pos = {x = 3, y = 4},
    display_size = {w = 71 * 1, h = 95 * 1},
    cost = 10,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    loc_vars = function(self, info_queue, card)
       
       
        if card.area and card.area == G.jokers then
            local other_joker
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    other_joker = G.jokers.cards[i + 1]
                end
            end
            local compatible = other_joker and other_joker ~= card and
                                   other_joker.config.center.blueprint_compat

            main_end = {
                {
                    n = G.UIT.C,
                    config = {align = "bm", minh = 0.4},
                    nodes = {
                        {
                            n = G.UIT.C,
                            config = {
                                ref_table = card,
                                align = "m",
                                colour = compatible and
                                    mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or
                                    mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8),
                                r = 0.05,
                                padding = 0.06
                            },
                            nodes = {
                                {
                                    n = G.UIT.T,
                                    config = {
                                        text = ' ' ..
                                            localize(
                                                'k_' ..
                                                    (compatible and 'compatible' or
                                                        'incompatible')) .. ' ',
                                        colour = G.C.UI.TEXT_LIGHT,
                                        scale = 0.32 * 0.8
                                    }
                                }
                            }
                        }
                    }
                }
            }
           

        end
         return {
                vars = {
                    math.floor(G.GAME.dollars / card.ability.extra.MoneyTrack),
                    card.ability.extra.MoneyTrack
                },
                main_end = main_end
            }
    end,
    pools = {["howie_jokers"] = true, ["Blueprints"] = true},

    calculate = function(self, card, context)

        local other_joker = nil
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] == card then
                other_joker = G.jokers.cards[i + 1]
            end
        end

        if context.retrigger_joker_check and not context.retrigger_joker and
            context.other_card ~= self and G.GAME.dollars >= 50 then

            -- card.ability.extra.retriggers = math.min(G.GAME.dollars/card.ability.extra.MoneyTrack)
            -- card.ability.extra.MoneyTrack = card.ability.extra.MoneyTrack * 2
        

        if context.other_card == other_joker then
            return {
                message = localize("k_again_ex"),
                repetitions = (math.floor(G.GAME.dollars /
                                              card.ability.extra.MoneyTrack)),
                card = card
            }
        else
            return nil, true
        end
        end
    end

}
--[[
calculate = function(self, card, context)
        local ret = SMODS.blueprint_effect(card, G.jokers.cards[1], context)
        if ret then
            ret.colour = G.C.RED
        end
        return ret
    end,
    --]]

SMODS.Joker {
    key = "friendprint",
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    rarity = 2,
    cost = 6,
    display_size = {w = 71 * 1, h = 95 * 1},
    config = {extra = {}},
    pos = {x = 7, y = 4},
    loc_txt = {
        ['name'] = 'Image_Friendprint',
        ['text'] = {
            [1] = 'When {C:attention}Blind{} is selected',
            [2] = 'Creates a {C:inactive}Monochrome{} copy,',
            [3] = 'of Joker to the right'
        }
    },
    pools = {["howie_jokers"] = true, ["Blueprints"] = true},
    atlas = 'CustomJokers',
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_howie_monochrome
        if card.area and card.area == G.jokers then
            local other_joker
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    other_joker = G.jokers.cards[i + 1]
                end
            end
            local compatible = other_joker and other_joker ~= card and
                                   other_joker.config.center.blueprint_compat and
                                   other_joker.config.center.key ~= "trashprint"

            main_end = {
                {
                    n = G.UIT.C,
                    config = {align = "bm", minh = 0.4},
                    nodes = {
                        {
                            n = G.UIT.C,
                            config = {
                                ref_table = card,
                                align = "m",
                                colour = compatible and
                                    mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or
                                    mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8),
                                r = 0.05,
                                padding = 0.06
                            },
                            nodes = {
                                {
                                    n = G.UIT.T,
                                    config = {
                                        text = ' ' ..
                                            localize(
                                                'k_' ..
                                                    (compatible and 'compatible' or
                                                        'incompatible')) .. ' ',
                                        colour = G.C.UI.TEXT_LIGHT,
                                        scale = 0.32 * 0.8
                                    }
                                }
                            }
                        }
                    }
                }
            }
            return {main_end = main_end}
        end
    end,
    --[[
    --for fucking with sub lol
text =  other_joker.config.center.key                                          
    --original 
    
    text = ' ' ..
                                            localize(
                                                'k_' ..
                                                    (compatible and 'compatible' or
                                                        'incompatible')) .. ' ',
                                                        ]] --
    calculate = function(self, card, context)

        local target_joker = nil

        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] == card then
                target_joker = G.jokers.cards[i + 1]
            end
            -- print("what")
        end

        if target_joker ~= nil and context.setting_blind and
            target_joker.config.center.blueprint_compat and
            not context.blueprint and target_joker.config.center.key ~=
            "trashprint" then

            -- print("meow")
            G.E_MANAGER:add_event(Event({
                func = function()
                    local copied_joker =
                        copy_card(target_joker, nil, nil, nil,
                                  target_joker.edition and
                                      target_joker.edition.negative)

                    copied_joker:add_to_deck()
                    copied_joker:set_edition('e_howie_monochrome', true)
                    G.jokers:emplace(copied_joker)

                    return true
                end
            }))
            card_eval_status_text(context.blueprint_card or card, 'extra', nil,
                                  nil, nil, {
                message = localize('k_duplicated_ex'),
                colour = G.C.GREEN
            })
            --[[
                 if target_joker.config.center.loc_txt == nil then --unfortunately doesn't work ):, cant change the name of jokers i think
                        target_joker.config.center.name = 'friend'
                    else
                          target_joker.config.center.loc_txt['name'] = 'friend'
                    end
                    --]]
        end

    end

    -- G.jokers.highlighted[1].config.center.blueprint_compat)

}
SMODS.Joker { -- Blueprint Copy
    key = "trashprint",
    config = {
        extra = {
            FirstCopyingName = 'none',
            FirstCopiedJoker = nil,
            SecondCopyingName = 'none',
            SecondCopiedJoker = nil

        }
    },
    loc_txt = {
        ['name'] = 'Trashprint',
        ['text'] = {
            [1] = 'Copies most recently sold joker',
            [2] = 'currently copying {C:attention}#1#{} and {C:attention}#2#{}'
        },
        ['unlock'] = {[1] = ''}
    },
    pos = {x = 4, y = 4},
    display_size = {w = 71 * 1, h = 95 * 1},
    cost = 10,
    rarity = 3,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.FirstCopyingName,
                card.ability.extra.SecondCopyingName
            }
        }
    end,
    pools = {["howie_jokers"] = true, ["Blueprints"] = true},
    calculate = function(self, card, context)

        if context.cardarea == G.jokers and context.selling_card then
            card.ability.extra.SecondCopiedJoker = card.ability.extra
                                                       .FirstCopiedJoker
            card.ability.extra.SecondCopyingName = card.ability.extra
                                                       .FirstCopyingName
            if context.card.config.center.blueprint_compat ~= true then
                card.ability.extra.FirstCopyingName = "Not Compatible"
                card.ability.extra.FirstCopiedJoker = nil
            else
                if context.card.config.center.loc_txt == nil then
                    card.ability.extra.FirstCopyingName = context.card.config
                                                              .center.name
                else
                    card.ability.extra.FirstCopyingName = context.card.config
                                                              .center.loc_txt['name']
                end
                card.ability.extra.FirstCopiedJoker = context.card
            end
        end

        -- print("sold card context detected")

        -- local card = c1 -- the card being sold
        -- print(context.card)
        -- print( context.card.config.center.key)

        -- print(card.ability.extra.CopiedJoker, "bark")

        local target_joker = card.ability.extra.FirstCopiedJoker
        local second_target_joker = card.ability.extra.SecondCopiedJoker
        -- print(target_joker)
        if SMODS.blueprint_effect(card, target_joker, context) then
            return SMODS.blueprint_effect(card, target_joker, context)
        end
        if SMODS.blueprint_effect(card, second_target_joker, context) then
            return SMODS.blueprint_effect(card, second_target_joker, context)
        end
    end

}
--[[
calculate = function(self, card, context)
        local ret = SMODS.blueprint_effect(card, G.jokers.cards[1], context)
        if ret then
            ret.colour = G.C.RED
        end
        return ret
    end,
    --]]
SMODS.Joker{ --Mr Uncanny
    key = "spongebomb",
    config = {
         extra = {
           totalchips =0,
           totalOtherChips = 0,
           ChipGain = 1,
           FiftyChips = 50
        }
    },
    loc_txt = {
        ['name'] = 'Spongebomb',
        ['text'] = {
            [1] = 'When {C:attention}Blind{} is defeated',
            [2] = 'gains {C:chips}+#2#{} chip for every',
            [3] = '{C:chips}#3# chips{} over the',
            [4] = '{C:attention}Blind{}\'s starting chips',
            [5] = '{C:inactive}(Currently{}{C:chips} +#1#{} {C:inactive}chips){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
   pos = {
        x = 3,
        y = 3
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 10,
    rarity = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
   -- pools = { ["howie_jokers"] = true },
   loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.totalchips,card.ability.extra.ChipGain,card.ability.extra.FiftyChips}}
    end,
    calculate = function(self, card, context)
            
         if context.cardarea == G.jokers and context.joker_main then
            return {
                chips = card.ability.extra.totalchips
            }
        end
        
        if  not context.blueprint and context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
             
             if G.GAME.chips / G.GAME.blind.chips >= to_big(1) then
                 card.ability.extra.totalOtherChips = G.GAME.chips - G.GAME.blind.chips
              card.ability.extra.totalchips = card.ability.extra.ChipGain * (card.ability.extra.totalchips + card.ability.extra.totalOtherChips/card.ability.extra.FiftyChips)
              
              return {
                message = "Upgraded!",
                colour = G.C.CHIPS,
                message_card = card
              }
            end
           
        end


    end

}

SMODS.Joker{ --strawberryelephant
    key = "spongeclock",
    config = {
        extra = {
            mult = tonumber(os.date("%H")),
            chips = tonumber(os.date("%M"))
        }
    },
    loc_txt = {
        ['name'] = 'Spongeclock',
        ['text'] = {
            [1] = 'Gives {C:red}+Mult{} according to Hour',
            [2] = 'Gives {C:blue}+Chips{} according to Minutes',
            [3] = '{C:inactive}Currently{} {C:red}+#1#{} {C:inactive}Mult and{} {C:blue}+#2#{}{C:inactive} Chips{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 5,
        y = 5
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
     pools = { ["howie_jokers"] = true },
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.mult, card.ability.extra.chips }}
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
          card.ability.extra.mult = tonumber(os.date("%H"))
          card.ability.extra.chips = tonumber(os.date("%M"))
                return {
                    mult = card.ability.extra.mult,
                    chips = card.ability.extra.chips
                }
            end
        
    end
}
SMODS.Joker{ --dscount
    key = "discount",
    config = {
        extra = {
            discount = 1,
        }
    },
    loc_txt = {
        ['name'] = 'Cards at a Cheap Price!?',
        ['text'] = {
            [1] = 'Adds a {C:attention}#1#%{} Discount to',
            [3] = 'at the end of the round',
            [2] = 'cards and packs in the shop'

        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 6,
        y = 5
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
     pools = { ["howie_jokers"] = true },
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.discount }}
    end,
    calculate = function(self, card, context)
       if context.end_of_round and context.cardarea == G.jokers then
        G.GAME.discount_percent = G.GAME.discount_percent + card.ability.extra.discount
       
            return  {
                 extra = {
                        message = "Discount Increased!"
            }
        }
       end
    end
}
SMODS.Joker{ --Golden Peter Griffin
    key = "krabs",
    config = {
        extra = {
            totalisPlayedHandFour = 0,
            dollars = 5
        }
    },
    loc_txt = {
        ['name'] = 'Eugene Krabs',
        ['text'] = {
            [1] = 'If played hand contains a {C:attention}Three of a Kind{},',
            [2] = 'gain {C:money}#1#${} for each card held in hand',
            [3] = "that has the same rank of last scored card"
        }
    },
    pos = {
        x = 9,
        y = 2
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
 pools = { ["howie_jokers"] = true },
  set_ability = function(self, card, initial)
        G.GAME.current_round.ScoredRank_card = { rank = 'Ace', id = 14 }
    end,
     loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.dollars}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round  then
            if (context.other_card:get_id() == G.GAME.current_round.ScoredRank_card.id and (card.ability.extra.isPlayedHandFour or 0) == 1) then
               -- print("meow")
                return {
                    dollars = card.ability.extra.dollars
                }
            end
        end
        if context.individual and context.cardarea == G.play  then
            if (next(context.poker_hands["Three of a Kind"]) ) then
                    G.GAME.current_round.ScoredRank_card.id = context.other_card:get_id()
                    card.ability.extra.totalisPlayedHandFour = 1
                    --print(G.GAME.current_round.ScoredRank_card.id)
                    --print( card.ability.extra.isPlayedHandFour)
            end
        end
        if context.cardarea == G.jokers and context.joker_main  then
            if not (not next(context.poker_hands["Three of a Kind"])) then
                card.ability.extra.totalisPlayedHandFour = 0
            end
        end
    end
}
SMODS.Joker { -- New Joker
    key = "gaster",
    config = {
        extra = {joker_slots = 1, start_dissolve = 0, GasterAbility = false}
    },
    loc_txt = {
        ['name'] = 'Gaster',
        ['text'] = {[1] = "wingding"},
        ['unlock'] = {[1] = 'Unlocked by default.'}
    },
    pos = {x = 0, y = 0},
    display_size = {w = 71 * 1, h = 95 * 1},
    cost = 3,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'Gaster',
    pools = {["howie_jokers"] = true},

    calculate = function(self, card, context)

        if card.ability.extra.GasterAbility and not context.blueprint then
            card.ability.extra.GasterAbility = false
            Howie.config.GasterFound = Howie.config.GasterFound + 1
            if Howie.config.GasterFound >= 3 then
                -- print("meow")
                G.GasterFound = 0

                card_eval_status_text(context.blueprint_card or card, 'extra',
                                      nil, nil, nil, {
                    message = "+" .. tostring(card.ability.extra.joker_slots) ..
                        " Joker Slot",
                    colour = G.C.DARK_EDITION
                })
                G.jokers.config.card_limit =
                    G.jokers.config.card_limit + card.ability.extra.joker_slots
            end

            card.children.center:set_sprite_pos({x = 1, y = 0})
            play_sound("howie_vanish", 1)
            -- print(Howie.config.GasterFound)

            SMODS.save_mod_config(Howie.config)
                    card:start_dissolve()
        end 

    end,
    add_to_deck = function(self, card, from_debuff)
        card.ability.extra.GasterAbility = true
    end

}

SMODS.Joker { -- New Joker
    key = "greenster",
    config = {
        extra = {
            joker_slots = 1,
            start_dissolve = 0,
            GasterAbility = false,
            GreenMax = 0,
            GreensterSeed = 0,
            RealGreenMax = 7
        }
    },
    loc_txt = {
        ['name'] = 'Greenster',
        ['text'] = {
            [1] = "{C:green,E:1,s:2}Green{} {C:green}#1#{} random",
            [2] = "playing cards in your deck"

        },
        ['unlock'] = {[1] = 'Unlocked by default.'}
    },
    pos = {x = 0, y = 0},
    display_size = {w = 71 * 1, h = 95 * 1},
    cost = 5,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    no_collection = false,
    atlas = 'Greenster',
    pools = {["howie_jokers"] = true},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.RealGreenMax}}
    end,
    calculate = function(self, card, context)

        if card.ability.extra.GasterAbility and not context.blueprint then
            card.ability.extra.GasterAbility = false

            G.E_MANAGER:add_event(Event({
                func = function()
                    for k, v in pairs(G.playing_cards) do
                        card.ability.extra.GreensterSeed = math.random(1, 10)
                        --  print(    card.ability.extra.GreensterSeed )
                        if card.ability.extra.GreensterSeed == 6 and
                            card.ability.extra.GreenMax <
                            card.ability.extra.RealGreenMax then
                            card.ability.extra.GreenMax = card.ability.extra
                                                              .GreenMax + 1
                            v:set_ability(G.P_CENTERS.m_howie_green)
                        end
                    end
                    if card.ability.extra.GreenMax <=
                        card.ability.extra.RealGreenMax then -- does it twice to prevent misses
                        for k, v in pairs(G.playing_cards) do
                            card.ability.extra.GreensterSeed =
                                math.random(1, 10)
                            --  print(    card.ability.extra.GreensterSeed )
                            if card.ability.extra.GreensterSeed == 6 and
                                card.ability.extra.GreenMax <
                                card.ability.extra.RealGreenMax then
                                card.ability.extra.GreenMax = card.ability.extra
                                                                  .GreenMax + 1
                                v:set_ability(G.P_CENTERS.m_howie_green)
                            end
                        end
                    end
                    return true
                end
            }))
            Howie.config.GasterFound = Howie.config.GasterFound + 1
            SMODS.save_mod_config(Howie.config)
            if Howie.config.GasterFound >= 3 then
                -- print("meow")
                G.GasterFound = 0

                card_eval_status_text(context.blueprint_card or card, 'extra',
                                      nil, nil, nil, {
                    message = "+" .. tostring(card.ability.extra.joker_slots) ..
                        " Joker Slot",
                    colour = G.C.DARK_EDITION
                })
                G.jokers.config.card_limit =
                    G.jokers.config.card_limit + card.ability.extra.joker_slots
                -- print()

            end

            card.children.center:set_sprite_pos({x = 1, y = 0})
            play_sound("howie_vanish", 1)
            -- print(Howie.config.GasterFound)
           SMODS.save_mod_config(Howie.config)
                    card:start_dissolve()                
        end

    end,
    add_to_deck = function(self, card, from_debuff)
        card.ability.extra.GasterAbility = true
    end

}

SMODS.Joker { -- Lancer
    key = "lancer",
    config = {extra = {totallancerPerturn = 0, var1 = 0}},
    loc_txt = {
        ['name'] = 'Lancer',
        ['text'] = {
            [1] = 'The first card',
            [2] = 'scored every turn',
            [3] = 'becomes a {C:attention}Jack of Spades{}'
        }
    },
    pos = {x = 1, y = 1},
    cost = 9,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = {["howie_jokers"] = true},
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if (card.ability.extra.totallancerPerturn or 0) == 0 then
                assert(SMODS.change_base(context.other_card, "Spades", "Jack"))
                card.ability.extra.totallancerPerturn = (card.ability.extra
                                                       .totallancerPerturn) + 1
                return {message = "Card Modified!"}
            end
        end
        if context.end_of_round and context.game_over == false and
            context.main_eval then
            return {
                func = function()
                    card.ability.extra.totallancerPerturn = 0
                    return true
                end
            }
        end
    end
}
local totalframeCounter = 0
local secondCounter = 0
local sendUpgrade = false
local legacytrue
local moderntrue
if (Howie.config["legacy_version"]) then
    legacytrue = false
    moderntrue = true
else
    legacytrue = true
    moderntrue = false
end

SMODS.Joker { -- Gerson Boom
    key = "legacygerson",
    config = {
        extra = {
            mult = 0,
            GameSpeed = 8 / G.SETTINGS.GAMESPEED, -- what the hell was i doing, nvm i realized it lol
            Scored = 0,
            IHateBalatro = false,
            IamKillingMyself = false, -- idk g.handscored was needed but like fuck off man,
            startCounting = false

        }
    },
    loc_txt = {
        ['name'] = 'Gerson Boom',
        ['text'] = {
            [1] = 'This Joker gains {C:red}+1{} Mult',
            [2] = 'for every #2# seconds that passes',
            [3] = 'while hand is scoring',
            [4] = '{C:inactive}(Currently{}{C:red} +#1#{} {C:inactive}Mult){}'
        },
        ['unlock'] = {[1] = 'Unlocked by default.'}
    },
    pos = {x = 4, y = 3},
    display_size = {w = 71 * 1, h = 95 * 1},
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = {["howie_jokers"] = true},
    no_collection = legacytrue,
    -- update function can be added here if needed, e.g.:

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.mult, card.ability.extra.GameSpeed}}
    end,

    update = function(self, card, front)
        if (Howie.config["legacy_version"]) then
            card.ability.extra.GameSpeed = 8 / G.SETTINGS.GAMESPEED
            if card.ability.extra.startCounting then
                if not card.ability.extra.IamKillingMyself then
                    if totalframeCounter <= 60 then
                        totalframeCounter = totalframeCounter + 1
                        secondCounter = secondCounter + 1

                    else
                        totalframeCounter = 0

                        print(secondCounter, card.ability.extra.GameSpeed)
                    end
                end
                if card.ability.extra.Scored ~= G.GAME.chips and
                    G.GAME.blind.chips > 0 then
                    --  print("gr")
                    card.ability.extra.Scored = G.GAME.chips
                    -- print(math.ceil(math.ceil(secondCounter/50)/card.ability.extra.GameSpeed))
                    card.ability.extra.mult =
                        card.ability.extra.mult +
                            math.ceil(
                                math.ceil(secondCounter / 50) /
                                    card.ability.extra.GameSpeed)

                    totalframeCounter = 0
                    secondCounter = 0
                    sendUpgrade = true
                    card.ability.extra.IamKillingMyself = true
                end
            end
        end
    end,
    calculate = function(self, card, context)

        if (Howie.config["legacy_version"]) then

            if context.individual and context.cardarea == G.play and
                not context.blueprint then
                -- print("hand played")
                card.ability.extra.IamKillingMyself = false -- this is for checking when a hand is played, sends it over to update
                -- print("Game Speed is "..card.ability.extra.GameSpeed) 
                -- did i finally make it work without needing an event???
            end
            if context.starting_shop or context.setting_blind then
                print(G.GAME.blind.chips)
                card.ability.extra.Scored = 0
            end
            if sendUpgrade then -- i need to make better comments lol
                sendUpgrade = false

                card.ability.extra.IamKillingMyself = true
                return {
                    extra = {
                        message = localize('k_upgrade_ex'),
                        colour = G.C.WHITE
                    }
                }
            end
            -- print("Hand Scored") 
        end

    end,
    add_to_deck = function(self, card, from_debuff)
        play_sound('howie_old')
        card.ability.extra.startCounting = true
    end,
    in_pool = function(self, args)
        if (Howie.config["legacy_version"]) then return true end
    end
}
SMODS.Joker { -- Gerson Boom
    key = "gersonboom",
    config = {
        extra = {totalmult = 0, Requiredtriggers = 5, totaltriggers = 0, multIncrease = 1}
    },
    loc_txt = {
        ['name'] = 'Gerson Boom',
        ['text'] = {
            [1] = 'Every {C:attention}#3#{} times',
            [2] = 'a card is triggered',
            [3] = 'this Joker gains {C:red}+#2#{} Mult',
            [4] = '{C:inactive}(Currently{}{C:red} +#1#{} {C:inactive}Mult){}',
            [5] = "{C:inactive,S:0.8}#4#/#3#{}"
        },
        ['unlock'] = {[1] = 'Unlocked by default.'}
    },
    pos = {x = 4, y = 3},
    display_size = {w = 71 * 1, h = 95 * 1},
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = {["howie_jokers"] = true},
    no_collection = moderntrue,
    -- update function can be added here if needed, e.g.:

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.totalmult, card.ability.extra.multIncrease,
                card.ability.extra.Requiredtriggers, card.ability.extra.totaltriggers
            }
        }
    end,

    calculate = function(self, card, context)
        if (not Howie.config["legacy_version"]) then -- this version is probably better but i like the old idk
            if context.individual and context.cardarea == G.play or
                context.post_trigger then
                card.ability.extra.totaltriggers = card.ability.extra.totaltriggers + 1
                if card.ability.extra.totaltriggers >=
                    card.ability.extra.Requiredtriggers then
                    card.ability.extra.totalmult =
                        card.ability.extra.multIncrease +
                            card.ability.extra.totalmult
                    card.ability.extra.totaltriggers = 0

                    return {message = "Upgraded!", message_card = card}
                end
            end
        end
        if context.cardarea == G.jokers and context.joker_main then

            return {mult = card.ability.extra.totalmult}
        end

    end,
    add_to_deck = function(self, card, from_debuff) play_sound('howie_old') end,
    in_pool = function(self, args)
        if (not Howie.config["legacy_version"]) then return true end
    end
}
SMODS.Joker { -- Sans Undertale
    key = "sansundertale",
    config = {extra = {sansAngry = 0, Xmult = 3}},
    loc_txt = {
        ['name'] = 'Sans Undertale',
        ['text'] = {
            [1] = 'This Comic has',
            [2] = '{X:red,C:white}X3{} Mult',
            [3] = 'if you have killed',
            [4] = '{C:attention}#1#{}/4 cards this Ante'
        }
    },
    pos = {x = 7, y = 1},
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    display_size = {w = 71 * 1, h = 95 * 1},
    atlas = 'CustomJokers',
    pools = {["howie_jokers"] = true},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.sansAngry}}
    end,

    calculate = function(self, card, context)
        if context.setting_blind then
            print(card.config.center.display_size)
            card.config.center.display_size = {w = 300 * 1, h = 300 * 1}
            card.children.center:set_sprite_pos({x = 7, y = 1})
            print(card.config.center.display_size)
        end
        if context.remove_playing_cards then
            for _, removed_card in ipairs(context.removed) do
                card.ability.extra.sansAngry =
                    (card.ability.extra.sansAngry) + 1
            end
            return {
                func = function() return true end,
                message = "You wanna have a bad time?"
            }
        end
        if context.end_of_round and context.main_eval and G.GAME.blind.boss then
            return {
                func = function()
                    card.ability.extra.sansAngry = 0
                    return true
                end,
                message = "I remember nothing, welcome to your first playthrough!"
            }
        end
        if context.cardarea == G.jokers and context.joker_main then
            if (card.ability.extra.sansAngry or 0) >= 4 then
                return {
                    Xmult = card.ability.extra.Xmult,
                    message = "Human. I remember your genocides."
                }
            end
        end
    end
}
SMODS.Joker { -- Jevil
    key = "jevil",
    config = {
        extra = {
            odds = 15,
            odds2 = 20,
            repetitions = 1,
            repetitions2 = 1,
            odds99 = 15,
            odds22 = 40,
            odds3 = 30,
            odds4 = 20,
            odds5 = 25,
            odds6 = 150,
            odds7 = 50,
            odds8 = 90,
            odds9 = 4,
            odds10 = 5,
            odds11 = 10,
            odds12 = 23,
            odds13 = 500,
            odds14 = 9,
            xchips = 1.7,
            mult = 550,
            ante_value_min = 1,
            ante_value_max = 8,
            joker_slots_min = 1,
            joker_slots_max = 4,
            joker_slots2_min = 1,
            joker_slots2_max = 3,
            chips_min = 1,
            chips_max = 75,
            Xmult_min = 1,
            Xmult_max = 3,
            mult2_min = 1,
            mult2_max = 15,
            perma_bonus_min = 1,
            perma_bonus_max = 3,
            hands_min = 1,
            hands_max = 5,
            hands2_min = 1,
            hands2_max = 5,
            discards_min = 1,
            discards_max = 5,
            discards2_min = 1,
            discards2_max = 5,
            ante_value2 = 39,
            perma_x_mult = 0
        }
    },
    loc_txt = {
        ['name'] = 'Jevil',
        ['text'] = {
            [1] = 'When a {C:attention}Wild{} card is scored,',
            [2] = 'trigger a random effect'
        }
    },
    pos = {x = 8, y = 0},
    cost = 9,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = {["howie_jokers"] = true},
    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, "m_wild") then
                -- print("green card")
                return true
            end
        end
    end,
    calculate = function(self, card, context)
        if context.destroy_card and context.destroy_card.should_destroy then
            return {remove = true}
        end
        if context.repetition and context.cardarea == G.play then
            if SMODS.get_enhancements(context.other_card)["m_wild"] == true then
                if SMODS.pseudorandom_probability(card, 'group_0_a4fdad4a', 1,
                                                  card.ability.extra.odds,
                                                  'j_howie_jevil') then
                    return {repetitions = card.ability.extra.repetitions}

                end
                if SMODS.pseudorandom_probability(card, 'group_1_32c7fea3', 1,
                                                  card.ability.extra.odds99,
                                                  'j_howie_jevil') then
                    return {repetitions = card.ability.extra.repetitions2}

                end
            end
        end

        if context.individual and context.cardarea == G.play then
            context.other_card.should_destroy = false
            if SMODS.get_enhancements(context.other_card)["m_wild"] == true then
                if SMODS.pseudorandom_probability(card, 'group_0_3c05b04c', 1,
                                                  card.ability.extra.odds,
                                                  'j_howie_jevil') then
                    SMODS.calculate_effect(
                        {x_chips = card.ability.extra.xchips}, card)
                end
                if SMODS.pseudorandom_probability(card, 'group_1_d7e17f8d', 1,
                                                  card.ability.extra.odds2,
                                                  'j_howie_jevil') then
                    SMODS.calculate_effect({mult = card.ability.extra.mult},
                                           card)
                    card_eval_status_text(context.blueprint_card or card,
                                          'extra', nil, nil, nil, {
                        message = "I can do anything!",
                        sound = "howie_anything",
                        colour = G.C.WHITE
                    })
                end
                if SMODS.pseudorandom_probability(card, 'group_2_bf2eefad', 1,
                                                  card.ability.extra.odds3,
                                                  'j_howie_jevil') then
                    local card_front = pseudorandom_element(G.P_CARDS,
                                                            pseudoseed(
                                                                'add_card_hand'))
                    local new_card = create_playing_card({
                        front = card_front,
                        center = pseudorandom_element({
                            G.P_CENTERS.m_gold, G.P_CENTERS.m_steel,
                            G.P_CENTERS.m_glass, G.P_CENTERS.m_wild,
                            G.P_CENTERS.m_mult, G.P_CENTERS.m_lucky,
                            G.P_CENTERS.m_stone
                        }, pseudoseed('add_card_hand_enhancement'))
                    }, G.discard, true, false, nil, true)
                    new_card:set_seal(pseudorandom_element({
                        "Gold", "Red", "Blue", "Purple"
                    }, pseudoseed('add_card_hand_seal')), true)
                    new_card:set_edition(
                        pseudorandom_element({
                            "e_foil", "e_holo", "e_polychrome", "e_negative"
                        }, pseudoseed('add_card_hand_edition')), true)

                    G.playing_card = (G.playing_card and G.playing_card + 1) or
                                         1
                    new_card.playing_card = G.playing_card
                    table.insert(G.playing_cards, new_card)

                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.hand:emplace(new_card)
                            new_card:start_materialize()
                            return true
                        end
                    }))
                    card_eval_status_text(context.blueprint_card or card,
                                          'extra', nil, nil, nil, {
                        message = "I can do anything!",
                        sound = "howie_anything",
                        colour = G.C.GREEN
                    })
                end
                if SMODS.pseudorandom_probability(card, 'group_3_b66c60bf', 1,
                                                  card.ability.extra.odds4,
                                                  'j_howie_jevil') then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local selected_tag =
                                pseudorandom_element(G.P_TAGS,
                                                     pseudoseed("create_tag")).key
                            local tag = Tag(selected_tag)
                            if tag.name == "Orbital Tag" then
                                local _poker_hands = {}
                                for k, v in pairs(G.GAME.hands) do
                                    if v.visible then
                                        _poker_hands[#_poker_hands + 1] = k
                                    end
                                end
                                tag.ability.orbital_hand =
                                    pseudorandom_element(_poker_hands,
                                                         "jokerforge_orbital")
                            end
                            tag:set_ability()
                            add_tag(tag)
                            play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                            return true
                        end
                    }))
                    card_eval_status_text(context.blueprint_card or card,
                                          'extra', nil, nil, nil, {
                        message = "I can do anything!",
                        sound = "howie_anything",
                        colour = G.C.GREEN
                    })
                end
                if SMODS.pseudorandom_probability(card, 'group_4_8f17ea79', 1,
                                                  card.ability.extra.odds5,
                                                  'j_howie_jevil') then
                    local created_consumable = true
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local random_sets = {'Tarot', 'Planet', 'Spectral'}
                            local random_set =
                                random_sets[math.random(1, #random_sets)]
                            SMODS.add_card {
                                set = random_set,
                                edition = 'e_negative',
                                key_append = 'joker_forge_' ..
                                    random_set:lower()
                            }
                            return true
                        end
                    }))
                    card_eval_status_text(context.blueprint_card or card,
                                          'extra', nil, nil, nil, {
                        message = "I can do anything!",
                        sound = "howie_anything",
                        colour = G.C.PURPLE
                    })
                end
                if SMODS.pseudorandom_probability(card, 'group_5_65d571c6', 1,
                                                  card.ability.extra.odds6,
                                                  'j_howie_jevil') then
                    SMODS.calculate_effect({
                        func = function()
                            card:start_dissolve()
                            return true
                        end
                    }, card)
                    card_eval_status_text(context.blueprint_card or card,
                                          'extra', nil, nil, nil, {
                        message = "I cant do anything.",
                        colour = G.C.RED
                    })
                end
                if SMODS.pseudorandom_probability(card, 'group_6_16ea3fab', 1,
                                                  card.ability.extra.odds7,
                                                  'j_howie_jevil') then
                    local available_jokers = {}
                    for i, joker in ipairs(G.jokers.cards) do
                        table.insert(available_jokers, joker)
                    end
                    local target_joker =
                        #available_jokers > 0 and
                            pseudorandom_element(available_jokers,
                                                 pseudoseed('copy_joker')) or
                            nil

                    if target_joker then
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                local copied_joker =
                                    copy_card(target_joker, nil, nil, nil,
                                              target_joker.edition and
                                                  target_joker.edition.negative)
                                copied_joker:set_edition("e_negative", true)

                                copied_joker:add_to_deck()
                                G.jokers:emplace(copied_joker)
                                return true
                            end
                        }))
                        card_eval_status_text(context.blueprint_card or card,
                                              'extra', nil, nil, nil, {
                            message = "I can do anything!",
                            sound = "howie_anything",
                            colour = G.C.GREEN
                        })
                    end

                end
                if SMODS.pseudorandom_probability(card, 'group_7_10b2ae78', 1,
                                                  card.ability.extra.odds8,
                                                  'j_howie_jevil') then
                    local mod = pseudorandom('ante_value_8a1158e2',
                                             card.ability.extra.ante_value_min,
                                             card.ability.extra.ante_value_max) -
                                    G.GAME.round_resets.ante
                    ease_ante(mod)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.round_resets.blind_ante = pseudorandom(
                                                                 'ante_value_8a1158e2',
                                                                 card.ability
                                                                     .extra
                                                                     .ante_value_min,
                                                                 card.ability
                                                                     .extra
                                                                     .ante_value_max)
                            return true
                        end
                    }))
                    card_eval_status_text(context.blueprint_card or card,
                                          'extra', nil, nil, nil, {
                        message = "I can do anything!",
                        sound = "howie_anything",
                        colour = G.C.FILTER
                    })
                end
                if SMODS.pseudorandom_probability(card, 'group_8_d445863f', 1,
                                                  card.ability.extra.odds7,
                                                  'j_howie_jevil') then
                    SMODS.calculate_effect({
                        func = function()
                            card_eval_status_text(
                                context.blueprint_card or card, 'extra', nil,
                                nil, nil, {
                                    message = "I can do anything!",
                                    sound = "howie_anything",
                                    colour = G.C.DARK_EDITION
                                })
                            G.jokers.config.card_limit = G.jokers.config
                                                             .card_limit +
                                                             pseudorandom(
                                                                 'joker_slots_264d5196',
                                                                 card.ability
                                                                     .extra
                                                                     .joker_slots_min,
                                                                 card.ability
                                                                     .extra
                                                                     .joker_slots_max)
                            return true
                        end
                    }, card)
                end
                if SMODS.pseudorandom_probability(card, 'group_9_11b7a219', 1,
                                                  card.ability.extra.odds7,
                                                  'j_howie_jevil') then
                    SMODS.calculate_effect({
                        func = function()
                            card_eval_status_text(
                                context.blueprint_card or card, 'extra', nil,
                                nil, nil, {
                                    message = "I can do anything!",
                                    sound = "howie_anything",
                                    colour = G.C.RED
                                })
                            G.jokers.config.card_limit = math.max(1,
                                                                  G.jokers
                                                                      .config
                                                                      .card_limit -
                                                                      pseudorandom(
                                                                          'joker_slots2_2665902d',
                                                                          card.ability
                                                                              .extra
                                                                              .joker_slots2_min,
                                                                          card.ability
                                                                              .extra
                                                                              .joker_slots2_max))
                            return true
                        end
                    }, card)
                end
                if SMODS.pseudorandom_probability(card, 'group_10_f01a9448', 1,
                                                  card.ability.extra.odds7,
                                                  'j_howie_jevil') then
                    local created_joker = true
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local joker_card = SMODS.add_card({set = 'Joker'})
                            if joker_card then
                                joker_card:set_edition("e_negative", true)

                            end

                            return true
                        end
                    }))
                    card_eval_status_text(context.blueprint_card or card,
                                          'extra', nil, nil, nil, {
                        message = "I can do anything!",
                        sound = "howie_anything",
                        colour = G.C.BLUE
                    })
                end
                if SMODS.pseudorandom_probability(card, 'group_12_514e6770', 1,
                                                  card.ability.extra.odds10,
                                                  'j_howie_jevil') then
                    SMODS.calculate_effect({
                        chips = pseudorandom('chips_bb51b517',
                                             card.ability.extra.chips_min,
                                             card.ability.extra.chips_max)
                    }, card)
                    card_eval_status_text(context.blueprint_card or card,
                                          'extra', nil, nil, nil, {
                        message = "I can do anything!",
                        sound = "howie_anything",
                        colour = G.C.CHIPS
                    })
                end
                if SMODS.pseudorandom_probability(card, 'group_13_56e434eb', 1,
                                                  card.ability.extra.odds11,
                                                  'j_howie_jevil') then
                    SMODS.calculate_effect({
                        Xmult = pseudorandom('Xmult_5030e29a',
                                             card.ability.extra.Xmult_min,
                                             card.ability.extra.Xmult_max)
                    }, card)
                    card_eval_status_text(context.blueprint_card or card,
                                          'extra', nil, nil, nil, {
                        message = "I can do anything!",
                        sound = "howie_anything",
                        colour = G.C.WHITE
                    })
                end
                if SMODS.pseudorandom_probability(card, 'group_14_b2e77897', 1,
                                                  card.ability.extra.odds9,
                                                  'j_howie_jevil') then
                    SMODS.calculate_effect({
                        mult = pseudorandom('mult2_1793e372',
                                            card.ability.extra.mult2_min,
                                            card.ability.extra.mult2_max)
                    }, card)
                    card_eval_status_text(context.blueprint_card or card,
                                          'extra', nil, nil, nil, {
                        message = "I can do anything!",
                        sound = "howie_anything",
                        colour = G.C.WHITE
                    })
                end
                if SMODS.pseudorandom_probability(card, 'group_15_43814a1c', 1,
                                                  card.ability.extra.odds4,
                                                  'j_howie_jevil') then
                    G.playing_card = (G.playing_card and G.playing_card + 1) or
                                         1
                    local copied_card = copy_card(context.other_card, nil, nil,
                                                  G.playing_card)
                    copied_card:add_to_deck()
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    G.deck:emplace(copied_card)
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
                        message = "I can do anything!",
                        sound = "howie_anything",
                        colour = G.C.GREEN
                    })
                end
                if SMODS.pseudorandom_probability(card, 'group_16_6ada6f49', 1,
                                                  card.ability.extra.odds9,
                                                  'j_howie_jevil') then
                    context.other_card.ability.perma_x_mult = context.other_card
                                                                  .ability
                                                                  .perma_x_mult or
                                                                  0
                    context.other_card.ability.perma_x_mult = context.other_card
                                                                  .ability
                                                                  .perma_x_mult +
                                                                  pseudorandom(
                                                                      'perma_bonus_df258be2',
                                                                      card.ability
                                                                          .extra
                                                                          .perma_bonus_min,
                                                                      card.ability
                                                                          .extra
                                                                          .perma_bonus_max)
                    SMODS.calculate_effect({
                        extra = {
                            message = localize('k_upgrade_ex'),
                            colour = G.C.CHIPS
                        },
                        card = card
                    }, card)
                    card_eval_status_text(context.blueprint_card or card,
                                          'extra', nil, nil, nil, {
                        message = "I can do anything!",
                        sound = "howie_anything",
                        colour = G.C.CHIPS
                    })
                end
                if SMODS.pseudorandom_probability(card, 'group_17_3339c0cd', 1,
                                                  card.ability.extra.odds12,
                                                  'j_howie_jevil') then
                    local target_cards = {}
                    for i, consumable in ipairs(G.consumeables.cards) do
                        table.insert(target_cards, consumable)
                    end
                    if #target_cards > 0 then
                        local card_to_destroy =
                            pseudorandom_element(target_cards, pseudoseed(
                                                     'destroy_consumable'))
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                card_to_destroy:start_dissolve()
                                return true
                            end
                        }))
                        card_eval_status_text(context.blueprint_card or card,
                                              'extra', nil, nil, nil, {
                            message = "I can do anything!",
                            sound = "howie_anything",
                            colour = G.C.RED
                        })
                    end

                end
                if SMODS.pseudorandom_probability(card, 'group_18_231e4712', 1,
                                                  card.ability.extra.odds4,
                                                  'j_howie_jevil') then
                    SMODS.calculate_effect({
                        func = function()
                            card_eval_status_text(
                                context.blueprint_card or card, 'extra', nil,
                                nil, nil, {
                                    message = "I can do anything!",
                                    sound = "howie_anything",
                                    colour = G.C.GREEN
                                })

                            G.GAME.round_resets.hands = G.GAME.round_resets
                                                            .hands +
                                                            pseudorandom(
                                                                'hands_1b102bb0',
                                                                card.ability
                                                                    .extra
                                                                    .hands_min,
                                                                card.ability
                                                                    .extra
                                                                    .hands_max)
                            ease_hands_played(
                                pseudorandom('hands_1b102bb0',
                                             card.ability.extra.hands_min,
                                             card.ability.extra.hands_max))

                            return true
                        end
                    }, card)
                end
                if SMODS.pseudorandom_probability(card, 'group_19_c565e22d', 1,
                                                  card.ability.extra.odds5,
                                                  'j_howie_jevil') then
                    SMODS.calculate_effect({
                        func = function()
                            card_eval_status_text(
                                context.blueprint_card or card, 'extra', nil,
                                nil, nil, {
                                    message = "I can do anything!",
                                    sound = "howie_anything",
                                    colour = G.C.RED
                                })

                            G.GAME.round_resets.hands = G.GAME.round_resets
                                                            .hands -
                                                            pseudorandom(
                                                                'hands2_50908d2d',
                                                                card.ability
                                                                    .extra
                                                                    .hands2_min,
                                                                card.ability
                                                                    .extra
                                                                    .hands2_max)
                            ease_hands_played(
                                -pseudorandom('hands2_50908d2d',
                                              card.ability.extra.hands2_min,
                                              card.ability.extra.hands2_max))

                            return true
                        end
                    }, card)
                end
                if SMODS.pseudorandom_probability(card, 'group_20_f5209f8e', 1,
                                                  card.ability.extra.odds4,
                                                  'j_howie_jevil') then
                    SMODS.calculate_effect({
                        func = function()
                            card_eval_status_text(
                                context.blueprint_card or card, 'extra', nil,
                                nil, nil, {
                                    message = "I can do anything!",
                                    sound = "howie_anything",
                                    colour = G.C.ORANGE
                                })

                            G.GAME.round_resets.discards = G.GAME.round_resets
                                                               .discards +
                                                               pseudorandom(
                                                                   'discards_47498564',
                                                                   card.ability
                                                                       .extra
                                                                       .discards_min,
                                                                   card.ability
                                                                       .extra
                                                                       .discards_max)
                            ease_discard(
                                pseudorandom('discards_47498564',
                                             card.ability.extra.discards_min,
                                             card.ability.extra.discards_max))

                            return true
                        end
                    }, card)
                end
                if SMODS.pseudorandom_probability(card, 'group_21_1c0ffc06', 1,
                                                  card.ability.extra.odds5,
                                                  'j_howie_jevil') then
                    SMODS.calculate_effect({
                        func = function()
                            card_eval_status_text(
                                context.blueprint_card or card, 'extra', nil,
                                nil, nil, {
                                    message = "I can do anything!",
                                    sound = "howie_anything",
                                    colour = G.C.RED
                                })

                            G.GAME.round_resets.discards = G.GAME.round_resets
                                                               .discards -
                                                               pseudorandom(
                                                                   'discards2_6b5979f1',
                                                                   card.ability
                                                                       .extra
                                                                       .discards2_min,
                                                                   card.ability
                                                                       .extra
                                                                       .discards2_max)
                            ease_discard(
                                -pseudorandom('discards2_6b5979f1',
                                              card.ability.extra.discards2_min,
                                              card.ability.extra.discards2_max))

                            return true
                        end
                    }, card)
                end
                if SMODS.pseudorandom_probability(card, 'group_22_bcfb7127', 1,
                                                  card.ability.extra.odds3,
                                                  'j_howie_jevil') then
                    context.other_card.should_destroy = true
                    card_eval_status_text(context.blueprint_card or card,
                                          'extra', nil, nil, nil, {
                        message = "I cant do anything.",
                        colour = G.C.RED
                    })
                end
                if SMODS.pseudorandom_probability(card, 'group_23_20f7e5ab', 1,
                                                  card.ability.extra.odds13,
                                                  'j_howie_jevil') then
                    local mod = card.ability.extra.ante_value2 -
                                    G.GAME.round_resets.ante
                    ease_ante(mod)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.round_resets.blind_ante = card.ability.extra
                                                                 .ante_value2
                            return true
                        end
                    }))
                    card_eval_status_text(context.blueprint_card or card,
                                          'extra', nil, nil, nil, {
                        message = "I can do anything!",
                        sound = "howie_anything",
                        colour = G.C.FILTER
                    })
                end
                if SMODS.pseudorandom_probability(card, 'group_24_c5f8a942', 1,
                                                  card.ability.extra.odds14,
                                                  'j_howie_jevil') then
                    if G.GAME.blind and G.GAME.blind.boss and
                        not G.GAME.blind.disabled then
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                G.GAME.blind:disable()
                                play_sound('timpani')
                                return true
                            end
                        }))
                        card_eval_status_text(context.blueprint_card or card,
                                              'extra', nil, nil, nil, {
                            message = "I can do anything!",
                            sound = "howie_anything",
                            colour = G.C.GREEN
                        })
                    end

                end
                if SMODS.pseudorandom_probability(card, 'group_25_bdb66b63', 1,
                                                  card.ability.extra.odds4,
                                                  'j_howie_jevil') then
                    SMODS.calculate_effect({balance = true}, card)
                    card_eval_status_text(context.blueprint_card or card,
                                          'extra', nil, nil, nil, {
                        message = "I can do anything!",
                        sound = "howie_anything",
                        colour = G.C.PURPLE
                    })
                end
                if SMODS.pseudorandom_probability(card, 'group_26_7ece770c', 1,
                                                  card.ability.extra.odds3,
                                                  'j_howie_jevil') then
                    assert(SMODS.change_base(context.other_card, "Hearts", nil))
                    context.other_card:set_edition("e_negative", true)
                    card_eval_status_text(context.blueprint_card or card,
                                          'extra', nil, nil, nil, {
                        message = "I can do anything!",
                        sound = "howie_anything",
                        colour = G.C.BLUE
                    })
                end
                if SMODS.pseudorandom_probability(card, 'group_27_bbf36e7e', 1,
                                                  card.ability.extra.odds11,
                                                  'j_howie_jevil') then
                    context.other_card:set_seal("Gold", true)
                    card_eval_status_text(context.blueprint_card or card,
                                          'extra', nil, nil, nil, {
                        message = "I can do anything!",
                        sound = "howie_anything",
                        colour = G.C.BLUE
                    })
                end
                if SMODS.pseudorandom_probability(card, 'group_28_b398d49c', 1,
                                                  card.ability.extra.odds11,
                                                  'j_howie_jevil') then
                    context.other_card:set_seal("Blue", true)
                    card_eval_status_text(context.blueprint_card or card,
                                          'extra', nil, nil, nil, {
                        message = "Card Modified!",
                        colour = G.C.BLUE
                    })
                end
                if SMODS.pseudorandom_probability(card, 'group_29_88faf7bf', 1,
                                                  card.ability.extra.odds11,
                                                  'j_howie_jevil') then
                    context.other_card:set_seal("Purple", true)
                    card_eval_status_text(context.blueprint_card or card,
                                          'extra', nil, nil, nil, {
                        message = "I can do anything!",
                        sound = "howie_anything",
                        colour = G.C.BLUE
                    })
                end
                if SMODS.pseudorandom_probability(card, 'group_30_2f451c92', 1,
                                                  card.ability.extra.odds11,
                                                  'j_howie_jevil') then
                    context.other_card:set_seal("Red", true)
                    card_eval_status_text(context.blueprint_card or card,
                                          'extra', nil, nil, nil, {
                        message = "I can do anything!",
                        sound = "howie_anything",
                        colour = G.C.BLUE
                    })
                end
            end
        end
        if context.buying_card and context.card.config.center.key == self.key and
            context.cardarea == G.jokers then
            return {message = "Chaos Chaos"}
        end
        if context.selling_self then return {message = "Bye Bye!"} end
    end
}
SMODS.Atlas({
    key = "PlueyAtlas",
    path = "pluey.png",
    px = 62,
    py = 59,
    atlas_table = "ASSET_ATLAS"
}):register()
-- yes pluey deserves to be animated
SMODS.Joker { -- Pluey
    key = "pluey",
    config = {extra = {currentscoringchips = 0, currentX = 0}},
    loc_txt = {
        ['name'] = 'Pluey',
        ['text'] = {
            [1] = 'Converts all {C:chips}Chips{}',
            [2] = 'except one',
            [3] = 'into double the {C:mult}Mult{}'
        },
        ['unlock'] = {[1] = 'Unlocked by default.'}
    },
    pos = {x = 0, y = 0},
    display_size = {w = 71 / (71 / 62), h = 95 / (95 / 59)},
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'PlueyAtlas',
    -- pools = { ["modprefix_mycustom_jokers"] = true },
    pools = {["howie_jokers"] = true},
    update = function(self, card, dt)
        if card.ability.extra.currentX >= 8 then
            card.ability.extra.currentX = 0
        end

        card.children.center:set_sprite_pos({
            x = math.floor(card.ability.extra.currentX),
            y = 0
        })

        card.ability.extra.currentX = card.ability.extra.currentX + .1

    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            return {chips = 1 - hand_chips, extra = {mult = 2 * hand_chips}}
        end
    end
}
SMODS.Joker{ --Sans Undertale
    key = "noelle",
    config = {
        extra = {
            totalcardsSold = 0,
            limit = 30
        }
    },
    loc_txt = {
        ['name'] = 'Noelle Holiday',
        ['text'] = {
            [1] = 'Makes {C:legendary}The Soul{}',
            [2] = 'after {C:attention}#2#{} cards', 
            [3] = "have been sold",
            [4] = '{C:inactive}[#1# LEFT]{}',
             [5] = '{C:inactive}(Must have room){}',
             [6] =  "{S:1.1,C:red,E:2}self destructs{}",

        }
    },
    pos = {
        x = 9,
        y = 6
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = false,
    display_size = {w = 71 * 1, h = 95 * 1},
    atlas = 'CustomJokers',
 pools = { ["howie_jokers"] = true },
    loc_vars = function(self, info_queue, card)
         info_queue[#info_queue + 1] = G.P_CENTERS.c_soul
        return {vars = {card.ability.extra.limit-card.ability.extra.totalcardsSold,card.ability.extra.limit}}
    end,

    calculate = function(self, card, context)
        --uhh at some point make her change sprite depdning on value
        --just do if totalcardsSold >= (limit/5)*X 
            --also sound effects
       if context.selling_card and not context.blueprint then
        if context.card ~= card then
        card.ability.extra.totalcardsSold = card.ability.extra.totalcardsSold + 1
        if card.ability.extra.totalcardsSold == (card.ability.extra.limit/5)*1 then
            play_sound("howie_weirdjingle",1,1.5)
         card.children.center:set_sprite_pos({
            x = 0,
            y = 7
        })
    end
     
        if card.ability.extra.totalcardsSold == (card.ability.extra.limit/5)*2 then
             play_sound("howie_weirdjingle",1,1.5)
         card.children.center:set_sprite_pos({
            x = 1,
            y = 7
        })
    end
     if card.ability.extra.totalcardsSold == (card.ability.extra.limit/5)*3 then
         play_sound("howie_weirdjingle",1,1.5)
         card.children.center:set_sprite_pos({
            x = 2,
            y = 7
        })
    end
    if card.ability.extra.totalcardsSold == (card.ability.extra.limit/5)*4 then
         play_sound("howie_weirdjingle",1,1.5)
         card.children.center:set_sprite_pos({
            x = 3,
            y = 7
        })
    end
        if card.ability.extra.totalcardsSold >= card.ability.extra.limit and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then 
           G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                    func = (function()
                        SMODS.add_card {
                            set = "Spectral",
                            --edition = "e_negative",
                            key = "c_soul",
                            key_append = 'howie_noelle' -- Optional, useful for manipulating the random seed and checking the source of the creation in `in_pool`.
                        }
                        G.GAME.consumeable_buffer = 0
                        return true
                    end)
                }))
                  SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = "Frozen!",
                    colour = G.C.RED
                }
       end
    end
    end
end
}
SMODS.Joker { -- Cabbit
    key = "cabbit",
    config = {extra = {odds = 8}},
    loc_txt = {
        ['name'] = 'Cabbit',
        ['text'] = {
            [1] = 'Held cards at the end of the round',
            [2] = 'gain random {C:enhanced}Enhancements{}'
        }
    },
    pos = {x = 1, y = 0},
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = {["howie_jokers"] = true},
    calculate = function(self, card, context)
        if context.cardarea == G.hand and context.end_of_round then
            if true then

                local hiCabbit = math.random(0, 8)
                if hiCabbit == 0 then
                    context.other_card:set_ability(G.P_CENTERS.m_gold)
                end
                if hiCabbit == 1 then
                    context.other_card:set_ability(G.P_CENTERS.m_lucky)
                end
                if hiCabbit == 2 then
                    context.other_card:set_ability(G.P_CENTERS.m_steel)
                end
                if hiCabbit == 3 then
                    context.other_card:set_ability(G.P_CENTERS.m_bonus)
                end
                if hiCabbit == 4 then
                    context.other_card:set_ability(G.P_CENTERS.m_lucky)
                end
                if hiCabbit == 5 then
                    context.other_card:set_ability(G.P_CENTERS.m_stone)
                end
                if hiCabbit == 6 then
                    context.other_card:set_ability(G.P_CENTERS.m_mult)
                end
                if hiCabbit == 7 then
                    context.other_card:set_ability(G.P_CENTERS.m_wild)
                end
                if hiCabbit == 8 then
                    context.other_card:set_ability(G.P_CENTERS.m_glass)
                end
            end
            return {message = "Card Modified!"}
        end
    end

}
SMODS.Joker { -- Gleek
    key = "gleek",
    config = {extra = {GleekCounter = 0, dollars = 5,max = 3 }},
    loc_txt = {
        ['name'] = 'Gleek',
        ['text'] = {
       
            [1] = 'Gain {C:money}#2#${} when you',
            [2] = "have at least {C:attention}#1#{} ",
            [3] = '{C:enhanced}Enhanced{} cards',
            [4] = "held in hand"
        }
    },
    pos = {x = 4, y = 0},
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = {["howie_jokers"] = true},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.max,card.ability.extra.dollars}}
    end,
    calculate = function(self, card, context)
        if context.after and context.cardarea == G.jokers then
            if card.ability.extra.GleekCounter >= card.ability.extra.max then
                card.ability.extra.GleekCounter = 0
                return {
                    dollars = card.ability.extra.dollars,
                    extra = {
                        func = function()
                           
                            return true
                        end,
                        colour = G.C.BLUE
                    }
                }
            end
        end
        if context.individual and context.cardarea == G.hand and
            not context.end_of_round then
            if (function()
                local enhancements = SMODS.get_enhancements(context.other_card)
                for k, v in pairs(enhancements) do
                    if v then return true end
                end
                return false
            end)() then
                return {
                    func = function()
                        card.ability.extra.GleekCounter = (card.ability.extra
                                                              .GleekCounter) + 1
                        return true
                    end
                }
            end
        end
       
     
    
    end
}
SMODS.Joker { -- Meowl
    key = "meowl",
    config = {extra = {mult = 3, perma_mult = 0}},
    loc_txt = {
        ['name'] = 'Meowl',
        ['text'] = {
            [1] = 'When an {C:enhanced}Enhanced{} card is scored',
            [2] = 'It permanently gains {C:mult}+#1#{} Mult'
        }
    },
    pos = {x = 3, y = 1},
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = {["howie_jokers"] = true},
     loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.mult}}
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if (function()
                local enhancements = SMODS.get_enhancements(context.other_card)
                for k, v in pairs(enhancements) do
                    if v then return true end
                end
                return false
            end)() then
                context.other_card.ability.perma_mult = context.other_card
                                                            .ability.perma_mult or
                                                            0
                context.other_card.ability.perma_mult = context.other_card
                                                            .ability.perma_mult +
                                                            card.ability.extra
                                                                .mult
                return {
                    extra = {
                        message = localize('k_upgrade_ex'),
                        colour = G.C.CHIPS
                    },
                    card = card
                }
            end
        end
    end
}
SMODS.Joker { -- Slungus
    key = "slungus",
    config = {extra = {}},
    loc_txt = {
        ['name'] = 'Slungus',
        ['text'] = {
            [1] = 'Each discarded {C:attention}#1#{}',
            [2] = 'card gains random {C:enhanced}Enhancements{}',
            [3] = '{s:.9}Rank changes every round{}'
        }
    },
    pos = {x = 0, y = 2},
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = {["howie_jokers"] = true},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                localize((G.GAME.current_round.slungusRank_card or {}).rank or
                             'Ace', 'ranks')
            }
        }
    end,

    set_ability = function(self, card, initial)
        G.GAME.current_round.slungusRank_card = {rank = 'Ace', id = 14}
    end,

    calculate = function(self, card, context)
        if context.discard then
            if (function()
                local rankFound = false
                for i, c in ipairs(context.full_hand) do
                    if context.other_card:get_id() ==
                        G.GAME.current_round.slungusRank_card.id then
                        rankFound = true
                        break
                    end
                end

                return rankFound
            end)() then
                return {
                    func = function()
                        local hiCabbit = math.random(0, 8)
                        if hiCabbit == 0 then
                            context.other_card:set_ability(G.P_CENTERS.m_gold)
                        end
                        if hiCabbit == 1 then
                            context.other_card:set_ability(G.P_CENTERS.m_lucky)
                        end
                        if hiCabbit == 2 then
                            context.other_card:set_ability(G.P_CENTERS.m_steel)
                        end
                        if hiCabbit == 3 then
                            context.other_card:set_ability(G.P_CENTERS.m_bonus)
                        end
                        if hiCabbit == 4 then
                            context.other_card:set_ability(G.P_CENTERS.m_lucky)
                        end
                        if hiCabbit == 5 then
                            context.other_card:set_ability(G.P_CENTERS.m_stone)
                        end
                        if hiCabbit == 6 then
                            context.other_card:set_ability(G.P_CENTERS.m_mult)
                        end
                        if hiCabbit == 7 then
                            context.other_card:set_ability(G.P_CENTERS.m_wild)
                        end
                        if hiCabbit == 8 then
                            context.other_card:set_ability(G.P_CENTERS.m_glass)
                        end
                    end,
                    message = "Card Modified!"
                }
            end
        end
        if context.end_of_round and context.game_over == false and
            context.main_eval then
            if G.playing_cards then
                local valid_slungusRank_cards = {}
                for _, v in ipairs(G.playing_cards) do
                    if not SMODS.has_no_rank(v) then
                        valid_slungusRank_cards[#valid_slungusRank_cards + 1] =
                            v
                    end
                end
                if valid_slungusRank_cards[1] then
                    local slungusRank_card =
                        pseudorandom_element(valid_slungusRank_cards,
                                             pseudoseed(
                                                 'slungusRank' ..
                                                     G.GAME.round_resets.ante))
                    G.GAME.current_round.slungusRank_card.rank =
                        slungusRank_card.base.value
                    G.GAME.current_round.slungusRank_card.id =
                        slungusRank_card.base.id
                end
            end
        end
    end
}
SMODS.Joker { -- Howie!
    key = "howie",
    config = {extra = {price = 1}},
    loc_txt = {
        ['name'] = 'Howie!',
        ['text'] = {
            [1] = 'Gains {C:money}#1#${} in ',
            [2] = '{C:attention}sell value{} when',
            [3] = 'buying a card',
            [4] = 'from the shop'
        }
    },
    pos = {x = 7, y = 0},
    cost = 3,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.price}}
    end,
    pools = {["howie_jokers"] = true},
    calculate = function(self, card, context)

        if context.buying_card then
            card.ability.extra_value = card.ability.extra_value +
                                           card.ability.extra.price
            card:set_cost()
            return {
                message = "+" .. tostring(card.ability.extra.price) ..
                    " Sell Value"
            }
        end
    end

}
SMODS.Joker { -- strawberryelephant
    key = "strawberryelephant",
    config = {extra = {mult = 15}},
    loc_txt = {
        ['name'] = 'Strawberry Elephant',
        ['text'] = {
            [3] = 'scoring {C:enhanced}Enhanced{} Card',
            [2] = 'hand contains a',
            [1] = '{C:red}+#1#{} Mult if played '
        },
        ['unlock'] = {[1] = 'Unlocked by default.'}
    },
    pos = {x = 0, y = 5},
    display_size = {w = 71 * 1, h = 95 * 1},
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = {["howie_jokers"] = true},
 loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.mult}}
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            if (function()
                local count = 0
                for _, playing_card in pairs(context.scoring_hand or {}) do
                    if next(SMODS.get_enhancements(playing_card)) then
                        count = count + 1
                    end
                end
                return count >= 1
            end)() then return {mult = card.ability.extra.mult} end
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        play_sound("howie_elephant")
        G.ElephantCount = 50
    end
}

-- Top-level: self-contained image/sheet loader and draw hook for Freddy animation
-- This code is intentionally outside the SMODS.Joker block.
do
  -- local helper: load a plain image file (defensive)
local function loadImageFileSafe(fn)
    local ok, res = pcall(function()
        local full_path = howie.path .. fn
        local file_data = assert(NFS.newFileData(full_path))
        local tempimagedata = assert(love.image.newImageData(file_data))
        return assert(love.graphics.newImage(tempimagedata))
    end)
    if ok then return res end
    return nil
end

-- local helper: load a sprite-sheet into an asset table compatible with drawThatFuckingImage
local function loadSpriteSheetLocal(file, frames, fw, fh, ft)
    if not file or not frames or not fw or not fh then return nil end
    local image = loadImageFileSafe(file)
    if not image then return nil end
    local iw, ih = image:getWidth(), image:getHeight()
    local cols = math.floor(iw / fw)
    local rows = math.floor(ih / fh)
    if cols < 1 or rows < 1 then return nil end
    local quads = {}
    local created = 0
    for ry = 0, rows - 1 do
        for cx = 0, cols - 1 do
            if created >= frames then break end
            quads[#quads + 1] = love.graphics.newQuad(cx * fw, ry * fh, fw,
                                                      fh, iw, ih)
            created = created + 1
        end
        if created >= frames then break end
    end
    local frame_time = ft or 0.08
    return {
        type = 'sheet',
        image = image,
        quads = quads,
        frame_time = frame_time,
        frames = #quads,
        fw = fw,
        fh = fh,
        start_time = love.timer.getTime()  -- NEW: Record the start time when the asset is loaded
    }
end

-- local draw helper (works standalone, doesn't require drawThatFuckingImage)
local function drawSheetAsset(asset, x, y, r, sx, sy)
    if not asset then return end
    r = r or 0
    sx = sx or 1
    sy = sy or sx
    if asset.type == 'image' then
        love.graphics.draw(asset, x, y, r, sx, sy)
        return
    end
    if asset.type == 'sheet' then
        -- MODIFIED: Use elapsed time since start_time to ensure animation starts at frame 0
        local t = love.timer.getTime() - (asset.start_time or 0)
        local idx = math.floor(t / asset.frame_time) % asset.frames + 1
        local quad = asset.quads[idx]
        love.graphics.draw(asset.image, quad, x, y, r, sx, sy)
        return
    end
    if asset.type == 'sequence' then
        -- MODIFIED: Apply the same logic for sequences (if used elsewhere)
        local t = love.timer.getTime() - (asset.start_time or 0)
        local idx = math.floor(t / asset.frame_time) % asset.frames + 1
        local img = asset.images[idx]
        love.graphics.draw(img, x, y, r, sx, sy)
        return
    end
end

-- draw hook: preserve existing love.draw then add Freddy overlay
local base_draw = love.draw
love.draw = function(...)
    base_draw(...)

    if G and G.ElephantCount and (G.ElephantCount > 0) then
        if howie.ElephantAnim == nil then
            -- Update these to match your sprite sheet
            howie.ElephantAnim = loadSpriteSheetLocal(
                                     'elephant_strip27.png', 27, 498, 281,
                                     0.08)
            if not howie.ElephantAnim then
                G.ElephantCount = nil
                return
            end
        end
        love.graphics.setColor(1, 1, 1, 1)
        drawSheetAsset(howie.ElephantAnim, 0, 0, 0, 1920 / 498, 1080 / 281)
        G.ElephantCount = G.ElephantCount - 1
        if G.ElephantCount <= 0 then G.ElephantCount = nil end
    end
end
end

SMODS.Joker { -- pibble
    key = "pibble",
    config = {
        extra = {
            chips = 75,
            Cleaned = true,
            noLoop = true,
            totalReturnMessages = -1,
            totalframeCounter = 0,
            totalframeRandom = 0,
            washBelly = false,
            totaldenominator = 5000,
            zeroChips = 0,
            washedChips = 75
        }
    },
    loc_txt = {
        ['name'] = 'Pibble',
        ['text'] = {
            [1] = '{C:blue}+#1#{} Chips',
            [2] = 'Gives {C:blue}#2#{} Chips',
            [3] = 'If Belly goes {C:attention}Unwashed{}'
        },
        ['unlock'] = {[1] = 'Unlocked by default.'}
    },
    pos = {x = 4, y = 5},
    display_size = {w = 71 * 1, h = 95 * 1},
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = {["howie_jokers"] = true},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.chips,card.ability.extra.zeroChips}}
    end,

    update = function(self, card, front)
         if card.ability.extra.chips == 0 then
             card.ability.extra.totaldenominator = 1500
         else
             card.ability.extra.totaldenominator = 3000
         end
        if  card.ability.extra.totalframeRandom  ~= 0 then
            --print(card.ability.extra.totalframeCounter)
            card.ability.extra.totalframeCounter = card.ability.extra.totalframeCounter + 1
            if  card.ability.extra.totalframeCounter ==  card.ability.extra.totalframeRandom then
                card.ability.extra.washBelly = true
            end
        end
        if SMODS.pseudorandom_probability(blind, 'j_howie_pibble', 1,  card.ability.extra.totaldenominator) then
         
            if card.ability.extra.totalframeRandom == 0 then

                card.ability.extra.totalframeRandom = math.random(90, 360)
                --rint(card.ability.extra.totalframeRandom, "random")
            end

            card.ability.extra.totalReturnMessages = 1
            -- play_sound("howie_wash",1, 1.5)
        end
         if   card.ability.extra.washBelly then
                 card.ability.extra.washBelly = false
              --  print(card.ability.extra.totalframeRandom)
                if card.ability.extra.Cleaned then
                    -- play_sound("howie_yay",1, 1.5)
                    card.ability.extra.totalReturnMessages = 2
                    card.ability.extra.chips = card.ability.extra.washedChips 
                    card.ability.extra.totalframeRandom = 0
                    card.ability.extra.totalframeCounter = 0
                    return true
                else
                    -- play_sound("howie_grr",1, 1.5)
                    card.ability.extra.totalReturnMessages = 3
                    card.ability.extra.chips = card.ability.extra.zeroChips
                    card.ability.extra.totalframeRandom = 0
                    card.ability.extra.totalframeCounter = 0
                    return true
                end
            end -- frame random end
            -- return true 
    end,
    calculate = function(self, card, context)
        if card.ability.extra.totalReturnMessages == 1 then
            card.ability.extra.totalReturnMessages = -1
            return {

                extra = {message = "Click on Pibble!", sound = "howie_wash"}
            }
        end
        if card.ability.extra.totalReturnMessages == 2 then
            card.ability.extra.totalReturnMessages = -1
            return {extra = {message = "yayy", sound = "howie_yay"}}
        end
        if card.ability.extra.totalReturnMessages == 3 then
            card.ability.extra.totalReturnMessages = -1
            return {extra = {message = "grrr", sound = "howie_grr"}}
        end
        if card.highlighted then
            -- print(card.ability.extra.noLoop)
            card.ability.extra.Cleaned = true
        end
        if not card.highlighted then card.ability.extra.Cleaned = false end
        if context.cardarea == G.jokers and context.joker_main then
            card.ability.extra.noLoop = true
            return {chips = card.ability.extra.chips}
        end
      
        end,
     add_to_deck = function(self, card, from_debuff)
            play_sound('howie_iampibble', 1 ,1,999)
      end
     
}
SMODS.Joker{ --Glorp Cloning
    key = "glorpcloning",
    config = {
        extra = {
            sell_value = 4,
            repetitions = 99,
            noLoop = true,
            discard_change = 1,
            make_cards = true
        }
    },
    loc_txt = {
        ['name'] = 'Glorp Cloning',
        ['text'] = {
            [1] = 'When this joker is bought,',
            [2] = 'add #1# random {C:attention}playing cards{}',
            [3] = 'to your deck with one having a',
            [4] = '{C:attention}Glorp Seal{}',
            [5] = '{C:red}+1{} Discard{} and {C:attention}+1{} Hand Size{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 5,
        y = 3
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["howie_jokers"] = true },
 loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.repetitions+1, } }
    end,
    calculate = function(self, card, context)
   
    if card.ability.extra.make_cards and not context.blueprint then
        card.ability.extra.make_cards = false
            if true then
                local card_front = pseudorandom_element(G.P_CARDS, pseudoseed('add_card'))
            local new_card = create_playing_card({
                front = card_front,
                center = G.P_CENTERS.m_howie_glorpseal
            }, G.discard, true, false, nil, true)
           --context.other_card:set_ability(G.P_CENTERS.m_howie_glorpseal)
              new_card:set_seal("howie_glorpseal", true)
            G.E_MANAGER:add_event(Event({
                func = function()
                    new_card:start_materialize()
                    G.play:emplace(new_card)
                    return true
                end
            }))
                return {
                    func = function()local my_pos = nil
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] == card then
                my_pos = i
                break
            end
        end
        local target_card = G.jokers.cards[my_pos]
                    return true
                end,
                    message = "Sell Value: $"..tostring(card.ability.extra.sell_value),
                    extra = {
                        func = function()
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.deck.config.card_limit = G.deck.config.card_limit + 1
                        return true
                    end
                }))
                draw_card(G.play, G.deck, 90, 'up')
                SMODS.calculate_context({ playing_card_added = true, cards = { new_card } })
            end,
                            message = "Added Card!",
                        colour = G.C.GREEN
                        }
                ,
                    func = function()
                        for i = 1, card.ability.extra.repetitions do
              local card_front = pseudorandom_element(G.P_CARDS, pseudoseed('add_card'))
            local new_card = create_playing_card({
                front = card_front,
                center = G.P_CENTERS.c_base
            }, G.discard, true, false, nil, true)
            
            G.E_MANAGER:add_event(Event({
                func = function()
                    new_card:start_materialize()
                    G.play:emplace(new_card)
                    return true
                end
            }))
                        SMODS.calculate_effect({func = function()
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.deck.config.card_limit = G.deck.config.card_limit + 1
                        return true
                    end
                }))
                draw_card(G.play, G.deck, 90, 'up')
                SMODS.calculate_context({ playing_card_added = true, cards = { new_card } })
            end}, card)
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Added Card!", colour = G.C.GREEN})
          end
                        return true
                    end
                }
            end
        end
        
    end,
   
    add_to_deck = function(self, card, from_debuff)
        G.hand:change_size(1)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.discard_change
        card.ability.extra.make_cards = true
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(-1)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.discard_change
    end
}
SMODS.Joker{ --New Joker
    key = "dogpoker",
    config = {
        extra = {
            card_draw0 = 4
        }
    },
    loc_txt = {
        ['name'] = 'Dogs Playing Poker',
        ['text'] = {
            [1] = 'Draw {C:attention}#1#{} cards to hand',
            [2] = "before scoring starts"
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 7,
        y = 6
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["howie_jokers"] = true },
     loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.card_draw0, } }
    end,
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers  then
            
                
           -- card:juice_up(0.8, 0.5)
          return{
                message = "Cards Drawn",
                SMODS.draw_cards(card.ability.extra.card_draw0)
          }
        end
    end
}
--[[
SMODS.Joker { -- Meowl
    key = "imposter",
    config = {extra = {mult = 3, perma_mult = 0}},
    loc_txt = {
        ['name'] = '#1#',
        ['text'] = {
            [1] = 'i will copy left card deez nuts',
            [2] = 'deez'
        }
    },
    pos = {x = 3, y = 1},
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = {["howie_jokers"] = true},
     loc_vars = function(self, info_queue, card)
        local name
        if card.area and card.area == G.jokers then
        local other_joker
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    other_joker = G.jokers.cards[i - 1]
                end
            end
            if  other_joker ~= nil then
             if  other_joker.config.center.loc_txt == nil then
                   name= other_joker.config
                                                              .center.name
                else
                    name = other_joker.config
                                                              .center.loc_txt['name']
                end
            end
        else
             name = "nonemmmeow"
        end
        return { vars = { name, } }
    end,
    calculate = function(self, card, context)
     if context.setting_blind then
        print(card.config.center.loc_txt['name'])
       
     end
    end
}
SMODS.Joker { -- Meowl
    key = "imposte2r",
    config = {extra = {mult = 3, perma_mult = 0}},
    loc_txt = {
        ['name'] = 'twotwoimposter',
        ['text'] = {
            [1] = 'first #1#',
            [2] = 'left joker number'
        }
    },
    pos = {x = 3, y = 1},
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = {["howie_jokers"] = true},
    loc_vars = function(self, info_queue, card)
        local output = "None"
        if card.area and card.area == G.jokers then
            local other_joker
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    other_joker = G.jokers.cards[i - 1]
                    break
                end
            end
            if other_joker and other_joker.ability and other_joker.ability.extra then
                if type(other_joker.ability.extra) == 'number' then
                    output = other_joker.ability.extra
                   other_joker.ability.extra = 10
                else
                
                local vars_list = {}
                for key, value in pairs(other_joker.ability.extra) do
                    
                    if type(value) == 'number' then
                        value = 10
                    table.insert(vars_list, value)
                    end
                end
                output = table.concat(vars_list, ", ")
            end
        end
        end
        return { vars = { output } }
    end,
    calculate = function(self, card, context)
     if context.setting_blind then
       
       
     end
    end
}
--]]
SMODS.Joker{ --New Joker
    key = "shareholders",
    config = {
        extra = {
            sellvalue = 20, bought = false
        }
    },
    loc_txt = {
        ['name'] = 'Shareholders',
        ['text'] = {
            [1] = "This Joker's Sell Value",
            [2] = "increases by {C:money}#1#${}",
            [3] = "after being bought",
             [4] = "{C:inactive}only appears if you have all joker slots filled{}"
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 7,
        y = 7
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["howie_jokers"] = true },
     loc_vars = function(self, info_queue, card)
    
        return { vars = { card.ability.extra.sellvalue } }
    end,
    calculate = function(self, card, context) 
        if not card.ability.extra.bought and not context.blueprint then
            card.ability.extra.bought = true
         card.ability.extra_value = card.ability.extra_value +
                                           card.ability.extra.sellvalue
            card:set_cost()
            return {
                message = "+" .. tostring(card.ability.extra.sellvalue) ..
                    " Sell Value"
            }
        end
    end,
     
     in_pool = function(self, args)
        if #G.jokers.cards >= G.jokers.config.card_limit  then return true end
    end
}
