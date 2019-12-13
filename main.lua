
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720


-- -- background image and starting scroll location (X axis)
local secretary = love.graphics.newImage('secretary.png')
local teacher = love.graphics.newImage('teacher.png')
local bird = love.graphics.newImage('bird.png')
local fairy = love.graphics.newImage('fairy-small.png')
local cat = love.graphics.newImage('cat-3.png')
local dragonStory01 = love.graphics.newImage('dragon01.jpg')
local fairysetplay001 = love.graphics.newImage('fairy-setplay001.png')
local fairysetplay002 = love.graphics.newImage('fairy-setplay002.png')
local fairysetplay003 = love.graphics.newImage('fairy-setplay003.png')
local fairysetplay003 = love.graphics.newImage('fairy-setplay003.png')
local map = love.graphics.newImage('map.jpg')
local dragonIntro = love.graphics.newImage('dragon-intro.jpg')



local isASelected_freeplay = false
local isBSelected_freeplay = false

local ablockXfree = 100
local ablockYfree = 100
local bblockXfree = 300
local bblockYfree = 300


local letters = {
                    A = {char="A", isSelected = false, x=80, y=0, placed = false}, 
                    B = {char="B", isSelected = false, x=160, y=0, placed = false}, 
                    C = {char="C", isSelected = false, x=240, y=0, placed = false}, 
                    D = {char="D", isSelected = false, x=320, y=0, placed = false}, 
                    E = {char="E", isSelected = false, x=400, y=0, placed = false}, 
                    F = {char="F", isSelected = false, x=480, y=0, placed = false}, 
                    G = {char="G", isSelected = false, x=560, y=0, placed = false}, 
                    H = {char="H", isSelected = false, x=560, y=80, placed = false}, 
                    I = {char="I", isSelected = false, x=560, y=160, placed = false}, 
                    J = {char="J", isSelected = false, x=560, y=240, placed = false}, 
                    K = {char="K", isSelected = false, x=560, y=320, placed = false},
                    L = {char="L", isSelected = false, x=560, y=400, placed = false}, 
                    M = {char="M", isSelected = false, x=560, y=480, placed = false}, 
                    N = {char="N", isSelected = false, x=560, y=560, placed = false}, 
                    O = {char="O", isSelected = false, x=480, y=560, placed = false}, 
                    P = {char="P", isSelected = false, x=400, y=560, placed = false}, 
                    Q = {char="Q", isSelected = false, x=320, y=560, placed = false}, 
                    R = {char="R", isSelected = false, x=240, y=560, placed = false}, 
                    S = {char="S", isSelected = false, x=160, y=560, placed = false}, 
                    T = {char="T", isSelected = false, x=80, y=560, placed = false}, 
                    U = {char="U", isSelected = false, x=0, y=560, placed = false}, 
                    V = {char="V", isSelected = false, x=0, y=480, placed = false}, 
                    W = {char="W", isSelected = false, x=0, y=400, placed = false}, 
                    X = {char="X", isSelected = false, x=0, y=320, placed = false}, 
                    Y = {char="Y", isSelected = false, x=0, y=240, placed = false}, 
                    Z = {char="Z", isSelected = false, x=0, y=160, placed = false}
                }
      
local target1 = {x = 170, y = 430}
local target2 = {x = 280, y = 430}
local target3 = {x = 390, y = 430}

local collision = false

mouse = {}

sound = love.audio.newSource("bird.mp3", "static") -- the "static" tells LÖVE to load the file into memory, good for short sound effects
woodblock = love.audio.newSource("woodblock.wav", "static")


function love.load()

    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true
    })
    smallFont = love.graphics.newFont('Solway.ttf', 32)
    largeFont = love.graphics.newFont('Solway.ttf', 70)
    gameState = 'start'

    -- for selecting
    aBlock_freeplay = 	{hover = false, text = "A", x = 200, y = 100, call = selectBlockAFreePlay}
    bBlock_freeplay = 	{hover = false, text = "B", x = 200, y = 100, call = selectBlockBFreePlay}

    fairysprite = fairysetplay001
    fairySpeech = "Oi, what's this then?"

    -- animation
    animation = newAnimation(love.graphics.newImage("fairy-spritesheet.png"), 400, 400, 1.5)

end


function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()

    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'screen2'
        elseif gameState == 'screen2' then
            gameState = 'introMode'    
        elseif gameState == 'introMode' then          
            gameState = 'mapMode'
        elseif gameState == 'mapMode' then            
            gameState = 'stageIntroMode'    
        elseif gameState == 'stageIntroMode' then            
            gameState = 'storyMode'    

            -- gameState = 'freeplay'
        -- elseif gameState == 'map' then
        --     gameState = 'freeplay'
        -- elseif gameState == 'freeplay' then
        --     gameState = 'intro'
        -- elseif gameState == 'intro' then
         
        elseif gameState == 'storyMode' then
            gameState = 'exerciseMode'
        end
    end
end

function love.draw()
             
    love.graphics.setFont(smallFont)
    love.graphics.clear(0, 0, 0, 255)

    if gameState == 'start' then
      
        love.graphics.draw(secretary, 440, 20, 0, 0.4, 0.4)

        love.graphics.setColor(1, 1, 1)
        love.graphics.printf('Oh wonderful, a new learner.', 0, 600, WINDOW_WIDTH, 'center')

    elseif gameState == 'screen2' then
        love.graphics.draw(teacher, 440, 20, 0, 0.4, 0.4)
        love.graphics.printf('Hurry child, there is much to do. Do not tarry.', 0, 600, WINDOW_WIDTH, 'center')


    elseif gameState == 'introMode' then

        love.graphics.printf("Welcome", 0, 50, 640, "center")
        love.graphics.printf("We have been waiting for you", 0, 100, 640, "center")

        love.graphics.printf("This is Wild World", 0, 200, 640, "center")
        love.graphics.printf("All knowledge has been lost", 0, 250, 640, "center")
        love.graphics.printf("Including the names of things", 0, 300, 640, "center")

        love.graphics.printf("We need you to help us with this please", 0, 400, 640, "center")    

        -- draw stage
        love.graphics.rectangle('line', 00, 00, 640, 640)

        -- the screen
        love.graphics.rectangle('line', 00, 00, 990, 720)

              -- menu area
       love.graphics.setColor(100, 100, 100)
       love.graphics.rectangle('line', 640, 00, 350, 80)
       love.graphics.printf("menu", 880, 0, 100, "center")

       -- Fairy area
       love.graphics.rectangle('line', 640, 80, 350, 520)
       love.graphics.draw(fairysprite, 640, 80, 0, 1, 1)

       love.graphics.rectangle('line', 640, 600, 350, 40)
       

       -- audio area    
       love.graphics.rectangle('line', 0, 640, 990, 80)
       love.graphics.setColor(100, 100, 100)
       love.graphics.printf("controls", 0, 640, 640, "center")



    elseif gameState == 'mapMode' then

        -- map
        love.graphics.draw(map, 00, 0, 0, 0.7, 0.7)

        love.graphics.setColor(100, 100, 100)

        love.graphics.printf("This is Wild World", 0, 535, 640, "center")
        love.graphics.printf("There are many people that need your help", 0, 585, 640, "center")
        love.graphics.printf("Choose where you want to go first", 0, 660, 640, "center")

        -- draw stage
        -- love.graphics.rectangle('line', 00, 00, 640, 640)

        -- the screen
        love.graphics.rectangle('line', 00, 00, 990, 720)

                -- menu area
         love.graphics.setColor(100, 100, 100)
         love.graphics.rectangle('line', 640, 00, 350, 80)
         love.graphics.printf("menu", 880, 0, 100, "center")
 
 
         -- Fairy area
         love.graphics.rectangle('line', 640, 80, 350, 520)
         love.graphics.draw(fairysprite, 640, 80, 0, 1, 1)
 
         love.graphics.rectangle('line', 640, 600, 350, 40)
         
 
         -- audio area    
         love.graphics.rectangle('line', 640, 640, 350, 80)
         love.graphics.setColor(100, 100, 100)


        --  love.graphics.printf("controls", 0, 640, 640, "center")



    elseif gameState == 'freeplay' then

        -- draw stage
        love.graphics.rectangle('line', 20, 20, 900, 670)
        love.graphics.draw(fairy, 930, 150, 0, 1, 1)
        love.graphics.printf('Press "p" for', -50, 30, WINDOW_WIDTH, 'right')
        love.graphics.printf('setplay mode', -50, 70, WINDOW_WIDTH, 'right')

        -- draw block A
        love.graphics.printf(aBlock_freeplay.text, ablockXfree - 50, ablockYfree + 50 - 16, 200, "center")
        love.graphics.rectangle('line', ablockXfree, ablockYfree, 100, 100)

        -- draw block B
        love.graphics.printf(bBlock_freeplay.text, bblockXfree - 50, bblockYfree + 50 - 16, 200, "center")
        love.graphics.rectangle('line', bblockXfree, bblockYfree, 100, 100)

        -- A block movement
        if isASelected_freeplay == false then
        elseif isASelected_freeplay == true then
            if collision == false then
                if love.keyboard.isDown('w') then
                    ablockYfree = ablockYfree - 3
                elseif love.keyboard.isDown('s') then
                    ablockYfree = ablockYfree + 3
                elseif love.keyboard.isDown('a') then
                    ablockXfree = ablockXfree - 3
                elseif love.keyboard.isDown('d') then
                    ablockXfree = ablockXfree + 3
                end
            elseif collision == true then
                if love.keyboard.isDown('w') then
                    ablockYfree = ablockYfree + 10
                elseif love.keyboard.isDown('s') then
                    ablockYfree = ablockYfree - 10
                elseif love.keyboard.isDown('a') then
                    ablockXfree = ablockXfree + 10
                elseif love.keyboard.isDown('d') then
                    ablockXfree = ablockXfree - 10
                end
             end
        end

        

        -- B block movement
        if isBSelected_freeplay == false then
        elseif isBSelected_freeplay == true then
            if collision == false then
                if love.keyboard.isDown('w') then
                    bblockYfree = bblockYfree - 3
                elseif love.keyboard.isDown('s') then
                    bblockYfree = bblockYfree + 3
                elseif love.keyboard.isDown('a') then
                    bblockXfree = bblockXfree - 3
                elseif love.keyboard.isDown('d') then
                    bblockXfree = bblockXfree + 3
                end
            elseif collision == true then
                if love.keyboard.isDown('w') then
                    bblockYfree = bblockYfree + 10
                elseif love.keyboard.isDown('s') then
                    bblockYfree = bblockYfree - 10
                elseif love.keyboard.isDown('a') then
                    bblockXfree = bblockXfree + 10
                elseif love.keyboard.isDown('d') then
                    bblockXfree = bblockXfree - 10
                end
            end
        end

    elseif gameState == 'intro' then
        love.graphics.draw(bird, 40, 100, 0, 1, 1)
        love.graphics.printf("I have your new exercises here", 500, 200, 500, "center")


    elseif gameState == 'stageIntroMode' then

        -- stage character
        love.graphics.draw(dragonIntro, 0, 00, 0, 0.6, 0.6)
        love.graphics.printf("I am trying to tame a dragon", 0, 600, 640, "center")

        -- Fairy area
        love.graphics.rectangle('line', 640, 80, 350, 520)
        love.graphics.draw(fairysprite, 640, 80, 0, 1, 1)

        love.graphics.rectangle('line', 640, 600, 350, 40)
        

        -- audio area    
        love.graphics.rectangle('line', 0, 640, 990, 80)
        love.graphics.setColor(100, 100, 100)
        -- love.graphics.printf("controls", 0, 640, 640, "center")


    elseif gameState == 'storyMode' then

        love.graphics.draw(dragonStory01, 00, 0, 0, 0.5, 0.5)

        love.graphics.setColor(0, 0, 0)

        -- draw stage
        love.graphics.rectangle('line', 00, 00, 640, 640)

        -- the screen
        love.graphics.rectangle('line', 00, 00, 990, 720)

         -- menu area
         love.graphics.setColor(100, 100, 100)
         love.graphics.rectangle('line', 640, 00, 350, 80)
         love.graphics.printf("menu", 880, 0, 100, "center")
 
 
         -- Fairy area
         love.graphics.rectangle('line', 640, 80, 350, 520)
         love.graphics.draw(fairysprite, 640, 80, 0, 1, 1)
 
         love.graphics.rectangle('line', 640, 600, 350, 40)
         
 
         -- audio area    
         love.graphics.rectangle('line', 0, 640, 990, 80)
         love.graphics.setColor(100, 100, 100)
        --  love.graphics.printf("controls", 0, 640, 640, "center")


    elseif gameState == 'exerciseMode' then
        love.graphics.setColor(0, 0, 0)

        -- draw stage
        love.graphics.rectangle('fill', 00, 00, 640, 640)

        -- the screen
        love.graphics.rectangle('fill', 00, 00, 990, 720)


        -- the blocks and play area
        love.graphics.setColor(0.5, 0, 0)
        love.graphics.rectangle('fill', 80, 80, 480, 480)

        -- menu area
        love.graphics.setColor(100, 100, 100)
        love.graphics.rectangle('line', 640, 00, 350, 80)
        love.graphics.printf("menu", 880, 0, 100, "center")


        -- Fairy area
        love.graphics.rectangle('line', 640, 80, 350, 520)
        love.graphics.draw(fairysprite, 640, 80, 0, 1, 1)

        love.graphics.rectangle('line', 640, 600, 350, 40)
        love.graphics.printf(fairySpeech, 640, 600, 350, "center")

        -- audio area    
        love.graphics.rectangle('line', 0, 640, 990, 80)
        love.graphics.setColor(100, 100, 100)
        love.graphics.printf("audio / familiar", 0, 640, 640, "center")


        -- draw block

        -- love.graphics.setColor(0.2, 1, 0.8)
        -- love.graphics.rectangle('fill', 10, 10, 60, 60)
    
        love.graphics.setFont(largeFont)
      

        -- draw subject
        love.graphics.draw(cat, 200, 100, 0, 1, 1)
        love.graphics.setColor(0.8, 0.3, 0.3)
        love.graphics.rectangle('fill', target1.x, target1.y, 80, 80)
        love.graphics.rectangle('fill', target2.x, target2.y, 80, 80)
        love.graphics.rectangle('fill', target3.x, target3.y, 80, 80)
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle('line', target1.x, target1.y, 80, 80)
        love.graphics.rectangle('line', target2.x, target2.y, 80, 80)
        love.graphics.rectangle('line', target3.x, target3.y, 80, 80)

        local counter = 1

        -- draw blocks      
        for i, letter in pairs(letters) do

            -- love.graphics.setColor(0.1, 0.7, 0.6)

            if letter.char == "A" or letter.char == "E" or letter.char == "I" or letter.char == "M" or letter.char == "Q" or letter.char == "U" or letter.char == "Y" then
                love.graphics.setColor(0, 1, 0)
                love.graphics.rectangle('fill', letter.x, letter.y, 80, 80)
            end

            if letter.char == "B" or letter.char == "F" or letter.char == "J" or letter.char == "N" or letter.char == "R" or letter.char == "V" or letter.char == "Z" then
                love.graphics.setColor(0.9, 0.9, 0)
                love.graphics.rectangle('fill', letter.x, letter.y, 80, 80)
            end

            if letter.char == "C" or letter.char == "G" or letter.char == "K" or letter.char == "O" or letter.char == "S" or letter.char == "W" then
                love.graphics.setColor(1, 0, 0)
                love.graphics.rectangle('fill', letter.x, letter.y, 80, 80)
            end

            if letter.char == "D" or letter.char == "H" or letter.char == "L" or letter.char == "P" or letter.char == "T" or letter.char == "X" then
                love.graphics.setColor(0, 0, 1)
                love.graphics.rectangle('fill', letter.x, letter.y, 80, 80)
            end

            love.graphics.setColor(0, 0, 0)
            love.graphics.rectangle('line', letter.x, letter.y, 80, 80)
            
            love.graphics.setColor(1, 1, 1)
            love.graphics.printf(letter.char, letter.x, letter.y, 80, "center")
            -- love.graphics.draw(letter.image, letter.x, letter.y, 0, 1, 1)
        end    
    
        -- Block movement
        for i, letter in pairs(letters) do
            if letter.isSelected == true then
                if love.keyboard.isDown('w') then
                    letter.y = letter.y - 2
                elseif love.keyboard.isDown('s') then
                    letter.y = letter.y + 2
                elseif love.keyboard.isDown('a') then
                    letter.x = letter.x - 2
                elseif love.keyboard.isDown('d') then
                    letter.x = letter.x + 2
                end
            end
        end

    elseif gameState == 'victory' then

        local spriteNum = math.floor(animation.currentTime / animation.duration * #animation.quads) + 1
        love.graphics.draw(animation.spriteSheet, animation.quads[spriteNum])

    end



     -- for correct letter placement
    if letters.C.placed == false then
        if (letters.C.x == target1.x and letters.C.y == target1.y) then
            letters.C.placed = true
            fairysprite = fairysetplay003
            fairySpeech = "So gifted"
            letters.C.isSelected = false
        end
    end

    if letters.A.placed == false then
        if (letters.A.x == target2.x and letters.A.y == target2.y) then
            letters.A.placed = true
            fairysprite = fairysetplay003
            fairySpeech = "So gifted"
            letters.A.isSelected = false
        end
    end

    if letters.T.placed == false then
        if (letters.T.x == target3.x and letters.T.y == target3.y) then
            letters.T.placed = true
            fairysprite = fairysetplay003
            fairySpeech = "So gifted"
            letters.T.isSelected = false
        end
    end

    if (letters.C.placed == true and letters.A.placed == true and letters.T.placed == true) then
      
        fairySpeech = "Shazam!"
    end

    


end


function love.update(dt)
	local  	down = love.mouse.isDown(1)
	local 	mx = love.mouse.getX()
	local	my = love.mouse.getY()
    menu_mousehandling_freeplay(mx, my, down)
    menu_mousehandling_setplay(mx, my, down)
    collision = CheckCollision(ablockXfree, ablockYfree, bblockXfree, bblockYfree, cblockX, cblockY)
    print(collision)


    ----------------------- Freeplay Collision Detection-------------------------
 
    if love.keyboard.isDown('w') then
        for i, letter in pairs(letters) do
            for i, currentLetter in pairs(letters) do
                if letter ~= currentLetter then
                    if currentLetter.x < letter.x + 80 and letter.x < currentLetter.x + 80 and currentLetter.y < letter.y + 80 and letter.y < currentLetter.y + 80 then
                        currentLetter.y = currentLetter.y + 5 
                    end
                end
            end
        end  
    end

    if love.keyboard.isDown('s') then
        for i, letter in pairs(letters) do
            for i, currentLetter in pairs(letters) do
                if letter ~= currentLetter then
                    if currentLetter.x < letter.x + 80 and letter.x < currentLetter.x + 80 and currentLetter.y < letter.y + 80 and letter.y < currentLetter.y + 80 then
                        currentLetter.y = currentLetter.y - 5 
                    end
                end
            end
        end  
    end

    if love.keyboard.isDown('a') then
        for i, letter in pairs(letters) do
            for i, currentLetter in pairs(letters) do
                if letter ~= currentLetter then
                    if currentLetter.x < letter.x + 80 and letter.x < currentLetter.x + 80 and currentLetter.y < letter.y + 80 and letter.y < currentLetter.y + 80 then
                        currentLetter.x = currentLetter.x + 5 
                    end
                end
            end
        end  
    end

    if love.keyboard.isDown('d') then
        for i, letter in pairs(letters) do
            for i, currentLetter in pairs(letters) do
                if letter ~= currentLetter then
                    if currentLetter.x < letter.x + 80 and letter.x < currentLetter.x + 80 and currentLetter.y < letter.y + 80 and letter.y < currentLetter.y + 80 then
                        currentLetter.x = currentLetter.x - 5 
                    end
                end
            end
        end  
    end



    -- animation
    animation.currentTime = animation.currentTime + dt
    if animation.currentTime >= animation.duration then
        animation.currentTime = animation.currentTime - animation.duration
    end

    if (letters.C.placed == true and down == true) then
        fairysprite = fairysetplay001
    end
end




-- mouse
function menu_mousehandling_setplay(mx, my, down)
    for i, letter in pairs(letters) do
        if mx > letter.x and mx < letter.x + 80 and my > letter.y and my < letter.y + 80 then
            letter.hover=true
            if down == true then letter.isSelected = true
                fairysprite = fairysetplay002
                fairySpeech = "Go on then"
                woodblock:play()
        end
        else
            letter.hover=false
            if down == true then letter.isSelected = false end
        end
    end

    -- audio
    if mx > 600 and mx < 950 and my > 600 and my < 700 and down == true then
        sound:play()
    end
end



-- Animation

function newAnimation(image, width, height, duration)
    local animation = {}
    animation.spriteSheet = image;
    animation.quads = {};

    for y = 0, image:getHeight() - height, height do
        for x = 0, image:getWidth() - width, width do
            table.insert(animation.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
        end
    end

    animation.duration = duration or 1
    animation.currentTime = 0
    return animation
end


-- free play mode

function menu_mousehandling_freeplay(mx, my, down)

    -- Selecting
    
        -- A block
        if mx > ablockXfree and mx < ablockXfree + 100 and my > ablockYfree and my < ablockYfree + 100 then
            aBlock_freeplay.hover=true
            if down == true then aBlock_freeplay.call() end
        else
            aBlock_freeplay.hover=false
            if down == true then isASelected_freeplay = false end
        end
    
         -- B block
        if mx > bblockXfree and mx < bblockXfree + 100 and my > bblockYfree and my < bblockYfree + 100 then
            bBlock_freeplay.hover=true
            if down == true then bBlock_freeplay.call() end
        else
            bBlock_freeplay.hover=false
            if down == true then isBSelected_freeplay = false end
        end
    end


function selectBlockAFreePlay()
    isASelected_freeplay = true      function newAnimation(image, width, height, duration)
        local animation = {}
        animation.spriteSheet = image;
        return animation
    end
end

function selectBlockBFreePlay()
    isBSelected_freeplay = true
end


-- Free Play Collision detection function;
-- Returns true if two boxes overlap, false if they don't;
-- x1,y1 are the top-left coords of the first box, while w1,h1 are its width and height;
-- x2,y2,w2 & h2 are the same, but for the second box.
function CheckCollision(ablockX, ablockY, bblockX, bblockY)
    return  ablockX < bblockX+100 and
            bblockX < ablockX+100 and
            ablockY < bblockY+100 and
            bblockY < ablockY+100
end




