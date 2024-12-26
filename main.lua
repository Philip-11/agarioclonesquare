if arg[2] == "debug" then
    require("lldebugger").start()
end


function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")

    math.randomseed(os.time())
    math.random(); math.random(); math.random()
    
    ScreenWidth, ScreenHeight = love.window.getMode()
    
    Player = {
        x = 30,
        y = 30,
        width = 50,
        height = 50,
        speed = 300,
        score = 0,
    }
    
    

    Items = {}
    
    for i=1, 30 do
        local item = {
            width = 30,
            height = 30,
            x = math.random(1, ScreenWidth),
            y = math.random(1, ScreenHeight),
        }

        table.insert(Items, item)
    end
    

end 


function love.update(dt)
    if love.keyboard.isDown("d") then Player.x = Player.x + Player.speed * dt end
    if love.keyboard.isDown("a") then Player.x = Player.x - Player.speed * dt end
    if love.keyboard.isDown("w") then Player.y = Player.y - Player.speed * dt end
    if love.keyboard.isDown("s") then Player.y = Player.y + Player.speed * dt end

    Mode = "fill"
    for i, item in ipairs(Items) do
        if CheckCollision(item, Player) then
            table.remove(Items, i)
            Player.score = Player.score + 1
            Player.width = Player.width + 10
            Player.height = Player.height + 10
        else 
            
            Mode = "line"
        end
    end  
end 


function love.draw()
    if #Items == 0 then
        love.graphics.print("YOUUUU WINNNN", 50, 50)
    end
    
    love.graphics.print("Score is " .. Player.score, 30, 30)
    love.graphics.rectangle(Mode, Player.x, Player.y, Player.width, Player.height)
    
    for i, v in ipairs(Items) do
        love.graphics.rectangle("line", v.x, v.y, v.width, v.height)    
    end
    
end


function CheckCollision(a, b)
    local a_left = a.x
    local a_right = a.x + a.width
    local a_top = a.y
    local a_bottom = a.y + a.height

    local b_left = b.x
    local b_right = b.x + b.width
    local b_top = b.y
    local b_bottom = b.y + b.height

    return a_right > b_left 
    and a_left < b_right
    and a_bottom > b_top
    and a_top < b_bottom

end











local love_errorhandler = love.errorhandler

function love.errorhandler(msg)
---@diagnostic disable-next-line: undefined-global
    if lldebugger then
        error(msg, 2)
    else
        return love_errorhandler(msg)
    end
end