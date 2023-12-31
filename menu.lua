-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------

greenDark   = { 0/255  , 153/255, 76/255  }
green       = { 0/255  , 255/255, 0/255   }
greenLight  = { 153/255, 255/255, 153/255 }

redDark     = { 153/255, 0/255  , 0/255   }
red         = { 255/255, 0/255  , 0/255   }
redLight    = { 255/255, 204/255, 204/255 }

yellowDark  = { 153/255, 153/255, 0/255   }
yellow      = { 255/255, 255/255, 0/255   }
yellowLight = { 255/255, 255/255, 204/255 } 

lightGrey   = { 224/255, 224/255, 224/255 }

black = {0,0,0}

local composer = require("composer")
local scene    = composer.newScene()
local background

---------------------- GO TO SCENE 1 ----------------------
function gotoSc1(event)
    if event.phase == "ended" then
        composer.gotoScene("Sc1", { time = 1000, effect = "slideRight" })
        print("on Scene1")
    end
    return true
end
---------------------- GO TO SCENE 2 ----------------------
function gotoSc2(event)
    if event.phase == "ended" then
        composer.gotoScene("Sc2", { time = 1000, effect = "slideRight" })
        print("on Scene2")
    end
    return true
end
---------------------- GO TO SCENE 3 ----------------------
function gotoSc3(event)
    if event.phase == "ended" then
        composer.gotoScene("Sc3", { time = 1000, effect = "slideLeft" })
        print("on Scene3")
    end
    return true
end
---------------------- GO TO SCENE 4 ----------------------
function gotoSc4(event)
    if event.phase == "ended" then
        composer.gotoScene("Sc4", { time = 1000, effect = "slideLeft" })
        print("on Scene4")
    end
    return true
end
---------------------- BUTTONS AND BG IMAGES ----------------------
function createButton(nx, ny, bx, by, showText, color, imagePath)
    local buttonsGroup = display.newGroup()

    local button = display.newRoundedRect(buttonsGroup, nx, ny, bx, by, 15)
    button:setFillColor(unpack(color))

    if imagePath then
        local image = display.newImageRect(buttonsGroup, imagePath, bx, by)
        image.x = nx
        image.y = ny
    elseif showText == true then
        local buttonText = display.newText(buttonsGroup, "Go", nx, ny, native.systemFontBold, 25)
        buttonText:setFillColor(unpack(black))
    end

    return buttonsGroup
end
---------------------------------- create() ----------------------------------
function scene:create(event)
    local sceneGroup = self.view
    background = display.newRect(sceneGroup, 0, 0, CW, CH)
    background.x, background.y = CW / 2, CH / 2
    background.fill = {
        type = "image",
        filename = "Images.xcassets/Backgrounds/bg0.png"
    }

    rec1 = createButton(200, 380, 170, 700, false, lightGrey, "Images.xcassets/Backgrounds/bg1.png")
    rec2 = createButton(400, 380, 170, 700, false, lightGrey, "Images.xcassets/Backgrounds/bg2.png")
    rec3 = createButton(600, 380, 170, 700, false, lightGrey, "Images.xcassets/Backgrounds/bg3.png")
    rec4 = createButton(800, 380, 170, 700, false, lightGrey, "Images.xcassets/Backgrounds/bg4.png")

    button1 = createButton(200, 500, 100, 60, true, greenLight)
    button2 = createButton(400, 500, 100, 60, true, greenLight)
    button3 = createButton(600, 500, 100, 60, true, greenLight)
    button4 = createButton(800, 500, 100, 60, true, greenLight)

    button1:addEventListener("tap", gotoSc1)
    button2:addEventListener("tap", gotoSc2)
    button3:addEventListener("tap", gotoSc3)
    button4:addEventListener("tap", gotoSc4)

    sceneGroup:insert(rec1)
    sceneGroup:insert(rec2)
    sceneGroup:insert(rec3)
    sceneGroup:insert(rec4)

    sceneGroup:insert(button1)
    sceneGroup:insert(button2)
    sceneGroup:insert(button3)
    sceneGroup:insert(button4)
end
---------------------------------- show() ----------------------------------
function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then

    elseif phase == "did" then
        button1:addEventListener("touch", gotoSc1)
        button2:addEventListener("touch", gotoSc2)
        button3:addEventListener("touch", gotoSc3)
        button4:addEventListener("touch", gotoSc4)
    end
end
---------------------------------- hide() ----------------------------------
function scene:hide(event)
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then

    elseif phase == "did" then

    end
end
---------------------------------- destroy() ----------------------------------
function scene:destroy(event)
    local sceneGroup = self.view
end
---------------------------------- destroy() ----------------------------------
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene