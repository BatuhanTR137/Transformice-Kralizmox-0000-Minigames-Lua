-- Transformice flappy bird minigame made by Kralizmox#0000 --
-- Made in 10 July 2024 --
-- Last update in 12 July 2024 --

tfm.exec.disableAutoShaman()
tfm.exec.disableAutoNewGame()
tfm.exec.disableAutoTimeLeft()
tfm.exec.disableAfkDeath()
tfm.exec.disablePhysicalConsumables()

local admins = {["Kralizmox#0000"] = true}
local playerAlive, playerScore, playerScoreText, playerScoreRecord, playerScoreTimer, highestPlayerScore, highestPlayerScoreName, playerAliveCount = {}, {}, {}, {}, 8, 0, "none", 0
local gameTime, gameRoundCount = 0, 0
local barrierSpawnTimer, barrierSpawnCount, barrierLevel, barrierColor, barrierYPosition, removeBarrierTimer = 3.5, 0, 280, "0x24D02A", 240, 10
local groundId, groundId2 = 0, 0
local difficultyBarWidth = 0

tfm.exec.newGame('<C><P G="0,0.0001" MEDATA=";;;;-0;0:::1-" /><Z><S><S P="0,0,0.3,0.2,0,0,0,0" H="20" L="800" m="" X="400" c="3" N="" Y="390" T="6" /><S P="0,0,0.3,0.2,0,0,0,0" H="3000" L="1500" o="a4d0e7" X="-750" c="4" N="" Y="200" T="12" /><S P="0,0,0.3,0.2,0,0,0,0" H="1300" L="800" o="a4d0e7" X="400" c="3" Y="-650" T="12" /><S P="0,0,0.3,0.2,0,0,0,0" H="1300" L="800" o="a4d0e7" X="400" c="3" Y="1050" T="12" /><S P="0,0,0.3,0.2,0,0,0,0" H="3000" L="1500" o="a4d0e7" X="1550" c="3" N="" Y="200" T="12" /></S><D><DS Y="200" X="150" /></D><O /><L /></Z></C>')
tfm.exec.setGameTime(9999999)
tfm.exec.setRoomMaxPlayers(49)

function eventNewGame()
   -- Game round counter --
   --gameRoundCount = gameRoundCount + 1
   --if gameRoundCount > 10 then
      --gameRoundCount = 1
      --for name in next, tfm.get.room.playerList do
         --playerScore[name] = 0
      --end
   --end
   tfm.exec.setAieMode(true, 0.0001, nil)
   --ui.setMapName("Flappy Bird <font color='#6C77C1'>| </font><font color='#C2C2DA'>Round:</font><font color='#98E2EB'> " .. gameRoundCount .. "/10</font>")
   ui.setMapName("Flappy Bird")
   for name in next, tfm.get.room.playerList do
      playerAlive[name], playerScore[name] = true, 0
      playerAliveCount = playerAliveCount + 1
      system.bindKeyboard(name, 32, true, true)
      system.bindKeyboard(name, 38, true, true)
      system.bindKeyboard(name, 87, true, true)
      tfm.exec.addImage("1909dfec50b.png", "?1", 0, 0, name, 1.5, 0.908) -- Background image
      tfm.exec.addImage("1909dfee6fe.png", "%" .. name, -30, -30, nil, 0.2, 0.2) -- Player image
      playerScoreText[name] = 0
      ui.addTextArea(2, "<p align='center'><font size='24' color='#FFFFFF'>" .. playerScoreText[name] .. "</font></p>", name, 0, 55, 800, 50, 0x000000, 0, 1, false)
      ui.addTextArea(4, "", nil, 200, 25, 400, 10, 0x808080, 0, 1, false)
      ui.addTextArea(6, "<font size='16' color='#FFFFFF'>Difficulty:</font>  <font size='16' color='#24D02A'>1</font><font color='#FFFFFF'>                    <font size='16' color='#FEFF00'>21</font>                    <font size='16' color='#FFA100'>41</font>                    <font size='16' color='#F20D0D'>61</font>               <font size='16' color='#731BE0'>+81</font>", nil, 110, 20, 500, 50, 0x000000, 0, 1, false)
      ui.addTextArea(7, "<p align='center'><font size='16' color='#FFFFFF'>Highest score " .. math.floor(highestPlayerScore) .. " record by " .. highestPlayerScoreName .. "</font></p>", nil, 0, 40, 800, 40, 0x000000, 0, 1, false)
      --ui.addTextArea(3, "<p align='center'><font size='20' color='#FFFFFF'>Highest score record " .. playerScoreRecord .. " by " .. name .. "</font></p>", nil, 0, 60, 800, 50, 0x000000, 0, 1, false)
      --ui.addTextArea(5, "", nil, 200, 20, 10, 10, 0x1AA0E4, 0, 1, false)
      --ui.addTextArea(6, "<font size='18' color='#FFFFFF'>| | | | | |</font>", name, 200, 10, 400, 40, 0x000000, 0, 1, false)
      --tfm.exec.setPlayerScore(name, playerScore[name])
      tfm.exec.setPlayerGravityScale(name, 240000)
      tfm.exec.freezePlayer(name, true, false)
   end
   ui.removeTextArea(1, nil)
end

function eventNewPlayer(name)
   ui.setMapName("Flappy Bird")
   playerScore[name], playerScoreRecord[name] = 0, -1
   tfm.exec.setPlayerScore(name, playerScore[name])
   tfm.exec.chatMessage("<font color='#BABD2F'>Welcome to Flappy Bird minigame, How to play: Press spacebar or w or arrow up key to fly bird.</font>\n<font color='#E68d43'>Minigame made by: Kralizmox#0000</font>", name)
   tfm.exec.addImage("1909dfec50b.png", "?1", 0, 0, name, 1.5, 0.908) -- Background image
   if admins[name] == true then
      tfm.exec.setNameColor(name, 0xEB1D51)
   end
end

for name in next, tfm.get.room.playerList do
   eventNewPlayer(name)
end

function eventKeyboard(name, key, down, x, y)
   if key == 32 or key == 38 or key == 87 then
      tfm.exec.movePlayer(name, 0, 0, false, 0, -100, false)
      tfm.exec.playSound("transformice/son/dash.mp3", 100, nil, nil, name)
   end
   if key == 76 then
      pressedLKeyCount[name] = true
      if pressedLKeyCount[name] == 1 then
         tfm.exec.addImage("", "!1", 0, 0, name, 1, 1) -- Leaderboard image
         ui.addTextArea(8, "<p align='center'><font size='16' color='#FFFFFF'></font></p>", nil, 0, 40, 800, 40, 0x000000, 0, 1, false)
      else
         pressedLKeyCount[name] = 0
         removeImage[name] = tfm.exec.removeImage()
         ui.removeTextArea(8, name)
      end
   end 
end

function checkDead()
   for name in next, tfm.get.room.playerList do
      if not tfm.get.room.playerList[name].isDead then
         return false
      end
   end
   return true
end

function eventPlayerDied(name)
   playerAlive[name] = false
   playerAliveCount = playerAliveCount - 1
   system.bindKeyboard(name, 32, true, false)
   system.bindKeyboard(name, 38, true, false)
   system.bindKeyboard(name, 87, true, false)
   -- If all players are died --
   if checkDead() then
      ui.addTextArea(1, "<p align='center'><font size='30' color='#FFFFFF'>GAME OVER!</font></p>", nil, 200, 200, 400, 100, 0x000000, 0, 1, false)
      gameTime = 5
      tfm.exec.setGameTime(5)
   end
end 

function eventLoop(a, b)
   -- Start new round --
   if b <= gameTime then
      tfm.exec.newGame('<C><P G="0,0.0001" MEDATA=";;;;-0;0:::1-"/><Z><S><S T="6" X="400" Y="390" L="800" H="20" P="0,0,0.3,0.2,0,0,0,0" c="3" N="" m=""/><S T="12" X="-750" Y="200" L="1500" H="3000" P="0,0,0.3,0.2,0,0,0,0" o="a4d0e7" c="4" N=""/><S T="12" X="400" Y="-650" L="800" H="1300" P="0,0,0.3,0.2,0,0,0,0" o="a4d0e7" c="3"/><S T="12" X="400" Y="1050" L="800" H="1300" P="0,0,0.3,0.2,0,0,0,0" o="a4d0e7" c="3"/><S T="12" X="1550" Y="200" L="1500" H="3000" P="0,0,0.3,0.2,0,0,0,0" o="a4d0e7" c="3" N=""/></S><D><DS X="150" Y="200"/></D><O/><L/></Z></C>')
      tfm.exec.setGameTime(9999999)
      playerScoreTimer, barrierSpawnTimer, barrierSpawnCount, barrierLevel, barrierColor, barrierYPosition, removeBarrierTimer = 8, 3.5, 0, 280, "0x24D02A", 240, 10
      difficultyBarWidth = 0
   end
   -- Add player score every 2 seconds --
   playerScoreTimer = playerScoreTimer - 0.5
   if playerScoreTimer == 0 then
      for name in next, tfm.get.room.playerList do
         if playerAlive[name] == true then
            playerScoreText[name] = playerScoreText[name] + 1
            --playerScoreRecord = playerScoreRecord + 1
            tfm.exec.playSound("transformice/son/fleche.mp3", 100, nil, nil, name)
            ui.updateTextArea(2, "<p align='center'><font size='24' color='#FFFFFF'>" .. playerScoreText[name] .. "</font></p>", name)
            --if playerScore[name] >= playerScoreRecord then
               --ui.updateTextArea(3, "<p align='center'><font size='16' color='#FFFFFF'>Highest score record " .. playerScoreRecord .. " by " .. name .. "</font></p>", nil)
            --end
            playerScore[name] = playerScore[name] + 1
            if playerScore[name] > playerScoreRecord[name] then
               playerScoreRecord[name] = playerScoreRecord[name] + 1
               tfm.exec.setPlayerScore(name, playerScore[name])
            end
         end
      end
      if difficultyBarWidth < 400 then
         difficultyBarWidth = difficultyBarWidth + 5
      end
      ui.addTextArea(4, "", nil, 200, 25, 400, 10, 0x808080, 0, 1, false)
      ui.addTextArea(5, "", nil, 200, 25, difficultyBarWidth, 10, 0x1AA0E4, 0, 1, false)
      ui.addTextArea(6, "<font size='16' color='#FFFFFF'>Difficulty:</font>  <font size='16' color='#24D02A'>1</font><font color='#FFFFFF'>                    <font size='16' color='#FEFF00'>21</font>                    <font size='16' color='#FFA100'>41</font>                    <font size='16' color='#F20D0D'>61</font>               <font size='16' color='#731BE0'>+81</font>", nil, 110, 20, 500, 50, 0x000000, 0, 1, false)
      for name in next, tfm.get.room.playerList do
         if playerAlive[name] == true then
            if playerScore[name] > highestPlayerScore then
               highestPlayerScore = highestPlayerScore + 1 / playerAliveCount
               highestPlayerScoreName = name
               ui.addTextArea(7, "<p align='center'><font size='16' color='#FFFFFF'>Highest score " .. math.floor(highestPlayerScore) .. " record by " .. highestPlayerScoreName .. "</font></p>", nil, 0, 40, 800, 40, 0x000000, 0, 1, false)
            end
         end
      end
      playerScoreTimer = 1
   end 
   -- Add new random barrier every 2 seconds --
   barrierSpawnTimer = barrierSpawnTimer - 0.5
   if barrierSpawnTimer == 0 then
      barrierSpawnCount = barrierSpawnCount + 1
      randomBarrierHeight = {40, 80, 120, 160, 200, 240}
      randomBarrierHeight = randomBarrierHeight[math.random(#randomBarrierHeight)]
      -- Barrier Level --
      if barrierSpawnCount > 20 and barrierSpawnCount <= 40 then
         barrierLevel, barrierColor, barrierYPosition = 290, "0xFEFF00", 235
      elseif barrierSpawnCount > 40 and barrierSpawnCount <= 60 then
         barrierLevel, barrierColor, barrierYPosition = 300, "0xFFA100", 230
      elseif barrierSpawnCount > 60 and barrierSpawnCount <= 80 then
         barrierLevel, barrierColor, barrierYPosition = 310, "0xF20D0D", 225
      elseif barrierSpawnCount > 80 then
         barrierLevel, barrierColor, barrierYPosition = 320, "0x731BE0", 220
      end 
      tfm.exec.addPhysicObject(groundId + 1, 1020, randomBarrierHeight / 2, {type = 12, width = 20, height = randomBarrierHeight, dynamic = true, color = barrierColor, fixedRotation = true, mass = 999999})
      tfm.exec.movePhysicObject(groundId + 1, 0, 0, false, -6, 0, true)
      tfm.exec.addPhysicObject(groundId + 2, 1020, randomBarrierHeight / 2 + barrierYPosition, {type = 12, width = 20, height = barrierLevel - randomBarrierHeight, dynamic = true, color = barrierColor, fixedRotation = true, mass = 999999})
      tfm.exec.movePhysicObject(groundId + 2, 0, 0, false, -6, 0, true)
      groundId = groundId + 2
      barrierSpawnTimer = 1
   end
   -- Remove barrier every 1 seconds --
   removeBarrierTimer = removeBarrierTimer - 0.5
   if removeBarrierTimer == 0 then
      groundIdList = {}
      groundId2 = groundId2 + 2
      table.insert(groundIdList, 1, groundId2 + 1)
      table.insert(groundIdList, 1, groundId2 + 2)
      tfm.exec.removePhysicObject(groundIdList[1])
      tfm.exec.removePhysicObject(groundIdList[2])
      removeBarrierTimer = 1
   end
end
