--[[ T-Rex Mice Game minigame made by Kralizmox#0000 ]]--
--[[ Made in 3 January 2025 ]]--

tfm.exec.disableAutoShaman()
tfm.exec.disableAutoNewGame()
tfm.exec.disableMortCommand()
tfm.exec.disableDebugCommand()
tfm.exec.disablePhysicalConsumables()
tfm.exec.disableAfkDeath()
tfm.exec.disableAutoTimeLeft()
tfm.exec.disableAutoScore()

local admins = {["Kralizmox#0000"] = true, ["Kornelkafb#0000"] = true}
local playerAlive, playerScore, playerHighScore, afkTimer, highestScore1, highestScore2, playerName, pressedSpacebar, spacebarTimer, playerScore2 = {}, {}, {}, {}, 0, 0, "none", {}, {}, {}
local scoreTimer, addGroundTimer, addCloudTimer = 3, 3, 3
local groundId, groundSpeedX, groundColor = 7, -10, "0x404040"
local playerLeaderboardName1, playerLeaderboardName2, playerLeaderboardName3, playerLeaderboardName4, playerLeaderboardName5, playerLeaderboardName6, playerLeaderboardName7, playerLeaderboardName8, playerLeaderboardName9, playerLeaderboardName10 = "none", "none", "none", "none", "none", "none", "none", "none", "none", "none"
local playerTop1Score, playerTop2Score, playerTop3Score, playerTop4Score, playerTop5Score, playerTop6Score, playerTop7Score, playerTop8Score, playerTop9Score, playerTop10Score = 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
local map = '<C><P G="0,0.0001" MEDATA=";;;;-0;0:::1-"/><Z><S><S T="9" X="50" Y="355" L="20" H="20" P="0,0,0,0,0,0,0,0" m=""/><S T="12" X="400" Y="-45" L="800" H="510" P="0,0,0,0,0,0,0,0" o="D1D4DA"/></S><D><DS X="50" Y="350"/></D><O/><L/></Z></C>'
tfm.exec.newGame(map)
tfm.exec.setGameTime(9999999)

function addGround()
   ui.setBackgroundColor("#D1D4DA")
   tfm.exec.addPhysicObject(2, 400, 370, {type = 12, width = 2800, height = 10, friction = 0, restitution = 0, miceCollision = false, foreground = true, color = 0x000000})
   tfm.exec.addPhysicObject(3, -500, 200, {type = 12, width = 1000, height = 1000, friction = 0, restitution = 0, miceCollision = false, groundCollision = false, foreground = true, color = 0xD1D4DA})
   tfm.exec.addPhysicObject(4, 1300, 200, {type = 12, width = 1000, height = 1000, friction = 0, restitution = 0, groundCollision = false, foreground = true, color = 0xD1D4DA})
   --tfm.exec.addPhysicObject(5, 400, -45, {type = 12, width = 800, height = 510, friction = 0, restitution = 0, groundCollision = false, color = 0xD1D4DA})
   tfm.exec.addPhysicObject(6, 400, 530, {type = 12, width = 800, height = 330, friction = 0, restitution = 0, groundCollision = false, color = 0xD1D4DA, contactListener = true})
end
 
function eventNewGame()
   scoreTimer, addGroundTimer, addCloudTimer = 3, 3, 3 
   groundSpeedX, groundColor = -10, "0x404040"
   for name in next, tfm.get.room.playerList do
      playerAlive[name], playerScore[name], afkTimer[name], highestScore1, pressedSpacebar[name], spacebarTimer[name], playerScore2[name] = true, 0, 7, 0, false, 1, 100
      tfm.exec.setPlayerGravityScale(name, 1000000)
      tfm.exec.freezePlayer(name, true, false)
      tfm.exec.setNameColor(name, 0x404040)
      ui.addTextArea(1, "<p align='right'><font size='24' color='#404040' face='Press Start 2P'>" .. playerScore[name] .. "</font></p>", name, 695, 25, 100, 30, 0x000000, 0, 1, true)
      ui.addTextArea(3, "<p align='right'><font size='24' color='#404040' face='Press Start 2P'>HI " .. playerHighScore[name] .. "</font></p>", name, 555, 25, 130, 30, 0x000000, 0, 1, true)
      ui.addTextArea(4, "<p align='center'><font size='24' color='#404040' face='Press Start 2P'>Speed: " .. math.floor(math.abs(groundSpeedX)) .. " km/h</font></p>", nil, 0, 25, 800, 30, 0x000000, 0, 1, true)
      ui.addTextArea(5, "<p align='center'><font size='80' face='Product Sans'><font color='#4285F4'>G</font><font color='#EA4335'>o</font><font color='#FBBC05'>o</font><font color='#4285F4'>g</font><font color='#34A853'>l</font><font color='#EA4335'>e</font></font></p>", nil, 0, 70, 800, 110, 0x000000, 0, 1, true)
      system.bindKeyboard(name, 1, true, true)
      system.bindKeyboard(name, 32, true, true)
   end
   ui.setMapName("T-Rex Mice Game")
   addGround()
   ui.removeTextArea(2, nil)
end

function eventNewPlayer(name)
   playerAlive[name], playerScore[name], playerHighScore[name] = false, 0, 0
   --playerTop1Score, playerTop2Score, playerTop3Score, playerTop4Score, playerTop5Score, playerTop6Score, playerTop7Score, playerTop8Score, playerTop9Score, playerTop10Score = 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
   tfm.exec.chatMessage("<font color='#30BA76'>Welcome to T-Rex Mice Game!</font>\n<D>How to play?\n• Press spacebar or up key to jump.</D>\n<J>Tip: When there many players, use ./watch [player name] command to see yourself for better gameplay.</J>\n<FC>Minigame made by Kralizmox#0000</FC>", name)
   tfm.exec.setPlayerScore(name, playerScore[name])
   ui.setMapName("T-Rex Mice Game")
   if groundSpeedX == -50 then
      ui.addTextArea(4, "<p align='center'><font size='24' color='#404040' face='Press Start 2P'>Speed: " .. math.floor(math.abs(groundSpeedX)) .. " km/h</font></p>", nil, 0, 25, 800, 30, 0x000000, 0, 1, true)
   end
   ui.addTextArea(5, "<p align='center'><font size='80' face='Product Sans'><font color='#4285F4'>G</font><font color='#EA4335'>o</font><font color='#FBBC05'>o</font><font color='#4285F4'>g</font><font color='#34A853'>l</font><font color='#EA4335'>e</font></font></p>", nil, 0, 70, 800, 110, 0x000000, 0, 1, true)
   ui.addTextArea(6, "<p align='center'><font size='24' color='#404040' face='Press Start 2P'>Highest score record " .. highestScore2 .. " by " .. playerName .. "</font></p>", nil, 0, 50, 800, 110, 0x000000, 0, 1, true)
   addGround()
   system.disableChatCommandDisplay(nil, true)
end

for name in next, tfm.get.room.playerList do
   eventNewPlayer(name)
end

function eventChatCommand(name, cmd)
   if admins[name] == true then
      if cmd == "kill " .. name then
         tfm.exec.killPlayer(name)
      end
   end
end

--[[ When all players is died ]]--
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
   system.bindKeyboard(name, 1, true, false)
   system.bindKeyboard(name, 32, true, false)
   if playerScore[name] >= playerHighScore[name] then
      playerHighScore[name] = playerScore[name]
      tfm.exec.setPlayerScore(name, playerHighScore[name])
      ui.addTextArea(3, "<p align='right'><font size='24' color='#404040' face='Press Start 2P'>HI " .. playerHighScore[name] .. "</font></p>", name, 555, 25, 130, 30, 0x000000, 0, 1, true)
   end
   if playerScore[name] >= highestScore2 then
      playerName = name
      ui.addTextArea(6, "<p align='center'><font size='24' color='#404040' face='Press Start 2P'>Highest score record " .. highestScore2 .. " by " .. playerName .. "</font></p>", nil, 0, 50, 800, 110, 0x000000, 0, 1, true)
   end
   if checkDead() then
      gameTime = 5
      ui.addTextArea(2, "<p align='center'><font size='24' color='#404040' face='Press Start 2P'>G A M E    O V E R</font></p>", nil, 0, 200, 800, 30, 0x000000, 0, 1, true)
   end
end

function eventKeyboard(name, key, down, x, y)
   if key == 1 or key == 32 then -- Up and spacebar
      if pressedSpacebar[name] == false then
         tfm.exec.movePlayer(name, 0, 0, false, 0, -300, false)
         tfm.exec.playSound("transformice/son/dash.mp3", 100, nil, nil, name)
      end
      afkTimer[name], pressedSpacebar[name] = 7, true
   end
end

function eventContactListener(name, id, info)
   if id >= 7 then
      tfm.exec.killPlayer(name)
   end
end

function eventLoop()
   --[[ When all players died, set game time 5 seconds ]]--
   if checkDead() then
      gameTime = gameTime - 0.5
      if gameTime == 0 then
         tfm.exec.newGame(map)
         tfm.exec.setGameTime(9999999)
      end
   end
   --[[ Add player score 10 every 1 seconds ]]--
   scoreTimer = scoreTimer - 0.5
   if scoreTimer == 0 and not checkDead() then
      highestScore1 = highestScore1 + 10
      if groundSpeedX > -50 and not checkDead() then
         groundSpeedX = groundSpeedX - 0.5
         ui.addTextArea(4, "<p align='center'><font size='24' color='#404040' face='Press Start 2P'>Speed: " .. math.floor(math.abs(groundSpeedX)) .. " km/h</font></p>", nil, 0, 25, 800, 30, 0x000000, 0, 1, true)
      end
      for name in next, tfm.get.room.playerList do
         if playerAlive[name] == true then
            playerScore[name] = playerScore[name] + 10
            ui.addTextArea(1, "<p align='right'><font size='24' color='#404040' face='Press Start 2P'>" .. playerScore[name] .. "</font></p>", name, 695, 25, 100, 30, 0x000000, 0, 1, true)
            tfm.exec.setPlayerScore(name, playerHighScore[name])
            if playerScore[name] == playerScore2[name] then
               playerScore2[name] = playerScore2[name] + 100
               tfm.exec.playSound("transformice/son/fleche.mp3", 100, nil, nil, name)
            end
         end
      end
      if highestScore1 > highestScore2 then
         highestScore2 = highestScore2 + 10
      end
      scoreTimer = 1
   end
   --[[ Add cactus and bird every 1 between 2 seconds ]]--
   if not checkDead() then
      addGroundTimer = addGroundTimer - 0.5
      groundId = groundId + 12
      if addGroundTimer == 0 then
         if highestScore1 < 100 then
            randomCactus = math.random(2)
         elseif highestScore1 >= 100 and highestScore1 < 200 then
            randomCactus = math.random(4)
         elseif highestScore1 >= 200 and highestScore1 < 300 then
            randomCactus = math.random(6)
         elseif highestScore1 >= 300 and highestScore1 < 400 then
            randomCactus = math.random(7)
         elseif highestScore1 >= 400 and highestScore1 < 600 then
            randomCactus = math.random(9)
         elseif highestScore1 >= 600 then
            randomCactus = math.random(11)
         end
         if randomCactus == 1 then
            loopCount = 4
            xPosition, yPosition, width, height, angle = {820, 820, 805, 835}, {345, 355, 350, 350}, {13, 40, 10, 10}, {40, 10, 20, 20}, {0, 0, 180, 180} -- Small cactus ground list
         elseif randomCactus == 2 then
            loopCount = 4
            xPosition, yPosition, width, height, angle = {820, 820, 805, 835}, {335, 345, 335, 335}, {13, 40, 10, 10}, {60, 10, 30, 30}, {0, 0, 180, 180} -- Long cactus ground list
         elseif randomCactus == 3 then
            loopCount = 8
            xPosition, yPosition, width, height, angle = {820, 820, 805, 835, 865, 865, 850, 880}, {345, 355, 350, 350, 345, 355, 350, 350}, {13, 30, 10, 10, 13, 30, 10, 10}, {40, 10, 20, 20, 40, 10, 20, 20}, {0, 0, 180, 180, 0, 0, 180, 180} -- Two small cactus ground list
         elseif randomCactus == 4 then
            loopCount = 8
            xPosition, yPosition, width, height, angle = {820, 820, 805, 835, 865, 865, 850, 880}, {335, 345, 335, 335, 335, 345, 335, 335}, {13, 40, 10, 10, 13, 40, 10, 10}, {60, 10, 20, 20, 60, 10, 20, 20}, {0, 0, 180, 180, 0, 0, 180, 180} -- Two long cactus ground list
         elseif randomCactus == 5 then
            loopCount = 12
            xPosition, yPosition, width, height, angle = {820, 820, 805, 835, 865, 865, 850, 880, 910, 910, 895, 925}, {345, 355, 350, 350, 345, 355, 350, 350, 345, 355, 350, 350}, {13, 30, 10, 10, 13, 30, 10, 10, 13, 30, 10, 10}, {40, 10, 20, 20, 40, 10, 20, 20, 40, 10, 20, 20}, {0, 0, 180, 180, 0, 0, 180, 180, 0, 0, 180, 180} -- Three small cactus ground list
         elseif randomCactus == 6 then
            loopCount = 12
            xPosition, yPosition, width, height, angle = {820, 820, 805, 835, 865, 865, 850, 880, 910, 910, 895, 925}, {335, 345, 335, 335, 335, 345, 335, 335, 335, 345, 335, 335}, {13, 40, 10, 10, 13, 40, 10, 10, 13, 40, 10, 10}, {60, 10, 20, 20, 60, 10, 20, 20, 60, 10, 20, 20}, {0, 0, 180, 180, 0, 0, 180, 180, 0, 0, 180, 180} -- Three long cactus ground list
         elseif randomCactus == 7 then
            loopCount = 8
            xPosition, width, height, angle = {840, 840, 850, 815, 815, 845, 855, 865}, {80, 40, 40, 10, 30, 10, 10, 10}, {10, 10, 10, 10, 10, 30, 20, 10}, {0, 0, 0, 0, 0, 0, 0, 0} -- Bird ground list
            randomYPosition = math.random(2)
            if randomYPosition == 1 then
               yPosition = {330, 340, 350, 310, 320, 310, 315, 320}
            elseif randomYPosition == 2 then
               yPosition = {265, 275, 285, 245, 255, 245, 250, 255}
            end
         elseif randomCactus == 8 then
            loopCount = 16
            xPosition, yPosition, width, height, angle = {820, 820, 805, 835, 865, 865, 850, 880, 910, 910, 895, 925, 955, 955, 940, 970}, {345, 355, 350, 350, 345, 355, 350, 350, 345, 355, 350, 350, 345, 355, 350, 350}, {13, 30, 10, 10, 13, 30, 10, 10, 13, 30, 10, 10, 13, 30, 10, 10}, {40, 10, 20, 20, 40, 10, 20, 20, 40, 10, 20, 20, 40, 10, 20, 20}, {0, 0, 180, 180, 0, 0, 180, 180, 0, 0, 180, 180, 0, 0, 180, 180} -- Four small cactus ground list
         elseif randomCactus == 9 then
            loopCount = 16
            xPosition, yPosition, width, height, angle = {820, 820, 805, 835, 865, 865, 850, 880, 910, 910, 895, 925, 955, 955, 940, 970}, {335, 345, 335, 335, 335, 345, 335, 335, 335, 345, 335, 335, 335, 345, 335, 335}, {13, 40, 10, 10, 13, 40, 10, 10, 13, 40, 10, 10, 13, 40, 10, 10}, {60, 10, 20, 20, 60, 10, 20, 20, 60, 10, 20, 20, 60, 10, 20, 20}, {0, 0, 180, 180, 0, 0, 180, 180, 0, 0, 180, 180, 0, 0, 180, 180} -- Four long cactus ground list
         elseif randomCactus == 10 then
            loopCount = 20
            xPosition, yPosition, width, height, angle = {820, 820, 805, 835, 865, 865, 850, 880, 910, 910, 895, 925, 955, 955, 940, 970, 1000, 1000, 985, 1015}, {345, 355, 350, 350, 345, 355, 350, 350, 345, 355, 350, 350, 345, 355, 350, 350, 345, 355, 350, 350}, {13, 30, 10, 10, 13, 30, 10, 10, 13, 30, 10, 10, 13, 30, 10, 10, 13, 30, 10, 10}, {40, 10, 20, 20, 40, 10, 20, 20, 40, 10, 20, 20, 40, 10, 20, 20, 40, 10, 20, 20}, {0, 0, 180, 180, 0, 0, 180, 180, 0, 0, 180, 180, 0, 0, 180, 180, 0, 0, 180, 180} -- Five small cactus ground list
         elseif randomCactus == 11 then
            loopCount = 20
            xPosition, yPosition, width, height, angle = {820, 820, 805, 835, 865, 865, 850, 880, 910, 910, 895, 925, 955, 955, 940, 970, 1000, 1000, 985, 1015}, {335, 345, 335, 335, 335, 345, 335, 335, 335, 345, 335, 335, 335, 345, 335, 335, 335, 345, 335, 335}, {13, 40, 10, 10, 13, 40, 10, 10, 13, 40, 10, 10, 13, 40, 10, 10, 13, 40, 10, 10}, {60, 10, 20, 20, 60, 10, 20, 20, 60, 10, 20, 20, 60, 10, 20, 20, 60, 10, 20, 20}, {0, 0, 180, 180, 0, 0, 180, 180, 0, 0, 180, 180, 0, 0, 180, 180, 0, 0, 180, 180} -- Five long cactus ground list
         end
         for i = 1, loopCount do
            tfm.exec.addPhysicObject(groundId + i, xPosition[i], yPosition[i], {type = 12, width = width[i], height = height[i], friction = 0, restitution = 0, color = 0x404040, angle = angle[i], groundCollision = false, dynamic = true, fixedRotation = true, mass = 999999, contactListener = true})
            tfm.exec.movePhysicObject(groundId + i, 0, 0, false, groundSpeedX, 0, false)
         end
         addGroundTimer = math.random(2)
      end
      --[[ Add cloud every 2 beetwen 3 seconds ]]--
      addCloudTimer = addCloudTimer - 0.5
      if addCloudTimer == 0 then
         randomYPositionCloud = math.random(100, 250)
         tfm.exec.addPhysicObject(groundId + 999996, 840, randomYPositionCloud, {type = 12, width = 80, height = 20, friction = 0.3, restitution = 0, miceCollision = false, groundCollision = false, dynamic = true, color = 0x000000})
         tfm.exec.addPhysicObject(groundId + 999997, 840, randomYPositionCloud - 15, {type = 12, width = 50, height = 10, friction = 0.3, restitution = 0, miceCollision = false, groundCollision = false, dynamic = true, color = 0x000000})
         tfm.exec.addPhysicObject(groundId + 999998, 840, randomYPositionCloud - 10, {type = 12, width = 40, height = 10, friction = 0.3, restitution = 0, miceCollision = false, groundCollision = false, dynamic = true, color = 0xD1D4DA})
         tfm.exec.addPhysicObject(groundId + 999999, 840, randomYPositionCloud, {type = 12, width = 70, height = 10, friction = 0.3, restitution = 0, miceCollision = false, groundCollision = false, dynamic = true, color = 0xD1D4DA})
         tfm.exec.movePhysicObject(groundId + 999996, 0, 0, false, -3, 0, false)
         tfm.exec.movePhysicObject(groundId + 999997, 0, 0, false, -3, 0, false)
         tfm.exec.movePhysicObject(groundId + 999998, 0, 0, false, -3, 0, false)
         tfm.exec.movePhysicObject(groundId + 999999, 0, 0, false, -3, 0, false)
         addCloudTimer = math.random(2, 3)
      end
   end
   for name in next, tfm.get.room.playerList do
      tfm.exec.setPlayerGravityScale(name, 1000000)
      --[[ Kill player, if afk time is 0 ]]--
      if playerAlive[name] == true then
         afkTimer[name] = afkTimer[name] - 0.5
         if afkTimer[name] == 0 then
            tfm.exec.killPlayer(name)
         end
      end
      if pressedSpacebar[name] == true then
         spacebarTimer[name] = spacebarTimer[name] - 0.5
         if spacebarTimer[name] == 0 then
            pressedSpacebar[name], spacebarTimer[name] = false, 0.5
         end
      end
   end
end
