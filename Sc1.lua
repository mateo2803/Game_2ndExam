-----------------------------------------------------------------------------------------
--
-- Sc1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local background
local altura = CH/2
local width  = CW/3
 
-------------------------- FUNCTION TO GO BACK TO MENU --------------------------

function gotoMenu(event)
    if event.phase == "ended" then
        composer.gotoScene("menu", { time = 1000, effect = "slideLeft" })
        print("on Menu")
    end
    return true
end

buttonMenu = display.newRect( 0, 50, 100, 60 )
buttonMenu:setFillColor( 0, 1, 0 )
buttonMenu:toFront( )


function scene:create( event )
-------------------------- PHYSICS, BACKGROUND AND STRUCTURES --------------------------
    local physics = require "physics"
    physics.start()
    physics.setDrawMode("hybrid")

    local sceneGroup = self.view
    grupoGrilla = display.newGroup()

    background = display.newImageRect(sceneGroup, "Images.xcassets/Backgrounds/bg1.png", CW, CH)
    background.x, background.y = CW/2, CH/2

    -- background2 = display.newImageRect(sceneGroup, "Images.xcassets/Backgrounds/bg1.png", CW, CH)
    -- background2.x = CW/2 - CW, background.y = CH/2

    platformMain = display.newRect( sceneGroup, 0, 520, 2048, 20 )
    platformMain:setFillColor( 0 )
 
    platform1 = display.newRect( sceneGroup, 220, 490, 30, 40 )
    platform1:setFillColor( 0 )

    platform2 = display.newRect( sceneGroup, 340, 500, 80, 40 )
    platform2:setFillColor( 0 )

    platform3 = display.newRect( sceneGroup, 620, 500, 160, 50 )
    platform3:setFillColor( 0 )

    physics.addBody( platformMain, "static" )
    physics.addBody( platform1, "static" )
    physics.addBody( platform2, "static" )
    physics.addBody( platform3, "static" )

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
            frames = {25,26,27},
            time = 400,  --  1 segundo cada 12 cuadros   8/12  2/3 
            loopCount = 0,
            sheet = c_sprite_right
        },
        {
            name = "up_move",
            time = 400,
            frames = {37,38,39},
            sheet = c_sprite_up
        },{
            name = "down_move",
            frames = {1,2,3},
            loopCount = 1,
            time = 400,
            sheet = c_sprite_down
        },
        {
            name = "left_move",
            frames = {13,14,15},
            time = 400,
            sheet = c_sprite_left

        }

    }

    local player = display.newSprite(c_sprite_right, sequence)
    player.x     = CW - 1000; 
    player.y     = CH - 400
    player:scale(0.9, 0.9)
    player:setSequence("right_move")
    player:play()

    physics.addBody(player, "dynami", {sceneGroup, radius = 20, bounce = 1})
    print(player.sequence, player.frame)

    print(physics.getGravity())

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
                
            end
            if player.sequence ~= "left_move" then
                player:setSequence("left_move")
            end
            if event.phase == "down" then
                player:translate(-1*speed, 0 )
                print(player.x, player.y)
            end
        elseif event.keyName == "space" then
            if player.isPlaying == false then 
                player:setSequence("up_move")
                player:play()
            end
            if player.sequence ~= "up_move" then
                player:setSequence("up_move")
            end
            if event.phase == "down" then
                player:translate(0, -1*speed )
                print(player.y, player.x)
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
                print(player.y)
            end
        end

    end

    Runtime:addEventListener("key", onKeyEvent)
    buttonMenu:addEventListener("tap", gotoMenu)
    buttonMenu:addEventListener("tap", gotoMenu)
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        buttonMenu:addEventListener("touch", gotoMenu)
 
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        platformMain.isVisible = false
        platform1.isVisible = false
        platform2.isVisible = false
        platform3.isVisible = false
        physics.stop()
        background.isVisible = false
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
 
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene