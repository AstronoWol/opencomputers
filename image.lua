--|============================|
--|      Библа CasinoImage     |
--|       Автор: SkyDrive_     |
--| Проект McSkill, cервер HTC |
--|         31.03.2017         |
--|        Version: 1.00       |
--|============================|
local image = {}
local component = require("component")
local g = component.gpu

function image.cherry(x,y)
	g.setForeground(0x333333)
	g.set(x,y,  "█▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█")
	g.set(x,y+1,"█           ▄▄▄▄ █")
	g.set(x,y+2,"█       ▄▄▀▀█▄ █ █")
	g.set(x,y+3,"█     ▄▀    █ ▀  █")
	g.set(x,y+4,"█  ▄▀▀▀▄   ▄█▄   █")
	g.set(x,y+5,"█ █     █▄▀   ▀▄ █")
	g.set(x,y+6,"█ ▀▄   ▄▀█     █ █")
	g.set(x,y+7,"█   ▀▀▀   ▀▄▄▄▀  █")
	g.set(x,y+8,"█▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█")
	g.setBackground(0x14a205)
	g.set(x+13,y+2,"▄ ")
	g.setBackground(0xd70f00)
	g.set(x+4,y+4,"▀▀▀")
	g.set(x+3,y+5,"     ")
	g.set(x+3,y+6,"▄   ▄")
	g.set(x+10,y+5,"▀   ▀")
	g.set(x+10,y+6,"     ")
	g.set(x+11,y+7,"▄▄▄")
	g.setForeground(0x700901)
	g.set(x+4,y+6,"▄▄█")
	g.set(x+7,y+5,"█")
	g.set(x+13,y+6,"▄█")
	g.setForeground(0xffffff)
	g.set(x+4,y+5,"▀")
	g.set(x+11,y+5,"▄")	
	g.setBackground(0x700901)
	g.setForeground(0x333333)
	g.set(x+7,y+6,"▄")
	g.set(x+14,y+5,"▀")
	g.set(x+11,y+7,"▄▄▄")
	g.setBackground(0x000000)
end

function image.seven(x,y)
	g.setForeground(0x333333)
	g.set(x,y,  "█▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█")
	g.set(x,y+1,"█  █▀▀▀▀▀▄▄▄▄▀▀█ █")
	g.set(x,y+2,"█  █           █ █")
	g.set(x,y+3,"█  █▄▄▀▀▀▀▄   ▄▀ █")
	g.set(x,y+4,"█        ▄▀  █   █")
	g.set(x,y+5,"█      ▄▀   ▄▀   █")
	g.set(x,y+6,"█     ▄▀   ▄▀    █")
	g.set(x,y+7,"█     █▄▄▄▄█     █")
	g.set(x,y+8,"█▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█")
	g.setBackground(0xff7800)
	g.set(x+4,y+1,"▀▀▀▀▀")
	g.set(x+13,y+1,"▀▀")
	g.set(x+4,y+2,"           ")
	g.set(x+4,y+3,"▄▄")
	g.set(x+10,y+3,"▄   ▄")
	g.set(x+10,y+4,"▀  ")
	g.set(x+8,y+5,"▀   ▄")
	g.set(x+7,y+6,"▀   ▄")
	g.set(x+7,y+7,"▄▄▄▄")
	g.setBackground(0x000000)
end

function image.diamond(x,y)
	g.setForeground(0x333333)
	g.set(x,y,  "█▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█")
	g.set(x,y+1,"█      ▄▄▄▄      █")
	g.set(x,y+2,"█    ▄▀    ▀▄    █")
	g.set(x,y+3,"█   █       ▀▄   █")
	g.set(x,y+4,"█  █         ▀▄  █")
	g.set(x,y+5,"█  █          █  █")
	g.set(x,y+6,"█   █        █   █")
	g.set(x,y+7,"█    ▀▄▄▄▄▄▄▀    █")
	g.set(x,y+8,"█▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█")
	g.setBackground(0x008b8b)
	g.set(x+6,y+7,"▄")
	g.set(x+11,y+7,"▄")
	g.setBackground(0xffffff)
	g.set(x+6,y+2,"▀")
	g.setBackground(0x00ffff)
	g.set(x+11,y+2,"▀")
	g.set(x+12,y+3,"▀")
	g.set(x+13,y+4,"▀")
	g.setForeground(0xffffff)
	g.set(x+7,y+2,"▀▀▀█")
	g.set(x+5,y+3,"█ ▄▄█▄ ")
	g.set(x+4,y+4,"█ █      ")
	g.set(x+4,y+5,"█▀")
	g.setForeground(0x008b8b)
	g.set(x+11,y+4,"█")
	g.set(x+6,y+5,"▀▄▄▄▄▀▀▀")
	g.set(x+5,y+6," █    █ ")
	g.setForeground(0x333333)
	g.set(x+7,y+7,"▄▄▄▄")
	g.setBackground(0x000000)
end

function image.orange(x,y)
	g.setForeground(0x333333)
	g.set(x,y,  "█▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█")
	g.set(x,y+1,"█   ▄▀▀▀▀▀▀▀▄    █")
	g.set(x,y+2,"█ ▄▀         ▀▄  █")
	g.set(x,y+3,"█ █           █▄ █")
	g.set(x,y+4,"█ █            █ █")
	g.set(x,y+5,"█ █           █▀ █")
	g.set(x,y+6,"█ ▀▄         ▄▀  █")
	g.set(x,y+7,"█   ▀▄▄▄▄▄▄▄▀    █")
	g.set(x,y+8,"█▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█")
	g.setBackground(0xfcef84)
	g.set(x+5,y+1,"▀▀▀▀▀")
	g.set(x+3,y+2,"▀")
	g.set(x+3,y+6,"▄")
	g.set(x+5,y+7,"▄▄▄▄▄")
	g.setForeground(0xffc600)
	g.set(x+4,y+2,"▄██ ██▄")
	g.set(x+3,y+3," ▄▀█ █▀▄ ")
	g.set(x+3,y+4," ██   ██ ")
	g.set(x+3,y+5," ▀▄█ █▄▀ ")
	g.set(x+4,y+6,"▀██ ██▀")
	g.setForeground(0x333333)
	g.setBackground(0xff7800)
	g.set(x+10,y+1,"▀▀")
	g.set(x+13,y+2,"▀")
	g.set(x+13,y+6,"▄")
	g.set(x+10,y+7,"▄▄")
	g.setForeground(0xfcef84)
	g.set(x+11,y+2,"▄ ")
	g.set(x+12,y+3,"  ")
	g.set(x+12,y+4,"   ")
	g.set(x+12,y+5,"  ")
	g.set(x+11,y+6,"▀ ")
	g.setBackground(0x000000)
end

function image.pickaxe(x,y)
	g.setForeground(0x333333)
	g.set(x,y,  "█▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█")
	g.set(x,y+1,"█     ▄▄▄▄▄      █")
	g.set(x,y+2,"█    ▀▄▄▄▄ ▀▄▀   █")
	g.set(x,y+3,"█        ▄▀▄ ▀▄  █")
	g.set(x,y+4,"█      ▄▀▄▀ █ █  █")
	g.set(x,y+5,"█    ▄▀▄▀   █ █  █")
	g.set(x,y+6,"█  ▄▀▄▀      ▀   █")
	g.set(x,y+7,"█ ▀▄▀            █")
	g.set(x,y+8,"█▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█")
	g.setBackground(0x08d7bc)
	g.set(x+6,y+2,"▄▄▄▄ ▀")
	g.set(x+11,y+3,"▄ ▀")
	g.set(x+13,y+4," ")
	g.set(x+13,y+5," ")
	g.setBackground(0x974a06)
	g.set(x+12,y+2,"▄▀")
	g.set(x+10,y+3,"▀")
	g.set(x+8,y+4,"▀▄")
	g.set(x+6,y+5,"▀▄")
	g.set(x+4,y+6,"▀▄")
	g.set(x+3,y+7,"▄")
	g.setBackground(0x000000)
end

function image.cheese(x,y)
	g.setForeground(0x333333)
	g.set(x,y,  "█▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█")
	g.set(x,y+1,"█                █")
	g.set(x,y+2,"█    ▄▀▀▀▄▄      █")
	g.set(x,y+3,"█  ▄▀      ▀▀▄▄  █")
	g.set(x,y+4,"█ █            █ █")
	g.set(x,y+5,"█ █            █ █")
	g.set(x,y+6,"█ █            █ █")
	g.set(x,y+7,"█ ▀▀▀▀▀▀▀▀▀▀▀▀▀▀ █")
	g.set(x,y+8,"█▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█")
	g.setBackground(0xffb400)
	g.set(x+6,y+2,"▀▀▀")
	g.set(x+4,y+3,"▀      ▀▀")
	g.setBackground(0xff8400)
	g.setForeground(0xffb400)
	g.set(x+7,y+3,"▄██▀")
	g.set(x+3,y+4,"▀▀   ▀▀▀▀▀▀▀")
	g.setForeground(0x982020)
	g.set(x+3,y+5,"  ▀▀▀  ██  ▄")
	g.set(x+3,y+6," ▄▄  ▀     ▀")
	g.set(x+5,y+4,"▄▄▄")
	g.setBackground(0x000000)
end

function image.pokeball(x,y)
	g.setForeground(0x333333)
	g.set(x,y,  "█▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█")
	g.set(x,y+1,"█    ▄▄▀▀▀▀▄▄    █")
	g.set(x,y+2,"█  ▄▀        ▀▄  █")
	g.set(x,y+3,"█ ▄▀    ▄▄    ▀▄ █")
	g.set(x,y+4,"█ █▄▄▄▄█  █▄▄▄▄█ █")
	g.set(x,y+5,"█ ▀▄    ▀▀    ▄▀ █")
	g.set(x,y+6,"█  ▀▄        ▄▀  █")
	g.set(x,y+7,"█    ▀▀▄▄▄▄▀▀    █")
	g.set(x,y+8,"█▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█")
	g.setBackground(0xff0000)
	g.set(x+7,y+1,"▀▀▀▀")
	g.set(x+4,y+2,"▀        ▀")
	g.set(x+3,y+3,"▀    ▄▄    ▀")
	g.set(x+3,y+4,"▄▄▄▄█  █▄▄▄▄")
	g.setBackground(0xffffff)
	g.set(x+8,y+4,"  ")
	g.set(x+3,y+5,"▄    ▀▀    ▄")
	g.set(x+4,y+6,"▄        ▄")
	g.set(x+7,y+7,"▄▄▄▄")
	g.setBackground(0x000000)
end

function image.meat(x,y)
	g.setForeground(0x333333)
	g.set(x,y,  "█▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█")
	g.set(x,y+1,"█          ▄▀▀█▄ █")
	g.set(x,y+2,"█          █   █ █")
	g.set(x,y+3,"█   ▄▄▄▄▀▀▀▄▄▀▀  █")
	g.set(x,y+4,"█ ▄▀        █    █")
	g.set(x,y+5,"█ █        █     █")
	g.set(x,y+6,"█ █       █      █")
	g.set(x,y+7,"█  ▀▄▄▄▄▄▀       █")
	g.set(x,y+8,"█▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█")
	g.setBackground(0xe87209)
	g.set(x+8,y+3,"▀▀▀▄▄")
	g.set(x+3,y+4,"▀        ")
	g.set(x+3,y+5,"        ")
	g.set(x+3,y+6,"       ")
	g.setBackground(0x981b07)
	g.set(x+8,y+3,"▀")
	g.set(x+4,y+7,"▄▄▄▄▄")
	g.setForeground(0xe87209)
	g.set(x+7,y+4,"▀█▄ ▀")
	g.set(x+4,y+5,"▄████▀ ")
	g.set(x+3,y+6,"▀██▄▀  ")
	g.setBackground(0xfef2ae)
	g.set(x+13,y+2,"█▄")
	g.setForeground(0x333333)
	g.set(x+12,y+1,"▀▀")	
	g.set(x+12,y+2," ")
	g.set(x+11,y+3,"▄")
	g.setBackground(0x000000)
end

function image.apple(x,y)
	g.setForeground(0x333333)
	g.set(x,y,  "█▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█")
	g.set(x,y+1,"█      ▀▄        █")
	g.set(x,y+2,"█   ▄▀▀▀▀█▀▀▀▄   █")
	g.set(x,y+3,"█  █    ▀▀    █  █")
	g.set(x,y+4,"█  █          █  █")
	g.set(x,y+5,"█  ▀▄        ▄▀  █")
	g.set(x,y+6,"█   ▀▄      ▄▀   █")
	g.set(x,y+7,"█     ▀▀▀▀▀▀     █")
	g.set(x,y+8,"█▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█")
	g.setBackground(0xc6ff00)
	g.set(x+5,y+2,"▀▀")
	g.set(x+4,y+3,"    ▀▀    ")
	g.set(x+4,y+5,"▄")
	g.set(x+5,y+6,"▄")
	g.setBackground(0x14a205)
	g.set(x+7,y+2,"▀▀█▀▀▀")
	g.set(x+13,y+5,"▄")
	g.set(x+12,y+6,"▄")
	g.setForeground(0xc6ff00)
	g.set(x+7,y+3,"▄")
	g.set(x+10,y+3,"▄   ")
	g.set(x+4,y+4,"████████  ")
	g.set(x+5,y+5,"██████▀ ")
	g.set(x+6,y+6,"▀▀▀▀▀ ")
	g.setBackground(0xffffff)
	g.set(x+5,y+3,"▀")
	g.set(x+5,y+4,"   ")
	g.set(x+6,y+5,"▄▄")
	g.setBackground(0x000000)
end

return image