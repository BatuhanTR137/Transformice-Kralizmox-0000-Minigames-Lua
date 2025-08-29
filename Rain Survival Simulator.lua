--[[ Rain Survival Simulator developed by Kralizmox#0000 ]]--
--[[ Last updated in 9 June 2025 ]]--

tfm.exec.disableAutoNewGame()
tfm.exec.disableAutoTimeLeft()
tfm.exec.disableAllShamanSkills()
tfm.exec.disablePhysicalConsumables()
tfm.exec.disableDebugCommand()

local playerScore, playerShaman, playerHp, playerHpBarWidth, randomDamagePlayer, playerColor, playerPickedColor, playerXPosition, playerYPosition, playerFreezeTimer, playerTouchedIce = {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}
local gameStarted, gameTimer, shamanDead = false, 185, false
local addGroundId1, addGroundId2, removeGroundId1, removeGroundId2 = 1, 20, 1, 20
local removeGroundTimer, windTimer, eventTimer, deteriorationTimer = 3, 10, 180, 5
local shamanObjectList, shamanObjectCount = {}, 0
local events, startEvent = {"Deterioration", "High gravity", "5x rain mass"}, false
local smallBoxCount, bigBoxCount, shortPlankCount, longPlankCount, ballCount, anvilCount = 0, 0, 0, 0, 0, 0
local trambolineMass, lavaMass, stoneMass, hailMass, acidMass, iceMass, cannonMass, anvilMass, armchairMass, couchMass, chairMass, tableMass, bedMass, toiletMass = 100, 100, 1000, 200, 100, 800, 2000, 5000, 1200, 2500, 300, 600, 3000, 900
local mapGravity = 10
local randomWindSpeed, randomEvent = 0, "None"
local iceRain = false
--local randomMusic = {}
local maps = {
--<C><P L="1600" H="800" F="8" DS="m;800,735" MEDATA=";;;;-0;0:::1-"/><Z><S><S T="6" X="800" Y="775" L="800" H="50" P="0,0,0.3,0.2,0,0,0,0"/><S T="12" X="800" Y="1200" L="1600" H="800" P="0,0,0.3,0.2,0,0,0,0" o="6A7495" c="4" N=""/><S T="13" X="0" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="200" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="400" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="600" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="800" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="1000" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="1200" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="1400" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="1600" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="12" X="800" Y="-400" L="1600" H="800" P="0,0,0.3,0.2,0,0,0,0" o="6A7495" c="3" N=""/><S T="12" X="-200" Y="400" L="400" H="2400" P="0,0,0,0,0,0,0,0" o="6A7495" N=""/><S T="12" X="1800" Y="400" L="400" H="2400" P="0,0,0,0,0,0,0,0" o="6A7495" N=""/></S><D><P X="150" Y="800" T="163" P="0,0"/><P X="1250" Y="800" T="163" P="0,1"/><P X="340" Y="800" T="163" P="0,0"/><P X="1450" Y="800" T="163" P="0,1"/><P X="60" Y="800" T="162" P="0,0"/><P X="1350" Y="800" T="162" P="0,1"/><P X="250" Y="800" T="162" P="0,0"/><P X="1540" Y="800" T="162" P="0,1"/><P X="500" Y="751" T="1" P="0,0"/><P X="1099" Y="750" T="1" P="0,1"/><P X="445" Y="750" T="5" P="0,0"/><P X="720" Y="750" T="183" P="0,0"/><P X="800" Y="750" T="183" P="0,0"/><P X="880" Y="750" T="183" P="0,0"/><P X="1155" Y="750" T="0" P="0,1"/><P X="600" Y="750" T="211" P="0,0"/><P X="990" Y="750" T="11" P="0,0"/><P X="1030" Y="750" T="11" P="0,0"/><P X="970" Y="750" T="3" P="0,1"/><P X="1010" Y="750" T="3" P="0,1"/></D><O/><L/></Z></C>
'<C><P L="1200" H="800" F="8" MEDATA=";;;;-0;0:::1-"/><Z><S><S T="6" X="600" Y="775" L="800" H="50" P="0,0,0.3,0.2,0,0,0,0"/><S T="12" X="600" Y="1200" L="1200" H="800" P="0,0,0.3,0.2,0,0,0,0" o="6A7495" c="4" N=""/><S T="13" X="0" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="200" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="400" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="600" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="800" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="1000" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="1200" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="12" X="600" Y="-400" L="1200" H="800" P="0,0,0.3,0.2,0,0,0,0" o="6A7495" c="3" N=""/><S T="12" X="-400" Y="400" L="800" H="2400" P="0,0,0,0,0,0,0,0" o="6A7495" c="3" N=""/><S T="12" X="1600" Y="400" L="800" H="2400" P="0,0,0,0,0,0,0,0" o="6A7495" c="3" N=""/></S><D><P X="300" Y="751" T="1" P="0,0"/><P X="899" Y="750" T="1" P="0,1"/><P X="245" Y="750" T="5" P="0,0"/><P X="520" Y="750" T="183" P="0,0"/><P X="600" Y="750" T="183" P="0,0"/><P X="680" Y="750" T="183" P="0,0"/><P X="955" Y="750" T="0" P="0,1"/><P X="400" Y="750" T="211" P="0,0"/><P X="790" Y="750" T="11" P="0,0"/><P X="830" Y="750" T="11" P="0,0"/><P X="770" Y="750" T="3" P="0,1"/><P X="810" Y="750" T="3" P="0,1"/><P X="150" Y="800" T="163" P="0,0"/><P X="1050" Y="800" T="163" P="0,1"/><P X="50" Y="800" T="162" P="0,0"/><P X="1150" Y="800" T="162" P="0,1"/><DS X="600" Y="735"/></D><O/><L/></Z></C>',
'<C><P L="1200" H="800" F="8" MEDATA=";;;;-0;0:::1-"/><Z><S><S T="12" X="800" Y="1200" L="1600" H="800" P="0,0,0.3,0.2,0,0,0,0" o="6A7495" c="4" N=""/><S T="13" X="0" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="200" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="400" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="600" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="800" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="1000" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="1200" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="12" X="800" Y="-400" L="1600" H="800" P="0,0,0.3,0.2,0,0,0,0" o="6A7495" c="3" N=""/><S T="12" X="-400" Y="400" L="800" H="2400" P="0,0,0,0,0,0,0,0" o="6A7495" c="3" N=""/><S T="12" X="1600" Y="400" L="800" H="2400" P="0,0,0,0,0,0,0,0" o="6A7495" c="3" N=""/><S T="10" X="600" Y="650" L="40" H="300" P="0,0,0.3,0,0,0,0,0"/><S T="10" X="200" Y="650" L="40" H="300" P="0,0,0.3,0,0,0,0,0"/><S T="10" X="1000" Y="650" L="40" H="300" P="0,0,0.3,0,0,0,0,0"/><S T="10" X="800" Y="680" L="40" H="240" P="0,0,0.3,0,0,0,0,0"/><S T="10" X="400" Y="680" L="40" H="240" P="0,0,0.3,0,0,0,0,0"/></S><D><P X="60" Y="800" T="162" P="0,0"/><P X="130" Y="800" T="162" P="0,0"/><P X="270" Y="800" T="162" P="0,0"/><P X="470" Y="800" T="162" P="0,0"/><P X="670" Y="800" T="162" P="0,1"/><P X="870" Y="800" T="162" P="0,1"/><P X="1080" Y="800" T="162" P="0,1"/><P X="330" Y="800" T="162" P="0,0"/><P X="530" Y="800" T="162" P="0,0"/><P X="730" Y="800" T="162" P="0,1"/><P X="930" Y="800" T="162" P="0,1"/><P X="1140" Y="800" T="162" P="0,1"/><DS X="600" Y="485"/></D><O/><L/></Z></C>',
'<C><P L="1200" H="800" F="8" MEDATA=";;;;-0;0:::1-"/><Z><S><S T="12" X="800" Y="1200" L="1600" H="800" P="0,0,0.3,0.2,0,0,0,0" o="6A7495" c="4" N=""/><S T="13" X="0" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="200" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="400" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="600" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="800" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="1000" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="1200" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="12" X="800" Y="-400" L="1600" H="800" P="0,0,0.3,0.2,0,0,0,0" o="6A7495" c="3" N=""/><S T="12" X="-400" Y="400" L="800" H="2400" P="0,0,0,0,0,0,0,0" o="6A7495" c="3" N=""/><S T="12" X="1600" Y="400" L="800" H="2400" P="0,0,0,0,0,0,0,0" o="6A7495" c="3" N=""/><S T="9" X="600" Y="700" L="1200" H="200" P="0,0,0,0,0,0,0,0"/><S T="12" X="600" Y="700" L="1200" H="200" P="0,0,0.3,0.2,0,0,0,0" o="419901" c="4"/><S T="19" X="600" Y="710" L="1200" H="180" P="0,0,0.3,0,0,0,0,0" c="3" m=""/><S T="7" X="600" Y="690" L="200" H="220" P="0,0,0.1,0.2,0,0,0,0"/><S T="7" X="100" Y="690" L="200" H="220" P="0,0,0.1,0.2,0,0,0,0"/><S T="7" X="1100" Y="690" L="200" H="220" P="0,0,0.1,0.2,0,0,0,0"/></S><D><P X="550" Y="580" T="7" P="0,0"/><P X="650" Y="580" T="7" P="0,1"/><P X="40" Y="580" T="8" P="0,0"/><P X="155" Y="580" T="10" P="0,0"/><P X="1045" Y="580" T="10" P="0,1"/><P X="155" Y="560" T="9" P="0,0"/><P X="1045" Y="560" T="9" P="0,1"/><P X="1160" Y="580" T="8" P="0,1"/><DS X="600" Y="565"/></D><O/><L/></Z></C>',
'<C><P L="1200" H="800" F="8" MEDATA=";;;;-0;0:::1-"/><Z><S><S T="12" X="800" Y="1200" L="1600" H="800" P="0,0,0.3,0.2,0,0,0,0" o="6A7495" c="4" N=""/><S T="13" X="0" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="200" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="400" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="600" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="800" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="1000" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="1200" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="12" X="800" Y="-400" L="1600" H="800" P="0,0,0.3,0.2,0,0,0,0" o="6A7495" c="3" N=""/><S T="12" X="-400" Y="400" L="800" H="2400" P="0,0,0,0,0,0,0,0" o="6A7495" c="3" N=""/><S T="12" X="1600" Y="400" L="800" H="2400" P="0,0,0,0,0,0,0,0" o="6A7495" c="3" N=""/><S T="13" X="600" Y="1130" L="600" P="0,0,0.3,0.2,0,0,0,0" o="EE0F0F"/><S T="13" X="600" Y="1140" L="600" P="0,0,0.3,0.2,0,0,0,0" o="EEA10F" c="3"/><S T="13" X="600" Y="1150" L="600" P="0,0,0.3,0.2,0,0,0,0" o="F7FF00" c="3"/><S T="13" X="600" Y="1160" L="600" P="0,0,0.3,0.2,0,0,0,0" o="00FF21" c="3"/><S T="13" X="600" Y="1170" L="600" P="0,0,0.3,0.2,0,0,0,0" o="00E8FF"/><S T="13" X="600" Y="1180" L="600" P="0,0,0.3,0.2,0,0,0,0" o="00E8FF" c="3"/><S T="13" X="600" Y="1180" L="600" P="0,0,0.3,0.2,0,0,0,0" o="0028FF" c="3"/><S T="13" X="600" Y="1190" L="600" P="0,0,0.3,0.2,0,0,0,0" o="6D00FF" c="3"/><S T="13" X="600" Y="1200" L="600" P="0,0,0.3,0.2,0,0,0,0" o="788186" c="3"/></S><D><P X="125" Y="790" T="156" P="1,0"/><P X="1075" Y="790" T="156" P="1,1"/><DS X="600" Y="515"/></D><O/><L/></Z></C>',
'<C><P L="1200" H="800" F="8" MEDATA=";;;;-0;0:::1-"/><Z><S><S T="13" X="0" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="200" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="400" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="600" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="800" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="1000" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="1200" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="12" X="800" Y="-400" L="1600" H="800" P="0,0,0.3,0.2,0,0,0,0" o="6A7495" c="3" N=""/><S T="1" X="600" Y="775" L="1200" H="50" P="0,0,0,0.2,0,0,0,0" N=""/><S T="12" X="800" Y="1200" L="1600" H="800" P="0,0,0.3,0.2,0,0,0,0" o="6A7495" c="4" N=""/><S T="12" X="-400" Y="400" L="800" H="2400" P="0,0,0,0,0,0,0,0" o="6A7495" c="3" N=""/><S T="12" X="1600" Y="400" L="800" H="2400" P="0,0,0,0,0,0,0,0" o="6A7495" c="3" N=""/></S><D><P X="600" Y="750" T="50" P="0,0"/><P X="500" Y="750" T="50" P="0,0"/><P X="700" Y="750" T="50" P="0,0"/><P X="130" Y="750" T="140" P="0,0"/><P X="300" Y="750" T="140" P="0,1"/><P X="450" Y="750" T="143" P="0,0"/><P X="750" Y="750" T="143" P="0,0"/><P X="900" Y="755" T="144" P="0,0"/><P X="1075" Y="755" T="144" P="0,0"/><DS X="600" Y="735"/></D><O/><L/></Z></C>',
'<C><P L="1200" H="800" F="8" MEDATA=";;;;-0;0:::1-"/><Z><S><S T="13" X="0" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="200" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="400" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="600" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="800" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="1000" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="1200" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="12" X="800" Y="-400" L="1600" H="800" P="0,0,0.3,0.2,0,0,0,0" o="6A7495" c="3" N=""/><S T="12" X="800" Y="1200" L="1600" H="800" P="0,0,0.3,0.2,0,0,0,0" o="6A7495" c="4" N=""/><S T="12" X="-400" Y="400" L="800" H="2400" P="0,0,0,0,0,0,0,0" o="6A7495" c="3" N=""/><S T="12" X="1600" Y="400" L="800" H="2400" P="0,0,0,0,0,0,0,0" o="6A7495" c="3" N=""/><S T="10" X="600" Y="840" L="600" H="600" P="0,0,0.3,0,45,0,0,0"/></S><D><DS X="600" Y="400"/></D><O/><L/></Z></C>',
'<C><P L="1200" H="800" F="8" MEDATA=";;;;-0;0:::1-"/><Z><S><S T="13" X="0" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="200" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="400" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="600" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="800" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="1000" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="1200" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="12" X="800" Y="-400" L="1600" H="800" P="0,0,0.3,0.2,0,0,0,0" o="6A7495" c="3" N=""/><S T="12" X="800" Y="1200" L="1600" H="800" P="0,0,0.3,0.2,0,0,0,0" o="6A7495" c="4" N=""/><S T="12" X="-400" Y="400" L="800" H="2400" P="0,0,0,0,0,0,0,0" o="6A7495" c="3" N=""/><S T="12" X="1600" Y="400" L="800" H="2400" P="0,0,0,0,0,0,0,0" o="6A7495" c="3" N=""/><S T="2" X="600" Y="775" L="1200" H="50" P="0,0,0.3,1,0,0,0,0"/></S><D><DS X="600" Y="735"/></D><O/><L/></Z></C>',
'<C><P L="1200" H="800" F="8" MEDATA=";;;;-0;0:::1-"/><Z><S><S T="12" X="800" Y="1200" L="1600" H="800" P="0,0,0.3,0.2,0,0,0,0" o="6A7495" c="4" N=""/><S T="13" X="0" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="200" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="400" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="600" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="800" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="1000" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="1200" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="12" X="800" Y="-400" L="1600" H="800" P="0,0,0.3,0.2,0,0,0,0" o="6A7495" c="3" N=""/><S T="12" X="-400" Y="400" L="800" H="2400" P="0,0,0,0,0,0,0,0" o="6A7495" c="3" N=""/><S T="12" X="1600" Y="400" L="800" H="2400" P="0,0,0,0,0,0,0,0" o="6A7495" c="3" N=""/><S T="10" X="200" Y="900" L="1000" H="400" P="0,0,0.3,0,45,0,0,0"/><S T="10" X="1000" Y="900" L="1000" H="400" P="0,0,0.3,0,-45,0,0,0"/><S T="10" X="600" Y="775" L="80" H="50" P="0,0,0.3,0,0,0,0,0"/></S><D><DS X="600" Y="735"/></D><O/><L/></Z></C>',
'<C><P L="1200" H="800" F="8" MEDATA=";;;;-0;0:::1-"/><Z><S><S T="12" X="800" Y="1200" L="1600" H="800" P="0,0,0.3,0.2,0,0,0,0" o="6A7495" c="4" N=""/><S T="13" X="0" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="200" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="400" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="600" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="800" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="1000" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="1200" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="12" X="800" Y="-400" L="1600" H="800" P="0,0,0.3,0.2,0,0,0,0" o="6A7495" c="3" N=""/><S T="12" X="-400" Y="400" L="800" H="2400" P="0,0,0,0,0,0,0,0" o="6A7495" c="3" N=""/><S T="12" X="1600" Y="400" L="800" H="2400" P="0,0,0,0,0,0,0,0" o="6A7495" c="3" N=""/><S T="10" X="600" Y="700" L="40" H="40" P="0,0,0.3,0,0,0,0,0"/></S><D><P X="65" Y="800" T="162" P="0,0"/><P X="305" Y="800" T="162" P="0,0"/><P X="120" Y="800" T="118" P="0,0"/><P X="240" Y="800" T="118" P="0,0"/><P X="360" Y="800" T="118" P="0,0"/><P X="480" Y="800" T="118" P="0,0"/><P X="600" Y="800" T="118" P="0,0"/><P X="720" Y="800" T="118" P="0,0"/><P X="840" Y="800" T="118" P="0,0"/><P X="960" Y="800" T="118" P="0,0"/><P X="1080" Y="800" T="118" P="0,0"/><P X="540" Y="800" T="162" P="0,0"/><P X="785" Y="800" T="162" P="0,1"/><P X="1025" Y="800" T="162" P="0,1"/><P X="180" Y="800" T="162" P="0,0"/><P X="420" Y="800" T="162" P="0,0"/><P X="660" Y="800" T="162" P="0,1"/><P X="900" Y="800" T="162" P="0,1"/><P X="1140" Y="800" T="162" P="0,1"/><P X="120" Y="800" T="163" P="0,0"/><P X="240" Y="800" T="163" P="0,0"/><P X="360" Y="800" T="163" P="0,0"/><P X="480" Y="800" T="163" P="0,0"/><P X="720" Y="800" T="163" P="0,1"/><P X="840" Y="800" T="163" P="0,1"/><P X="960" Y="800" T="163" P="0,1"/><P X="1080" Y="800" T="163" P="0,1"/><P X="60" Y="775" T="106" P="0,0"/><P X="180" Y="775" T="106" P="0,0"/><P X="300" Y="775" T="106" P="0,0"/><P X="420" Y="775" T="106" P="0,0"/><P X="540" Y="775" T="106" P="0,0"/><P X="660" Y="775" T="106" P="0,1"/><P X="780" Y="775" T="106" P="0,1"/><P X="900" Y="775" T="106" P="0,1"/><P X="1020" Y="775" T="106" P="0,1"/><P X="1140" Y="775" T="106" P="0,1"/><DS X="600" Y="665"/></D><O/><L/></Z></C>',
'<C><P L="1200" H="800" F="8" MEDATA=";;;;-0;0:::1-"/><Z><S><S T="12" X="800" Y="1200" L="1600" H="800" P="0,0,0.3,0.2,0,0,0,0" o="6A7495" c="4" N=""/><S T="13" X="0" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="200" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="400" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="600" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="800" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="1000" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="13" X="1200" Y="150" L="180" P="0,0,0.3,0.2,0,0,0,0" o="0F1011" c="4" N=""/><S T="12" X="800" Y="-400" L="1600" H="800" P="0,0,0.3,0.2,0,0,0,0" o="6A7495" c="3" N=""/><S T="12" X="-400" Y="400" L="800" H="2400" P="0,0,0,0,0,0,0,0" o="6A7495" c="3" N=""/><S T="12" X="1600" Y="400" L="800" H="2400" P="0,0,0,0,0,0,0,0" o="6A7495" c="3" N=""/><S T="9" X="600" Y="775" L="1200" H="50" P="0,0,0,0,0,0,0,0"/><S T="12" X="600" Y="775" L="1200" H="50" P="0,0,0.3,0.2,0,0,0,0" o="419901" c="4"/><S T="19" X="600" Y="785" L="1200" H="30" P="0,0,0.3,0,0,0,0,0" c="3" m=""/><S T="7" X="1000" Y="801" L="150" H="150" P="0,0,0.1,0.2,45,0,0,0"/><S T="7" X="600" Y="800" L="150" H="150" P="0,0,0.1,0.2,45,0,0,0"/><S T="7" X="200" Y="800" L="150" H="150" P="0,0,0.1,0.2,45,0,0,0"/></S><D><P X="160" Y="735" T="7" P="0,0"/><P X="560" Y="735" T="7" P="0,0"/><P X="960" Y="735" T="7" P="0,0"/><P X="240" Y="735" T="7" P="0,1"/><P X="640" Y="735" T="7" P="0,1"/><P X="1040" Y="735" T="7" P="0,1"/><DS X="600" Y="680"/></D><O/><L/></Z></C>'
}
local randomMap = maps[math.random(#maps)]
tfm.exec.newGame(randomMap)
tfm.exec.setGameTime(198)

function eventNewGame()
    gameStarted, gameTimer, shamanDead = false, 185, false
    addGroundId1, addGroundId2, removeGroundId1, removeGroundId2 = 1, 20, 1, 20
    removeGroundTimer, windTimer, eventTimer, deteriorationTimer = 3, 10, 180, 5
    shamanObjectList, shamanObjectCount = {}, 0
    events, startEvent = {"Deterioration", "High gravity", "5x rain mass"}, false
    smallBoxCount, bigBoxCount, shortPlankCount, longPlankCount, ballCount, anvilCount = 0, 0, 0, 0, 0, 0
    trambolineMass, lavaMass, stoneMass, hailMass, acidMass, iceMass, cannonMass, anvilMass, armchairMass, couchMass, chairMass, tableMass, bedMass, toiletMass = 100, 100, 1000, 200, 100, 800, 2000, 5000, 1250, 2500, 300, 600, 3000, 900
    mapGravity = 10
    randomWindSpeed, randomEvent = 0, "None"
    iceRain = false
    ui.setMapName("Rain Survival Simulator")
    for name in next, tfm.get.room.playerList do
        if tfm.get.room.playerList[name].isShaman then
            tfm.exec.chatMessage("<font color='#30BA76'>You are the shaman! Build a strong building to protect mices from dangerous rains!</font>", name)
            ui.addTextArea(8, "<font size='13' color='#FFFFFF'><font color='#98E2EB'>Shaman build limit</font>\n<font color='#D29E6C'>Small box:</font> " .. smallBoxCount .. "/8\n<font color='#D29E6C'>Big box:</font> " .. bigBoxCount .. "/8\n<font color='#D29E6C'>Short plank:</font> " .. shortPlankCount .. "/6\n<font color='#D29E6C'>Long plank:</font> " .. longPlankCount .. "/6\n<font color='#F4CD3A'>Ball:</font> " .. ballCount .. "/6\n<font color='#0D0D0D'>Anvil:</font> " .. anvilCount .. "/4</font>", nil, 5, 25, 130, 120, 0x808080, 0, 1, true)
            playerShaman[name] = true
            -- Make divine mode shaman
            if tfm.get.room.playerList[name].shamanMode < 2 then
                tfm.exec.setShamanMode(name, 2)
            end
        end
        playerHp[name], playerHpBarWidth[name], playerFreezeTimer[name], playerTouchedIce[name] = 100, 200, 1, false
        if playerPickedColor[name] == true then
            tfm.exec.setNameColor(name, playerColor[name])
        end
        ui.addTextArea(9, "", name, 300, 375, 200, 20, 0x808080, 0, 1, true)
        ui.addTextArea(2, "", name, 300, 375, playerHpBarWidth[name], 20, 0xE71717, 0, 1, true)
        ui.addTextArea(10, "<p align='center'><font size='16' color='#FFFFFF'>Health: 100/" .. math.floor(playerHp[name]) .. "</font></p>", name, 300, 375, 200, 20, 0x000000, 0, 1, true)
    end
    ui.addTextArea(1, "<p align='center'><font size='16' color='#FFFFFF'>Rain will start in " .. math.floor(gameTimer - 65) .." seconds</font></p>", nil, 0, 50, 800, 25, 0x000000, 0, 1, true)
    ui.addTextArea(3, "<p align='center'><font size='16' color='#FFFFFF'>Rain: <font color='#EF6262'>None</font></font></p>", nil, 0, 30, 800, 25, 0x000000, 0, 1, true)
    ui.addTextArea(5, "<p align='right'><font size='16' color='#A9B5BB'>Wind speed: 0</font></p>", nil, 0, 30, 800, 25, 0x000000, 0, 1, true)
    ui.addTextArea(6, "<p align='center'><font size='16' color='#E6EB14'>Random event will start in " .. math.floor(eventTimer - 30) .." seconds</font></p>", nil, 0, 70, 800, 25, 0x000000, 0, 1, true)
    ui.addTextArea(7, "<p align='right'><font size='16'><font color='#13ED29'>Event:</font> <font color='#EF6262'>None</font></font></p>", nil, 0, 50, 800, 25, 0x000000, 0, 1, true)
    tfm.exec.setWorldGravity(0, mapGravity)
end

function eventNewPlayer(name)
    if gameStarted == false then
        tfm.exec.respawnPlayer(name)
        playerHp[name], playerHpBarWidth[name], playerFreezeTimer[name], playerTouchedIce[name] = 100, 200, 1, false
        ui.addTextArea(9, "", name, 300, 375, 200, 20, 0x808080, 0, 1, true)
        ui.addTextArea(2, "", name, 300, 375, 200, 20, 0xE71717, 0, 1, true)
        ui.addTextArea(3, "<p align='center'><font size='16' color='#FFFFFF'>Rain: <font color='#EF6262'>None</font></font></p>", nil, 0, 30, 800, 25, 0x000000, 0, 1, true)
        ui.addTextArea(5, "<p align='right'><font size='16' color='#A9B5BB'>Wind speed: 0</font></p>", nil, 0, 30, 800, 25, 0x000000, 0, 1, true)
        ui.addTextArea(7, "<p align='right'><font size='16'><font color='#13ED29'>Event: </font><font color='#EF6262'>None</font></font></p>", nil, 0, 50, 800, 25, 0x000000, 0, 1, true)
        ui.addTextArea(10, "<p align='center'><font size='16' color='#FFFFFF'>Health: 100/" .. math.floor(playerHp[name]) .. "</font></p>", name, 300, 375, 200, 20, 0x000000, 0, 1, true)
    elseif gameStarted == true then
        ui.addTextArea(3, "<p align='center'><font size='16' color='#FFFFFF'>Rain: " .. randomRain .. "</font></p>", nil, 0, 30, 800, 25, 0x000000, 0, 1, true)
        ui.addTextArea(5, "<p align='right'><font size='16' color='#A9B5BB'>Wind speed: " .. randomWindSpeed .. "</font></p>", nil, 0, 30, 800, 25, 0x000000, 0, 1, true)
        ui.addTextArea(7, "<p align='right'><font size='16'><font color='#13ED29'>Event: </font><font color='#EF6262'>" .. randomEvent .. "</font></font></p>", nil, 0, 50, 800, 25, 0x000000, 0, 1, true)
    end
    ui.addTextArea(4, "<p align='center'><font size='13' color='#000000'><a href='event:test'>Change name color</a></font></p>", name, 655, 375, 140, 20, 0xEF9C0E, 0, 1, true)
    playerScore[name], playerShaman[name], playerPickedColor[name] = 0, false, false
    tfm.exec.setPlayerScore(name, playerScore[name])
    tfm.exec.chatMessage("<font color='#EDCC8D'>Welcome to Rain Survival Simulator. The goal is survive from dangerous rains!</font>\n<FC>Minigame was made by: Kralizmox#0000.</FC>", name)
    ui.addTextArea(8, "<font size='13' color='#FFFFFF'><font color='#98E2EB'>Shaman build limit</font>\n<font color='#D29E6C'>Small box:</font> " .. smallBoxCount .. "/8\n<font color='#D29E6C'>Big box:</font> " .. bigBoxCount .. "/8\n<font color='#D29E6C'>Short plank:</font> " .. shortPlankCount .. "/6\n<font color='#D29E6C'>Long plank:</font> " .. longPlankCount .. "/6\n<font color='#F4CD3A'>Ball:</font> " .. ballCount .. "/6\n<font color='#0D0D0D'>Anvil:</font> " .. anvilCount .. "/4</font>", nil, 5, 25, 130, 120, 0x808080, 0, 1, true)
    ui.setMapName("Rain Survival Simulator")
    -- Add music
    --[[musics = {"desert1", "desert2"}
    randomMusic[name] = musics[math.random(2)]
    if randomMusic[name] == "desert1" then
        tfm.exec.playMusic("cite18/musique/desert1.mp3", "music1", 100, false, true, name)
    elseif randomMusic[name] == "desert2" then
        tfm.exec.playMusic("cite18/musique/desert2.mp3", "music2", 100, false, true, name)
    end]]
end

for name in next, tfm.get.room.playerList do
    eventNewPlayer(name)
end

function eventTextAreaCallback(id, name, event)
    if id == 4 then
        ui.showColorPicker(1, name)
    end
end

function eventColorPicked(id, name, color)
    if id == 1 then
        playerColor[name] = color
        tfm.exec.setNameColor(name, playerColor[name])
        playerPickedColor[name] = true     
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

function setPlayerScore(name)
    playerScore[name] = playerScore[name]
    tfm.exec.setPlayerScore(name, playerScore[name])
end

function eventPlayerDied(name)
    if playerShaman[name] == false then
        playerScore[name] = playerScore[name] + 1
        tfm.exec.setPlayerScore(name, playerScore[name])
    else
        setPlayerScore(name)
    end
    playerHp[name], playerHpBarWidth[name] = 0, 0
    ui.removeTextArea(2, name)
    ui.addTextArea(10, "<p align='center'><font size='16' color='#FFFFFF'>Health: 100/" .. math.floor(playerHp[name]) .. "</font></p>", name, 300, 375, 200, 20, 0x000000, 0, 1, true)
    if tfm.get.room.playerList[name].isShaman then
        shamanDead = true
        eventTimer, gameTimer = -1, -1
        tfm.exec.setGameTime(5)
    end
    if shamanDead == false and checkDead() then
        eventTimer, gameTimer = -1, -1
        tfm.exec.setGameTime(5)
    end
end

function eventSummoningEnd(name, type, x, y, angle, description)
    -- For deterioration event
    if (type >= 1 and type <= 4) or type == 6 or type == 10 or (type >= 101 and type <= 200) or (type >= 201 and type <= 300) or (type >= 301 and type <= 400) or (type >= 401 and type <= 500) or (type >= 601 and type <= 700) or (type >= 1001 and type <= 1100) then
        shamanObjectCount = shamanObjectCount + 1
        shamanObjectList[shamanObjectCount] = description.id
        --print(shamanObjectList)
    end
    -- Shaman build limit
    if type == 1 or (type >= 101 and type <= 200) then -- Small box
        if smallBoxCount < 8 then
            smallBoxCount = smallBoxCount + 1
        elseif smallBoxCount >= 8 then
            tfm.exec.removeObject(description.id)
            tfm.exec.chatMessage("<font color='#CB546B'>You reached the limit of small box object!</font>", name)
        end
        ui.addTextArea(8, "<font size='13' color='#FFFFFF'><font color='#98E2EB'>Shaman build limit</font>\n<font color='#D29E6C'>Small box:</font> " .. smallBoxCount .. "/8\n<font color='#D29E6C'>Big box:</font> " .. bigBoxCount .. "/8\n<font color='#D29E6C'>Short plank:</font> " .. shortPlankCount .. "/6\n<font color='#D29E6C'>Long plank:</font> " .. longPlankCount .. "/6\n<font color='#F4CD3A'>Ball:</font> " .. ballCount .. "/6\n<font color='#0D0D0D'>Anvil:</font> " .. anvilCount .. "/4</font>", nil, 5, 25, 130, 120, 0x808080, 0, 1, true)
    elseif type == 2 or (type >= 201 and type <= 300) then -- Big box
        if bigBoxCount < 8 then
            bigBoxCount = bigBoxCount + 1
        elseif bigBoxCount >= 8 then
            tfm.exec.removeObject(description.id)
            tfm.exec.chatMessage("<font color='#CB546B'>You reached the limit of big box object!</font>", name)
        end
        ui.addTextArea(8, "<font size='13' color='#FFFFFF'><font color='#98E2EB'>Shaman build limit</font>\n<font color='#D29E6C'>Small box:</font> " .. smallBoxCount .. "/8\n<font color='#D29E6C'>Big box:</font> " .. bigBoxCount .. "/8\n<font color='#D29E6C'>Short plank:</font> " .. shortPlankCount .. "/6\n<font color='#D29E6C'>Long plank:</font> " .. longPlankCount .. "/6\n<font color='#F4CD3A'>Ball:</font> " .. ballCount .. "/6\n<font color='#0D0D0D'>Anvil:</font> " .. anvilCount .. "/4</font>", nil, 5, 25, 130, 120, 0x808080, 0, 1, true)
    elseif type == 3 or (type >= 301 and type <= 400) then -- Short plank
        if shortPlankCount < 6 then
            shortPlankCount = shortPlankCount + 1
        elseif shortPlankCount >= 6 then
            tfm.exec.removeObject(description.id)
            tfm.exec.chatMessage("<font color='#CB546B'>You reached the limit of short plank object!</font>", name)
        end
        ui.addTextArea(8, "<font size='13' color='#FFFFFF'><font color='#98E2EB'>Shaman build limit</font>\n<font color='#D29E6C'>Small box:</font> " .. smallBoxCount .. "/8\n<font color='#D29E6C'>Big box:</font> " .. bigBoxCount .. "/8\n<font color='#D29E6C'>Short plank:</font> " .. shortPlankCount .. "/6\n<font color='#D29E6C'>Long plank:</font> " .. longPlankCount .. "/6\n<font color='#F4CD3A'>Ball:</font> " .. ballCount .. "/6\n<font color='#0D0D0D'>Anvil:</font> " .. anvilCount .. "/4</font>", nil, 5, 25, 130, 120, 0x808080, 0, 1, true)
    elseif type == 4 or (type >= 401 and type <= 500) then -- Long plank
        if longPlankCount < 6 then
            longPlankCount = longPlankCount + 1
        elseif longPlankCount >= 6 then
            tfm.exec.removeObject(description.id)
            tfm.exec.chatMessage("<font color='#CB546B'>You reached the limit of long plank object!</font>", name)
        end
        ui.addTextArea(8, "<font size='13' color='#FFFFFF'><font color='#98E2EB'>Shaman build limit</font>\n<font color='#D29E6C'>Small box:</font> " .. smallBoxCount .. "/8\n<font color='#D29E6C'>Big box:</font> " .. bigBoxCount .. "/8\n<font color='#D29E6C'>Short plank:</font> " .. shortPlankCount .. "/6\n<font color='#D29E6C'>Long plank:</font> " .. longPlankCount .. "/6\n<font color='#F4CD3A'>Ball:</font> " .. ballCount .. "/6\n<font color='#0D0D0D'>Anvil:</font> " .. anvilCount .. "/4</font>", nil, 5, 25, 130, 120, 0x808080, 0, 1, true)
    elseif type == 6 or (type >= 601 and type <= 700) then -- Ball
        if ballCount < 6 then
            ballCount = ballCount + 1
        elseif ballCount >= 6 then
            tfm.exec.removeObject(description.id)
            tfm.exec.chatMessage("<font color='#CB546B'>You reached the limit of ball object!</font>", name)
        end
        ui.addTextArea(8, "<font size='13' color='#FFFFFF'><font color='#98E2EB'>Shaman build limit</font>\n<font color='#D29E6C'>Small box:</font> " .. smallBoxCount .. "/8\n<font color='#D29E6C'>Big box:</font> " .. bigBoxCount .. "/8\n<font color='#D29E6C'>Short plank:</font> " .. shortPlankCount .. "/6\n<font color='#D29E6C'>Long plank:</font> " .. longPlankCount .. "/6\n<font color='#F4CD3A'>Ball:</font> " .. ballCount .. "/6\n<font color='#0D0D0D'>Anvil:</font> " .. anvilCount .. "/4</font>", nil, 5, 25, 130, 120, 0x808080, 0, 1, true)
    elseif type == 10 or (type >= 1001 and type <= 1100) then -- Anvil
        if anvilCount < 4 then
            anvilCount = anvilCount + 1
        elseif anvilCount >= 4 then
            tfm.exec.removeObject(description.id)
            tfm.exec.chatMessage("<font color='#CB546B'>You reached the limit of anvil object!</font>", name)
        end
        ui.addTextArea(8, "<font size='13' color='#FFFFFF'><font color='#98E2EB'>Shaman build limit</font>\n<font color='#D29E6C'>Small box:</font> " .. smallBoxCount .. "/8\n<font color='#D29E6C'>Big box:</font> " .. bigBoxCount .. "/8\n<font color='#D29E6C'>Short plank:</font> " .. shortPlankCount .. "/6\n<font color='#D29E6C'>Long plank:</font> " .. longPlankCount .. "/6\n<font color='#F4CD3A'>Ball:</font> " .. ballCount .. "/6\n<font color='#0D0D0D'>Anvil:</font> " .. anvilCount .. "/4</font>", nil, 5, 25, 130, 120, 0x808080, 0, 1, true)
    end
    -- Ban some shaman objects
    if (type >= 17 and type <= 20) or (type >= 28 and type <= 31) or type == 32 or (type >= 1700 and type <= 1799) or (type >= 2800 and type <= 2899) then
        tfm.exec.removeObject(description.id)
    end
end

function eventLoop(a, b)
    -- Random events system
    eventTimer = eventTimer - 0.5
    if eventTimer > 30 and eventTimer < 180 then
        ui.addTextArea(6, "<p align='center'><font size='16' color='#E6EB14'>Random event will start in " .. math.floor(eventTimer - 30) .." seconds</font></p>", nil, 0, 70, 800, 25, 0x000000, 0, 1, true)
    elseif eventTimer == 30 then
        startEvent = true
        randomEvent = events[math.random(#events)]
        ui.addTextArea(7, "<p align='right'><font size='16'><font color='#13ED29'>Event: </font><font color='#EF6262'>" .. randomEvent .. "</font></font></p>", nil, 0, 50, 800, 25, 0x000000, 0, 1, true)
    elseif eventTimer > 0 and eventTimer < 30 then
        ui.addTextArea(6, "<p align='center'><font size='16' color='#E6EB14'>Event will finish in " .. math.floor(eventTimer) .." seconds</font></p>", nil, 0, 70, 800, 25, 0x000000, 0, 1, true)
    elseif eventTimer == 0 then
        startEvent = false
        ui.addTextArea(7, "<p align='right'><font size='16'><font color='#13ED29'>Event: </font><font color='#EF6262'>None</font></font></p>", nil, 0, 50, 800, 25, 0x000000, 0, 1, true)
        --eventTimer = 30
    end
    gameTimer = gameTimer - 0.5
    if gameTimer > 65 and gameTimer < 185 then
       ui.addTextArea(1, "<p align='center'><font size='16' color='#FFFFFF'>Rain will start in " .. math.floor(gameTimer - 65) .." seconds</font></p>", nil, 0, 50, 800, 25, 0x000000, 0, 1, true)
       --tfm.exec.playSound("transformice/son/rebours.mp3", 100)
    elseif gameTimer == 65 then
        gameStarted = true
        for name in next, tfm.get.room.playerList do
            tfm.exec.setShaman(name, false)
        end
        rains = {"<font color='#89A7F5'>Ice rain</font>", "<font color='#6D4E94'>Tramboline rain</font>", "<font color='#F59605'>Lava rain</font>", "<font color='#5E584B'>Stone rain</font>", "<font color='#000000'>Anvil rain</font>", "<font color='#C2E5F8'>Hail rain</font>", "<font color='#000000'>Cannon rain</font>", "<font color='#8CE82A'>Acid rain</font>", "<font color='#8A311B'>Armchair rain</font>", "<font color='#8A311B'>Couch rain</font>", "<font color='#5A3719'>Table rain</font>", "<font color='#46788E'>Bed rain</font>", "<font color='#E8E9EB'>Toilet rain</font>"}
        --rains = {"<font color='#8A311B'>Armchair rain</font>"}
        randomRain = rains[math.random(#rains)]
        ui.addTextArea(3, "<p align='center'><font size='16' color='#FFFFFF'>Rain: " .. randomRain .. "</font></p>", name, 0, 30, 800, 25, 0x000000, 0, 1, true)
    elseif gameTimer > 5 and gameTimer < 65 then
        ui.addTextArea(1, "<p align='center'><font size='16' color='#FFFFFF'>Rain will finish in " .. math.floor(gameTimer - 5) .." seconds</font></p>", nil, 0, 50, 800, 25, 0x000000, 0, 1, true)
        -- Add ground and remove ground system
        addGroundId1 = addGroundId1 + 20
        addGroundId2 = addGroundId2 + 20
        for i = addGroundId1, addGroundId2 do
            if randomRain == "<font color='#89A7F5'>Ice rain</font>" then
                tfm.exec.addPhysicObject(i, math.random(-200, 1400), math.random(-600, -200), {type = 1, width = 20, height = 20, dynamic = true, friction = 0, restitution = 0.2, mass = iceMass, contactListener = true})
                iceRain = true
            elseif randomRain == "<font color='#6D4E94'>Tramboline rain</font>" then
                tfm.exec.addPhysicObject(i, math.random(-200, 1400), math.random(-600, -200), {type = 2, width = 20, height = 20, dynamic = true, friction = 0, restitution = 1, mass = trambolineMass, contactListener = true})
            elseif randomRain == "<font color='#F59605'>Lava rain</font>" then
                tfm.exec.addPhysicObject(i, math.random(-200, 1400), math.random(-600, -200), {type = 3, width = 10, height = 15, dynamic = true, friction = 0, restitution = 1.2, mass = lavaMass, contactListener = true})
            elseif randomRain == "<font color='#5E584B'>Stone rain</font>" then
                tfm.exec.addPhysicObject(i, math.random(-200, 1400), math.random(-600, -200), {type = 10, width = 25, height = 25, dynamic = true, friction = 0.3, restitution = 0, mass = stoneMass, contactListener = true})
            elseif randomRain == "<font color='#C2E5F8'>Hail rain</font>" then
                tfm.exec.addPhysicObject(i, math.random(-200, 1400), math.random(-600, -200), {type = 13, width = 10, dynamic = true, color = 0xC2E5F8, friction = 0.3, restitution = 0.2, mass = hailMass, contactListener = true})
            elseif randomRain == "<font color='#8CE82A'>Acid rain</font>" then
                tfm.exec.addPhysicObject(i, math.random(-200, 1400), math.random(-600, -200), {type = 19, width = 10, height = 15, dynamic = true, friction = 0.3, restitution = 0, mass = acidMass, contactListener = true})
            elseif randomRain == "<font color='#000000'>Cannon rain</font>" then
                tfm.exec.addPhysicObject(i, math.random(-200, 1400), math.random(-600, -200), {type = 13, width = 15, dynamic = true, color = 0x000000, friction = 0.3, restitution = 0, mass = cannonMass, contactListener = true})
                tfm.exec.movePhysicObject(i, 0, 0, false, 0, 20, false)
                tfm.exec.addImage("1752b1c10bc.png", "+" .. i, 20, -15, nil, 1, 1, 1.67)
            elseif randomRain == "<font color='#000000'>Anvil rain</font>" then
                tfm.exec.addPhysicObject(i, math.random(-200, 1400), math.random(-600, -200), {type = 12, width = 30, height = 30, dynamic = true, color = 0x000000, friction = 0.3, restitution = 0, mass = anvilMass, contactListener = true})
                tfm.exec.addImage("1752b1b9497.png", "+" .. i, -25, -25)
            elseif randomRain == "<font color='#8A311B'>Armchair rain</font>" then
                tfm.exec.addPhysicObject(i, math.random(-200, 1400), math.random(-600, -200), {type = 12, width = 65, height = 20, dynamic = true, color = 0x8A311B, friction = 0.3, restitution = 0, mass = armchairMass, contactListener = true})
                tfm.exec.addImage("195e83c3406.png", "+" .. i, -35, -40, nil, 0.13, 0.13)
            elseif randomRain == "<font color='#8A311B'>Couch rain</font>" then
                tfm.exec.addPhysicObject(i, math.random(-200, 1400), math.random(-600, -200), {type = 12, width = 165, height = 20, dynamic = true, color = 0x8A311B, friction = 0.3, restitution = 0, mass = couchMass, contactListener = true})
                tfm.exec.addImage("195e83c6094.png", "+" .. i, -90, -45, nil, 0.13, 0.13)
            elseif randomRain == "<font color='#5A3719'>Chair rain</font>" then
                tfm.exec.addPhysicObject(i, math.random(-200, 1400), math.random(-600, -200), {type = 12, width = 35, height = 10, dynamic = true, color = 0x8A311B, friction = 0.3, restitution = 0, mass = chairMass, contactListener = true})
            elseif randomRain == "<font color='#5A3719'>Table rain</font>" then
                tfm.exec.addPhysicObject(i, math.random(-200, 1400), math.random(-600, -200), {type = 12, width = 115, height = 10, dynamic = true, color = 0x8A311B, friction = 0.3, restitution = 0, mass = tableMass, contactListener = true})
                tfm.exec.addImage("195e83cc117.png", "+" .. i, -60, -5, nil, 0.13, 0.13)
            elseif randomRain == "<font color='#46788E'>Bed rain</font>" then
                tfm.exec.addPhysicObject(i, math.random(-200, 1400), math.random(-600, -200), {type = 12, width = 120, height = 40, dynamic = true, color = 0x46788E, friction = 0.3, restitution = 1, mass = bedMass, contactListener = true})
                tfm.exec.addImage("195e83cf9a3.png", "+" .. i, -70, -50, nil, 0.28, 0.28)
            elseif randomRain == "<font color='#E8E9EB'>Toilet rain</font>" then
                tfm.exec.addPhysicObject(i, math.random(-200, 1400), math.random(-600, -200), {type = 12, width = 35, height = 10, dynamic = true, color = 0xE8E9EB, friction = 0.3, restitution = 0, mass = toiletMass, contactListener = true})
                tfm.exec.addImage("195e83c9769.png", "+" .. i, -20, -30, nil, 0.13, 0.13)
            end
        end
        if removeGroundTimer > 0 then
            removeGroundTimer = removeGroundTimer - 0.5
        elseif removeGroundTimer == 0 then
            removeGroundId1 = removeGroundId1 + 20
            removeGroundId2 = removeGroundId2 + 20
            for i = removeGroundId1, removeGroundId2 do
                tfm.exec.removePhysicObject(i)
            end
        end
        if startEvent == true then
            if randomEvent == "Deterioration" then
                deteriorationTimer = deteriorationTimer - 0.5
                if deteriorationTimer == 0 then
                    removeShamanObject = shamanObjectList[math.random(#shamanObjectList)]
                    tfm.exec.removeObject(removeShamanObject)                 
                    --for obj in next, tfm.get.room.objectList do
                        --if tfm.get.room.objectList[obj].type == 1 then
                            --print("Small box")
                        --elseif tfm.get.room.objectList[obj].type == 2 then
                            --print("Big box")
                        --end
                    --end
                    deteriorationTimer = 5
                end
            elseif randomEvent == "High gravity" then
                mapGravity = 20
            elseif randomEvent == "5x rain mass" then
                trambolineMass, lavaMass, stoneMass, hailMass, acidMass, iceMass, cannonMass, anvilMass, armchairMass, couchMass, chairMass, tableMass, bedMass, toiletMass = 500, 500, 5000, 1000, 500, 4000, 10000, 25000, 6250, 12500, 1500, 3000, 15000, 4500
            end
        end
        -- Wind system
        windTimer = windTimer - 0.5
        if windTimer == 0 then
            randomWindSpeed = math.random(-3, 3)
            tfm.exec.setWorldGravity(randomWindSpeed, mapGravity)
            for i = 1, 10 do
                tfm.exec.displayParticle(27, math.random(200, 1000), math.random(400, 600))
            end
            ui.addTextArea(5, "<p align='right'><font size='16' color='#A9B5BB'>Wind speed: " .. randomWindSpeed .. "</font></p>", nil, 0, 30, 800, 25, 0x000000, 0, 1, true)
            windTimer = 10
        end
    elseif gameTimer == 5 then
        for name in next, tfm.get.room.playerList do
            tfm.exec.giveCheese(name)
            tfm.exec.playerVictory(name)
        end
    end
    -- For ice rain
    if iceRain == true then
        for name in next, tfm.get.room.playerList do
            playerXPosition = tfm.get.room.playerList[name].x 
            playerYPosition = tfm.get.room.playerList[name].y
            if playerTouchedIce[name] == true then
                playerFreezeTimer[name] = playerFreezeTimer[name] - 0.5
                if playerFreezeTimer[name] == 0 then
                    tfm.exec.freezePlayer(name, false)
                    playerTouchedIce[name] = false
                end
            end
        end
    end
    if b <= 198 then
        for name in next, tfm.get.room.playerList do
            if playerShaman[name] == true then
                playerScore[name] = 0
                tfm.exec.setPlayerScore(name, playerScore[name])
                playerShaman[name] = false
            end
        end
        randomMap = maps[math.random(#maps)]
        tfm.exec.newGame(randomMap)
        tfm.exec.setGameTime(198)
    end
end

function damagePlayer(name)
    playerHp[name] = playerHp[name] - randomDamagePlayer[name]
    playerHpBarWidth[name] = playerHpBarWidth[name] - randomDamagePlayer[name] * 2
    ui.addTextArea(2, "", name, 300, 375, playerHpBarWidth[name], 20, 0xE71717, 0, 1, true)
    ui.addTextArea(10, "<p align='center'><font size='16' color='#FFFFFF'>Health: 100/" .. math.floor(playerHp[name]) .. "</font></p>", name, 300, 375, 200, 20, 0x000000, 0, 1, true)
    if playerHp[name] <= 0 then
        tfm.exec.killPlayer(name)
        playerHp[name] = 0
        --ui.updateTextArea(2, "<p align='center'><font size='16' color='#E71717'>Health: " .. math.floor(playerHp[name]) .. "</font></p>", name)
        ui.removeTextArea(2, name)
        ui.addTextArea(10, "<p align='center'><font size='16' color='#FFFFFF'>Health: 100/" .. math.floor(playerHp[name]) .. "</font></p>", name, 300, 375, 200, 20, 0x000000, 0, 1, true)
        if iceRain == true then
            tfm.exec.addShamanObject(54, playerXPosition, playerYPosition)
            tfm.exec.chatMessage("<font color='#89A7F5'>You are got freezed, it's so cold!</font>", name)
        end
    end
end

function eventContactListener(name, id, info)
    if id >= 1 then
        if randomRain == "<font color='#89A7F5'>Ice rain</font>" then
            randomDamagePlayer[name] = math.random(4, 8)
            tfm.exec.freezePlayer(name, true)
            tfm.exec.playSound("transformice/son/gel.mp3", 100)
            playerFreezeTimer[name], playerTouchedIce[name] = 1, true
            damagePlayer(name)
        elseif randomRain == "<font color='#6D4E94'>Tramboline rain</font>" then
            randomDamagePlayer[name] = math.random(1, 2)
            damagePlayer(name)
        elseif randomRain == "<font color='#F59605'>Lava rain</font>" then
            randomDamagePlayer[name] = 10
            damagePlayer(name)
        elseif randomRain == "<font color='#5E584B'>Stone rain</font>" then
            randomDamagePlayer[name] = math.random(5, 9)
            damagePlayer(name)
        elseif randomRain == "<font color='#C2E5F8'>Hail rain</font>" then
            randomDamagePlayer[name] = math.random(1, 2)
            damagePlayer(name)
        elseif randomRain == "<font color='#8CE82A'>Acid rain</font>" then
            playerHp[name], playerHpBarWidth[name] = 0, 0            
            ui.addTextArea(2, "", name, 300, 375, playerHpBarWidth[name], 20, 0xE71717, 0, 1, true)
            ui.addTextArea(10, "<p align='center'><font size='16' color='#FFFFFF'>Health: 100/" .. math.floor(playerHp[name]) .. "</font></p>", name, 300, 375, 200, 20, 0x000000, 0, 1, true)
        elseif randomRain == "<font color='#000000'>Cannon rain</font>" then
            randomDamagePlayer[name] = math.random(10, 15)
            damagePlayer(name)
        elseif randomRain == "<font color='#000000'>Anvil rain</font>" then
            randomDamagePlayer[name] = math.random(15, 20)
            damagePlayer(name)
        elseif randomRain == "<font color='#8A311B'>Armchair rain</font>" then
            randomDamagePlayer[name] = math.random(5, 10)
            damagePlayer(name)
        elseif randomRain == "<font color='#8A311B'>Couch rain</font>" then
            randomDamagePlayer[name] = math.random(10, 20)
            damagePlayer(name)
        elseif randomRain == "<font color='#5A3719'>Chair rain</font>" then
            randomDamagePlayer[name] = math.random(3, 4)
            damagePlayer(name)
        elseif randomRain == "<font color='#5A3719'>Table rain</font>" then
            randomDamagePlayer[name] = math.random(4, 5)
            damagePlayer(name)
        elseif randomRain == "<font color='#46788E'>Bed rain</font>" then
            randomDamagePlayer[name] = math.random(8, 10)
            damagePlayer(name) 
        elseif randomRain == "<font color='#E8E9EB'>Toilet rain</font>" then
            randomDamagePlayer[name] = math.random(5, 6)
            damagePlayer(name) 
        end
    end
end

function eventPlayerWon(name)
    if playerShaman[name] == false then
        playerScore[name] = playerScore[name] + 10
        tfm.exec.setPlayerScore(name, playerScore[name])
    else 
        setPlayerScore(name)
    end
end
