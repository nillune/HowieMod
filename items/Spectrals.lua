SMODS.Consumable {
    key = 'blobfish',
    set = 'Spectral',
    pos = {x = 0, y = 0},
    config = {max_highlighted = 5},
    loc_txt = {
        name = 'Blobfish',
        text = {
            [1] = 'Changes the rank of up to ',
            [2] = '{C:attention}#1#{} selected cards to 7'
        }
    },

    cost = 5,
    unlocked = true,
    discovered = false,
    hidden = false,
    can_repeat_soul = false,
    atlas = 'CustomConsumables',
    pools = {["fish"] = true},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.max_highlighted}}
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('howie_fish')
                used_card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) *
                                0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    assert(SMODS.change_base(G.hand.highlighted[i], nil, '7'))
                    return true
                end
            }))
        end
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) *
                                0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
        delay(0.5)

    end

}
SMODS.Consumable {
    key = 'cod',
    set = 'Spectral',
    pos = {x = 2, y = 0},
    loc_txt = {
        name = 'Cod',
        text = {
            [1] = 'Add {C:dark_edition}Negative{} effect to',
            [2] = "{C:attention}#1#{} selected card in hand"
        }
    },
    cost = 5,
    unlocked = true,
    discovered = false,
    hidden = false,
    can_repeat_soul = false,
    atlas = 'CustomConsumables',
    pools = {["fish"] = true},
    config = {max_highlighted = 1},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.max_highlighted}}
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('howie_fish')
                used_card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) *
                                0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    G.hand.highlighted[i]:set_edition({negative = true}, true)
                    return true
                end
            }))
        end
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) *
                                0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
        delay(0.5)

    end

}
SMODS.Consumable {
    key = 'megfish',
    set = 'Spectral',
    pos = {x = 4, y = 0},
    config = {extra = {dollars = 15}},
    loc_txt = {
        name = 'Meg Fish',
        text = {
            [1] = 'Watch a',
            [2] = '{C:spectral}Family Guy Clip{}',
            [3] = 'to gain {C:money}#1#${}'
        }
    },

    cost = 5,
    unlocked = true,
    discovered = false,
    hidden = false,
    can_repeat_soul = false,
    atlas = 'CustomConsumables',
    pools = {["fish"] = true},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.dollars}}
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()

                watchTV()
                ease_dollars(card.ability.extra.dollars, true)
                return true
            end
        }))
        delay(0.6)
    end,
    can_use = function(self, card) return true end
}
SMODS.Consumable {
    key = 'goldfish',
    set = 'Spectral',
    pos = {x = 3, y = 0},
    config = {extra = {cards_amount = 2}},
    loc_txt = {
        name = 'Goldfish',
        text = {
            [1] = '{C:attention}#1#{} random cards',
            [2] = "in your hand become a",
            [3] = '{C:attention}Gold Card{} and',
            [4] = 'gain a {C:attention}Red{} Seal'
        }
    },
    cost = 3,
    unlocked = true,
    discovered = false,
    hidden = false,
    can_repeat_soul = false,
    atlas = 'CustomConsumables',
    pools = {["fish"] = true},
    loc_vars = function(self, info_queue, card)

        return {vars = {card.ability.extra.cards_amount}}
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card

        local affected_cards = {}
        local temp_hand = {}

        for _, playing_card in ipairs(G.hand.cards) do
            temp_hand[#temp_hand + 1] = playing_card
        end
        table.sort(temp_hand, function(a, b)
            return not a.playing_card or not b.playing_card or a.playing_card <
                       b.playing_card
        end)

        pseudoshuffle(temp_hand, 12345)

        for i = 1, math.min(card.ability.extra.cards_amount, #temp_hand) do
            affected_cards[#affected_cards + 1] = temp_hand[i]
        end

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('howie_fish')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #affected_cards do
            local percent = 1.15 - (i - 0.999) / (#affected_cards - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    affected_cards[i]:flip()
                    play_sound('card1', percent)
                    affected_cards[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #affected_cards do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    affected_cards[i]:set_ability(G.P_CENTERS['m_gold'])
                    return true
                end
            }))
        end
        for i = 1, #affected_cards do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    affected_cards[i]:set_seal("Red", nil, true)
                    return true
                end
            }))
        end
        for i = 1, #affected_cards do
            local percent = 0.85 + (i - 0.999) / (#affected_cards - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    affected_cards[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    affected_cards[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.5)
    end,
    can_use = function(self, card) return true end
}

SMODS.Consumable {
    key = 'GasterFish',
    set = 'Spectral',
    pos = {x = 1, y = 1},
    config = {extra = {copy_amount = 1, cardsmade = 3}},
    loc_txt = {
        name = 'GasterFish',
        text = {
            [1] = 'Create {C:attention}#1#{} {C:inactive}Monochrome{}',
            [2] = 'copies of selected joker'
        }
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_howie_monochrome
        local other_joker
        if G.STAGE == G.STAGES.RUN then
            if #G.jokers.highlighted == 1 then

                other_joker = G.jokers.highlighted[1]
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
            return {vars = {card.ability.extra.cardsmade}, main_end = main_end}
        end
        return {vars = {card.ability.extra.cardsmade}}
    end,
    cost = 3,
    unlocked = true,
    discovered = false,
    hidden = false,
    can_repeat_soul = false,
    atlas = 'CustomConsumables',
    pools = {["fish"] = true},
    use = function(self, card, area, copier)
        local used_card = copier or card
        if #G.jokers.highlighted == 1 then
            for i = 1, card.ability.extra.cardsmade do
                local _first_materialize = nil
                local self_card = G.jokers.highlighted[1]
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        play_sound('timpani')
                        local copied_joker =
                            copy_card(self_card, set_edition, nil, nil, false)
                        copied_joker:start_materialize(nil, _first_materialize)
                        self_card:add_to_deck()
                        G.jokers:emplace(copied_joker)
                        _first_materialize = true
                        copied_joker:set_edition('e_howie_monochrome', true)
                        return true
                    end
                }))
                delay(0.6)
            end
        end
    end,
    can_use = function(self, card)
        return (#G.jokers.highlighted == 1 and
                   G.jokers.highlighted[1].config.center.blueprint_compat)
    end
}
SMODS.Consumable {
    key = 'friendfish',
    set = 'Spectral',
    pos = {x = 0, y = 1},
    config = {max_highlighted = 1, extra = {copy_cards_amount = 5}},
    loc_txt = {
        name = 'Fish_Friend',
        text = {
            [1] = 'Create {C:attention}#1#{} {C:inactive}Monochrome{} copies',
            [2] = 'of {C:attention}#2#{} selected card',
            [3] = 'in your hand'
        }
    },
    cost = 5,
    unlocked = true,
    discovered = false,
    hidden = false,
    can_repeat_soul = false,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_howie_monochrome
        return {
            vars = {
                card.ability.extra.copy_cards_amount,
                card.ability.max_highlighted
            }
        }
    end,
    atlas = 'CustomConsumables',
    pools = {["fish"] = true},
    use = function(self, card, area, copier)
        local used_card = copier or card

        G.E_MANAGER:add_event(Event({
            func = function()
                local _first_materialize = nil
                local new_cards = {}

                for _, selected_card in pairs(G.hand.highlighted) do
                    for i = 1, card.ability.extra.copy_cards_amount do
                        G.playing_card =
                            (G.playing_card and G.playing_card + 1) or 1
                        local copied_card =
                            copy_card(selected_card, nil, nil, G.playing_card)
                        copied_card:set_edition("e_howie_monochrome", true)
                        copied_card:add_to_deck()
                        G.deck.config.card_limit = G.deck.config.card_limit + 1
                        table.insert(G.playing_cards, copied_card)
                        G.hand:emplace(copied_card)
                        copied_card:start_materialize(nil, _first_materialize)
                        _first_materialize = true
                        new_cards[#new_cards + 1] = copied_card
                    end
                end

                SMODS.calculate_context({
                    playing_card_added = true,
                    cards = new_cards
                })
                return true
            end
        }))
        delay(0.6)

    end

}
function changeJokerNumber(joker,number)
        if type(joker) == 'table' then
            for k, v in pairs(joker) do
                    if not k:match("total") then
                        if type(v) == 'number' then
                            joker[k] = number
                        elseif type(v) == 'table' then
                            changeJokerNumber(v,number) -- Recurse into nested tables
                        end
                    else
                       -- print(k)
                    end
                end
        end
    
     if type(joker.extra) == 'number' then
                   joker.extra = 6.7
                else
                for k, v in pairs(joker.extra) do
                    print("joker.extra checked")
                    if not k:match("total") then
                        if type(v) == 'number' then
                            joker[k] = number
                        elseif type(v) == 'table' then
                            changeJokerNumber(v,number) -- Recurse into nested tables
                        end
                    else
                       -- print(k)
                    end
                end
            end
        
end
SMODS.Consumable {
    key = 'sixsevenfish',
    set = 'Spectral',
    pos = {x = 5, y = 1},
    config = {max_highlighted = 1, extra = {copy_cards_amount = 5}},
    loc_txt = {
        name = '67 Fish',
        text = {
            [1] = 'Set a jokers',
            [2] = 'numbers to {C:attention}6.7{}',
            [3] = '{C:inactive}if possible{}'
        }
    },
    cost = 5,
    unlocked = true,
    discovered = false,
    hidden = false,
    can_repeat_soul = false,
    loc_vars = function(self, info_queue, card)

        return {
            vars = {
                card.ability.extra.copy_cards_amount,
                card.ability.max_highlighted
            }
        }
    end,
    atlas = 'CustomConsumables',
    pools = {["fish"] = true},
    use = function(self, card, area, copier)
        local used_card = copier or card
        local self_card = G.jokers.highlighted[1]
        if self_card and self_card.ability and self_card.ability.extra then
            -- Helper function to recursively set all numeric values in a table to 6.7
            local function set_to_67(tbl)
                if type(tbl) == 'number' then
                   return
                else
                for k, v in pairs(tbl) do
                    if not k:match("total") then
                        if type(v) == 'number' then
                            tbl[k] = 6.7
                        elseif type(v) == 'table' then
                            set_to_67(v) -- Recurse into nested tables
                        end
                    else
                       -- print(k)
                    end
                end
            end
        end
            -- Apply the change to the extra table
            if  type(self_card.ability.extra)  == 'number' then
                self_card.ability.extra = 6.7
            else
            set_to_67(self_card.ability.extra)
            end
            -- Optional: Trigger a UI update or effect to show the change
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('howie_fish')
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
        end
    end,
    can_use = function(self, card)
        return (#G.jokers.highlighted == 1 and
                   G.jokers.highlighted[1].ability.extra)
    end
}
