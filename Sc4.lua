-----------------------------------------------------------------------------------------
--
-- Sc4.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local physics  = require "physics"
local scene    = composer.newScene()
local background, background2, background3, player
 
local playerGroup     = display.newGroup() 
local buttonGroup     = display.newGroup()
local backgroundGroup = display.newGroup()

---------------------------------- create() ----------------------------------
function scene:create( event )
-------------------------- PHYSICS, BACKGROUND AND STRUCTURES --------------------------
    local sceneGroup = self.view
    
    physics.start()
    physics.pause()
    physics.setDrawMode("hybrid")
    
    sceneGroup:insert(backgroundGroup)
    sceneGroup:insert(buttonGroup)

    background = display.newImageRect(backgroundGroup, "Images.xcassets/Backgrounds/bg4.png", CW, CH)
    background.x, background.y = CW/2, CH/2

    background2 = display.newImageRect(backgroundGroup, "Images.xcassets/Backgrounds/bg4.png", CW, CH)
    background2.x = CW/2 + CW; background2.y = CH/2

    local scenario = 1

    platformMain = display.newRect( backgroundGroup, 1000, 540, 2048, 20 )
    platformMain:setFillColor( 0 )

    platform1 = display.newRect( backgroundGroup, CW/2 + 30, 280, 200, 20 )
    platform1:setStrokeColor(0) 

    platform2 = display.newRect( backgroundGroup, CW/2 + 195, 240, 50, 20 )
    platform2:setFillColor( 0 )

    platform3 = display.newRect( backgroundGroup, CW/2 + 400, 200, 100, 20 )
    platform3:setFillColor( 0 )

    platform4 = display.newRect( backgroundGroup, CW/2 + 640, 270, 110, 20 )
    platform4:setFillColor( 0 )

    physics.addBody( platformMain, "static", {bounce = 1, friction = 1} )
    physics.addBody( platform1, "static", {friction = 1} )
    physics.addBody( platform2, "static", {friction = 1} )
    physics.addBody( platform3, "static", {friction = 1} )
    physics.addBody( platform4, "static", {friction = 1} )

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
            frames = {76,77,78},
            time = 400,  --  1 segundo cada 12 cuadros   8/12  2/3 
            loopCount = 0,
            sheet = c_sprite_right
        },
        {
            name = "up_move",
            time = 400,
            frames = {88,89,90},
            sheet = c_sprite_up
        },{
            name = "down_move",
            frames = {52,53,54},
            loopCount = 1,
            time = 400,
            sheet = c_sprite_down
        },
        {
            name = "left_move",
            frames = {64,65,65},
            time = 400,
            sheet = c_sprite_left
        }
    }

    player = display.newSprite(backgroundGroup, c_sprite_right, sequence)
    player.x     = CW/2; 
    player.y     = 0
    player:scale(1.1, 1.1)
    player:setSequence("right_move")
    player:play()

    physics.addBody(player, "dynami", {radius = 30, bounce = 0, friction = 0.1})
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
            if player.isPlaying == false then 
                player:setSequence("up_move")
                player:play()
            end
            if player.sequence ~= "up_move" then
                player:setSequence("up_move")
            end
            if event.phase == "down" then
                player:translate(0, -4*speed )
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

    Runtime:addEventListener   ("enterFrame", camera)
    Runtime:addEventListener   ("key"       , onKeyEvent)
    buttonMenu:addEventListener("tap"       , gotoMenu)
    buttonMenu:addEventListener("tap"       , gotoMenu)

    sceneGroup:insert(buttonGroup)
    sceneGroup:insert(playerGroup)
end
 
---------------------------------- show() ----------------------------------
function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- physics.start()
    elseif ( phase == "did" ) then
        physics.start()
        buttonMenu:addEventListener("touch", gotoMenu)
    end
end
---------------------------------- hide() ----------------------------------
function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase
    if ( phase == "will" ) then
         -- physics.start()
    elseif ( phase == "did" ) then
        physics.stop()
        -- Code here runs immediately after the scene goes entirely off screen
    end
end
---------------------------------- destroy() ----------------------------------
function scene:destroy( event )
    local sceneGroup = self.view
end
---------------------------------- NEW SCENE ----------------------------------
function newScreen()
    player.x = 20
    transition.to(backgroundGroup,{alpha = 1, time =1000, delay=500})
        local paint = {
        type = "image",
        filename = "Images.xcassets/Backgrounds/bg4.png"
    }
    background.fill = paint
end

function camera(e)
    backgroundGroup.x = -player.x + CW/2   --defase 
end
-------------------------- GO BACK TO MENU --------------------------
function gotoMenu(event)
    if event.phase == "ended" then
        composer.gotoScene("menu", { time = 1000, effect = "slideRight" })
        print("on Menu")
    end
    return true
end
-------------------------- listeners ---------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
 
return scene