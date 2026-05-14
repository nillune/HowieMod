 local JoeWeight = 1
if not Howie.config["no_family"] then
     JoeWeight = .4

else
     JoeWeight = 0
end
SMODS.Booster {
    key = 'joe_pack',
    loc_txt= {
        name = 'Joe Pack',
        group_name = {"Doesn't look very good, does it?"},
        text = { "Pick {C:attention}#1#{} card out",
                "{C:attention}#2#{} Joe Rarity jokers!", },
        
    },
    config = { extra = 2, choose = 1 },
    weight = JoeWeight,
    atlas = "CustomBoosters",
    pos = { x = 0, y = 0 },
    kind = 'JoePack',
    group_key = "j_howie_joe_pack",
    discovered = false,
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra }
        }
    end,
    create_card = function(self, card, i)
       
        local weights = {
            1,
            0.01
           
        }
    
        local total_weight = 0
        for _, weight in ipairs(weights) do
            total_weight = total_weight + weight
        end
        local random_value = pseudorandom('howie_joe_pack_card') * total_weight
        local cumulative_weight = 0
        local selected_index = 1
        for j, weight in ipairs(weights) do
            cumulative_weight = cumulative_weight + weight
            if random_value <= cumulative_weight then
                selected_index = j
                break
            end
        end
        if selected_index == 1 then
            return {
            set = "Joker",
            rarity = "howie_joe",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append = "howie_joe_pack"
            }
        elseif selected_index == 2 then
            return {
            key = "j_howie_joeswanson",
            set = "Joker",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append = "howie_joe_pack"
            }
        end
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("2a5fa1"))
        ease_background_colour({ new_colour = HEX('2a5fa1'), special_colour = HEX("2a5fa1"), contrast = 2 })
    end,
    particles = function(self)
        -- No particles for joker packs
    end,
}


SMODS.Booster {
    key = 'bigjoepack',
    loc_txt = {
        name = "Big Joe Pack ",
        text = {
            "Choose 1 of 4 Joe Joker Cards."
        },
        group_name = {"Pick somethin', will ya?"},
    },
    config = { extra = 4, choose = 1 },
    weight = JoeWeight,
    atlas = "CustomBoosters",
    pos = { x = 1, y = 0 },
    kind = 'JoeBigPack',
    group_key = "j_howie_big_joe_pack",
    discovered = false,
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra }
        }
    end,
    create_card = function(self, card, i)
        local weights = {
            1,
            0.01
           
        }
    
        local total_weight = 0
        for _, weight in ipairs(weights) do
            total_weight = total_weight + weight
        end
        local random_value = pseudorandom('howie_joepackcopy_card') * total_weight
        local cumulative_weight = 0
        local selected_index = 1
        for j, weight in ipairs(weights) do
            cumulative_weight = cumulative_weight + weight
            if random_value <= cumulative_weight then
                selected_index = j
                break
            end
        end
        if selected_index == 1 then
            return {
            set = "Joker",
            rarity = "howie_joe",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append = "howie_joepackcopy"
            }
        elseif selected_index == 2 then
            return {
            key = "j_howie_joeswanson",
            set = "Joker",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append = "howie_joepackcopy"
            }
        end
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("2a5fa1"))
        ease_background_colour({ new_colour = HEX('2a5fa1'), special_colour = HEX("2a5fa1"), contrast = 2 })
    end,
    particles = function(self)
        -- No particles for joker packs
    end,
}
SMODS.Booster{
    key = 'booster_howiepack',
    group_key = "k_howie_booster_group",
    atlas = 'CustomBoosters', 
    pos = { x = 2, y = 0 },
    discovered = false,
    loc_txt= {
        name = 'Howie Pack',
        text = { "Pick {C:attention}#1#{} card out",
                "{C:attention}#2#{} Howie jokers!", },
        group_name = {"meow"},
    },
    
    draw_hand = false,
    config = {
        extra = 3,
        choose = 1, 
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra } }
    end,

    weight = 1,
    cost = 5,
    kind = "HowiePack",
    
    create_card = function(self, card, i)
        ease_background_colour(HEX("ffac00"))
        return SMODS.create_card({
            set = "howie_jokers",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
        })
    end,
    select_card = 'jokers',

    in_pool = function() return true end
}
SMODS.Booster{
    key = 'booster_fish',
    group_key = "k_howie_booster_group",
    atlas = 'CustomBoosters', 
    pos = { x = 3, y = 0 },
    discovered = false,
    loc_txt= {
        name = 'Fish Net',
        text = { "Fish up {C:attention}#1#{} fish  ",
                "consumable out of {C:attention}#2#{}", },
        group_name = {"meow"},
    },
    
    draw_hand = false,
    config = {
        extra = 3,
        choose = 1, 
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra } }
    end,

    weight = 1,
    cost = 4,
    kind = "HowiePack",
    
    create_card = function(self, card, i)
        ease_background_colour(HEX("ffac00"))
        return SMODS.create_card({
            set = "fish",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
        })
    end,
    select_card = 'consumeables',

    in_pool = function() return true end
}