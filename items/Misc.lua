math.randomseed(os.time())

SMODS.Stake {
    name = "Mint Stake",
    key = "mint",
    applied_stakes = {"stake_gold"},
    pos = {x = 3, y = 1},
    sticker_atlas = "stickers",
    sticker_pos = {x = 3, y = 1},
    atlas = "Stakes",
    modifiers = function()
        G.GAME.starting_params.discards = G.GAME.starting_params.discards + 1
    end,
    loc_txt = {
        ['name'] = 'Mint Stake',
        ['text'] = {
            "Gold Stake but with the discard", "Courtesy of me, mint :3"

        }

    },
    above_stake = "stake_blue",
    colour = G.C.PINK,
    -- shiny = true,
    prefix_config = {applied_stakes = {mod = false}}
}


SMODS.Voucher {
    key = 'sub_normal',
    pos = {x = 0, y = 0},
    Cost = 10,
    atlas = 'VoucherAtlas',
    loc_txt = {
        ['default'] = {
            name = 'Wheel of Win',
            text = {
                '{C:tarot,T:c_wheel_of_fortune}Wheel Of Fortune{} is {C:attention}1 in 2{}',
                'and always turns {C:attention}Jokers{} {C:dark_edition,T:e_polychrome}Polychrome{}'
            }
        }
    },
    loc_vars = function(self, info_queue, card) end,
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({func = function() return true end}))
    end
}
SMODS.Voucher {
    key = 'sub_tier2',
    Cost = 10,
    requires = {"v_howie_sub_normal"},
    pos = {x = 1, y = 0},
    atlas = 'VoucherAtlas',
    loc_txt = {
        ['default'] = {
            name = 'Wheel of Super Win',
            text = {
                '{C:tarot,T:c_wheel_of_fortune}Wheel Of Fortune{} is {C:attention}3 in 4{}',
                'and only turns {C:attention}Jokers{} {C:dark_edition,T:e_negative}Negative{}'
            }
        }
    },
    loc_vars = function(self, info_queue, card) end,
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({func = function() return true end}))
    end
}
SMODS.Voucher {
    key = 'family_tier1',
    Cost = 10,
    -- requires = {"v_howie_sub_normal"},
    pos = {x = 2, y = 0},
    atlas = 'VoucherAtlas',
    loc_txt = {
        ['default'] = {
            name = 'Anti-Family',
            text = {
                '{C:spectral}Family Guy Clip{} watch time',
                'is reduced by {C:attention}8{} seconds'

            }
        }
    },
    loc_vars = function(self, info_queue, card) end,
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({func = function() return true end}))
    end
}
SMODS.Voucher {
    key = 'family_tier2',
    Cost = 10,
    requires = {"v_howie_family_tier2"},
    pos = {x = 5, y = 0},
    atlas = 'VoucherAtlas',
    loc_txt = {
        ['default'] = {
            name = 'Anti-Family',
            text = {
                'Every {C:attention}third{} {C:spectral}Family Guy Clip{} is skipped',
                '{s:0.8}(Still counts as being watched){}'

            }
        }
    },
    loc_vars = function(self, info_queue, card) end,
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({func = function() return true end}))
    end
}
SMODS.Voucher {
    key = 'erin_tier1',
    Cost = 10,
    -- requires = {"v_howie_family_tier2"},
    pos = {x = 3, y = 0},
    config = {extra = {repetitions = 15}},
    atlas = 'VoucherAtlas',
    loc_txt = {
        ['default'] = {
            name = 'Clonerining',
            text = {
                'Adds {C:attention}#1#{} Random {C:green,E:1,s:2}Green{}',
                'Playing cards to your deck'
            }
        }
    },
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.repetitions}}
    end,
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                for i = 1, card.ability.extra.repetitions do
                    local card_front = pseudorandom_element(G.P_CARDS,
                                                            pseudoseed(
                                                                'add_card_hand'))
                    local base_card = create_playing_card({
                        front = card_front,
                        center = G.P_CENTERS.m_howie_green
                    }, G.discard, true, false, nil, true)

                    G.playing_card = (G.playing_card and G.playing_card + 1) or
                                         1
                    local new_card = copy_card(base_card, nil, nil,
                                               G.playing_card)
                    new_card:add_to_deck()
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    G.deck:emplace(new_card)
                    table.insert(G.playing_cards, new_card)

                    base_card:remove()

                    G.E_MANAGER:add_event(Event({
                        func = function()
                            new_card:start_materialize()
                            return true
                        end
                    }))
                    -- card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Added Card!", colour = G.C.GREEN})
                end
                return true
            end
        }))
    end
}

SMODS.Voucher {
    key = 'erin_tier2',
    Cost = 10,
    requires = {"v_howie_erin_tier1"},
    pos = {x = 4, y = 0},
    config = {extra = {seal = 'Red'}},
    atlas = 'VoucherAtlas',
    loc_txt = {
        ['default'] = {
            name = 'Redering',
            text = {
                'All {C:green,E:1,s:2}Green{} cards in your deck',
                'Gain a #1# Seal'
            }
        }
    },
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.seal}}
    end,
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                for _, playing_card in pairs(G.playing_cards or {}) do
                    if SMODS.get_enhancements(playing_card)["m_howie_green"] then
                        -- print("meow")
                        playing_card:set_seal(card.ability.extra.seal, nil, true)

                    end

                end
                return true
            end
        }))
    end
}
SMODS.PokerHand({
    key = "Bulwark",
    visible = false,
    chips = 170,
    mult = 10,
    l_chips = 60,
    l_mult = 2,
    loc_txt = {
        ['default'] = {name = 'Family House', description = {'5 Family Cards'}}
    },
    config = {},
    example = {
        {'S_A', true, enhancement = 'm_howie_familycard'},
        {'S_A', true, enhancement = 'm_howie_familycard'},
        {'S_A', true, enhancement = 'm_howie_familycard'},
        {'S_A', true, enhancement = 'm_howie_familycard'},
        {'S_A', true, enhancement = 'm_howie_familycard'}
    },
    -- mpos = { x = 0, y = 0 },
    evaluate = function(parts, hand)
        local stones = {}
        for i, card in ipairs(hand) do

            if card.config.center_key == familycardArray[1] or
                card.config.center_key == familycardArray[2] then
                stones[#stones + 1] = card
            end
        end
        return #stones >= 5 and {stones} or {}
    end
})

-- Enhanced loader/drawer that supports:
-- 1) simple image (string filename) -> {type='image', image=...}
-- 2) sprite sheet -> {type='sheet', image=..., quads={...}, frame_time=..., frames=...}
-- 3) sequence of files -> {type='sequence', images={...}, frame_time=..., frames=...}
-- Usage: howie.MyAnim = loadThatFuckingImage("file.png") or loadThatFuckingImage{type='sheet', file='anim.png', fw=..., fh=..., ft=0.08}
function loadThatFuckingImage(fn)
    local function loadImageFromFile(full_path)
        local file_data = assert(NFS.newFileData(full_path),
                                 ("Failed to open " .. tostring(full_path)))
        local tempimagedata = assert(love.image.newImageData(file_data),
                                     ("Failed to decode image data: " ..
                                         tostring(full_path)))
        return assert(love.graphics.newImage(tempimagedata),
                      ("Failed to create image: " .. tostring(full_path)))
    end

    -- if a plain string, load a single image
    if type(fn) == 'string' then
        local full = howie.path .. fn
        return {type = 'image', image = loadImageFromFile(full)}
    end

    -- if a table, expect either 'sheet' or 'sequence'
    if type(fn) == 'table' then
        if fn.type == 'sheet' then
            -- required fields: file, fw (frame width), fh (frame height)
            assert(fn.file, "sheet requires .file")
            assert(fn.fw and fn.fh,
                   "sheet requires .fw and .fh (frame width/height)")
            local full = howie.path .. fn.file
            local image = loadImageFromFile(full)
            local iw, ih = image:getWidth(), image:getHeight()
            local cols = math.floor(iw / fn.fw)
            local rows = math.floor(ih / fn.fh)
            assert(cols >= 1 and rows >= 1, "invalid frame sizes for image")
            local quads = {}
            for ry = 0, rows - 1 do
                for cx = 0, cols - 1 do
                    quads[#quads + 1] = love.graphics.newQuad(cx * fn.fw,
                                                              ry * fn.fh, fn.fw,
                                                              fn.fh, iw, ih)
                end
            end
            local frame_time = fn.ft or 0.08
            return {
                type = 'sheet',
                image = image,
                quads = quads,
                frame_time = frame_time,
                frames = #quads,
                fw = fn.fw,
                fh = fn.fh
            }
        elseif fn.type == 'sequence' then
            -- pattern example: pattern = "anim_%d.png", count = 12
            assert(fn.pattern and fn.count,
                   "sequence requires pattern and count")
            local imgs = {}
            for i = 1, fn.count do
                local filename = string.format(fn.pattern, i)
                local full = howie.path .. filename
                imgs[#imgs + 1] = loadImageFromFile(full)
            end
            local frame_time = fn.ft or 0.08
            return {
                type = 'sequence',
                images = imgs,
                frame_time = frame_time,
                frames = #imgs
            }
        else
            error("unknown animation type: " .. tostring(fn.type))
        end
    end

    error("unsupported argument to loadThatFuckingImage")
end

-- Generic draw helper. Call this inside love.draw where you currently call love.graphics.draw.
-- x,y are top-left coordinates; r,sx,sy are optional (rotation and scales) to match love.graphics.draw signature.
function drawThatFuckingImage(asset, x, y, r, sx, sy)
    r = r or 0
    sx = sx or 1
    sy = sy or sx or 1
    if not asset then return end

    if asset.type == 'image' then
        love.graphics.draw(asset.image, x, y, r, sx, sy)
        return
    end

    if asset.type == 'sheet' then
        local t = love.timer.getTime()
        local idx = math.floor(t / asset.frame_time) % asset.frames + 1
        local quad = asset.quads[idx]
        love.graphics.draw(asset.image, quad, x, y, r,
                           sx * (asset.fw / asset.image:getWidth()),
                           sy * (asset.fh / asset.image:getHeight()))
        return
    end

    if asset.type == 'sequence' then
        local t = love.timer.getTime()
        local idx = math.floor(t / asset.frame_time) % asset.frames + 1
        local img = asset.images[idx]
        love.graphics.draw(img, x, y, r, sx, sy)
        return
    end
end
-- thanks ai

function isWholeNumber(num) return num == math.floor(num) end
--[[c
do
    if type(create_UIBox_buttons) == 'function' then
        local create_UIBox_buttonsRef = create_UIBox_buttons
        function create_UIBox_buttons()
            local t = create_UIBox_buttonsRef()

            -- Only modify when in a run and the current blind matches our boss key
            local on_endrun_boss = false
            if type(G) == 'table' and type(G.GAME) == 'table' and
                type(G.GAME.blind) == 'table' and G.GAME.blind.name then
                on_endrun_boss = (G.GAME.blind.name == 'boss_tenna') or
                                     (G.GAME.blind.key == 'boss_tenna')
            end

            if on_endrun_boss and t and t.nodes and type(t.nodes) == 'table' then
                -- Create a standalone End Run UI node (top-level sibling) using UIBox_button so it has a proper background.
                local TennaNode = UIBox_button({
                    id = 'tenna_button',
                    label = {'I LOVE TV!'},
                    button = 'tenna_button',
                    minw = 1.8,
                    minh = 1.3,
                    scale = 0.4,
                    col = true,
                    colour = G.C.PALE_RED,
                    one_press = false
                })

                -- Try to find the index of the play/discard button node at the top-level and insert BEFORE it (so End Run is left of Play).
                local insert_index = nil
                for idx, node in ipairs(t.nodes) do
                    -- direct button node
                    if node and node.config and node.config.button and
                        (node.config.button == 'play_cards_from_highlighted' or
                            node.config.button ==
                            'discard_cards_from_highlighted') then
                        insert_index = idx
                        break
                    end
                    -- or a wrapper that contains the button
                    if node and node.nodes and type(node.nodes) == 'table' then
                        for _, sub in ipairs(node.nodes) do
                            if sub and sub.config and sub.config.button and
                                (sub.config.button ==
                                    'play_cards_from_highlighted' or
                                    sub.config.button ==
                                    'discard_cards_from_highlighted') then
                                insert_index = idx
                                break
                            end
                        end
                        if insert_index then break end
                    end
                end

                if insert_index then
                    table.insert(t.nodes, insert_index + 1, TennaNode)
                else
                    -- fallback: append to the end
                    table.insert(t.nodes, TennaNode)
                end
            end

            return t
        end
    end

    -- Handler to end the run: set the game state to GAME_OVER safely while in a run.
    G.FUNCS.tenna_button = function(e)
        print("End Run button pressed")
        G.ILoveTV = G.ILoveTV + 2
    end

end
--]]
-- Top-level: self-contained image/sheet loader and draw hook for Freddy animation
-- This code is intentionally outside the SMODS.Joker block.
do
    -- local helper: load a plain image file (defensive)
    local function loadImageFileSafe(fn)
        local ok, res = pcall(function()
            local full_path = howie.path .. fn
            local file_data = assert(NFS.newFileData(full_path))
            local tempimagedata = assert(love.image.newImageData(file_data))
            return assert(love.graphics.newImage(tempimagedata))
        end)
        if ok then return res end
        return nil
    end

    -- local helper: load a sprite-sheet into an asset table compatible with drawThatFuckingImage
    local function loadSpriteSheetLocal(file, frames, fw, fh, ft)
        if not file or not frames or not fw or not fh then return nil end
        local image = loadImageFileSafe(file)
        if not image then return nil end
        local iw, ih = image:getWidth(), image:getHeight()
        local cols = math.floor(iw / fw)
        local rows = math.floor(ih / fh)
        if cols < 1 or rows < 1 then return nil end
        local quads = {}
        local created = 0
        for ry = 0, rows - 1 do
            for cx = 0, cols - 1 do
                if created >= frames then break end
                quads[#quads + 1] = love.graphics.newQuad(cx * fw, ry * fh, fw,
                                                          fh, iw, ih)
                created = created + 1
            end
            if created >= frames then break end
        end
        local frame_time = ft or 0.08
        return {
            type = 'sheet',
            image = image,
            quads = quads,
            frame_time = frame_time,
            frames = #quads,
            fw = fw,
            fh = fh
        }
    end

    -- local draw helper (works standalone, doesn't require drawThatFuckingImage)
    local function drawSheetAsset(asset, x, y, r, sx, sy)
        if not asset then return end
        r = r or 0
        sx = sx or 1
        sy = sy or sx
        if asset.type == 'image' then
            love.graphics.draw(asset, x, y, r, sx, sy)
            return
        end
        if asset.type == 'sheet' then
            local t = love.timer.getTime()
            local idx = math.floor(t / asset.frame_time) % asset.frames + 1
            local quad = asset.quads[idx]
            love.graphics.draw(asset.image, quad, x, y, r, sx, sy)
            return
        end
        if asset.type == 'sequence' then
            local t = love.timer.getTime()
            local idx = math.floor(t / asset.frame_time) % asset.frames + 1
            local img = asset.images[idx]
            love.graphics.draw(img, x, y, r, sx, sy)
            return
        end
    end

    -- draw hook: preserve existing love.draw then add Freddy overlay
    local base_draw = love.draw
    love.draw = function(...)
        base_draw(...)

        if G and G.TennaDanceCount and (G.TennaDanceCount > 0) then
            if howie.TennaDanceAnim == nil then
                -- Update these to match your sprite sheet
                howie.TennaDanceAnim = loadSpriteSheetLocal(
                                           'tenna_dance_strip93.png', 93, 154,
                                           256, 0.02)
                if not howie.TennaDanceAnim then
                    G.TennaDanceCount = nil
                    return
                end
            end
            love.graphics.setColor(1, 1, 1, 1)
            drawSheetAsset(howie.TennaDanceAnim, 633, 156, 0, 3, 3)

            if G.TennaDanceCount <= 0 then G.TennaDanceCount = nil end
        end
    end
end
do
    -- local helper: load a plain image file (defensive)
    local function loadImageFileSafe(fn)
        local ok, res = pcall(function()
            local full_path = howie.path .. fn
            local file_data = assert(NFS.newFileData(full_path))
            local tempimagedata = assert(love.image.newImageData(file_data))
            return assert(love.graphics.newImage(tempimagedata))
        end)
        if ok then return res end
        return nil
    end

    -- local helper: load a sprite-sheet into an asset table compatible with drawThatFuckingImage
    local function loadSpriteSheetLocal(file, frames, fw, fh, ft)
        if not file or not frames or not fw or not fh then return nil end
        local image = loadImageFileSafe(file)
        if not image then return nil end
        local iw, ih = image:getWidth(), image:getHeight()
        local cols = math.floor(iw / fw)
        local rows = math.floor(ih / fh)
        if cols < 1 or rows < 1 then return nil end
        local quads = {}
        local created = 0
        for ry = 0, rows - 1 do
            for cx = 0, cols - 1 do
                if created >= frames then break end
                quads[#quads + 1] = love.graphics.newQuad(cx * fw, ry * fh, fw,
                                                          fh, iw, ih)
                created = created + 1
            end
            if created >= frames then break end
        end
        local frame_time = ft or 0.08
        return {
            type = 'sheet',
            image = image,
            quads = quads,
            frame_time = frame_time,
            frames = #quads,
            fw = fw,
            fh = fh
        }
    end

    -- local draw helper (works standalone, doesn't require drawThatFuckingImage)
    local function drawSheetAsset(asset, x, y, r, sx, sy)
        if not asset then return end
        r = r or 0
        sx = sx or 1
        sy = sy or sx
        if asset.type == 'image' then
            love.graphics.draw(asset, x, y, r, sx, sy)
            return
        end
        if asset.type == 'sheet' then
            local t = love.timer.getTime()
            local idx = math.floor(t / asset.frame_time) % asset.frames + 1
            local quad = asset.quads[idx]
            love.graphics.draw(asset.image, quad, x, y, r, sx, sy)
            return
        end
        if asset.type == 'sequence' then
            local t = love.timer.getTime()
            local idx = math.floor(t / asset.frame_time) % asset.frames + 1
            local img = asset.images[idx]
            love.graphics.draw(img, x, y, r, sx, sy)
            return
        end
    end
    -- draw hook: preserve existing love.draw then add Freddy overlay
    local base_draw = love.draw
    love.draw = function(...)
        base_draw(...)

        if G and G.TennaSuitCount and (G.TennaSuitCount > 0) then
            if howie.TennaSuitAnim == nil then
                -- Update these to match your sprite sheet
                howie.TennaSuitAnim = loadSpriteSheetLocal(
                                          'tennasuit_strip59.png', 59, 218, 256,
                                          0.03)
                if not howie.TennaSuitAnim then
                    G.TennaSuitCount = nil
                    return
                end
            end
            love.graphics.setColor(1, 1, 1, 1)
            drawSheetAsset(howie.TennaSuitAnim, 603, 156, 0, 3, 3)

            if G.TennaSuitCount <= 0 then G.TennaSuitCount = nil end
        end
    end
end
local drawhook = love.draw
function love.draw()
    drawhook()
    function loadThatFuckingImage(fn)
        local full_path = (howie.path .. fn)
        local file_data = assert(NFS.newFileData(full_path), ("Epic fail"))
        local tempimagedata = assert(love.image.newImageData(file_data),
                                     ("Epic fail 2"))
        return (assert(love.graphics.newImage(tempimagedata), ("Epic fail 3")))
    end
    local _xscale = 2 * love.graphics.getWidth() / 1920
    local _yscale = 2 * love.graphics.getHeight() / 1080
    if G.sadCount and (G.sadCount > 0) then
        if howie.SadTenna == nil then
            howie.SadTenna = loadThatFuckingImage("sadtenna.png")
        end
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(howie.SadTenna, 603, 250, 0, .9, .9)
        -- G.steveCount = G.steveCount - 1   
    end
end
SMODS.current_mod.optional_features = {retrigger_joker = true, post_trigger = true,} --why the hell is post trigger one of these
SMODS.Language {
    key = "comicsans",
    label = "Comic Sans",
    font = {
        file = "comicsans.ttf",
        render_scale = G.TILESIZE * 10,
        TEXT_HEIGHT_SCALE = 0.83,
        TEXT_OFFSET = {x = 10, y = -20},
        FONTSCALE = 0.1,
        squish = 1,
        DESCSCALE = 1
    }
}
