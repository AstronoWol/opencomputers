local component = require("component")
local computer=require("computer")
local event = require("event")
local term = require("term")
local shell = require("shell")
local fs = require("filesystem")
local unicode=require("unicode")
local serial = require("serialization")
local sky = require("sky")
local g = component.gpu
event.shouldInterrupt = function () return false end
--------------------Настройки--------------------
local WIDTH, HEIGHT = 104, 30 --Разрешение моника 146/112 x 42
local COLOR1 = 0x00ffff --Рамка
local COLOR2 = 0x333333 --Цвет кнопок
local UPDATE = 300 --Апдейт отображения информации в сек.
local SCOREBOARDS = {"Helper1", "Helper2", "Modn", "Modn", "STMod", "GM", "GD", "Global", "TAdmin"}
local MOD_CHAT_COLOR = {"&a", "&2", "&6", "&6", "&3", "&9", "&9", "&8", "&8"}
local CHANGE_COLOR_NICKNAME = true --Смена цвета ника в мод.чате и листе
local CHANGE_SCOREBOARDS = true --Смена цвета в табе, при наличии скорбордов
-------------------------------------------------

local mid = WIDTH / 2
local admins = {}
local buf = {}
local buf1 = {}
local timer = 0
local stat = {"&0[&aСтажёр&0] - &2","&0[&2Помощник&0] - &2", "&0[&4Модератор&0] - &6", "&0[&4???&0] - &d", "&0[&3Ст.Модератор&0] - &3", "&0[&9Гл.Модератор&0] - &3",
"&0[&9Дизайнер&0] - &3", "&0[&4Куратор&0] - &0", "&0[&4Тех.Админ&0] - &0"}

function setAdmins()
    for i = 1, #admins do
	   buf[admins[i][2]] = true;
    end
	shell.execute("rm AdminsBD.lua")
	shell.execute("wget https://mcmod.pw/api/openadmins/?server=1 AdminsBD.lua")
	file = io.open(shell.getWorkingDirectory() .. "/AdminsBD.lua", "r")
	local reads = file:read(9999999)
	if reads ~= nil then
		admins = serial.unserialize("{" .. reads .. "}")
	else
		admins = {}
	end
	file:close()
	for i = 1, #admins do
	   buf1[admins[i][2]] = true;
    end
	for i = 1, #admins do
	   if buf[admins[i][2]] then
	       buf1[admins[i][2]] = nil;
	   end
    end
    for i in pairs(buf1) do
        for a = 1, #admins do
    	   if i == admins[a][2] then
    	       if CHANGE_SCOREBOARDS then
				sky.com("scoreboard teams join " .. SCOREBOARDS[admins[a][1]] .. " " .. admins[a][2])
    			end
    			if CHANGE_COLOR_NICKNAME then
    				sky.com("nick " .. admins[a][2] .. " " .. MOD_CHAT_COLOR[admins[a][1]] .. admins[a][2])
    			end
    	   end
        end
    end
end
setAdmins()

g.setResolution(WIDTH, HEIGHT)
-- sky.logo("OpenAdmins", COLOR1, COLOR2, WIDTH, HEIGHT)

function Seen(nick)
	local year, month, day, hour, minute = 0,0,0,0,0
	local c = sky.com("seen " .. nick)
	local _, b = string.find(c, "§6 с §c")
	if (b == nil) then
		return "&4error"
	end
	local text = string.sub(c, b+1, unicode.len(c))
	if string.find(text, "лет") ~= nil then
		year = string.sub(text, string.find(text, " лет")-2, string.find(text, " лет")-1)
	end
	if string.find(text, "год") ~= nil then
		year = 1
	end
	if string.find(text, "месяц") ~= nil then
		month = string.sub(text, string.find(text, " месяц")-2, string.find(text, " месяц")-1)
	end
	if string.find(text, "дн") ~= nil then
		day = string.sub(text, string.find(text, " дн")-2, string.find(text, " дн")-1)
	elseif string.find(text, "день") ~= nil then
		day = 1
	end
	if string.find(text, "час") ~= nil then
		hour = string.sub(text, string.find(text, " час")-2, string.find(text, " час")-1)
	end
	if string.find(text, "минут") ~= nil then
		minute = string.sub(text, string.find(text, " минут")-2, string.find(text, " минут")-1)
	end
	local status
	if string.find(c, "онлайн") ~= nil then
		status = "&2online"
	else
		status = "&0offline"
	end
	return status, tonumber(year), tonumber(month), tonumber(day), tonumber(hour), tonumber(minute)
end

function Update()
	term.clear()
	sky.mid(WIDTH, 5, "&2Список администрации")
	for i = 1, #admins do
		sky.text(mid-48, i+10, stat[admins[i][1]] .. admins[i][2])
		sky.text(mid-17, i+10, "&3" .. admins[i][3] .. "  ")
		
		sky.text(mid+4, i+10, "&6" .. sky.playtime(admins[i][2]) .. "    ")
		
		local status, year, month, day, hour, minute = Seen(admins[i][2]) 
		g.set(mid+20,i+10,"                       ")
		if status == "&4error" then
			sky.text(mid+20,i+10, status)
		elseif year ~= 0 then
			sky.text(mid+20,i+10, status .. " - " .. year .. " лет " .. month .. " мес. ")
		elseif month ~= 0 then
			sky.text(mid+20,i+10, status .. " - " .. month .. " мес. " .. day .. " дн. ")
		elseif day ~= 0 then
			sky.text(mid+20,i+10, status .. " - " .. day .. " дн. " .. hour .. " ч. ")
		else
			sky.text(mid+20,i+10, status .. " - " .. hour .. " ч. " .. minute .. " мин. ")
		end
	end
end

Update()

while true do
	local e,_,w,h,_,nick = event.pull(UPDATE, "touch")
	setAdmins()
	Update()
end