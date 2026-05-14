SMODS.Rarity {
    key = "joe",
    pools = {
        ["Joker"] = true
    },
    default_weight = 0.09,

    badge_colour = HEX('2a5fa1'),
    loc_txt = {
        name = "Joe"
    },
    get_weight = function(self, weight, object_type)
        --lol
        if  Howie.config["no_family"] then
            --print("familyoff")
            --print(Howie.config["no_family"])
            return 0
        end
        
        if  next(SMODS.find_card("j_howie_familygod"))  then
               --print("meow")
            return 5
        end
        if next(SMODS.find_card("j_howie_joeswanson"))  then
            print("joey")
            return 1
        end
            return weight
            
        end
    
}
SMODS.Rarity {
    key = "curse",
    pools = {
        ["Joker"] = true
    },
    default_weight = 0,

    badge_colour = HEX('ff00ff'),
    loc_txt = {
        name = "Curse"
    },
    get_weight = function(self, weight, object_type)
        return 0
    end
}