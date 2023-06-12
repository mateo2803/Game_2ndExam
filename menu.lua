-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------

local composer = require("composer")
local scene = composer.newScene()
local background

function gotoSc1(event)
    if event.phase == "ended" then
        composer.gotoScene("Sc1", { time = 1000, effect = "slideRight" })
        print("on Scene1")
    end
    return true
end

function gotoSc2(event)
    if event.phase == "ended" then
        composer.gotoScene("Sc2", { time = 1000, effect = "slideRight" })
        print("on Scene2")
    end
    return true
end

function gotoSc3(event)
    if event.phase == "ended" then
        composer.gotoScene("Sc3", { time = 1000, effect = "slideLeft" })
        print("on Scene3")
    end
    return true
end

function gotoSc4(event)
    if event.phase == "ended" then
        composer.gotoScene("Sc4", { time = 1000, effect = "slideLeft" })
        print("on Scene4")
    end
    return true
end

function createButton(nx, ny, bx, by, showText, color)
    local buttonsGroup = display.newGroup()
    local button = display.newRoundedRect(buttonsGroup, nx, ny, bx, by, 5)
    button:setFillColor(0, 1, 0) 
    if showText == true then 
        local buttonText = display.newText(buttonsGroup, "Go", nx, ny, native.systemFontBold, 25)
        buttonText:setFillColor(0)
    end
    return buttonsGroup
end

function scene:create(event)
    local sceneGroup = self.view
    background = display.newRect(sceneGroup, 0, 0, CW, CH)
    background.x, background.y = CW / 2, CH / 2
    background.fill = {
        type = "image",
        filename = "Images.xcassets/Backgrounds/bg0.png"
    }

    rec1 = createButton(200, 380, 170, 700, false)
    rec2 = createButton(400, 380, 170, 700, false)
    rec3 = createButton(600, 380, 170, 700, false)
    rec4 = createButton(800, 380, 170, 700, false)

    button1 = createButton(200, 500, 100, 60, true)
    button2 = createButton(400, 500, 100, 60, true)
    button3 = createButton(600, 500, 100, 60, true)
    button4 = createButton(800, 500, 100, 60, true)

    button1:addEventListener("tap", gotoSc1)
    button2:addEventListener("tap", gotoSc2)
    button3:addEventListener("tap", gotoSc3)
    button4:addEventListener("tap", gotoSc4)
end

function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
    elseif phase == "did" then
        -- Code here runs when the scene is entirely on screen
        button1:addEventListener("touch", gotoSc1)
    end
end

function scene:hide(event)
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then
        button1.isVisible = false
        button2.isVisible = false
        button3.isVisible = false
        button4.isVisible = false

        rec1.isVisible = false
        rec2.isVisible = false
        rec3.isVisible = false
        rec4.isVisible = false
    elseif phase == "did" then
        -- Code here runs immediately after the scene goes entirely off screen

    end
end

function scene:destroy(event)
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene