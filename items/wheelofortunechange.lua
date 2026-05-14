--yo mama so fat i had to give her her own lua page
SMODS.Consumable:take_ownership('wheel_of_fortune',
{
    pos = { x = 0, y = 1 },
    config = { extra = { odds = 4, odds2 = 1 } },
    loc_vars = function(self, info_queue, card)
         numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds,
            'c_wheel_of_fortune')
        return { vars = { numerator, denominator } }
    end,
    use = function(self, card, area, copier)
    if  G.GAME.used_vouchers["v_howie_sub_normal"] and not G.GAME.used_vouchers["v_howie_sub_tier2"] then
        --print("one voucher")
         edition = poll_edition('c_wheel_of_fortune', nil, true, true, {'e_polychrome' })
        card.ability.extra.odds = 2
    end
    if  G.GAME.used_vouchers["v_howie_sub_normal"] and  G.GAME.used_vouchers["v_howie_sub_tier2"] then
         edition = poll_edition('c_wheel_of_fortune', nil, true, true, {'e_negative'})
        --print("both voucher")
        
        card.ability.extra.odds2 = 3
        card.ability.extra.odds = 4
        end
    if not G.GAME.used_vouchers["v_howie_sub_normal"] and  not G.GAME.used_vouchers["v_howie_sub_tier2"] then
        --print("no voucher")
        print(G.GAME.used_vouchers["v_howie_sub_normal"], G.GAME.used_vouchers["v_howie_sub_tier2"])
        edition = poll_edition('c_wheel_of_fortune', nil, true, true, {'e_polychrome', 'e_holo', "e_foil" })
        card.ability.extra.odds2 = 1
        card.ability.extra.odds = 4
    end
	if SMODS.pseudorandom_probability(card, 'c_wheel_of_fortune', card.ability.extra.odds2, card.ability.extra.odds) then
            local editionless_jokers = SMODS.Edition:get_edition_cards(G.jokers, true)
            local eligible_card = pseudorandom_element(editionless_jokers, 'c_wheel_of_fortune')
            --print(edition)
            if G.GAME.used_vouchers["v_howie_sub_normal"] and  G.GAME.used_vouchers["v_howie_sub_tier2"] then  eligible_card:set_edition('e_negative', true) --idk it only works if i do it here
    else eligible_card:set_edition(edition, true) end
            
            check_for_unlock({ type = 'have_edition' })
        else
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    attention_text({
                        text = localize('k_nope_ex'),
                        scale = 1.3,
                        hold = 1.4,
                        major = card,
                        backdrop_colour = G.C.SECONDARY_SET.Tarot,
                        align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and
                            'tm' or 'cm',
                        offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
                        silent = true
                    })
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.06 * G.SETTINGS.GAMESPEED,
                        blockable = false,
                        blocking = false,
                        func = function()
                            play_sound('tarot2', 0.76, 0.4)
                            return true
                        end
                    }))
                    play_sound('tarot2', 1, 0.4)
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
        end
    end,

    can_use = function(self, card)
        return next(SMODS.Edition:get_edition_cards(G.jokers, true))
    end
	
},
true
)