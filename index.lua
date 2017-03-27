Graphics.init()

local currRoom = 1

--ADDED THIS, IF IT CRASHES LOOK TO THIS, MIGHT BE OUT OF BOUNDS
while true do
	if (Controls.check(Controls.read(),KEY_A)) then
		local loadFrisk = require("Lua.frisk_sprites")
		break
	end
	
	if (Controls.check(Controls.read(),KEY_B)) then
		local loadFrisk = require("Lua.smealum_sprites")
		break
	end
	
end

--Load room files/functions
local loadRoom1 = require("Lua.room_1")
local room_1 = loadRoom1.room1

local loadRoom2 = require("Lua.room_2")
local room_2 = loadRoom2.room2

-- Main Loop
while true do

--GRAPHICS
	
	-- Updating screens
	Screen.refresh()
	Screen.clear(BOTTOM_SCREEN)
	
	Screen.debugPrint(0,0,"N/A",Color.new(255,255,255),BOTTOM_SCREEN)
	Screen.debugPrint(0,20,"N/A",Color.new(255,255,255),BOTTOM_SCREEN)
	Screen.debugPrint(0,35,"N/A",Color.new(255,255,255),BOTTOM_SCREEN)
	
	Screen.debugPrint(70,140,"Press Start To Exit",Color.new(255,255,255),BOTTOM_SCREEN)
	Screen.debugPrint(60,160,"Press Select for FTPD",Color.new(255,255,255),BOTTOM_SCREEN)
	Screen.debugPrint(90,120,"Bottom Screen",Color.new(255,255,255),BOTTOM_SCREEN)
	
	-- Flip screens
	Screen.flip()
	Screen.waitVblankStart()
	
--Load rooms based on the currRoom value

	if (currRoom == 1) then
		currRoom = room_1()
	end
	
	if (currRoom == 2) then
		currRoom = room_2()
	end
	
end