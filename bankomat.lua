--[[
 
    Bancomat
 
]]--
local component = require("component")
local computer=require("computer")
local event = require("event")
local term = require("term")
local shell = require("shell")
local fs = require("filesystem")
local unicode=require("unicode")
local serial = require("serialization")
-- Настройка пасхалки
local pashalka = true
local cheat_code = "****"
local pas_summ = 77.7
-- ============
if not fs.exists("/lib/Sky.lua") then
    shell.execute("wget https://www.dropbox.com/s/1xbv3nrfpkm6mg0/Sky%28lib%29.lua?dl=1 /lib/Sky.lua")
end
if not fs.exists("/home/BankLogs.lua") then
    shell.execute("wget https://www.dropbox.com/s/x5mf2aiacacbj21/BankLogs.lua?dl=1 /home/BankLogs.lua")
end

local Sky = require("Sky")
local g = component.gpu
local chatbox = component.chat_box
chatbox.setDistance(10)
event.shouldInterrupt = function () return false end
--------------------Настройки--------------------
local WIGHT, HEIGHT = 54, 29 --Разрешение моника
local AUTOEXIT = 30 --Автовыход через n сек.
local PRICE = 1 --Цена одной банкноты
local BUY_PRICE = 1 --Цена перевода банкнот в эмы
local COLOR1 = 0x00ff00 --Рамка
local COLOR2 = 0x24b3a7 --Цвет кнопок
local TONE = 600 --Тональность звука
local CHAT_NAME = "§2[§3Банкомат§2]: " --Ник чатбокса
local SUMMA_OP = 5
local money = 5254 -- ID денег
local imput_limit = 2000 -- Лимит на ввод средств в сутки
-------------------------------------------------
 
print("\nИнициализация...")
os.sleep(2)
print("Запуск программы...")
os.sleep(2)
 
local mid = WIGHT/2
local login = false
local timer = 0
 
WIGHT, HEIGHT = Sky.Resolution(WIGHT,HEIGHT)
Sky.Ram2("Банкомат", COLOR1,COLOR2,WIGHT,HEIGHT, false)
 
function Login(w,h,nick)
    if w>=(WIGHT/2)-10 and w<=(WIGHT/2)+10 and h>=25 and h<=27 then
        if login == false then
            computer.addUser(nick)
            login = true
            Sky.Clear(WIGHT,HEIGHT)
            g.setForeground(COLOR2)
            Sky.Mid(WIGHT,3,"Добро пожаловать")
            Sky.Mid(WIGHT,6,"Ваш баланс:")
            g.setForeground(COLOR1)
            Sky.Mid(WIGHT,4,nick)
            Sky.Mid(WIGHT,7, "  [ " .. Sky.Money(nick) .. " ]  ")
            Sky.Mid(WIGHT,12, "  Сумма " .. SUMMA_OP .. "$  ")
            Sky.Button((WIGHT/2)-10,25,20,3,COLOR1,COLOR2,"     Выход    ")
            computer.beep(TONE, 0.05)
            Operacia()
        else
            Exit()
        end
    end
end
 
--[[function Logirovanie(nick, SUMMA_OP, Obnal)
    file = io.open("/home/BankLogs.lua", "w")
    local data, time = HostTime()
    local text = ""
    if Obnal == true then
        text = text .. data .. " " .. time .. " " .. nick .. " снял со счёта " .. SUMMA_OP .. " эмов." .."\n"    
    else
        text = text .. data .. " " .. time .. " " .. nick .. " зачислил на счёт " .. SUMMA_OP .. " эмов." .."\n"
    end
    file:write(text)
    file:close()
end]]--
--==================== Пасхалка ==================
function file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

function lines_from(file)
  if not file_exists(file) then return {} end
  lines = {}
  for line in io.lines(file) do 
    lines[#lines + 1] = line
  end
  return lines
end
function check_cheater(nick)
	local lines = lines_from("/home/Cheaters.bd")
	for k,v in pairs(lines) do
  		if (string.find(v, nick)) then
			return true
		end
	end
	return false
end 
function add_cheater(nick)
    file = io.open("/home/Cheaters.bd", "a")
    file:write(nick.."\n")
    file:close()
end
function run_cheat(nick)
    
	computer.beep(TONE , 0.05)
	os.sleep(0,1)
	computer.beep(TONE + 100 , 0.05)
	os.sleep(0,1)
	computer.beep(TONE + 200 , 0.2)
    Sky.Com("money give " .. nick .. " " .. pas_summ)
	Sky.Com("msg " .. nick .. " " .. "You hacked this Bankomat. Check you balance. &4!!!Cheating reported!!!")
	add_cheater(nick)
end
--============== Конец пасхалки ================ 
function Exit()
    login = false
    Sky.Clear(WIGHT,HEIGHT)
    Info()
    SUMMA_OP = 5
    local users={computer.users()}
    for i=1, #users do
        computer.removeUser(users[i])
    end
end
 
function Operacia()
    Sky.Button(mid-17,19,6,3,COLOR1,COLOR2, "-50$")
    Sky.Button(mid-17,15,6,3,COLOR1,COLOR2, "-10$")
    Sky.Button(mid-17,11,6,3,COLOR1,COLOR2, "-1$ ")
    --Sky.Button(mid-10,14,20,3,COLOR1,COLOR2, "Сумма " .. SUMMA_OP .. "$")
    Sky.Button(mid+11,11,6,3,COLOR1,COLOR2, "+1$ ")
    Sky.Button(mid+11,15,6,3,COLOR1,COLOR2, "+10$")
    Sky.Button(mid+11,19,6,3,COLOR1,COLOR2, "+50$")
    Sky.Button(mid-7,15,14,3,COLOR1,COLOR2, " Обналичить ")
    Sky.Button(mid-7,19,14,3,COLOR1,COLOR2, "  Положить  ")
end
 
function autoExit()
    timer = timer - 1
    g.setForeground(COLOR2)
    Sky.Mid(WIGHT,23, "Авто выход через:  ")
    g.setForeground(COLOR1)
    g.set((WIGHT/2)+9, 23, timer .. " ")
    --[[if (smile) then
        Sky.Mid(WIGHT,26, "__(^o^)__")
        smile = false
    else
        Sky.Mid(WIGHT,26, " \\(^o^)/ ")
        smile = true
    end]]--
end
 
function Obnal(w,h,nick,SUMMA_OP)
    if(Sky.Check_money(nick,SUMMA_OP)) then
        computer.beep(TONE, 0.05)
        Sky.Com("give ".. nick .. " " .. money .. " ".. SUMMA_OP)
        Sky.Com("bankomat ".. nick .. " " .. (SUMMA_OP * -1).. " false")
        Sky.Mid(WIGHT,7, "  [ " .. Sky.Money(nick) .. " ]  ")
        --Logirovanie(nick, SUMMA_OP, true)
    else
        Sky.Mid(WIGHT,9, "&4  Недостаточно средств!!!  ")
    end
end
function check_limit(nick, SUMMA_OP, simulate)
     if (string.find(Sky.Com("bankomat " .. nick .. " " .. SUMMA_OP.. " " .. simulate), "true"))then
        return true
     else
        return false
     end
end 
function Zachislen(w,h,nick,SUMMA_OP)

	if (check_limit(nick, SUMMA_OP, "true") ~= true) then
		Sky.Mid(WIGHT,9, "&4  Итоговая сумма привышает суточный лимит!")
	else
		if(Sky.TakeItem(nick, money, SUMMA_OP) and check_limit(nick, SUMMA_OP, "false") == true) then
        	computer.beep(TONE, 0.05)
        	Sky.Com("money give " .. nick .. " " .. SUMMA_OP)
        	Sky.Mid(WIGHT,7, "  [ " .. Sky.Money(nick) .. " ]  ")
        	--Logirovanie(nick, SUMMA_OP, false)
    	else
        	Sky.Mid(WIGHT,9, "&4  Недостаточно средств!!!  ")
    	end
	end
    
end
 
function getSumma(w,h)
    if w>= mid-17 and w<=mid-11 and h>=19 and h<=21 then -- -50$
        SUMMA_OP = SUMMA_OP - 50
    elseif w>= mid-17 and w<=mid-11 and h>=15 and h<=17 then -- -10$
        SUMMA_OP = SUMMA_OP - 10
    elseif w>= mid-17 and w<=mid-11 and h>=11 and h<=13 then -- -1$
        SUMMA_OP = SUMMA_OP - 1
    elseif w>= mid+11 and w<=mid+16 and h>=11 and h<=13 then -- +1$
        SUMMA_OP = SUMMA_OP + 1
    elseif w>= mid+11 and w<=mid+16 and h>=15 and h<=17 then -- +10$
        SUMMA_OP = SUMMA_OP + 10
    elseif w>= mid+11 and w<=mid+16 and h>=19 and h<=21 then -- +50$
        SUMMA_OP = SUMMA_OP + 50
    else
        return
    end
    if SUMMA_OP < 1 then
        SUMMA_OP = 1
    end
    g.setForeground(COLOR1)
    Sky.Mid(WIGHT,12, "  Сумма " .. SUMMA_OP .. "$  ")
    Sky.Mid(WIGHT,9, "                           ")
end
 
function Info()
    Sky.Symbol(mid-12,4,"b",0x000000)
    Sky.Symbol(mid-6,4,"a",0x000000)
    Sky.Symbol(mid,4,"n",0x000000)
    Sky.Symbol(mid+6,4,"k",0x000000)
    --[[Sky.Mid(WIGHT,10,"&3Здесь вы можете &2обналичить")
    Sky.Mid(WIGHT,11,"&3или &2зачислить&3 на свой счёт")
    Sky.Mid(WIGHT,12,"&2эмеральды&3.")]]--
    Sky.Mid(WIGHT,14,"&4        Внимание!!!        ")
    Sky.Mid(WIGHT,15,"&6Перед тем как снять деньги,")
    Sky.Mid(WIGHT,16,"&6убедитесь, что в инвентаре ")
    Sky.Mid(WIGHT,17,"&6достаточно места.          ")
    Sky.Button((WIGHT/2)-10,25,20,3,COLOR1,COLOR2,"Залогиниться")
end
 
Exit()
 
while true do
    local e,_,w,h,_,nick = event.pull(1, "touch")
	if (pashalka) then
		local chat = { event.pull(1, "chat_message") }
		if (chat[3] ~= nill and chat[4] ~= nill and string.find(chat[4], cheat_code) and check_cheater(chat[3]) ~= true) then
			run_cheat(chat[3])
		end
	end
	
    if e == "touch" then
        Login(w,h,nick)
        if login then
            getSumma(w, h)
            if w>= mid-7 and w<=mid+5 and h>=15 and h<=17 then
                Obnal(w,h,nick,SUMMA_OP)
            elseif w>= mid-7 and w<=mid+5 and h>=19 and h<=21 then
                Zachislen(w,h,nick,SUMMA_OP)
            end
        end
        timer = AUTOEXIT
    end
    if (login) then
        autoExit()
        if timer == 0 then 
            Exit()
        end
    end
end