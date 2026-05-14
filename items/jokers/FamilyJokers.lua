SMODS.Joker { -- Brian Griffin
    key = "briangriffin",
    config = {
        extra = {
            total = 0,
            hand_size = 1,
            start_dissolve = 0,
            ClipPlayed = Howie.config.ClipsWatched
        }
    },
    loc_txt = {
        ['name'] = 'Brian Griffin',
        ['text'] = {
            -- [1] = 'Doubles chance of playing {C:spectral}Family Guy{} Clip',
            [1] = '{C:attention}+#2# {}Hand Size when a clip is watched',
            [2] = '{C:hearts}Destroyed when ran over{}',
            [3] = '{C:Inactive}Currently{} {C:attention}+#1#{} {C:Inactive}Handsize{}'
        },
        ['unlock'] = {[1] = ''}
    },
    pos = {x = 0, y = 0},
    cost = 6,
    rarity = "howie_joe",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    in_pool = function(self, args) return not args or args.source ~= 'sho' end,
    -- pools = { ["howie_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.total,card.ability.extra.hand_size}}
    end,
    calculate = function(self, card, context)
        
        if  card.ability.extra.ClipPlayed ~= Howie.config.ClipsWatched and
            not context.blueprint then
          card.ability.extra.ClipPlayed = Howie.config.ClipsWatched
           
            card.ability.extra.total = (card.ability.extra
                                                       .total) + card.ability.extra.hand_size
            -- ClipPlayed = false
           
                    G.hand:change_size(card.ability.extra.hand_size)

                   
                
            
        end
        if context.selling_self and not context.blueprint then
            return {
                func = function()
                    card_eval_status_text(context.blueprint_card or card,
                                          'extra', nil, nil, nil, {
                        message = "-" ..
                            tostring(card.ability.extra.handSizeIncreased) ..
                            " Hand Size",
                        colour = G.C.RED
                    })
                    G.hand:change_size(-card.ability.extra.handSizeIncreased)
                    return true
                end
            }
        end
        if BrianDeath == true and not context.blueprint then
            return {
                func = function()
                    card_eval_status_text(context.blueprint_card or card,
                                          'extra', nil, nil, nil, {
                        message = "-" ..
                            tostring(card.ability.extra.handSizeIncreased) ..
                            " Hand Size",
                        colour = G.C.RED
                    })
                    G.hand:change_size(-card.ability.extra.handSizeIncreased)
                    return true
                end,
                extra = {
                    func = function()
                        card:start_dissolve()
                        BrianDeath = false
                        return true
                    end,
                    colour = G.C.RED
                }
            }
        end
    end
}
SMODS.Joker { -- Lois Griffin
    key = "loisgriffin",
    config = {extra = {}},
    loc_txt = {
        ['name'] = 'Lois Griffin',
        ['text'] = {
            [1] = 'Thirds the time you need to',
            [2] = 'spend watching {C:spectral}Family Guy Clips{}'
        }
    },
    pos = {x = 2, y = 1},
    cost = 4,
    rarity = "howie_joe",
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers'
    -- doesn't actually do anything in her own code LOL
    -- go check video code if youre checking this?????

}
SMODS.Joker { -- Bonnie Swanson
    key = "bonnieswanson",
    config = {extra = {charm = 0, Active = true, text = "Active!"}},
    loc_txt = {
        ['name'] = 'Bonnie Swanson',
        ['text'] = {
            [1] = 'When you skip any {C:attention}Booster Pack{}',
            [2] = 'watch a {C:spectral}Family Guy Clip{}',
            [3] = 'to create a free {C:attention}Charm Tag{}',
            [4] = '{C:inactive}Only works once per Shop{}',
            [5] = '{C:inactive}#1#{}'
        },
        ['unlock'] = {[1] = 'Unlocked by default.'}
    },
    pos = {x = 8, y = 3},
    display_size = {w = 71 * 1, h = 95 * 1},
    cost = 7,
    rarity = "howie_joe",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    -- pools = { ["modprefix_imposter_jokers"] = true },
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.text}}
    end,

    calculate = function(self, card, context)
        if context.skipping_booster and card.ability.extra.Active then
            card.ability.extra.Active = false
            card.ability.extra.text = "Inactive"
            return {
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            watchTV()
                            local tag = Tag("tag_charm")
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
                    return true
                end,
                message = "Created Tag!"
            }
        end
        if context.end_of_round then
           
            card.ability.extra.Active = true
            card.ability.extra.text = "Active!"
        end
    end
}
SMODS.Joker { -- Family Guy DVD 
    key = "familyguydvd",
    config = {extra = {Xmult = 4}},
    loc_txt = {
        ['name'] = 'Family Guy DVD ',
        ['text'] = {
            [1] = '{X:red,C:white}X#1#{} Mult',
            [2] = 'If this is not the',
            [3] = 'first played hand of the blind',
            [4] = 'Watch a {C:spectral}Family Guy Clip{}'
        }
    },
    pos = {x = 3, y = 0},

    cost = 6,
    rarity = "howie_joe",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.Xmult}}
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            if not (G.GAME.current_round.hands_played == 0) then
                watchTV()
                return {
                    message = "Turn on the TV!",
                    Xmult = card.ability.extra.Xmult
                }
            else
                return {Xmult = card.ability.extra.Xmult}
            end
        end
    end
}

SMODS.Joker { -- Stewie Griffin
    key = "stewiegriffin",
    config = {extra = {xmult = 1, xmult_gain = .75}},
    loc_txt = {
        ['name'] = 'Stewie Griffin',
        ['text'] = {
            [1] = 'This Joker gains {X:mult,C:white}#2#X{} Mult',
            [2] = 'when a {C:enhanced}Family Card{}',
            [3] = 'is destroyed',
            [4] = '{C:inactive}(Currently {X:mult,C:white}#1#X{C:inactive} Mult)'
        },
        ['unlock'] = {[1] = ''}
    },
    pos = {x = 2, y = 2},
    display_size = {w = 71 * 1, h = 95 * 1},
    cost = 4,
    rarity = "howie_joe",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.xmult,card.ability.extra.xmult_gain}}
    end,
    calculate = function(self, card, context)
        if context.remove_playing_cards and not context.blueprint then
            local face_cards = 0
            for _, removed_card in ipairs(context.removed) do
                 if SMODS.get_enhancements(removed_card)[familycardArray[1]] or
                SMODS.get_enhancements(removed_card)[familycardArray[2]] then face_cards = face_cards + 1 end
            end 
            if face_cards > 0 then
                -- See note about SMODS Scaling Manipulation on the wiki
                card.ability.extra.xmult = card.ability.extra.xmult + face_cards * card.ability.extra.xmult_gain
                return { message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } } }
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}
SMODS.Joker { -- Story Of Family Guy
    key = "storyoffamilyguy",
    config = {extra = {}},
    loc_txt = {
        ['name'] = 'Cleveland Orenthal Brown',
        ['text'] = {
            [1] = 'When Blind is selected',
            [2] = 'add a {C:enhanced}Family{} Card', 
            [3] = 'to your hand'
        },
        ['unlock'] = {[1] = 'Unlocked by default.'}
    },
    pos = {x = 3, y = 2},
    display_size = {w = 71 * 1, h = 95 * 1},
    cost = 5,
    rarity = "howie_joe",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    -- pools = { ["howie_jokers"] = true },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_howie_familycard
    end,

    calculate = function(self, card, context)
        if context.setting_blind then
            return {
                func = function()

                    local card_front = pseudorandom_element(G.P_CARDS,
                                                            pseudoseed(
                                                                'add_card_hand'))
                    local new_card = create_playing_card({
                        front = card_front,
                        center = G.P_CENTERS.m_howie_familycard
                    }, G.discard, true, false, nil, true)

                    G.playing_card = (G.playing_card and G.playing_card + 1) or
                                         1
                    new_card.playing_card = G.playing_card
                    table.insert(G.playing_cards, new_card)

                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.hand:emplace(new_card)
                            new_card:start_materialize()
                            SMODS.calculate_context({
                                playing_card_added = true,
                                cards = {new_card}
                            })
                            return true
                        end
                    }))
                end,
                message = "Added Card to Hand!"
            }
        end
    end
}
SMODS.Joker { -- Tom Tucker
    key = "tomtucker",
    config = {extra = {blind_size = 0.7, percent = 30 }},
    loc_txt = {
        ['name'] = 'Tom Tucker',
        ['text'] = {
            [1] = 'When {C:attention}Blind {}is selected',
            [2] = 'Watch a {C:spectral}Family Guy Clip{}',
            [3] = 'to reduce blind size',
            [4] = 'by {C:attention}#1#%{}'
        },
        ['unlock'] = {[1] = 'Unlocked by default.'}
    },
    pos = {x = 7, y = 3},
    display_size = {w = 71 * 1, h = 95 * 1},
    cost = 4,
    rarity = "howie_joe",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    -- pools = { ["modprefix_imposter_jokers"] = true },
     loc_vars = function(self, info_queue, card)
      card.ability.extra.percent = (1 - card.ability.extra.blind_size)*100 
        return {vars = {card.ability.extra.percent}}
    
    end,

    calculate = function(self, card, context)
        if context.setting_blind then
            return {
                func = function()
                    card_eval_status_text(context.blueprint_card or card,
                                          'extra', nil, nil, nil, {
                        message = "X" .. tostring(card.ability.extra.blind_size) ..
                            " Blind Size",
                        colour = G.C.GREEN
                    })
                    G.GAME.blind.chips =
                        G.GAME.blind.chips * card.ability.extra.blind_size
                    G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                    G.HUD_blind:recalculate()
                    watchTV()
                    return true
                end
            }
        end
    end
}
SMODS.Joker { -- Chris Griffin
    key = "chrisgriffin",
    config = {extra = {}},
    loc_txt = {
        ['name'] = 'Chris Griffin',
        ['text'] = {
            [1] = 'Each played {C:attention}#1#{}',
            [2] =  'becomes a {C:enhanced}Family Card{}',
            [3] =  'when scored, Rank',
            [4] = ' changes every round'
        },
        ['unlock'] = {[1] = ''}
    },
    pos = {x = 2, y = 0},
    cost = 6,
    rarity = "howie_joe",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                localize((G.GAME.current_round.chrisRank_card or {}).rank or
                             'Ace', 'ranks')
            }
        }
    end,

    set_ability = function(self, card, initial)
        G.GAME.current_round.chrisRank_card = {rank = 'Ace', id = 14}
    end,

    calculate = function(self, card, context)
      if context.individual and context.cardarea == G.play then
            if (function()
                local rankFound = false
                for i, c in ipairs(context.full_hand) do
                    if context.other_card:get_id() ==
                        G.GAME.current_round.chrisRank_card.id then
                        rankFound = true
                        break
                    end
                end

                return rankFound
            end)() then
                return {
                    func = function()
                      
                            context.other_card:set_ability(G.P_CENTERS.m_howie_familycard)
                        
                    end,
                    message = "Card Modified!"
                }
            end
        end
        if context.end_of_round and context.game_over == false and
            context.main_eval then
            if G.playing_cards then
                local valid_chrisRank_cards = {}
                for _, v in ipairs(G.playing_cards) do
                    if not SMODS.has_no_rank(v) then
                        valid_chrisRank_cards[#valid_chrisRank_cards + 1] =
                            v
                    end
                end
                if valid_chrisRank_cards[1] then
                    local chrisRank_card =
                        pseudorandom_element(valid_chrisRank_cards,
                                             pseudoseed(
                                                 'chrisRank' ..
                                                     G.GAME.round_resets.ante))
                    G.GAME.current_round.chrisRank_card.rank =
                        chrisRank_card.base.value
                    G.GAME.current_round.chrisRank_card.id =
                        chrisRank_card.base.id
                end
            end
        end
    end
}

if Howie.config["no_family"] then
    G.SwansonRarity = "howie_joe"
else
    G.SwansonRarity = 3
end
SMODS.Joker { -- Joe Swanson
    key = "joeswanson",
    config = {extra = {hand_change = 1, uncommonjokers = 0, perma_mult = 3}},
    loc_txt = {
        ['name'] = 'Joe Swanson',
        ['text'] = {
            [1] = 'For each {X:blue,C:black}Joe{} Rarity Joker,',
            [2] = 'cards gain {C:mult}+#1#{} Mult permanently when scored',
            [3] = '{X:blue,C:black}Joe{} Rarity Jokers appear more'
        }
    },
    pos = {x = 9, y = 0},
    cost = 8,
    rarity = G.SwansonRarity,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    loc_vars = function(self, info_queue, card) return {vars = {card.ability.extra.perma_mult}} end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            context.other_card.ability.perma_mult =
                context.other_card.ability.perma_mult or 0
            context.other_card.ability.perma_mult =
                context.other_card.ability.perma_mult + ((function()
                    local count = 0;
                    for _, joker in ipairs(G.jokers and G.jokers.cards or {}) do
                        if joker.config.center.rarity == "howie_joe" then
                            count = count + 1
                        end
                    end
                    return count
                end)()) * card.ability.extra.perma_mult
            return {
                extra = {message = localize('k_upgrade_ex'), colour = G.C.MULT},
                card = card
            }
        end
    end,

 

}
SMODS.Joker { -- Vagabond Copy
    key = "peepants",
    config = {mod_conv = 'c_howie_tropicalfish', extra = {limit = 4}},
    loc_txt = {
        ['name'] = 'Pee Pants the Inebriated Hobo Clown',
        ['text'] = {
            [1] = 'If hand is played',
            [2] = 'with {C:money}$#2#{} or less',
            [3] = 'Create a {C:purple,T:c_howie_tropicalfish}Tropical Fish{}'
        },
        ['unlock'] = {[1] = ''}
    },
    pos = {x = 6, y = 4},
    display_size = {w = 71 * 1, h = 95 * 1},
    cost = 8,
    rarity = "howie_joe",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return {
            vars = {
                localize {
                    type = 'name_text',
                    set = 'Enhanced',
                    key = card.ability.extra.mod_conv
                },
                 card.ability.extra.limit
            },
           
        }
       
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            if G.GAME.dollars <= to_big(card.ability.extra.limit) then
                if G.consumeables.config.card_limit  >  #G.consumeables.cards then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.4,
                        func = function()
                            play_sound('timpani')
                            SMODS.add_card({
                                set = 'Tarot',
                                key = 'c_howie_tropicalfish'
                            })
                            card:juice_up(0.3, 0.5)
                            return true
                        end
                    }))
                end
                delay(0.6)
                return {
                    message = created_consumable and localize('k_plus_tarot') or
                        nil
                }
            end
        end
    end
}

SMODS.Joker { -- Seamus Levine
    key = "petercube",
    config = {extra = {xchips = 2.5}},
    loc_txt = {
        ['name'] = 'Peter Cube',
        ['text'] = {
            [1] = 'If played hand has',
            [2] = 'Only 4 Cards',
            [3] = "Add a {C:enhanced}Family{} Card to hand",
            [4] = "That gives {C:mult}+16{} Mult "
        }
    },
    pos = {x = 4, y = 6},
    cost = 4,
    rarity = "howie_joe",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
     pixel_size = {w = 71 / (71 / 40), h = 95 / (95 / 32)},
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    -- pools = { ["howie_jokers"] = true },
    calculate = function(self, card, context)
          if context.before and #context.full_hand == 4 then
            return {
                func = function()

                    local card_front = pseudorandom_element(G.P_CARDS,
                                                            pseudoseed(
                                                                'add_card_hand'))
                    local new_card = create_playing_card({
                        front = card_front,
                        center = G.P_CENTERS.m_howie_familycard
                    }, G.discard, true, false, nil, true)

                    G.playing_card = (G.playing_card and G.playing_card + 1) or
                                         1
                    new_card.playing_card = G.playing_card
                    table.insert(G.playing_cards, new_card)
                 new_card.ability.mult = 16
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.hand:emplace(new_card)
                            new_card:start_materialize()
                            SMODS.calculate_context({
                                playing_card_added = true,
                                cards = {new_card}
                                
                            })
                            return true
                        end
                    }))
                end,
                message = "Added Card to Hand!"
            }
        end
    end
}

if Howie.config["no_family"] then
    G.GodRarity = "howie_joe"
else
    G.GodRarity = 4
end
SMODS.Joker { -- God
    key = "familygod",
    config = {extra = {hand_change = 1, uncommonjokers = 1, perma_x_mult = 1.3}},
    loc_txt = {
        ['name'] = 'God',
        ['text'] = {
            [1] = 'For each {X:blue,C:black}Joe{} Rarity Joker',
            [2] = 'cards gain {X:mult,C:white}X#1#{} Mult permanently when scored',
            [3] = '{X:blue,C:black}Joe{} Rarity Jokers are extremely common'
        }
    },
    pos = {x = 8, y = 2},
    cost = 10,
    rarity = G.GodRarity,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    loc_vars = function(self, info_queue, card) return {vars = {card.ability.extra.perma_x_mult}} end,
    -- pools = { ["howie_jokers"] = true },
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
            not context.blueprint then
            context.other_card.ability.perma_x_mult =
                context.other_card.ability.perma_x_mult or 0
            context.other_card.ability.perma_x_mult =
                context.other_card.ability.perma_x_mult +
                    card.ability.extra.uncommonjokers + ((function()
                    local count = 0;
                    for _, joker in ipairs(G.jokers and G.jokers.cards or {}) do
                        if joker.config.center.rarity == "howie_joe" then
                            count = count + 1
                        end
                    end
                    return count
                end)()) * card.ability.extra.perma_x_mult
            return {
                extra = {message = localize('k_upgrade_ex'), colour = G.C.CHIPS},
                card = card
            }
        end
    end,
--almost  january mint

}

SMODS.Joker { -- Golden Peter Griffin
    key = "goldenpeter",
    config = {
        extra = {
            isPlayedHandFour = 0,
            dollars = 7,
            noLoop = true,
            ClipPlayed = Howie.config.ClipsWatched
        }
    },
    loc_txt = {
        ['name'] = 'Golden Peter',
        ['text'] = {
            [1] = 'Gain {C:money}#1#${} After Watching',
            [2] = 'A {C:spectral}Family Guy Clip{}'
        }
    },
    pos = {x = 6, y = 0},
    cost = 6,
    rarity = "howie_joe",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    -- pools = { ["howie_jokers"] = true },
     loc_vars = function(self, info_queue, card) return {vars = {card.ability.extra.dollars}} end,

    calculate = function(self, card, context)
        if  card.ability.extra.ClipPlayed ~= Howie.config.ClipsWatched then
           -- print( Howie.config.ClipsWatched, "gfolen peter")
           card.ability.extra.ClipPlayed = Howie.config.ClipsWatched
                 ease_dollars(card.ability.extra.dollars)
        end
    end
}
SMODS.Joker { -- Glass Peter
    key = "glasspeter",
    config = {extra = {Xmult = 2, odds = 4}},
    loc_txt = {
        ['name'] = 'Glass Peter',
        ['text'] = {
            [1] = 'When a {C:enhanced}Family Card{} is scored',
            [2] = '{X:red,C:white}X#3#{} Mult',
            [3] = '{C:uncommon}#1# in #2#{} chance to destroy card'
        },
        ['unlock'] = {[1] = 'Unlocked by default.'}
    },
    pos = {x = 1, y = 4},
    display_size = {w = 71 * 1, h = 95 * 1},
    cost = 4,
    rarity = "howie_joe",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    -- pools = { ["modprefix_imposter_jokers"] = true },
    loc_vars = function(self, info_queue, card)

        local new_numerator, new_denominator =
            SMODS.get_probability_vars(card, 1, card.ability.extra.odds,
                                       'j_howie_glasspeter')
        return {vars = {new_numerator, new_denominator, card.ability.extra.Xmult}}
    end,

    calculate = function(self, card, context)
        if context.destroy_card and context.destroy_card.should_destroy then
            return {remove = true}
        end
        if context.individual and context.cardarea == G.play then
            context.other_card.should_destroy = false
            if SMODS.get_enhancements(context.other_card)[familycardArray[1]] ==
                true or
                SMODS.get_enhancements(context.other_card)[familycardArray[2]] ==
                true then
                return {
                    Xmult = card.ability.extra.Xmult,
                    func = function()
                        if SMODS.pseudorandom_probability(card,
                                                          'group_0_cdbaf0d2', 1,
                                                          card.ability.extra
                                                              .odds,
                                                          'j_howie_glasspeter',
                                                          false) then
                            context.other_card.should_destroy = true
                            card_eval_status_text(
                                context.blueprint_card or card, 'extra', nil,
                                nil, nil,
                                {message = "Destroyed!", colour = G.C.RED})
                        end
                        return true
                    end
                }
            end
        end
    end,
    in_pool = function(self, args) -- equivalent to `enhancement_gate = 'm_steel'`
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, familycardArray[1]) or
                SMODS.has_enhancement(playing_card, familycardArray[2]) then
                return true
            end
        end
        return false
    end
}
SMODS.Joker { -- Peter Griffin
    key = "retep",
    config = {extra = {total = 4, decrease = .25}},
    loc_txt = {
        ['name'] = 'Retep',
        ['text'] = {
            [1] = '{X:red,C:white}X#3#{} Mult',
            [2] = 'reduced by {X:red,C:white}X#1#{} Mult',
            [3] = 'for each {C:enhanced}Family Card{} in your {C:attention}full deck{}',
            [4] = '{C:inactive}(Currently{} {X:red,C:white}X#2#{} {C:inactive}Mult){}'
        }
    },
    pos = {x = 9, y = 3},
    cost = 5,
    rarity = "howie_joe",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_steel

        local steel_tally = 0
        if G.playing_cards then
            for _, playing_card in ipairs(G.playing_cards) do
                if SMODS.has_enhancement(playing_card, familycardArray[1]) or
                    SMODS.has_enhancement(playing_card, familycardArray[2]) then
                    steel_tally = steel_tally + 1
                end
            end
        end
        return {
            vars = {
                card.ability.extra.decrease,
                card.ability.extra.total - steel_tally * card.ability.extra.decrease,
                card.ability.extra.total
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local steel_tally = 0
            for _, playing_card in ipairs(G.playing_cards) do
                if SMODS.has_enhancement(playing_card, familycardArray[1]) or
                    SMODS.has_enhancement(playing_card, familycardArray[2]) then
                    steel_tally = steel_tally + 1
                end
            end
            return {Xmult = card.ability.extra.total - steel_tally * card.ability.extra.decrease}
        end
    end

}
SMODS.Joker { -- Glenn Quagmire
    key = "glennquagmire",
    config = {extra = {total = 0, maxCount = 40, ignore = 0}},
    loc_txt = {
        ['name'] = 'Glenn Quagmire',
        ['text'] = {
            [1] = 'Every {C:attention}#2#{} {C:enhanced}Family{} Cards Scored',
            [2] = 'Create a Random Joe Card',
            [3] = '{C:inactive}#1#/#2#{}'
        }
    },
    pos = {x = 5, y = 0},
    cost = 7,
    rarity = "howie_joe",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    -- pools = { ["howie_jokers"] = true },
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.total, card.ability.extra.maxCount}}
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            
           if SMODS.has_enhancement(context.other_card,familycardArray[1]) or
               SMODS.has_enhancement(context.other_card,familycardArray[2])  then
                print("gig")
                card.ability.extra.total =
                    (card.ability.extra.total) + 1
                return {message = "Giggity!", colour = G.C.GREEN,  message_card = card}
            end
        end
        if context.after and context.cardarea == G.jokers then
            if (card.ability.extra.total or 0) >= card.ability.extra.maxCount then
                card.ability.extra.total =  card.ability.extra.total - card.ability.extra.maxCount
                return {
                    func = function()
                        local created_joker = true
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                local joker_card = SMODS.add_card({
                                    set = 'Joker',
                                    rarity = 'howie_joe'
                                })
                                if joker_card then end

                                return true
                            end
                        }))

                        if created_joker then
                            card_eval_status_text(
                                context.blueprint_card or card, 'extra', nil,
                                nil, nil, {
                                    message = localize('k_plus_joker'),
                                    colour = G.C.BLUE
                                })
                        end
                        return true
                    end
                }
            end
        end
    end
}
SMODS.Joker { -- Peter Griffin
    key = "petergriffin",
    config = {extra = {xmult = 0.25}},
    loc_txt = {
        ['name'] = 'Peter Griffin',
        ['text'] = {
            [1] = 'Gives {X:red,C:white}X#1#{} Mult',
            [2] = 'for each {C:enhanced}Family Card{} ',
            [3] = 'in your {C:attention}full deck{}',
            [4] = '{C:inactive}(Currently{} {X:red,C:white}X#2#{} {C:inactive}Mult){}'
        }
    },
    pos = {x = 4, y = 1},
    cost = 5,
    rarity = "howie_joe",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_steel

        local steel_tally = 0
        if G.playing_cards then
            for _, playing_card in ipairs(G.playing_cards) do
                if SMODS.has_enhancement(playing_card, familycardArray[1]) or
                    SMODS.has_enhancement(playing_card, familycardArray[2]) then
                    steel_tally = steel_tally + 1
                end
            end
        end
        return {
            vars = {
                card.ability.extra.xmult,
                1 + card.ability.extra.xmult * steel_tally
            }
        } 
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local steel_tally = 0
            for _, playing_card in ipairs(G.playing_cards) do
                if SMODS.has_enhancement(playing_card, familycardArray[1]) or
                    SMODS.has_enhancement(playing_card, familycardArray[2]) then
                    steel_tally = steel_tally + 1
                end
            end
            return {Xmult = 1 + card.ability.extra.xmult * steel_tally}
        end
    end,
    in_pool = function(self, args) -- equivalent to `enhancement_gate = 'm_steel'`
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, familycardArray[1]) or
                SMODS.has_enhancement(playing_card, familycardArray[2]) then
                return true
            end
        end
        return false
    end
}
SMODS.Joker { -- Adam We
    key = "adamwe",
    config = {extra = {noLoop = true}},
    loc_txt = {
        ['name'] = 'Adam We',
        ['text'] = {
            [1] = 'The first scored card',
            [2] = 'becomes a {C:enhanced}Family Card{}',
            [3] = 'If hand played contains',
            [4] = '{C:attention}0 {}Family Cards'
        },
        ['unlock'] = {[1] = 'Unlocked by default.'}
    },
    pos = {x = 9, y = 4},
    display_size = {w = 71 * 1, h = 95 * 1},
    cost = 5,
    rarity = "howie_joe",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    -- pools = { ["modprefix_mycustom_jokers"] = true },

    calculate = function(self, card, context)
        if context.setting_blind then card.ability.extra.noLoop = true end
        if context.individual and context.cardarea == G.play then
            if (function()
                local count = 0
                for _, playing_card in pairs(context.scoring_hand or {}) do
                    if SMODS.get_enhancements(playing_card)["m_howie_familycard"] ==
                        true then
                        card.ability.extra.noLoop = false
                        count = count + 1
                    end
                end
                return count == 0
            end)() then
                if card.ability.extra.noLoop then
                    context.other_card:set_ability(G.P_CENTERS
                                                       .m_howie_familycard)
                    return {message = "Card Modified!"}
                end
            end
        end
    end
}
SMODS.Joker { -- Family Guy DVD 
    key = "icecreampeter",
    config = {extra = {total = 200,mult_loss = 40}},
    loc_txt = {
        ['name'] = 'Ice Cream Peter',
        ['text'] = {
            [1] ="{C:mult}+#1#{} Mult",
             [2] =  "{C:mult}-#2#{} Mult per round played",
                [3] = "Watch a {C:spectral}Family Guy Clip{}",
                [4] = "when a hand is played"
        }
    },
    pos = {x = 7, y = 5},

    cost = 4,
    rarity = "howie_joe",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.total,card.ability.extra.mult_loss}}
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if card.ability.extra.total - card.ability.extra.mult_loss <= 0 then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = localize('k_melted_ex'),
                    colour = G.C.RED
                }
            else
                -- See note about SMODS Scaling Manipulation on the wiki
                card.ability.extra.total = card.ability.extra.total - card.ability.extra.mult_loss
                return {
                    message = localize { type = 'variable', key = 'a_mult_minus', vars = { card.ability.extra.mult_loss } },
                    colour = G.C.MULT
                }
            end
        end
        if context.joker_main then
            watchTV()
            return {
                mult = card.ability.extra.total
            }
        end
    end
}