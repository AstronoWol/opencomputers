local com = require("component")
local event = require("event")
local serial = require("serialization")
local unicode = require("unicode")
local fs = require("filesystem")
local shell = require("shell")
local term = require("term") 

local cb = com.chat_box
local opencb = com.opencb
local g = com.gpu

local server = 3; -- 1 TMSB | 2 VOLCANO | 3 HTCL | 4 ARCTCHRPG
local hst = "https://mcmod.pw/api/reputation/getMods.php?server=" .. server;

function main()
local bool, err = pcall(function()
local info = {
  "\n§1┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n§1┃"..string.rep("§f ",30).."§6Репутация\n§1┃§f §f §3Чтобы повысить или понизить репутацию игроку\n§1┃"..string.rep("§f ",6).."§3Напишите в локальный или глобальный чат:\n§1┃"..string.rep("§f ",17).."§6rep §7[§aник§7] §2+ §3или §6rep §7[§cник§7] §c-\n§1┃\n§1┃"..string.rep("§f ",27).."§6Топ по онлайну\n§1┃§f §f §3Чтобы посмотреть Топ-10 игроков по онлайну\n§1┃"..string.rep("§f ",6).."§3Напишите в локальный или глобальный чат:\n§1┃"..string.rep("§f ",30).."§6-playtime\n§1┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
}
if not (fs.exists("/home/users")) then
    shell.execute("wget https://mcmod.pw/api/reputation/users /home/users")
end

file = io.open("users", "rb")
users = file:read("*a")
users = serial.unserialize(users)
file:close()

local moders = {}

ww, hh = 146, 42
g.setResolution(ww,hh)
function setColor(index)
    if (index ~= "r") then back = g.getForeground() end
    if (index == "0") then g.setForeground(0x333333) end
    if (index == "1") then g.setForeground(0x0000ff) end
    if (index == "2") then g.setForeground(0x00ff00) end
    if (index == "3") then g.setForeground(0x24b3a7) end
    if (index == "4") then g.setForeground(0xff0000) end
    if (index == "5") then g.setForeground(0x8b00ff) end
    if (index == "6") then g.setForeground(0xffa500) end
    if (index == "7") then g.setForeground(0xbbbbbb) end
    if (index == "8") then g.setForeground(0x808080) end
    if (index == "9") then g.setForeground(0x0000ff) end
    if (index == "a") then g.setForeground(0x66ff66) end
    if (index == "b") then g.setForeground(0x00ffff) end
    if (index == "c") then g.setForeground(0xff6347) end
    if (index == "d") then g.setForeground(0xff00ff) end
    if (index == "e") then g.setForeground(0xffff00) end
    if (index == "f") then g.setForeground(0xffffff) end
    if (index == "g") then g.setForeground(0x00ff00) end
    if (index == "r") then g.setForeground(back) end
    -- не бейте :C
end
function save() 
  file=io.open("users","w")
  file:write(serial.serialize(users))
  file:close()
end
function textSet(x,y,text)
    local n = 1
    for i = 1, unicode.len(text) do
        if unicode.sub(text, i,i) == "&" then
            setColor(unicode.sub(text, i + 1, i + 1))
        elseif unicode.sub(text, i - 1, i - 1) ~= "&" then
            g.set(x+n,y, unicode.sub(text, i,i))
            n = n + 1
        end
    end
end
function mid(w,y,text)
  local _,n = string.gsub(text, "&","")
  local l = unicode.len(text) - n * 2; x = (w / 2) - (l / 2)
  textSet(x, y, text)
end
function nickCheck(param)
  if param == false then return false end
  local __,cot = opencb.execute("money "..param)
  if cot:find("Баланс: §f") or moders[param] then
    return true
  else 
    return false 
  end
end
function register(param) 
  if not users[param] then 
    users[param] = {["Pusers"] = {},["Musers"] = {},["nick"] = param,["Mi"] = 0,["Pi"] = 0} 
  end 
end
function midl(y,text) 
  local _,n = string.gsub(text, "&","")
  local l = unicode.len(text) - n * 2; x = (44 / 2) - (l / 2)
  textSet(x+1, y, text)
end
function midm(y,text) 
  local _,n = string.gsub(text, "&","")
  local l = unicode.len(text) - n * 2; x = (69 / 2) - (l / 2)
  textSet(39+x, y, text)
end
function midr(y,text) 
  local _,n = string.gsub(text, "&","")
  local l = unicode.len(text) - n * 2; x = (69 / 2) - (l / 2)
  textSet(90+x, y, text)
end
function getNick(param)
  if (string.len(param) > 17) then
  return false
  end
  local nick = param
  local _,input = opencb.execute("seen "..nick)
  if input:find("не найден") then
    return false
  end
  local inputSmall,nickSmall = unicode.lower(input),unicode.lower(nick)
  local pr1,pr2 = string.find(inputSmall,nickSmall)
  nick = string.sub(input,pr1,pr2)
  return nick
end
function getPlayTimeTop() 
  local playtime = {}
  local _,input = opencb.execute("playtimetop 10")
  input = string.sub(input,string.find(input,"\n")+1,string.len(input))
  local line_index = 0
  for line in string.gmatch(input,"\n") do
    line_index=line_index + 1
  end
  for x = 1,line_index do 
    local text = string.sub(input,1,string.find(input,"\n")-1)
    local nick,hours = text:match("^(.+)%s-%s(.+)$")
    nick = string.sub(nick,1,string.len(nick)-2)
    table.insert(playtime,{["hours"]=hours,["nick"]=nick})
    input = string.sub(input,string.find(input,"\n")+1,string.len(input))
  end 
  function sortingMethod(a,b)
    return tonumber(a["hours"]) > tonumber(b["hours"])
  end
  table.sort(playtime, sortingMethod)
  return playtime
end
function get_playtime_player_count(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end 
function HUDdraw()
  setColor("8")
  g.fill(1,1,160,50," ")
  g.fill(100,1,ww,1,"─")
  g.fill(1,1,44,1,"─")
  g.fill(1,1,1,hh,"│")
  g.fill(ww,1,1,hh,"│")
  g.set(1,1,"┌")
  g.set(ww,1,"┐")
  g.set(40,hh,"└")
  g.set(102,hh,"┘")
  g.fill(100,hh,ww,1,"─")
  g.fill(1,hh,44,1,"─")
  g.fill(44,1,1,hh,"│")
  g.fill(46,8,1,28,"│")
  g.fill(98,8,1,28,"│")
  g.fill(100,1,1,hh,"│")
  g.set(44,1,"┐")
  g.set(44,hh,"┘")
  g.fill(47,25,51,1,"─")
  g.fill(47,24,51,1,"─")
  g.fill(47,8,51,1,"─")
  g.set(46,8,"┌")
  g.set(98,8,"┐")
  g.set(46,25,"┌")
  g.set(46,24,"└")
  g.set(98,25,"┐")
  g.set(98,24,"┘")
  g.fill(46,36,52,1,"─")
  g.set(46,36,"└")
  g.set(98,36,"┘")
  g.set(100,1,"┌")
  g.set(100,hh,"└")
  g.set(1,hh,"└")
  g.set(ww,hh,"┘")
  setColor("a")
  midl(4,"Игроки с наилучшей репутацией:")
  midr(4,"Модерация с наилучшей репутацией:")
  midm(10,"Топ-10 игроков по онлайну:")
  mid(146,27,"&bОсновные команды:")
  mid(146,29,"&2rep &8[&bnick&8]&2 + &7Повышение репутации игрока.")
  mid(146,30,"&2rep &8[&bnick&8]&2 - &7Понижение репутации игрока.")
  mid(146,31,"&2rep &8[&bnick&8]&2 &7Информация о репутации игрока.")
  mid(146,34,"&2Есть идеи? Пиши: DevilPuppy#7824")
  local scores = {}
  if (users ~= nill) then
  for x in pairs(users) do
    scores[#scores+1] = users[x]
  end
  end
  function compare(a,b) return a["Pi"]-a["Mi"] > b["Pi"]-b["Mi"] end
  table.sort(scores, compare)
  xx = 1
  xxx = 1
  for x in pairs(scores) do
    if moders[scores[x]["nick"]] then
      if xxx < 35 then
        midr(6+xxx,"&b"..scores[x]["nick"].." - &2Рейтинг: "..scores[x]["Pi"]-scores[x]["Mi"].."&b - &8(&2"..scores[x]["Pi"].."&8|&c"..scores[x]["Mi"].."&8)")
        xxx = xxx + 1
      end
    else
      if xx < 35 then
        midl(6+xx,"&b"..scores[x]["nick"].." - &2Рейтинг: "..scores[x]["Pi"]-scores[x]["Mi"].."&b - &8(&2"..scores[x]["Pi"].."&8|&c"..scores[x]["Mi"].."&8)")
        xx = xx + 1
      end
    end
  end
  local playtime = getPlayTimeTop()

  for x = 1,get_playtime_player_count(playtime) do
    midm(12+x,"&b"..playtime[x]["nick"].." - &2"..playtime[x]["hours"])
  end
  setColor("8")
  g.fill(102,39,42,1,"─")
  g.fill(102,41,42,1,"─")
  g.fill(102,39,1,3,"│")
  g.fill(144,39,1,3,"│")
  g.set(102,39,"┌")
  g.set(144,39,"┐")
  g.set(102,41,"└")
  g.set(144,41,"┘")
  setColor("2")
  g.set(117,40,"Синхронизировать")
end
function sync()
  moders = {}

  shell.execute("rm /home/mods");
  shell.execute("wget " .. hst .. " /home/mods");

  file = io.open("mods", "rb")
  moders = file:read("*a");
  moders = serial.unserialize(moders);
  file:close();
  HUDdraw()
end
sync()

-- Регистрация всей модерации
for i in pairs(moders) do
  register(i)
end

while true do
  local e = {event.pull(300)}
  --Можно было сделать короче, быстрее, лучше, но кому это нужно)0)
  if e[1] == nil then HUDdraw();end
  if e[1] == "touch" then
    if e[3] >= 102 and e[3] <= 144 and e[4] >= 39 and e[4] <= 41 then
      sync();
    end
  end
  local msg = e[4]
  if e[1] == "chat_message" and (msg:find("^-info$") or msg:find("^-playtime$") or msg:find("^!?rep")) then
  local nick,mm = getNick(e[3]),true
  -- if msg:find("^-info$") then
  --   for x in pairs(info) do opencb.execute('w '..nick..' '..info[x]..'') end
  -- end
  if msg:find("^-playtime$") then
    local playtime = getPlayTimeTop()
    local text = "\n§cТоп-10§6 игроков по онлайну:\n"
    for x = 1,10 do
      text = text .. "\n§6" .. x .. ". §3".. playtime[x]["nick"] .. " - §a" .. playtime[x]["hours"]
    end
    opencb.execute('w '..nick..' '..text..'')
  end
  if msg:find("^!?rep (%S+) [+]$") and msg:match("^!?rep%s(%S+)[+]$") == nil then nickSel = getNick(msg:match("^!?rep (%S+) [+]$"))
    if nickCheck(nickSel) and nick ~= nickSel then register(nickSel);register(nick)
      if users[nickSel]["Pusers"][nick] or users[nickSel]["Pusers"][nick] then opencb.execute('w '..nick..' §cВы уже голосовали за этого игрока.'); else
        users[nickSel]["Pusers"][nick] = true;users[nickSel]["Pi"] = users[nickSel]["Pi"] + 1; opencb.execute('w '..nick..' §6Вы повысили репутацию §a'..nickSel..'§6!'); opencb.execute('w '..nickSel..' §6Вам повысил репутацию §a'..nick..'§6!'); end
    else opencb.execute('w '..nick..' §cИгрок не найден!'); end mm = false; end
    if msg:find("^!?rep (%S+) [-]$") and msg:match("^!?rep%s(%S+)[-]$") == nil and mm then nickSel = getNick(msg:match("^!?rep (%S+) [-]$"))
      if nickCheck(nickSel) and nick ~= nickSel then register(nickSel);register(nick)HUDdraw();
        if users[nickSel]["Musers"][nick] or users[nickSel]["Pusers"][nick] then opencb.execute('w '..nick..' §cВы уже голосовали за этого игрока.'); else
          users[nickSel]["Musers"][nick] = true;users[nickSel]["Mi"] = users[nickSel]["Mi"] + 1; opencb.execute('w '..nick..' §6Вы понизили репутацию §c'..nickSel..'§6!');opencb.execute('w '..nickSel..' §6Вам понизил репутацию §c'..nick..'§6!'); end
    else opencb.execute('w '..nick..' §cИгрок не найден!'); end mm = false; end
    if msg:find("^!?rep (%S+)$") and mm then nickSel = getNick(msg:match("^!?rep (%S+)$"))
      if nickCheck(nickSel) then register(nickSel);register(nick)
        local Mi,Pi = users[nickSel]["Mi"],users[nickSel]["Pi"]
        opencb.execute('w '..nick..' §6У игрока §3'..nickSel..' §6репутация §f§l'..Pi-Mi..' §8(§a'..Pi..'§8|§c'..Mi..'§8)')
   else opencb.execute('w '..nick..' §cИгрок не найден!'); end mm = false; end
      if mm == false then save();HUDdraw(); end
  end
end
end)
term.clear()
if err ~= "interrupted" then
  print("Произошла ошибка - "..err)
  print("Перезагружаю...")
  os.sleep(3)
  main()
else
  print("Намеренный выход через Ctrl+Alt+C")
end
end
main()