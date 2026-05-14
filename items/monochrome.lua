SMODS.Shader({ key = 'greyscale', path = 'greyscale.fs' })
SMODS.Shader({ key = 'monochrome', path = 'monochrome.fs' })
SMODS.Edition {
    key = 'monochrome',
    shader = 'greyscale',
    in_shop = false,
    apply_to_float = false,
    badge_colour = HEX('408080'),
    sound = { sound = "generic1", per = 1.2, vol = 0.4 },
    disable_shadow = false,
    config = {
       
           target_joker = 1
      
    },
    disable_base_shader = false,
    loc_txt = {
        name = 'Monochrome',
        label = 'Monochrome',
        text = {
        [1] = '{C:inactive}Destroyed after activating{}'
    }
    },
    unlocked = true,
    discovered = false,
    no_collection = false,
    extra_cost = -7,
    get_weight = function(self)
        return G.GAME.edition_rate * self.weight
    end,
  update = function(self, card, dt)
         
    end,
    calculate = function(self, card, context)
       if card.ability.eternal then card.ability.eternal = nil end --no cheese
             if context.post_trigger then
            --print(context.other_card.config.center.key  )
                if context.other_card == card then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.GAME.joker_buffer = 0
                        -- See note about SMODS Scaling Manipulation on the wiki
                        card:juice_up(0.8, 0.8)
                        card:start_dissolve({ HEX("57ecab") }, nil, 1.6)
                        play_sound('slice1', 0.96 + math.random() * 0.08)
                        return true
                    end
                }))  
            end
        end
         if context.destroy_card and context.cardarea == G.play and context.destroy_card == card then
            return { remove = true }
        end            
    end
}

SMODS.Edition {
    key = 'cardstorm',
    shader = 'monochrome',
    in_shop = true,
    apply_to_float = false,
    badge_colour = HEX('408080'),
    sound = { sound = "generic1", per = 1.2, vol = 0.4 },
    disable_shadow = false,
    config = {
       
           target_joker = 1
      
    },
    disable_base_shader = false,
    loc_txt = {
        name = 'cardstorm',
        label = 'cardstorm',
        text = {
        [1] = 'Retriggers leftmost Joker'
    }
    },
    unlocked = true,
    discovered = false,
    no_collection = false,
    extra_cost = 10,
    weight = 2,
    get_weight = function(self)
        return G.GAME.edition_rate * self.weight
    end,

    calculate = function(self, card, context)
        if context.retrigger_joker_check and not context.retrigger_joker and
            context.other_card ~= self  then
            
            if context.other_card == G.jokers.cards[1] then
                return {
                    message = localize("k_again_ex"),
                    repetitions = 1,
                    card = card
                }
            else
                return nil, true
            end
        end
    
    end
}


