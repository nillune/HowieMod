SMODS.Consumable {
    key = 'spooner',
    set = 'Planet',
    pos = { x = 9, y = 0 },
    config = { 
  
        hand_type = "howie_Bulwark",
        levels = 1,
     softlock = true  },
    loc_txt = {
        name = '31 Spooner Street',
        text = {
       [1] = 'Level up {C:attention}#2#{}',
        [2] = '{C:red}+#3#{} Mult and {C:blue}+#4#{} Chips'
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
                G.GAME.hands[card.ability.hand_type].level,
                localize(card.ability.hand_type, 'poker_hands'),
                G.GAME.hands[card.ability.hand_type].l_mult,
                G.GAME.hands[card.ability.hand_type].l_chips,
                colours = { (G.GAME.hands[card.ability.hand_type].level == 1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, G.GAME.hands[card.ability.hand_type].level)]) }
            }
        }
    end,
    can_use = function(self, card)
        return true
    end
}