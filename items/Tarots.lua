SMODS.Consumable {
    key = 'tuna',
    set = 'Tarot',
    pos = {x = 8, y = 0},
    config = {extra = {hand_size_value = 1, destroy_joker_amount = 1}},
    loc_txt = {
        name = 'Tuna',
        text = {
            [1] = 'Destroy {C:attention}#2#{} random Jokers',
            [2] = 'Gain {C:attention}+#1#{} hand size'
        }
    },
    cost = 3,
    unlocked = true,
    discovered = false,
    hidden = false,
    can_repeat_soul = false,
    atlas = 'CustomConsumables',

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.hand_size_value,
                card.ability.extra.destroy_joker_amount
            }
        }
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                card_eval_status_text(used_card, 'extra', nil, nil, nil,
                                      {message = "Fish!", colour = G.C.BLUE})
                G.hand:change_size(2)
                return true
            end
        }))
        delay(0.6)
        local jokers_to_destroy = {}
        local deletable_jokers = {}

        for _, joker in pairs(G.jokers.cards) do
            if joker.ability.set == 'Joker' and
                not SMODS.is_eternal(joker, card) then
                deletable_jokers[#deletable_jokers + 1] = joker
            end
        end

        if #deletable_jokers > 0 then
            local temp_jokers = {}
            for _, joker in ipairs(deletable_jokers) do
                temp_jokers[#temp_jokers + 1] = joker
            end

            pseudoshuffle(temp_jokers, 98765)

            for i = 1, math.min(card.ability.extra.destroy_joker_amount,
                                #temp_jokers) do
                jokers_to_destroy[#jokers_to_destroy + 1] = temp_jokers[i]
            end
        end

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('howie_fish')
                used_card:juice_up(0.3, 0.5)
                return true
            end
        }))

        local _first_dissolve = nil
        G.E_MANAGER:add_event(Event({
            trigger = 'before',
            delay = 0.75,
            func = function()
                for _, joker in pairs(jokers_to_destroy) do
                    joker:start_dissolve(nil, _first_dissolve)
                    _first_dissolve = true
                end
                return true
            end
        }))
        delay(0.6)
    end,
    can_use = function(self, card)
        for _, joker in pairs(G.jokers.cards) do
            if joker.ability.set == 'Joker' and
                not SMODS.is_eternal(joker, card) then return true end
        end

    end
}
SMODS.Consumable {
    key = 'catfish',
    set = 'Tarot',
    pos = {x = 1, y = 0},
    config = {extra = {destroy_count = 3, edition_amount = 1}},
    loc_txt = {
        name = 'Catfish',
        text = {
            [1] = 'Destroy {C:attention}#1#{} random cards',
            [2] = 'a random joker',
            [3] = 'becomes {C:edition}Foil{}'
        }
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_foil
        return {
            vars = {
                card.ability.extra.destroy_count,
                card.ability.extra.edition_amount
            }
        }
    end,
    cost = 5,
    unlocked = true,
    discovered = false,
    hidden = false,
    can_repeat_soul = false,
    atlas = 'CustomConsumables',
    pools = {["fish"] = true},
    use = function(self, card, area, copier)
        local used_card = copier or card
        local jokers_to_edition = {}
        local eligible_jokers = {}

        if 'editionless' == 'editionless' then
            eligible_jokers = SMODS.Edition:get_edition_cards(G.jokers, true)
        else
            for _, joker in pairs(G.jokers.cards) do
                if joker.ability.set == 'Joker' then
                    eligible_jokers[#eligible_jokers + 1] = joker
                end
            end
        end

        if #eligible_jokers > 0 then
            local temp_jokers = {}
            for _, joker in ipairs(eligible_jokers) do
                temp_jokers[#temp_jokers + 1] = joker
            end

            pseudoshuffle(temp_jokers, 76543)

            for i = 1, math.min(card.ability.extra.edition_amount, #temp_jokers) do
                jokers_to_edition[#jokers_to_edition + 1] = temp_jokers[i]
            end
        end

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                used_card:juice_up(0.3, 0.5)
                return true
            end
        }))

        for _, joker in pairs(jokers_to_edition) do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    joker:set_edition({foil = true}, true)
                    return true
                end
            }))
        end
        delay(0.6)
        local destroyed_cards = {}
        local temp_hand = {}

        for _, playing_card in ipairs(G.hand.cards) do
            temp_hand[#temp_hand + 1] = playing_card
        end
        table.sort(temp_hand, function(a, b)
            return not a.playing_card or not b.playing_card or a.playing_card <
                       b.playing_card
        end)

        pseudoshuffle(temp_hand, 12345)

        for i = 1, 3 do
            destroyed_cards[#destroyed_cards + 1] = temp_hand[i]
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
        SMODS.destroy_cards(destroyed_cards)

        delay(0.5)
    end,
    can_use = function(self, card) return true end
}
SMODS.Consumable {
    key = 'tropicalfish',
    set = 'Tarot',
    pos = {x = 7, y = 0},
    loc_txt = {
        name = 'Tropical Fish',
        text = {
            [1] = 'Enhances {C:attention}#1#{}',
            [2] = 'selected card into',
            [3] = 'a {C:enhanced,T:m_howie_familycard}Family Card{}'
        }
    },
    cost = 3,
    unlocked = true,
    discovered = false,
    hidden = false,
    can_repeat_soul = false,
    atlas = 'CustomConsumables',
    config = {extra = {enhanceAmount = 1}},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_howie_familycard
        return {vars = {card.ability.extra.enhanceAmount}}
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        if (#G.hand.highlighted <= card.ability.extra.enhanceAmount and
            #G.hand.highlighted > 0) then
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
                local percent = 1.15 - (i - 0.999) /
                                    (#G.hand.highlighted - 0.998) * 0.3
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
                        G.hand.highlighted[i]:set_ability(
                            G.P_CENTERS['m_howie_familycard'])
                        return true
                    end
                }))
            end
            for i = 1, #G.hand.highlighted do
                local percent = 0.85 + (i - 0.999) /
                                    (#G.hand.highlighted - 0.998) * 0.3
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
    end,
    can_use = function(self, card)
        return ((#G.hand.highlighted <= card.ability.extra.enhanceAmount and
                   #G.hand.highlighted > 0))
    end
}
SMODS.Consumable {
    key = 'salmon',
    set = 'Tarot',
    pos = {x = 5, y = 0},
    config = {extra = {edition_amount = 1}},
    loc_txt = {
        name = 'Salmon',
        text = {
            [1] = 'Gives a random joker',
            [2] = '{C:edition}Polychrome {}and {C:attention}Perishable{}'
        }
    },
    cost = 5,
    unlocked = true,
    discovered = false,
    hidden = false,
    can_repeat_soul = false,
    atlas = 'CustomConsumables',
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        local jokers_to_edition = {}
        local eligible_jokers = {}

        if 'editionless' == 'editionless' then
            eligible_jokers = SMODS.Edition:get_edition_cards(G.jokers, true)
        else
            for _, joker in pairs(G.jokers.cards) do
                if joker.ability.set == 'Joker' then
                    eligible_jokers[#eligible_jokers + 1] = joker
                end
            end
        end

        if #eligible_jokers > 0 then
            local temp_jokers = {}
            for _, joker in ipairs(eligible_jokers) do
                temp_jokers[#temp_jokers + 1] = joker
            end

            pseudoshuffle(temp_jokers, 76543)

            for i = 1, math.min(card.ability.extra.edition_amount, #temp_jokers) do
                jokers_to_edition[#jokers_to_edition + 1] = temp_jokers[i]
            end
        end

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('howie_fish')
                used_card:juice_up(0.3, 0.5)
                return true
            end
        }))

        for _, joker in pairs(jokers_to_edition) do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    joker:set_edition('e_polychrome', true)
                    joker:add_sticker('perishable', true)
                    return true
                end
            }))
        end
        delay(0.6)

    end,
    can_use = function(self, card) return true end
}
SMODS.Consumable {
    key = 'shrimp',
    set = 'Tarot',
    pos = {x = 6, y = 0},
    loc_txt = {
        name = 'Shrimp',
        text = {
            [1] = 'A Shrimp fried this {C:dark_edition}Negative {}{C:attention}Rice?{}'
        }
    },
    cost = 5,
    unlocked = true,
    discovered = false,
    hidden = false,
    can_repeat_soul = false,
    atlas = 'CustomConsumables',
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.j_howie_hairball

    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                play_sound('howie_fish')
                local new_joker = SMODS.add_card({
                    set = 'Joker',
                    key = 'j_howie_hairball'
                })
                if new_joker then
                    new_joker:set_edition({negative = true}, true)
                end
                used_card:juice_up(0.3, 0.5)
                return true
            end
        }))
        delay(0.6)
    end,
    can_use = function(self, card) return true end
}
SMODS.Consumable {
    key = 'crab',
    set = 'Tarot',
    pos = {x = 2, y = 1},
    loc_txt = {
        name = 'Crab',
        text = {
            [1] = 'Remove all stickers',
            [2] = 'from {C:attention}#1#{} Joker'
        }
    },
    cost = 3,
    unlocked = true,
    discovered = false,
    hidden = false,
    can_repeat_soul = false,
    config = {extra = {enhanceAmount = 1}},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.enhanceAmount}}
    end,
    atlas = 'CustomConsumables',
    use = function(self, card, area, copier)
        local used_card = copier or card
        -- print(G.GAME.stake)
        if (#G.jokers.highlighted == 1) then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('tarot1')
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            for i = 1, #G.jokers.highlighted do
                local percent = 1.15 - (i - 0.999) /
                                    (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        G.jokers.highlighted[i]:flip()
                        play_sound('card1', percent)
                        G.jokers.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            delay(0.2)
            for i = 1, #G.jokers.highlighted do
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        G.jokers.highlighted[1].ability.eternal = false
                        G.jokers.highlighted[1].ability.rental = false
                        G.jokers.highlighted[1].ability.perishable = false
                        return true
                    end
                }))
            end
            for i = 1, #G.jokers.highlighted do
                local percent = 0.85 + (i - 0.999) /
                                    (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        G.jokers.highlighted[i]:flip()
                        play_sound('tarot2', percent, 0.6)
                        G.jokers.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    G.jokers:unhighlight_all()
                    return true
                end
            }))
            delay(0.5)
        end
    end,
    can_use = function(self, card) return ((#G.jokers.highlighted == 1)) end,
    in_pool = function(self, args) -- equivalent to `enhancement_gate = 'm_lucky'`
        -- print(G.GAME.stake)
        if G.GAME.stake >= 4 then return true end
        return false
    end
    --
}
SMODS.Consumable {
    key = 'erineel',
    set = 'Tarot',
    config = {max_highlighted = 3, extra = {}},
    loc_txt = {
        name = 'Erinlectric Eel',
        text = {[1] = '{C:green,E:1,s:2}Green{} up to {C:attention}#1#{} cards'}
    },
    cost = 3,
    unlocked = true,
    discovered = false,
    hidden = false,
    can_repeat_soul = false,
    atlas = 'CustomConsumables',
    pos = {y = 1, x = 3},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_howie_green
        return {vars = {card.ability.max_highlighted}}
    end,
    pools = {["fish"] = true},

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
                    G.hand.highlighted[i]:set_ability(
                        G.P_CENTERS['m_howie_green'])
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
    key = 'assfish',
    set = 'Tarot',
    loc_txt = {
        name = 'Bony-eared Assfish',
        text = {[1] = 'Make your least used Joker'}
    },
    cost = 3,
    unlocked = true,
    discovered = false,
    hidden = false,
    can_repeat_soul = false,
    atlas = 'CustomConsumables',
    pos = {y = 1, x = 4},
    use = function(self, card, area, copier)
        local topkeys = {}
        local used_cards = {}
        local max_amt = 0
        for k, v in pairs(G.PROFILES[G.SETTINGS.profile]['joker_usage']) do
            if G.P_CENTERS[k] and (not nil or G.P_CENTERS[k].set == nil) and
                G.P_CENTERS[k].discovered then
                -- print("meow")
                used_cards[#used_cards + 1] = {count = v.count, key = k}
                if v.count > max_amt then max_amt = v.count end
            end
        end
        table.sort(used_cards, function(a, b) return a.count > b.count end)

        for i = 1, 215 do
            local v = used_cards[i]
            if v then
                if topkeys[i] ~= v.key then
                    topkeys[i] = v.key
                   -- print(topkeys[i])
                end
            end
        end

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                SMODS.add_card({set = 'Joker', key =  topkeys[#topkeys]})
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        delay(0.6)
    end,
    can_use = function(self, card)
        return G.jokers and #G.jokers.cards < G.jokers.config.card_limit
    end
}
