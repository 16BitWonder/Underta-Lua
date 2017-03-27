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
local cam_pos_y = 0

--Player position
local frisk_x = 195
local frisk_y = 100

--Collision variables from all four sides
local topColl = false
local bottColl = false
local rightColl = false
local leftColl = false

local function room1()

room1 = Graphics_loadImage("/3ds/Underta-Lua/tex/rooms-(1-42)-ruins/room1.png")
roomtransit = Graphics_loadImage("/3ds/Underta-Lua/tex/rooms-(1-42)-ruins/room_transition.png")

	-- Main Loop
	while true do

	--GRAPHICS
	
		-- Updating screens
		Screen.refresh()
		Graphics.initBlend(TOP_SCREEN)
		Screen.clear(BOTTOM_SCREEN)
	
		--Top screen resolution (412x240), Bottom screen resolution (320x240)
	
		--Draw textures, Width can only be up to 400		EVENTUALLY CHANGE THIS AND OTHER VALUES SO IT IS JUST DRAWIMAGE
		Graphics_drawPartialImage(0,0,cam_pos_x,0,400,240,room1)
	
		Graphics_drawImage(frisk_x,frisk_y,friskFace0)
	
		Screen.debugPrint(0,0,cam_pos_x,Color.new(255,255,255),BOTTOM_SCREEN)
		Screen.debugPrint(0,20,frisk_x,Color.new(255,255,255),BOTTOM_SCREEN)
		Screen.debugPrint(0,35,frisk_y,Color.new(255,255,255),BOTTOM_SCREEN)
	
		Screen.debugPrint(70,140,"Press Start To Exit",Color.new(255,255,255),BOTTOM_SCREEN)
		Screen.debugPrint(60,160,"Press Select for FTPD",Color.new(255,255,255),BOTTOM_SCREEN)
		Screen.debugPrint(90,120,"Bottom Screen",Color.new(255,255,255),BOTTOM_SCREEN)
	
		--CONTROLS

		if (Controls_check(Controls_read(),KEY_START)) then
			Graphics.term()
			System.exit()
		end
		
		if (Controls_check(Controls_read(),KEY_L)) then
			return 1
		end
		
		if (Controls_check(Controls_read(),KEY_SELECT)) then
			System.launch3DSX("/3ds/ftpd/ftpd.3dsx")
		end
	
		--Change camera position Eventually change the subtraction and addition number to correspond with player speed
		if (Controls_check(Controls_read(),KEY_DLEFT)) then--MOVE LEFT
			if ((frisk_x > 75 and cam_pos_x == 0) or (frisk_x > 195 and cam_pos_x == 401)) then
				frisk_x = frisk_x - 1
			end
		
			if (cam_pos_x > 0 and frisk_x == 195) then
				cam_pos_x = cam_pos_x - 1
			end
		end
		if (Controls_check(Controls_read(),KEY_DRIGHT)) then--MOVE RIGHT
			if (frisk_x < 195 or (cam_pos_x == 401 and frisk_x < 293)) then
				frisk_x = frisk_x + 1
			end
		
			if (cam_pos_x < 401 and frisk_x == 195) then
				cam_pos_x = cam_pos_x + 1
			end
		end
		if (Controls_check(Controls_read(),KEY_DUP)) then--MOVE UP
			if (((frisk_x > 113 and cam_pos_x < 79) and frisk_y > 22) or ((cam_pos_x > 78 and cam_pos_x < 119) and frisk_y > 41) or (frisk_x < 114 and frisk_y > 41) or (cam_pos_x > 120 and frisk_y > 120)) then
				frisk_y = frisk_y - 1
			end
			
			if (frisk_x > 240 and frisk_x < 280 and frisk_y == 120) then--LOAD INTO ROOM TWO IF UP ON DOORWAY
				timer = Timer.new()
				transit = Color.new(0,0,0,255)

				while (Timer.getTime(timer) < 250) do
				
					Screen.refresh()
					Graphics.initBlend(TOP_SCREEN)
					
					Graphics_drawImage(0,0,roomtransit,transit)
					
					Graphics.termBlend()
					Screen.flip()
					Screen.waitVblankStart()
				end
				
				Timer.destroy(timer)
				
				Screen.clear(TOP_SCREEN)
				
				return 2
			end
		end
		if (Controls_check(Controls_read(),KEY_DDOWN)) then--MOVE DOWN
			if (cam_pos_x < 80 or frisk_y < 148) then
				frisk_y = frisk_y + 1
			end
		end	
		
		--Terminate graphic blend
		Graphics.termBlend()
	
		-- Flip screens
		Screen.flip()
		Screen.waitVblankStart()
		
	end
end

M.room1 = room1
return M