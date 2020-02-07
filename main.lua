local dungeon = {}
dungeon.width = 35
dungeon.height = 15
dungeon.nbColumn = 9
dungeon.nbLine = 6
dungeon.map = {}

function roomCreator(pLine, pColumn)
    local newRoom = {}

    newRoom.line = pLine
    newRoom.column = pColumn
    newRoom.isOpen = false
    newRoom.upDoor = false
    newRoom.rightDoor = false
    newRoom.bottomDoor = false
    newRoom.leftDoor = false
    newRoom.isStart = false

    return newRoom
end

function dungeonGenerator()
    local rooms = {}
    local nbRooms = 20
    local startLine, startColumn
    local startRoom = {}    
    local currentRoom = {}    
    local direction = ""

    print("Start dungeon generation...")
    for i=1, dungeon.nbLine, 1 do
        dungeon.map[i] = {}
        for j=1, dungeon.nbColumn, 1 do
            dungeon.map[i][j] = roomCreator(i,j)
        end
    end    

    -- where the dungeon start
    startLine = love.math.random(1, dungeon.nbLine)
    startColumn = love.math.random(1, dungeon.nbColumn)
    startRoom = dungeon.map[startLine][startColumn]
    startRoom.isOpen = true
    startRoom.isStart = true
    -- add the first room in the list of rooms available
    table.insert( rooms, startRoom )
    
    -- in which direction it is possible to go
    while #rooms < nbRooms do
        local nextDirection = {}
        local nextRoom = {}
        currentRoomIndex = love.math.random(1, #rooms)
        currentRoom = rooms[currentRoomIndex]

        if currentRoom.line > 1 then
            table.insert(nextDirection, "up")
        end
        if currentRoom.line < dungeon.nbLine then
            table.insert(nextDirection, "down")
        end
        if currentRoom.column > 1 then
            table.insert(nextDirection, "left")
        end
        if currentRoom.column < dungeon.nbColumn then
            table.insert(nextDirection, "right")
        end
        
        local genNumber = love.math.random(1, #nextDirection)
        direction = nextDirection[genNumber]   
        
        if direction == "up" then
            currentRoom.upDoor = true
            nextRoom = dungeon.map[currentRoom.line-1][currentRoom.column]
        elseif direction == "left" then
            currentRoom.leftDoor = true
            nextRoom = dungeon.map[currentRoom.line][currentRoom.column-1]
        elseif direction == "down" then
            currentRoom.bottomDoor = true
            nextRoom = dungeon.map[currentRoom.line+1][currentRoom.column]
        elseif direction == "right" then
            currentRoom.rightDoor = true
            nextRoom = dungeon.map[currentRoom.line][currentRoom.column+1]
        else
            print("FAIL !!!!!!")
            return 1;
        end

        if nextRoom.isOpen == false then
            nextRoom.isOpen = true 
            table.insert(rooms, nextRoom)
        end        
    end
end

function love.load()
    dungeonGenerator()
end

function love.update(dt)
end

function love.draw()
    for i=1, #dungeon.map, 1 do
        for j=1, #dungeon.map[i], 1 do
            if dungeon.map[i][j].isOpen == false then
                love.graphics.setColor(0.6,0.6,0.6)
            elseif dungeon.map[i][j].isStart == true then
                love.graphics.setColor(0,1,0)
            end
            love.graphics.rectangle("fill", dungeon.width * (j - 1) + (j * 5) , dungeon.height * (i - 1) + (i * 5), dungeon.width, dungeon.height)
            love.graphics.setColor(1,1,1)                  
        end
    end    
end