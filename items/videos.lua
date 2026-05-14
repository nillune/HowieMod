-- credits to SMG9000 for the code
function create_UIBox_custom_video1(name, buttonname, time, width, height)
    local file_path = SMODS.Mods["howie"].path .. "/assets/" .. name .. ".ogv"
    local file = NFS.read(file_path)
    love.filesystem.write("temp.ogv", file)
    local video_file = love.graphics.newVideo('temp.ogv')
    local vid_sprite = Sprite(0, 0, width * 5 / 9, height,
                              G.ASSET_ATLAS["ui_" ..
                                  (G.SETTINGS.colourblind_option and 2 or 1)],
                              {x = 0, y = 0})
    video_file:getSource():setVolume(G.SETTINGS.SOUND.volume *
                                         G.SETTINGS.SOUND.game_sounds_volume /
                                         (100 * 10))
    vid_sprite.video = video_file
    video_file:play()

    local t = create_UIBox_generic_options({
        back_delay = time,
        back_label = buttonname,
        colour = G.C.BLACK,
        padding = 0,
        contents = {{n = G.UIT.O, config = {object = vid_sprite}}}
    })

    return t

end
function playVideo(VideoName, VideoTime, ButtonText)
   
     G.FUNCS.overlay_menu {
                definition = create_UIBox_custom_video1(VideoName, ButtonText, VideoTime, 20, 11),
                config = {no_esc = true}
            }
end

function watchTV()
  
    FamilyRandom = math.random(0, 99)
    local FamilyVar = "Family" .. FamilyRandom
    Howie.config.ClipsWatched = Howie.config.ClipsWatched + 1
   SMODS.save_mod_config(Howie.config.ClipsWatched)
   print( Howie.config.ClipsWatched )
    G.ClipPlayed = true
    NoMusic = true
    FamilyvideoTime = 30
    G.ClipPlayed = true
    if FamilyRandom == 9 then BrianDeath = true end
     if  G.GAME.used_vouchers["v_howie_family_tier1"] then 
         FamilyvideoTime = FamilyvideoTime - 8
     end
    if (G.STAGE == G.STAGES.RUN or G.STATE == G.STATES.PLAY_TAROT) and type(G.jokers) == "table" and type(G.jokers.cards) == "table" then
        for i = 1, #G.jokers.cards do
            local card = G.jokers.cards[i]
            if card and card.config and card.config.center and card.config.center.key == "j_howie_loisgriffin" then
                FamilyvideoTime = FamilyvideoTime / 3
                break
            end
        end
    end
   
if   G.GAME.used_vouchers["v_howie_family_tier2"] and  isWholeNumber(Howie.config.ClipsWatched/3) then
else
     local success, result_or_error_message = pcall(playVideo, FamilyVar, FamilyvideoTime, "This is funny.")
      --print(success)
     while not success do
        FamilyRandom = math.random(0, 99)
        
    FamilyVar = "Family" .. FamilyRandom
       success = pcall(playVideo, FamilyVar, FamilyvideoTime, "This is funny.")
        end
     end
        
     


return true
end
