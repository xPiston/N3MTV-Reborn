-- NO TOUCHY, IF SOMETHING IS WRONG CONTACT KANERSPS! --
-- NO TOUCHY, IF SOMETHING IS WRONG CONTACT KANERSPS! --
-- NO TOUCHY, IF SOMETHING IS WRONG CONTACT KANERSPS! --
-- NO TOUCHY, IF SOMETHING IS WRONG CONTACT KANERSPS! --
local dlog = os.date("%Y%m%d%H%M%S")
print('Log File : logs/log_' .. dlog .. '.log')
os.execute("mkdir logs")
local fileLog = io.open('logs/log_' .. dlog .. '.log', 'w+')

function writeLog(log)
	fileLog:write(os.date("%Y/%m/%d %X") .. ' | ' .. log .. '\r\n')
	fileLog:flush()
end

function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end

function startswith(String,Start)
	return string.sub(String,1,string.len(Start))==Start
end

function returnIndexesInTable(t)
	local i = 0;
	for _,v in pairs(t)do
		i = i + 1
	end
	return i;
end

function debugMsg(msg)
	if(settings.defaultSettings.debugInformation and msg)then
		print("ES_DEBUG: " .. msg)
	end
end

AddEventHandler("es:debugMsg", debugMsg)