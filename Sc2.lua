-----------------------------------------------------------------------------------------
--
-- Sc2.lua
--
-----------------------------------------------------------------------------------------
local physics  = require "physics"
local composer = require( "composer" )
local scene    = composer.newScene()
local background, background2, background3, player
---------------------------------- GROUPS ---------------------------------- 
local playerGroup     = display.newGroup() 
local buttonGroup     = display.newGroup()
local backgroundGroup = display.newGroup()
-------------------------- create() --------------------------
function scene:create( event )
------------------ PHYSICS, BACKGROUND AND STRUCTURES ------------------
    local sceneGroup = self.view

    physics.start()
    physics.pause()
    physics.setDrawMode("hybrid")
    
    sceneGroup:insert(backgroundGroup)
    sceneGroup:insert(buttonGroup)

    background = display.newImageRect(backgroundGroup, "Images.xcassets/Backgrounds/bg2.png", CW, CH)
    background.x, background.y = CW/2, CH/2

    background2 = display.newImageRect(backgroundGroup, "Images.xcassets/Backgrounds/bg2.png", CW, CH)
    background2.x = CW/2 + CW; background2.y = CH/2

    background3 = display.newImageRect(backgroundGroup, "Images.xcassets/Backgrounds/bg2.png", CW, CH)
    background3.x = CW/2 - CW; background3.y = CH/2

    local scenario = 1

    platform1 = display.newRect( backgroundGroup, 0, 540, 700, 20 )
    platform1:setFillColor( 0 )
 
    platform2 = display.newRect( backgroundGroup, 850, 540, 350, 20 )
    platform2:setFillColor( 0 )

    platform3 = display.newRect( backgroundGroup, 0, 270, 550, 20 )
    platform3:setFillColor( 0 )

    platform4 = display.newRect( backgroundGroup, 900, 270, 350, 20 )
    platform4:setFillColor( 0 )

    platform5 = display.newRect( backgroundGroup, CW/2, 480, 100, 20 )
    platform5:setFillColor( 0 )

    physics.addBody( platform1, "static", {friction = 1} )
    physics.addBody( platform2, "static", {friction = 1} )
    physics.addBody( platform3, "static", {friction = 1} )
    physics.addBody( platform4, "static", {friction = 1} )
    physics.addBody( platform5, "static", {friction = 1} )

-------------------------- CHARACTER MOVEMENT --------------------------
    local speed = 15

    local char_options = {
        width     = 624/12,
        height    = 576/8,
        numFrames = 96
    }

    c_sprite_right = graphics.newImageSheet("Images.xcassets/Characters/characters.png", char_options)
    c_sprite_left  = graphics.newImageSheet("Images.xcassets/Characters/characters.png", char_options)
    c_sprite_up    = graphics.newImageSheet("Images.xcassets/Characters/characters.png", char_options)
    c_sprite_down  = graphics.newImageSheet("Images.xcassets/Characters/characters.png", char_options)

    local sequence = {
        {
            name = "right_move",
            frames = {34,35,36},
            time = 400,  --  1 segundo cada 12 cuadros   8/12  2/3 
            loopCount = 0,
            sheet = c_sprite_right
        },
        {
            name = "up_move",
            time = 400,
            frames = {46,47,48},
            sheet = c_sprite_up
        },{
            name = "down_move",
            frames = {10,11,12},
            loopCount = 1,
            time = 400,
            sheet = c_sprite_down
        },
        {
            name = "left_move",
            frames = {22, 23, 24},
            time = 400,
            sheet = c_sprite_left

        }

    }

    player   = display.newSprite(backgroundGroup, c_sprite_right, sequence)
    player.x = CW/2; 
    player.y = CH - 400
    player:scale(2, 2)
    player:setSequence("right_move")
    player:play()

    physics.addBody(player, "dynami", {radius = 60, bounce = 0.5, friction = 0.1})
    player.isFixedRotation = true

    buttonMenu = display.newRoundedRect( buttonGroup, 950, 50, 100, 60, 15 )
    buttonMenu:setFillColor( 153/255, 255/255, 153/255)
    buttonMenu:toFront( )
    local buttonText = display.newText( buttonGroup, "Go Back", 950, 50, native.systemFontBold, 20 )
    buttonText:setFillColor(0,0,0)
    buttonText:toFront( )

    function onKeyEvent(event)
        if event.keyName == "right" then
            if player.isPlaying == false then 
                player:setSequence("right_move")
                player:play()
            end
            if player.sequence ~= "right_move" then
                player:setSequence("right_move")
            end
            if event.phase == "down" then
                player:translate(speed, 0 )
            end
        elseif event.keyName == "left" then
            if player.isPlaying == false then 
                player:setSequence("left_move")
                player:play()
            end
            if player.sequence ~= "left_move" then
                player:setSequence("left_move")
            end
            if event.phase == "down" then
                player:translate(-1*speed, 0 )
            end
         elseif event.keyName == "space" then
	        if event.phase == "down" then
	            if not spacePressed then
	                player:setSequence("up_move")
	                player:play()
	                player:translate(0, -5 * speed)
	                spacePressed = true
	            else
	                -- Perform double jump action
	                player:setSequence("up_move")
	                player:play()
	                player:translate(0, -5 * speed)
	                spacePressed = false
	            end
        	end
        elseif event.keyName == "down" then
            if player.isPlaying == false then 
                player:setSequence("down_move")
                player:play()
            end
            if player.sequence ~= "down_move" then
                player:setSequence("down_move")
            end
            if event.phase == "down" then
                player:translate(0, 1*speed )
            end
        end

    end

    Runtime:addEventListener   ("enterFrame", camera	)
    Runtime:addEventListener   ("key"       , onKeyEvent)
    buttonMenu:addEventListener("tap"       , gotoMenu	)
    buttonMenu:addEventListener("tap"		, gotoMenu	)

    sceneGroup:insert(buttonGroup)
    sceneGroup:insert(playerGroup)
end
-------------------------- show() -----------------------------
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
    	physics.start()
    elseif ( phase == "did" ) then
        --physics.start()
        buttonMenu:addEventListener("touch", gotoMenu)
    end
end
-------------------------- hide() -----------------------------
function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase
    if ( phase == "will" ) then
        physics.stop() 
    elseif ( phase == "did" ) then
        
    end
end
-------------------------- destroy() --------------------------
function scene:destroy( event )
    local sceneGroup = self.view
end
-------------------------- NEW SCENE --------------------------
function newScreen()
        player.x = 20
        transition.to(bacgroundGroup,{alpha = 1, time =1000, delay=500})
        local paint = {
            type = "image",
            filename = "Images.xcassets/Backgrounds/bg2.png"
        }
        background.fill = paint
end

function camera(e)
    backgroundGroup.x = -player.x + CW/2 --defase 
end
-------------------------- GO BACK TO MENU --------------------------
function gotoMenu(event)
    if event.phase == "ended" then
        composer.gotoScene("menu", { time = 1000, effect = "slideLeft" })
        print("on Menu")
    end
    return true
end
-------------------------- listeners --------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
 
return scene