-----------------------------------------------------------------------------------------
--
-- Sc3.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local background
local altura = CH/2
local width  = CW/3
 
local playerGroup = display.newGroup() 
local buttonGroup = display.newGroup()
local backgroundGroup = display.newGroup()
local structuresGroup = display.newGroup()

function gotoMenu(event)
    if event.phase == "ended" then
        composer.gotoScene("menu", { time = 1000, effect = "slideRight" })
        print("on Menu")
    end
    return true
end

function scene:create( event )
-------------------------- PHYSICS, BACKGROUND AND STRUCTURES --------------------------
    local sceneGroup = self.view

    local physics = require "physics"
    physics.start()
    physics.setDrawMode("hybrid")

    
    sceneGroup:insert(backgroundGroup)
    sceneGroup:insert(structuresGroup)

    buttonMenu = display.newRoundedRect( buttonGroup, 950, 50, 100, 60, 15 )
    buttonMenu:setFillColor( 153/255, 255/255, 153/255)
    buttonMenu:toFront( )
    local buttonText = display.newText( buttonGroup, "Go Back", 950, 50, native.systemFontBold, 20 )
    buttonText:setFillColor(0,0,0)
    buttonText:toFront( )

    background = display.newImageRect(backgroundGroup, "Images.xcassets/Backgrounds/bg3.png", CW, CH)
    background.x, background.y = CW/2, CH/2

    -- background2 = display.newImageRect(backgroundGroup, "Images.xcassets/Backgrounds/bg2.png", CW, CH)
    -- background2.x = CW/2 + CW, background2.y = CH/2

    local scenario = 1

    platform1 = display.newRect( structuresGroup, CW/2, 640, 1000, 20 )
    platform1:setFillColor( 0 )
 
    platform2 = display.newRect( structuresGroup, 420, 580, 90, 100 )
    platform2:setFillColor( 0 )

    platform3 = display.newRect( structuresGroup, 465, 580, 550, 20 )
    platform3:setFillColor( 0 )

    -- platform4 = display.newRect( structuresGroup, 900, 270, 350, 20 )
    -- platform4:setFillColor( 0 )

    -- platform5 = display.newRect( structuresGroup, CW/2, 480, 100, 20 )
    -- platform5:setFillColor( 0 )

    physics.addBody( platform1, "static", {friction = 1} )
    physics.addBody( platform2, "static", {friction = 1} )
    -- physics.addBody( platform3, "static", {friction = 1} )
    -- physics.addBody( platform4, "static", {friction = 1} )
    -- physics.addBody( platform5, "static", {friction = 1} )

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

    local player = display.newSprite(sceneGroup, c_sprite_right, sequence)
    player.x     = CW - 1000; 
    player.y     = CH - 400
    player:scale(2, 2)
    player:setSequence("right_move")
    player:play()

    physics.addBody(player, "dynami", {radius = 60, bounce = 1, friction = 0.1})
    print(player.sequence, player.frame)
    player.isFixedRotation = true
    --print(physics.getGravity())

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

    -- Runtime:addEventListener("enterFrame", camera)
    Runtime:addEventListener("key", onKeyEvent)
    buttonMenu:addEventListener("tap", gotoMenu)
    buttonMenu:addEventListener("tap", gotoMenu)

    sceneGroup:insert(buttonGroup)
    sceneGroup:insert(playerGroup)
end
 
-- function newScreen()
--         player.x = 20
--         transition.to(bacgroundGroup,{alpha = 1, time =1000, delay=500})
--         local paint = {
--             type = "image",
--             filename = "Images.xcassets/Backgrounds/bg2.png"
--         }
--         background.fill = paint
--     end

--     function cambiarPantalla()
--         if scenario == 1 then
--             transition.to(bacgroundGroup, {alpha = 0.1, time = 1500, delay = 500, onComplete=newScreen})
--             scenario = 2
--         end
--     end

--     function camera(e)
--         if player.x > CW then -- verificacion si nos salimos de pantalla
--             print("Nos salimos de pantalla")
--             cambiarPantalla() -- mover la pantalla cuando el personaje excede el limite y desplegar un escenario nuevo con un efecto.
--         end

--         bacgroundGroup.x = -player.x  + CW/2 --defase 
--         buttonGroup.x = -bacgroundGroup.x
--     end
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        physics.start()
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        physics.start()
        buttonMenu:addEventListener("touch", gotoMenu)
 
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
         
    elseif ( phase == "did" ) then
        physics.stop()
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