--[[ The Floor is Random Fan Made by Kralizmox#0000 ]]--
--[[ Made in March 2024 ]]--
--[[ Last update in 9 September 2024 ]]--

tfm.exec.disableAutoShaman()
tfm.exec.disableAutoNewGame()
tfm.exec.disableAutoTimeLeft()
tfm.exec.disableDebugCommand()
tfm.exec.disablePhysicalConsumables()

local admins, mods = {["Kralizmox#0000"] = true}, {["Onlinerido#0000"] = true, ["Kickaricka3#9256"] = true, ["Qtangel#0000"] = true}
local randomXPositionMap2, randomYPositionMap2 = {math.random(15, 145), math.random(375, 505), math.random(735, 865), math.random(1095, 1225), math.random(1455, 1585)}, {605, 485, 365}
local playerCount, playerCount2, playerScore, playerVictory, playerVictoryCount, playerIsBanned = 0, 0, {}, false, {}, {}
local text = {"<font color='#30BA76'>Victory does count</font>", "<font color='#CB546B'>Victory doesn\'t count</font>"}
local events, groundTypeList, groundTypeList2, shamanObjectList = {"dont jump", "disco"}, {3, 8, 9, 15, 19}, {1, 2, 4, 6, 20}, {1, 2, 3, 4, 6, 7, 10, 28, 39, 40, 45, 46, 57, 59, 60, 61, 67, 68, 69}
local randomObject1, randomObject2, randomObject3, randomObject4, randomObject5 = math.random(19), math.random(19), math.random(19), math.random(19), math.random(19)
local downKeyIsPressed = {}
local musicTimer, timer, timer2, secondTimer, shootTimer = {}, 10.5, 5.5, -4, {}
local loopCount = 0
local shamanObjectCount1, shamanObjectCount2 = {20, 50, 80, 110, 140, 170, 200, 230, 260, 290, 320, 350, 380, 410, 440, 470, 500, 530, 560, 590, 620, 650, 680, 710, 740, 770, 800, 830, 860, 890, 920, 950, 980, 1010, 1040, 1070, 1100, 1130, 1160, 1190, 1220, 1250, 1280, 1310, 1340, 1370, 1400, 1430, 1460, 1490, 1520, 1550, 1580, 20, 50, 80, 110, 140, 170, 200, 230, 260, 290, 320, 350, 380, 410, 440, 470, 500, 530, 560, 590, 620, 650, 680, 710, 740, 770, 800, 830, 860, 890, 920, 950, 980, 1010, 1040, 1070, 1100, 1130, 1160, 1190, 1220, 1250, 1280, 1310, 1340, 1370, 1400, 1430, 1460, 1490, 1520, 1550, 1580}, {130, 165, 200, 235, 270, 430, 465, 500, 535, 570, 730, 765, 800, 835, 870, 1030, 1065, 1100, 1135, 1170, 1330, 1365, 1400, 1435, 1470, 130, 165, 200, 235, 270, 430, 465, 500, 535, 570, 730, 765, 800, 835, 870, 1030, 1065, 1100, 1135, 1170, 1330, 1365, 1400, 1435, 1470, 130, 165, 200, 235, 270, 430, 465, 500, 535, 570, 730, 765, 800, 835, 870, 1030, 1065, 1100, 1135, 1170, 1330, 1365, 1400, 1435, 1470}
local randomFloor, randomGround, randomFloorEvent, randomFloorTimer = {0, 1, 3, 7, 8, 9, 14, 15, 17, 19, 32, 40, 41, 42, 43}, 17, false, 2
local objectCount, object = 0, {}
local transform, balloon = 0, 0
local maps = {7959077, 7959078}

maps = maps[math.random(2)]
tfm.exec.newGame(maps)
tfm.exec.setRoomMaxPlayers(100)

function eventNewGame()
   playerCount, playerCount2, playerVictory = 0, 0, false
   timer, timer2, timer3, secondTimer = 10.5, 5.5, 15.5, -4
   loopCount = 0
   --{0, 1, 3, 7, 8, 9, 14, 15, 17, 19, 28, 32, 40, 41, 42, 43, 44}
   randomFloor, randomGround, randomFloorEvent, randomFloorTimer = {0, 1, 3, 7, 8, 9, 14, 15, 17, 19, 28, 32, 40, 41, 42, 43, 44}, 17, false, 0
   objectCount = 0
   transform, balloon = 0, 0
   ui.setMapName("The floor is random fan made by <font color='#EB1D51'>Kralizmox#0000</font>")
   ui.setBackgroundColor("#5A93FF")
   ui.removeTextArea(2, nil)
   tfm.exec.setGameTime(9999999)
   tfm.exec.addImage("18a6c9d7a9a.png", "?1", 0, 0, name, 1.758, 1.093) 
   for name in next, tfm.get.room.playerList do
      playerCount2 = playerCount2 + 1
      if admins[name] == true then
         tfm.exec.setNameColor(name, 0xEB1D51)
      end
      if mods[name] == true then
         tfm.exec.setNameColor(name, 0xBABD2F)
      end
      if playerIsBanned[name] == true then
         tfm.exec.killPlayer(name)
      end
      if playerCount2 >= 11 then
         ui.setMapName("The floor is random fan made <font color='#606090'> | </font> " .. text[1])
         if playerVictoryCount[name] == 2 then
            tfm.exec.changePlayerSize(name, 2)
         elseif playerVictoryCount[name] == 3 then
            tfm.exec.changePlayerSize(name, 3)
         elseif playerVictoryCount[name] == 4 then
            tfm.exec.changePlayerSize(name, 4)
         elseif playerVictoryCount[name] == 5 then
            tfm.exec.changePlayerSize(name, 5)
         end
      elseif playerCount2 < 11 then
         ui.setMapName("The floor is random fan made <font color='#606090'> | </font> " .. text[2])
         tfm.exec.changePlayerSize(name, 1)
      end
   end
   if maps == 7959077 then
      tfm.exec.addPhysicObject(1, 800, 280, {type = 6, width = 1600, height = 40, friction = 0.3, restitution = 0.2, miceCollision = true, groundCollision = true})
      tfm.exec.addPhysicObject(2, 800, 780, {type = 6, width = 1600, height = 40, friction = 0.3, restitution = 0.2, miceCollision = true, groundCollision = true})
   elseif maps == 7959078 then
      groundXPositions, groundYPositions = {200, 500, 800, 1100, 1400, 200, 500, 800, 1100, 1400, 200, 500, 800, 1100, 1400}, {150, 150, 150, 150, 150, 400, 400, 400, 400, 400, 650, 650, 650, 650, 650}
      for i = 1, 15 do
         tfm.exec.addPhysicObject(i, groundXPositions[i], groundYPositions[i], {type = 6, width = 200, height = 40, friction = 0.3, restitution = 0.2, miceCollision = true, groundCollision = true})
      end
   end
   for name in next, tfm.get.room.playerList do
      playerCount = playerCount + 1
      system.bindKeyboard(name, 3, true, false)
      tfm.exec.giveTransformations(name, false)
      if playerVictoryCount[name] == 0 or playerVictoryCount[name] == 1 then
         tfm.exec.changePlayerSize(name, 1)
      end
   end
end

function eventNewPlayer(name)
   playerScore[name], playerVictoryCount[name] = 0, 0
   musicTimer[name] = 0
   downKeyIsPressed[name], shootTimer[name] = false, 1.5
   if playerCount2 >= 11 then
      ui.setMapName("The floor is random <font color='#606090'> | </font> " .. text[1])
   elseif playerCount < 11 then
      ui.setMapName("The floor is random <font color='#606090'> | </font> " .. text[2])
   end
   ui.setBackgroundColor("#5A93FF")
   tfm.exec.chatMessage("<font color='#BABD2F'>Welcome to the floor is random fan made!</font>\n<font color='#30BA76'>To get victory score, you need at least over than 11 players. Victory rewards: At 2, 3, 4 and 5 score, you will get more bigger size!</font>\n<font color='#CB546B'>Please dont use x bug, you will get die by admins and mods.</font>\n<font color='#ED67EA'>What's new? (9 September 2024)\n• Added new 4 floor (deathmatch floor, stable rune floor, balloon floor and transform floor)\n• Decreased 1 second in rune floor, space floor and decreased 0.50 second in nothing floor, ice floor\n• There 17 total floors now\n• Added new 1 map</font>\n<font color='#E68D43'>This fan made minigame created by: Kralizmox#0000.</font>", name)
   tfm.exec.addImage("18a6c9d7a9a.png", "?1", 0, 0, name, 1.758, 1.093)
   tfm.exec.setPlayerScore(name, playerScore[name])
   system.disableChatCommandDisplay(nil, true)
end

for name in next, tfm.get.room.playerList do
   eventNewPlayer(name)
end

function eventChatCommand(name, cmd)
   --[[ Admin Commands ]]--
   if admins[name] == true then
      for name in next, tfm.get.room.playerList do
         if cmd == "kill " .. name then
            tfm.exec.killPlayer(name)
            tfm.exec.chatMessage("<font color='#CB546B'>You got killed by admin. Reason: Using x bug.</font>", name)
         end
         if cmd == "ban " .. name then
            tfm.exec.killPlayer(name)
            tfm.exec.chatMessage("<font color='#CB546B'>You got killed by admin.</font>", name)
            playerIsBanned[name] = true
         end
         if cmd == "unban " .. name then
            tfm.exec.chatMessage("<font color='#6C77C1'>You got unbanned by admin.</font>", name)
            playerIsBanned[name] = false
         end
         if cmd == "resetvictorycount all" then
            for name in next, tfm.get.room.playerList do
               playerScore[name], playerVictoryCount[name] = 0, 0
               tfm.exec.setPlayerScore(name, playerScore[name])
            end
         end
      end
   end
   --[[ Mods Commands ]]--
   if mods[name] == true then
      for name in next, tfm.get.room.playerList do
         if cmd == "kill " .. name then
            tfm.exec.killPlayer(name)
            tfm.exec.chatMessage("<font color='#BABD2F'>You got killed by mods. Reason: Using x bug.</font>", name)
         end
         if cmd == "ban " .. name then
            tfm.exec.killPlayer(name)
            tfm.exec.chatMessage("<font color='#BABD2F'>You got banned by mods.</font>", name)
            playerIsBanned[name] = true
         end
         if cmd == "unban " .. name then
            tfm.exec.chatMessage("<font color='#6C77C1'>You got unbanned by mods.</font>", name)
            playerIsBanned[name] = false
         end
      end
   end
end

function eventKeyboard(name, key, down, x, y)
   if key == 3 then
      if downKeyIsPressed[name] == false then
         objectCount = objectCount + 1
         if tfm.get.room.playerList[name].isFacingRight == true then
            object[objectCount] = tfm.exec.addShamanObject(17, x - 20, y + 20, 90, 0, 0, false)
         else 
            object[objectCount] = tfm.exec.addShamanObject(17, x + 20, y + 20, -90, 0, 0, false)
         end
         downKeyIsPressed[name] = true
      end
   end
end

function eventLoop()
   for name in next, tfm.get.room.playerList do
         musicTimer[name] = musicTimer[name] + 0.5
      if musicTimer[name] == 0.5 then
         tfm.exec.playSound("cite18/musique/toundra1.mp3", 100, nil, nil, name)
      elseif musicTimer[name] == 95.5 then
         musicTimer[name] = 0
      end
   end
   if playerVictory == false then
      timer = timer - 0.5
   elseif playerVictory == true then
      timer2 = timer2 - 0.5
   end
   if (timer == 10.5 or timer == 9.5 or timer == 8.5 or timer == 7.5 or timer == 6.5 or timer == 5.5 or timer == 4.5 or timer == 3.5 or timer == 2.5 or timer == 1.5) and playerVictory == false then
      ui.addTextArea(1, "<p align='center'><font size='50'>" .. math.floor(timer) .. "</font></p>", nil, 0, 50, 800, 60, 0x000000, 0, 1, true)
      tfm.exec.playSound("transformice/son/rebours.mp3", 100, nil, nil, name)
   end
   if timer == 4.5 and playerVictory == false then
      randomObject1, randomObject2, randomObject3, randomObject4 = math.random(19), math.random(19), math.random(19), math.random(19)
      if maps == 7959077 then
         if loopCount == 0 then
            shamanObject1 = tfm.exec.addShamanObject(shamanObjectList[randomObject1], math.random(0, 1600), 245, 0)
            shamanObject2 = tfm.exec.addShamanObject(shamanObjectList[randomObject2], math.random(0, 1600), 245, 0)
            shamanObject3 = tfm.exec.addShamanObject(shamanObjectList[randomObject3], math.random(0, 1600), 245, 0)
            shamanObject4 = tfm.exec.addShamanObject(shamanObjectList[randomObject4], math.random(0, 1600), 245, 0)
            shamanObject5 = tfm.exec.addShamanObject(shamanObjectList[randomObject1], math.random(0, 1600), 745, 0)
            shamanObject6 = tfm.exec.addShamanObject(shamanObjectList[randomObject2], math.random(0, 1600), 745, 0)
            shamanObject7 = tfm.exec.addShamanObject(shamanObjectList[randomObject3], math.random(0, 1600), 745, 0)
            shamanObject8 = tfm.exec.addShamanObject(shamanObjectList[randomObject4], math.random(0, 1600), 745, 0)
         elseif loopCount == 1 then
            shamanObject1 = tfm.exec.addShamanObject(shamanObjectList[randomObject1], math.random(0, 1600), 245, 0)
            shamanObject2 = tfm.exec.addShamanObject(shamanObjectList[randomObject2], math.random(0, 1600), 245, 0)
            shamanObject3 = tfm.exec.addShamanObject(shamanObjectList[randomObject3], math.random(0, 1600), 245, 0)
            shamanObject4 = tfm.exec.addShamanObject(shamanObjectList[randomObject1], math.random(0, 1600), 745, 0)
            shamanObject5 = tfm.exec.addShamanObject(shamanObjectList[randomObject2], math.random(0, 1600), 745, 0)
            shamanObject6 = tfm.exec.addShamanObject(shamanObjectList[randomObject3], math.random(0, 1600), 745, 0)
            for name in next, tfm.get.room.playerList do
               tfm.exec.giveCheese(name, true)
               tfm.exec.giveMeep(name, true)
            end
         elseif loopCount == 2 then
            shamanObject1 = tfm.exec.addShamanObject(shamanObjectList[randomObject1], math.random(0, 1600), 245, 0)
            shamanObject2 = tfm.exec.addShamanObject(shamanObjectList[randomObject2], math.random(0, 1600), 245, 0)
            shamanObject3 = tfm.exec.addShamanObject(shamanObjectList[randomObject1], math.random(0, 1600), 745, 0)
            shamanObject4 = tfm.exec.addShamanObject(shamanObjectList[randomObject2], math.random(0, 1600), 745, 0)
         elseif loopCount > 2 then
            shamanObject1 = tfm.exec.addShamanObject(shamanObjectList[randomObject1], math.random(0, 1600), 245, 0)
            shamanObject2 = tfm.exec.addShamanObject(shamanObjectList[randomObject1], math.random(0, 1600), 745, 0)
         end 
      elseif maps == 7959078 then
         randomXPosition1, randomXPosition2, randomXPosition3, randomXPosition4, randomXPosition5, randomXPosition6, randomXPosition7, randomXPosition8, randomXPosition9, randomXPosition10, randomXPosition11, randomXPosition12 = {math.random(120, 280), math.random(420, 580), math.random(720, 880), math.random(1020, 1180), math.random(1320, 1480)}, {math.random(120, 280), math.random(420, 580), math.random(720, 880), math.random(1020, 1180), math.random(1320, 1480)}, {math.random(120, 280), math.random(420, 580), math.random(720, 880), math.random(1020, 1180), math.random(1320, 1480)}, {math.random(120, 280), math.random(420, 580), math.random(720, 880), math.random(1020, 1180), math.random(1320, 1480)}, {math.random(120, 280), math.random(420, 580), math.random(720, 880), math.random(1020, 1180), math.random(1320, 1480)}, {math.random(120, 280), math.random(420, 580), math.random(720, 880), math.random(1020, 1180), math.random(1320, 1480)}, {math.random(120, 280), math.random(420, 580), math.random(720, 880), math.random(1020, 1180), math.random(1320, 1480)}, {math.random(120, 280), math.random(420, 580), math.random(720, 880), math.random(1020, 1180), math.random(1320, 1480)}, {math.random(120, 280), math.random(420, 580), math.random(720, 880), math.random(1020, 1180), math.random(1320, 1480)}, {math.random(120, 280), math.random(420, 580), math.random(720, 880), math.random(1020, 1180), math.random(1320, 1480)}, {math.random(120, 280), math.random(420, 580), math.random(720, 880), math.random(1020, 1180), math.random(1320, 1480)}, {math.random(120, 280), math.random(420, 580), math.random(720, 880), math.random(1020, 1180), math.random(1320, 1480)}
         if loopCount == 0 then
            shamanObject1 = tfm.exec.addShamanObject(shamanObjectList[randomObject1], randomXPosition1[math.random(5)], 115, 0)
            shamanObject2 = tfm.exec.addShamanObject(shamanObjectList[randomObject2], randomXPosition2[math.random(5)], 115, 0)
            shamanObject3 = tfm.exec.addShamanObject(shamanObjectList[randomObject3], randomXPosition3[math.random(5)], 115, 0)
            shamanObject4 = tfm.exec.addShamanObject(shamanObjectList[randomObject4], randomXPosition4[math.random(5)], 115, 0)
            shamanObject5 = tfm.exec.addShamanObject(shamanObjectList[randomObject1], randomXPosition5[math.random(5)], 365, 0)
            shamanObject6 = tfm.exec.addShamanObject(shamanObjectList[randomObject2], randomXPosition6[math.random(5)], 365, 0)
            shamanObject7 = tfm.exec.addShamanObject(shamanObjectList[randomObject3], randomXPosition7[math.random(5)], 365, 0)
            shamanObject8 = tfm.exec.addShamanObject(shamanObjectList[randomObject4], randomXPosition8[math.random(5)], 365, 0)
            shamanObject9 = tfm.exec.addShamanObject(shamanObjectList[randomObject1], randomXPosition9[math.random(5)], 615, 0)
            shamanObject10 = tfm.exec.addShamanObject(shamanObjectList[randomObject2], randomXPosition10[math.random(5)], 615, 0)
            shamanObject11 = tfm.exec.addShamanObject(shamanObjectList[randomObject3], randomXPosition11[math.random(5)], 615, 0)
            shamanObject12 = tfm.exec.addShamanObject(shamanObjectList[randomObject4], randomXPosition12[math.random(5)], 615, 0)
         elseif loopCount == 1 then
            shamanObject1 = tfm.exec.addShamanObject(shamanObjectList[randomObject1], randomXPosition1[math.random(5)], 115, 0)
            shamanObject2 = tfm.exec.addShamanObject(shamanObjectList[randomObject2], randomXPosition2[math.random(5)], 115, 0)
            shamanObject3 = tfm.exec.addShamanObject(shamanObjectList[randomObject3], randomXPosition3[math.random(5)], 115, 0)
            shamanObject4 = tfm.exec.addShamanObject(shamanObjectList[randomObject1], randomXPosition4[math.random(5)], 365, 0)
            shamanObject5 = tfm.exec.addShamanObject(shamanObjectList[randomObject2], randomXPosition5[math.random(5)], 365, 0)
            shamanObject6 = tfm.exec.addShamanObject(shamanObjectList[randomObject3], randomXPosition6[math.random(5)], 365, 0)
            shamanObject7 = tfm.exec.addShamanObject(shamanObjectList[randomObject1], randomXPosition7[math.random(5)], 615, 0)
            shamanObject8 = tfm.exec.addShamanObject(shamanObjectList[randomObject2], randomXPosition8[math.random(5)], 615, 0)
            shamanObject9 = tfm.exec.addShamanObject(shamanObjectList[randomObject3], randomXPosition9[math.random(5)], 615, 0)
            for name in next, tfm.get.room.playerList do
               tfm.exec.giveCheese(name, true)
               tfm.exec.giveMeep(name, true)
            end
         elseif loopCount == 2 then
            shamanObject1 = tfm.exec.addShamanObject(shamanObjectList[randomObject1], randomXPosition1[math.random(5)], 115, 0)
            shamanObject2 = tfm.exec.addShamanObject(shamanObjectList[randomObject2], randomXPosition2[math.random(5)], 115, 0)
            shamanObject3 = tfm.exec.addShamanObject(shamanObjectList[randomObject1], randomXPosition3[math.random(5)], 365, 0)
            shamanObject4 = tfm.exec.addShamanObject(shamanObjectList[randomObject2], randomXPosition4[math.random(5)], 365, 0)
            shamanObject5 = tfm.exec.addShamanObject(shamanObjectList[randomObject1], randomXPosition5[math.random(5)], 615, 0)
            shamanObject6 = tfm.exec.addShamanObject(shamanObjectList[randomObject2], randomXPosition6[math.random(5)], 615, 0)
         elseif loopCount > 2 then
            shamanObject1 = tfm.exec.addShamanObject(shamanObjectList[randomObject1], randomXPosition1[math.random(5)], 115, 0)
            shamanObject2 = tfm.exec.addShamanObject(shamanObjectList[randomObject2], randomXPosition2[math.random(5)], 365, 0)
            shamanObject3 = tfm.exec.addShamanObject(shamanObjectList[randomObject3], randomXPosition3[math.random(5)], 615, 0)
         end 
      end
   elseif timer == 0.5 and playerVictory == false then
      --[[ Random Floor Events ]]--
      groundTypeList = randomFloor
      --groundTypeList = {0}
      groundTypeList = groundTypeList[math.random(randomGround)]
      if groundTypeList == 0 then -- The floor is transform event
         ui.updateTextArea(1, "<p align='center'><font size='50' color='#D4B699'>THE FLOOR IS TRANSFORM</font></p>", nil, 0, 100, 800, 60, 0x000000, 0, 1, true)
         --tfm.exec.playSound("transformice/son/gel.mp3", 100, nil, nil, nil)
         if maps == 7959077 then
            tfm.exec.addPhysicObject(1, 800, 280, {type = groundTypeList, width = 1600, height = 40, friction = 0.3, restitution = 0.2, miceCollision = true, groundCollision = true})
            tfm.exec.addPhysicObject(2, 800, 780, {type = groundTypeList, width = 1600, height = 40, friction = 0.3, restitution = 0.2, miceCollision = true, groundCollision = true})
         elseif maps == 7959078 then
            groundXPositions, groundYPositions = {200, 500, 800, 1100, 1400, 200, 500, 800, 1100, 1400, 200, 500, 800, 1100, 1400}, {150, 150, 150, 150, 150, 400, 400, 400, 400, 400, 650, 650, 650, 650, 650}
            for i = 1, 15 do
               tfm.exec.addPhysicObject(i, groundXPositions[i], groundYPositions[i], {type = groundTypeList, width = 200, height = 40, friction = 0.3, restitution = 0.2, miceCollision = true, groundCollision = true})
            end
         end
         for name in next, tfm.get.room.playerList do
            tfm.exec.giveTransformations(name, true)
         end
         transform = 1 
         table.remove(randomFloor, 1)
         randomGround = randomGround - 1
         elseif groundTypeList == 1 then -- The floor is ice event
            secondTimer = -5.5
            ui.updateTextArea(1, "<p align='center'><font size='50' color='#88B5CC'>THE FLOOR IS ICE</font></p>", nil, 0, 100, 800, 60, 0x000000, 0, 1, true)
            tfm.exec.playSound("transformice/son/gel.mp3", 100, nil, nil, nil)
            if maps == 7959077 then
               tfm.exec.addPhysicObject(1, 800, 280, {type = groundTypeList, width = 1600, height = 40, friction = 0, restitution = 0.2, miceCollision = true, groundCollision = true})
               tfm.exec.addPhysicObject(2, 800, 780, {type = groundTypeList, width = 1600, height = 40, friction = 0, restitution = 0.2, miceCollision = true, groundCollision = true})
            elseif maps == 7959078 then
               groundXPositions, groundYPositions = {200, 500, 800, 1100, 1400, 200, 500, 800, 1100, 1400, 200, 500, 800, 1100, 1400}, {150, 150, 150, 150, 150, 400, 400, 400, 400, 400, 650, 650, 650, 650, 650}
               for i = 1, 15 do
                  tfm.exec.addPhysicObject(i, groundXPositions[i], groundYPositions[i], {type = groundTypeList, width = 200, height = 40, friction = 0, restitution = 0.2, miceCollision = true, groundCollision = true})
               end
            end
            for name in next, tfm.get.room.playerList do
               tfm.exec.freezePlayer(name, true)
            end
         elseif groundTypeList == 3 then -- The floor is lava event
            ui.updateTextArea(1, "<p align='center'><font size='50' color='#FF0000'>THE FLOOR IS LAVA</font></p>", nil, 0, 100, 800, 60, 0x000000, 0, 1, true)
            if maps == 7959077 then
               tfm.exec.addPhysicObject(1, 800, 280, {type = groundTypeList, width = 1600, height = 40, friction = 0.3, restitution = 0.2, miceCollision = false, groundCollision = true})
               tfm.exec.addPhysicObject(2, 800, 780, {type = groundTypeList, width = 1600, height = 40, friction = 0.3, restitution = 0.2, miceCollision = false, groundCollision = true})
            elseif maps == 7959078 then
               groundXPositions, groundYPositions = {200, 500, 800, 1100, 1400, 200, 500, 800, 1100, 1400, 200, 500, 800, 1100, 1400}, {150, 150, 150, 150, 150, 400, 400, 400, 400, 400, 650, 650, 650, 650, 650}
               for i = 1, 15 do
                  tfm.exec.addPhysicObject(i, groundXPositions[i], groundYPositions[i], {type = groundTypeList, width = 200, height = 40, friction = 0.3, restitution = 0.2, miceCollision = false, groundCollision = true})
               end
            end
         elseif groundTypeList == 7 then -- The floor is sandstorm event
            ui.updateTextArea(1, "<p align='center'><font size='50' color='#EFDF79'>THE FLOOR IS SANDSTORM</font></p>", nil, 0, 100, 800, 60, 0x000000, 0, 1, true)
            if maps == 7959077 then
               tfm.exec.addPhysicObject(1, 800, 280, {type = groundTypeList, width = 1600, height = 40, friction = 0.1, restitution = 0.2, miceCollision = true, groundCollision = true})
               tfm.exec.addPhysicObject(2, 800, 780, {type = groundTypeList, width = 1600, height = 40, friction = 0.1, restitution = 0.2, miceCollision = true, groundCollision = true})
            elseif maps == 7959078 then
               groundXPositions, groundYPositions = {200, 500, 800, 1100, 1400, 200, 500, 800, 1100, 1400, 200, 500, 800, 1100, 1400}, {150, 150, 150, 150, 150, 400, 400, 400, 400, 400, 650, 650, 650, 650, 650}
               for i = 1, 15 do
                  tfm.exec.addPhysicObject(i, groundXPositions[i], groundYPositions[i], {type = groundTypeList, width = 200, height = 40, friction = 0.1, restitution = 0.2, miceCollision = true, groundCollision = true})
               end
            end
            randomWind = {15, -15}
            tfm.exec.setWorldGravity(randomWind[math.random(2)], 10)
         elseif groundTypeList == 8 then -- The floor is cloud event
            ui.updateTextArea(1, "<p align='center'><font size='50' color='#ADD8E6'>THE FLOOR IS CLOUD</font></p>", nil, 0, 100, 800, 60, 0x000000, 0, 1, true)
            if maps == 7959077 then
               tfm.exec.addPhysicObject(1, 800, 280, {type = groundTypeList, width = 1600, height = 40, friction = 0.3, restitution = 0.2, miceCollision = false, groundCollision = true})
               tfm.exec.addPhysicObject(2, 800, 780, {type = groundTypeList, width = 1600, height = 40, friction = 0.3, restitution = 0.2, miceCollision = false, groundCollision = true})
            elseif maps == 7959078 then
               groundXPositions, groundYPositions = {200, 500, 800, 1100, 1400, 200, 500, 800, 1100, 1400, 200, 500, 800, 1100, 1400}, {150, 150, 150, 150, 150, 400, 400, 400, 400, 400, 650, 650, 650, 650, 650}
               for i = 1, 15 do
                  tfm.exec.addPhysicObject(i, groundXPositions[i], groundYPositions[i], {type = groundTypeList, width = 200, height = 40, friction = 0.3, restitution = 0.2, miceCollision = false, groundCollision = true})
               end
            end
         elseif groundTypeList == 9 then -- The floor is water event
            ui.updateTextArea(1, "<p align='center'><font size='50' color='#6DA7AF'>THE FLOOR IS WATER</font></p>", nil, 0, 100, 800, 60, 0x000000, 0, 1, true)
            if maps == 7959077 then
               tfm.exec.addPhysicObject(1, 800, 280, {type = groundTypeList, width = 1600, height = 40, friction = 0, restitution = 0.2, miceCollision = false, groundCollision = true})
               tfm.exec.addPhysicObject(2, 800, 780, {type = groundTypeList, width = 1600, height = 40, friction = 0, restitution = 0.2, miceCollision = false, groundCollision = true})
            elseif maps == 7959078 then
               groundXPositions, groundYPositions = {200, 500, 800, 1100, 1400, 200, 500, 800, 1100, 1400, 200, 500, 800, 1100, 1400}, {150, 150, 150, 150, 150, 400, 400, 400, 400, 400, 650, 650, 650, 650, 650}
               for i = 1, 15 do
                  tfm.exec.addPhysicObject(i, groundXPositions[i], groundYPositions[i], {type = groundTypeList, width = 200, height = 40, friction = 0, restitution = 0.2, miceCollision = false, groundCollision = true})
               end
            end
         elseif groundTypeList == 14 then -- The floor is sheep event
            secondTimer = -8
            ui.updateTextArea(1, "<p align='center'><font size='50' color='#DEC6AD'>THE FLOOR IS SHEEP</font></p>", nil, 0, 100, 800, 60, 0x000000, 0, 1, true)
            if maps == 7959077 then
               tfm.exec.addPhysicObject(1, 800, 295, {type = groundTypeList, width = 1600, height = 10, friction = 0.3, restitution = 0.2, miceCollision = false, groundCollision = true})
               tfm.exec.addPhysicObject(2, 800, 795, {type = groundTypeList, width = 1600, height = 10, friction = 0.3, restitution = 0.2, miceCollision = false, groundCollision = true})
               for i = 1, #shamanObjectCount1 do
                  xPositions, yPositions = {20, 50, 80, 110, 140, 170, 200, 230, 260, 290, 320, 350, 380, 410, 440, 470, 500, 530, 560, 590, 620, 650, 680, 710, 740, 770, 800, 830, 860, 890, 920, 950, 980, 1010, 1040, 1070, 1100, 1130, 1160, 1190, 1220, 1250, 1280, 1310, 1340, 1370, 1400, 1430, 1460, 1490, 1520, 1550, 1580, 20, 50, 80, 110, 140, 170, 200, 230, 260, 290, 320, 350, 380, 410, 440, 470, 500, 530, 560, 590, 620, 650, 680, 710, 740, 770, 800, 830, 860, 890, 920, 950, 980, 1010, 1040, 1070, 1100, 1130, 1160, 1190, 1220, 1250, 1280, 1310, 1340, 1370, 1400, 1430, 1460, 1490, 1520, 1550, 1580}, {280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775}
                  shamanObjectCount1[i] = tfm.exec.addShamanObject(40, xPositions[i], yPositions[i], 0, 0, 0, false)
               end
            elseif maps == 7959078 then
               groundXPositions, groundYPositions = {200, 500, 800, 1100, 1400, 200, 500, 800, 1100, 1400, 200, 500, 800, 1100, 1400}, {165, 165, 165, 165, 165, 415, 415, 415, 415, 415, 665, 665, 665, 665, 665}
               for i = 1, 15 do
                  tfm.exec.addPhysicObject(i, groundXPositions[i], groundYPositions[i], {type = groundTypeList, width = 200, height = 40, friction = 0.3, restitution = 0.2, miceCollision = false, groundCollision = true})
               end
               for i = 1, #shamanObjectCount2 do
                  xPositions, yPositions = {130, 165, 200, 235, 270, 430, 465, 500, 535, 570, 730, 765, 800, 835, 870, 1030, 1065, 1100, 1135, 1170, 1330, 1365, 1400, 1435, 1470, 130, 165, 200, 235, 270, 430, 465, 500, 535, 570, 730, 765, 800, 835, 870, 1030, 1065, 1100, 1135, 1170, 1330, 1365, 1400, 1435, 1470, 130, 165, 200, 235, 270, 430, 465, 500, 535, 570, 730, 765, 800, 835, 870, 1030, 1065, 1100, 1135, 1170, 1330, 1365, 1400, 1435, 1470}, {150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650}
                  shamanObjectCount2[i] = tfm.exec.addShamanObject(40, xPositions[i], yPositions[i], 0, 0, 0, false)
               end
            end
         elseif groundTypeList == 15 then -- The floor is cobweb event
            ui.updateTextArea(1, "<p align='center'><font size='50' color='#FFFFFF'>THE FLOOR IS COBWEB</font></p>", nil, 0, 100, 800, 60, 0x000000, 0, 1, true)
            if maps == 7959077 then
               tfm.exec.addPhysicObject(1, 800, 280, {type = groundTypeList, width = 1600, height = 40, friction = 0.3, restitution = 0.2, miceCollision = false, groundCollision = false})
               tfm.exec.addPhysicObject(2, 800, 780, {type = groundTypeList, width = 1600, height = 40, friction = 0.3, restitution = 0.2, miceCollision = false, groundCollision = false})
            elseif maps == 7959078 then
               groundXPositions, groundYPositions = {200, 500, 800, 1100, 1400, 200, 500, 800, 1100, 1400, 200, 500, 800, 1100, 1400}, {150, 150, 150, 150, 150, 400, 400, 400, 400, 400, 650, 650, 650, 650, 650}
               for i = 1, 15 do
                  tfm.exec.addPhysicObject(i, groundXPositions[i], groundYPositions[i], {type = groundTypeList, width = 200, height = 40, friction = 0.3, restitution = 0.2, miceCollision = false, groundCollision = false})
               end
            end
         elseif groundTypeList == 17 then -- The floor is cannonball event
            ui.updateTextArea(1, "<p align='center'><font size='50' color='#000001'>THE FLOOR IS CANNONBALL</font></p>", nil, 0, 100, 800, 60, 0x000000, 0, 1, true)
            tfm.exec.playSound("cite18/boule-acier.mp3", 100, nil, nil, nil)
            if maps == 7959077 then
               tfm.exec.addPhysicObject(1, 800, 295, {type = 14, width = 1600, height = 10, friction = 0.3, restitution = 0.2, miceCollision = false, groundCollision = false})
               tfm.exec.addPhysicObject(2, 800, 795, {type = 14, width = 1600, height = 10, friction = 0.3, restitution = 0.2, miceCollision = false, groundCollision = false})
               for i = 1, #shamanObjectCount1 do
                  xPositions, yPositions = {20, 50, 80, 110, 140, 170, 200, 230, 260, 290, 320, 350, 380, 410, 440, 470, 500, 530, 560, 590, 620, 650, 680, 710, 740, 770, 800, 830, 860, 890, 920, 950, 980, 1010, 1040, 1070, 1100, 1130, 1160, 1190, 1220, 1250, 1280, 1310, 1340, 1370, 1400, 1430, 1460, 1490, 1520, 1550, 1580, 20, 50, 80, 110, 140, 170, 200, 230, 260, 290, 320, 350, 380, 410, 440, 470, 500, 530, 560, 590, 620, 650, 680, 710, 740, 770, 800, 830, 860, 890, 920, 950, 980, 1010, 1040, 1070, 1100, 1130, 1160, 1190, 1220, 1250, 1280, 1310, 1340, 1370, 1400, 1430, 1460, 1490, 1520, 1550, 1580}, {280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775}
                  shamanObjectCount1[i] = tfm.exec.addShamanObject(17, xPositions[i], yPositions[i], 0, 0, 0, false)
               end
            elseif maps == 7959078 then
               groundXPositions, groundYPositions = {200, 500, 800, 1100, 1400, 200, 500, 800, 1100, 1400, 200, 500, 800, 1100, 1400}, {150, 150, 150, 150, 150, 400, 400, 400, 400, 400, 650, 650, 650, 650, 650}
               for i = 1, 15 do
                  tfm.exec.addPhysicObject(i, groundXPositions[i], groundYPositions[i], {type = 14, width = 200, height = 40, friction = 0.3, restitution = 0.2, miceCollision = false, groundCollision = false})
               end
               for i = 1, #shamanObjectCount2 do
                  xPositions, yPositions = {130, 165, 200, 235, 270, 430, 465, 500, 535, 570, 730, 765, 800, 835, 870, 1030, 1065, 1100, 1135, 1170, 1330, 1365, 1400, 1435, 1470, 130, 165, 200, 235, 270, 430, 465, 500, 535, 570, 730, 765, 800, 835, 870, 1030, 1065, 1100, 1135, 1170, 1330, 1365, 1400, 1435, 1470, 130, 165, 200, 235, 270, 430, 465, 500, 535, 570, 730, 765, 800, 835, 870, 1030, 1065, 1100, 1135, 1170, 1330, 1365, 1400, 1435, 1470}, {150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650}
                  shamanObjectCount2[i] = tfm.exec.addShamanObject(17, xPositions[i], yPositions[i], 0, 0, 0, false)
               end
            end
         elseif groundTypeList == 19 then -- The floor is acid event
            ui.updateTextArea(1, "<p align='center'><font size='50' color='#66FF00'>THE FLOOR IS ACID</font></p>", nil, 0, 100, 800, 60, 0x000000, 0, 1, true)
            if maps == 7959077 then
               tfm.exec.addPhysicObject(1, 800, 280, {type = groundTypeList, width = 1600, height = 40, friction = 0.3, restitution = 0.2, miceCollision = true, groundCollision = true})
               tfm.exec.addPhysicObject(2, 800, 780, {type = groundTypeList, width = 1600, height = 40, friction = 0.3, restitution = 0.2, miceCollision = true, groundCollision = true})
            elseif maps == 7959078 then
               groundXPositions, groundYPositions = {200, 500, 800, 1100, 1400, 200, 500, 800, 1100, 1400, 200, 500, 800, 1100, 1400}, {150, 150, 150, 150, 150, 400, 400, 400, 400, 400, 650, 650, 650, 650, 650}
               for i = 1, 15 do
                  tfm.exec.addPhysicObject(i, groundXPositions[i], groundYPositions[i], {type = groundTypeList, width = 200, height = 40, friction = 0.3, restitution = 0.2, miceCollision = true, groundCollision = true})
               end
            end
         elseif groundTypeList == 20 then -- The floor is honey event
            ui.updateTextArea(1, "<p align='center'><font size='50' color='#F0CE48'>THE FLOOR IS HONEY</font></p>", nil, 0, 100, 800, 60, 0x000000, 0, 1, true)
            tfm.exec.addPhysicObject(1, 800, 280, {type = groundTypeList, width = 1600, height = 40, friction = 0.3, restitution = 0, miceCollision = true, groundCollision = true, duration = 50000})
            tfm.exec.addPhysicObject(2, 800, 780, {type = groundTypeList, width = 1600, height = 40, friction = 0.3, restitution = 0, miceCollision = true, groundCollision = true, duration = 50000})
         elseif groundTypeList == 28 then -- The floor is balloon event
            secondTimer = -8
            ui.updateTextArea(1, "<p align='center'><font size='50' color='#31AFF1'>THE FLOOR IS BALLOON</font></p>", nil, 0, 100, 800, 60, 0x000000, 0, 1, true)
            if maps == 7959077 then
               tfm.exec.addPhysicObject(1, 800, 280, {type = 14, width = 1600, height = 40, friction = 0.3, restitution = 0.2, miceCollision = false, groundCollision = false})
               tfm.exec.addPhysicObject(2, 800, 780, {type = 14, width = 1600, height = 40, friction = 0.3, restitution = 0.2, miceCollision = false, groundCollision = false})
               for i = 1, #shamanObjectCount1 do
                  xPositions, yPositions = {20, 50, 80, 110, 140, 170, 200, 230, 260, 290, 320, 350, 380, 410, 440, 470, 500, 530, 560, 590, 620, 650, 680, 710, 740, 770, 800, 830, 860, 890, 920, 950, 980, 1010, 1040, 1070, 1100, 1130, 1160, 1190, 1220, 1250, 1280, 1310, 1340, 1370, 1400, 1430, 1460, 1490, 1520, 1550, 1580, 20, 50, 80, 110, 140, 170, 200, 230, 260, 290, 320, 350, 380, 410, 440, 470, 500, 530, 560, 590, 620, 650, 680, 710, 740, 770, 800, 830, 860, 890, 920, 950, 980, 1010, 1040, 1070, 1100, 1130, 1160, 1190, 1220, 1250, 1280, 1310, 1340, 1370, 1400, 1430, 1460, 1490, 1520, 1550, 1580}, {280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775}
                  shamanObjectCount1[i] = tfm.exec.addShamanObject(28, xPositions[i], yPositions[i], 0, 0, 0, false)
               end
            elseif maps == 7959078 then
               groundXPositions, groundYPositions = {200, 500, 800, 1100, 1400, 200, 500, 800, 1100, 1400, 200, 500, 800, 1100, 1400}, {150, 150, 150, 150, 150, 400, 400, 400, 400, 400, 650, 650, 650, 650, 650}
               for i = 1, 15 do
                  tfm.exec.addPhysicObject(i, groundXPositions[i], groundYPositions[i], {type = 14, width = 200, height = 40, friction = 0.3, restitution = 0.2, miceCollision = false, groundCollision = false})
               end
               for i = 1, #shamanObjectCount2 do
                  xPositions, yPositions = {130, 165, 200, 235, 270, 430, 465, 500, 535, 570, 730, 765, 800, 835, 870, 1030, 1065, 1100, 1135, 1170, 1330, 1365, 1400, 1435, 1470, 130, 165, 200, 235, 270, 430, 465, 500, 535, 570, 730, 765, 800, 835, 870, 1030, 1065, 1100, 1135, 1170, 1330, 1365, 1400, 1435, 1470, 130, 165, 200, 235, 270, 430, 465, 500, 535, 570, 730, 765, 800, 835, 870, 1030, 1065, 1100, 1135, 1170, 1330, 1365, 1400, 1435, 1470}, {150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650}
                  shamanObjectCount2[i] = tfm.exec.addShamanObject(28, xPositions[i], yPositions[i], 0, 0, 0, false)
               end
            end   
            balloon = 1 
            table.remove(randomFloor, 11 - transform)
            randomGround = randomGround - 1
         elseif groundTypeList == 32 then -- The floor is rune event
            ui.updateTextArea(1, "<p align='center'><font size='50' color='#00FFFF'>THE FLOOR IS RUNE</font></p>", nil, 0, 100, 800, 60, 0x000000, 0, 1, true)
            tfm.exec.playSound("cite18/np-esprit.mp3", 100, nil, nil, nil)
            if maps == 7959077 then
               tfm.exec.addPhysicObject(1, 800, 295, {type = 14, width = 1600, height = 40, friction = 0.3, restitution = 0.2, miceCollision = false, groundCollision = false})
               tfm.exec.addPhysicObject(2, 800, 795, {type = 14, width = 1600, height = 40, friction = 0.3, restitution = 0.2, miceCollision = false, groundCollision = false})
               for i = 1, #shamanObjectCount1 do
                  xPositions, yPositions = {20, 50, 80, 110, 140, 170, 200, 230, 260, 290, 320, 350, 380, 410, 440, 470, 500, 530, 560, 590, 620, 650, 680, 710, 740, 770, 800, 830, 860, 890, 920, 950, 980, 1010, 1040, 1070, 1100, 1130, 1160, 1190, 1220, 1250, 1280, 1310, 1340, 1370, 1400, 1430, 1460, 1490, 1520, 1550, 1580, 20, 50, 80, 110, 140, 170, 200, 230, 260, 290, 320, 350, 380, 410, 440, 470, 500, 530, 560, 590, 620, 650, 680, 710, 740, 770, 800, 830, 860, 890, 920, 950, 980, 1010, 1040, 1070, 1100, 1130, 1160, 1190, 1220, 1250, 1280, 1310, 1340, 1370, 1400, 1430, 1460, 1490, 1520, 1550, 1580}, {280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775}
                  shamanObjectCount1[i] = tfm.exec.addShamanObject(32, xPositions[i], yPositions[i], randomRuneAngle, 0, 0, true)
               end
            elseif maps == 7959078 then
               groundXPositions, groundYPositions = {200, 500, 800, 1100, 1400, 200, 500, 800, 1100, 1400, 200, 500, 800, 1100, 1400}, {150, 150, 150, 150, 150, 400, 400, 400, 400, 400, 650, 650, 650, 650, 650}
               for i = 1, 15 do
                  tfm.exec.addPhysicObject(i, groundXPositions[i], groundYPositions[i], {type = 14, width = 200, height = 40, friction = 0.3, restitution = 0.2, miceCollision = false, groundCollision = false})
               end
               for i = 1, #shamanObjectCount2 do
                  xPositions, yPositions = {130, 165, 200, 235, 270, 430, 465, 500, 535, 570, 730, 765, 800, 835, 870, 1030, 1065, 1100, 1135, 1170, 1330, 1365, 1400, 1435, 1470, 130, 165, 200, 235, 270, 430, 465, 500, 535, 570, 730, 765, 800, 835, 870, 1030, 1065, 1100, 1135, 1170, 1330, 1365, 1400, 1435, 1470, 130, 165, 200, 235, 270, 430, 465, 500, 535, 570, 730, 765, 800, 835, 870, 1030, 1065, 1100, 1135, 1170, 1330, 1365, 1400, 1435, 1470}, {150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650}
                  shamanObjectCount2[i] = tfm.exec.addShamanObject(32, xPositions[i], yPositions[i], randomRuneAngle, 0, 0, true)
               end
            end
            randomRuneAngle = {0, -180}
            randomRuneAngle = randomRuneAngle[math.random(2)]
         elseif groundTypeList == 40 then -- The floor is broken event
            ui.updateTextArea(1, "<p align='center'><font size='50' color='#FFFFFF'>THE FLOOR IS BROKEN?!</font></p>", nil, 0, 100, 800, 60, 0x000000, 0, 1, true)
            if maps == 7959077 then
               tfm.exec.addPhysicObject(1, 800, 280, {type = 6, width = 1600, height = 40, friction = 0.3, restitution = 0.2, miceCollision = true, groundCollision = true})
               tfm.exec.addPhysicObject(2, 800, 780, {type = 6, width = 1600, height = 40, friction = 0.3, restitution = 0.2, miceCollision = true, groundCollision = true})
            elseif maps == 7959078 then
               groundXPositions, groundYPositions = {200, 500, 800, 1100, 1400, 200, 500, 800, 1100, 1400, 200, 500, 800, 1100, 1400}, {150, 150, 150, 150, 150, 400, 400, 400, 400, 400, 650, 650, 650, 650, 650}
               for i = 1, 15 do
                  tfm.exec.addPhysicObject(i, groundXPositions[i], groundYPositions[i], {type = 6, width = 200, height = 40, friction = 0.3, restitution = 0.2, miceCollision = true, groundCollision = true})
               end
            end  
            table.remove(randomFloor, 13 - transform - balloon)
            randomGround = randomGround - 1
         elseif groundTypeList == 41 then -- The floor is nothing event
            secondTimer = -1.5
            ui.updateTextArea(1, "<p align='center'><font size='50' color='#FFFFFF'>THE FLOOR IS NOTHING!</font></p>", nil, 0, 100, 800, 60, 0x000000, 0, 1, true)
            if maps == 7959077 then
               tfm.exec.addPhysicObject(1, 800, 280, {type = 14, width = 1600, height = 40, friction = 0.3, restitution = 0.2, miceCollision = false, groundCollision = false})
               tfm.exec.addPhysicObject(2, 800, 780, {type = 14, width = 1600, height = 40, friction = 0.3, restitution = 0.2, miceCollision = false, groundCollision = false})
            elseif maps == 7959078 then
               groundXPositions, groundYPositions = {200, 500, 800, 1100, 1400, 200, 500, 800, 1100, 1400, 200, 500, 800, 1100, 1400}, {150, 150, 150, 150, 150, 400, 400, 400, 400, 400, 650, 650, 650, 650, 650}
               for i = 1, 15 do
                  tfm.exec.addPhysicObject(i, groundXPositions[i], groundYPositions[i], {type = 14, width = 200, height = 40, friction = 0.3, restitution = 0.2, miceCollision = false, groundCollision = false})
               end
            end
         elseif groundTypeList == 42 then -- The floor is space event
            secondTimer = -6
            ui.updateTextArea(1, "<p align='center'><font size='50' color='#FFFFFF'>THE FLOOR IS SPACE</font></p>", nil, 0, 100, 800, 60, 0x000000, 0, 1, true)
            if maps == 7959077 then
               tfm.exec.addPhysicObject(1, 800, 280, {type = 14, width = 1600, height = 40, friction = 0.3, restitution = 0.2, miceCollision = false, groundCollision = false})
               tfm.exec.addPhysicObject(2, 800, 780, {type = 14, width = 1600, height = 40, friction = 0.3, restitution = 0.2, miceCollision = false, groundCollision = false})
            elseif maps == 7959078 then
               groundXPositions, groundYPositions = {200, 500, 800, 1100, 1400, 200, 500, 800, 1100, 1400, 200, 500, 800, 1100, 1400}, {150, 150, 150, 150, 150, 400, 400, 400, 400, 400, 650, 650, 650, 650, 650}
               for i = 1, 15 do
                  tfm.exec.addPhysicObject(i, groundXPositions[i], groundYPositions[i], {type = 14, width = 200, height = 40, friction = 0.3, restitution = 0.2, miceCollision = false, groundCollision = false})
               end
            end
         tfm.exec.setWorldGravity(0, -1)
         elseif groundTypeList == 43 then -- The floor is stable rune event
            ui.updateTextArea(1, "<p align='center'><font size='50' color='#E68D43'>THE FLOOR IS STABLE RUNE</font></p>", nil, 0, 100, 800, 60, 0x000000, 0, 1, true)
            tfm.exec.playSound("cite18/np-esprit.mp3", 100, nil, nil, nil)
         if maps == 7959077 then
            tfm.exec.addPhysicObject(1, 800, 280, {type = 14, width = 1600, height = 40, friction = 0.3, restitution = 0.2, miceCollision = false, groundCollision = false})
            tfm.exec.addPhysicObject(2, 800, 780, {type = 14, width = 1600, height = 40, friction = 0.3, restitution = 0.2, miceCollision = false, groundCollision = false})
            for i = 1, #shamanObjectCount1 do
               xPositions, yPositions = {20, 50, 80, 110, 140, 170, 200, 230, 260, 290, 320, 350, 380, 410, 440, 470, 500, 530, 560, 590, 620, 650, 680, 710, 740, 770, 800, 830, 860, 890, 920, 950, 980, 1010, 1040, 1070, 1100, 1130, 1160, 1190, 1220, 1250, 1280, 1310, 1340, 1370, 1400, 1430, 1460, 1490, 1520, 1550, 1580, 20, 50, 80, 110, 140, 170, 200, 230, 260, 290, 320, 350, 380, 410, 440, 470, 500, 530, 560, 590, 620, 650, 680, 710, 740, 770, 800, 830, 860, 890, 920, 950, 980, 1010, 1040, 1070, 1100, 1130, 1160, 1190, 1220, 1250, 1280, 1310, 1340, 1370, 1400, 1430, 1460, 1490, 1520, 1550, 1580}, {280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 280, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775, 775}
               shamanObjectCount1[i] = tfm.exec.addShamanObject(62, xPositions[i], yPositions[i], randomRuneAngle, 0, 0, true)
            end
         elseif maps == 7959078 then
            groundXPositions, groundYPositions = {200, 500, 800, 1100, 1400, 200, 500, 800, 1100, 1400, 200, 500, 800, 1100, 1400}, {150, 150, 150, 150, 150, 400, 400, 400, 400, 400, 650, 650, 650, 650, 650}
            for i = 1, 15 do
                tfm.exec.addPhysicObject(i, groundXPositions[i], groundYPositions[i], {type = 14, width = 200, height = 40, friction = 0.3, restitution = 0.2, miceCollision = false, groundCollision = false})
            end
            for i = 1, #shamanObjectCount2 do
               xPositions, yPositions = {130, 165, 200, 235, 270, 430, 465, 500, 535, 570, 730, 765, 800, 835, 870, 1030, 1065, 1100, 1135, 1170, 1330, 1365, 1400, 1435, 1470, 130, 165, 200, 235, 270, 430, 465, 500, 535, 570, 730, 765, 800, 835, 870, 1030, 1065, 1100, 1135, 1170, 1330, 1365, 1400, 1435, 1470, 130, 165, 200, 235, 270, 430, 465, 500, 535, 570, 730, 765, 800, 835, 870, 1030, 1065, 1100, 1135, 1170, 1330, 1365, 1400, 1435, 1470}, {150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650}
               shamanObjectCount2[i] = tfm.exec.addShamanObject(62, xPositions[i], yPositions[i], randomRuneAngle, 0, 0, true)
            end
         end
         randomRuneAngle = {0, -180}
         randomRuneAngle = randomRuneAngle[math.random(2)]
         elseif groundTypeList == 44 then -- The floor is deathmatch event
            secondTimer = -10
            ui.updateTextArea(1, "<p align='center'><font size='50' color='#000001'>THE FLOOR IS DEATHMATCH</font></p>", nil, 0, 100, 800, 60, 0x000000, 0, 1, true)
            if maps == 7959077 then
               tfm.exec.addPhysicObject(1, 800, 280, {type = 14, width = 1600, height = 40, friction = 0.3, restitution = 0.2, miceCollision = false, groundCollision = false})
               tfm.exec.addPhysicObject(2, 800, 780, {type = 14, width = 1600, height = 40, friction = 0.3, restitution = 0.2, miceCollision = false, groundCollision = false})
               elseif maps == 7959078 then
               groundXPositions, groundYPositions = {200, 500, 800, 1100, 1400, 200, 500, 800, 1100, 1400, 200, 500, 800, 1100, 1400}, {150, 150, 150, 150, 150, 400, 400, 400, 400, 400, 650, 650, 650, 650, 650}
               for i = 1, 15 do
                  tfm.exec.addPhysicObject(i, groundXPositions[i], groundYPositions[i], {type = 14, width = 200, height = 40, friction = 0.3, restitution = 0.2, miceCollision = false, groundCollision = false})
               end
            end
         for name in next, tfm.get.room.playerList do
            if tfm.get.room.playerList[name].isDead == false then
               system.bindKeyboard(name, 3, true, true)
            end
         end
      end
   end
   --[[ For the floor is ice event ]]--
   if groundTypeList == 1 then
      if playerVictory == false then
         if timer == -4 then
            if maps == 7959077 then
               tfm.exec.addPhysicObject(1, 800, 280, {type = 9, width = 1600, height = 40, friction = 0, restitution = 0.2, miceCollision = false, groundCollision = true})
               tfm.exec.addPhysicObject(2, 800, 780, {type = 9, width = 1600, height = 40, friction = 0, restitution = 0.2, miceCollision = false, groundCollision = true})
            elseif maps == 7959078 then
               groundXPositions, groundYPositions = {200, 500, 800, 1100, 1400, 200, 500, 800, 1100, 1400, 200, 500, 800, 1100, 1400}, {150, 150, 150, 150, 150, 400, 400, 400, 400, 400, 650, 650, 650, 650, 650}
               for i = 1, 15 do
                  tfm.exec.addPhysicObject(i, groundXPositions[i], groundYPositions[i], {type = 9, width = 200, height = 40, friction = 0, restitution = 0.2, miceCollision = false, groundCollision = true})
               end
            end
         end
      end
   end   
   if groundTypeList == 44 then -- The floor is deathmatch event
      for name in next, tfm.get.room.playerList do
         if downKeyIsPressed[name] == true then
            shootTimer[name] = shootTimer[name] - 0.5
         end
         if shootTimer[name] == 0 then
            downKeyIsPressed[name] = false
            shootTimer[name] = 1
         end
      end
   end
   if timer == secondTimer and playerVictory == false then
      secondTimer = -4
      randomFloorEvent, randomFloorTimer = false, 2
      groundTypeList2 = {6}
      groundTypeList2 = groundTypeList2[math.random(1)]
      if maps == 7959077 then
         tfm.exec.addPhysicObject(1, 800, 280, {type = groundTypeList2, width = 1600, height = 40, friction = 0.3, restitution = 0.2, miceCollision = true, groundCollision = true})
         tfm.exec.addPhysicObject(2, 800, 780, {type = groundTypeList2, width = 1600, height = 40, friction = 0.3, restitution = 0.2, miceCollision = true, groundCollision = true})         tfm.exec.removeObject(shamanObject1)
         tfm.exec.removeObject(shamanObject2)
         tfm.exec.removeObject(shamanObject3)
         tfm.exec.removeObject(shamanObject4)
         tfm.exec.removeObject(shamanObject5)
         tfm.exec.removeObject(shamanObject6)
         tfm.exec.removeObject(shamanObject7)
         tfm.exec.removeObject(shamanObject8)
      elseif maps == 7959078 then
         groundXPositions, groundYPositions = {200, 500, 800, 1100, 1400, 200, 500, 800, 1100, 1400, 200, 500, 800, 1100, 1400}, {150, 150, 150, 150, 150, 400, 400, 400, 400, 400, 650, 650, 650, 650, 650}
         for i = 1, 15 do
            tfm.exec.addPhysicObject(i, groundXPositions[i], groundYPositions[i], {type = 6, width = 200, height = 40, friction = 0.3, restitution = 0.2, miceCollision = true, groundCollision = true})
         end
         tfm.exec.removeObject(shamanObject1)
         tfm.exec.removeObject(shamanObject2)
         tfm.exec.removeObject(shamanObject3)
         tfm.exec.removeObject(shamanObject4)
         tfm.exec.removeObject(shamanObject5)
         tfm.exec.removeObject(shamanObject6)
         tfm.exec.removeObject(shamanObject7)
         tfm.exec.removeObject(shamanObject8)
         tfm.exec.removeObject(shamanObject9)
         tfm.exec.removeObject(shamanObject10)
         tfm.exec.removeObject(shamanObject11)
         tfm.exec.removeObject(shamanObject12)
      end
      for i = 1, #shamanObjectCount1 do
         tfm.exec.removeObject(shamanObjectCount1[i])
      end
      for i = 1, #shamanObjectCount2 do
         tfm.exec.removeObject(shamanObjectCount2[i])
      end
      for i = 1, objectCount do
         tfm.exec.removeObject(object[i])
      end
      if groundTypeList == 1 then -- The floor is ice event
         for name in next, tfm.get.room.playerList do
            tfm.exec.freezePlayer(name, false)
         end
      end
      if groundTypeList == 44 then -- The floor is deathmatch event 
         for name in next, tfm.get.room.playerList do
            system.bindKeyboard(name, 3, true, false)
            downKeyIsPressed[name], shootTimer[name] = false, 1.5
         end 
      end
      tfm.exec.setWorldGravity(0, 10)      
      timer = 10.5
      tfm.exec.playSound("transformice/son/rebours.mp3", 100, nil, nil, nil)
      loopCount = loopCount + 1
      objectCount = 0
      ui.addTextArea(1, "<p align='center'><font size='50'>" .. math.floor(timer) .. "</font></p>", nil, 0, 50, 800, 60, 0x000000, 0, 1, true)
   end
   if timer2 == 0 then
      timer = 10.5
      tfm.exec.playSound("transformice/son/rebours.mp3", 100, nil, nil, nil)
      ui.addTextArea(1, "<p align='center'><font size='50'>" .. math.floor(timer) .. "</font></p>", nil, 0, 50, 800, 60, 0x000000, 0, 1, true)
      maps = {7959077, 7959078}
      maps = maps[math.random(2)]
      tfm.exec.newGame(maps)
   end
end

function eventPlayerDied(name)
   playerCount = playerCount - 1
   system.bindKeyboard(name, 3, true, false)
   if playerCount == 1 then
      for name in next, tfm.get.room.playerList do
         tfm.exec.giveCheese(name)
         tfm.exec.playerVictory(name)
         randomFloor, playerVictory = false, true
      end
   elseif playerCount == 0 then -- If it's draw
      randomFloor, playerVictory = false, true
      playerVictory = true
      ui.updateTextArea(1, "<p align='center'><font size='30' color='#FFFFFF'>GAME OVER!</font></p>", nil)
      ui.addTextArea(2, "<p align='center'><font size='30' color='#FFFF00'>Draw!</font></p>", nil, 0, 100, 800, 60, 0x000000, 0, 1, true)
   end
end

function eventPlayerWon(name)
   ui.updateTextArea(1, "<p align='center'><font size='30' color='#FFFFFF'>GAME OVER!</font></p>", nil)
   ui.addTextArea(2, "<p align='center'><font size='30' color='#FFFF00'>" .. name .. " has won the game</font></p>", nil, 0, 100, 800, 60, 0x000000, 0, 1, true)
   system.bindKeyboard(name, 3, true, false)
   if playerCount2 >= 11 then
      playerScore[name] = playerScore[name] + 1
      playerVictoryCount[name] = playerVictoryCount[name] + 1
   end
   tfm.exec.setPlayerScore(name, playerScore[name])
end
