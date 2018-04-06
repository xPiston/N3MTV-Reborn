RegisterServerEvent('paycheck:salary')
AddEventHandler('paycheck:salary', function()
	local mysource = source
	local salary = 50
	TriggerEvent('es:getPlayerFromId', mysource, function(user)
		-- Ajout de l'argent à l'utilisateur
		local user_id = user.getIdentifier()
		-- Requête qui permet de recuperer le métier de l'utilisateur
		MySQL.Async.fetchAll("SELECT salary FROM users INNER JOIN jobs ON users.job = jobs.job_id WHERE identifier = @username",{['@username'] = user_id}, function(result)
			if(result ~= nil and result[1] ~= nil) then
				local salary_job = result[1].salary
				user.addMoney((salary + salary_job))
				TriggerClientEvent("es_freeroam:notify", mysource, "CHAR_BANK_MAZE", 1, "Maze Bank", false, "Prime de temps de connexion :  + "..salary.."~g~€~s~~n~Salaire métier reçu : + "..salary_job.." ~g~$")
			end
		end)
	end)
end)
