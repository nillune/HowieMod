SMODS.Atlas{
    key = 'tagatlas',
    path = 'tagatlas.png',
    px = 32,
    py = 32,
}


SMODS.Tag{
    key = 'tag_howiejoker',
    loc_txt= {
        name = 'Howie Tag',
        text = { "Immediately grants you a",
                "{C:attention}Howie Mod Joker{}", }},
    atlas = 'tagatlas',
    pos = { x = 1, y = 0 },
    min_ante = 1,


    apply = function(self, tag, context)
        tag:yep('+', G.C.DARK_EDITION, print() )

            local card = create_card("howie_jokers", G.Jokers, nil, nil, nil, nil, nil, "howietag")
            card:add_to_deck()
            G.jokers:emplace(card)
            play_sound("howie_vanish")

        tag.triggered = true
        return ret
    end,
}
SMODS.Tag{
    key = 'tag_erinjoker',
    loc_txt= {
        name = 'Erin Tag',
        text = { "Immediately grants you a",
                "{C:attention}Erin Joker{}", }},
    atlas = 'tagatlas',
    pos = { x = 0, y = 0 },
    min_ante = 1,


    apply = function(self, tag, context)
        tag:yep('+', G.C.DARK_EDITION, print() )

            local card = create_card("erin", G.Jokers, nil, nil, nil, nil, nil, "howietag")
            card:add_to_deck()
            G.jokers:emplace(card)
            play_sound("howie_vanish")

        tag.triggered = true
        return ret
    end,
}