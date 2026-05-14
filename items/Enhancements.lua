
SMODS.Enhancement {
    key = 'green',
    pos = { x = 1, y = 0 },
    config = {
        extra = {
            GreenCount = 0,
            levels = 2,
            Line2 = 'Three of a Kind',
            MaxGreen = 20,
            increaseCount = 1 --so it works with cyrptid uwu
        }
    },
    loc_txt = {
        name = 'Green',
        text = {
        [1] = 'When #3# {C:green,E:1,s:2}Green{} cards have been scored',
        [2] = 'level up {C:attention}#2#{} by {C:attention}#4#{} levels',
        [3] = '{C:inactive}Currently #1#/#3#{}',
        [4] = 'Always Scores'
    }
    },
    atlas = 'CustomEnhancements',
    any_suit = false,
    replace_base_card = false,
    no_rank = false,
    no_suit = false,
    always_scores = true,
    unlocked = true,
    discovered = false,
    no_collection = false,
    weight = 5,
    loc_vars = function(self, info_queue, card)
        return {vars = { Howie.config.GreenCount,card.ability.extra.Line2,card.ability.extra.MaxGreen, card.ability.extra.levels }}
    end,
    calculate = function(self, card, context)
         if next(SMODS.find_card('j_howie_halferin', false)) then
            card.ability.extra.MaxGreen = 10
         end
        -- reloading runs and trying to keep green score is like really iffy but this is the best i can do, i think

        -- I FOUND OUT HOW
          
        if context.main_scoring and context.cardarea == G.play and (Howie.config.GreenCount or 0) >= card.ability.extra.MaxGreen then

             local target_hand
             if next(SMODS.find_card('j_howie_peterin', false)) then
                target_hand = "howie_Bulwark"
                         else
                target_hand = "Three of a Kind"
             end
            SMODS.calculate_effect({level_up = card.ability.extra.levels,
                level_up_hand = target_hand}, card)
            Howie.config.GreenCount = Howie.config.GreenCount - card.ability.extra.MaxGreen

        end
        if context.main_scoring and context.cardarea == G.play then
            Howie.config.GreenCount = (Howie.config.GreenCount) + card.ability.extra.increaseCount
            SMODS.save_mod_config(Howie.config.GreenCount)
        end
        if card.ability.extra.GreenCount ~= Howie.config.GreenCount then
            card.ability.extra.GreenCount = Howie.config.GreenCount
        if next(SMODS.find_card('j_howie_peterin', false)) then
            
            card.ability.extra.Line2 = 'Family House'
        end
        end
    end
}

SMODS.Enhancement {
    key = 'familycard',
    pos = { x = 0, y = 0 },
    config = {
        mult = 10,
       extra = {
            odds = 75,
            
        }
        
    },
    loc_txt = {
        name = 'Family Card',
        text = {
        [1] = '{C:mult}+#1#{} Mult',
        [2] = '{C:attention}#2#/#3#{} chance ',
        [3] = 'To play a {C:spectral}Family Guy Clip{}',
        [4] = 'When scored'
    }
    },
    atlas = 'CustomEnhancements',
    any_suit = false,
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,
    unlocked = true,
    discovered = false,
    no_collection = false,
    loc_vars = function(self, info_queue, card)
        local familynumerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'm_howie_familycard')
        return {vars =  {card.ability.mult,
       familynumerator, denominator}}
         
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            if SMODS.pseudorandom_probability(card, 'group_0_6cb3d782', 1, card.ability.extra.odds, 'm_howie_familycard') then
                watchTV()
            end
        end
    end
}


SMODS.Atlas{
    key = 'CustomSeals',
    path = 'Seals.png',
    px = 71,
    py = 95, 
}
--dude i hate this so much STOP SAPPEARING IN STANDARD PACKS
--just gonna make it only score when you have glorp atp
--done

--fuck This Joker 
SMODS.Seal {
    key = 'glorpseal',
    pos = { x = 0, y = 0 },
    config = {
        extra = {
            joker_slots = 1
        }
    },
    badge_colour = HEX('FFB347'),
   loc_txt = {
        name = 'Glorp Seal',
        label = 'Glorp Seal',
        text = {
        [1] = '{C:attention}+#1#{} Joker Slot when scored with glorp cloning'
    }
    },
    atlas = 'CustomSeals',
  
    unlocked = true,
    discovered = false,
    no_collection = true,
     loc_vars = function(self, info_queue, card)
       
        return {vars =  {card.ability.seal.extra.joker_slots}}
         
    end,
    weight = 0,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play and next(SMODS.find_card('j_howie_glorpcloning', false)) then
           return {
                    func = function()
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(card.ability.seal.extra.joker_slots).." Joker Slot", colour = G.C.DARK_EDITION})
                G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.seal.extra.joker_slots
                return true
            end
                }
        end
    end
}


