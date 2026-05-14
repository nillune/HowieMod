G.TENNA = {
    meow = ""
}
function create_UIBox_with_text_input()
    local t = create_UIBox_generic_options({
         back_delay = 999999,
        back_label = "Back",
        colour = G.C.BLACK,
        padding = 0.5,
        contents = {
            {n = G.UIT.R, config = {padding = 0.1}, nodes = {
                 create_text_input({
            w = 4, max_length = 16,prompt_text = 'Enter Name',
            ref_table = G.TENNA, ref_value = 'meow'
          }), UIBox_button{button = "confirm_meow", colour = G.C.PALE_GREEN, minw = 2.65, minh = 1, label = {'Confirm'}, scale = 0.5},
            }}
        }
    })
    return t
    
end
G.FUNCS.confirm_meow = function(e)
    print(G.TENNA.meow)
end
if  G.TENNA.meow == "meow" then
    print("meow")
end
local function tennatest(Question, Correct, Wrong1, Wrong2, Wrong3)

    if math.random(1, 2) == 2 then
        local temp1
        temp1 = Wrong1
        Wrong1 = Wrong2
        Wrong2 = temp1
    end
    if math.random(1, 2) == 2 then
        local temp2
        temp2 = Wrong2
        Wrong2 = Wrong3
        Wrong3 = temp2
    end
    if math.random(1, 2) == 2 then
        local temp3
        temp3 = Wrong1
        Wrong1 = Wrong3
        Wrong3 = temp3
    end

    -- the ones above swap what values the wrong answers are, so they'll appear in different rows, not really needed but just to mix things
    -- there's probably a better way to do this but damn if i know
    -- this decides what row the correct answer is on
    local decider = math.random(1, 4)
     --decider = 1
    if decider == 1 then
        local t = create_UIBox_generic_options({
             back_delay = 999999,
            back_label = "",
            colour = G.C.BLACK,
            padding = 0,
            contents = {
                {n=G.UIT.R, config={align = "cm"}, nodes={ {n = G.UIT.R, config = {padding = 0.1}, nodes = {
          
                
        }},
                UIBox_button({
                    button = "question",
                    label = {Question},
                    minw = 10,
                    maxw = 10,
                    minh = 3,
                    scale = 0.8,
                    shadow = false,
                    config={align = "cm"},
                    colour = G.C.GREEN,
                    focus_args = {
                        nav = 'wide',
                        button = 'x',
                        set_button_pip = true
                    }
                }), UIBox_button({
                    button = "correct",
                    label = {Correct},
                    minw = 6.5,
                    maxw = 5,
                    minh = 1.2,
                    scale = 0.7,
                    shadow = true,
                    colour = G.C.BLUE,
                    focus_args = {
                        nav = 'wide',
                        button = 'x',
                        set_button_pip = true
                    }
                }), UIBox_button({
                    button = "wrong",
                    label = {Wrong1},
                    minw = 6.5,
                    maxw = 5,
                    minh = 1.2,
                    scale = 0.7,
                    shadow = true,
                    colour = G.C.BLUE,
                    focus_args = {
                        nav = 'wide',
                        button = 'x',
                        set_button_pip = true
                    }
                }), UIBox_button({
                    button = "wrong",
                    label = {Wrong2},
                    minw = 6.5,
                    maxw = 5,
                    minh = 1.2,
                    scale = 0.7,
                    shadow = true,
                    colour = G.C.BLUE,
                    focus_args = {
                        nav = 'wide',
                        button = 'x',
                        set_button_pip = true
                    }
                }), UIBox_button({
                    button = "wrong",
                    label = {Wrong3},
                    maxw = 5,
                    minh = 1.2,
                    minw = 6.5,
                    scale = 0.7,
                    shadow = true,
                    colour = G.C.BLUE,
                    focus_args = {
                        nav = 'wide',
                        button = 'x',
                        set_button_pip = true
                    }
                })
                }}
            }
        
        })
        return t
    elseif decider == 2 then
        local t = create_UIBox_generic_options({
             back_delay = 999999,
            back_label = "",
            colour = G.C.BLACK,
            padding = 0,
            contents = {
                UIBox_button({
                    button = "question",
                    label = {Question},
                    minw = 10,
                    maxw = 10,
                    minh = 3,
                    scale = 0.8,
                    shadow = false,
                    colour = G.C.GREEN,
                    focus_args = {
                        nav = 'wide',
                        button = 'x',
                        set_button_pip = true
                    }
                }), UIBox_button({
                    button = "wrong",
                    label = {Wrong1},
                    minw = 6.5,
                    maxw = 5,
                    minh = 1.2,
                    scale = 0.7,
                    shadow = true,
                    colour = G.C.BLUE,
                    focus_args = {
                        nav = 'wide',
                        button = 'x',
                        set_button_pip = true
                    }
                }), UIBox_button({
                    button = "correct",
                    label = {Correct},
                    minw = 6.5,
                    maxw = 5,
                    minh = 1.2,
                    scale = 0.7,
                    shadow = true,
                    colour = G.C.BLUE,
                    focus_args = {
                        nav = 'wide',
                        button = 'x',
                        set_button_pip = true
                    }
                }), UIBox_button({
                    button = "wrong",
                    label = {Wrong2},
                    minw = 6.5,
                    maxw = 5,
                    minh = 1.2,
                    scale = 0.7,
                    shadow = true,
                    colour = G.C.BLUE,
                    focus_args = {
                        nav = 'wide',
                        button = 'x',
                        set_button_pip = true
                    }
                }), UIBox_button({
                    button = "wrong",
                    label = {Wrong3},
                    minw = 6.5,
                    maxw = 5,
                    minh = 1.2,
                    scale = 0.7,
                    shadow = true,
                    colour = G.C.BLUE,
                    focus_args = {
                        nav = 'wide',
                        button = 'x',
                        set_button_pip = true
                    }
                })

            }

        })
        return t
    elseif decider == 3 then
        local t = create_UIBox_generic_options({
             back_delay = 999999,
            back_label = "",
            colour = G.C.BLACK,
            padding = 0,
            contents = {
                UIBox_button({
                    button = "question",
                    label = {Question},
                    minw = 10,
                    maxw = 10,
                    minh = 3,
                    scale = 0.8,
                    shadow = false,
                    colour = G.C.GREEN,
                    focus_args = {
                        nav = 'wide',
                        button = 'x',
                        set_button_pip = true
                    }
                }), UIBox_button({
                    button = "wrong",
                    label = {Wrong1},
                    minw = 6.5,
                    maxw = 5,
                    minh = 1.2,
                    scale = 0.7,
                    shadow = true,
                    colour = G.C.BLUE,
                    focus_args = {
                        nav = 'wide',
                        button = 'x',
                        set_button_pip = true
                    }
                }), UIBox_button({
                    button = "wrong",
                    label = {Wrong2},
                    minw = 6.5,
                    maxw = 5,
                    minh = 1.2,
                    scale = 0.7,
                    shadow = true,
                    colour = G.C.BLUE,
                    focus_args = {
                        nav = 'wide',
                        button = 'x',
                        set_button_pip = true
                    }

                }), UIBox_button({
                    button = "correct",
                    label = {Correct},
                    minw = 6.5,
                    maxw = 5,
                    minh = 1.2,
                    scale = 0.7,
                    shadow = true,
                    colour = G.C.BLUE,
                    focus_args = {
                        nav = 'wide',
                        button = 'x',
                        set_button_pip = true
                    }
                }), UIBox_button({
                    button = "wrong",
                    label = {Wrong3},
                    minw = 6.5,
                    maxw = 5,
                    minh = 1.2,
                    scale = 0.7,
                    shadow = true,
                    colour = G.C.BLUE,
                    focus_args = {
                        nav = 'wide',
                        button = 'x',
                        set_button_pip = true
                    }
                })

            }

        })
        return t
    elseif decider == 4 then
        local t = create_UIBox_generic_options({
             back_delay = 999999,
            back_label = "",
            colour = G.C.BLACK,
            padding = 0,
            contents = {
                UIBox_button({
                    button = "question",
                    label = {Question},
                    minw = 10,
                    maxw = 10,
                    minh = 3,
                    scale = 0.8,
                    shadow = false,
                    colour = G.C.GREEN,
                    focus_args = {
                        nav = 'wide',
                        button = 'x',
                        set_button_pip = true
                    }
                }), UIBox_button({
                    button = "wrong",
                    label = {Wrong1},
                    minw = 6.5,
                    maxw = 5,
                    minh = 1.2,
                    scale = 0.7,
                    shadow = true,
                    colour = G.C.BLUE,
                    focus_args = {
                        nav = 'wide',
                        button = 'x',
                        set_button_pip = true
                    }
                }), UIBox_button({
                    button = "wrong",
                    label = {Wrong2},
                    minw = 6.5,
                    maxw = 5,
                    minh = 1.2,
                    scale = 0.7,
                    shadow = true,
                    colour = G.C.BLUE,
                    focus_args = {
                        nav = 'wide',
                        button = 'x',
                        set_button_pip = true
                    }

                }), UIBox_button({
                    button = "wrong",
                    label = {Wrong3},
                    minw = 6.5,
                    maxw = 5,
                    minh = 1.2,
                    scale = 0.7,
                    shadow = true,
                    colour = G.C.BLUE,
                    focus_args = {
                        nav = 'wide',
                        button = 'x',
                        set_button_pip = true
                    }
                }), UIBox_button({
                    button = "correct",
                    label = {Correct},
                    minw = 6.5,
                    maxw = 5,
                    minh = 1.2,
                    scale = 0.7,
                    shadow = true,
                    colour = G.C.BLUE,
                    focus_args = {
                        nav = 'wide',
                        button = 'x',
                        set_button_pip = true
                    }
                })

            }

        })
        return t
    end
end
local looptimes
local isFlipped
G.FUNCS = G.FUNCS or {}
G.FUNCS.correct = function(e)
     play_sound("howie_coin", 1,12)
    ease_dollars(5)
    G.OVERLAY_MENU:remove()
    G.OVERLAY_MENU = nil
    if isFlipped then
        for _, joker in ipairs(G.jokers.cards) do joker:flip() end
        isFlipped = false
    end
    if looptimes > 0 then
        looptimes = looptimes -1
        QuizQuestion(looptimes)
    end
end
G.FUNCS = G.FUNCS or {}
G.FUNCS.wrong = function(e)
    play_sound("howie_hurt", 1 ,6)
    ease_dollars(-5)
    G.OVERLAY_MENU:remove()
    G.OVERLAY_MENU = nil
    if isFlipped then
        for _, joker in ipairs(G.jokers.cards) do joker:flip() end
        isFlipped = false
    end
    if looptimes > 0 then
        looptimes = looptimes -1
        QuizQuestion(looptimes)
    end
end
G.FUNCS = G.FUNCS or {}
G.FUNCS.question = function(e) end
local askedQuestions = {}
function QuizQuestion(looptimes2)
    looptimes = looptimes2
     math.randomseed(os.time())
    local QuizNumber = math.random(1, 28)
     --QuizNumber = 28
     for i=1,99 do
    if askedQuestions[QuizNumber] == true then
       QuizNumber = math.random(1, 28)
    else
        askedQuestions[QuizNumber] = true 
        break
    end
    if i == 99 then
        print("guh")
    end
end
    if QuizNumber == 1 then
        G.FUNCS.overlay_menu {
            definition = tennatest(
                "Which joker can be copied\n by Blueprint/Brainstorm?",
                "Midas Mask", "Trading Card", "Paradolia", "Golden Joker"),
            config = {no_esc = false}
        }
    elseif QuizNumber == 2 then
        G.FUNCS.overlay_menu {
            definition = tennatest("Which one is the red one?", "Teto", "Neru",
                                   "Miku", "Gumi"),
            config = {no_esc = false}
        }

    elseif QuizNumber == 3 then
        G.FUNCS.overlay_menu {
            definition = tennatest(
                "Who does Lois call when\n Peter is stuck in the air?",
                "A Scientist", "A Fireman", "A Policeman", "A Magician"),
            config = {no_esc = false}
        }
    elseif QuizNumber == 4 then
        G.FUNCS.overlay_menu {
            definition = tennatest(
                "Which enhancement is not\n mentioned by any vanilla jokers?",
                "Wild", "Steel", "Lucky", "Gold"),
            config = {no_esc = false}
        }
    elseif QuizNumber == 5 then
        G.FUNCS.overlay_menu {
            definition = tennatest(
                "What's the prize\n for answering correctly?", "Money",
                "New car", "Mercy", "More questions"),
            config = {no_esc = false}
        }
    elseif QuizNumber == 6 then
        G.FUNCS.overlay_menu {
            definition = tennatest(
                'What is the first event tower\n in the roblox game "Tower Battles"',
                "Scarecrow", "Resting Soldier", "Graveyard", "Elf"),
            config = {no_esc = false}
        }
    elseif QuizNumber == 7 then
        G.FUNCS.overlay_menu {
            definition = tennatest(
                'What is the hightly memorable\n heading of of "TV TIME?"',
                "Marvelous Mystery Board", "Magical Mystery Board",
                "Don't lick the screen!", "Don't touch that Dial!"),
            config = {no_esc = false}
        }
    elseif QuizNumber == 8 then
        G.FUNCS.overlay_menu {
            definition = tennatest(
                'How much does Chomper cost to\n place in Plants vs Zombies 1',
                "150 Sun", "125 Sun", "175 Sun", "100 Sun"),
            config = {no_esc = false}
        }
    elseif QuizNumber == 9 and #G.jokers.cards > 3 then
        G.FUNCS.overlay_menu {
            definition = tennatest('How many Jokers do you have',
                                   tostring(#G.jokers.cards),
                                   tostring(#G.jokers.cards + 1),
                                   tostring(#G.jokers.cards - 1),
                                   tostring(#G.jokers.cards + 2)),
            config = {no_esc = false}
        }
    elseif QuizNumber == 10 and #G.jokers.cards > 3 then
        local jokername
        local twojokername
        local threejokername
        local fourjokername
        for _, joker in ipairs(G.jokers.cards) do joker:flip() end
        isFlipped = true
        if G.jokers.cards[1].config.center.loc_txt == nil then
            jokername = G.jokers.cards[1].config.center.name
        else
            jokername = G.jokers.cards[1].config.center.loc_txt['name']
        end
        if G.jokers.cards[2].config.center.loc_txt == nil then
            twojokername = G.jokers.cards[2].config.center.name
        else
            twojokername = G.jokers.cards[2].config.center.loc_txt['name']
        end
        if G.jokers.cards[3].config.center.loc_txt == nil then
            threejokername = G.jokers.cards[3].config.center.name
        else
            threejokername = G.jokers.cards[3].config.center.loc_txt['name']
        end
        if G.jokers.cards[4].config.center.loc_txt == nil then
            fourjokername = G.jokers.cards[4].config.center.name
        else
            fourjokername = G.jokers.cards[4].config.center.loc_txt['name']
        end
        G.FUNCS.overlay_menu {
            definition = tennatest('What is your leftmost joker?', jokername,
                                   twojokername, threejokername, fourjokername),
            config = {no_esc = false}
        }
    elseif QuizNumber == 10 and #G.jokers.cards <= 3 or QuizNumber == 9 and
        #G.jokers.cards <= 3 then
        G.FUNCS.overlay_menu {
            definition = tennatest(
                'How much does Chomper cost to\n place in Plants vs Zombies 1?',
                "150 Sun", "125 Sun", "175 Sun", "100 Sun"),
            config = {no_esc = false}
        }
    elseif QuizNumber == 11 then
        G.FUNCS.overlay_menu {
            definition = tennatest("Which of Mint's cats has no tail?",
                                   "Caroline", "Loki", "Ivy", "Ava"),
            config = {no_esc = false}
        }
    elseif QuizNumber == 12 then
        G.FUNCS.overlay_menu {
            definition = tennatest("Who has the most aura?", "Triple T",
                                   "Tralalero Tralala", "Ballerina Cappuccina",
                                   "Bombardiro Crocodilo"),
            config = {no_esc = false}
        }
    elseif QuizNumber == 13 then
        G.FUNCS.overlay_menu {
            definition = tennatest('What does "The Fish"\n boss blind do?',
                                   "Cards drawn face down after each hand played",
                                   "Cards played previously this Ante are debuffed",
                                   "All Diamond cards are debuffed",
                                   "Must play 5 cards"),
            config = {no_esc = false}
        }
    elseif QuizNumber == 14 then
        G.FUNCS.overlay_menu {
            definition = tennatest(
                'Which Family Guy Character\n did not appear in the first episode',
                "Joe", "Hitler", "Cleveland", "Quagmire"),
            config = {no_esc = false}
        }
    elseif QuizNumber == 15 and #G.jokers.cards > 2 then

        G.FUNCS.overlay_menu {
            definition = tennatest('What is the cost of\n your 2nd joker?',
                                   tostring(G.jokers.cards[2].config.center.cost),
                                   tostring(
                                       G.jokers.cards[2].config.center.cost + 2),
                                   tostring(
                                       G.jokers.cards[2].config.center.cost - 2),
                                   "6"),
            config = {no_esc = false}
        }
    elseif QuizNumber == 17 then

        G.FUNCS.overlay_menu {
            definition = tennatest('How many Tarots have you used this match?',
                                   tostring(
                                       (G.GAME.consumeable_usage_total and
                                           G.GAME.consumeable_usage_total.tarot or
                                           0)),
                                   tostring(
                                       (G.GAME.consumeable_usage_total and
                                           G.GAME.consumeable_usage_total.tarot or
                                           0) - math.random(1, 10)),
                                   tostring(
                                       (G.GAME.consumeable_usage_total and
                                           G.GAME.consumeable_usage_total.tarot or
                                           0) + math.random(1, 10)),
                                   tostring(
                                       (G.GAME.consumeable_usage_total and
                                           G.GAME.consumeable_usage_total.tarot or
                                           0) + math.random(-5, 5))),
            config = {no_esc = false}
        }
    elseif QuizNumber == 16 then

        G.FUNCS.overlay_menu {
            definition = tennatest(
                "How many cards have you \n discarded this run",
                tostring(G.GAME.round_scores.cards_discarded.amt), tostring(
                    G.GAME.round_scores.cards_discarded.amt -
                        math.random(20, 50)), tostring(
                    G.GAME.round_scores.cards_discarded.amt +
                        math.random(20, 50)), tostring(
                    G.GAME.round_scores.cards_discarded.amt +
                        math.random(-50, 50))),
            config = {no_esc = false}
        }
    elseif QuizNumber == 18 then

        G.FUNCS.overlay_menu {
            definition = tennatest(
                "How many times have you \n rerolled the shop this run",
                tostring(G.GAME.round_scores.times_rerolled.amt), tostring(
                    G.GAME.round_scores.times_rerolled.amt - math.random(1, 30)),
                tostring(
                    G.GAME.round_scores.times_rerolled.amt + math.random(1, 30)),
                tostring(
                    G.GAME.round_scores.times_rerolled.amt +
                        math.random(-20, 20))),
            config = {no_esc = false}
        }
    elseif QuizNumber == 19 then

        G.FUNCS.overlay_menu {
            definition = tennatest(
                "How many times have you \n bought a card this run",
                tostring(G.GAME.round_scores.cards_purchased.amt), tostring(
                    G.GAME.round_scores.cards_purchased.amt - math.random(1, 30)),
                tostring(
                    G.GAME.round_scores.cards_purchased.amt + math.random(1, 30)),
                tostring(
                    G.GAME.round_scores.cards_purchased.amt +
                        math.random(-20, 20))),
            config = {no_esc = false}
        }
    elseif QuizNumber == 20 then

        G.FUNCS.overlay_menu {
            definition = tennatest(
                "How many times have you \n played a playing card this run",
                tostring(G.GAME.round_scores.cards_played.amt), tostring(
                    G.GAME.round_scores.cards_played.amt - math.random(1, 30)),
                tostring(
                    G.GAME.round_scores.cards_played.amt + math.random(1, 30)),
                tostring(
                    G.GAME.round_scores.cards_played.amt + math.random(-20, 20))),
            config = {no_esc = false}
        }
    elseif QuizNumber == 21 then

        G.FUNCS.overlay_menu {
            definition = tennatest(
                "How much did your\n best hand this run score",
                tostring(G.GAME.round_scores.hand.amt),
                tostring(G.GAME.round_scores.hand.amt * math.random(2, 3)),
                tostring(
                    G.GAME.round_scores.cards_played.amt / math.random(2, 3)),
                tostring(G.GAME.round_scores.cards_played.amt +
                             math.random(-20000000000, 20000000000))),
            config = {no_esc = false}
        }
    elseif QuizNumber == 22 then

        G.FUNCS.overlay_menu {
            definition = tennatest("What is Mint's (me) favorite joker",
                                   "Baseball Card", "Perkeo", "Stuntman",
                                   "Madness"),
            config = {no_esc = false}
        }
    elseif QuizNumber == 23 then

        G.FUNCS.overlay_menu {
            definition = tennatest(
                "What is Mint's (me) favorite joker in this mod", "Pibble",
                "Family Guy DVD", "Moneyprint", "Pluey"),
            config = {no_esc = false}
        }
    elseif QuizNumber == 24 then

        G.FUNCS.overlay_menu {
            definition = tennatest(
                'What was the first name\n of the joker "Cleveland Orenthal Brown',
                "Story of Family Guy", "Seamus Levine", "Clown Peter",
                "Joe Cube"),
            config = {no_esc = false}
        }
    elseif QuizNumber == 25 then

        G.FUNCS.overlay_menu {
            definition = tennatest(
                'Which joker idea did Mint (me)\n get from reddit',
                "Spongebomb", "Howie", "Trashprint", "Spongeclock"),
            config = {no_esc = false}
        }
    elseif QuizNumber == 26 then

        G.FUNCS.overlay_menu {
            definition = tennatest(
                "What is Mint's (me)\n favorite pokemon",
                "Alolan Raichu", "Togepi", "Sylveon", "Marshadow"),
            config = {no_esc = false}
        }
    elseif QuizNumber == 27 then

        G.FUNCS.overlay_menu {
            definition = tennatest(
                "What was Mint's (me) most listened\n to song in 2025",
                "It's TV Time!", "Human After All", "Override", "I'm Your Captain Now"),
            config = {no_esc = false}
        }   
    elseif QuizNumber == 999 then --written question, gotta figure it out later
    
        G.FUNCS.overlay_menu {
           definition = create_UIBox_with_text_input(),
            config = {no_esc = false}
        }
    elseif QuizNumber == 28 then
        G.FUNCS.overlay_menu {
            definition = tennatest(
                "How many Subscribers does Erin have?",
                 tostring(Howie.config.ErinSubs), tostring(math.floor(Howie.config.ErinSubs*(math.random(1,20)/10))), tostring(math.floor(Howie.config.ErinSubs/(math.random(1,20)/10))), "0 cuz shes a loser"
                 ),
            config = {no_esc = false}
        }  
   
    end
end
