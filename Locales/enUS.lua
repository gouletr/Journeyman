local addonName, addon = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "enUS", true, true)
--if not L then return end

L["AUTO_SET_WAYPOINT"] = "Auto Set Waypoint Arrow"
L["AUTO_SET_WAYPOINT_DESC"] = "Automatically set TomTom waypoint arrow to next step."
L["AUTO_SET_WAYPOINT_MIN"] = "Minimum Distance"
L["AUTO_SET_WAYPOINT_MIN_DESC"] = "Minimum distance to automatically set TomTom waypoint arrow."
L["AUTO_SCROLL"] = "Auto Scroll"
L["AUTO_SCROLL_DESC"] = "Automatically scroll the window to the current step."
L["CHAPTER_INDEX_LABEL"] = "Chapter Index"
L["CHAPTER_TITLE"] = "Chapter %d: %s"
L["CHAPTER_TITLE_LABEL"] = "Chapter Title"
L["CLAMP_WINDOW"] = "Clamp Window"
L["CLAMP_WINDOW_DESC"] = "Prevent window from moving outside the screen."
L["COPY_CHAPTER"] = "Copy Chapter"
L["COPY_TEXT_BELOW"] = "Copy text below"
L["CREATE_NEW_JOURNEY"] = "Create New Journey"
L["CREATE_NEW_JOURNEY_DESC"] = "Create a new journey, make it active and open it in the journey editor."
L["DEBUGGING_OPTIONS"] = "Debugging Options"
L["DELETE_CHAPTER"] = "Delete Chapter"
L["DELETE_JOURNEY"] = "Delete Journey"
L["DELETE_STEP"] = "Delete Step"
L["DIE_AND_SPIRIT_RES"] = "You can choose to die now and use spirit healer service."
L["DROPDOWN_ACCEPT_QUEST"] = "Accept Quest"
L["DROPDOWN_BIND_HEARTHSTONE"] = "Bind Hearthstone"
L["DROPDOWN_COMPLETE_QUEST"] = "Complete Quest"
L["DROPDOWN_FLY_TO"] = "Fly To"
L["DROPDOWN_LEARN_FLIGHT_PATH"] = "Learn Flight Path"
L["DROPDOWN_REACH_LEVEL"] = "Reach Level"
L["DROPDOWN_TURNIN_QUEST"] = "Turn-in Quest"
L["DROPDOWN_USE_HEARTHSTONE"] = "Use Hearthstone"
L["ENABLE_DEBUG"] = "Enable Debug"
L["ENABLE_DEBUG_DESC"] = "Toggle debugging mode."
L["ENABLE_DEBUG_TEXT"] = "This option controls whether debugging information and tools are enabled or not. This can add a lot of messages to the console, and shouldn't be necessary unless there are problems."
L["EXPORT_JOURNEY"] = "Export Journey"
L["EXPORT_JOURNEY_DESC"] = "Export journey to string."
L["FONT_SIZE"] = "Font Size"
L["FONT_SIZE_DESC"] = "Font size used in the window."
L["IMPORT_JOURNEY"] = "Import Journey"
L["IMPORT_JOURNEY_DESC"] = "Import journey from string."
L["INDENT_SIZE"] = "Indentation Size"
L["INDENT_SIZE_DESC"] = "Size of the text indentation in the window."
L["INVALID_JOURNEY"] = "Invalid journey"
L["JOURNEY_INDEX_LABEL"] = "Journey Index"
L["JOURNEY_OPTIONS"] = "Journey Options"
L["JOURNEY_TITLE_LABEL"] = "Journey Title"
L["LINE_SPACING"] = "Line Spacing"
L["LINE_SPACING_DESC"] = "Space between lines of text in the window."
L["LOCK_WINDOW"] = "Lock Window"
L["LOCK_WINDOW_DESC"] = "Toggle window lock to prevent moving or resizing."
L["MISSING_CHAPTER_TITLE"] = "No Chapter"
L["NEW_CHAPTER"] = "New Chapter"
L["NEW_CHAPTER_TITLE"] = "New Chapter"
L["NEW_JOURNEY"] = "New Journey"
L["NEW_JOURNEY_TITLE"] = "New Journey"
L["NEW_STEP"] = "New Step"
L["NOT_A_NUMBER"] = "Not a Number"
L["NOT_A_STRING"] = "Not a String"
L["NO_JOURNEY_SELECTED"] = "No journey selected, please select a journey to continue."
L["NO_VALUE"] = "No Value"
L["OPEN_OPTIONS"] = "Open Options"
L["PASTE_CHAPTER"] = "Paste Chapter"
L["PASTE_TEXT_BELOW"] = "Paste text below"
L["RESET_POSITION"] = "Reset Position"
L["RESET_POSITION_DESC"] = "Reset the window position."
L["SAVED_PER_CHARACTER"] = "Saved per character."
L["SELECT_CHAPTER"] = "Select Chapter"
L["SELECT_JOURNEY"] = "Select Journey"
L["SELECT_JOURNEY_DESC"] = "Select which journey to use."
L["SELECT_STEP"] = "Select Step"
L["SHOW_COMPLETED_STEPS"] = "Show Completed Steps"
L["SHOW_COMPLETED_STEPS_DESC"] = "Toggle showing completed steps."
L["SHOW_QUEST_LEVEL"] = "Show Quest Level"
L["SHOW_QUEST_LEVEL_DESC"] = "Toggle showing quest level."
L["SHOW_SCROLL_BAR"] = "Show Scroll Bar"
L["SHOW_SCROLL_BAR_DESC"] = "Toggle showing scroll bar next to the window."
L["SHOW_SKIPPED_STEPS"] = "Show Skipped Steps"
L["SHOW_SKIPPED_STEPS_DESC"] = "Toggle showing skipped steps."
L["SHOW_WINDOW"] = "Show Window"
L["SHOW_WINDOW_DESC"] = "Toggle showing window."
L["STEPS_SHOWN"] = "Number of Steps"
L["STEPS_SHOWN_DESC"] = "Number of steps shown in the window."
L["STEP_ACCEPT_QUEST"] = "Accept %s"
L["STEP_BIND_HEARTHSTONE"] = "Bind %s to %s"
L["STEP_COMPLETE_QUEST"] = "Complete %s"
L["STEP_DATA_LABEL"] = "Step Data"
L["STEP_FLY_TO"] = "Fly to %s"
L["STEP_GO_TALK_TO"] = "Go talk to"
L["STEP_GO_TO"] = "Go to"
L["STEP_INDEX_LABEL"] = "Step Index"
L["STEP_LEARN_FLIGHT_PATH"] = "Learn flight path to %s"
L["STEP_NOTE"] = "Note: %s"
L["STEP_NOTE_LABEL"] = "Step Note"
L["STEP_REACH_LEVEL"] = "Reach level %s"
L["STEP_TURNIN_QUEST"] = "Turn-in %s"
L["STEP_TYPE_LABEL"] = "Step Type"
L["STEP_USE_HEARTHSTONE"] = "Use %s to %s"
L["UNDEFINED"] = "Undefined"
L["UPDATE_ACTIVE_JOURNEY"] = "Update Active Journey"
L["UPDATE_ACTIVE_JOURNEY_CONFIRM"] = "Enabling this option will add new steps to the active journey during your adventures, continue?"
L["UPDATE_ACTIVE_JOURNEY_DESC"] = "Update active journey with new steps."
L["UPDATE_ACTIVE_JOURNEY_DISABLED"] = "Option 'Update Active Journey' has been disabled for this character."
L["UPDATE_ACTIVE_JOURNEY_TEXT"] = "Enabling this option will cause new steps to be appended into the active journey chapter. Changing active journey will disable this option."
L["UPDATE_FREQUENCY"] = "Update Frequency (seconds)"
L["UPDATE_FREQUENCY_CONFIRM"] = "Changing this option requires a user interface reload, continue?"
L["UPDATE_FREQUENCY_DESC"] = "Period of time in seconds between each update check."
L["UPDATE_FREQUENCY_TEXT"] = "This option controls the frequency of updates. Decreasing the value will cause the addon to check more often if updates are needed. It is recommended not to change this value."
L["UPDATE_OPTIONS"] = "Update Options"
L["WINDOW_BG_COLOR"] = "Background Color"
L["WINDOW_BG_COLOR_DESC"] = "Background color of the window."
L["WINDOW_HEIGHT"] = "Height"
L["WINDOW_HEIGHT_DESC"] = "Height of the window."
L["WINDOW_LEVEL"] = "Level"
L["WINDOW_LEVEL_DESC"] = "Control the level (display order) of the window."
L["WINDOW_OPTIONS"] = "Window Options"
L["WINDOW_STRATA"] = "Strata"
L["WINDOW_STRATA_DESC"] = "Control the strata (display layer) of the window."
L["WINDOW_WIDTH"] = "Width"
L["WINDOW_WIDTH_DESC"] = "Width of the window."

-- Exported from https://wow.tools/dbc/?dbc=areatable&build=1.14.1.41030
local areaTableCSV = [[
ID,ZoneName,AreaName_lang,ContinentID,ParentAreaID,AreaBit,SoundProviderPref,SoundProviderPrefUnderwater,AmbienceID,UwAmbience,ZoneMusic,UwZoneMusic,ExplorationLevel,IntroSound,UwIntroSound,FactionGroupMask,Ambient_multiplier,MountFlags,PvpCombatWorldStateID,WildBattlePetLevelMin,WildBattlePetLevelMax,WindSettingsID,Flags[0],Flags[1],LiquidTypeID[0],LiquidTypeID[1],LiquidTypeID[2],LiquidTypeID[3]
1,DunMorogh,Dun Morogh,0,0,119,0,11,42,2172,8,0,0,0,0,2,0,0,-1,0,0,0,65,0,0,0,0,0
2,Longshore,Longshore,0,40,120,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3,Badlands,Badlands,0,0,121,0,11,25,2172,7,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
4,BlastedLands,Blasted Lands,0,0,122,0,11,210,2172,7,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
7,DarkwaterCove,Blackwater Cove,0,33,123,0,11,0,2172,3,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
8,SwampofSorrows,Swamp of Sorrows,0,0,124,0,11,33,2172,223,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
9,NorthshireValley,Northshire Valley,0,12,125,0,11,35,2172,1,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
10,Duskwood,Duskwood,0,0,617,0,11,40,2172,2,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
11,Wetlands,Wetlands,0,0,618,0,11,44,2172,227,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
12,ElwynnForest,Elwynn Forest,0,0,126,0,11,35,2172,1,0,0,0,0,2,0,0,-1,0,0,0,64,0,0,0,0,0
13,TheWorldTree,The World Tree,0,10,555,0,11,48,2172,11,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
14,Durotar,Durotar,1,0,127,0,11,25,2172,9,0,0,0,0,4,0,0,-1,0,0,0,64,0,0,0,0,0
15,DustwallowMarsh,Dustwallow Marsh,1,0,128,0,11,33,2172,227,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
16,Azshara,Azshara,1,0,129,0,11,31,2172,205,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
17,TheBarrens,The Barrens,1,0,130,0,11,38,2172,7,0,0,0,0,4,0,0,-1,0,0,0,64,0,0,0,0,0
18,CrystalLake,Crystal Lake,0,12,131,0,11,35,2172,1,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
19,Zul'Gurub,Zul'Gurub,0,33,574,0,11,32,2172,3,0,40,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
20,Moonbrook,Moonbrook,0,40,132,0,11,0,2172,9,0,14,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
21,KulTiras,Kul Tiras,0,0,133,0,11,0,2172,8,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
22,ProgrammerIsle,Programmer Isle,451,0,547,0,11,38,2172,2,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
23,NorthshireRiver,Northshire River,0,12,134,0,11,35,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
24,Northshireabbey,Northshire Abbey,0,12,135,73,11,35,2172,1,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
25,BlackrockMountain,Blackrock Mountain,0,0,136,0,11,46,2172,10,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
26,Lighthouse,Lighthouse,0,40,602,0,11,0,2172,7,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
28,WesternPlaguelands,Western Plaguelands,0,0,137,0,11,37,2172,205,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
30,Nine,Nine,0,0,138,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
32,TheCemetary,The Cemetary,0,10,139,0,11,0,2172,2,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
33,StranglethornJungle,Stranglethorn Vale,0,0,140,0,11,32,2172,3,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
34,EchoRidgeMine,Echo Ridge Mine,0,12,141,0,11,35,2172,1,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
35,BootyBay,Booty Bay,0,33,142,0,11,0,2172,3,0,42,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
36,AlteracMountains,Alterac Mountains,0,0,143,0,11,31,2172,1,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
37,LakeNazferiti,Lake Nazferiti,0,33,144,0,11,0,2172,3,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
38,LochModan,Loch Modan,0,0,145,0,11,31,2172,1,0,0,0,0,2,0,0,-1,0,0,0,64,0,0,0,0,0
40,Westfall,Westfall,0,0,146,0,11,47,2172,9,0,0,0,0,2,0,0,-1,0,0,0,64,0,0,0,0,0
41,DeadwindPass,Deadwind Pass,0,0,556,0,11,49,2172,2,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
42,Darkshire,Darkshire,0,10,147,0,11,0,2172,2,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
43,WildShore,Wild Shore,0,33,148,0,11,0,2172,3,0,42,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
44,RedridgeMountains,Redridge Mountains,0,0,149,0,11,31,2172,1,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
45,ArathiHighlands,Arathi Highlands,0,0,150,0,11,30,2172,8,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
46,BurningSteppes,Burning Steppes,0,0,151,0,11,46,2172,10,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
47,TheHinterlands,The Hinterlands,0,0,152,0,11,31,2172,1,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
49,DeadMansHole,Dead Man's Hole,0,22,153,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
51,SearingGorge,Searing Gorge,0,0,154,0,11,46,2172,10,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
53,ThievesCamp,Thieves Camp,0,12,155,0,11,35,2172,1,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
54,JasperlodeMine,Jasperlode Mine,0,12,550,0,11,35,2172,1,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
55,ValleyofHeroesUNUSED,Valley of Heroes UNUSED,0,12,156,0,11,35,2172,17,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
56,Heroes'Vigil,Heroes' Vigil,0,12,157,0,11,35,2172,1,0,0,303,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
57,FargodeepMine,Fargodeep Mine,0,12,158,0,11,35,2172,1,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
59,NorthshireVineyards,Northshire Vineyards,0,12,159,0,11,35,2172,1,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
60,Forest'sEdge,Forest's Edge,0,12,606,0,11,35,2172,1,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
61,ThunderFalls,Thunder Falls,0,12,160,0,11,35,2172,1,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
62,PumpkinPatch,Brackwell Pumpkin Patch,0,12,161,0,11,35,2172,1,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
63,TheStonefieldFarm,The Stonefield Farm,0,12,162,0,11,35,2172,1,0,6,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
64,TheMaclureVineyards,The Maclure Vineyards,0,12,163,0,11,35,2172,1,0,6,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
65,***On Map Dungeon***,***On Map Dungeon***,0,0,164,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,68,0,0,0,0,0
66,***On Map Dungeon***,***On Map Dungeon***,1,0,165,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,68,0,0,0,0,0
67,***On Map Dungeon***,***On Map Dungeon***,17,0,166,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,68,0,0,0,0,0
68,LakeEverstill,Lake Everstill,0,44,557,0,11,0,2172,1,0,16,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
69,Lakeshire,Lakeshire,0,44,167,0,11,0,2172,1,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
70,Stonewatch,Stonewatch,0,44,168,0,11,0,2172,1,0,24,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
71,StonewatchFalls,Stonewatch Falls,0,44,627,0,11,0,2172,1,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
72,TheDarkPortal,The Dark Portal,0,4,169,0,11,210,2172,7,0,63,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
73,TheTaintedScar,The Tainted Scar,0,4,170,0,11,0,2172,7,0,50,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
74,PoolofTears,Pool of Tears,0,8,171,0,11,0,2172,0,0,43,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
75,Stonard,Stonard,0,8,172,0,11,0,2172,0,0,37,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
76,FallowSanctuary,Fallow Sanctuary,0,8,173,0,11,0,2172,0,0,37,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
77,Anvilmar,Anvilmar,0,1,174,0,11,0,2172,8,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
80,StormwindMountains,Stormwind Mountains,0,12,175,0,11,35,2172,17,0,10,0,0,2,0,0,-1,0,0,0,1073741888,0,0,0,0,0
81,JeffNEQuadrantChanged,Jeff NE Quadrant Changed,451,22,575,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
82,JeffNWQuadrant,Jeff NW Quadrant,451,22,176,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
83,JeffSEQuadrant,Jeff SE Quadrant,451,22,177,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
84,JeffSWQuadrant,Jeff SW Quadrant,451,22,178,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
85,TirisfalGlades,Tirisfal Glades,0,0,179,0,11,40,2172,2,0,0,0,0,4,0,0,-1,0,0,0,64,0,0,0,0,0
86,StoneCircleLake,Stone Cairn Lake,0,12,180,0,11,35,2172,1,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
87,Goldshire,Goldshire,0,12,548,0,11,35,2172,1,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
88,EastvaleLoggingCamp,Eastvale Logging Camp,0,12,181,0,11,35,2172,1,0,6,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
89,ThunderFallsOrchard,Mirror Lake Orchard,0,12,182,0,11,35,2172,1,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
91,TowerofAzora,Tower of Azora,0,12,183,0,11,35,2172,1,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
92,MirrorLake,Mirror Lake,0,12,558,0,11,35,2172,1,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
93,Vul'GolOgreMound,Vul'Gol Ogre Mound,0,10,628,0,11,0,2172,214,0,28,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
94,RavenHill,Raven Hill,0,10,184,0,11,0,2172,2,0,24,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
95,RedridgeCanyon,Redridge Canyons,0,44,185,0,11,0,2172,1,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
96,TowerofIlgalar,Tower of Ilgalar,0,44,186,0,11,0,2172,1,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
97,Alther'sMill,Alther's Mill,0,44,187,0,11,0,2172,1,0,19,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
98,RethbanCaverns,Rethban Caverns,0,44,188,0,11,0,2172,1,0,17,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
99,RebelCamp,Rebel Camp,0,33,189,0,11,0,2172,3,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
100,Nesingwary'sExpedition,Nesingwary's Expedition,0,33,585,0,11,0,2172,3,0,31,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
101,Kurzen'sCompound,Kurzen's Compound,0,33,190,0,11,0,2172,3,0,32,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
102,RuinsofZul'Kunda,Ruins of Zul'Kunda,0,33,586,0,11,0,2172,3,0,41,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
103,RuinsofZul'Mamwe,Ruins of Zul'Mamwe,0,33,191,0,11,0,2172,3,0,40,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
104,TheVileReef,The Vile Reef,0,33,192,0,11,0,2172,3,0,37,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
105,Mosh'OggOgreMound,Mosh'Ogg Ogre Mound,0,33,193,0,11,0,2172,3,0,42,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
106,TheStockpile,The Stockpile,0,33,194,0,11,0,2172,3,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
107,Saldean'sFarm,Saldean's Farm,0,40,195,0,11,0,2172,9,0,14,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
108,SentinelHill,Sentinel Hill,0,40,196,0,11,0,2172,9,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
109,Furlbrow'sPumpkinFarm,Furlbrow's Pumpkin Farm,0,40,197,0,11,0,2172,9,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
111,JangolodeMine,Jangolode Mine,0,40,198,0,11,0,2172,9,0,12,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
113,GoldCoastQuarry,Gold Coast Quarry,0,40,576,0,11,0,2172,9,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
115,WestfallLighthouse,Westfall Lighthouse,0,40,199,0,11,24,2172,9,0,17,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
116,MistyValley,Misty Valley,0,8,200,0,11,0,2172,0,0,39,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
117,Grom'golBaseCamp,Grom'gol Base Camp,0,33,629,0,11,0,2172,228,0,35,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
118,Whelgar'sExcavationSite,Whelgar's Excavation Site,0,11,201,0,11,0,2172,191,0,22,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
120,WestbrookGarrison,Westbrook Garrison,0,12,559,0,11,35,2172,0,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
121,TranquilGardensCemetery,Tranquil Gardens Cemetery,0,10,202,0,11,0,2172,15,0,28,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
122,ZuuldaiaRuins,Zuuldaia Ruins,0,33,203,0,11,0,2172,3,0,37,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
123,Bal'lalRuins,Bal'lal Ruins,0,33,204,0,11,0,2172,3,0,34,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
125,Kal'aiRuins,Kal'ai Ruins,0,33,205,0,11,0,2172,3,0,35,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
126,TkashiRuins,Tkashi Ruins,0,33,206,0,11,0,2172,3,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
127,Balia'mahRuins,Balia'mah Ruins,0,33,207,0,11,0,2172,3,0,40,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
128,Ziata'jaiRuins,Ziata'jai Ruins,0,33,208,0,11,0,2172,3,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
129,MizjahRuins,Mizjah Ruins,0,33,209,0,11,0,2172,3,0,37,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
130,SilverpineForest,Silverpine Forest,0,0,210,0,11,28,2172,2,0,0,0,0,4,0,0,-1,0,0,0,64,0,0,0,0,0
131,Kharanos,Kharanos,0,1,211,0,11,0,2172,0,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
132,ColdridgeValley,Coldridge Valley,0,1,212,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
133,Gnomeregan,Gnomeregan,0,1,213,0,11,42,2172,8,0,10,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
134,Gol'BolarQuarry,Gol'Bolar Quarry,0,1,214,0,11,0,2172,8,0,10,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
135,FrostmaneHold,Frostmane Hold,0,1,215,0,11,0,2172,0,0,7,121,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
136,TheGrizzledDen,The Grizzled Den,0,1,216,0,11,0,2172,0,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
137,BrewnallVillage,Brewnall Village,0,1,217,0,11,0,2172,0,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
138,MistyPineRefuge,Misty Pine Refuge,0,1,218,0,11,0,2172,8,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
139,EasternPlaguelands,Eastern Plaguelands,0,0,219,0,11,37,2172,205,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
141,Teldrassil,Teldrassil,1,0,220,0,11,48,2172,11,0,0,0,0,2,0,0,-1,0,0,0,64,0,0,0,0,0
142,Ironband'sExcavationSite,Ironband's Excavation Site,0,38,221,0,11,0,2172,1,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
143,Mo'groshStronghold,Mo'grosh Stronghold,0,38,222,0,11,0,2172,14,0,18,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
144,Thelsamar,Thelsamar,0,38,223,0,11,0,2172,1,0,10,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
145,AlgazGate,Algaz Gate,0,38,224,0,11,0,2172,1,0,18,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
146,StonewroughtDam,Stonewrought Dam,0,38,225,0,11,230,2172,1,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
147,TheFarstriderLodge,The Farstrider Lodge,0,38,226,0,11,0,2172,1,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
148,Darkshore,Darkshore,1,0,227,0,11,28,2172,191,0,0,0,0,2,0,0,-1,0,0,0,64,0,0,0,0,0
149,SilverStreamMine,Silver Stream Mine,0,38,228,0,11,0,2172,1,0,12,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
150,MenethilHarbor,Menethil Harbor,0,11,229,0,11,0,2172,191,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
151,DesignerIsland,Designer Island,451,0,560,0,11,47,2172,226,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
152,TheBulwark,The Bulwark,0,85,230,0,11,0,2172,2,0,9,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
153,RuinsofLordaeron,Ruins of Lordaeron,0,85,607,0,11,0,2172,2,0,10,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
154,Deathknell,Deathknell,0,85,231,0,11,0,2172,15,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
155,NightWeb'sHollow,Night Web's Hollow,0,85,232,0,11,0,2172,2,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
156,SollidenFarmstead,Solliden Farmstead,0,85,233,0,11,0,2172,2,0,6,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
157,AgamandMills,Agamand Mills,0,85,234,0,11,0,2172,15,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
158,AgamandFamilyCrypt,Agamand Family Crypt,0,85,235,0,11,0,2172,15,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
159,Brill,Brill,0,85,236,0,11,0,2172,15,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
160,WhisperingGardens,Whispering Gardens,0,85,237,0,11,0,2172,2,0,12,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
161,TerraceofRepose,Terrace of Repose,0,85,238,0,11,0,2172,2,0,10,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
162,BrightwaterLake,Brightwater Lake,0,85,239,0,11,0,2172,2,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
163,Gunther'sRetreat,Gunther's Retreat,0,85,240,0,11,0,2172,2,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
164,Garren'sHaunt,Garren's Haunt,0,85,241,0,11,0,2172,2,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
165,BalnirFarmstead,Balnir Farmstead,0,85,242,0,11,0,2172,15,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
166,ColdHearthManor,Cold Hearth Manor,0,85,243,0,11,0,2172,2,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
167,CrusaderOutpost,Crusader Outpost,0,85,244,0,11,0,2172,2,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
168,TheNorthCoast,The North Coast,0,85,245,0,11,0,2172,2,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
169,Whispering Shore,Whispering Shore,0,85,577,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
170,LordamereLake,Lordamere Lake,0,0,246,0,11,31,2172,2,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
172,FenrisIsle,Fenris Isle,0,130,247,0,11,0,2172,2,0,18,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
173,Faol'sRest,Faol's Rest,0,85,620,0,11,0,2172,2,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
186,Dolanaar,Dolanaar,1,141,622,0,11,0,2172,11,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
187,DarnassusUNUSED,Darnassus UNUSED,1,141,248,0,11,48,2172,76,0,7,63,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
188,Shadowglen,Shadowglen,1,141,561,0,11,0,2172,11,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
189,Steelgrill'sDepot,Steelgrill's Depot,0,1,249,0,11,0,2172,8,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
190,Hearthglen,Hearthglen,0,28,250,0,11,0,2172,0,0,56,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
192,NorthridgeLumberCamp,Northridge Lumber Camp,0,28,251,0,11,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
193,RuinsofAndorhal,Ruins of Andorhal,0,28,252,0,11,0,2172,15,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
195,SchoolofNecromancy,School of Necromancy,0,28,253,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
196,Uther'sTomb,Uther's Tomb,0,28,578,0,11,0,2172,15,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
197,SorrowHill,Sorrow Hill,0,28,254,0,11,0,2172,0,0,50,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
198,TheWeepingCave,The Weeping Cave,0,28,255,0,11,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
199,FelstoneField,Felstone Field,0,28,256,0,11,0,2172,10,0,50,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
200,Dalson'sTears,Dalson's Tears,0,28,257,0,11,0,2172,10,0,54,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
201,Gahrron'sWithering,Gahrron's Withering,0,28,258,0,11,0,2172,10,0,57,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
202,TheWrithingHaunt,The Writhing Haunt,0,28,259,0,11,0,2172,10,0,46,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
203,MardenholdeKeep,Mardenholde Keep,0,28,260,0,11,37,2172,193,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
204,PyrewoodVillage,Pyrewood Village,0,130,261,0,11,0,2172,191,0,15,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
205,DunModr,Dun Modr,0,11,262,0,11,0,2172,191,0,28,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
206,Westfall,Westfall,36,0,263,0,11,47,2172,9,0,0,0,0,0,0,0,-1,0,0,0,65600,0,0,0,0,0
207,TheGreatSea,The Great Sea,36,0,264,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
208,UnusedIroncladcove,Unused Ironcladcove,36,0,265,76,11,34,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
209,ShadowfangKeep,Shadowfang Keep,33,0,266,0,11,28,2172,2,0,16,0,0,4,0,0,-1,0,0,0,0,0,0,0,0,0
210,***On Map Dungeon***,***On Map Dungeon***,36,0,267,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,68,0,0,0,0,0
211,IceflowLake,Iceflow Lake,0,1,268,0,11,0,2172,8,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
212,Helm'sBedLake,Helm's Bed Lake,0,1,269,0,11,0,2172,8,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
213,DeepElemMine,Deep Elem Mine,0,130,270,0,11,0,2172,2,0,13,324,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
214,TheGreatSea,The Great Sea,0,0,271,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
215,Mulgore,Mulgore,1,0,272,0,11,30,2172,9,0,0,0,0,4,0,0,-1,0,0,0,64,0,0,0,0,0
219,AlexstonFarmstead,Alexston Farmstead,0,40,273,0,11,0,2172,9,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
220,RedCloudMesa,Red Cloud Mesa,1,215,562,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
221,CampNarache,Camp Narache,1,215,274,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
222,BloodhoofVillage,Bloodhoof Village,1,215,275,0,11,0,2172,226,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
223,StonebullLake,Stonebull Lake,1,215,276,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
224,RavagedCaravan,Ravaged Caravan,1,215,277,0,11,0,2172,9,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
225,RedRocks,Red Rocks,1,215,278,0,11,0,2172,9,0,9,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
226,TheSkitteringDark,The Skittering Dark,0,130,551,0,11,0,2172,0,0,11,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
227,Valgan'sField,Valgan's Field,0,130,279,0,11,0,2172,2,0,11,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
228,TheSepulcher,The Sepulcher,0,130,280,0,11,0,2172,15,0,10,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
229,Olsen'sFarthing,Olsen's Farthing,0,130,281,0,11,0,2172,0,0,12,161,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
230,TheGreymaneWall,The Greymane Wall,0,130,282,0,11,0,2172,0,0,18,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
231,Beren'sPeril,Beren's Peril,0,130,283,0,11,0,2172,191,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
232,TheDawningIsles,The Dawning Isles,0,130,284,0,11,0,2172,2,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
233,Ambermill,Ambermill,0,130,285,0,11,0,2172,191,0,15,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
235,FenrisKeep,Fenris Keep,0,130,608,0,11,0,2172,219,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
236,Shadowfang Keep,Shadowfang Keep,0,130,286,0,11,28,2172,2,0,16,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
237,TheDecrepitFerry,The Decrepit Ferry,0,130,287,0,11,0,2172,2,0,16,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
238,Malden'sOrchard,Malden's Orchard,0,130,587,0,11,0,2172,2,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
239,TheIvarPatch,The Ivar Patch,0,130,588,0,11,0,2172,2,0,11,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
240,TheDeadField,The Dead Field,0,130,288,0,11,0,2172,2,0,12,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
241,TheRottingOrchard,The Rotting Orchard,0,10,289,0,11,0,2172,2,0,26,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
242,BrightwoodGrove,Brightwood Grove,0,10,290,0,11,0,2172,2,0,28,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
243,ForlornRowe,Forlorn Rowe,0,10,291,0,11,0,2172,2,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
244,TheWhippleEstate,The Whipple Estate,0,10,292,0,11,0,2172,2,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
245,TheYorgenFarmstead,The Yorgen Farmstead,0,10,563,0,11,0,2172,2,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
246,TheCauldron,The Cauldron,0,51,293,0,11,0,2172,10,0,48,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
247,GrimesiltDigSite,Grimesilt Dig Site,0,51,294,0,11,0,2172,0,0,45,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
249,DreadmaulRock,Dreadmaul Rock,0,46,1,0,11,0,2172,10,0,50,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
250,RuinsofThaurisan,Ruins of Thaurissan,0,46,579,0,11,0,2172,0,0,54,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
251,FlameCrest,Flame Crest,0,46,2,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
252,BlackrockStronghold,Blackrock Stronghold,0,46,3,0,11,0,2172,0,0,57,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
253,ThePillarofAsh,The Pillar of Ash,0,46,4,0,11,0,2172,0,0,56,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
254,BlackrockMountain,Blackrock Mountain,0,46,630,0,11,0,2172,10,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
255,AltarofStorms,Altar of Storms,0,46,5,0,11,0,2172,10,0,59,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
256,Aldrassil,Aldrassil,1,141,6,0,11,0,2172,11,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
257,ShadowthreadCave,Shadowthread Cave,1,141,7,0,11,0,2172,11,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
258,FelRock,Fel Rock,1,141,8,0,11,0,2172,11,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
259,LakeIl'Ameth,Lake Al'Ameth,1,141,9,0,11,0,2172,11,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
260,StarbreezeVillage,Starbreeze Village,1,141,10,0,11,0,2172,11,0,6,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
261,GnarlpineHold,Gnarlpine Hold,1,141,11,0,11,0,2172,0,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
262,Ban'ethilBarrowDen,Ban'ethil Barrow Den,1,141,12,0,11,0,2172,11,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
263,TheCleft,The Cleft,1,141,13,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
264,TheOracleGlade,The Oracle Glade,1,141,14,0,11,0,2172,11,0,9,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
265,WellspringRiver,Wellspring River,1,141,15,0,11,0,2172,0,0,11,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
266,WellspringLake,Wellspring Lake,1,141,16,0,11,0,2172,0,0,9,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
267,HillsbradFoothills,Hillsbrad Foothills,0,0,17,0,11,31,2172,1,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
268,AzsharaCrater,Azshara Crater,37,0,580,0,11,42,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
269,DunAlgaz,Dun Algaz,0,0,18,0,11,31,2172,0,0,18,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
271,Southshore,Southshore,0,267,615,0,11,0,2172,1,0,22,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
272,TarrenMill,Tarren Mill,0,267,19,0,11,0,2172,182,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
275,DurnholdeKeep,Durnholde Keep,0,267,20,0,11,0,2172,191,0,21,302,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
276,StonewroughtPass,UNUSED Stonewrought Pass,0,0,564,0,11,31,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
277,TheFoothillCaverns,The Foothill Caverns,0,36,21,0,11,0,2172,1,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
278,LordamereInternmentCamp,Lordamere Internment Camp,0,36,22,0,11,0,2172,1,0,32,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
279,Dalaran,Dalaran,0,36,23,0,11,0,2172,0,0,30,81,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
280,Strahnbrad,Strahnbrad,0,36,24,0,11,37,2172,10,0,34,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
281,RuinsofAlterac,Ruins of Alterac,0,36,25,0,11,37,2172,10,0,36,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
282,CrushridgeHold,Crushridge Hold,0,36,26,0,11,37,2172,10,0,35,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
283,SlaughterHollow,Slaughter Hollow,0,36,27,0,11,37,2172,10,0,35,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
284,TheUplands,The Uplands,0,36,28,0,11,0,2172,1,0,27,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
285,SouthpointTower,Southpoint Tower,0,267,29,0,11,0,2172,2,0,21,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
286,HillsbradFields,Hillsbrad Fields,0,267,30,0,11,0,2172,1,0,22,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
287,Hillsbrad,Hillsbrad,0,267,31,0,11,0,2172,1,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
288,AzurelodeMine,Azurelode Mine,0,267,32,0,11,0,2172,0,0,27,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
289,NethanderStead,Nethander Stead,0,267,33,0,11,0,2172,1,0,26,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
290,DunGarok,Dun Garok,0,267,34,0,11,0,2172,1,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
293,Thoradin'sWall,Thoradin's Wall,0,0,35,0,11,31,2172,1,0,30,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
294,EasternStrand,Eastern Strand,0,267,36,0,11,0,2172,1,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
295,WesternStrand,Western Strand,0,267,616,0,11,0,2172,1,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
296,SouthSeasUNUSED,South Seas UNUSED,0,0,37,0,11,24,2172,0,0,0,122,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
297,JagueroIsle,Jaguero Isle,0,33,38,0,11,0,2172,0,0,50,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
298,BaradinBay,Baradin Bay,0,11,39,0,11,0,2172,3,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
299,MenethilBay,Menethil Bay,0,11,40,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
300,MistyReedStrand,Misty Reed Strand,0,8,41,0,11,0,2172,0,0,41,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
301,TheSavageCoast,The Savage Coast,0,33,42,0,11,0,2172,3,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
302,TheCrystalShore,The Crystal Shore,0,33,565,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
303,ShellBeach,Shell Beach,0,33,43,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
305,NorthTide'sRun,North Tide's Run,0,130,44,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
306,SouthTide'sRun,South Tide's Run,0,130,45,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
307,TheOverlookCliffs,The Overlook Cliffs,0,47,46,0,11,0,2172,1,0,48,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
308,TheForbiddingSea,The Forbidding Sea,0,0,631,0,11,0,2172,1,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
309,Ironbeard'sTomb,Ironbeard's Tomb,0,11,47,0,11,0,2172,0,0,24,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
310,CrystalveinMine,Crystalvein Mine,0,33,48,0,11,0,2172,0,0,41,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
311,RuinsofAboraz,Ruins of Aboraz,0,33,589,0,11,0,2172,0,0,44,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
312,Janeiro'sPoint,Janeiro's Point,0,33,49,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
313,NorthfoldManor,Northfold Manor,0,45,632,0,11,0,2172,0,0,31,302,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
314,Go'ShekFarm,Go'Shek Farm,0,45,50,0,11,0,2172,0,0,33,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
315,Dabyrie'sFarmstead,Dabyrie's Farmstead,0,45,590,0,11,0,2172,0,0,31,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
316,BoulderfistHall,Boulderfist Hall,0,45,51,0,11,31,2172,0,0,35,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
317,WitherbarkVillage,Witherbark Village,0,45,609,0,11,0,2172,3,0,33,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
318,DrywhiskerGorge,Drywhisker Gorge,0,45,52,0,11,0,2172,0,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
320,RefugePointe,Refuge Pointe,0,45,53,0,11,0,2172,0,0,30,123,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
321,Hammerfall,Hammerfall,0,45,54,0,11,0,2172,14,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
322,BlackwaterShipwrecks,Blackwater Shipwrecks,0,45,581,0,11,0,2172,8,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
323,O'Breen'sCamp,O'Breen's Camp,0,45,55,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
324,StromgardeKeep,Stromgarde Keep,0,45,56,0,11,0,2172,186,0,36,182,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
325,TheTowerofArathor,The Tower of Arathor,0,45,57,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
326,TheSanctum,The Sanctum,0,45,58,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
327,Faldir'sCove,Faldir's Cove,0,45,59,0,11,0,2172,3,0,40,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
328,TheDrownedReef,The Drowned Reef,0,45,566,0,11,0,2172,192,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
330,ThandolSpan,Thandol Span,0,0,60,0,11,44,2172,3,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
331,Ashenvale,Ashenvale,1,0,61,0,11,48,2172,11,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
332,TheGreatSea,The Great Sea,1,0,62,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
333,CircleofEastBinding,Circle of East Binding,0,45,63,0,11,0,2172,0,0,38,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
334,CircleofWestBinding,Circle of West Binding,0,45,64,0,11,0,2172,0,0,38,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
335,CircleofInnerBinding,Circle of Inner Binding,0,45,65,0,11,0,2172,0,0,38,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
336,CircleofOuterBinding,Circle of Outer Binding,0,45,66,0,11,0,2172,0,0,38,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
337,Apocryphan'sRest,Apocryphan's Rest,0,3,67,0,11,25,2172,7,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
338,AngorFortress,Angor Fortress,0,3,633,0,11,25,2172,7,0,39,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
339,LethlorRavine,Lethlor Ravine,0,3,634,0,11,25,2172,0,0,45,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
340,Kargath,Kargath,0,3,68,0,11,25,2172,0,0,38,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
341,CampKosh,Camp Kosh,0,3,69,0,11,25,2172,0,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
342,CampBoff,Camp Boff,0,3,70,0,11,25,2172,0,0,39,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
343,CampWurg,Camp Wurg,0,3,71,0,11,25,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
344,CampCagg,Camp Cagg,0,3,72,0,11,25,2172,0,0,43,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
345,Agmond'sEnd,Agmond's End,0,3,73,0,11,25,2172,7,0,39,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
346,Hammertoe'sDigsite,Hammertoe's Digsite,0,3,74,0,11,25,2172,0,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
347,DustbelchGrotto,Dustbelch Grotto,0,3,75,0,11,25,2172,0,0,43,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
348,AeriePeak,Aerie Peak,0,47,76,0,11,0,2172,1,0,41,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
349,WildhammerKeep,Wildhammer Keep,0,47,77,0,11,0,2172,1,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
350,Quel'DanilLodge,Quel'Danil Lodge,0,47,78,0,11,0,2172,1,0,45,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
351,SkulkRock,Skulk Rock,0,47,79,0,11,0,2172,1,0,48,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
352,Zun'watha,Zun'watha,0,47,80,0,11,0,2172,1,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
353,Shadra'Alor,Shadra'Alor,0,47,81,0,11,0,2172,3,0,44,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
354,Jintha'Alor,Jintha'Alor,0,47,591,0,11,0,2172,227,0,45,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
355,TheAltarofZul,The Altar of Zul,0,47,592,0,11,0,2172,176,0,46,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
356,Seradane,Seradane,0,47,82,0,11,0,2172,76,0,41,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
357,Feralas,Feralas,1,0,83,0,11,48,2172,3,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
358,BramblebladeRavine,Brambleblade Ravine,1,215,84,0,11,25,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
359,BaelModan,Bael Modan,1,17,85,0,11,0,2172,7,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
360,TheVentureCo.Mine,The Venture Co. Mine,1,215,86,0,11,0,2172,9,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
361,Felwood,Felwood,1,0,87,0,11,28,2172,193,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
362,RazorHill,Razor Hill,1,14,88,0,11,0,2172,9,0,5,421,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
363,ValleyofTrials,Valley of Trials,1,14,89,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
364,TheDen,The Den,1,14,90,75,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
365,BurningBladeCoven,Burning Blade Coven,1,14,91,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
366,KolkarCrag,Kolkar Crag,1,14,92,0,11,0,2172,9,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
367,Sen'jinVillage,Sen'jin Village,1,14,93,0,11,0,2172,185,0,6,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
368,EchoIsles,Echo Isles,1,14,94,0,11,32,2172,3,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
369,ThunderRidge,Thunder Ridge,1,14,95,0,11,0,2172,9,0,9,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
370,DrygulchRavine,Drygulch Ravine,1,14,96,0,11,0,2172,9,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
371,DustwindCave,Dustwind Cave,1,14,567,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
372,TiragardeKeep,Tiragarde Keep,1,14,97,0,11,0,2172,186,0,6,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
373,ScuttleCoast,Scuttle Coast,1,14,98,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
374,BladefistBay,Bladefist Bay,1,14,99,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
375,DeadeyeShore,Deadeye Shore,1,14,100,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
377,SouthfuryRiver,Southfury River,1,0,101,0,11,0,2172,9,0,9,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
378,CampTaurajo,Camp Taurajo,1,17,102,0,11,0,2172,226,0,10,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
379,FarWatchPost,Far Watch Post,1,17,103,0,11,0,2172,7,0,10,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
380,TheCrossroads,The Crossroads,1,17,104,0,11,0,2172,228,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
381,BoulderLodeMine,Boulder Lode Mine,1,17,105,0,11,0,2172,0,0,17,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
382,TheSludgeFen,The Sludge Fen,1,17,552,0,11,0,2172,3,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
383,TheDryHills,The Dry Hills,1,17,106,0,11,0,2172,0,0,14,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
384,DreadmistPeak,Dreadmist Peak,1,17,107,0,11,46,2172,10,0,11,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
385,NorthwatchHold,Northwatch Hold,1,17,108,0,11,0,2172,3,0,15,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
386,TheForgottenPools,The Forgotten Pools,1,17,109,0,11,32,2172,3,0,12,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
387,LushwaterOasis,Lushwater Oasis,1,17,582,0,11,32,2172,3,0,12,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
388,TheStagnantOasis,The Stagnant Oasis,1,17,110,0,11,32,2172,3,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
390,FieldofGiants,Field of Giants,1,17,111,0,11,0,2172,0,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
391,TheMerchantCoast,The Merchant Coast,1,17,112,0,11,32,2172,3,0,12,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
392,Ratchet,Ratchet,1,17,113,0,11,0,2172,3,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
393,DarkspearStrand,Darkspear Strand,1,14,114,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
394,DarrowmereLakeUNUSED,Darrowmere Lake UNUSED,0,0,115,0,11,37,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
395,CaerDarrowUNUSED,Caer Darrow UNUSED,0,394,116,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
396,WinterhoofWaterWell,Winterhoof Water Well,1,215,117,0,11,0,2172,9,0,6,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
397,ThunderhornWaterWell,Thunderhorn Water Well,1,215,118,0,11,0,2172,9,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
398,WildmaneWaterWell,Wildmane Water Well,1,215,441,0,11,0,2172,9,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
399,SkylineRidge,Skyline Ridge,1,215,610,0,11,0,2172,9,0,6,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
400,ThousandNeedles,Thousand Needles,1,0,442,0,11,25,2172,9,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
401,TheTidusStair,The Tidus Stair,1,17,443,0,11,32,2172,3,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
403,ShadyRestInn,Shady Rest Inn,1,15,568,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
404,Bael'dunDigsite,Bael'dun Digsite,1,215,444,0,11,0,2172,9,0,8,102,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
405,Desolace,Desolace,1,0,445,0,11,39,2172,7,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
406,StonetalonMountains,Stonetalon Mountains,1,0,446,0,11,25,2172,7,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
407,OrgrimmarUNUSED,Orgrimmar UNUSED,1,14,447,0,11,0,2172,14,0,10,62,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
408,Gillijim'sIsle,Gillijim's Isle,0,0,448,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
409,IslandofDoctorLapidis,Island of Doctor Lapidis,0,0,449,0,11,32,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
410,RazorwindCanyon,Razorwind Canyon,1,14,450,0,11,0,2172,9,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
411,Bathran'sHaunt,Bathran's Haunt,1,331,451,0,11,0,2172,205,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
412,TheRuinsofOrdil'Aran,The Ruins of Ordil'Aran,1,331,625,0,11,0,2172,205,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
413,Maestra'sPost,Maestra's Post,1,331,452,0,11,0,2172,0,0,19,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
414,TheZoramStrand,The Zoram Strand,1,331,453,0,11,24,2172,176,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
415,Astranaar,Astranaar,1,331,454,0,11,0,2172,11,0,20,81,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
416,TheShrineofAessina,The Shrine of Aessina,1,331,455,0,11,0,2172,199,0,23,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
417,FireScarShrine,Fire Scar Shrine,1,331,456,0,11,28,2172,193,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
418,TheRuinsofStardust,The Ruins of Stardust,1,331,457,0,11,28,2172,193,0,23,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
419,TheHowlingVale,The Howling Vale,1,331,458,0,11,0,2172,204,0,28,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
420,SilverwindRefuge,Silverwind Refuge,1,331,459,0,11,0,2172,0,0,25,81,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
421,MystralLake,Mystral Lake,1,331,460,0,11,0,2172,0,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
422,FallenSkyLake,Fallen Sky Lake,1,331,461,0,11,0,2172,0,0,26,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
424,IrisLake,Iris Lake,1,331,462,0,11,28,2172,194,0,22,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
425,Moonwell,Moonwell,1,331,549,0,11,0,2172,199,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
426,RaynewoodRetreat,Raynewood Retreat,1,331,463,0,11,0,2172,0,0,24,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
427,TheShadyNook,The Shady Nook,1,331,464,0,11,0,2172,11,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
428,Night Run,Night Run,1,331,569,0,11,0,2172,3,0,25,121,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
429,Xavian,Xavian,1,331,611,0,11,0,2172,3,0,0,121,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
430,Satyrnaar,Satyrnaar,1,331,465,0,11,0,2172,3,0,28,121,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
431,Splintertree Post,Splintertree Post,1,331,553,0,11,0,2172,228,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
432,TheDor'DanilBarrowDen,The Dor'Danil Barrow Den,1,331,466,0,11,0,2172,205,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
433,FalfarrenRiver,Falfarren River,1,331,467,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
434,FelfireHill,Felfire Hill,1,331,570,0,11,48,2172,193,0,29,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
435,DemonFallCanyon,Demon Fall Canyon,1,331,468,0,11,49,2172,193,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
436,DemonFallRidge,Demon Fall Ridge,1,331,469,0,11,49,2172,193,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
437,Warsong Lumber Camp,Warsong Lumber Camp,1,331,612,0,11,28,2172,228,0,22,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
438,BoughShadow,Bough Shadow,1,331,470,0,11,0,2172,188,0,20,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
439,TheShimmeringFlats,The Shimmering Flats,1,400,471,0,11,39,2172,0,0,35,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
440,Tanaris,Tanaris,1,0,472,0,11,39,2172,176,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
441,LakeFalathim,Lake Falathim,1,331,473,0,11,48,2172,0,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
442,Auberdine,Auberdine,1,148,474,0,11,0,2172,0,0,12,81,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
443,RuinsofMathystra,Ruins of Mathystra,1,148,475,0,11,0,2172,176,0,19,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
444,TowerofAlthalaxx,Tower of Althalaxx,1,148,476,0,11,0,2172,0,0,16,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
445,CliffspringFalls,Cliffspring Falls,1,148,477,0,11,0,2172,0,0,14,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
446,Bashal'Aran,Bashal'Aran,1,148,478,0,11,0,2172,0,0,11,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
447,Ameth'Aran,Ameth'Aran,1,148,479,0,11,0,2172,15,0,11,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
448,GroveoftheAncients,Grove of the Ancients,1,148,480,0,11,0,2172,0,0,15,302,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
449,TheMaster'sGlaive,The Master's Glaive,1,148,481,0,11,0,2172,0,0,16,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
450,Remtravel'sExcavation,Remtravel's Excavation,1,148,482,0,11,0,2172,0,0,19,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
452,Mist'sEdge,Mist's Edge,1,148,483,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
453,TheLongWash,The Long Wash,1,148,583,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
454,WildbendRiver,Wildbend River,1,148,484,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
455,BlackwoodDen,Blackwood Den,1,148,485,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
456,CliffspringRiver,Cliffspring River,1,148,486,0,11,0,2172,0,0,14,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
457,TheVeiledSea,The Veiled Sea,1,0,571,0,11,24,2172,200,0,0,201,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
458,GoldRoad,Gold Road,1,17,487,0,11,0,2172,7,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
459,ScarletWatchPost,Scarlet Watch Post,0,85,375,0,11,0,2172,0,0,10,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
460,SunRockRetreat,Sun Rock Retreat,1,406,488,0,11,0,2172,228,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
461,Windshear Crag,Windshear Crag,1,406,489,0,11,0,2172,7,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
463,CragpoolLake,Cragpool Lake,1,406,490,0,11,0,2172,7,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
464,MirkfallonLake,Mirkfallon Lake,1,406,491,0,11,0,2172,7,0,21,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
465,TheCharredVale,The Charred Vale,1,406,492,0,11,0,2172,7,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
466,ValleyoftheBloodfuries,Valley of the Bloodfuries,1,406,493,0,11,0,2172,7,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
467,StonetalonPeak,Stonetalon Peak,1,406,613,0,11,29,2172,11,0,25,201,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
468,TheTalonDen,The Talon Den,1,406,494,0,11,29,2172,11,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
469,GreatwoodVale,Greatwood Vale,1,406,495,0,11,0,2172,7,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
470,ThunderBluffUNUSED,Thunder Bluff UNUSED,1,215,496,0,11,45,2172,9,0,10,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
471,BraveWindMesa,Brave Wind Mesa,1,215,497,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
472,FireStoneMesa,Fire Stone Mesa,1,215,498,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
473,MantleRock,Mantle Rock,1,215,554,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
474,HunterRiseUNUSED,Hunter Rise UNUSED,1,215,499,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
475,SpiritRiseUNUSED,Spirit RiseUNUSED,1,215,500,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
476,ElderRiseUNUSED,Elder RiseUNUSED,1,215,501,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
477,RuinsofJubuwal,Ruins of Jubuwal,0,33,502,0,11,0,2172,3,0,43,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
478,PoolsofArlithrien,Pools of Arlithrien,1,141,503,0,11,0,2172,11,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
479,TheRustmaulDigSite,The Rustmaul Dig Site,1,400,504,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
480,CampE'thok,Camp E'thok,1,400,505,0,11,0,2172,9,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
481,SplithoofCrag,Splithoof Crag,1,400,572,0,11,0,2172,9,0,24,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
482,Highperch,Highperch,1,400,506,0,11,0,2172,9,0,29,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
483,TheScreechingCanyon,The Screeching Canyon,1,400,507,0,11,0,2172,9,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
484,FreewindPost,Freewind Post,1,400,508,0,11,0,2172,226,0,26,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
485,TheGreatLift,The Great Lift,1,400,509,0,11,0,2172,9,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
486,GalakHold,Galak Hold,1,400,510,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
487,RoguefeatherDen,Roguefeather Den,1,400,511,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
488,TheWeatheredNook,The Weathered Nook,1,400,512,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
489,Thalanaar,Thalanaar,1,357,513,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
490,Un'GoroCrater,Un'Goro Crater,1,0,514,0,11,33,2172,223,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
491,RazorfenKraul,Razorfen Kraul,47,0,515,0,11,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,0,0,0,0,0,0
492,RavenHillCemetery,Raven Hill Cemetery,0,10,516,0,11,0,2172,15,0,26,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
493,Moonglade,Moonglade,1,0,517,0,11,28,2172,191,0,0,201,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
495,DELETEME,DELETE ME,0,0,519,0,11,0,2172,11,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
496,BrackenwallVillage,Brackenwall Village,1,15,518,0,11,0,2172,214,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
497,SwamplightManor,Swamplight Manor,1,15,520,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
498,BloodfenBurrow,Bloodfen Burrow,1,15,521,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
499,DarkmistCavern,Darkmist Cavern,1,15,522,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
500,MogglePoint,Moggle Point,1,15,623,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
501,Beezil'sWreck,Beezil's Wreck,1,15,614,0,11,0,2172,3,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
502,WitchHill,Witch Hill,1,15,624,0,11,0,2172,0,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
503,SentryPoint,Sentry Point,1,15,573,0,11,0,2172,191,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
504,NorthPointTower,North Point Tower,1,15,523,0,11,0,2172,191,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
505,WestPointTower,West Point Tower,1,15,524,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
506,LostPoint,Lost Point,1,15,525,0,11,0,2172,191,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
507,Bluefen,Bluefen,1,15,526,0,11,0,2172,0,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
508,StonemaulRuins,Stonemaul Ruins,1,15,527,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
509,TheDenofFlame,The Den of Flame,1,15,528,0,11,0,2172,0,0,38,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
510,TheDragonmurk,The Dragonmurk,1,15,584,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
511,Wyrmbog,Wyrmbog,1,15,529,0,11,0,2172,0,0,43,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
512,Onyxia'sLairUNUSED,Onyxia's Lair UNUSED,1,15,530,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
513,TheramoreIsle,Theramore Isle,1,15,531,0,11,43,2172,13,0,36,401,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
514,FootholdCitadel,Foothold Citadel,1,15,532,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
515,IroncladPrison,Ironclad Prison,1,15,533,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
516,DustwallowBay,Dustwallow Bay,1,15,534,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
517,TidefuryCove,Tidefury Cove,1,15,535,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
518,DreadmurkShore,Dreadmurk Shore,1,15,536,0,11,0,2172,0,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
536,Addle'sStead,Addle's Stead,0,10,537,0,11,0,2172,2,0,24,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
537,FirePlumeRidge,Fire Plume Ridge,1,490,538,0,11,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
538,LakkariTarPits,Lakkari Tar Pits,1,490,539,0,11,0,2172,0,0,49,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
539,TerrorRun,Terror Run,1,490,540,0,11,0,2172,0,0,53,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
540,TheSlitheringScar,The Slithering Scar,1,490,541,0,11,0,2172,0,0,51,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
541,Marshal'sRefuge,Marshal's Refuge,1,490,542,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
542,FungalRock,Fungal Rock,1,490,543,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
543,GolakkaHotSprings,Golakka Hot Springs,1,490,544,0,11,0,2172,0,0,53,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
556,TheLoch,The Loch,0,38,545,0,11,0,2172,1,0,12,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
576,Beggar'sHaunt,Beggar's Haunt,0,10,546,0,11,0,2172,2,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
596,KodoGraveyard,Kodo Graveyard,1,405,593,0,11,0,2172,7,0,35,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
597,GhostWalkerPost,Ghost Walker Post,1,405,594,0,11,0,2172,226,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
598,Sar'therisStrand,Sar'theris Strand,1,405,595,0,11,31,2172,227,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
599,ThunderAxeFortress,Thunder Axe Fortress,1,405,596,0,11,0,2172,193,0,30,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
600,Bolgan'sHole,Bolgan's Hole,1,405,597,0,11,0,2172,7,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
602,MannorocCoven,Mannoroc Coven,1,405,599,0,11,0,2172,193,0,39,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
603,Sargeron,Sargeron,1,405,600,0,11,0,2172,76,0,31,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
604,MagramVillage,Magram Village,1,405,601,0,11,0,2172,7,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
606,GelkisVillage,Gelkis Village,1,405,603,0,11,0,2172,7,0,34,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
607,ValleyofSpears,Valley of Spears,1,405,604,0,11,0,2172,7,0,37,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
608,Nijel'sPoint,Nijel's Point,1,405,605,0,11,0,2172,206,0,30,103,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
609,KolkarVillage,Kolkar Village,1,405,598,0,11,0,2172,7,0,32,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
616,Hyjal,Hyjal,1,0,619,0,11,31,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
618,Winterspring,Winterspring,1,0,621,0,11,42,2172,8,0,0,0,0,0,0,0,-1,0,0,0,65,0,0,0,0,0
636,BlackwolfRiver,Blackwolf River,1,406,626,0,11,0,2172,7,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
637,KodoRock,Kodo Rock,1,215,635,0,11,0,2172,9,0,0,121,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
638,HiddenPath,Hidden Path,1,14,636,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
639,SpiritRock,Spirit Rock,1,14,637,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
640,ShrineoftheDormantFlame,Shrine of the Dormant Flame,1,14,638,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
656,LakeElune'ara,Lake Elune'ara,1,493,295,0,11,0,2172,0,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
657,TheHarborage,The Harborage,0,8,296,0,11,0,2172,0,0,37,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
676,Outland,Outland,150,0,297,0,11,46,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
696,Craftsmen'sTerraceUNUSED,Craftsmen's Terrace UNUSED,1,141,298,0,11,48,2172,76,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
697,Tradesmen'sTerraceUNUSED,Tradesmen's Terrace UNUSED,1,141,299,0,11,48,2172,76,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
698,TheTempleGardensUNUSED,The Temple Gardens UNUSED,1,141,300,0,11,48,2172,76,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
699,TempleofEluneUNUSED,Temple of Elune UNUSED,1,141,301,0,11,48,2172,76,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
700,CenarionEnclaveUNUSED,Cenarion Enclave UNUSED,1,141,302,0,11,48,2172,76,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
701,Warrior'sTerraceUNUSED,Warrior's Terrace UNUSED,1,141,303,0,11,48,2172,76,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
702,Rut'theranVillage,Rut'theran Village,1,141,304,0,11,0,2172,0,0,11,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
716,Ironband'sCompound,Ironband's Compound,0,1,639,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
717,TheStockade,The Stockade,34,0,640,0,11,0,2172,0,0,0,0,0,2,0,0,-1,0,0,0,0,0,0,0,0,0
718,WailingCaverns,Wailing Caverns,43,0,641,0,11,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,0,0,0,0,0,0
719,BlackfathomDeeps,Blackfathom Deeps,48,0,642,75,11,0,2172,176,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
720,FrayIsland,Fray Island,1,17,643,0,11,32,2172,3,0,0,121,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
721,Gnomeregan,Gnomeregan,90,0,305,0,11,42,2172,0,0,0,0,0,2,0,0,-1,0,0,0,0,0,0,0,0,0
722,RazorfenDowns,Razorfen Downs,129,0,644,0,11,38,2172,0,0,0,0,0,4,0,0,-1,0,0,0,3,0,0,0,0,0
736,Ban'ethilHollow,Ban'ethil Hollow,1,141,645,0,11,0,2172,0,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
796,ScarletMonastery,Scarlet Monastery,189,0,646,0,11,0,2172,205,0,0,0,0,4,0,0,-1,0,0,0,0,0,0,0,0,0
797,Jerod'sLanding,Jerod's Landing,0,12,647,0,11,35,2172,0,0,8,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
798,RidgepointTower,Ridgepoint Tower,0,12,648,0,11,35,2172,0,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
799,TheDarkenedBank,The Darkened Bank,0,10,649,0,11,0,2172,2,0,10,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
800,ColdridgePass,Coldridge Pass,0,1,650,0,11,0,2172,0,0,4,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
801,ChillBreezeValley,Chill Breeze Valley,0,1,651,0,11,0,2172,0,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
802,ShimmerRidge,Shimmer Ridge,0,1,652,0,11,0,2172,0,0,8,121,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
803,AmberstillRanch,Amberstill Ranch,0,1,653,0,11,0,2172,0,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
804,TheTundridHills,The Tundrid Hills,0,1,654,0,11,0,2172,0,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
805,SouthGatePass,South Gate Pass,0,1,655,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
806,SouthGateOutpost,South Gate Outpost,0,1,656,0,11,0,2172,0,0,12,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
807,NorthGatePass,North Gate Pass,0,1,657,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
808,NorthGateOutpost,North Gate Outpost,0,1,658,0,11,0,2172,0,0,11,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
809,GatesofIronforge,Gates of Ironforge,0,1,659,0,11,0,2172,0,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
810,StillwaterPond,Stillwater Pond,0,85,660,0,11,0,2172,0,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
811,NightmareVale,Nightmare Vale,0,85,661,0,11,0,2172,0,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
812,VenomwebVale,Venomweb Vale,0,85,662,0,11,0,2172,0,0,10,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
813,TheBulwark,The Bulwark,0,28,663,0,11,0,2172,0,0,52,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
814,SouthfuryRiver,Southfury River,1,14,664,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
815,SouthfuryRiver,Southfury River,1,17,665,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
816,RazormaneGrounds,Razormane Grounds,1,14,666,0,11,0,2172,0,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
817,SkullRock,Skull Rock,1,14,667,0,11,0,2172,0,0,10,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
818,PalemaneRock,Palemane Rock,1,215,668,0,11,0,2172,0,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
819,WindfuryRidge,Windfury Ridge,1,215,669,0,11,0,2172,0,0,9,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
820,TheGoldenPlains,The Golden Plains,1,215,670,0,11,0,2172,0,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
821,TheRollingPlains,The Rolling Plains,1,215,671,0,11,0,2172,0,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
836,DunAlgaz,Dun Algaz,0,11,672,0,11,0,2172,0,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
837,DunAlgaz,Dun Algaz,0,38,673,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
838,NorthGatePass,North Gate Pass,0,38,306,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
839,SouthGatePass,South Gate Pass,0,38,307,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
856,TwilightGrove,Twilight Grove,0,10,674,0,11,0,2172,2,0,19,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
876,GMIsland,GM Island,1,0,675,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
877,Delete ME,Delete ME,1,17,676,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
878,SouthfuryRiver,Southfury River,1,16,677,0,11,0,2172,8,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
879,SouthfuryRiver,Southfury River,1,331,678,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
880,ThandolSpan,Thandol Span,0,45,679,0,11,0,2172,0,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
881,ThandolSpan,Thandol Span,0,11,680,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
896,PurgationIsle,Purgation Isle,0,267,308,0,11,40,2172,193,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
916,TheJansenStead,The Jansen Stead,0,40,681,0,11,0,2172,0,0,9,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
917,TheDeadAcre,The Dead Acre,0,40,682,0,11,0,2172,0,0,18,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
918,TheMolsenFarm,The Molsen Farm,0,40,683,0,11,0,2172,0,0,14,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
919,Stendel'sPond,Stendel's Pond,0,40,684,0,11,0,2172,0,0,14,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
920,TheDaggerHills,The Dagger Hills,0,40,309,0,11,0,2172,0,0,17,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
921,Demont'sPlace,Demont's Place,0,40,310,0,11,0,2172,0,0,16,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
922,TheDustPlains,The Dust Plains,0,40,311,0,11,0,2172,0,0,18,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
923,StonesplinterValley,Stonesplinter Valley,0,38,312,0,11,0,2172,0,0,13,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
924,ValleyofKings,Valley of Kings,0,38,313,0,11,0,2172,0,0,11,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
925,AlgazStation,Algaz Station,0,38,314,0,11,0,2172,0,0,12,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
926,BucklebreeFarm,Bucklebree Farm,0,130,315,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
927,TheShiningStrand,The Shining Strand,0,130,316,0,11,0,2172,0,0,14,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
928,NorthTide'sHollow,North Tide's Hollow,0,130,317,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
936,GrizzlepawRidge,Grizzlepaw Ridge,0,38,318,0,11,0,2172,0,0,12,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
956,TheVerdantFields,The Verdant Fields,169,0,319,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
976,Gadgetzan,Gadgetzan,1,440,320,0,0,0,2172,0,0,40,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
977,SteamwheedlePort,Steamwheedle Port,1,440,390,0,0,0,2172,3,0,40,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
978,Zul'Farrak,Zul'Farrak,1,440,321,0,0,25,2172,176,0,45,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
979,SandsorrowWatch,Sandsorrow Watch,1,440,322,0,0,0,2172,0,0,44,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
980,ThistleshrubValley,Thistleshrub Valley,1,440,323,0,0,0,2172,0,0,49,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
981,TheGapingChasm,The Gaping Chasm,1,440,324,0,0,0,2172,0,0,48,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
982,TheNoxiousLair,The Noxious Lair,1,440,325,0,0,0,2172,0,0,48,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
983,DunemaulCompound,Dunemaul Compound,1,440,326,0,0,0,2172,0,0,47,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
984,EastmoonRuins,Eastmoon Ruins,1,440,327,0,0,0,2172,0,0,47,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
985,WaterspringField,Waterspring Field,1,440,328,0,0,0,2172,0,0,44,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
986,Zalashji'sDen,Zalashji's Den,1,440,329,0,0,0,2172,0,0,45,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
987,Land'sEndBeach,Land's End Beach,1,440,330,0,0,0,2172,0,0,48,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
988,WavestriderBeach,Wavestrider Beach,1,440,331,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
989,Uldum,Uldum,1,440,332,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
990,ValleyoftheWatchers,Valley of the Watchers,1,440,333,0,0,0,2172,0,0,50,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
991,Gunstan'sPost,Gunstan's Post,1,440,334,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
992,SouthmoonRuins,Southmoon Ruins,1,440,335,0,0,0,2172,0,0,47,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
996,Render'sCamp,Render's Camp,0,44,408,0,0,0,2172,0,0,22,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
997,Render'sValley,Render's Valley,0,44,409,0,0,0,2172,0,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
998,Render'sRock,Render's Rock,0,44,410,0,0,0,2172,0,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
999,StonewatchTower,Stonewatch Tower,0,44,411,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1000,GalardellValley,Galardell Valley,0,44,412,0,0,0,2172,0,0,22,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1001,LakeridgeHighway,Lakeridge Highway,0,44,336,0,0,0,2172,0,0,16,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1002,ThreeCorners,Three Corners,0,44,337,0,0,0,2172,0,0,16,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1016,DireforgeHill,Direforge Hill,0,11,338,0,0,0,2172,0,0,28,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1017,RaptorRidge,Raptor Ridge,0,11,339,0,0,0,2172,0,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1018,BlackChannelMarsh,Black Channel Marsh,0,11,340,0,0,0,2172,0,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1019,TheGreenBelt,The Green Belt,0,139,341,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1020,MosshideFen,Mosshide Fen,0,11,342,0,0,0,2172,0,0,22,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1021,ThelgenRock,Thelgen Rock,0,11,343,0,0,0,2172,0,0,22,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1022,BluegillMarsh,Bluegill Marsh,0,11,344,0,0,0,2172,0,0,24,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1023,SaltsprayGlen,Saltspray Glen,0,11,345,0,0,0,2172,0,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1024,SundownMarsh,Sundown Marsh,0,11,346,0,0,0,2172,0,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1025,TheGreenBelt,The Green Belt,0,11,347,0,0,0,2172,0,0,21,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1036,AngerfangEncampment,Angerfang Encampment,0,11,391,0,0,0,2172,0,0,28,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1037,GrimBatol,Grim Batol,0,11,392,0,0,0,2172,0,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1038,DragonmawGates,Dragonmaw Gates,0,11,393,0,0,0,2172,0,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1039,TheLostFleet,The Lost Fleet,0,11,394,0,0,0,2172,0,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1056,DarrowHill,Darrow Hill,0,267,348,0,0,0,2172,0,0,31,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1057,Thoradin'sWall,Thoradin's Wall,0,267,349,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1076,WebwinderPath,Webwinder Path,1,406,368,0,0,0,2172,0,0,21,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1097,TheHushedBank,The Hushed Bank,0,10,351,0,0,0,2172,0,0,19,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1098,ManorMistmantle,Manor Mistmantle,0,10,352,0,0,0,2172,0,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1099,CampMojache,Camp Mojache,1,357,353,0,0,0,2172,226,0,42,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1100,GrimtotemCompound,Grimtotem Compound,1,357,395,0,0,0,2172,0,0,41,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1101,TheWrithingDeep,The Writhing Deep,1,357,396,0,0,0,2172,0,0,44,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1102,WildwindLake,Wildwind Lake,1,357,350,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1103,GordunniOutpost,Gordunni Outpost,1,357,397,0,0,0,2172,0,0,42,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1104,Mok'Gordun,Mok'Gordun,1,357,398,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1105,FeralScarVale,Feral Scar Vale,1,357,354,0,0,0,2172,0,0,44,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1106,FrayfeatherHighlands,Frayfeather Highlands,1,357,399,0,0,0,2172,0,0,46,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1107,IdlewindLake,Idlewind Lake,1,357,400,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1108,TheForgottenCoast,The Forgotten Coast,1,357,355,0,0,0,2172,0,0,49,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1109,EastPillar,East Pillar,1,357,401,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1110,WestPillar,West Pillar,1,357,402,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1111,DreamBough,Dream Bough,1,357,403,0,0,0,2172,0,0,60,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1112,JademirLake,Jademir Lake,1,357,404,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1113,Oneiros,Oneiros,1,357,405,0,0,0,2172,0,0,60,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1114,RuinsofRavenwind,Ruins of Ravenwind,1,357,356,0,0,0,2172,0,0,49,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1115,RageScarHold,Rage Scar Hold,1,357,357,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1116,FeathermoonStronghold,Feathermoon Stronghold,1,357,358,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1117,RuinsofSolarsal,Ruins of Solarsal,1,357,359,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1118,LowerWilds UNUSED,Lower Wilds UNUSED,1,357,360,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1119,TheTwinColossals,The Twin Colossals,1,357,369,0,0,0,2172,0,0,48,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1120,SardorIsle,Sardor Isle,1,357,413,0,0,0,2172,0,0,43,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1121,IsleofDread,Isle of Dread,1,357,414,0,0,0,2172,0,0,44,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1136,HighWilderness,High Wilderness,1,357,361,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1137,LowerWilds,Lower Wilds,1,357,370,0,0,0,2172,0,0,42,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1156,SouthernBarrens,Southern Barrens,1,17,362,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1157,SouthernGoldRoad,Southern Gold Road,1,17,406,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1176,Zul'Farrak,Zul'Farrak,209,0,371,0,0,25,2172,176,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
1196,UNUSEDAlcazIsland,UNUSEDAlcaz Island,1,0,363,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
1216,TimbermawHold,Timbermaw Hold,1,16,364,0,0,0,2172,0,0,49,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1217,VanndirEncampment,Vanndir Encampment,1,16,365,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1218,TESTAzshara,TESTAzshara,1,16,366,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1219,LegashEncampment,Legash Encampment,1,16,367,0,0,0,2172,0,0,52,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1220,ThalassianBaseCamp,Thalassian Base Camp,1,16,415,0,0,0,2172,76,0,52,302,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1221,RuinsofEldarath,Ruins of Eldarath ,1,16,416,0,0,0,2172,176,0,48,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1222,Hetaera'sClutch,Hetaera's Clutch,1,16,417,0,0,0,2172,176,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1223,TempleofZin-Malor,Temple of Zin-Malor,1,16,418,0,0,0,2172,15,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1224,Bear'sHead,Bear's Head,1,16,419,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1225,Ursolan,Ursolan,1,16,420,0,0,0,2172,0,0,49,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1226,TempleofArkkoran,Temple of Arkkoran,1,16,421,0,0,0,2172,176,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1227,BayofStorms,Bay of Storms,1,16,422,0,0,0,2172,176,0,50,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1228,TheShatteredStrand,The Shattered Strand,1,16,423,0,0,0,2172,176,0,52,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1229,TowerofEldara,Tower of Eldara,1,16,424,0,0,0,2172,176,0,53,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1230,JaggedReef,Jagged Reef,1,16,425,0,0,0,2172,176,0,51,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1231,SouthridgeBeach,Southridge Beach,1,16,426,0,0,0,2172,176,0,52,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1232,RavencrestMonument,Ravencrest Monument,1,16,427,0,0,0,2172,176,0,54,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1233,ForlornRidge,Forlorn Ridge,1,16,428,0,0,0,2172,215,0,49,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1234,LakeMennar,Lake Mennar,1,16,429,0,0,0,2172,0,0,52,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1235,ShadowsongShrine,Shadowsong Shrine,1,16,430,0,0,0,2172,15,0,46,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1236,HaldarrEncampment,Haldarr Encampment,1,16,431,0,0,0,2172,3,0,45,121,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1237,Valormok,Valormok,1,16,432,0,0,0,2172,228,0,49,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1256,TheRuinedReaches,The Ruined Reaches,1,16,433,0,0,0,2172,176,0,42,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1276,TheTalondeepPath,The Talondeep Path,1,331,434,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1277,TheTalondeepPath,The Talondeep Path,1,406,435,0,0,0,2172,0,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1296,RocktuskFarm,Rocktusk Farm,1,14,372,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1297,JaggedswineFarm,Jaggedswine Farm,1,14,407,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1316,RazorfenDowns,Razorfen Downs,1,17,436,0,0,70,2172,176,0,33,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1336,LostRiggerCove,Lost Rigger Cove,1,440,373,0,0,0,2172,0,0,45,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1337,Uldaman,Uldaman,70,0,437,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
1338,LordamereLake,Lordamere Lake,0,130,438,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1339,LordamereLake,Lordamere Lake,0,36,439,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1357,Gallows'Corner,Gallows' Corner,0,36,440,0,0,37,2172,10,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1377,Silithus,Silithus,1,0,374,0,0,38,2172,176,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
1397,EmeraldForest,Emerald Forest,169,0,376,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
1417,SunkenTemple,Sunken Temple,109,0,377,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
1437,DreadmaulHold,Dreadmaul Hold,0,4,378,0,0,0,2172,0,0,47,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1438,NethergardeKeep,Nethergarde Keep,0,4,379,0,0,0,2172,205,0,50,303,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1439,DreadmaulPost,Dreadmaul Post,0,4,380,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1440,Serpent'sCoil,Serpent's Coil,0,4,381,0,0,0,2172,0,0,51,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1441,AltarofStorms,Altar of Storms,0,4,382,0,0,0,2172,10,0,54,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1442,FirewatchRidge,Firewatch Ridge,0,51,383,0,0,0,2172,0,0,48,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1443,TheSlagPit,The Slag Pit,0,51,384,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1444,TheSeaofCinders,The Sea of Cinders,0,51,385,0,0,0,2172,0,0,56,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1445,BlackrockMountain,Blackrock Mountain,0,51,386,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1446,ThoriumPoint,Thorium Point,0,51,387,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1457,GarrisonArmory,Garrison Armory,0,4,388,0,0,0,2172,0,0,47,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1477,TheTempleOfAtal'Hakkar,The Temple of Atal'Hakkar,0,0,389,0,0,33,2172,3,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
1497,Undercity,Undercity,0,0,685,0,0,40,2172,0,0,10,0,0,4,0,0,-1,0,0,0,312,0,0,0,0,0
1517,Uldaman,Uldaman,0,3,686,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1518,NotIUsedDeadmines,Not Used Deadmines,0,40,687,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1519,StormwindCity,Stormwind City,0,0,688,0,0,31,2172,13,0,10,61,0,2,0,0,-1,0,0,0,312,0,0,0,0,0
1537,Ironforge,Ironforge,0,0,689,0,0,42,2172,0,0,10,0,0,2,0,0,-1,0,0,0,312,0,0,0,0,0
1557,SplithoofHold,Splithoof Hold,1,400,690,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1577,TheCapeofStranglethorn,The Cape of Stranglethorn,0,33,691,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1578,SouthernSavageCoast,Southern Savage Coast,0,33,692,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1579,UnusedTheDeadmines002,Unused The Deadmines 002,0,0,693,0,0,0,2172,0,0,0,0,0,2,0,0,-1,0,0,0,64,0,0,0,0,0
1580,UnusedIroncladCove003,Unused Ironclad Cove 003,36,1579,694,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1581,TheDeadmines,The Deadmines,36,0,695,76,0,53,2172,204,0,0,0,0,2,0,0,-1,0,0,0,0,0,0,0,0,0
1582,IroncladCove,Ironclad Cove,36,1581,696,76,0,53,2172,204,0,0,181,0,2,0,0,-1,0,0,0,1073741824,0,0,0,0,0
1583,BlackrockSpire,Blackrock Spire,0,0,697,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
1584,BlackrockDepths,Blackrock Depths,0,0,698,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
1597,RaptorGroundsUNUSED,Raptor Grounds UNUSED,1,17,699,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1598,Grol'domFarmUNUSED,Grol'dom Farm UNUSED,1,17,700,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1599,Mor'shanBaseCamp,Mor'shan Base Camp,1,17,701,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1600,Honor'sStandUNUSED,Honor's Stand UNUSED,1,17,702,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1601,BlackthornRidgeUNUSED,Blackthorn Ridge UNUSED,1,17,703,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1602,BramblescarUNUSED,Bramblescar UNUSED,1,17,704,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1603,Agama'gorUNUSED,Agama'gor UNUSED,1,17,705,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1617,ValleyofHeroes,Valley of Heroes,0,1519,706,0,0,43,2172,13,0,0,0,0,2,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1637,Orgrimmar,Orgrimmar,1,0,707,0,0,25,2172,7,0,10,62,0,4,0,0,-1,0,0,0,312,0,0,0,0,0
1638,ThunderBluff,Thunder Bluff,1,0,708,0,0,45,2172,226,0,10,381,0,4,0,0,-1,0,0,0,312,0,0,0,0,0
1639,ElderRise,Elder Rise,1,1638,709,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1640,SpiritRise,Spirit Rise,1,1638,710,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1641,HunterRise,Hunter Rise,1,1638,711,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1657,Darnassus,Darnassus,1,0,712,0,0,48,2172,76,0,10,63,0,2,0,0,-1,0,0,0,312,0,0,0,0,0
1658,CenarionEnclave,Cenarion Enclave,1,1657,713,0,0,0,2172,0,0,0,103,0,2,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1659,Craftsmen'sTerrace,Craftsmen's Terrace,1,1657,714,0,0,0,2172,0,0,0,0,0,2,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1660,Warrior'sTerrace,Warrior's Terrace,1,1657,715,0,0,0,2172,0,0,0,0,0,2,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1661,TheTempleGardens,The Temple Gardens,1,1657,716,0,0,0,2172,0,0,0,0,0,2,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1662,Tradesmen'sTerrace,Tradesmen's Terrace,1,1657,717,0,0,0,2172,0,0,0,0,0,2,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1677,Gavin'sNaze,Gavin's Naze,0,36,718,0,0,0,2172,0,0,33,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1678,Sofera'sNaze,Sofera's Naze,0,36,719,0,0,0,2172,0,0,33,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1679,Corrahn'sDagger,Corrahn's Dagger,0,36,720,0,0,0,2172,0,0,33,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1680,TheHeadland,The Headland,0,36,721,0,0,0,2172,0,0,34,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1681,MistyShore,Misty Shore,0,36,722,0,0,0,2172,0,0,31,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1682,Dandred'sFold,Dandred's Fold,0,36,723,0,0,0,2172,0,0,39,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1683,GrowlessCave,Growless Cave,0,36,724,0,0,37,2172,10,0,34,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1684,ChillwindPoint,Chillwind Point,0,36,725,0,0,0,2172,0,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1697,RaptorGrounds,Raptor Grounds,1,17,726,0,0,0,2172,0,0,18,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1698,Bramblescar,Bramblescar,1,17,727,0,0,0,2172,0,0,20,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1699,ThornHill,Thorn Hill,1,17,728,0,0,0,2172,0,0,13,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1700,Agama'gor,Agama'gor,1,17,729,0,0,0,2172,0,0,19,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1701,BlackthornRidge,Blackthorn Ridge,1,17,730,0,0,0,2172,0,0,20,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1702,Honor'sStand,Honor's Stand,1,17,731,0,0,0,2172,0,0,18,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1703,TheMor'shanRampart,The Mor'shan Rampart,1,17,732,0,0,0,2172,0,0,17,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1704,Grol'domFarm,Grol'dom Farm,1,17,733,0,0,0,2172,0,0,11,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1717,RazorfenKraul,Razorfen Kraul,1,17,734,0,0,0,2172,0,0,24,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1718,TheGreatLift,The Great Lift,1,17,735,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1737,MistvaleValley,Mistvale Valley,0,33,736,0,0,0,2172,0,0,40,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1738,Nek'maniWellspring,Nek'mani Wellspring,0,33,737,0,0,0,2172,0,0,43,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1739,BloodsailCompound,Bloodsail Compound,0,33,738,0,0,0,2172,0,0,42,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1740,VentureCo.BaseCamp,Venture Co. Base Camp,0,33,739,0,0,0,2172,0,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1741,GurubashiArena,Gurubashi Arena,0,33,740,0,0,0,2172,0,0,43,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1742,SpiritDen,Spirit Den,0,33,741,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1757,TheCrimsonVeil,The Crimson Veil,0,33,742,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1758,TheRiptide,The Riptide,0,33,743,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1759,TheDamsel'sLuck,The Damsel's Luck,0,33,744,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1760,VentureCo.OperationsCenter,Venture Co. Operations Center,0,33,745,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1761,DeadwoodVillage,Deadwood Village,1,361,746,0,0,0,2172,194,0,47,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1762,FelpawVillage,Felpaw Village,1,361,747,0,0,0,2172,194,0,54,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1763,Jaedenar,Jaedenar,1,361,748,0,0,0,2172,193,0,51,161,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1764,BloodvenomRiver,Bloodvenom River,1,361,749,0,0,0,2172,193,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1765,BloodvenomFalls,Bloodvenom Falls,1,361,750,0,0,0,2172,193,0,52,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1766,ShatterScarVale,Shatter Scar Vale,1,361,751,0,0,0,2172,0,0,53,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1767,IrontreeWoods,Irontree Woods,1,361,752,0,0,0,2172,0,0,53,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1768,IrontreeCavern,Irontree Cavern,1,361,753,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1769,TimbermawHold,Timbermaw Hold,1,361,754,0,0,0,2172,0,0,54,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1770,ShadowHold,Shadow Hold,1,361,755,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1771,ShrineoftheDeceiver,Shrine of the Deceiver,1,361,756,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1777,Itharius'sCave,Itharius's Cave,0,8,757,0,0,0,2172,0,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1778,Sorrowmurk,Sorrowmurk,0,8,758,0,0,0,2172,0,0,41,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1779,Draenil'durVillage,Draenil'dur Village,0,8,759,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1780,SplinterspearJunction,Splinterspear Junction,0,8,760,0,0,0,2172,0,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1797,Stagalbog,Stagalbog,0,8,761,0,0,0,2172,0,0,41,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1798,TheShiftingMire,The Shifting Mire,0,8,762,0,0,0,2172,0,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1817,StagalbogCave,Stagalbog Cave,0,8,763,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1837,WitherbarkCaverns,Witherbark Caverns,0,45,764,0,0,0,2172,3,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1857,Thoradin'sWall,Thoradin's Wall,0,45,765,0,0,0,2172,0,0,32,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1858,Boulder'gor,Boulder'gor,0,45,766,0,0,0,2172,0,0,32,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1877,ValleyofFangs,Valley of Fangs,0,3,767,0,0,0,2172,0,0,42,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1878,TehDustbowl,The Dustbowl,0,3,768,0,0,0,2172,0,0,39,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1879,MirageFlats,Mirage Flats,0,3,769,0,0,0,2172,0,0,40,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1880,Featherbeard'sHovel,Featherbeard's Hovel,0,47,770,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1881,Shindigger'sCamp,Shindigger's Camp,0,47,771,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1882,PlaguemistRavine,Plaguemist Ravine,0,47,772,0,0,0,2172,0,0,45,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1883,ValorwindLake,Valorwind Lake,0,47,773,0,0,0,2172,0,0,48,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1884,Agol'watha,Agol'watha,0,47,774,0,0,0,2172,0,0,46,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1885,Hiri'watha,Hiri'watha,0,47,775,0,0,0,2172,0,0,42,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1886,TheCreepingRuin,The Creeping Ruin,0,47,776,0,0,0,2172,0,0,47,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1887,Bogen'sLedge,Bogen's Ledge,0,47,777,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1897,TheMaker'sTerrace,The Maker's Terrace,0,3,778,0,0,0,2172,0,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1898,DustwindGulch,Dustwind Gulch,0,3,779,0,0,0,2172,0,0,39,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1917,Shaol'watha,Shaol'watha,0,47,780,0,0,0,2172,0,0,49,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1937,NoonshadeRuins,Noonshade Ruins,1,440,781,0,0,0,2172,0,0,42,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1938,BrokenPillar,Broken Pillar,1,440,782,0,0,0,2172,0,0,45,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1939,AbyssalSands,Abyssal Sands,1,440,783,0,0,0,2172,0,0,45,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1940,SouthbreakShore,Southbreak Shore,1,440,784,0,0,0,2172,0,0,49,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1941,CavernsofTime,Caverns of Time,1,0,785,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
1942,TheMarshlands,The Marshlands,1,490,786,0,0,0,2172,0,0,48,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1943,IronstonePlateau,Ironstone Plateau,1,490,787,0,0,0,2172,0,0,50,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1957,BlackcharCave,Blackchar Cave,0,51,788,0,0,0,2172,0,0,47,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1958,TannerCamp,Tanner Camp,0,51,789,0,0,0,2172,0,0,43,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1959,DustfireValley,Dustfire Valley,0,51,790,0,0,0,2172,0,0,45,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1977,ZulGurub,Zul'Gurub,309,0,791,0,11,32,2172,3,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
1978,MistyReedPost,Misty Reed Post,0,8,792,0,0,0,2172,0,0,41,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1997,BloodvenomPost,Bloodvenom Post ,1,361,793,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1998,TalonbranchGlade,Talonbranch Glade ,1,361,794,0,0,0,2172,0,0,53,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2017,Stratholme,Stratholme,329,0,795,0,0,37,2172,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
2037,UNUSEDShadowfangKeep003,UNUSEDShadowfang Keep 003,0,0,796,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
2057,Scholomance,Scholomance,289,0,797,0,0,37,2172,15,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
2077,TwilightVale,Twilight Vale,1,148,798,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2078,TwilightShore,Twilight Shore,1,148,799,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2079,AlcazIsland,Alcaz Island,1,15,800,0,0,32,2172,3,0,61,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2097,DarkcloudPinnacle,Darkcloud Pinnacle,1,400,801,0,0,0,2172,226,0,26,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2098,DawningWoodCatacombs,Dawning Wood Catacombs,0,10,802,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2099,StonewatchKeep,Stonewatch Keep,0,44,803,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2100,Maraudon,Maraudon,349,0,804,0,0,0,2172,7,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
2101,StoutlagerInn,Stoutlager Inn,0,38,805,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2102,ThunderbrewDistillery,Thunderbrew Distillery,0,1,806,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2103,MenethilKeep,Menethil Keep,0,11,807,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2104,DeepwaterTavern,Deepwater Tavern,0,11,808,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2117,ShadowGrave,Shadow Grave,0,85,809,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2118,BrillTownHall,Brill Town Hall,0,85,810,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2119,Gallows'EndTavern,Gallows' End Tavern,0,85,811,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2137,ThePoolsofVisionUNUSED,The Pools of VisionUNUSED,1,215,812,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2138,DreadmistDen,Dreadmist Den,1,17,813,0,0,0,2172,10,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2157,Bael'dunKeep,Bael'dun Keep,1,17,814,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2158,Emberstrife'sDen,Emberstrife's Den,1,15,815,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2159,OnyxiasLair,Onyxia's Lair,1,0,816,0,0,33,2172,237,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
2160,WindshearMine,Windshear Mine,1,406,817,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2161,Roland'sDoom,Roland's Doom,0,10,818,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2177,BattleRing,Battle Ring,0,33,819,0,0,0,2172,0,0,0,325,0,0,0,0,-1,0,0,0,1073742032,0,0,0,0,0
2197,ThePoolsofVision,The Pools of Vision,1,1638,820,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2198,ShadowbreakRavine,Shadowbreak Ravine,1,405,821,0,0,0,2172,237,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2217,BrokenSpearVillage,Broken Spear Village,1,405,822,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2237,WhitereachPost,Whitereach Post,1,400,823,0,0,0,2172,0,0,28,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2238,Gornia,Gornia,1,400,824,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2239,Zane'sEyeCrater,Zane's Eye Crater,1,400,825,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2240,MirageRaceway,Mirage Raceway,1,400,826,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2241,FrostsaberRock,Frostsaber Rock,1,618,827,0,0,0,2172,0,0,57,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2242,TheHiddenGrove,The Hidden Grove,1,618,828,0,0,0,2172,0,0,58,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2243,TimbermawPost,Timbermaw Post,1,618,829,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2244,WinterfallVillage,Winterfall Village,1,618,830,0,0,0,2172,0,0,57,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2245,Mazthoril,Mazthoril,1,618,831,0,0,0,2172,223,0,56,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2246,FrostfireHotSprings,Frostfire Hot Springs,1,618,832,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2247,IceThistleHills,Ice Thistle Hills,1,618,833,0,0,0,2172,0,0,56,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2248,DunMandarr,Dun Mandarr,1,618,834,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2249,FrostwhisperGorge,Frostwhisper Gorge,1,618,835,0,0,0,2172,0,0,60,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2250,OwlWingThicket,Owl Wing Thicket,1,618,836,0,0,0,2172,0,0,56,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2251,LakeKel'Theril,Lake Kel'Theril,1,618,837,0,0,0,2172,0,0,56,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2252,TheRuinsofKel'Theril,The Ruins of Kel'Theril,1,618,838,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2253,StarfallVillage,Starfall Village,1,618,839,0,0,0,2172,76,0,55,103,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2254,Ban'ThallowBarrowDen,Ban'Thallow Barrow Den,1,618,840,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2255,Everlook,Everlook,1,618,841,0,0,0,2172,235,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2256,DarkwhisperGorge,Darkwhisper Gorge,1,618,842,0,0,37,2172,205,0,60,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2257,DeeprunTram,Deeprun Tram,369,0,843,0,0,0,2172,0,0,0,0,0,2,0,0,-1,0,0,0,0,0,0,0,0,0
2258,TheFungalVale,The Fungal Vale,0,139,844,0,0,0,2172,0,0,58,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2259,UNUSEDTheMarrisStead,UNUSEDThe Marris Stead,0,139,845,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2260,TheMarrisStead,The Marris Stead,0,139,846,0,0,0,2172,0,0,54,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2261,TheUndercroft,The Undercroft,0,139,847,0,0,0,2172,0,0,54,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2262,Darrowshire,Darrowshire,0,139,848,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2263,CrownGuardTower,Crown Guard Tower,0,139,849,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2264,Corin'sCrossing,Corin's Crossing,0,139,850,0,0,0,2172,0,0,57,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2265,ScarletBaseCamp,Scarlet Base Camp,0,139,851,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2266,Tyr'sHand,Tyr's Hand,0,139,852,0,0,0,2172,193,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2267,TheScarletBasilica,The Scarlet Basilica,0,139,853,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2268,Light'sHopeChapel,Light's Hope Chapel,0,139,854,0,0,0,2172,0,0,58,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2269,BrowmanMill,Browman Mill,0,139,855,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2270,TheNoxiousGlade,The Noxious Glade,0,139,856,0,0,0,2172,0,0,58,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2271,EastwallTower,Eastwall Tower,0,139,857,0,0,0,2172,0,0,56,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2272,Northdale,Northdale,0,139,858,0,0,0,2172,0,0,58,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2273,Zul'Mashar,Zul'Mashar,0,139,859,0,0,0,2172,227,0,57,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2274,Mazra'Alor,Mazra'Alor,0,139,860,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2275,NorthpassTower,Northpass Tower,0,139,861,0,0,0,2172,0,0,56,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2276,Quel'LithienLodge,Quel'Lithien Lodge,0,139,862,0,0,0,2172,76,0,59,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2277,Plaguewood,Plaguewood,0,139,863,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2278,Scourgehold,Scourgehold,0,139,864,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2279,Stratholme,Stratholme,0,139,865,0,0,37,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2280,UNUSEDStratholme,UNUSED Stratholme,0,0,866,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
2297,DarrowmereLake,Darrowmere Lake,0,28,867,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2298,CaerDarrow,Caer Darrow,0,28,868,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2299,DarrowmereLake,Darrowmere Lake,0,139,869,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2300,CavernsofTime,Caverns of Time,1,440,870,0,0,0,2172,0,0,50,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2301,ThistlefurVillage,Thistlefur Village,1,331,871,0,0,28,2172,194,0,23,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2302,TheQuagmire,The Quagmire,1,15,872,0,0,0,2172,0,0,39,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2303,WindbreakCanyon,Windbreak Canyon,1,400,873,0,0,0,2172,0,0,27,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2317,SouthSeas,South Seas,1,440,874,0,0,24,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2318,TheGreatSea,The Great Sea,1,15,875,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2319,TheGreatSea,The Great Sea,1,17,876,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2320,TheGreatSea,The Great Sea,1,14,877,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2321,TheGreatSea,The Great Sea,1,16,878,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2322,TheVeiledSea,The Veiled Sea,1,141,879,0,0,0,2172,0,0,0,0,0,2,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2323,TheVeiledSea,The Veiled Sea,1,357,880,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2324,TheVeiledSea,The Veiled Sea,1,405,881,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2325,TheVeiledSea,The Veiled Sea,1,331,882,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2326,TheVeiledSea,The Veiled Sea,1,148,883,0,0,0,2172,0,0,0,0,0,2,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2337,RazorHillBarracks,Razor Hill Barracks,1,14,884,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2338,SouthSeas,South Seas,0,33,885,0,0,24,2172,0,0,0,122,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2339,TheGreatSea,The Great Sea,0,33,886,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2357,BloodtoothCamp,Bloodtooth Camp,1,331,887,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2358,ForestSong,Forest Song,1,331,888,0,0,0,2172,188,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2359,Greenpaw Village,Greenpaw Village,1,331,889,0,0,0,2172,0,0,24,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2360,SilverwingOutpost,Silverwing Outpost,1,331,890,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2361,Nighthaven,Nighthaven,1,493,891,0,0,0,2172,0,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2362,ShrineofRemulos,Shrine of Remulos,1,493,892,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2363,StormrageBarrowDens,Stormrage Barrow Dens,1,493,893,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2364,TheGreatSea,The Great Sea,0,40,894,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2365,TheGreatSea,The Great Sea,0,11,895,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2366,TheBlackMorass,The Black Morass,269,0,896,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
2367,OldHillsbrad Foothills,Old Hillsbrad Foothills,269,0,897,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
2368,TarrenMill,Tarren Mill,269,2367,898,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2369,Southshore,Southshore,269,2367,899,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2370,DurnholdeKeep,Durnholde Keep,269,2367,900,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2371,DunGarok,Dun Garok,269,2367,901,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2372,Hillsbrad Fields,Hillsbrad Fields,269,2367,902,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2373,EasternStrand,Eastern Strand,269,2367,903,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2374,NethanderStead,Nethander Stead,269,2367,904,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2375,DarrowHill,Darrow Hill,269,2367,905,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2376,SouthpointTower,Southpoint Tower,269,2367,906,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2377,Thoradin'sWall,Thoradin's Wall,269,2367,907,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2378,WesternStrand,Western Strand,269,2367,908,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2379,AzurelodeMine,Azurelode Mine,269,2367,909,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2397,TheGreatSea,The Great Sea,0,267,910,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2398,TheGreatSea,The Great Sea,0,130,911,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2399,TheGreatSea,The Great Sea,0,85,912,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2400,TheForbiddingSea,The Forbidding Sea,0,47,913,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2401,TheForbiddingSea,The Forbidding Sea,0,45,914,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2402,TheForbiddingSea,The Forbidding Sea,0,11,915,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2403,TheForbiddingSea,The Forbidding Sea,0,8,916,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2404,TethrisAran,Tethris Aran,1,405,917,0,0,0,2172,0,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2405,EthelRethor,Ethel Rethor,1,405,918,0,0,0,2172,227,0,32,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2406,RanazjarIsle,Ranazjar Isle,1,405,919,0,0,0,2172,0,0,35,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2407,Kormek'sHut,Kormek's Hut,1,405,920,0,0,0,2172,0,0,32,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2408,ShadowpreyVillage,Shadowprey Village,1,405,921,0,0,0,2172,185,0,33,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2417,BlackrockPass,Blackrock Pass,0,46,922,0,0,0,2172,0,0,54,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2418,Morgan'sVigil,Morgan's Vigil,0,46,923,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2419,SlitherRock,Slither Rock,0,46,924,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2420,TerrorWingPath,Terror Wing Path,0,46,925,0,0,0,2172,0,0,52,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2421,Draco'dar,Draco'dar,0,46,926,0,0,0,2172,0,0,54,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2437,Ragefire,Ragefire Chasm,389,0,927,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,0,0,0,0,0,0
2457,NightsongWoods,Nightsong Woods,1,331,928,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2477,TheVeiledSea,The Veiled Sea,1,1377,929,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2478,Morlos'Aran,Morlos'Aran,1,361,930,0,0,0,2172,0,0,47,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2479,EmeraldSanctuary,Emerald Sanctuary,1,361,931,0,0,0,2172,0,0,48,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2480,JadefireGlen,Jadefire Glen,1,361,932,0,0,0,2172,0,0,50,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2481,RuinsofConstellas,Ruins of Constellas,1,361,933,0,0,0,2172,0,0,51,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2497,BitterReaches,Bitter Reaches,1,16,934,0,0,0,2172,0,0,53,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2517,RiseoftheDefiler,Rise of the Defiler,0,4,935,0,0,0,2172,0,0,46,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2518,LarissPavilion,Lariss Pavilion,1,357,936,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2519,WoodpawHills,Woodpaw Hills,1,357,937,0,0,0,2172,0,0,41,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2520,WoodpawDen,Woodpaw Den,1,357,938,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2521,VerdantisRiver,Verdantis River,1,357,939,0,0,0,2172,0,0,-1,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2522,RuinsofIsildien,Ruins of Isildien,1,357,940,0,0,0,2172,0,0,45,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2537,GrimtotemPost,Grimtotem Post,1,406,941,0,0,0,2172,226,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2538,CampAparaje,Camp Aparaje,1,406,942,0,0,0,2172,226,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2539,Malaka'jin,Malaka'jin,1,406,943,0,0,0,2172,185,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2540,BoulderslideRavine,Boulderslide Ravine,1,406,944,0,0,0,2172,0,0,16,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2541,SishirCanyon,Sishir Canyon,1,406,945,0,0,0,2172,229,0,18,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2557,DireMaul,Dire Maul,429,0,946,0,0,29,2172,11,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
2558,DeadwindRavine,Deadwind Ravine,0,41,947,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2559,DiamondheadRiver,Diamondhead River,0,41,948,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2560,Ariden'sCamp,Ariden's Camp,0,41,949,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2561,TheVice,The Vice,0,41,950,0,0,0,2172,0,0,57,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2562,Karazhan,Karazhan,0,41,951,0,0,0,2172,0,0,60,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2563,Morgan'sPlot,Morgan's Plot,0,41,952,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2577,DireMaul,Dire Maul,1,357,953,0,0,29,2172,11,0,44,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2597,AlteracValley,Alterac Valley,30,0,954,0,0,42,2172,242,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
2617,Scrabblescrew'sCamp,Scrabblescrew's Camp,1,405,955,0,0,0,2172,226,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2618,JadefireRun,Jadefire Run,1,361,956,0,0,0,2172,0,0,50,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2619,ThondrorilRiver,Thondroril River,0,139,957,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2620,ThondrorilRiver,Thondroril River,0,28,958,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2621,LakeMereldar,Lake Mereldar,0,139,959,0,0,0,2172,0,0,54,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2622,PestilentScar,Pestilent Scar,0,139,960,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2623,TheInfectisScar,The Infectis Scar,0,139,961,0,0,0,2172,0,0,59,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2624,BlackwoodLake,Blackwood Lake,0,139,962,0,0,0,2172,0,0,58,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2625,EastwallGate,Eastwall Gate,0,139,963,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2626,TerrorwebTunnel,Terrorweb Tunnel,0,139,964,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2627,Terrordale,Terrordale,0,139,965,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2637,KargathiaKeep,Kargathia Keep,1,331,966,0,0,28,2172,228,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2657,ValleyofBones,Valley of Bones,1,405,967,0,0,0,2172,193,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2677,BlackwingLair,Blackwing Lair,469,0,968,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
2697,Deadman'sCrossing,Deadman's Crossing,0,41,969,0,0,0,2172,0,0,50,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2717,MoltenCore,Molten Core,409,0,970,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
2737,TheScarabWall,The Scarab Wall,1,1377,971,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2738,Southwind Village,Southwind Village,1,1377,972,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2739,TwilightBaseCamp,Twilight Base Camp,1,1377,973,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2740,TheCrystalVale,The Crystal Vale,1,1377,974,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2741,TheScarabDais,The Scarab Dais,1,1377,975,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2742,Hive'Ashi,Hive'Ashi,1,1377,976,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2743,Hive'Zora,Hive'Zora,1,1377,977,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2744,Hive'Regal,Hive'Regal,1,1377,978,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2757,Shrineofthefallenwarrior,Shrine of the Fallen Warrior,1,17,979,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2777,AlteracValley,UNUSED Alterac Valley,0,267,980,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2797,BlackfathomDeeps,Blackfathom Deeps,1,331,981,0,0,24,2172,176,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2817,***On Map Dungeon***,***On Map Dungeon***,30,0,1157,3,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,68,0,0,0,0,0
2837,TheMaster'sCellar,The Master's Cellar,1,41,982,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2838,StonewroughtPass,Stonewrought Pass,0,51,983,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2839,AlteracValley,Alterac Valley,0,36,984,0,0,38,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2857,TheRumbleCage,The Rumble Cage,1,440,985,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741952,0,0,0,0,0
2877,ChunkTest,Chunk Test,451,22,986,0,0,0,2172,0,0,60,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2897,Zoram'garOutpost,Zoram'gar Outpost,1,331,987,0,0,24,2172,185,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2917,HallofLegends,Hall of Legends,450,0,988,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,32,0,0,0,0,0
2918,Champions'Hall,Champions' Hall,449,0,989,0,0,0,2172,0,0,0,0,0,2,0,0,-1,0,0,0,32,0,0,0,0,0
2937,Grosh'gokCompound,Grosh'gok Compound,0,41,990,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2938,SleepingGorge,Sleeping Gorge,0,41,991,0,0,0,2172,0,0,50,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2957,IrondeepMine,Irondeep Mine,30,2597,992,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2958,StonehearthOutpost,Stonehearth Outpost,30,2597,993,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2959,DunBaldar,Dun Baldar,30,2597,994,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2960,IcewingPass,Icewing Pass,30,2597,995,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2961,FrostwolfVillage,Frostwolf Village,30,2597,996,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2962,TowerPoint,Tower Point,30,2597,997,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2963,ColdtoothMine,Coldtooth Mine,30,2597,998,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2964,WinteraxHold,Winterax Hold,30,2597,999,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2977,IcebloodGarrison,Iceblood Garrison,30,2597,1000,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2978,FrostwolfKeep,Frostwolf Keep,30,2597,1001,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2979,Tor'krenFarm,Tor'kren Farm,1,14,1002,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3017,FrostDaggerPass,Frost Dagger Pass,30,2597,1003,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3037,IronstoneCamp,Ironstone Camp,1,400,1004,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3038,Weazel'sCrater,Weazel's Crater,1,400,1005,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3039,TahondaRuins,Tahonda Ruins,1,400,1006,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3057,FieldofStrife,Field of Strife,30,2597,1007,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3058,IcewingCavern,Icewing Cavern,30,2597,1008,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3077,Valor'sRest,Valor's Rest,1,1377,1009,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3097,TheSwarmingPillar,The Swarming Pillar,1,1377,1010,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3098,TwilightPost,Twilight Post,1,1377,1011,0,0,0,2172,0,0,57,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3099,TwilightOutpost,Twilight Outpost,1,1377,1012,0,0,0,2172,0,0,59,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3100,RavagedTwilightCamp,Ravaged Twilight Camp,1,1377,1013,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3117,Shalzaru'sLair,Shalzaru's Lair,1,357,1014,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3137,TalrendisPoint,Talrendis Point,1,16,1015,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3138,RethressSanctum,Rethress Sanctum,1,16,1016,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3139,MoonHorrorDen,Moon Horror Den,1,618,1017,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3140,Scalebeard'sCave,Scalebeard's Cave,1,16,1018,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3157,BoulderslideCavern,Boulderslide Cavern,1,406,1019,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3177,WarsongLaborCamp,Warsong Labor Camp,1,331,1020,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3197,ChillwindCamp,Chillwind Camp,0,28,1021,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3217,TheMaul,The Maul,1,2557,1022,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741952,0,0,0,0,0
3237,TheMaulUNUSED,The Maul UNUSED,1,2557,1023,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741952,0,0,0,0,0
3257,BonesofGrakkarond,Bones of Grakkarond,1,1377,1024,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3277,WarsongGulch,Warsong Gulch,489,0,1025,0,0,38,2172,243,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
3297,FrostwolfGraveyard,Frostwolf Graveyard,30,2597,1026,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3298,FrostwolfPass,Frostwolf Pass,30,2597,1027,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3299,DunBaldarPass,Dun Baldar Pass,30,2597,1028,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3300,IcebloodGraveyard,Iceblood Graveyard,30,2597,1029,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3301,SnowfallGraveyard,Snowfall Graveyard,30,2597,1030,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3302,StonehearthGraveyard,Stonehearth Graveyard,30,2597,1031,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3303,StormpikeGraveyard,Stormpike Graveyard,30,2597,1032,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3304,IcewingBunker,Icewing Bunker,30,2597,1033,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3305,StonehearthBunker,Stonehearth Bunker,30,2597,1034,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3306,WildpawRidge,Wildpaw Ridge,30,2597,1035,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3317,RevantuskVillage,Revantusk Village,0,47,1036,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3318,RockofDurotan,Rock of Durotan,30,2597,1037,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3319,SilverwingGrove,Silverwing Grove,1,331,1038,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3320,WarsongLumberMill,Warsong Lumber Mill,489,3277,1039,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3321,SilverwingHold,Silverwing Hold,489,3277,1040,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3337,WildpawCavern,Wildpaw Cavern,30,2597,1041,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3338,TheVeiledCleft,The Veiled Cleft,30,2597,1042,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3357,YojambaIsle,Yojamba Isle,0,33,1043,0,0,0,2172,245,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3358,ArathiBasin,Arathi Basin,529,0,1044,0,11,37,2172,219,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
3377,TheCoil,The Coil,309,1977,1045,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3378,AltarofHir'eek,Altar of Hir'eek,309,1977,1046,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3379,Shadra'zaar,Shadra'zaar,309,1977,1047,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3380,HakkariGrounds,Hakkari Grounds,309,1977,1048,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3381,NazeofShirvallah,Naze of Shirvallah,309,1977,1049,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3382,TempleofBethekk,Temple of Bethekk,309,1977,1050,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3383,TheBloodfirePit,The Bloodfire Pit,309,1977,1051,0,0,0,2172,245,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3384,AltaroftheBloodGod,Altar of the Blood God,309,1977,1052,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3397,Zanza'sRise,Zanza's Rise,309,1977,1053,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3398,EdgeofMadness,Edge of Madness,309,1977,1054,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3417,TrollbaneHall,Trollbane Hall,529,3358,1055,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3418,Defiler'sDen,Defiler's Den,529,3358,1056,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3419,Pagle'sPointe,Pagle's Pointe,309,1977,1057,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3420,Farm,Farm,529,3358,1058,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3421,Blacksmith,Blacksmith,529,3358,1059,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3422,LumberMill,Lumber Mill,529,3358,1060,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3423,GoldMine,Gold Mine,529,3358,1061,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3424,Stables,Stables,529,3358,1062,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3425,CenarionHold,Cenarion Hold,1,1377,1063,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3426,StaghelmPoint,Staghelm Point,1,1377,1064,0,0,0,2172,0,0,59,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3427,BronzebeardEncampment,Bronzebeard Encampment,1,1377,1065,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3428,AhnQiraj,Ahn'Qiraj,531,0,1161,0,0,352,2172,248,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
3429,RuinsofAhnQiraj,Ruins of Ahn'Qiraj,509,0,1162,0,0,352,2172,248,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
3446,TwilightsRun,Twilight's Run,1,1377,1163,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3447,Ortell'sHideout,Ortell's Hideout,1,1377,1164,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3448,ScarabTerrace,Scarab Terrace,509,3429,1068,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3449,General'sTerrace,General's Terrace,509,3429,1069,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3450,TheReservoir,The Reservoir,509,3429,1070,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3451,TheHatchery,The Hatchery,509,3429,1071,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3452,TheComb,The Comb,509,3429,1072,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3453,Watchers'Terrace,Watchers' Terrace,509,3429,1073,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3454,RuinsofAhn'Qiraj,Ruins of Ahn'Qiraj,1,1377,1074,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3456,Naxxrammas,Naxxramas,533,0,1158,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,3,0,0,0,0,21
3459,CityChannel,City,0,0,1160,3,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,512,0,0,0,0,0
3478,GatesofAhn'Qiraj,Gates of Ahn'Qiraj,1,0,1159,0,0,38,2172,176,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
3486,RavenholdtManor,Ravenholdt Manor,0,36,1076,0,0,0,2172,0,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
13649,TestDungeon,Test Dungeon,13,0,12255,0,0,0,0,0,0,0,0,0,0,0,3,-1,0,0,0,64,0,0,0,0,0
]]

-- Exported from https://wow.tools/dbc/?dbc=taxinodes&build=1.14.1.41030
local taxiNodesCSV = [[
Name_lang,Pos[0],Pos[1],Pos[2],MapOffset[0],MapOffset[1],FlightMapOffset[0],FlightMapOffset[1],ID,ContinentID,ConditionID,CharacterBitNumber,Flags,UiTextureKitID,Facing,SpecialIconConditionID,VisibilityConditionID,MountCreatureID[0],MountCreatureID[1]
Northshire Abbey,-8888.98,-0.54,94.39,0,0,0,0,1,0,0,1,0,0,0,0,0,308,0
"Stormwind, Elwynn",-8840.56,489.7,109.61,0,0,0,0,2,0,0,2,1,0,0,0,0,0,541
Programmer Isle,16391.81,16341.21,69.44,0,0,0,0,3,0,0,3,0,0,0,0,0,308,0
"Sentinel Hill, Westfall",-10628.89,1036.68,34.06,0,0,0,0,4,0,0,4,1,0,0,0,0,0,541
"Lakeshire, Redridge",-9429.1,-2231.4,68.65,0,0,0,0,5,0,0,5,1,0,0,0,0,0,541
"Ironforge, Dun Morogh",-4821.78,-1155.44,502.21,0,0,0,0,6,0,0,6,1,0,0,0,0,0,541
"Menethil Harbor, Wetlands",-3792.26,-783.29,9.06,0,0,0,0,7,0,0,7,1,0,0,0,0,0,541
"Thelsamar, Loch Modan",-5421.91,-2930.01,347.25,0,0,0,0,8,0,0,8,1,0,0,0,0,0,541
"Booty Bay, Stranglethorn",-14271.77,299.87,31.09,0,0,0,0,9,0,0,9,0,0,0,0,0,0,541
"The Sepulcher, Silverpine Forest",478.86,1536.59,131.32,0,0,0,0,10,0,0,10,2,0,0,0,0,3574,0
"Undercity, Tirisfal",1568.62,267.97,-43.1,0,0,0,0,11,0,0,11,2,0,0,0,0,3574,0
"Darkshire, Duskwood",-10515.46,-1261.65,41.34,0,0,0,0,12,0,0,12,1,0,0,0,0,0,541
"Tarren Mill, Hillsbrad",-0.06,-859.91,58.83,0,0,0,0,13,0,0,13,2,0,0,0,0,3574,0
"Southshore, Hillsbrad",-711.48,-515.48,26.11,0,0,0,0,14,0,0,14,1,0,0,0,0,0,541
Eastern Plaguelands,2253.4,-5344.9,83.38,0,0,0,0,15,0,0,15,0,0,0,0,0,0,541
"Refuge Pointe, Arathi",-1240.53,-2515.11,22.16,0,0,0,0,16,0,0,16,1,0,0,0,0,0,541
"Hammerfall, Arathi",-916.29,-3496.89,70.45,0,0,0,0,17,0,0,17,2,0,0,0,0,2224,0
"Booty Bay, Stranglethorn",-14444.29,509.62,26.2,0,0,0,0,18,0,0,18,2,0,0,0,0,2224,0
"Booty Bay, Stranglethorn",-14473.05,464.15,36.43,0,0,0,0,19,0,0,19,1,0,0,0,0,0,541
"Grom'gol, Stranglethorn",-12414.18,146.29,3.28,0,0,0,0,20,0,0,20,2,0,0,0,0,2224,0
"Kargath, Badlands",-6633.99,-2180.05,244.14,0,0,0,0,21,0,0,21,2,0,0,0,0,2224,0
"Thunder Bluff, Mulgore",-1197.21,29.71,176.95,0,0,0,0,22,1,0,22,2,0,0,0,0,2224,0
"Orgrimmar, Durotar",1677.59,-4315.71,61.17,0,0,0,0,23,1,0,23,2,0,0,0,0,2224,0
"Generic, World target for Zeppelin Paths",-6666,-2222.3,278.6,0,0,0,0,24,0,0,24,0,0,0,0,0,0,0
"Crossroads, The Barrens",-441.8,-2596.08,96.06,0,0,0,0,25,1,0,25,2,0,0,0,0,2224,0
"Auberdine, Darkshore",6341.38,557.68,16.29,0,0,0,0,26,1,0,26,1,0,0,0,0,0,3837
"Rut'theran Village, Teldrassil",8643.59,841.05,23.3,0,0,0,0,27,1,0,27,1,0,0,0,0,0,3837
"Astranaar, Ashenvale",2827.34,-289.24,107.16,0,0,0,0,28,1,0,28,1,0,0,0,0,0,3837
"Sun Rock Retreat, Stonetalon Mountains",966.57,1040.32,104.27,0,0,0,0,29,1,0,29,2,0,0,0,0,2224,0
"Freewind Post, Thousand Needles",-5407.71,-2414.3,90.32,0,0,0,0,30,1,0,30,2,0,0,0,0,2224,0
"Thalanaar, Feralas",-4491.88,-775.89,-39.52,0,0,0,0,31,1,0,31,1,0,0,0,0,0,3837
"Theramore, Dustwallow Marsh",-3825.37,-4516.58,10.44,0,0,0,0,32,1,0,32,1,0,0,0,0,0,541
"Stonetalon Peak, Stonetalon Mountains",2681.13,1461.68,232.88,0,0,0,0,33,1,0,33,1,0,0,0,0,0,3837
"Transport, Booty Bay - Ratchet",-1965.17,-5824.29,-1.06,0,0,0,0,34,1,0,34,0,0,0,0,0,0,0
"Transport, Orgrimmar Zepplins",1320.07,-4649.2,21.57,0,0,0,0,35,1,0,35,0,0,0,0,0,0,0
"Generic, World target",-8644.62,433.28,59.46,0,0,0,0,36,0,0,36,0,0,0,0,0,15665,0
"Nijel's Point, Desolace",139.24,1325.82,193.5,0,0,0,0,37,1,0,37,1,0,0,0,0,0,3837
"Shadowprey Village, Desolace",-1767.64,3263.89,4.94,0,0,0,0,38,1,0,38,2,0,0,0,0,2224,0
"Gadgetzan, Tanaris",-7223.97,-3734.59,8.39,0,0,0,0,39,1,0,39,1,0,0,0,0,0,541
"Gadgetzan, Tanaris",-7048.89,-3780.36,10.19,0,0,0,0,40,1,0,40,2,0,0,0,0,2224,0
"Feathermoon, Feralas",-4373.8,3338.65,12.27,0,0,0,0,41,1,0,41,1,0,0,0,0,0,3837
"Camp Mojache, Feralas",-4419.86,199.31,25.06,0,0,0,0,42,1,0,42,2,0,0,0,0,2224,0
"Aerie Peak, The Hinterlands",283.74,-2002.76,194.74,0,0,0,0,43,0,0,43,1,0,0,0,0,0,541
"Valormok, Azshara",3661.52,-4390.38,113.05,0,0,0,0,44,1,0,44,2,0,0,0,0,2224,0
"Nethergarde Keep, Blasted Lands",-11112.25,-3435.74,79.09,0,0,0,0,45,0,0,45,1,0,0,0,0,0,541
"Southshore Ferry, Hillsbrad",-986.43,-547.86,-3.86,0,0,0,0,46,0,0,46,0,0,0,0,0,0,0
"Transport, Grom'gol - Orgrimmar",-12418.77,235.43,1.12,0,0,0,0,47,0,0,47,0,0,0,0,0,0,0
"Bloodvenom Post, Felwood",5068.4,-337.22,367.41,0,0,0,0,48,1,0,48,2,0,0,0,0,2224,0
Moonglade,7458.45,-2487.21,462.33,0,0,0,0,49,1,0,49,1,0,0,0,0,0,3837
"Transport, Menethil Ships",0,0,0,0,0,0,0,50,0,0,50,0,0,0,0,0,0,0
"Transport, Rut'theran - Auberdine",0,0,0,0,0,0,0,51,0,0,51,0,0,0,0,0,0,0
"Everlook, Winterspring",6799.24,-4742.44,701.5,0,0,0,0,52,1,0,52,1,0,0,0,0,0,3837
"Everlook, Winterspring",6813.06,-4611.12,710.67,0,0,0,0,53,1,0,53,2,0,0,0,0,2224,0
"Transport, Feathermoon - Feralas",-4203.87,3284,-12.86,0,0,0,0,54,1,0,54,0,0,0,0,0,0,0
"Brackenwall Village, Dustwallow Marsh",-3147.39,-2842.18,34.61,0,0,0,0,55,1,0,55,2,0,0,0,0,2224,0
"Stonard, Swamp of Sorrows",-10456.97,-3279.25,21.35,0,0,0,0,56,0,0,56,2,0,0,0,0,2224,0
"Fishing Village, Teldrassil",8701.51,991.37,14.21,0,0,0,0,57,1,0,57,0,0,0,0,0,0,3837
"Zoram'gar Outpost, Ashenvale",3374.71,996.97,5.19,0,0,0,0,58,1,0,58,2,0,0,0,0,2224,0
"Dun Baldar, Alterac Valley",574.21,-46.65,37.61,0,0,0,0,59,30,0,59,1,0,0,0,0,0,541
"Frostwolf Keep, Alterac Valley",-1335.44,-319.69,90.66,0,0,0,0,60,30,0,60,2,0,0,0,0,3574,0
"Splintertree Post, Ashenvale",2302.39,-2524.55,104.4,0,0,0,0,61,1,0,61,2,0,0,0,0,2224,0
"Nighthaven, Moonglade",7793.61,-2403.47,489.32,0,0,0,0,62,1,0,62,1,0,0,0,0,0,3837
"Nighthaven, Moonglade",7787.72,-2404.1,489.56,0,0,0,0,63,1,0,63,2,0,0,0,0,2224,0
"Talrendis Point, Azshara",2721.99,-3880.64,100.87,0,0,0,0,64,1,0,64,1,0,0,0,0,0,3837
"Talonbranch Glade, Felwood",6205.88,-1949.63,571.29,0,0,0,0,65,1,0,65,1,0,0,0,0,0,3837
"Chillwind Camp, Western Plaguelands",931.32,-1430.11,64.67,0,0,0,0,66,0,0,66,1,0,0,0,0,0,541
"Light's Hope Chapel, Eastern Plaguelands",2271.09,-5340.8,87.11,0,0,0,0,67,0,0,67,1,0,0,0,0,0,541
"Light's Hope Chapel, Eastern Plaguelands",2327.41,-5286.89,81.78,0,0,0,0,68,0,0,68,2,0,0,0,0,3574,0
Moonglade,7470.39,-2123.38,492.34,0,0,0,0,69,1,0,69,2,0,0,0,0,2224,0
"Flame Crest, Burning Steppes",-7504.03,-2187.54,165.53,0,0,0,0,70,0,0,70,2,0,0,0,0,2224,0
"Morgan's Vigil, Burning Steppes",-8364.61,-2738.35,185.46,0,0,0,0,71,0,0,71,1,0,0,0,0,0,541
"Cenarion Hold, Silithus",-6811.39,836.74,49.81,0,0,0,0,72,1,0,72,2,0,0,0,0,2224,0
"Cenarion Hold, Silithus",-6761.83,772.03,88.91,0,0,0,0,73,1,0,73,1,0,0,0,0,0,3837
"Thorium Point, Searing Gorge",-6552.59,-1168.27,309.31,0,0,0,0,74,0,0,74,1,0,0,0,0,0,541
"Thorium Point, Searing Gorge",-6554.93,-1100.05,309.57,0,0,0,0,75,0,0,75,2,0,0,0,0,2224,0
"Revantusk Village, The Hinterlands",-635.26,-4720.5,5.38,0,0,0,0,76,0,0,76,2,0,0,0,0,2224,0
"Camp Taurajo, The Barrens",-2380.67,-1882.67,95.85,0,0,0,0,77,1,0,77,2,0,0,0,0,2224,0
Naxxramas,3133.31,-3399.93,139.53,0,0,0,0,78,0,0,78,0,0,0,0,0,0,0
"Marshal's Refuge, Un'Goro Crater",-6113.82,-1142.7,-187.63,0,0,0,0,79,1,0,79,3,0,0,0,0,2224,541
"Ratchet, The Barrens",-894.59,-3773.01,11.48,0,0,0,0,80,1,0,80,3,0,0,0,0,2224,541
"Plaguewood Tower, Eastern Plaguelands",2998.71,-3050.1,117.19,0,0,0,0,84,0,0,84,3,0,0,0,0,17660,17660
"Northpass Tower, Eastern Plaguelands",3109.31,-4285.13,109.45,0,0,0,0,85,0,0,85,3,0,0,0,0,3574,541
"Eastwall Tower, Eastern Plaguelands",2499.23,-4742.85,93.5,0,0,0,0,86,0,0,86,3,0,0,0,0,3574,541
"Crown Guard Tower, Eastern Plaguelands",1857.56,-3658.47,143.73,0,0,0,0,87,0,0,87,3,0,0,0,0,3574,541
]]

L.areaTable = addon.LoadCSVData(areaTableCSV, "ID")
L.taxiNodes = addon.LoadCSVData(taxiNodesCSV, "ID")
