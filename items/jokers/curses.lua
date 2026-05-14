
SMODS.Joker{ --Lancer
    key = "freddy",
    config = {
        extra = {
            lancerPerturn = 0,
            var1 = 0,
            auto_unselect_min = 20, -- seconds (minimum random delay)
            auto_unselect_max = 50,  -- seconds (maximum random delay)
            freddySelected = 100,
             joker_slots = 1
        }
    },
    loc_txt = {
        ['name'] = 'freddyfazbear',
        ['text'] = {
            [1] = 'Dont keep him unselected',
            [2] = 'for too long',
            [3] = '{C:inactive}#1#/5 blinds left{}'
        }
    },
    pos = {
        x = 6,
        y = 3
    },
    cost = 9,
    rarity = "howie_curse",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    no_collection = true,
    atlas = 'CustomJokers',
 --pools = { ["howie_jokers"] = true },
 loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.var1}}
    end,
    calculate = function(self, card, context)
       
        if context.setting_blind  then
            card.ability.extra.var1 = card.ability.extra.var1 + 1
            if card.ability.extra.var1 >= 6 then
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "-"..tostring(card.ability.extra.joker_slots).." Joker Slot", colour = G.C.DARK_EDITION})
                G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.joker_slots
                return {
                    func = function()
                local target_joker = nil
                for i, joker in ipairs(G.jokers.cards) do
                    if joker.config.center.key == "j_howie_freddy" and not joker.getting_sliced then
                        target_joker = joker
                        break
                    end
                end
                
                if target_joker then
                    if target_joker.ability.eternal then
                        target_joker.ability.eternal = nil
                    end
                    target_joker.getting_sliced = true
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            target_joker:start_dissolve({G.C.RED}, nil, 1.6)
                            return true
                        end
                    }))
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Destroyed!", colour = G.C.RED})
                end
                    return true
                end
                }
            end
            local event
            event = Event{
                trigger = 'after',
                delay = 100/G.SETTINGS.GAMESPEED,
                timer = "UPTIME",
                blockable = false,
                blocking = false,
                func = function()
                    if card.ability.extra.var1 >= 6 then
                        return true
                    end
                    if card.ability.extra.freddySelected <= 0 then
                        if card.ability.extra.var1 < 6 then
                            play_sound("howie_freddy",1, 1)
                         G.FreddyCount = 144
                         if G.STAGE == G.STAGES.RUN then
            -- Move to game over safely
            G.STATE = G.STATES.GAME_OVER
            G.STATE_COMPLETE = false
            -- Ensure any HUD updates happen
            if G.HUD_blind and type(G.HUD_blind.recalculate) == 'function' then
                pcall(function() G.HUD_blind:recalculate() end)
            end
                    end
                    
                end
            end        
                    --
                    event.start_timer = false
            end
            } G.E_MANAGER:add_event(event)
        end
        if not card.highlighted then 
                card.ability.extra.freddySelected =  card.ability.extra.freddySelected - 2.5
        end
        -- If the card is highlighted (selected) start a one-shot timer to
        -- unselect it after a random delay. Use a per-card flag so we don't
        -- schedule multiple timers for the same selection.
         if card.highlighted then 
              card.ability.extra.freddySelected =  card.ability.extra.freddySelected + 1.4
         end
        if card.highlighted and not card._freddy_unselect_scheduled then
           
            card._freddy_unselect_scheduled = true
            local min_t = (self.config and self.config.extra and self.config.extra.auto_unselect_min) or 2
            local max_t = (self.config and self.config.extra and self.config.extra.auto_unselect_max) or 6
            local delay = min_t + math.random() * (math.max(0, max_t - min_t))

            -- Schedule using the game's event manager so the timing respects
            -- game speed and the main loop.
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = delay,
                blockable = false,
                blocking = false,
                func = function()
                    -- Defensive checks: card may have been removed or area changed
                    if card and card.area and card.highlighted then
                        -- remove_from_highlighted already handles forced selection rules
                        card.area:remove_from_highlighted(card)
                        play_sound('cardSlide2', nil, 0.3)
                    end

                    -- clear the scheduled flag so future selections can schedule again
                    if card then card._freddy_unselect_scheduled = nil end
                    return true
                end
            }))
        end
    end
}


-- draw hook: preserve existing love.draw then add Freddy overlay
local base_draw = love.draw
love.draw = function(...)
    base_draw(...)

    if G and G.FreddyCount and (G.FreddyCount > 0) then
        if howie.freddyAnim == nil then
            -- Update these to match your sprite sheet
            howie.freddyAnim = loadSpriteSheetLocal('freddy_strip16.png', 16, 398, 227, 0.15)
            if not howie.freddyAnim then
                G.FreddyCount = nil
                return
            end
        end
        love.graphics.setColor(1, 1, 1, 1)
        drawSheetAsset(howie.freddyAnim, 0, 0, 0, 1920 / 498, 1080 / 281)
        G.FreddyCount = G.FreddyCount - 1
        if G.FreddyCount <= 0 then G.FreddyCount = nil end
    end
end


SMODS.Joker { -- Piano Zombie
    key = "pianozombie",
    config = {extra = {var1 = 0,  joker_slots = 1}},
    loc_txt = {
        ['name'] = 'Piano Zombie',
        ['text'] = {[1] = 'Dance!',
      [2] = '{C:inactive}#1#/5 blinds left{}'},
        ['unlock'] = {[1] = 'Unlocked by default.'}
    },
    pos = {x = 1, y = 6},
    display_size = {w = 71 * 1, h = 95 * 1},
    cost = 4,
    rarity = "howie_curse",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    no_collection = true,
    atlas = 'CustomJokers',
   loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.var1}}
    end,
    update = function(self, card, front)

        if SMODS.pseudorandom_probability(blind, 'j_howie_pianozombie', 1, 1000) then
             if #G.jokers.cards > 1 then
                G.jokers:unhighlight_all()
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                G.jokers:shuffle('aajk')
                                play_sound('cardSlide1', 0.85)
                                return true
                            end
                        }))
                        delay(0.15)
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                G.jokers:shuffle('aajk')
                                play_sound('cardSlide1', 1.15)
                                return true
                            end
                        }))
                        delay(0.15)
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                G.jokers:shuffle('aajk')
                                play_sound('cardSlide1', 1)
                                return true
                            end
                        }))
                        delay(0.5)
                        return true
                    end
                }))
            end
             return {message = "Shuffle!"}
        end
    end,
    calculate = function(self, card, context)
       if context.setting_blind  then
            card.ability.extra.var1 = card.ability.extra.var1 + 1
            if card.ability.extra.var1 >= 6 then
                --print("killing self")
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "-"..tostring(card.ability.extra.joker_slots).." Joker Slot", colour = G.C.DARK_EDITION})
                G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.joker_slots
                return {
                    func = function()
                local target_joker = nil
                for i, joker in ipairs(G.jokers.cards) do
                    if joker.config.center.key == "j_howie_pianozombie" and not joker.getting_sliced then
                        target_joker = joker
                        break
                    end
                end
                
                if target_joker then
                    if target_joker.ability.eternal then
                        target_joker.ability.eternal = nil
                    end
                    target_joker.getting_sliced = true
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            target_joker:start_dissolve({G.C.RED}, nil, 1.6)
                            return true
                        end
                    }))
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Destroyed!", colour = G.C.RED})
                end
                    return true
                end
                }
            end
        end
    end
}
