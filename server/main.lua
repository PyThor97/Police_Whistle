local Core = exports.vorp_core:GetCore()

RegisterServerEvent("checkJobEvent")
AddEventHandler("checkJobEvent", function()
    local src = source
    local user = Core.getUser(src)
    local character = user.getUsedCharacter
    local job = character.job
    local HasJob = false

    -- בדיקת עבודה
    for _, jobAllowed in ipairs(Config.Jobs) do
        if job == jobAllowed then
            HasJob = true
        end
    end

    -- שליחת תוצאה ללקוח
    TriggerClientEvent("jobCheckResult", src, HasJob)
end)
