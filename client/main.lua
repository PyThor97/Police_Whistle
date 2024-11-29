local Core = exports.vorp_core:GetCore()
local hasJob = false

function DevPrint(...)
	if Config.DevMode then
		print(...)
	end
end

-- בקשה לבדוק את העבודה של השחקן
TriggerServerEvent("checkJobEvent")
DevPrint('Checking player job...')

RegisterNetEvent("jobCheckResult")
AddEventHandler("jobCheckResult", function(result)
	DevPrint('Job received!')
	if result then
		DevPrint('Player has the right job!')
		hasJob = true
	else
		DevPrint("Player doesn't have the right job")
		Core.NotifyRightTip("You don't have the right job", 4000)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerMounted = IsPedOnMount(PlayerPedId()) -- בדיקה בתוך הלולאה
		if playerMounted and hasJob then
			if IsControlJustPressed(0, Config.Key) then
				Citizen.InvokeNative(0x6FB1DA3CA9DA7D90,
					Config.SoundName,
					PlayerPedId(),
					'MOB3_Sounds',
					true, 
					0,
					0
				)
				Wait(5000)
				DevPrint('Player whistled.')
			end
		end
	end
end)
