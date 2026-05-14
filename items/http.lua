-- find the subscriber count text
--print("meow:", tostring(https.request("https://www.youtube.com/@the2ndbananalol")))
--https.asyncRequest("https://www.youtube.com/@the2ndbananalol",print)
--print("Subscriber count:", https.asyncRequest("https://www.youtube.com/@the2ndbananalol",print):match("subscribers"))
--[[
if not https.request("https://www.youtube.com/@the2ndbananalol") == 200 then
    local subs = https.request("https://www.youtube.com/@the2ndbananalol"):match('"subscriberCountText".-"text":"(.-)"')
  print("Subscriber count:", subs)
else
    if not https.request("https://www.youtube.com/@the2ndbananalol") == 200 then
    local subs = 
  print("Subscriber count:", https.request("https://www.youtube.com/@the2ndbananalol"):match('"subscriberCountText".-"text":"(.-)"'))
    else
        
  print("Subscriber count:", https.request("https://www.youtube.com/@the2ndbananalol"):match('"subscriberCountText".-"text":"(.-)"'))
    end
end
--]]

