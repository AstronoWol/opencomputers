local component = require("component")
local event = require("event")
local term = require("term")
local shell = require("shell")
local fs = require("filesystem")
local unicode=require("unicode")
local serial = require("serialization")
local sky = require("sky")
local g = component.gpu
local INFO
event.shouldInterrupt = function () return false end
if not (fs.exists(shell.getWorkingDirectory() .. "/OpenInfo_Settings.lua")) then
	shell.execute("wget https://mcmod.pw/pastebin/files/OpenInfo_Settings.lua OpenInfo_Settings.lua")
end
print("\nИнициализация...")
os.sleep(2)
print("Запуск программы...")
os.sleep(2)
file = io.open(shell.getWorkingDirectory() .. "/OpenInfo_Settings.lua", "r")
local reads = file:read(9999999)
INFO = serial.unserialize("{" .. reads .. "}")
file:close()
if INFO[1].H < #INFO + 1 then
	INFO[1].H = #INFO + 1
end
local WIGHT = INFO[1].W
local HEIGTH = INFO[1].H
g.setResolution(WIGHT, HEIGTH)
term.clear();
--sky.ram("OpenInfo", INFO[1].COLOR1, INFO[1].COLOR2,WIGHT, HEIGHT, false)
g.setForeground(0xffffff)
for i = 2, #INFO do
	sky.mid(WIGHT, i, INFO[i])
end
while true do
	os.sleep(60)
end