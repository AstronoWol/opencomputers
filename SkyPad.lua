local component = require("component")
local computer=require("computer")
local event = require("event")
local term = require("term")
local shell = require("shell")
local fs = require("filesystem")
local unicode=require("unicode")
local serial = require("serialization")
if not component.isAvailable("opencb") then
  print("Подключите командный блок: opencb")
  os.sleep(3)
  os.exit()
end
if not fs.exists("/lib/sky.lua") then
  shell.execute("wget https://mcmod.pw/pastebin/files/sky.lua /lib/sky.lua")
end
local sky = require("sky")
local g = component.gpu
event.shouldInterrupt = function () return false end
--------------------Настройки--------------------
local WIDTH, HEIGHT = 146, 42 --Разрешение моника 146/112 x 42
local PASS = "78783811" --Пасс
local COLOR1 = 0x00ffff --Рамка
local COLOR2 = 0x0000ff --Цвет кнопок
local COLOR3 = 0x333333 --Таблица
local COLOR_SHELL = 0xff00ff --Цвет шелла
-------------------------------------------------
if not (fs.exists(shell.getWorkingDirectory() .. "/Programms.lua")) then
  shell.execute("wget https://mcmod.pw/pastebin/files/Programms.lua " .. shell.getWorkingDirectory() .."/Programms.lua")
end
if not (fs.exists("/autorun.lua")) then
  print("\nНастройка автозапуска...")
  file = io.open("/autorun.lua", "w")
  file:write("local shell = require('shell')\nlocal term = require('term')\nos.sleep(0.5)\nterm.clear()\nlocal dir = '" .. shell.getWorkingDirectory() .. "'\nif dir ~= '/' then shell.setWorkingDirectory(dir) end\nshell.execute('SkyPad')")
  file:close()
  os.sleep(1)
end
print("\nИнициализация...")
os.sleep(2)
print("Запуск программы...")
os.sleep(2)

local mid = (WIDTH-32)/2+32
local login, prog, tech = false, false, false
local sel = 0

g.setResolution(WIDTH, HEIGHT)
sky.logo("SkyPad", COLOR1, COLOR2, WIDTH, HEIGHT)
g.setForeground(COLOR2)
for i = 1, HEIGHT do
  g.set(29, i, "||")
end

file = io.open(shell.getWorkingDirectory() .. "/Programms.lua", "r")
local progs = serial.unserialize("{" .. file:read(9999999) .. "}")
file:close()

function Login()
  login = false
  prog = false
  tech = false
  sky.clearL(HEIGHT)
  sky.clearR(WIDTH,HEIGHT)
  Rules()
  g.setForeground(COLOR1)
  sky.word(mid - 28,7, "mcskill", 0x222222)
  --users={computer.users()}
    --for i=1, #users do
    --    computer.removeUser(users[i])
    --end
  sky.midR(WIDTH,32,"Введите пароль:")
  term.setCursor(mid-2,33)
  local p, nick = sky.read({mask = "*", max = 8, accept = "0-9a-f", blink = true, center = true, nick = true})
  if p == PASS then
    if (sky.checkOP(nick)) then
      login = true
      sky.midR(WIDTH,33,"Приветствую, " .. nick)
      computer.addUser(nick)
      os.sleep(2)
      sky.clearL(HEIGHT)
      sky.clearR(WIDTH,HEIGHT)
      Rules(nick)
      Table()
    else
      sky.midR(WIDTH,34,"Даже, зная пароль, просто так")
      sky.midR(WIDTH,35,"ты сюда не войдёшь")
      os.sleep(2)
      sky.midR(WIDTH,37,"Петушинная морда")
      os.sleep(3)
      Login()
    end
  else
    sky.midR(WIDTH,33,"Неверный пароль")
    if (component.isAvailable("opencb")) then
      component.opencb.execute("thor " .. nick)
    end
    os.sleep(2) 
    Login()
  end
end

function Rules(nick)
  if (login) then
    g.setForeground(COLOR2)
    sky.midL(WIDTH,5,"==========================")
    sky.midL(WIDTH,11,"==========================")
    sky.midL(WIDTH,15,"==========================")
    sky.midL(WIDTH,31,"Добро пожаловать")
    g.setForeground(COLOR1)
    sky.midL(WIDTH,3, "Общая инфа:")
    sky.midL(WIDTH,6, "Монитор в идеале 5х3")
    sky.midL(WIDTH,7, "блока, чтоб не париться.")
    sky.midL(WIDTH,8, "Но если над другой, то")
    sky.midL(WIDTH,9, "в настройках каждой проги")
    sky.midL(WIDTH,10, "меняйте параметр WIDTH")
    sky.midL(WIDTH,12, "Autorun ставится свой,")
    sky.midL(WIDTH,13, "но его можно")
    sky.midL(WIDTH,14, "редачить под себя")
    sky.midL(WIDTH,32,nick)
    sky.button(7,34,18,3,COLOR1,COLOR2,"Обновить")
    sky.button(7,37,18,3,COLOR1,COLOR2,"Выйти")
  end
end

function TechPanel()
  prog = false
  g.fill(mid - 43, 13, 83, 23, " ")
  sky.midR(WIDTH, 20, "&bВаще хз, чё тут запилить,")
  sky.midR(WIDTH, 21, "&bесли есть идеи, напишите :)")
  tech = true
end

function ProgrammPanel()
  g.fill(mid - 43, 13, 83, 23, " ")
  tech = false
  sky.midR(WIDTH,13,"&bСписок программ для OpenComputers&r")
  g.setForeground(COLOR3)
  sky.midR(WIDTH,14, "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━┳━━━━━━━━━━┓")
  sky.midR(WIDTH,15, "┃                       &bНазвание&r                      ┃     &bСтатус&r     ┃  &bРазмер&r  ┃")
  sky.midR(WIDTH,16, "┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╋━━━━━━━━━━━━━━━━╋━━━━━━━━━━┫")
  for i = 1, 9 do 
    sky.midR(WIDTH,i+16, "┃                                                     ┃                ┃          ┃")
  end
  sky.midR(WIDTH,26, "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━┻━━━━━━━━━━┛")
  DrawProgs(0)
  prog = true
end

function DrawProgs(s)
  sel = s
  for i = 1, #progs do
    g.setForeground(COLOR1)
    g.set(mid-42, i+16, "                                                     ")
    g.set(mid+29, i+16, "          ")
    local name_progs = tostring(progs[i][1][1]) .. tostring(progs[i][1][2])
    if sel ~= i then
      g.set(mid-15-unicode.len(name_progs)/2, i+16, name_progs)   
    else
      g.set(mid-19-unicode.len(name_progs)/2, i+16, ">>> " .. name_progs .. " <<<")   
    end
    if (fs.exists(shell.getWorkingDirectory() .. "/" .. progs[i][1][1] .. ".lua")) then
      sky.text(mid + 12, i+16, "&2 Установлено  &r")
      local size = fs.size(shell.getWorkingDirectory() .. "/" .. progs[i][1][1] .. ".lua")
      sky.text(mid + 33 - unicode.len(size)/2, i+16, size .. "B")
    else
      sky.text(mid + 12, i+16, "&8Не установлено&r")
    end
  end
  g.fill(mid - 42, 27, 84, 10, " ")
  if sel ~= 0 then
    if (fs.exists(shell.getWorkingDirectory() .. "/" .. progs[sel][1][1] .. ".lua")) then
      sky.button(mid-21,33,20,3,COLOR1,COLOR2,"Запустить")
      sky.button(mid+1,33,20,3,COLOR1,COLOR2," Обновить ")
    else
      sky.button(mid-10,33,20,3,COLOR1,COLOR2,"Установить")
    end
    g.setForeground(COLOR1)
    sky.midR(WIDTH,28,"Требуемые компоненты:")
    local comp = ""
    for i = 1, #progs[sel][3] do
      comp = comp .. progs[sel][3][i] .. " &0|&r "
    end
    sky.midR(WIDTH,29, "&0|&r " .. comp)
  end
end

function Click(w,h)
  g.setForeground(COLOR1)
  if sel ~= 0 then
    if (fs.exists(shell.getWorkingDirectory() .. "/" .. progs[sel][1][1] .. ".lua")) then
      if w>=mid-21 and w<=mid-2 and h>=33 and h<=35 then
        for i = 1, #progs[sel][3] do
          if not (component.isAvailable(progs[sel][3][i])) then
            sky.midR(WIDTH,31,"&6Отсутствует компонент: &4" .. progs[sel][3][i])
            os.sleep(3)
            DrawProgs(sel)
            return
          end
        end
        term.clear()
        shell.execute(progs[sel][1][1])
        g.setForeground(COLOR1)
        print("\nКликни на монитор для перезагрузки")
        local e = event.pull("touch")
        print("\nРестарт...")
        os.sleep(2)
        shell.execute("reboot")
      elseif w>=mid+1 and w<=mid+20 and h>=33 and h<=35 then
        fs.remove(shell.getWorkingDirectory() .. "/" .. progs[sel][1][1] .. ".lua")
        sky.get(progs[sel][2],progs[sel][1][1] .. ".lua",mid-19,31)
        sky.midR(WIDTH,31,"                                        ")
        DrawProgs(sel)
        return
      end
    else
      if w>=mid-10 and w<=mid+9 and h>=33 and h<=35 then
        sky.get(progs[sel][2],progs[sel][1][1] .. ".lua",mid-19,31)
        sky.midR(WIDTH,31,"                                        ")
        DrawProgs(sel)
        return
      end
    end
  end
  for i = 1, #progs do
    if w>=mid-42 and w<=mid+38 and h == i + 16 then
      DrawProgs(i)
      return
    end
  end
  DrawProgs(0)
end

function Table()
  sky.drawImage(mid - 28,7, shell.getWorkingDirectory() .. "/LogoSkill.lua")
  sky.button(mid - 32,37,20,3,COLOR1,COLOR2,"Проги")
  sky.button(mid - 10,37,20,3,COLOR1,COLOR2,"Войти в шелл")
  sky.button(mid + 12,37,20,3,COLOR1,COLOR2,"Тех.панель")
  sky.button(WIDTH-11,3,7,4,COLOR1,COLOR2,"")
  sky.text(WIDTH-10,4,"&b┌│┐&r")
  sky.text(WIDTH-10,5,"&b└─┘&r")
end

function getButtons(w,h)
  if w>=7 and w<= 25 and h>=34 and h<=36 then --Кнопка обновить
    term.clear()
    fs.remove(shell.getWorkingDirectory() .. "/SkyPad.lua") 
    fs.remove(shell.getWorkingDirectory() .. "/Programms.lua")
    fs.remove("/lib/sky.lua")
    g.setForeground(COLOR1)
    shell.execute("wget https://files.mcmod.pw/sky/SkyPad.lua SkyPad.lua")
    shell.execute("wget https://files.mcmod.pw/sky/Programms.lua Programms.lua")
    shell.execute("wget https://files.mcmod.pw/sky/lib/sky.lua /lib/sky.lua")
    print("\nРестарт...")
    os.sleep(2)
    shell.execute("reboot")
elseif w>=7 and w<= 25 and h>=37 and h<=39 then --Кнопка Логин
    Login()
  elseif w>=mid-32 and w<= mid-13 and h>=37 and h<=39 then --Кнопка Проги
    ProgrammPanel()
  elseif w>=mid-10 and w<= mid+9 and h>=37 and h<=39 then --Кнопка Войти в шелл
    term.clear()
    g.setForeground(COLOR_SHELL)
    shell.execute("sh")
  elseif w>=mid+12 and w<= mid+31 and h>=37 and h<=39 then --Кнопка Тех.Панель
    TechPanel()
  elseif w>=WIDTH-11 and w<= WIDTH-6 and h>=3 and h<=6 then --Кнопка Офф
    computer.shutdown()
  end
end

Login()

while true do
  local e,_,w,h,_,nick = event.pull("touch")
  if (login) then
    getButtons(w,h)
    if (prog) then
      Click(w,h)
    end
  end
end