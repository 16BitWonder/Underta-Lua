local M = {}

--Localize some functions for fast access
local Graphics_loadImage = Graphics.loadImage
local Graphics_drawPartialImage = Graphics.drawPartialImage
local Graphics_drawImage = Graphics.drawImage
local Controls_check = Controls.check
local Controls_read = Controls.read

--Whether player is moving or not, use this and a timer for cycling player sprites, left and right take priority
local isMoving = false

--Camera position
local cam_pos_x = 0
local cam_pos_y = -99

--Player position
local frisk_x = 190
local frisk_y = 209

--Collision variables from all four sides
local topColl = false
local bottColl = false
local rightColl = false
local leftColl = false

local function room2()

room2 = Graphics_loadImage("/3ds/Underta-Lua/tex/rooms-(1-42)-ruins/room2.png")

	-- Main Loop
	while true do

	--GRAPHICS
	
		-- Updating screens
		Screen.refresh()
		Graphics.initBlend(TOP_SCREEN)
		Screen.clear(BOTTOM_SCREEN)
	
		--Top screen resolution (412x240), Bottom screen resolution (320x240)
	
		--Draw textures, Width can only be up to 400		EVENTUALLY CHANGE THIS AND OTHER VALUES SO IT IS JUST DRAWIMAGE
		Graphics_drawImage(0,cam_pos_y,room2)
	
		Graphics_drawImage(frisk_x,frisk_y,friskFace0)
	
		Screen.debugPrint(0,0,cam_pos_x,Color.new(255,255,255),BOTTOM_SCREEN)
		Screen.debugPrint(0,20,frisk_x,Color.new(255,255,255),BOTTOM_SCREEN)
		Screen.debugPrint(0,35,frisk_y,Color.new(255,255,255),BOTTOM_SCREEN)
	
		Screen.debugPrint(70,140,"Press Start To Exit",Color.new(255,255,255),BOTTOM_SCREEN)
		Screen.debugPrint(60,160,"Press Select for FTPD",Color.new(255,255,255),BOTTOM_SCREEN)
		Screen.debugPrint(90,120,"Bottom Screen",Color.new(255,255,255),BOTTOM_SCREEN)
	
		--Terminate graphic blend
		Graphics.termBlend()
	
		-- Flip screens
		Screen.flip()
		Screen.waitVblankStart()
	
		--CONTROLS

		if (Controls_check(Controls_read(),KEY_START)) then
			Graphics.term()
			System.exit()
		end
		
		if (Controls_check(Controls_read(),KEY_L)) then
			return 2
		end
		
		if (Controls_check(Controls_read(),KEY_SELECT)) then
			System.launch3DSX("/3ds/ftpd/ftpd.3dsx")
		end
	
		--Change camera position Eventually change the subtraction and addition number to correspond with player speed
		if (Controls_check(Controls_read(),KEY_DLEFT)) then--MOVE LEFT

				frisk_x = frisk_x - 1

		end
		if (Controls_check(Controls_read(),KEY_DRIGHT)) then--MOVE RIGHT

				frisk_x = frisk_x + 1

		end
		if (Controls_check(Controls_read(),KEY_DUP)) then--MOVE UP
			if ((frisk_y > 100) or (cam_pos_y == 0)) then
				frisk_y = frisk_y - 1
			end
			
			if ((frisk_y == 100) and (cam_pos_y < 0)) then
				cam_pos_y = cam_pos_y + 1
			end
				
		end
		if (Controls_check(Controls_read(),KEY_DDOWN)) then--MOVE DOWN
			if (((frisk_y < 100) and (cam_pos_y == 0)) or ((frisk_y > 99) and (cam_pos_y == -99))) then
				frisk_y = frisk_y + 1
			end
			
			if ((frisk_y == 100) and (cam_pos_y > -99)) then
				cam_pos_y = cam_pos_y - 1
			end
			
		end
	end
end

M.room2 = room2
return M