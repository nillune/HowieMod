SMODS.Joker{ --Erin
    key = "erin",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Erin',
        ['text'] = {
            [1] = 'If hand does not',
            [2] = 'contain {C:attention}Three of a Kind{}',
            [3] = '{C:green,E:1,s:2}Green{}all cards'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 3
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["erin"] = true },
loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_howie_green
     end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if not (next(context.poker_hands["Three of a Kind"])) then
                context.other_card:set_ability(G.P_CENTERS.m_howie_green)
                return {
                    message = "Card Modified!"
                }
            end
        end
    end
}
SMODS.Joker{ --Drawerin
    key = "drawerin",
    config = {
        extra = {
            chips = 10,
            greenbonus = 1
        }
    },
    loc_txt = {
        ['name'] = 'Drawerin',
        ['text'] = {
            [1] = 'When a played {C:enhanced}Enhanced{}',
            [2] = 'card is scored {C:green}+#1#{}',
            [3] = 'to the {C:green,E:1,s:2}Green{} Count '
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 4
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["erin"] = true },
    loc_vars = function(self, info_queue, card)
        return{vars = {card.ability.extra.greenbonus}}
     end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if (function()
        local enhancements = SMODS.get_enhancements(context.other_card)
        for k, v in pairs(enhancements) do
            if v then
                return true
            end
        end
        return false
    end)() then
        Howie.config.GreenCount = Howie.config.GreenCount + card.ability.extra.greenbonus
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.GREEN,
                    message_card = card
                }
            end
        end
    end,
 in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card,"m_howie_green")then
                --print("green card")
                return true
            end
        end
    end
    
}
SMODS.Joker{ --Lois Griffin
    key = "halferin",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Half Erin',
        ['text'] = {
            [1] = 'Sets the amount',
            [2] = 'of {C:green,E:1,s:2}Green{} Cards',
            [3] =  'that need to',
            [4] = 'be scored to {C:attention}10{}',
        }
    },
    pos = {
        x = 2,
        y = 3
    },
    cost = 5,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    atlas = 'CustomJokers',
    pools = { ["erin"] = true },

 --meow you get the jist
 --check green code
        in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card,"m_howie_green")then
                --print("green card")
                return true
            end
        end
    end
        
    
}
SMODS.Joker{ --Lois Griffin
    key = "peterin",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Peterin',
        ['text'] = {
            [1] = '{C:green,E:1,s:2}Green{} cards count',
            [2] = 'as {C:enhanced}Family{} Cards',
            [3] =  'and level up',
            [4] = '{C:attention}Family House{} instead',
        }
    },
    pos = {
        x = 1,
        y = 3
    },
    cost = 4,
    rarity = "howie_joe",
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
  add_to_deck = function(self, card, from_debuff)
        familycardArray = {"m_howie_familycard", "m_howie_green"}
    end,

    remove_from_deck = function(self, card, from_debuff)
        familycardArray = {"m_howie_familycard", "m_howie_nothing"}
    end
    
}
if SMODS.find_card("j_howie_peterin") then
     familycardArray = {"m_howie_familycard", "m_howie_green"}
else
    familycardArray = {"m_howie_familycard", "m_howie_nothing"}
end


SMODS.Joker{ --Erinstitutor
    key = "erinstitutor",
    config = {
        extra = {
            greenBonus = 3
        }
    },
    loc_txt = {
        ['name'] = 'Erinstitutor',
        ['text'] = {
            [1] = 'When a played {C:green,E:1,s:2}Green{} card is scored',
            [2] = 'destroy it and {C:green}+#1#{}',
            [3] = 'to the {C:green,E:1,s:2}#1#{} count'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 5,
        y = 4
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["erin"] = true },
    loc_vars = function(self, info_queue, card)
        return{vars = {card.ability.extra.greenBonus}}
     end,
    calculate = function(self, card, context)
        if context.destroy_card and context.destroy_card.should_destroy  then
            return { remove = true }
        end
        if context.individual and context.cardarea == G.play  then
            context.other_card.should_destroy = false
            if SMODS.get_enhancements(context.other_card)["m_howie_green"] == true then
                context.other_card.should_destroy = true
                Howie.config.GreenCount = Howie.config.GreenCount + card.ability.extra.greenBonus
                 card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+3 Green Count!", colour = G.C.GREEN})
                return {
                    message = "Destroyed!"
                }
            end
        end
    end,
     in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card,"m_howie_green")then
                --print("green card")
                return true
            end
        end
    end
}
SMODS.Joker{ --Gros Erin
    key = "groserin",
    config = {
        extra = {
            number = 20
        }
    },
    loc_txt = {
        ['name'] = 'Gros Erin',
        ['text'] = {
            [1] = 'The Next {C:attention}#1#{} played cards',
            [2] = 'become {C:green,E:1,s:2}Green{} when scored',
            [3] = '{C:inactive}{s:.8}(If they are not already){}{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
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
   pools = { ["erin"] = true },
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.number}}
    end,

    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if  not (SMODS.get_enhancements(context.other_card)["m_howie_green"] == true and (card.ability.extra.number or 0) > 0) then
                card.ability.extra.number = math.max(0, (card.ability.extra.number) - 1)
                context.other_card:set_ability(G.P_CENTERS.m_howie_green)
                return {
                    message = "Card Modified!"
                    }
                end
            end
    if context.joker_main and (card.ability.extra.number <= 0) then
                 SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = "Peeled!"
                
                    }
            end        
        end
}
SMODS.Joker {
    key = "luigi_erin",
    blueprint_compat = true,
    rarity = 1,
    cost = 5,
    pos = { x = 2, y = 6},
    loc_txt = {
        ['name'] = 'Plumberin',
        ['text'] = {
            [1] = 'When a {V:1}#1#{} card is scored',
            [2] = '{C:attention}+#2#{} to the {C:green,E:1,s:2}Green{} count',
           
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    config = { extra = { extraCount = 2 } },
    atlas = "CustomJokers",
    loc_vars = function(self, info_queue, card)
        local suit = (G.GAME.current_round.howie_luigi_erin or {}).suit or 'Spades'
        return { vars = {localize(suit, 'suits_singular'), colours = { G.C.SUITS[suit] }, card.ability.extra.extraCount } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_suit(G.GAME.current_round.howie_luigi_erin.suit)  then
            if Howie.config.GreenCount == nil then
                Howie.config.GreenCount = 0
            end
             Howie.config.GreenCount = Howie.config.GreenCount + card.ability.extra.extraCount
                 card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+2 Green Count!", colour = G.C.GREEN})
        end
    end
}
local https = require "SMODS.https"
local function apply_sub_count(code, body, headers)
    local subcount
	if body then
		subcount = tonumber(string.match(body, "(.. )subscribers")) 
        if subcount ~= nil then
          
            Howie.config.ErinSubs= subcount
             SMODS.save_mod_config(Howie.config.ErinSubs)
        else
             Howie.config.ErinSubs = 100
             SMODS.save_mod_config(Howie.config.ErinSubs)
        end
	end
end
 local noloop= true
SMODS.Joker {
    key = "orderin",
    blueprint_compat = true,
    rarity = 4,
    cost = 10,
    pos = { x = 5, y = 7},
    loc_txt = {
        ['name'] = 'Orderin and Chaos',
        ['text'] = {
            [1] = 'When {C:green,E:1,s:2}Green{} count reaches {C:green}20{}',
            [2] = 'Level up Hand by amount of ',
            [3] = "subs {C:green,E:1,s:2}Erin{} has on youtube",
            [4] = "{C:inactive}Currently #1# Subs{}"
           
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    config = { extra = { extraCount = 2 } },
    atlas = "CustomJokers",
    loc_vars = function(self, info_queue, card)
       info_queue[#info_queue + 1] = G.P_CENTERS.j_howie_erinyoutube
        return { vars = { Howie.config.ErinSubs} }
    end,
    calculate = function(self, card, context)
       
        if Howie.config.GreenCount >= 20 and noloop then
            noloop = false 
            print("meow")
        
            local target_hand
             if next(SMODS.find_card('j_howie_peterin', false)) then
                target_hand = "howie_Bulwark"
                         else
                target_hand = "Three of a Kind"
             end
            SMODS.calculate_effect({level_up =  Howie.config.ErinSubs,
                level_up_hand = target_hand}, card)
            
        end
         if context.ending_shop then
            https.asyncRequest(
				"https://www.youtube.com/@the2ndbananalol",
				apply_sub_count
			)
            noloop = true
         end
    end
}
--- This changes vremade_ancient_card every round so every instance of Ancient Joker shares the same card.
--- You could replace this with a context.end_of_round reset instead if you want the variables to be local.
--- See SMODS.current_mod.reset_game_globals at the bottom of this file for when this function is called.
local function reset_howie_luigi_erin()
  G.GAME.current_round.howie_luigi_erin = { suit = 'Spades' }
    local valid_castle_cards = {}
    for _, playing_card in ipairs(G.playing_cards) do
        if not SMODS.has_no_suit(playing_card) then
            valid_castle_cards[#valid_castle_cards + 1] = playing_card
        end
    end
    local castle_card = pseudorandom_element(valid_castle_cards,
        'howie_luigi_erin' .. G.GAME.round_resets.ante)
    if castle_card then
        G.GAME.current_round.howie_luigi_erin.suit = castle_card.base.suit
    end
end

local function resetCounts()
    --print("meow")
 --reset_howie_luigi_erin()
	Howie.config.GasterFound = 0
    SMODS.save_mod_config(Howie.config)
	Howie.config.GreenCount = 0
    SMODS.save_mod_config(Howie.config.GreenCount)
	familycardArray = {"m_howie_familycard", "m_howie_nothing"}
     G.ILoveTV = 0
end
SMODS.current_mod.reset_game_globals = function(run_start)
    if run_start then
    resetCounts()
     if (Howie.config["unstable_features"]) then
     G.GAME.current_round.voucher = get_next_voucher_key()
     end
    end
    reset_howie_luigi_erin()
end
SMODS.Joker{ --Gros Erin
    key = "erinyoutube",
    config = {
        extra = {
            number = 20
        }
    },
    loc_txt = {
        ['name'] = "Erin's Youtube",
        ['text'] = {
            [1] = '{C:green}@the2ndbananalol{}',
            
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
        y = 5
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = "howie_curse",
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = false,
    discovered = false,
    no_collection = true,
    atlas = 'CustomJokers',
   
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.number}}
    end,

    
    calculate = function(self, card, context)
        
        end
}