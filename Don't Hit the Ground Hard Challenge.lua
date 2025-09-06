--[[ Don't Hit the Ground Hard Challenge minigame developed by Kralizmox#0000 ]]--
--[[ Made in 22.06.2025 ]]--
--[[ Last updated in 06.09.2025 ]]--

-- Admins and funcorps commands
-- !ban [name] [banReasonText] -> Bans the player from the room for using hackers or x bug
-- !playersize [sizeValue] -> Changes the player size
-- !immortality true -> Enables the immortality mode
-- !immortaliy false -> Disables the immortality mode 
-- !fly true -> Enables the free fly mode
-- !fly false -> Disables the free fly mode

tfm.exec.disableAutoShaman()
tfm.exec.disableAutoNewGame()
tfm.exec.disableAutoTimeLeft()
tfm.exec.disableAfkDeath()
tfm.exec.disableDebugCommand()
tfm.exec.disablePhysicalConsumables()

local admins = {["Kralizmox#0000"] = true}
local funcorps = {["Kornelkafb#0000"] = true, ["Jestem_ona#7797"] = true}
local cloudPositionsX, cloudPositionsY = {}, {}
local starPositionsY = {}
local asteroidPositionsX, asteroidPositions1Y, asteroidPositions2Y = {}, {}, {}
local args, name, reasonText

for i = 1, 30 do
    cloudPositionsX[i] = math.random(-500, 800)
end

--for i = 65, 425 do
    --asteroidPositionsX[i] = math.random(-400, 1100)
--end

local highestFlyPower, highestFlyPowerName = 100, "None"
local isPlayerWon, winnerName = false, "None"
local waitNewGameTimer, newGameIsStarted = 3.5, false
local args, name, reasonText

local defaultPlayerData = {
    flyPower = -100,
    sensibility = 1,
    touchedGround = true,
    freezeTimer = 0.5,
    flyTimer = 1,
    canFly = true,
    pressedSpacebar = false,
    pressedUp = false,
    isWon = false,
    successJumps = 0,
    failedJumps = 0,
    playerSize = 1,
    totalWins = 0,
    enabledFlyMode = false,
    enabledImmortalityMode = false,
    isBanned = false
}

local players = {}
local map = '<C><P H="60000" DS="y;59945" MEDATA=";;;;-0;0:::1-"/><Z><S><S T="6" X="400" Y="60460" L="3000" H="1000" P="0,0,0.3,0.2,0,0,0,0" c="4"/></S><D><P X="1200" Y="59970" T="139" P="0,0"/><P X="1100" Y="59970" T="139" P="0,0"/><P X="1000" Y="59970" T="139" P="0,0"/><P X="900" Y="59970" T="139" P="0,0"/><P X="799" Y="59970" T="139" P="0,0"/><P X="700" Y="59970" T="139" P="0,0"/><P X="600" Y="59970" T="139" P="0,0"/><P X="500" Y="59970" T="139" P="0,0"/><P X="400" Y="59970" T="139" P="0,0"/><P X="300" Y="59970" T="139" P="0,0"/><P X="200" Y="59970" T="139" P="0,0"/><P X="100" Y="59970" T="139" P="0,0"/><P X="0" Y="59970" T="139" P="0,0"/><P X="-100" Y="59970" T="139" P="0,0"/><P X="-200" Y="59970" T="139" P="0,0"/><P X="-300" Y="59970" T="139" P="0,0"/><P X="-400" Y="59970" T="139" P="0,0"/><F X="20" Y="20"/><F X="60" Y="20"/><F X="-380" Y="20"/><F X="100" Y="20"/><F X="-340" Y="20"/><F X="140" Y="20"/><F X="-300" Y="20"/><F X="180" Y="20"/><F X="-260" Y="20"/><F X="220" Y="20"/><F X="-220" Y="20"/><F X="260" Y="20"/><F X="-180" Y="20"/><F X="300" Y="20"/><F X="-140" Y="20"/><F X="340" Y="20"/><F X="-100" Y="20"/><F X="380" Y="20"/><F X="-60" Y="20"/><F X="420" Y="20"/><F X="-20" Y="20"/><F X="460" Y="20"/><F X="500" Y="20"/><F X="820" Y="20"/><F X="540" Y="20"/><F X="860" Y="20"/><F X="580" Y="20"/><F X="900" Y="20"/><F X="620" Y="20"/><F X="940" Y="20"/><F X="660" Y="20"/><F X="980" Y="20"/><F X="700" Y="20"/><F X="1020" Y="20"/><F X="740" Y="20"/><F X="1060" Y="20"/><F X="1140" Y="20"/><F X="780" Y="20"/><F X="1100" Y="20"/><F X="1180" Y="20"/></D><O/><L/></Z></C>'

tfm.exec.newGame(map)
tfm.exec.setRoomMaxPlayers(100)

function specialNicknameColor(name)
    if players[name].isWon == false then
        if admins[name] == true then
            tfm.exec.setNameColor(name, 0x00AAFF)
        end
        if funcorps[name] == true then
            tfm.exec.setNameColor(name, 0xFF8547)
        end
    end
end

function eventNewPlayer(name)
    cloudPositionsY[name] = 59600
    starPositionsY[name] = 52000
    asteroidPositions1Y[name], asteroidPositions2Y[name] = 45800, 10500
    if players[name] == nil then
        players[name] = {
            flyPower = defaultPlayerData.flyPower,
            sensibility = defaultPlayerData.sensibility,
            touchedGround = defaultPlayerData.touchedGround,
            freezeTimer = defaultPlayerData.freezeTimer,
            flyTimer = defaultPlayerData.flyTimer,
            canFly = defaultPlayerData.canFly,
            pressedSpacebar = defaultPlayerData.pressedSpacebar,
            pressedUp = defaultPlayerData.pressedUp,
            isWon = defaultPlayerData.isWon,
            successJumps = defaultPlayerData.successJumps,
            failedJumps = defaultPlayerData.failedJumps,
            playerSize = defaultPlayerData.playerSize,
            totalWins = defaultPlayerData.totalWins,
            enabledFlyMode = defaultPlayerData.enabledFlyMode,
            enabledImmortalityMode = defaultPlayerData.enabledImmortalityMode,
            isBanned = defaultPlayerData.isBanned
        }
    end
    if players[name].isBanned == false then
        tfm.exec.respawnPlayer(name)
    elseif players[name].isBanned == true then
        ui.addTextArea(7, "", name, -400, -150, 1600, 900, 0x000001, 0, 1, true)
        ui.addTextArea(10, "<p align='center'><font size='20' color='#CB546B'>You are banned!\nReason: " .. reasonText .. "</font></p>", name, 0, 180, 800, 60, 0x000001, 0, 1, true)
    end
    tfm.exec.setGameTime(9999999)
    tfm.exec.chatMessage("<font color='#2ECF73'>Welcome to Don\'t Hit the Ground Hard Challenge minigame. The goal is do not fall hard from height and reach the cheese planet!</font>\n<font color='#EDCC8D'>Every success jumps, you will gain +20 fly power and +0.02 \"aie\" sensibility.</font>\n<font color='#BABD2F'>Every time you win, you will gain +0.2 mouse size!</font>\n<font color='#FF8547'>This minigame was made by: Kralizmox#0000.</font>\n<font size='14' color='#CB546B'>• Warning: Don\'t use any hacks and x bug. You will get permanently banned from the room!</font>", name)
    tfm.exec.setAieMode(true, players[name].sensibility, name)
    tfm.exec.setPlayerScore(name, math.abs(players[name].flyPower))
    tfm.exec.addPhysicObject(1, 400, 60460, {type = 14, width = 3000, height = 1000, friction = 0.3, restitution = 0.2, contactListener = true})
    tfm.exec.addPhysicObject(2, 400, 70460, {type = 14, width = 3000, height = 1000, friction = 0.3, restitution = 0.2, contactListener = true})
    specialNicknameColor(name)
    if players[name].isWon == true then
        tfm.exec.setNameColor(name, 0xFFFF00)
    end
    tfm.exec.playMusic("cite18/musique/museum.mp3", "music", 100, true, true, name)
    tfm.exec.addImage("18756e48371.png", "?1", -1500, 52000, name, 8, 12.26) -- Sky
    tfm.exec.addImage("18773217882.png", "?2", -600, 59650, name, 1, 0.5) -- Mountain
    -- Clouds
    for i = 1, 30 do
        tfm.exec.addImage("181ba85ccc2.png", "!" .. i, cloudPositionsX[i], cloudPositionsY[name], name) -- Cloud
        cloudPositionsY[name] = cloudPositionsY[name] - 200
    end
    -- Stars
    for i = 3, 56 do
        tfm.exec.addImage("181b9de5c95.png", "?" .. i, -700, starPositionsY[name], name) -- Star
        starPositionsY[name] = starPositionsY[name] - 1000
    end
    tfm.exec.addImage("1883b125925.png", "?57", 350, 50000, name, 0.5, 0.5) -- Moon
    tfm.exec.addImage("1883b11fa05.png", "?58", 340, 46000, name, 0.5, 0.5) -- Mars
    tfm.exec.addImage("197a27e2eb0.png", "?59", 300, 41000, name, 0.9, 0.9) -- Jupiter
    tfm.exec.addImage("1883b133513.png", "?60", 160, 35000, name, 0.7, 0.7) -- Saturn
    tfm.exec.addImage("197a22ac189.png", "?61", 303, 28000, name, 0.3, 0.3) -- Uranus
    tfm.exec.addImage("1883b12d793.png", "?62", 325, 20000, name, 0.5, 0.5) -- Neptune
    tfm.exec.addImage("18f7d33850e.png", "?63", 345, 11000, name, 0.6, 0.6) -- Pluto
    tfm.exec.addImage("197a27eba25.png", "?64", 310, 120, name, 0.5, 0.5) -- Cheese planet
    -- Asteroids 1
    --[[for i = 65, 175 do
        tfm.exec.addImage("1990f734e31.png", "?" .. i, asteroidPositionsX[i], asteroidPositions1Y[name], name, 0.3, 0.3) -- Asteroid
        asteroidPositions1Y[name] = asteroidPositions1Y[name] - 40
    end
    for i = 176, 425 do
        tfm.exec.addImage("1990f734e31.png", "?" .. i, asteroidPositionsX[i], asteroidPositions2Y[name], name, 0.3, 0.3) -- Asteroid
        asteroidPositions2Y[name] = asteroidPositions2Y[name] - 40
    end]]
    system.bindKeyboard(name, 1, true, true)
    system.bindKeyboard(name, 1, false, true)
    system.bindKeyboard(name, 32, true, true)
    system.bindKeyboard(name, 72, true, true)
    system.disableChatCommandDisplay(nil, true)
    ui.addTextArea(1, "<p align='right'><font size='16' color='#FFFFFF'>Fly Power: " .. math.abs(players[name].flyPower) .. " (Max 2000)\n\"Aie\" Sensibility: " .. players[name].sensibility .. " (Max 2)\nSuccess Jumps: " .. players[name].successJumps .. "\nFailed Jumps: " .. players[name].failedJumps .. "\nPlayer Size: " .. players[name].playerSize .. " (Max 5)\n<font color='#FFFF00'>Total Wins: " .. players[name].totalWins .. "</font></font></p>", name, 535, 280, 260, 120, 0x000000, 0, 1, true)
    ui.addTextArea(2, "<p align='center'><font size='20' color='#FFFFFF'>Press Spacebar to Fly!</font></p>", name, 275, 365, 250, 30, 0x000000, 0, 1, true)
    ui.addTextArea(3, "<p align='center'><font size='20' color='#FFFFFF'>Highest Fly Power " .. math.abs(highestFlyPower) .. " by " .. highestFlyPowerName .. "\n<font color='#FFFF00'>First Winner: " .. winnerName .. "</font></font></p>", nil, 0, 25, 800, 60, 0x000000, 0, 1, true)
    ui.addTextArea(4, "<p align='left'><font size='14' color='#FFFFFF'><a href='event:help'>Help</a></p>", nil, 5, 375, 35, 25, 0x000001, 0, 1, true)
    --ui.addTextArea(4, "<p align='left'><font size='14' color='#FFFFFF'><a href='event:help'>Help</a> | <a href='event:changelog'>Changelog</a></font></p>", nil, 5, 375, 125, 25, 0x000001, 0, 1, true)
    ui.addTextArea(11, "", name, -1500, -3160, 3000, 3000, 0x000001, 0, 1, true)
    ui.addTextArea(12, "", name, -1500, 760, 3000, 3000, 0x000001, 0, 1, true)
    ui.setMapName("This minigame was made by <font color='#00AAFF'>Kralizmox#0000</font>")
    ui.setBackgroundColor("#000000")
end

for name in next, tfm.get.room.playerList do
    eventNewPlayer(name)
end

function eventChatCommand(name, cmd)
    -- Player commands
    if cmd == "help" then
        ui.addTextArea(5, "<p align='center'><font size='20' color='#FFFFFF'>How to Play?</font></p>\n<font size='14' color='#2ECF73'>• Welcome to Don't Hit the Ground Hard Challenge minigame. The goal is do not fall hard from height and reach the cheese planet!</font>\n<font size='14' color='#EDCC8D'>• Every success jumps, you will gain +20 fly power and +0.02 \"aie\" sensibility.</font>\n<font size='14' color='#BABD2F'>• Every time you win, you will gain +0.2 mouse size!</font>\n<font size='14' color='#CB546B'>• Warning: Don\'t use any hacks and x bug. You will get permanently banned from the room!</font>", name, 200, 115, 400, 180, 0x5A3C19, 0, 1, true)
        ui.addTextArea(6, "<font size='20' color='#FF0000'><a href='event:closeHelpButton'>X</a></font>", name, 580, 115, 25, 25, 0x000000, 0, 1, true)
    end
    -- Admin commands
    if admins[name] == true or funcorps[name] == true then
        if cmd:sub(1, 4) == "ban " then
            args = cmd:sub(5)
            name, reasonText = string.match(args, "^(%S+)%s+(.+)$")
            if name and reasonText then
                players[name].isBanned = true
                tfm.exec.killPlayer(name)
                tfm.exec.chatMessage("<font color='#CB546B'>" .. name .. " banned from the room. Reason: " .. reasonText .. "</font>", name)
                ui.addTextArea(7, "", name, -400, -150, 1600, 900, 0x000001, 0, 1, true)
                ui.addTextArea(1, "<p align='right'><font size='16' color='#FFFFFF'>Fly Power: " .. math.abs(players[name].flyPower) .. " (Max 2000)\n\"Aie\" Sensibility: " .. players[name].sensibility .. " (Max 2)\nSuccess Jumps: " .. players[name].successJumps .. "\nFailed Jumps: " .. players[name].failedJumps .. "\nPlayer Size: " .. players[name].playerSize .. " (Max 5)\n<font color='#FFFF00'>Total Wins: " .. players[name].totalWins .. "</font></font></p>", name, 535, 280, 260, 120, 0x000000, 0, 1, true)
                ui.addTextArea(2, "<p align='center'><font size='20' color='#FFFFFF'>Press Spacebar to Fly!</font></p>", name, 275, 365, 250, 30, 0x000000, 0, 1, true)
                ui.addTextArea(3, "<p align='center'><font size='20' color='#FFFFFF'>Highest Fly Power " .. math.abs(highestFlyPower) .. " by " .. highestFlyPowerName .. "\n<font color='#FFFF00'>First Winner: " .. winnerName .. "</font></font></p>", nil, 0, 25, 800, 60, 0x000000, 0, 1, true)
                ui.addTextArea(4, "<p align='left'><font size='14' color='#FFFFFF'><a href='event:help'>Help</a></p>", nil, 5, 375, 35, 25, 0x000001, 0, 1, true)
                ui.addTextArea(10, "<p align='center'><font size='20' color='#CB546B'>You are banned from the room!\nReason: " .. reasonText .. "</font></p>", name, 0, 180, 800, 60, 0x000001, 0, 1, true)
            end
        end
        if cmd == "unban " .. name then
            players[name].isBanned = false
            tfm.exec.respawnPlayer(name)
            tfm.exec.chatMessage("<font color='#6C77C1'>" .. name .. " has been unbanned.</font>", name)
            ui.removeTextArea(7, name)
            ui.removeTextArea(10, name)
        end
        if cmd:sub(1, 10) == "playersize" then
            local playerSizeValue = tonumber(cmd:sub(12))
            tfm.exec.changePlayerSize(name, playerSizeValue)
        end
        if cmd == "immortality true" then
            tfm.exec.setAieMode(false, players[name].sensibility, name)
            players[name].enabledImmortalityMode = true
        end
        if cmd == "immortality false" then
            tfm.exec.setAieMode(true, players[name].sensibility, name)
            players[name].enabledImmortalityMode = false
        end
        if cmd == "fly true" then
            players[name].enabledFlyMode = true
        end
        if cmd == "fly false" then
            players[name].enabledFlyMode = false
        end
    end
end

function eventPlayerDied(name)
    if players[name].isBanned == false then
        tfm.exec.respawnPlayer(name)
    end
    specialNicknameColor(name)
    tfm.exec.playSound("transformice/son/bulle1.mp3", 100, nil, nil, name)
    system.bindKeyboard(name, 32, true, true)
    players[name].flyTimer = 1
    players[name].canFly = false
    if players[name].pressedSpacebar == true then
        players[name].failedJumps = players[name].failedJumps + 1
        ui.addTextArea(1, "<p align='right'><font size='16' color='#FFFFFF'>Fly Power: " .. math.abs(players[name].flyPower) .. " (Max 2000)\n\"Aie\" Sensibility: " .. players[name].sensibility .. " (Max 2)\nSuccess Jumps: " .. players[name].successJumps .. "\nFailed Jumps: " .. players[name].failedJumps .. "\nPlayer Size: " .. players[name].playerSize .. " (Max 5)\n<font color='#FFFF00'>Total Wins: " .. players[name].totalWins .. "</font></font></p>", name, 535, 280, 260, 120, 0x000000, 0, 1, true)
    end
    players[name].pressedSpacebar = false
    players[name].pressedUp = false
    if players[name].isWon == true then
        tfm.exec.setNameColor(name, 0xFFFF00)
    end
end

function eventTextAreaCallback(id, name, event)
    if event == "help" then
        ui.removeTextArea(8, name)
        ui.removeTextArea(9, name)
        ui.addTextArea(5, "<p align='center'><font size='20' color='#FFFFFF'>How to Play?</font></p>\n<font size='14' color='#2ECF73'>• Welcome to Don't Hit the Ground Hard Challenge minigame. The goal is do not fall hard from height and reach the cheese planet!</font>\n<font size='14' color='#EDCC8D'>• Every success jumps, you will gain +20 fly power and +0.02 \"aie\" sensibility.</font>\n<font size='14' color='#BABD2F'>• Every time you win, you will gain +0.2 mouse size!</font>\n<font size='14' color='#CB546B'>• Warning: Don\'t use any hacks and x bug. You will get permanently banned from the room!</font>", name, 200, 115, 400, 180, 0x5A3C19, 0, 1, true)
        ui.addTextArea(6, "<font size='20' color='#FF0000'><a href='event:closeHelpButton'>X</a></font>", name, 580, 115, 25, 25, 0x000000, 0, 1, true)
    end
    if event == "closeHelpButton" then
        ui.removeTextArea(5, name)
        ui.removeTextArea(6, name)
    end
    if event == "changelog" then
        ui.removeTextArea(5, name)
        ui.removeTextArea(6, name)
        ui.addTextArea(8, "<p align='center'><font size='20' color='#FFFFFF'>Changelog (V1.0.0)</font></p>\n<font size='16' color='#2ECF73'>Update (02/09/2025)</font>\n<font size='14' color='#FFFFFF'>• Added Help UI and Changelog UI</font>\n<font size='16' color='#2ECF73'>Update (29/08/2025)</font>\n<font size='14' color='#FFFFFF'>• Semi-Official</font>", name, 200, 125, 400, 150, 0x5A3C19, 0, 1, true)
        ui.addTextArea(9, "<font size='20' color='#FF0000'><a href='event:closeChangelogButton'>X</a></font>", name, 580, 125, 25, 25, 0x000000, 0, 1, true)
    end
    if event == "closeChangelogButton" then
        ui.removeTextArea(8, name)
        ui.removeTextArea(9, name)
    end
end

function eventContactListener(name, id, info)
    if id == 1 or id == 2 then
        players[name].touchedGround = true
    end
end

function eventKeyboard(name, key, down, x, y)
    if players[name].enabledFlyMode == false then
        if key == 1 and down == true then
            ui.addTextArea(2, "<p align='center'><font size='20' color='#CB546B'>Press Spacebar to Fly!</font></p>" , name, 275, 365, 250, 30, 0x000000, 0, 1, true)
            players[name].touchedGround = false
            players[name].pressedUp = true
        end
        if key == 1 and down == false then
            players[name].pressedUp = false
        end
    end
    if players[name].touchedGround == true and newGameIsStarted == true then
        if key == 32 and tfm.get.room.playerList[name].isJumping == false and players[name].canFly == true then
            if players[name].enabledFlyMode == false and players[name].enabledImmortalityMode == false then
                tfm.exec.freezePlayer(name, true)
                tfm.exec.movePlayer(name, 0, 0, false, 0, players[name].flyPower, false)
                tfm.exec.playSound("transformice/son/dash.mp3", 100, nil, nil, name)
                tfm.exec.playSound("transformice/son/gel.mp3", 20, nil, nil, name)
                system.bindKeyboard(name, 32, true, false)
                ui.addTextArea(2, "<p align='center'><font size='20' color='#CB546B'>Press Spacebar to Fly!</font></p>", name, 275, 365, 250, 30, 0x000000, 0, 1, true)
                players[name].touchedGround = false
                players[name].freezeTimer = 0.5
                players[name].flyTimer = 1
                players[name].pressedSpacebar = true
            end
        end
    end
    -- When fly mode command is enabled
    if players[name].enabledFlyMode == true then
        if key == 32 then
            tfm.exec.movePlayer(name, 0, 0, false, 0, -100, true)
        end
    end
    if key == 72 then
        ui.addTextArea(5, "<p align='center'><font size='20' color='#FFFFFF'>How to Play?</font></p>\n<font size='14' color='#2ECF73'>• Welcome to Don't Hit the Ground Hard Challenge minigame. The goal is do not fall hard from height and reach the cheese planet!</font>\n<font size='14' color='#EDCC8D'>• Every success jumps, you will gain +20 fly power and +0.02 \"aie\" sensibility.</font>\n<font size='14' color='#BABD2F'>• Every time you win, you will gain +0.2 mouse size!</font>\n<font size='14' color='#CB546B'>• Warning: Don\'t use any hacks and x bug. You will get permanently banned from the room!</font>", name, 200, 115, 400, 180, 0x5A3C19, 0, 1, true)
        ui.addTextArea(6, "<font size='20' color='#FF0000'><a href='event:closeHelpButton'>X</a></font>", name, 580, 115, 25, 25, 0x000000, 0, 1, true)
    end
end

function eventPlayerWon(name)
    tfm.exec.respawnPlayer(name)
    tfm.exec.setPlayerScore(name, math.abs(players[name].flyPower))
    tfm.exec.setNameColor(name, 0xFFFF00)
    tfm.exec.chatMessage("<font color='#BABD2F'>" .. name .. " has finished the game. Congrats!</font>", nil)
    if isPlayerWon == false then
        winnerName = name
    end
    isPlayerWon = true
    system.bindKeyboard(name, 32, true, true)
    ui.addTextArea(3, "<p align='center'><font size='20' color='#FFFFFF'>Highest Fly Power " .. math.abs(highestFlyPower) .. " by " .. highestFlyPowerName .. "\n<font color='#FFFF00'>First Winner: " .. winnerName .. "</font></font></p>", nil, 0, 25, 800, 60, 0x000000, 0, 1, true)
    players[name].flyTimer = 1
    players[name].canFly = false
    players[name].isWon = true
end

function eventLoop()
    -- Wait new game timer system
    if waitNewGameTimer > 0 then
        waitNewGameTimer = waitNewGameTimer - 0.5 
    elseif waitNewGameTimer == 0 then
        newGameIsStarted = true
        waitNewGameTimer = -1
    end
    for name in next, tfm.get.room.playerList do
        if players[name].touchedGround == false and players[name].pressedSpacebar == true then
            -- Remove freeze timer system
            if players[name].freezeTimer > 0 then
                players[name].freezeTimer = players[name].freezeTimer - 0.5
            elseif players[name].freezeTimer == 0 then
                tfm.exec.freezePlayer(name, false)
                players[name].freezeTimer = -1
            end
        end
        if players[name].touchedGround == true then
            -- Change text color
            if players[name].pressedUp == true then
                ui.addTextArea(2, "<p align='center'><font size='20' color='#CB546B'>Press Spacebar to Fly!</font></p>" , name, 275, 365, 250, 30, 0x000000, 0, 1, true)
            elseif players[name].pressedUp == false then
                ui.addTextArea(2, "<p align='center'><font size='20' color='#FFFFFF'>Press Spacebar to Fly!</font></p>" , name, 275, 365, 250, 30, 0x000000, 0, 1, true)
            end
            -- Fly timer system
            if players[name].flyTimer > 0 then
                players[name].flyTimer = players[name].flyTimer - 0.5
            elseif players[name].flyTimer == 0 then
                players[name].canFly = true
                if players[name].pressedSpacebar == true then
                    players[name].successJumps = players[name].successJumps + 1
                    if players[name].flyPower > -2000 then
                        players[name].flyPower = players[name].flyPower - 20
                        system.bindKeyboard(name, 32, true, true)
                        if players[name].sensibility < 2 then
                            players[name].sensibility = players[name].sensibility + 0.02
                        elseif players[name].sensibility == 2 then
                            players[name].sensibility = 2
                        end
                        tfm.exec.setPlayerScore(name, math.abs(players[name].flyPower))
                        tfm.exec.setAieMode(true, players[name].sensibility, name)
                        ui.addTextArea(1, "<p align='right'><font size='16' color='#FFFFFF'>Fly Power: " .. math.abs(players[name].flyPower) .. " (Max 2000)\n\"Aie\" Sensibility: " .. players[name].sensibility .. " (Max 2)\nSuccess Jumps: " .. players[name].successJumps .. "\nFailed Jumps: " .. players[name].failedJumps .. "\nPlayer Size: " .. players[name].playerSize .. " (Max 5)\n<font color='#FFFF00'>Total Wins: " .. players[name].totalWins .. "</font></font></p>", name, 535, 280, 260, 120, 0x000000, 0, 1, true)
                        if math.abs(players[name].flyPower) > highestFlyPower then
                            highestFlyPower = highestFlyPower + 20
                            highestFlyPowerName = name
                            ui.addTextArea(3, "<p align='center'><font size='20' color='#FFFFFF'>Highest Fly Power " .. math.abs(highestFlyPower) .. " by " .. highestFlyPowerName .. "\n<font color='#FFFF00'>First Winner: " .. winnerName .. "</font></font></p>", nil, 0, 25, 800, 60, 0x000000, 0, 1, true)
                        end
                    end
                end
                ui.addTextArea(2, "<p align='center'><font size='20' color='#FFFFFF'>Press Spacebar to Fly!</font></p>" , name, 0, 365, 800, 30, 0x000000, 0, 1, true)
                if tfm.get.room.playerList[name].hasCheese == true then
                    if players[name].enabledFlyMode == false and players[name].enabledImmortalityMode == false then
                        if players[name].flyPower >= -2000 then
                            tfm.exec.playerVictory(name)
                            players[name].totalWins = players[name].totalWins + 1
                            if players[name].playerSize < 5 then
                                players[name].playerSize = players[name].playerSize + 0.2
                                tfm.exec.changePlayerSize(name, players[name].playerSize)
                            end
                            ui.addTextArea(1, "<p align='right'><font size='16' color='#FFFFFF'>Fly Power: " .. math.abs(players[name].flyPower) .. " (Max 2000)\n\"Aie\" Sensibility: " .. players[name].sensibility .. " (Max 2)\nSuccess Jumps: " .. players[name].successJumps .. "\nFailed Jumps: " .. players[name].failedJumps .. "\nPlayer Size: " .. players[name].playerSize .. " (Max 5)\n<font color='#FFFF00'>Total Wins: " .. players[name].totalWins .. "</font></font></p>", name, 535, 280, 260, 120, 0x000000, 0, 1, true)
                        end
                    end
                end
                players[name].pressedSpacebar = false
                players[name].flyTimer = -1
            end
        end
    end
end
