SMODS.Atlas {
    key = "CustomDecks",
    path = "Decks.png",
    px = 71,
    py = 95,
    atlas_table = "ASSET_ATLAS"
}
-- G.GAME.selected_back
-- will need this eventually
-- probably
-- yeah i did
SMODS.Back {
    key = "ErinDeck",
    pos = {x = 0, y = 0},
    unlocked = true,
    atlas = "CustomDecks",
    loc_txt = {
        ['name'] = 'Erin Deck',
        ['text'] = {
            [1] = "{C:attention}Aces{}, {C:attention}2's{}, and {C:attention}Queens{} ",
            [2] = 'are {C:green,E:1,s:2}Green{}'
        }
    },
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.playing_cards) do
                    if v.base.id == 14 then
                        v:set_ability(G.P_CENTERS.m_howie_green)
                    end
                    if v.base.id == 2 then
                        v:set_ability(G.P_CENTERS.m_howie_green)
                    end
                    if v.base.id == 12 then
                        v:set_ability(G.P_CENTERS.m_howie_green)
                    end
                end
                return true
            end
        }))
    end,
    locked_loc_vars = function(self, info_queue, back)
        local other_name = localize('k_unknown')
        if G.P_CENTERS['b_black'].unlocked then
            other_name = localize {
                type = 'name_text',
                set = 'Back',
                key = 'b_black'
            }
        end

        return {vars = {other_name}}
    end,
    check_for_unlock = function(self, args)
        return args.type == 'win_deck' and get_deck_win_stake('b_black') > 1
    end
}
SMODS.Back {
    key = "Petoria",
    pos = {x = 1, y = 0},
    config = {ante_scaling = 1},
    unlocked = true,
    atlas = "CustomDecks",
    loc_txt = {
        ['name'] = 'Petoria Deck',
        ['text'] = {
            [1] = "{X:blue,C:black}Joe{} Rarity Jokers appear more ",
            [2] = 'when a Non-{X:blue,C:black}Joe{} Rarity Joker is purchased',
            [3] = 'Watch a {C:spectral}Family Guy Clip{} '
        }
    },
    loc_vars = function(self, info_queue, back)
        return {vars = {self.config.ante_scaling}}
    end,

    apply = function(self, back) G.GAME.howie_joe_mod = .5 end,
    calculate = function(self, back, context)
        if context.buying_card then
            if context.card.config.center.blueprint_compat == true or
                context.card.config.center.blueprint_compat == false then
                -- print('hi')
                if context.card.config.center.rarity == "howie_joe" or
                    context.card.config.center.key == "joeswanson" then
                else
                    -- print(context.card.config.center.rarity,context.card.config.center.key)
                    watchTV()
                end
            end
        end
    end,
    -- The config field already handles the functionality so it doesn't need to be implemented
    -- The following is how the implementation would be
    --[[
    apply = function(self, back)
        G.GAME.starting_params.ante_scaling = self.config.ante_scaling
    end,
    ]]
    locked_loc_vars = function(self, info_queue, back)
        return {
            vars = {
                localize {type = 'name_text', set = 'Stake', key = 'stake_blue'},
                colours = {get_stake_col(5)}
            }
        }
    end,
    check_for_unlock = function(self, args)
        return args.type == 'win_stake' and get_deck_win_stake() >= 5
    end
}
SMODS.Back {
    key = "long",
    pos = {x = 5, y = 0},
    config = {ante_scaling = 1, joker_slot = 15},
    unlocked = true,
    atlas = "CustomDecks",
    loc_txt = {
        ['name'] = 'Rich Deck',
        ['text'] = {
            [1] = "{C:attention}+15{} Joker slots",
            [4] = 'when blind is selected',
            [2] = 'Lose {C:money}5${} for each',
            [3] = "extra joker slot filled"
        }
    },
    loc_vars = function(self, info_queue, back)
        return {vars = {self.config.ante_scaling}}
    end,

    apply = function(self, back) end,
    calculate = function(self, back, context)
        if context.setting_blind and #G.jokers.cards > 5 then

            return {
                dollars = ((15 -
                    ((G.jokers and G.jokers.config.card_limit or 0) -
                        #(G.jokers and G.jokers.cards or {}))) * 5) * -1,
                func = function() -- This is for timing purposes, it runs after the dollar manipulation
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.dollar_buffer = 0
                            return true
                        end
                    }))
                end
            }
        end

    end,
    -- The config field already handles the functionality so it doesn't need to be implemented
    -- The following is how the implementation would be
    --[[
    apply = function(self, back)
        G.GAME.starting_params.ante_scaling = self.config.ante_scaling
    end,
    ]]
    locked_loc_vars = function(self, info_queue, back)
        return {
            vars = {
                localize {type = 'name_text', set = 'Stake', key = 'stake_blue'},
                colours = {get_stake_col(5)}
            }
        }
    end,
    check_for_unlock = function(self, args)
        return args.type == 'win_stake' and get_deck_win_stake() >= 5
    end
}
SMODS.Back({
    key = "voucherdeck", -- i gotta come up with a better name this could get confusing
    config = {noloop = true},
    atlas = "CustomDecks",
    loc_txt = {
        ['name'] = 'Voucher Deck',
        ['text'] = {
            [1] = "{C:attention}+1{} Voucher slot in shop",
            [2] = "Vouchers are {C:attention}20%{} Cheaper"
        }
    },
    pos = {x = 2, y = 0},
    -- mp_credits = { art = { "aura!" }, code = { "Toneblock" } },
    apply = function(self)
       
        SMODS.change_voucher_limit(1)
        G.GAME.modifiers.howie_voucherdeck = true
      
    end,
    calculate = function(self, back, context)
      
          if (Howie.config["unstable_features"]) and  self.config.noloop  and G.GAME.blind.chips == 300 then
            self.config.noloop = false
        add_tag(Tag('tag_voucher'))
        end
    end

})

local set_cost_ref = Card.set_cost
function Card:set_cost()
    set_cost_ref(self)
    if G.GAME.modifiers.howie_voucherdeck and self.config.center.set ==
        "Voucher" then

        self.cost = math.max(1,
                             math.floor(
                                 0.8 * (self.base_cost + self.extra_cost + 0.5) *
                                     (100 - G.GAME.discount_percent) / 100) -- thanks mulitplayer code
        )

    end
end
SMODS.Back {
    key = "hazeldeck",
    pos = { x = 6, y = 0 },
    config = { hands = 1,hand_size = 1,no_interest = true },
    unlocked = true,
    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.hands,self.config.hand_size } }
    end,
    atlas = "CustomDecks",
    loc_txt = {
        ['name'] = 'Hazel and Cherri Deck',
        ['text'] = {
            [1] = "{C:blue}+#1#{} hand every round,",
            [2] = "{C:attention}+#2#{} hand size,",
            [3] =  "Earn no {C:attention}Interest",
        }
    },
    -- The config field already handles the functionality so it doesn't need to be implemented
    -- The following is how the implementation would be
    --[[
    apply = function(self, back)
        G.GAME.starting_params.hands = G.GAME.starting_params.hands + self.config.extra.hands
    end,
    ]]
   
}