SMODS.Atlas {
    key = 'erinMoon',
    path = "erinTest.png",
    px = 125,
    py = 125,
    frames = 1,
    atlas_table = "ASSET_ATLAS"
}
SMODS.Consumable {
    key = 'erinplanet',
    set = 'Planet',
    config = {extra = {currentX = 0}},
    loc_txt = {
        name = 'Erin Planet',
        text = {[1] = '{C:green,E:1,s:2}Green{} your entire hand'}
    },
    cost = 3,
    unlocked = true,
    discovered = false,
    hidden = false,
    can_repeat_soul = false,
    atlas = 'erinMoon',
    pos = {y = 0, x = 0},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_howie_green
    end,
      pools = {["fish"] = true},
    update = function(self, card, dt)
        if card.ability.extra.currentX >= 39 then
            card.ability.extra.currentX = 0
        end
        if isWholeNumber(card.ability.extra.currentX) then
            card.children.center:set_sprite_pos({
                x = card.ability.extra.currentX,
                y = 0
            })
        end
        card.ability.extra.currentX = card.ability.extra.currentX + 0.5

    end,

    
    use = function(self, card, area, copier)
        local used_tarot = copier or card
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                used_tarot:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.cards do
            local percent = 1.15 - (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.cards[i]:flip()
                    play_sound('card1', percent)
                    G.hand.cards[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
       
        for i = 1, #G.hand.cards do
            G.E_MANAGER:add_event(Event({
                func = function()
                    local _card = G.hand.cards[i]
                   _card:set_ability(
                            G.P_CENTERS['m_howie_green'])
                    return true
                end
            }))
        end
        for i = 1, #G.hand.cards do
            local percent = 0.85 + (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.cards[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.cards[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.5)
    end,
   can_use = function(self, card)
        return G.hand and #G.hand.cards > 0
    end,
}
