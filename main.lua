
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

    print("Start dungeon generation...")
    for i=1, dungeon.nbLine, 1 do
        dungeon.map[i] = {}
        for j=1, dungeon.nbColumn, 1 do
            dungeon.map[i][j] = roomCreator(i,j)
        end
    end    

    -- where the dungeon start
    startLine = math.random( 1, dungeon.nbLine)
    startColumn = math.random(1, dungeon.nbColumn)
    startRoom = dungeon.map[startLine][startColumn]
    startRoom.isOpen = true
    startRoom.isStart = true
    -- add the first room in the list of rooms available
    table.insert( rooms, startRoom )

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
        end
    end
    love.graphics.setColor(255,255,255)
end