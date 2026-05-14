SMODS.Joker { -- New Joker
    key = "rederin",
    config = {extra = {}},
    loc_txt = {
        ['name'] = 'Evil Erin',
        ['text'] = {[1] = 'X0 Chips', [2] = 'evil joker'},
        ['unlock'] = {[1] = 'Unlocked by default.'}
    },
    pos = {x = 0, y = 4},
    display_size = {w = 71 * 1, h = 95 * 1},
    cost = 5,
    rarity = "howie_curse",
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = false,
    no_collection = true,
    atlas = 'CustomJokers',
    pools = {["erin"] = true},

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
      
            return {x_chips = 0.1}

        end
    end,
    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, "m_howie_green") then
                -- print("green card")
                return true
            end
        end
    end
}
-- The Omelette
SMODS.Challenge {
    key = 'pibblechallenge',
    loc_txt = {name = 'Wash my Belly!'},
    rules = {modifiers = {{id = 'joker_slots', value = 10}}},
    jokers = {
        {id = 'j_howie_rederin', eternal = true, pinned = true},
        {id = 'j_howie_pibble'}, {id = 'j_howie_pibble'},
        {id = 'j_howie_pibble'}, {id = 'j_howie_pibble'}
    },
    restrictions = {
        banned_cards = {
            {id = 'j_howie_miku'}, {id = 'j_howie_johnpork'},
            {id = 'j_blue_joker'}, {id = 'j_banner'}, {id = 'j_crafty'},
            {id = 'j_clever'}, {id = 'j_bull'}, {id = 'j_ice_cream'},
            {id = 'j_devious'}, {id = 'j_runner'}, {id = 'j_wee'},
            {id = 'j_wily'}, {id = 'j_stuntman'}, {id = 'j_sly'},
            {id = 'j_square'},   {id = 'j_howie_spongeclock'}, 
        },
        banned_other = {
               {id = 'e_foil'}
        }
    }
}
if SMODS.find_card("j_howie_rederin") and (G.STAGE == G.STAGES.RUN or G.STATE == G.STATES.PLAY_TAROT) and type(G.jokers) == "table" and type(G.jokers.cards) == "table" then
   G.GAME.banned_keys = "e_foil"
end
SMODS.Challenge {
    key = 'glorpchallenge',
    loc_txt = {name = 'Glorp in a Glorpstack'},
    jokers = {{id = 'j_howie_glorpcloning', eternal = true}},
    rules = {
        modifiers = {
            {id = 'discards', value = 6}, {id = 'hand_size', value = 10},
            {id = 'joker_slots', value = 2}
        }
    },
     
    deck = {
        type = 'Challenge Deck',
        cards = {
            {s = 'C', r = 'A', g = "howie_glorpseal"}, {s = 'D', r = 'A'},
            {s = 'H', r = 'A'}, {s = 'S', r = 'A'}, {s = 'C', r = 'K'},
            {s = 'D', r = 'K'}, {s = 'H', r = 'K'}, {s = 'S', r = 'K'},
            {s = 'C', r = 'Q'}, {s = 'D', r = 'Q'}, {s = 'H', r = 'Q'},
            {s = 'S', r = 'Q'}, {s = 'C', r = 'J'}, {s = 'D', r = 'J'},
            {s = 'H', r = 'J'}, {s = 'S', r = 'J'}, {s = 'C', r = 'T'},
            {s = 'D', r = 'T'}, {s = 'H', r = 'T'}, {s = 'S', r = 'T'},
            {s = 'C', r = '9'}, {s = 'D', r = '9'}, {s = 'H', r = '9'},
            {s = 'S', r = '9'}, {s = 'C', r = '8'}, {s = 'D', r = '8'},
            {s = 'H', r = '8'}, {s = 'S', r = '8'}, {s = 'C', r = '7'},
            {s = 'D', r = '7'}, {s = 'H', r = '7'}, {s = 'S', r = '7'},
            {s = 'C', r = '6'}, {s = 'D', r = '6'}, {s = 'H', r = '6'},
            {s = 'S', r = '6'}, {s = 'C', r = '5'}, {s = 'D', r = '5'},
            {s = 'H', r = '5'}, {s = 'S', r = '5'}, {s = 'C', r = '4'},
            {s = 'D', r = '4'}, {s = 'H', r = '4'}, {s = 'S', r = '4'},
            {s = 'C', r = '3'}, {s = 'D', r = '3'}, {s = 'H', r = '3'},
            {s = 'S', r = '3'}, {s = 'C', r = '2'}, {s = 'D', r = '2'},
            {s = 'H', r = '2'}, {s = 'S', r = '2'}, {s = 'C', r = 'A'},
            {s = 'D', r = 'A'}, {s = 'H', r = 'A'}, {s = 'S', r = 'A'},
            {s = 'C', r = 'K'}, {s = 'D', r = 'K'}, {s = 'H', r = 'K'},
            {s = 'S', r = 'K'}, {s = 'C', r = 'Q'}, {s = 'D', r = 'Q'},
            {s = 'H', r = 'Q'}, {s = 'S', r = 'Q'}, {s = 'C', r = 'J'},
            {s = 'D', r = 'J'}, {s = 'H', r = 'J'}, {s = 'S', r = 'J'},
            {s = 'C', r = 'T'}, {s = 'D', r = 'T'}, {s = 'H', r = 'T'},
            {s = 'S', r = 'T'}, {s = 'C', r = '9'}, {s = 'D', r = '9'},
            {s = 'H', r = '9'}, {s = 'S', r = '9'}, {s = 'C', r = '8'},
            {s = 'D', r = '8'}, {s = 'H', r = '8'}, {s = 'S', r = '8'},
            {s = 'C', r = '7'}, {s = 'D', r = '7'}, {s = 'H', r = '7'},
            {s = 'S', r = '7'}, {s = 'C', r = '6'}, {s = 'D', r = '6'},
            {s = 'H', r = '6'}, {s = 'S', r = '6'}, {s = 'C', r = '5'},
            {s = 'D', r = '5'}, {s = 'H', r = '5'},
            {s = 'S', r = '5', g = "howie_glorpseal"}, {s = 'C', r = '4'},
            {s = 'D', r = '4'}, {s = 'H', r = '4'}, {s = 'S', r = '4'},
            {s = 'C', r = '3'}, {s = 'D', r = '3'}, {s = 'H', r = '3'},
            {s = 'S', r = '3'}, {s = 'C', r = '2'}, {s = 'D', r = '2'},
            {s = 'H', r = '2'}, {s = 'S', r = '2'}, {s = 'C', r = 'A'},
            {s = 'D', r = 'A'}, {s = 'H', r = 'A'}, {s = 'S', r = 'A'},
            {s = 'C', r = 'K'}, {s = 'D', r = 'K'}, {s = 'H', r = 'K'},
            {s = 'S', r = 'K'}, {s = 'C', r = 'Q'}, {s = 'D', r = 'Q'},
            {s = 'H', r = 'Q'}, {s = 'S', r = 'Q'}, {s = 'C', r = 'J'},
            {s = 'D', r = 'J'}, {s = 'H', r = 'J'}, {s = 'S', r = 'J'},
            {s = 'C', r = 'T'}, {s = 'D', r = 'T', g = "howie_glorpseal"},
            {s = 'H', r = 'T'}, {s = 'S', r = 'T'}, {s = 'C', r = '9'},
            {s = 'D', r = '9'}, {s = 'H', r = '9'}, {s = 'S', r = '9'},
            {s = 'C', r = '8'}, {s = 'D', r = '8'},
            {s = 'H', r = '8', g = "howie_glorpseal"}, {s = 'S', r = '8'},
            {s = 'C', r = '7'}, {s = 'D', r = '7'}, {s = 'H', r = '7'},
            {s = 'S', r = '7'}, {s = 'C', r = '6'}, {s = 'D', r = '6'},
            {s = 'H', r = '6'}, {s = 'S', r = '6'}, {s = 'C', r = '5'},
            {s = 'D', r = '5'}, {s = 'H', r = '5'}, {s = 'S', r = '5'},
            {s = 'C', r = '4'}, {s = 'D', r = '4'}, {s = 'H', r = '4'},
            {s = 'S', r = '4'}, {s = 'C', r = '3', g = "howie_glorpseal"},
            {s = 'D', r = '3'}, {s = 'H', r = '3'}, {s = 'S', r = '3'},
            {s = 'C', r = '2'}, {s = 'D', r = '2'}, {s = 'H', r = '2'},
            {s = 'S', r = '2'}, {s = 'C', r = 'A'}, {s = 'D', r = 'A'},
            {s = 'H', r = 'A'}, {s = 'S', r = 'A'}, {s = 'C', r = 'K'},
            {s = 'D', r = 'K'}, {s = 'H', r = 'K'}, {s = 'S', r = 'K'},
            {s = 'C', r = 'Q'}, {s = 'D', r = 'Q'}, {s = 'H', r = 'Q'},
            {s = 'S', r = 'Q', g = "howie_glorpseal"}, {s = 'C', r = 'J'},
            {s = 'D', r = 'J'}, {s = 'H', r = 'J'}, {s = 'S', r = 'J'},
            {s = 'C', r = 'T'}, {s = 'D', r = 'T'}, {s = 'H', r = 'T'},
            {s = 'S', r = 'T'}, {s = 'C', r = '9'}, {s = 'D', r = '9'},
            {s = 'H', r = '9'}, {s = 'S', r = '9'}, {s = 'C', r = '8'},
            {s = 'D', r = '8'}, {s = 'H', r = '8'}, {s = 'S', r = '8'},
            {s = 'C', r = '7'}, {s = 'D', r = '7'}, {s = 'H', r = '7'},
            {s = 'S', r = '7'}, {s = 'C', r = '6'}, {s = 'D', r = '6'},
            {s = 'H', r = '6'}, {s = 'S', r = '6'}, {s = 'C', r = '5'},
            {s = 'D', r = '5'}, {s = 'H', r = '5'}, {s = 'S', r = '5'},
            {s = 'C', r = '4'}, {s = 'D', r = '4'}, {s = 'H', r = '4'},
            {s = 'S', r = '4'}, {s = 'C', r = '3'}, {s = 'D', r = '3'},
            {s = 'H', r = '3'}, {s = 'S', r = '3'}, {s = 'C', r = '2'},
            {s = 'D', r = '2'}, {s = 'H', r = '2'}, {s = 'S', r = '2'}
        }
    }
}
-- Medusa
SMODS.Challenge {
    key = 'jevilchallenge',
    jokers = {{id = 'j_howie_jevil', eternal = true}},
    rules = {
        modifiers = {
        
            {id = 'joker_slots', value = 6}
        }
    },
     loc_txt = {name = 'The Circus'},
    deck = {
        type = 'Challenge Deck',
        cards = {
            {s = 'C', r = 'A'}, {s = 'D', r = 'A'}, {s = 'H', r = 'A'},
            {s = 'S', r = 'A'}, {s = 'C', r = 'K', e = 'm_wild'},
            {s = 'D', r = 'K', e = 'm_wild'}, {s = 'H', r = 'K', e = 'm_wild'},
            {s = 'S', r = 'K', e = 'm_wild'}, {s = 'C', r = 'Q', e = 'm_wild'},
            {s = 'D', r = 'Q', e = 'm_wild'}, {s = 'H', r = 'Q', e = 'm_wild'},
            {s = 'S', r = 'Q', e = 'm_wild'}, {s = 'C', r = 'J', e = 'm_wild'},
            {s = 'D', r = 'J', e = 'm_wild'}, {s = 'H', r = 'J', e = 'm_wild'},
            {s = 'S', r = 'J', e = 'm_wild'}, {s = 'C', r = 'T'},
            {s = 'D', r = 'T'}, {s = 'H', r = 'T'}, {s = 'S', r = 'T'},
            {s = 'C', r = '9'}, {s = 'D', r = '9'}, {s = 'H', r = '9'},
            {s = 'S', r = '9'}, {s = 'C', r = '8'}, {s = 'D', r = '8'},
            {s = 'H', r = '8'}, {s = 'S', r = '8'}, {s = 'C', r = '7'},
            {s = 'D', r = '7'}, {s = 'H', r = '7'}, {s = 'S', r = '7'},
            {s = 'C', r = '6'}, {s = 'D', r = '6'}, {s = 'H', r = '6'},
            {s = 'S', r = '6'}, {s = 'C', r = '5'}, {s = 'D', r = '5'},
            {s = 'H', r = '5'}, {s = 'S', r = '5'}, {s = 'C', r = '4'},
            {s = 'D', r = '4'}, {s = 'H', r = '4'}, {s = 'S', r = '4'},
            {s = 'C', r = '3'}, {s = 'D', r = '3'}, {s = 'H', r = '3'},
            {s = 'S', r = '3'}, {s = 'C', r = '2'}, {s = 'D', r = '2'},
            {s = 'H', r = '2'}, {s = 'S', r = '2'}
        }
    },
      restrictions = {
        banned_cards = {
            {id = 'c_howie_tropicalfish'}, {id = 'c_howie_erineel'},
            {id = 'j_howie_cabbit'}, {id = 'j_howie_slungus'},   {id = 'c_magician'},
                {id = 'c_empress'},
                {id = 'c_heirophant'},
                {id = 'c_chariot'},
                {id = 'c_devil'},
                {id = 'c_tower'},
               
                {id = 'c_incantation'},
                {id = 'c_grim'},
                {id = 'c_familiar'},
                {id = 'p_standard_normal_1', ids = {
                    'p_standard_normal_1','p_standard_normal_2','p_standard_normal_3','p_standard_normal_4','p_standard_jumbo_1','p_standard_jumbo_2','p_standard_mega_1','p_standard_mega_2',
                }},
                {id = 'j_marble'},
                {id = 'j_vampire'},
                {id = 'j_midas_mask'},
                {id = 'j_certificate'},
                {id = 'v_magic_trick'},
                {id = 'v_illusion'},
           
        }
    }
}
