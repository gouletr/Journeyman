local addonName, addon = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "esMX")
if not L then return end

-- L["AUTO_SET_WAYPOINT"] = "Auto Set Waypoint Arrow"
-- L["AUTO_SET_WAYPOINT_DESC"] = "Automatically set TomTom waypoint arrow to next step."
-- L["AUTO_SET_WAYPOINT_MIN"] = "Minimum Distance"
-- L["AUTO_SET_WAYPOINT_MIN_DESC"] = "Minimum distance to automatically set TomTom waypoint arrow."
-- L["CHAPTER_INDEX_LABEL"] = "Chapter Index"
-- L["CHAPTER_TITLE"] = "Chapter %d: %s"
-- L["CHAPTER_TITLE_LABEL"] = "Chapter Title"
-- L["CLAMP_WINDOW"] = "Clamp Window"
-- L["CLAMP_WINDOW_DESC"] = "Prevent window from moving outside the screen."
-- L["DEBUGGING_OPTIONS"] = "Debugging Options"
-- L["DELETE_CHAPTER"] = "Delete Chapter"
-- L["DELETE_JOURNEY"] = "Delete Journey"
-- L["DELETE_STEP"] = "Delete Step"
-- L["DIE_AND_SPIRIT_RES"] = "You can choose to die now and use spirit healer service."
-- L["DROPDOWN_ACCEPT_QUEST"] = "Accept Quest"
-- L["DROPDOWN_BIND_HEARTHSTONE"] = "Bind Hearthstone"
-- L["DROPDOWN_COMPLETE_QUEST"] = "Complete Quest"
-- L["DROPDOWN_FLY_TO"] = "Fly To"
-- L["DROPDOWN_LEARN_FLIGHT_PATH"] = "Learn Flight Path"
-- L["DROPDOWN_REACH_LEVEL"] = "Reach Level"
-- L["DROPDOWN_TURNIN_QUEST"] = "Turn-in Quest"
-- L["DROPDOWN_USE_HEARTHSTONE"] = "Use Hearthstone"
-- L["ENABLE_DEBUG"] = "Enable Debug"
-- L["ENABLE_DEBUG_DESC"] = "Toggle debugging mode."
-- L["ENABLE_DEBUG_TEXT"] = "This option controls whether debugging information and tools are enabled or not. This can add a lot of messages to the console, and shouldn't be necessary unless there are problems."
-- L["FONT_SIZE"] = "Font Size"
-- L["FONT_SIZE_DESC"] = "Font size used in the window."
-- L["IMPORT_JOURNEY"] = "Import From Character"
-- L["IMPORT_JOURNEY_DESC"] = "Import journey from this character."
-- L["JOURNEY_INDEX_LABEL"] = "Journey Index"
-- L["JOURNEY_OPTIONS"] = "Journey Options"
-- L["JOURNEY_TITLE_LABEL"] = "Journey Title"
-- L["LINE_SPACING"] = "Line Spacing"
-- L["LINE_SPACING_DESC"] = "Space between lines of text in the window."
-- L["LOCK_WINDOW"] = "Lock Window"
-- L["LOCK_WINDOW_DESC"] = "Toggle window lock to prevent moving or resizing."
-- L["MISSING_CHAPTER_TITLE"] = "No Chapter"
-- L["NEW_CHAPTER"] = "New Chapter"
-- L["NEW_CHAPTER_TITLE"] = "New Chapter"
-- L["NEW_JOURNEY"] = "New Journey"
-- L["NEW_JOURNEY_TITLE"] = "New Journey"
-- L["NEW_STEP"] = "New Step"
-- L["NOT_A_NUMBER"] = "Not a Number"
-- L["NOT_A_STRING"] = "Not a String"
-- L["NO_JOURNEY_SELECTED"] = "No journey selected, please select a journey to continue."
-- L["NO_VALUE"] = "No Value"
-- L["OPEN_OPTIONS"] = "Open Options"
-- L["RESET_POSITION"] = "Reset Position"
-- L["RESET_POSITION_DESC"] = "Reset the window position."
-- L["SAVED_PER_CHARACTER"] = "Saved per character."
-- L["SELECT_CHAPTER"] = "Select Chapter"
-- L["SELECT_JOURNEY"] = "Select Journey"
-- L["SELECT_JOURNEY_DESC"] = "Select which journey to use."
-- L["SELECT_STEP"] = "Select Step"
-- L["SHOW_COMPLETED_STEPS"] = "Show Completed Steps"
-- L["SHOW_COMPLETED_STEPS_DESC"] = "Toggle showing completed steps."
-- L["SHOW_QUEST_LEVEL"] = "Show Quest Level"
-- L["SHOW_QUEST_LEVEL_DESC"] = "Toggle showing quest level."
-- L["SHOW_SCROLL_BAR"] = "Show Scroll Bar"
-- L["SHOW_SCROLL_BAR_DESC"] = "Toggle showing scroll bar next to the window."
-- L["SHOW_SKIPPED_STEPS"] = "Show Skipped Steps"
-- L["SHOW_SKIPPED_STEPS_DESC"] = "Toggle showing skipped steps."
-- L["SHOW_WINDOW"] = "Show Window"
-- L["SHOW_WINDOW_DESC"] = "Toggle showing window."
-- L["STEPS_SHOWN"] = "Number of Steps"
-- L["STEPS_SHOWN_DESC"] = "Number of steps shown in the window."
-- L["STEP_ACCEPT_QUEST"] = "Accept %s"
-- L["STEP_BIND_HEARTHSTONE"] = "Bind %s to %s"
-- L["STEP_COMPLETE_QUEST"] = "Complete %s"
-- L["STEP_DATA_LABEL"] = "Step Data"
-- L["STEP_FLY_TO"] = "Fly to %s"
-- L["STEP_GO_TALK_TO"] = "Go talk to"
-- L["STEP_GO_TO"] = "Go to"
-- L["STEP_INDEX_LABEL"] = "Step Index"
-- L["STEP_LEARN_FLIGHT_PATH"] = "Learn flight path to %s"
-- L["STEP_NOTE"] = "Note: %s"
-- L["STEP_NOTE_LABEL"] = "Step Note"
-- L["STEP_REACH_LEVEL"] = "Reach level %d"
-- L["STEP_TURNIN_QUEST"] = "Turn-in %s"
-- L["STEP_TYPE_LABEL"] = "Step Type"
-- L["STEP_USE_HEARTHSTONE"] = "Use %s to %s"
-- L["UNDEFINED"] = "Undefined"
-- L["UPDATE_ACTIVE_JOURNEY"] = "Update Active Journey"
-- L["UPDATE_ACTIVE_JOURNEY_CONFIRM"] = "Enabling this option will add new steps to the active journey during your adventures, continue?"
-- L["UPDATE_ACTIVE_JOURNEY_DESC"] = "Update active journey with new steps."
-- L["UPDATE_ACTIVE_JOURNEY_DISABLED"] = "Option 'Update Active Journey' has been disabled for this character."
-- L["UPDATE_ACTIVE_JOURNEY_TEXT"] = "Enabling this option will cause new steps to be appended into the active journey chapter. Changing active journey will disable this option."
-- L["UPDATE_FREQUENCY"] = "Update Frequency (seconds)"
-- L["UPDATE_FREQUENCY_CONFIRM"] = "Changing this option requires a user interface reload, continue?"
-- L["UPDATE_FREQUENCY_DESC"] = "Period of time in seconds between each update check."
-- L["UPDATE_FREQUENCY_TEXT"] = "This option controls the frequency of updates. Decreasing the value will cause the addon to check more often if updates are needed. It is recommended not to change this value."
-- L["UPDATE_OPTIONS"] = "Update Options"
-- L["WINDOW_BG_COLOR"] = "Background Color"
-- L["WINDOW_BG_COLOR_DESC"] = "Background color of the window."
-- L["WINDOW_HEIGHT"] = "Height"
-- L["WINDOW_HEIGHT_DESC"] = "Height of the window."
-- L["WINDOW_LEVEL"] = "Level"
-- L["WINDOW_LEVEL_DESC"] = "Control the level (display order) of the window."
-- L["WINDOW_OPTIONS"] = "Window Options"
-- L["WINDOW_STRATA"] = "Strata"
-- L["WINDOW_STRATA_DESC"] = "Control the strata (display layer) of the window."
-- L["WINDOW_WIDTH"] = "Width"
-- L["WINDOW_WIDTH_DESC"] = "Width of the window."
-- Exported from https://wow.tools/dbc/?dbc=areatable&build=1.14.1.41030&locale=esMX
local areaTableCSV = [[
ID,ZoneName,AreaName_lang,ContinentID,ParentAreaID,AreaBit,SoundProviderPref,SoundProviderPrefUnderwater,AmbienceID,UwAmbience,ZoneMusic,UwZoneMusic,ExplorationLevel,IntroSound,UwIntroSound,FactionGroupMask,Ambient_multiplier,MountFlags,PvpCombatWorldStateID,WildBattlePetLevelMin,WildBattlePetLevelMax,WindSettingsID,Flags[0],Flags[1],LiquidTypeID[0],LiquidTypeID[1],LiquidTypeID[2],LiquidTypeID[3]
1,DunMorogh,Dun Morogh,0,0,119,0,11,42,2172,8,0,0,0,0,2,0,0,-1,0,0,0,65,0,0,0,0,0
2,Longshore,Playa Larga,0,40,120,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3,Badlands,Tierras Inhóspitas,0,0,121,0,11,25,2172,7,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
4,BlastedLands,Las Tierras Devastadas,0,0,122,0,11,210,2172,7,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
7,DarkwaterCove,Cala Aguasnegras,0,33,123,0,11,0,2172,3,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
8,SwampofSorrows,Pantano de las Penas,0,0,124,0,11,33,2172,223,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
9,NorthshireValley,Valle de Villanorte,0,12,125,0,11,35,2172,1,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
10,Duskwood,Bosque del Ocaso,0,0,617,0,11,40,2172,2,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
11,Wetlands,Los Humedales,0,0,618,0,11,44,2172,227,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
12,ElwynnForest,Bosque de Elwynn,0,0,126,0,11,35,2172,1,0,0,0,0,2,0,0,-1,0,0,0,64,0,0,0,0,0
13,TheWorldTree,Árbol del Mundo,0,10,555,0,11,48,2172,11,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
14,Durotar,Durotar,1,0,127,0,11,25,2172,9,0,0,0,0,4,0,0,-1,0,0,0,64,0,0,0,0,0
15,DustwallowMarsh,Marjal Revolcafango,1,0,128,0,11,33,2172,227,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
16,Azshara,Azshara,1,0,129,0,11,31,2172,205,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
17,TheBarrens,Los Baldíos,1,0,130,0,11,38,2172,7,0,0,0,0,4,0,0,-1,0,0,0,64,0,0,0,0,0
18,CrystalLake,Lago de Cristal,0,12,131,0,11,35,2172,1,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
19,Zul'Gurub,Zul'Gurub,0,33,574,0,11,32,2172,3,0,40,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
20,Moonbrook,Arroyo de la Luna,0,40,132,0,11,0,2172,9,0,14,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
21,KulTiras,Kul Tiras,0,0,133,0,11,0,2172,8,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
22,ProgrammerIsle,Isla del Programador,451,0,547,0,11,38,2172,2,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
23,NorthshireRiver,Río de Villanorte,0,12,134,0,11,35,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
24,Northshireabbey,Abadía de Villanorte,0,12,135,73,11,35,2172,1,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
25,BlackrockMountain,Montaña Roca Negra,0,0,136,0,11,46,2172,10,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
26,Lighthouse,Faro,0,40,602,0,11,0,2172,7,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
28,WesternPlaguelands,Tierras de la Peste del Oeste,0,0,137,0,11,37,2172,205,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
30,Nine,Nine,0,0,138,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
32,TheCemetary,El Cementerio,0,10,139,0,11,0,2172,2,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
33,StranglethornJungle,Vega de Tuercespina,0,0,140,0,11,32,2172,3,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
34,EchoRidgeMine,Mina del Eco,0,12,141,0,11,35,2172,1,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
35,BootyBay,Bahía del Botín,0,33,142,0,11,0,2172,3,0,42,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
36,AlteracMountains,Montañas de Alterac,0,0,143,0,11,31,2172,1,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
37,LakeNazferiti,Lago Nazferiti,0,33,144,0,11,0,2172,3,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
38,LochModan,Loch Modan,0,0,145,0,11,31,2172,1,0,0,0,0,2,0,0,-1,0,0,0,64,0,0,0,0,0
40,Westfall,Páramos de Poniente,0,0,146,0,11,47,2172,9,0,0,0,0,2,0,0,-1,0,0,0,64,0,0,0,0,0
41,DeadwindPass,Paso de la Muerte,0,0,556,0,11,49,2172,2,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
42,Darkshire,Villa Oscura,0,10,147,0,11,0,2172,2,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
43,WildShore,Orilla Salvaje,0,33,148,0,11,0,2172,3,0,42,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
44,RedridgeMountains,Montañas Crestagrana,0,0,149,0,11,31,2172,1,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
45,ArathiHighlands,Tierras Altas de Arathi,0,0,150,0,11,30,2172,8,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
46,BurningSteppes,Las Estepas Ardientes,0,0,151,0,11,46,2172,10,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
47,TheHinterlands,Tierras del Interior,0,0,152,0,11,31,2172,1,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
49,DeadMansHole,El Agujero del Muerto,0,22,153,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
51,SearingGorge,La Garganta de Fuego,0,0,154,0,11,46,2172,10,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
53,ThievesCamp,Campamento de Ladrones,0,12,155,0,11,35,2172,1,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
54,JasperlodeMine,Cantera de Jaspe,0,12,550,0,11,35,2172,1,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
55,ValleyofHeroesUNUSED,Valley of Heroes UNUSED,0,12,156,0,11,35,2172,17,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
56,Heroes'Vigil,Vigilia de los Héroes,0,12,157,0,11,35,2172,1,0,0,303,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
57,FargodeepMine,Mina Abisal,0,12,158,0,11,35,2172,1,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
59,NorthshireVineyards,Viñedos de Villanorte,0,12,159,0,11,35,2172,1,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
60,Forest'sEdge,Linde del bosque,0,12,606,0,11,35,2172,1,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
61,ThunderFalls,Cataratas del Trueno,0,12,160,0,11,35,2172,1,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
62,PumpkinPatch,Plantación de Calabazas de Brackwell,0,12,161,0,11,35,2172,1,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
63,TheStonefieldFarm,La Granja Pedregosa,0,12,162,0,11,35,2172,1,0,6,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
64,TheMaclureVineyards,Los Viñedos de Maclure,0,12,163,0,11,35,2172,1,0,6,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
65,***On Map Dungeon***,***On Map Dungeon***,0,0,164,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,68,0,0,0,0,0
66,***On Map Dungeon***,***On Map Dungeon***,1,0,165,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,68,0,0,0,0,0
67,***On Map Dungeon***,***On Map Dungeon***,17,0,166,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,68,0,0,0,0,0
68,LakeEverstill,Lago Sempiterno,0,44,557,0,11,0,2172,1,0,16,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
69,Lakeshire,Villa del Lago,0,44,167,0,11,0,2172,1,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
70,Stonewatch,Petravista,0,44,168,0,11,0,2172,1,0,24,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
71,StonewatchFalls,Cascadas Petravista,0,44,627,0,11,0,2172,1,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
72,TheDarkPortal,El Portal Oscuro,0,4,169,0,11,210,2172,7,0,63,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
73,TheTaintedScar,Escara Impía,0,4,170,0,11,0,2172,7,0,50,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
74,PoolofTears,Charca de Lágrimas,0,8,171,0,11,0,2172,0,0,43,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
75,Stonard,Rocal,0,8,172,0,11,0,2172,0,0,37,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
76,FallowSanctuary,Retiro Fangoso,0,8,173,0,11,0,2172,0,0,37,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
77,Anvilmar,Yunquemar,0,1,174,0,11,0,2172,8,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
80,StormwindMountains,Montañas de Ventormenta,0,12,175,0,11,35,2172,17,0,10,0,0,2,0,0,-1,0,0,0,1073741888,0,0,0,0,0
81,JeffNEQuadrantChanged,Jeff NE Quadrant Changed,451,22,575,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
82,JeffNWQuadrant,Jeff NW Quadrant,451,22,176,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
83,JeffSEQuadrant,Jeff SE Quadrant,451,22,177,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
84,JeffSWQuadrant,Jeff SW Quadrant,451,22,178,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
85,TirisfalGlades,Claros de Tirisfal,0,0,179,0,11,40,2172,2,0,0,0,0,4,0,0,-1,0,0,0,64,0,0,0,0,0
86,StoneCircleLake,Lago del Hito,0,12,180,0,11,35,2172,1,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
87,Goldshire,Villadorada,0,12,548,0,11,35,2172,1,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
88,EastvaleLoggingCamp,Aserradero de la Vega del Este,0,12,181,0,11,35,2172,1,0,6,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
89,ThunderFallsOrchard,Vergel del Lago Espejo,0,12,182,0,11,35,2172,1,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
91,TowerofAzora,Torre de Azora,0,12,183,0,11,35,2172,1,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
92,MirrorLake,Lago Espejo,0,12,558,0,11,35,2172,1,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
93,Vul'GolOgreMound,Túmulo de Vul'Gol,0,10,628,0,11,0,2172,214,0,28,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
94,RavenHill,Cerro del Cuervo,0,10,184,0,11,0,2172,2,0,24,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
95,RedridgeCanyon,Cañones de Crestagrana,0,44,185,0,11,0,2172,1,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
96,TowerofIlgalar,Torre de Ilgalar,0,44,186,0,11,0,2172,1,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
97,Alther'sMill,Molino de Alther,0,44,187,0,11,0,2172,1,0,19,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
98,RethbanCaverns,Cavernas de Rethban,0,44,188,0,11,0,2172,1,0,17,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
99,RebelCamp,Asentamiento Rebelde,0,33,189,0,11,0,2172,3,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
100,Nesingwary'sExpedition,Expedición de Nesingwary,0,33,585,0,11,0,2172,3,0,31,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
101,Kurzen'sCompound,Base de Kurzen,0,33,190,0,11,0,2172,3,0,32,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
102,RuinsofZul'Kunda,Ruinas de Zul'Kunda,0,33,586,0,11,0,2172,3,0,41,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
103,RuinsofZul'Mamwe,Ruinas de Zul'Mamwe,0,33,191,0,11,0,2172,3,0,40,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
104,TheVileReef,El Arrecife Mortal,0,33,192,0,11,0,2172,3,0,37,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
105,Mosh'OggOgreMound,Túmulo Ogro Mosh'Ogg,0,33,193,0,11,0,2172,3,0,42,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
106,TheStockpile,Las Reservas,0,33,194,0,11,0,2172,3,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
107,Saldean'sFarm,Finca de Saldean,0,40,195,0,11,0,2172,9,0,14,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
108,SentinelHill,Colina del Centinela,0,40,196,0,11,0,2172,9,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
109,Furlbrow'sPumpkinFarm,Plantación de Calabazas de Cejade,0,40,197,0,11,0,2172,9,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
111,JangolodeMine,Mina de Jango,0,40,198,0,11,0,2172,9,0,12,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
113,GoldCoastQuarry,Mina de la Costa del Oro,0,40,576,0,11,0,2172,9,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
115,WestfallLighthouse,Faro de Poniente,0,40,199,0,11,24,2172,9,0,17,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
116,MistyValley,Valle Brumoso,0,8,200,0,11,0,2172,0,0,39,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
117,Grom'golBaseCamp,Campamento Grom'gol,0,33,629,0,11,0,2172,228,0,35,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
118,Whelgar'sExcavationSite,Excavación de Whelgar,0,11,201,0,11,0,2172,191,0,22,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
120,WestbrookGarrison,Cuartel de Arroyoeste,0,12,559,0,11,35,2172,0,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
121,TranquilGardensCemetery,Cementerio del Jardín Sereno,0,10,202,0,11,0,2172,15,0,28,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
122,ZuuldaiaRuins,Ruinas Zuuldaia,0,33,203,0,11,0,2172,3,0,37,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
123,Bal'lalRuins,Ruinas de Bal'lal,0,33,204,0,11,0,2172,3,0,34,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
125,Kal'aiRuins,Ruinas de Kal'ai,0,33,205,0,11,0,2172,3,0,35,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
126,TkashiRuins,Ruinas de Tkashi,0,33,206,0,11,0,2172,3,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
127,Balia'mahRuins,Ruinas de Balia'mah,0,33,207,0,11,0,2172,3,0,40,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
128,Ziata'jaiRuins,Ruinas de Ziata'jai,0,33,208,0,11,0,2172,3,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
129,MizjahRuins,Ruinas de Mizjah,0,33,209,0,11,0,2172,3,0,37,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
130,SilverpineForest,Bosque de Argénteos,0,0,210,0,11,28,2172,2,0,0,0,0,4,0,0,-1,0,0,0,64,0,0,0,0,0
131,Kharanos,Kharanos,0,1,211,0,11,0,2172,0,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
132,ColdridgeValley,Valle de Crestanevada,0,1,212,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
133,Gnomeregan,Gnomeregan,0,1,213,0,11,42,2172,8,0,10,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
134,Gol'BolarQuarry,Cantera de Gol'Bolar,0,1,214,0,11,0,2172,8,0,10,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
135,FrostmaneHold,Poblado Peloescarcha,0,1,215,0,11,0,2172,0,0,7,121,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
136,TheGrizzledDen,El Cubil Pardo,0,1,216,0,11,0,2172,0,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
137,BrewnallVillage,Las Birras,0,1,217,0,11,0,2172,0,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
138,MistyPineRefuge,Refugio Pinobruma,0,1,218,0,11,0,2172,8,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
139,EasternPlaguelands,Tierras de la Peste del Este,0,0,219,0,11,37,2172,205,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
141,Teldrassil,Teldrassil,1,0,220,0,11,48,2172,11,0,0,0,0,2,0,0,-1,0,0,0,64,0,0,0,0,0
142,Ironband'sExcavationSite,Excavación de Vetaferro,0,38,221,0,11,0,2172,1,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
143,Mo'groshStronghold,Fortaleza de Mo'grosh,0,38,222,0,11,0,2172,14,0,18,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
144,Thelsamar,Thelsamar,0,38,223,0,11,0,2172,1,0,10,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
145,AlgazGate,Puerta de Algaz,0,38,224,0,11,0,2172,1,0,18,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
146,StonewroughtDam,Presa de las Tres Cabezas,0,38,225,0,11,230,2172,1,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
147,TheFarstriderLodge,Cabaña del Errante,0,38,226,0,11,0,2172,1,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
148,Darkshore,Costa Oscura,1,0,227,0,11,28,2172,191,0,0,0,0,2,0,0,-1,0,0,0,64,0,0,0,0,0
149,SilverStreamMine,Mina de Fuenteplata,0,38,228,0,11,0,2172,1,0,12,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
150,MenethilHarbor,Puerto de Menethil,0,11,229,0,11,0,2172,191,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
151,DesignerIsland,Isla del Diseñador,451,0,560,0,11,47,2172,226,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
152,TheBulwark,El Baluarte,0,85,230,0,11,0,2172,2,0,9,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
153,RuinsofLordaeron,Ruinas de Lordaeron,0,85,607,0,11,0,2172,2,0,10,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
154,Deathknell,Camposanto,0,85,231,0,11,0,2172,15,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
155,NightWeb'sHollow,Hoya Nocturácnidas,0,85,232,0,11,0,2172,2,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
156,SollidenFarmstead,Hacienda Solliden,0,85,233,0,11,0,2172,2,0,6,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
157,AgamandMills,Molinos de Agamand,0,85,234,0,11,0,2172,15,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
158,AgamandFamilyCrypt,Cripta de la Familia Agamand,0,85,235,0,11,0,2172,15,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
159,Brill,Rémol,0,85,236,0,11,0,2172,15,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
160,WhisperingGardens,Jardines de los Susurros,0,85,237,0,11,0,2172,2,0,12,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
161,TerraceofRepose,Bancal del Reposo,0,85,238,0,11,0,2172,2,0,10,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
162,BrightwaterLake,Lago Aguasclaras,0,85,239,0,11,0,2172,2,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
163,Gunther'sRetreat,Refugio de Gunther,0,85,240,0,11,0,2172,2,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
164,Garren'sHaunt,Granja de Garren,0,85,241,0,11,0,2172,2,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
165,BalnirFarmstead,Hacienda Balnir,0,85,242,0,11,0,2172,15,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
166,ColdHearthManor,Mansión Fríogar,0,85,243,0,11,0,2172,2,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
167,CrusaderOutpost,Avanzada de los Cruzados,0,85,244,0,11,0,2172,2,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
168,TheNorthCoast,La Costa Norte,0,85,245,0,11,0,2172,2,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
169,Whispering Shore,Costa Murmurante,0,85,577,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
170,LordamereLake,Lago Lordamere,0,0,246,0,11,31,2172,2,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
172,FenrisIsle,Isla de Fenris,0,130,247,0,11,0,2172,2,0,18,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
173,Faol'sRest,Tumba de Faol,0,85,620,0,11,0,2172,2,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
186,Dolanaar,Dolanaar,1,141,622,0,11,0,2172,11,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
187,DarnassusUNUSED,Darnassus UNUSED,1,141,248,0,11,48,2172,76,0,7,63,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
188,Shadowglen,Cañada Umbría,1,141,561,0,11,0,2172,11,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
189,Steelgrill'sDepot,Almacén de Brasacerada,0,1,249,0,11,0,2172,8,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
190,Hearthglen,Vega del Amparo,0,28,250,0,11,0,2172,0,0,56,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
192,NorthridgeLumberCamp,Aserradero Crestanorte,0,28,251,0,11,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
193,RuinsofAndorhal,Ruinas de Andorhal,0,28,252,0,11,0,2172,15,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
195,SchoolofNecromancy,Escuela de Nigromancia,0,28,253,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
196,Uther'sTomb,Tumba de Uther,0,28,578,0,11,0,2172,15,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
197,SorrowHill,Colina de las Penas,0,28,254,0,11,0,2172,0,0,50,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
198,TheWeepingCave,La Cueva del Llanto,0,28,255,0,11,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
199,FelstoneField,Campo de Piedramácula,0,28,256,0,11,0,2172,10,0,50,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
200,Dalson'sTears,Lágrimas de Dalson,0,28,257,0,11,0,2172,10,0,54,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
201,Gahrron'sWithering,Gangrena de Gahrron,0,28,258,0,11,0,2172,10,0,57,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
202,TheWrithingHaunt,El Tormento,0,28,259,0,11,0,2172,10,0,46,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
203,MardenholdeKeep,Fortaleza de Mardenholde,0,28,260,0,11,37,2172,193,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
204,PyrewoodVillage,Aldea Piroleña,0,130,261,0,11,0,2172,191,0,15,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
205,DunModr,Dun Modr,0,11,262,0,11,0,2172,191,0,28,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
206,Westfall,Páramos de Poniente,36,0,263,0,11,47,2172,9,0,0,0,0,0,0,0,-1,0,0,0,65600,0,0,0,0,0
207,TheGreatSea,Mare Magnum,36,0,264,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
208,UnusedIroncladcove,Unused Ironcladcove,36,0,265,76,11,34,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
209,ShadowfangKeep,Castillo de Colmillo Oscuro,33,0,266,0,11,28,2172,2,0,16,0,0,4,0,0,-1,0,0,0,0,0,0,0,0,0
210,***On Map Dungeon***,***On Map Dungeon***,36,0,267,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,68,0,0,0,0,0
211,IceflowLake,Lago Glacial,0,1,268,0,11,0,2172,8,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
212,Helm'sBedLake,Lago de Helm,0,1,269,0,11,0,2172,8,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
213,DeepElemMine,Mina de Elem,0,130,270,0,11,0,2172,2,0,13,324,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
214,TheGreatSea,Mare Magnum,0,0,271,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
215,Mulgore,Mulgore,1,0,272,0,11,30,2172,9,0,0,0,0,4,0,0,-1,0,0,0,64,0,0,0,0,0
219,AlexstonFarmstead,Hacienda de Alexston,0,40,273,0,11,0,2172,9,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
220,RedCloudMesa,Mesa de la Nube Roja,1,215,562,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
221,CampNarache,Campamento Narache,1,215,274,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
222,BloodhoofVillage,Poblado Pezuña de Sangre,1,215,275,0,11,0,2172,226,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
223,StonebullLake,Lago Toro de Piedra,1,215,276,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
224,RavagedCaravan,Caravana Devastada,1,215,277,0,11,0,2172,9,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
225,RedRocks,Roca Roja,1,215,278,0,11,0,2172,9,0,9,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
226,TheSkitteringDark,Penumbra de las Celerácnidas,0,130,551,0,11,0,2172,0,0,11,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
227,Valgan'sField,Campo de Valgan,0,130,279,0,11,0,2172,2,0,11,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
228,TheSepulcher,El Sepulcro,0,130,280,0,11,0,2172,15,0,10,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
229,Olsen'sFarthing,Finca de Olsen,0,130,281,0,11,0,2172,0,0,12,161,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
230,TheGreymaneWall,La Muralla de Cringris,0,130,282,0,11,0,2172,0,0,18,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
231,Beren'sPeril,El Desafío de Beren,0,130,283,0,11,0,2172,191,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
232,TheDawningIsles,Islas del Alba,0,130,284,0,11,0,2172,2,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
233,Ambermill,Molino Ámbar,0,130,285,0,11,0,2172,191,0,15,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
235,FenrisKeep,Castillo de Fenris,0,130,608,0,11,0,2172,219,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
236,Shadowfang Keep,Castillo de Colmillo Oscuro,0,130,286,0,11,28,2172,2,0,16,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
237,TheDecrepitFerry,El Viejo Embarcadero,0,130,287,0,11,0,2172,2,0,16,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
238,Malden'sOrchard,Huerta de Malden,0,130,587,0,11,0,2172,2,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
239,TheIvarPatch,Los Dominios de Ivar,0,130,588,0,11,0,2172,2,0,11,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
240,TheDeadField,El Campo Muerto,0,130,288,0,11,0,2172,2,0,12,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
241,TheRottingOrchard,El Vergel Pútrido,0,10,289,0,11,0,2172,2,0,26,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
242,BrightwoodGrove,Arboleda del Destello,0,10,290,0,11,0,2172,2,0,28,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
243,ForlornRowe,Loma Inhóspita,0,10,291,0,11,0,2172,2,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
244,TheWhippleEstate,El Raquitismo,0,10,292,0,11,0,2172,2,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
245,TheYorgenFarmstead,La Hacienda Yorgen,0,10,563,0,11,0,2172,2,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
246,TheCauldron,La Caldera,0,51,293,0,11,0,2172,10,0,48,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
247,GrimesiltDigSite,Excavación de Limugre,0,51,294,0,11,0,2172,0,0,45,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
249,DreadmaulRock,Roca Machacamiedo,0,46,1,0,11,0,2172,10,0,50,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
250,RuinsofThaurisan,Ruinas de Thaurissan,0,46,579,0,11,0,2172,0,0,54,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
251,FlameCrest,Peñasco Llamarada,0,46,2,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
252,BlackrockStronghold,Bastión de Roca Negra,0,46,3,0,11,0,2172,0,0,57,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
253,ThePillarofAsh,El Pilar de Ceniza,0,46,4,0,11,0,2172,0,0,56,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
254,BlackrockMountain,Montaña Roca Negra,0,46,630,0,11,0,2172,10,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
255,AltarofStorms,Altar de la Tempestad,0,46,5,0,11,0,2172,10,0,59,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
256,Aldrassil,Aldrassil,1,141,6,0,11,0,2172,11,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
257,ShadowthreadCave,Gruta Narácnida,1,141,7,0,11,0,2172,11,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
258,FelRock,Roca Mácula,1,141,8,0,11,0,2172,11,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
259,LakeIl'Ameth,Lago Al'Ameth,1,141,9,0,11,0,2172,11,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
260,StarbreezeVillage,Aldea Brisa Estelar,1,141,10,0,11,0,2172,11,0,6,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
261,GnarlpineHold,Tierras de los Tuercepinos,1,141,11,0,11,0,2172,0,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
262,Ban'ethilBarrowDen,Túmulo de Ban'ethil,1,141,12,0,11,0,2172,11,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
263,TheCleft,La Grieta,1,141,13,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
264,TheOracleGlade,El Claro del Oráculo,1,141,14,0,11,0,2172,11,0,9,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
265,WellspringRiver,Río Primigenio,1,141,15,0,11,0,2172,0,0,11,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
266,WellspringLake,Lago Primigenio,1,141,16,0,11,0,2172,0,0,9,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
267,HillsbradFoothills,Laderas de Trabalomas,0,0,17,0,11,31,2172,1,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
268,AzsharaCrater,Cráter de Azshara,37,0,580,0,11,42,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
269,DunAlgaz,Dun Algaz,0,0,18,0,11,31,2172,0,0,18,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
271,Southshore,Costasur,0,267,615,0,11,0,2172,1,0,22,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
272,TarrenMill,Molino Tarren,0,267,19,0,11,0,2172,182,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
275,DurnholdeKeep,Castillo de Durnholde,0,267,20,0,11,0,2172,191,0,21,302,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
276,StonewroughtPass,UNUSED Stonewrought Pass,0,0,564,0,11,31,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
277,TheFoothillCaverns,Cuevas de la Ladera,0,36,21,0,11,0,2172,1,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
278,LordamereInternmentCamp,Campo de Reclusión de Lordamere,0,36,22,0,11,0,2172,1,0,32,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
279,Dalaran,Dalaran,0,36,23,0,11,0,2172,0,0,30,81,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
280,Strahnbrad,Strahnbrad,0,36,24,0,11,37,2172,10,0,34,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
281,RuinsofAlterac,Ruinas de Alterac,0,36,25,0,11,37,2172,10,0,36,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
282,CrushridgeHold,Dominios de los Aplastacresta,0,36,26,0,11,37,2172,10,0,35,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
283,SlaughterHollow,Cuenca de la Matanza,0,36,27,0,11,37,2172,10,0,35,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
284,TheUplands,Las Tierras Altas,0,36,28,0,11,0,2172,1,0,27,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
285,SouthpointTower,Torre Austral,0,267,29,0,11,0,2172,2,0,21,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
286,HillsbradFields,Campos de Trabalomas,0,267,30,0,11,0,2172,1,0,22,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
287,Hillsbrad,Trabalomas,0,267,31,0,11,0,2172,1,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
288,AzurelodeMine,Mina Azur,0,267,32,0,11,0,2172,0,0,27,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
289,NethanderStead,Granja Nethander,0,267,33,0,11,0,2172,1,0,26,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
290,DunGarok,Dun Garok,0,267,34,0,11,0,2172,1,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
293,Thoradin'sWall,Muralla de Thoradin,0,0,35,0,11,31,2172,1,0,30,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
294,EasternStrand,Playa del Este,0,267,36,0,11,0,2172,1,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
295,WesternStrand,Playa del Oeste,0,267,616,0,11,0,2172,1,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
296,SouthSeasUNUSED,South Seas UNUSED,0,0,37,0,11,24,2172,0,0,0,122,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
297,JagueroIsle,Isla Jaguero,0,33,38,0,11,0,2172,0,0,50,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
298,BaradinBay,Bahía de Baradin,0,11,39,0,11,0,2172,3,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
299,MenethilBay,Bahía de Menethil,0,11,40,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
300,MistyReedStrand,Playa Juncobruma,0,8,41,0,11,0,2172,0,0,41,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
301,TheSavageCoast,La Costa Salvaje,0,33,42,0,11,0,2172,3,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
302,TheCrystalShore,La Costa de Cristal,0,33,565,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
303,ShellBeach,Playa del Molusco,0,33,43,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
305,NorthTide'sRun,Cala Mareanorte,0,130,44,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
306,SouthTide'sRun,Cala Mareasur,0,130,45,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
307,TheOverlookCliffs,Los Acantilados Dominantes,0,47,46,0,11,0,2172,1,0,48,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
308,TheForbiddingSea,Mar Adusto,0,0,631,0,11,0,2172,1,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
309,Ironbeard'sTomb,Tumba de Barbaférrea,0,11,47,0,11,0,2172,0,0,24,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
310,CrystalveinMine,Mina de Cristal,0,33,48,0,11,0,2172,0,0,41,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
311,RuinsofAboraz,Ruinas de Aboraz,0,33,589,0,11,0,2172,0,0,44,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
312,Janeiro'sPoint,Cayo de Janeiro,0,33,49,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
313,NorthfoldManor,Mansión Redilnorte,0,45,632,0,11,0,2172,0,0,31,302,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
314,Go'ShekFarm,Granja Go'shek,0,45,50,0,11,0,2172,0,0,33,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
315,Dabyrie'sFarmstead,Granja de Dabyrie,0,45,590,0,11,0,2172,0,0,31,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
316,BoulderfistHall,Sala Puño de Roca,0,45,51,0,11,31,2172,0,0,35,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
317,WitherbarkVillage,Poblado Secacorteza,0,45,609,0,11,0,2172,3,0,33,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
318,DrywhiskerGorge,Cañón Mostacho Seco,0,45,52,0,11,0,2172,0,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
320,RefugePointe,Refugio de la Zaga,0,45,53,0,11,0,2172,0,0,30,123,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
321,Hammerfall,Sentencia,0,45,54,0,11,0,2172,14,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
322,BlackwaterShipwrecks,Naufragios de Aguasnegras,0,45,581,0,11,0,2172,8,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
323,O'Breen'sCamp,Campamento de O'Breen,0,45,55,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
324,StromgardeKeep,Castillo de Stromgarde,0,45,56,0,11,0,2172,186,0,36,182,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
325,TheTowerofArathor,Torre de Arathor,0,45,57,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
326,TheSanctum,El Sagrario,0,45,58,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
327,Faldir'sCove,Cala de Faldir,0,45,59,0,11,0,2172,3,0,40,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
328,TheDrownedReef,El Arrecife Hundido,0,45,566,0,11,0,2172,192,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
330,ThandolSpan,Puente Thandol,0,0,60,0,11,44,2172,3,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
331,Ashenvale,Vallefresno,1,0,61,0,11,48,2172,11,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
332,TheGreatSea,Mare Magnum,1,0,62,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
333,CircleofEastBinding,Círculo de Vínculo Este,0,45,63,0,11,0,2172,0,0,38,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
334,CircleofWestBinding,Círculo de Vínculo Oeste,0,45,64,0,11,0,2172,0,0,38,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
335,CircleofInnerBinding,Círculo de Vínculo Interior,0,45,65,0,11,0,2172,0,0,38,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
336,CircleofOuterBinding,Círculo de Vínculo Exterior,0,45,66,0,11,0,2172,0,0,38,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
337,Apocryphan'sRest,Descanso de Apócrifo,0,3,67,0,11,25,2172,7,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
338,AngorFortress,Fortaleza de Angor,0,3,633,0,11,25,2172,7,0,39,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
339,LethlorRavine,Barranco Lethlor,0,3,634,0,11,25,2172,0,0,45,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
340,Kargath,Kargath,0,3,68,0,11,25,2172,0,0,38,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
341,CampKosh,Asentamiento Kosh,0,3,69,0,11,25,2172,0,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
342,CampBoff,Asentamiento Boff,0,3,70,0,11,25,2172,0,0,39,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
343,CampWurg,Asentamiento Wurg,0,3,71,0,11,25,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
344,CampCagg,Asentamiento Cagg,0,3,72,0,11,25,2172,0,0,43,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
345,Agmond'sEnd,El Final de Agmond,0,3,73,0,11,25,2172,7,0,39,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
346,Hammertoe'sDigsite,Excavación de Piemartillo,0,3,74,0,11,25,2172,0,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
347,DustbelchGrotto,Gruta Rotapolvo,0,3,75,0,11,25,2172,0,0,43,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
348,AeriePeak,Pico Nidal,0,47,76,0,11,0,2172,1,0,41,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
349,WildhammerKeep,Fortaleza de los Martillo Salvaje,0,47,77,0,11,0,2172,1,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
350,Quel'DanilLodge,Avanzada Quel'Danil,0,47,78,0,11,0,2172,1,0,45,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
351,SkulkRock,Roca Oculta,0,47,79,0,11,0,2172,1,0,48,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
352,Zun'watha,Zun'watha,0,47,80,0,11,0,2172,1,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
353,Shadra'Alor,Shadra'Alor,0,47,81,0,11,0,2172,3,0,44,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
354,Jintha'Alor,Jintha'Alor,0,47,591,0,11,0,2172,227,0,45,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
355,TheAltarofZul,El Altar de Zul,0,47,592,0,11,0,2172,176,0,46,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
356,Seradane,Seradane,0,47,82,0,11,0,2172,76,0,41,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
357,Feralas,Feralas,1,0,83,0,11,48,2172,3,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
358,BramblebladeRavine,Barranco Cortazarza,1,215,84,0,11,25,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
359,BaelModan,Bael Modan,1,17,85,0,11,0,2172,7,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
360,TheVentureCo.Mine,Mina Ventura y Cía.,1,215,86,0,11,0,2172,9,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
361,Felwood,Frondavil,1,0,87,0,11,28,2172,193,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
362,RazorHill,Cerrotajo,1,14,88,0,11,0,2172,9,0,5,421,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
363,ValleyofTrials,Valle de los Retos,1,14,89,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
364,TheDen,El Cubil,1,14,90,75,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
365,BurningBladeCoven,Aquelarre del Filo Ardiente,1,14,91,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
366,KolkarCrag,Risco Kolkar,1,14,92,0,11,0,2172,9,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
367,Sen'jinVillage,Poblado Sen'jin,1,14,93,0,11,0,2172,185,0,6,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
368,EchoIsles,Islas del Eco,1,14,94,0,11,32,2172,3,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
369,ThunderRidge,Monte del Trueno,1,14,95,0,11,0,2172,9,0,9,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
370,DrygulchRavine,Barranco Árido,1,14,96,0,11,0,2172,9,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
371,DustwindCave,Cueva Viento Seco,1,14,567,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
372,TiragardeKeep,Fuerte de Tiragarde,1,14,97,0,11,0,2172,186,0,6,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
373,ScuttleCoast,Costa de la Huida,1,14,98,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
374,BladefistBay,Bahía de Garrafilada,1,14,99,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
375,DeadeyeShore,Costa de Mortojo,1,14,100,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
377,SouthfuryRiver,Río Furia del Sur,1,0,101,0,11,0,2172,9,0,9,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
378,CampTaurajo,Campamento Taurajo,1,17,102,0,11,0,2172,226,0,10,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
379,FarWatchPost,Avanzada del Puente,1,17,103,0,11,0,2172,7,0,10,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
380,TheCrossroads,El Cruce,1,17,104,0,11,0,2172,228,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
381,BoulderLodeMine,Mina Pedrusco,1,17,105,0,11,0,2172,0,0,17,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
382,TheSludgeFen,El Fangal,1,17,552,0,11,0,2172,3,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
383,TheDryHills,Las Colinas Áridas,1,17,106,0,11,0,2172,0,0,14,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
384,DreadmistPeak,Cima Calígine,1,17,107,0,11,46,2172,10,0,11,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
385,NorthwatchHold,Fuerte del Norte,1,17,108,0,11,0,2172,3,0,15,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
386,TheForgottenPools,Las Charcas del Olvido,1,17,109,0,11,32,2172,3,0,12,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
387,LushwaterOasis,Oasis Aguaverde,1,17,582,0,11,32,2172,3,0,12,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
388,TheStagnantOasis,El Oasis Estancado,1,17,110,0,11,32,2172,3,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
390,FieldofGiants,Tierra de Gigantes,1,17,111,0,11,0,2172,0,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
391,TheMerchantCoast,La Costa Mercante,1,17,112,0,11,32,2172,3,0,12,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
392,Ratchet,Trinquete,1,17,113,0,11,0,2172,3,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
393,DarkspearStrand,Playa Lanza Negra,1,14,114,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
394,DarrowmereLakeUNUSED,Darrowmere Lake UNUSED,0,0,115,0,11,37,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
395,CaerDarrowUNUSED,Caer Darrow UNUSED,0,394,116,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
396,WinterhoofWaterWell,Pozo Pezuña Invernal,1,215,117,0,11,0,2172,9,0,6,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
397,ThunderhornWaterWell,Pozo Tronacuerno,1,215,118,0,11,0,2172,9,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
398,WildmaneWaterWell,Pozo Ferocrín,1,215,441,0,11,0,2172,9,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
399,SkylineRidge,Cresta Horizonte,1,215,610,0,11,0,2172,9,0,6,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
400,ThousandNeedles,Las Mil Agujas,1,0,442,0,11,25,2172,9,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
401,TheTidusStair,El Escalón de la Marea,1,17,443,0,11,32,2172,3,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
403,ShadyRestInn,Posada Reposo Umbrío,1,15,568,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
404,Bael'dunDigsite,Excavación de Bael'dun,1,215,444,0,11,0,2172,9,0,8,102,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
405,Desolace,Desolace,1,0,445,0,11,39,2172,7,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
406,StonetalonMountains,Sierra Espolón,1,0,446,0,11,25,2172,7,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
407,OrgrimmarUNUSED,Orgrimmar UNUSED,1,14,447,0,11,0,2172,14,0,10,62,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
408,Gillijim'sIsle,Isla de Gillijim,0,0,448,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
409,IslandofDoctorLapidis,Isla del Doctor Lapidis,0,0,449,0,11,32,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
410,RazorwindCanyon,Cañón del Ventajo,1,14,450,0,11,0,2172,9,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
411,Bathran'sHaunt,Ruinas de Bathran,1,331,451,0,11,0,2172,205,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
412,TheRuinsofOrdil'Aran,Las Ruinas de Ordil'Aran,1,331,625,0,11,0,2172,205,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
413,Maestra'sPost,Atalaya de Maestra,1,331,452,0,11,0,2172,0,0,19,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
414,TheZoramStrand,La Ensenada de Zoram,1,331,453,0,11,24,2172,176,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
415,Astranaar,Astranaar,1,331,454,0,11,0,2172,11,0,20,81,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
416,TheShrineofAessina,El Santuario de Aessina,1,331,455,0,11,0,2172,199,0,23,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
417,FireScarShrine,Santuario de la Escara,1,331,456,0,11,28,2172,193,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
418,TheRuinsofStardust,Las Ruinas del Polvo Estelar,1,331,457,0,11,28,2172,193,0,23,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
419,TheHowlingVale,Vega del Aullido,1,331,458,0,11,0,2172,204,0,28,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
420,SilverwindRefuge,Refugio Brisa de Plata,1,331,459,0,11,0,2172,0,0,25,81,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
421,MystralLake,Lago Mystral,1,331,460,0,11,0,2172,0,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
422,FallenSkyLake,Lago Cielo Estrellado,1,331,461,0,11,0,2172,0,0,26,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
424,IrisLake,Lago Iris,1,331,462,0,11,28,2172,194,0,22,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
425,Moonwell,Poza de la Luna,1,331,549,0,11,0,2172,199,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
426,RaynewoodRetreat,Refugio de la Algaba,1,331,463,0,11,0,2172,0,0,24,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
427,TheShadyNook,El Rincón Lóbrego,1,331,464,0,11,0,2172,11,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
428,Night Run,Senda de la Noche,1,331,569,0,11,0,2172,3,0,25,121,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
429,Xavian,Xavian,1,331,611,0,11,0,2172,3,0,0,121,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
430,Satyrnaar,Satyrnaar,1,331,465,0,11,0,2172,3,0,28,121,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
431,Splintertree Post,Puesto del Hachazo,1,331,553,0,11,0,2172,228,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
432,TheDor'DanilBarrowDen,El Túmulo de Dor'danil,1,331,466,0,11,0,2172,205,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
433,FalfarrenRiver,Río Falfarren,1,331,467,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
434,FelfireHill,Cerro Lumbrevil,1,331,570,0,11,48,2172,193,0,29,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
435,DemonFallCanyon,Barranco del Demonio,1,331,468,0,11,49,2172,193,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
436,DemonFallRidge,Cresta del Demonio,1,331,469,0,11,49,2172,193,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
437,Warsong Lumber Camp,Aserradero Grito de Guerra,1,331,612,0,11,28,2172,228,0,22,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
438,BoughShadow,Talloumbrío,1,331,470,0,11,0,2172,188,0,20,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
439,TheShimmeringFlats,El Desierto de Sal,1,400,471,0,11,39,2172,0,0,35,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
440,Tanaris,Tanaris,1,0,472,0,11,39,2172,176,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
441,LakeFalathim,Lago Falathim,1,331,473,0,11,48,2172,0,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
442,Auberdine,Auberdine,1,148,474,0,11,0,2172,0,0,12,81,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
443,RuinsofMathystra,Ruinas de Mathystra,1,148,475,0,11,0,2172,176,0,19,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
444,TowerofAlthalaxx,Torre de Althalaxx,1,148,476,0,11,0,2172,0,0,16,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
445,CliffspringFalls,Salto de Fonroca,1,148,477,0,11,0,2172,0,0,14,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
446,Bashal'Aran,Bashal'Aran,1,148,478,0,11,0,2172,0,0,11,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
447,Ameth'Aran,Ameth'Aran,1,148,479,0,11,0,2172,15,0,11,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
448,GroveoftheAncients,Páramo de los Ancianos,1,148,480,0,11,0,2172,0,0,15,302,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
449,TheMaster'sGlaive,La Espada del Maestro,1,148,481,0,11,0,2172,0,0,16,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
450,Remtravel'sExcavation,Excavación de Tripirrem,1,148,482,0,11,0,2172,0,0,19,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
452,Mist'sEdge,Cabo de la Niebla,1,148,483,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
453,TheLongWash,Playa del Oleaje,1,148,583,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
454,WildbendRiver,Río Culebra,1,148,484,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
455,BlackwoodDen,Cubil del Bosque Negro,1,148,485,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
456,CliffspringRiver,Río Fonroca,1,148,486,0,11,0,2172,0,0,14,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
457,TheVeiledSea,Mar de la Bruma,1,0,571,0,11,24,2172,200,0,0,201,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
458,GoldRoad,Camino del Oro,1,17,487,0,11,0,2172,7,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
459,ScarletWatchPost,Atalaya Escarlata,0,85,375,0,11,0,2172,0,0,10,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
460,SunRockRetreat,Refugio Roca del Sol,1,406,488,0,11,0,2172,228,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
461,Windshear Crag,Risco Cortaviento,1,406,489,0,11,0,2172,7,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
463,CragpoolLake,Lago del Peñasco,1,406,490,0,11,0,2172,7,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
464,MirkfallonLake,Lago Mirkfallon,1,406,491,0,11,0,2172,7,0,21,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
465,TheCharredVale,La Vega Carbonizada,1,406,492,0,11,0,2172,7,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
466,ValleyoftheBloodfuries,Valle Furia Sangrienta,1,406,493,0,11,0,2172,7,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
467,StonetalonPeak,Cima del Espolón,1,406,613,0,11,29,2172,11,0,25,201,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
468,TheTalonDen,El Cubil del Espolón,1,406,494,0,11,29,2172,11,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
469,GreatwoodVale,Vega del Gran Bosque,1,406,495,0,11,0,2172,7,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
470,ThunderBluffUNUSED,Thunder Bluff UNUSED,1,215,496,0,11,45,2172,9,0,10,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
471,BraveWindMesa,Mesa de Viento Bravo,1,215,497,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
472,FireStoneMesa,Mesa de La Piedra de Fuego,1,215,498,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
473,MantleRock,Rocamanto,1,215,554,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
474,HunterRiseUNUSED,Hunter Rise UNUSED,1,215,499,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
475,SpiritRiseUNUSED,Spirit RiseUNUSED,1,215,500,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
476,ElderRiseUNUSED,Elder RiseUNUSED,1,215,501,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
477,RuinsofJubuwal,Ruinas de Jubuwal,0,33,502,0,11,0,2172,3,0,43,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
478,PoolsofArlithrien,Estanques de Arlithrien,1,141,503,0,11,0,2172,11,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
479,TheRustmaulDigSite,Excavación Oximelena,1,400,504,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
480,CampE'thok,Campamento E'thok,1,400,505,0,11,0,2172,9,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
481,SplithoofCrag,Risco Pezuña Quebrada,1,400,572,0,11,0,2172,9,0,24,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
482,Highperch,Nido Alto,1,400,506,0,11,0,2172,9,0,29,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
483,TheScreechingCanyon,Cañón del Chirrido,1,400,507,0,11,0,2172,9,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
484,FreewindPost,Poblado Viento Libre,1,400,508,0,11,0,2172,226,0,26,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
485,TheGreatLift,El Gran Elevador,1,400,509,0,11,0,2172,9,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
486,GalakHold,Dominios Galak,1,400,510,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
487,RoguefeatherDen,Guarida Malapluma,1,400,511,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
488,TheWeatheredNook,El Hueco Perdido,1,400,512,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
489,Thalanaar,Thalanaar,1,357,513,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
490,Un'GoroCrater,Cráter de Un'Goro,1,0,514,0,11,33,2172,223,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
491,RazorfenKraul,Horado Rajacieno,47,0,515,0,11,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,0,0,0,0,0,0
492,RavenHillCemetery,Cementerio del Cerro del Cuervo,0,10,516,0,11,0,2172,15,0,26,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
493,Moonglade,Claro de la Luna,1,0,517,0,11,28,2172,191,0,0,201,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
495,DELETEME,DELETE ME,0,0,519,0,11,0,2172,11,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
496,BrackenwallVillage,Poblado Murohelecho,1,15,518,0,11,0,2172,214,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
497,SwamplightManor,Mansión Cienaluz,1,15,520,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
498,BloodfenBurrow,Madriguera de los Cienorrojo,1,15,521,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
499,DarkmistCavern,Cueva Niebla Negra,1,15,522,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
500,MogglePoint,Cabo Moggle,1,15,623,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
501,Beezil'sWreck,Siniestro de Beezil,1,15,614,0,11,0,2172,3,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
502,WitchHill,Colina de las Brujas,1,15,624,0,11,0,2172,0,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
503,SentryPoint,Alto del Centinela,1,15,573,0,11,0,2172,191,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
504,NorthPointTower,Torre de la Punta Norte,1,15,523,0,11,0,2172,191,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
505,WestPointTower,Torre de la Punta Oeste,1,15,524,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
506,LostPoint,Punta Perdida,1,15,525,0,11,0,2172,191,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
507,Bluefen,Ciénaga Azul,1,15,526,0,11,0,2172,0,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
508,StonemaulRuins,Ruinas Quebrantarrocas,1,15,527,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
509,TheDenofFlame,Cubil de la Llama,1,15,528,0,11,0,2172,0,0,38,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
510,TheDragonmurk,El Pantano del Dragón,1,15,584,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
511,Wyrmbog,Ciénaga de Fuego,1,15,529,0,11,0,2172,0,0,43,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
512,Onyxia'sLairUNUSED,Onyxia's Lair UNUSED,1,15,530,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
513,TheramoreIsle,Isla Theramore,1,15,531,0,11,43,2172,13,0,36,401,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
514,FootholdCitadel,Ciudadela Garrida,1,15,532,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
515,IroncladPrison,Prisión del Acorazado,1,15,533,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
516,DustwallowBay,Bahía Revolcafango,1,15,534,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
517,TidefuryCove,Cala Furiamarea,1,15,535,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
518,DreadmurkShore,Playa Tenebruma,1,15,536,0,11,0,2172,0,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
536,Addle'sStead,Granja de Addle,0,10,537,0,11,0,2172,2,0,24,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
537,FirePlumeRidge,Cresta del Penacho en Llamas,1,490,538,0,11,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
538,LakkariTarPits,Fosas de Alquitrán Lakkari,1,490,539,0,11,0,2172,0,0,49,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
539,TerrorRun,Camino del Terror,1,490,540,0,11,0,2172,0,0,53,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
540,TheSlitheringScar,La Cicatriz Serpenteante,1,490,541,0,11,0,2172,0,0,51,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
541,Marshal'sRefuge,Refugio de Marshal,1,490,542,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
542,FungalRock,Roca Fungal,1,490,543,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
543,GolakkaHotSprings,Baños de Golakka,1,490,544,0,11,0,2172,0,0,53,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
556,TheLoch,Loch Modan,0,38,545,0,11,0,2172,1,0,12,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
576,Beggar'sHaunt,Refugio de los Mendigos,0,10,546,0,11,0,2172,2,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
596,KodoGraveyard,Cementerio de Kodos,1,405,593,0,11,0,2172,7,0,35,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
597,GhostWalkerPost,Campamento del Espíritu Errante,1,405,594,0,11,0,2172,226,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
598,Sar'therisStrand,Playa de Sar'theris,1,405,595,0,11,31,2172,227,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
599,ThunderAxeFortress,Fortaleza del Hacha de Trueno,1,405,596,0,11,0,2172,193,0,30,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
600,Bolgan'sHole,Cuenca de Bolgan,1,405,597,0,11,0,2172,7,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
602,MannorocCoven,Aquelarre Mannoroc,1,405,599,0,11,0,2172,193,0,39,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
603,Sargeron,Sargeron,1,405,600,0,11,0,2172,76,0,31,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
604,MagramVillage,Poblado Magram,1,405,601,0,11,0,2172,7,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
606,GelkisVillage,Poblado Gelkis,1,405,603,0,11,0,2172,7,0,34,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
607,ValleyofSpears,Valle de las Lanzas,1,405,604,0,11,0,2172,7,0,37,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
608,Nijel'sPoint,Punta de Nijel,1,405,605,0,11,0,2172,206,0,30,103,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
609,KolkarVillage,Poblado Kolkar,1,405,598,0,11,0,2172,7,0,32,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
616,Hyjal,Hyjal,1,0,619,0,11,31,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
618,Winterspring,Cuna del Invierno,1,0,621,0,11,42,2172,8,0,0,0,0,0,0,0,-1,0,0,0,65,0,0,0,0,0
636,BlackwolfRiver,Río Lobonegro,1,406,626,0,11,0,2172,7,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
637,KodoRock,Roca de los Kodos,1,215,635,0,11,0,2172,9,0,0,121,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
638,HiddenPath,Sendero Oculto,1,14,636,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
639,SpiritRock,Roca de los Espíritus,1,14,637,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
640,ShrineoftheDormantFlame,Santuario de la Llama Latente,1,14,638,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
656,LakeElune'ara,Lago Elune'ara,1,493,295,0,11,0,2172,0,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
657,TheHarborage,El Puerto,0,8,296,0,11,0,2172,0,0,37,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
676,Outland,Terrallende,150,0,297,0,11,46,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
696,Craftsmen'sTerraceUNUSED,Craftsmen's Terrace UNUSED,1,141,298,0,11,48,2172,76,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
697,Tradesmen'sTerraceUNUSED,Tradesmen's Terrace UNUSED,1,141,299,0,11,48,2172,76,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
698,TheTempleGardensUNUSED,The Temple Gardens UNUSED,1,141,300,0,11,48,2172,76,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
699,TempleofEluneUNUSED,Temple of Elune UNUSED,1,141,301,0,11,48,2172,76,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
700,CenarionEnclaveUNUSED,Cenarion Enclave UNUSED,1,141,302,0,11,48,2172,76,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
701,Warrior'sTerraceUNUSED,Warrior's Terrace UNUSED,1,141,303,0,11,48,2172,76,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
702,Rut'theranVillage,Aldea Rut'theran,1,141,304,0,11,0,2172,0,0,11,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
716,Ironband'sCompound,Complejo Vetaferro,0,1,639,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
717,TheStockade,Las Mazmorras,34,0,640,0,11,0,2172,0,0,0,0,0,2,0,0,-1,0,0,0,0,0,0,0,0,0
718,WailingCaverns,Cuevas de los Lamentos,43,0,641,0,11,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,0,0,0,0,0,0
719,BlackfathomDeeps,Cavernas de Brazanegra,48,0,642,75,11,0,2172,176,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
720,FrayIsland,Isla de Batalla,1,17,643,0,11,32,2172,3,0,0,121,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
721,Gnomeregan,Gnomeregan,90,0,305,0,11,42,2172,0,0,0,0,0,2,0,0,-1,0,0,0,0,0,0,0,0,0
722,RazorfenDowns,Zahúrda Rajacieno,129,0,644,0,11,38,2172,0,0,0,0,0,4,0,0,-1,0,0,0,3,0,0,0,0,0
736,Ban'ethilHollow,Hondonada Ban'ethil,1,141,645,0,11,0,2172,0,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
796,ScarletMonastery,Monasterio Escarlata,189,0,646,0,11,0,2172,205,0,0,0,0,4,0,0,-1,0,0,0,0,0,0,0,0,0
797,Jerod'sLanding,Embarcadero de Jerod,0,12,647,0,11,35,2172,0,0,8,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
798,RidgepointTower,Torre de la Peña,0,12,648,0,11,35,2172,0,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
799,TheDarkenedBank,La Ribera Lóbrega,0,10,649,0,11,0,2172,2,0,10,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
800,ColdridgePass,Desfiladero de Crestanevada,0,1,650,0,11,0,2172,0,0,4,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
801,ChillBreezeValley,Valle Escalofrío,0,1,651,0,11,0,2172,0,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
802,ShimmerRidge,Monte Luz,0,1,652,0,11,0,2172,0,0,8,121,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
803,AmberstillRanch,Granja de Semperámbar,0,1,653,0,11,0,2172,0,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
804,TheTundridHills,Las Colinas Tundra,0,1,654,0,11,0,2172,0,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
805,SouthGatePass,Paso de la Puerta Sur,0,1,655,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
806,SouthGateOutpost,Avanzada de la Puerta Sur,0,1,656,0,11,0,2172,0,0,12,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
807,NorthGatePass,Paso de la Puerta Norte,0,1,657,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
808,NorthGateOutpost,Avanzada de la Puerta Norte,0,1,658,0,11,0,2172,0,0,11,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
809,GatesofIronforge,Puertas de Forjaz,0,1,659,0,11,0,2172,0,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
810,StillwaterPond,Charca Aguaserena,0,85,660,0,11,0,2172,0,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
811,NightmareVale,Vega Pesadilla,0,85,661,0,11,0,2172,0,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
812,VenomwebVale,Vega Venerácnidas,0,85,662,0,11,0,2172,0,0,10,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
813,TheBulwark,El Baluarte,0,28,663,0,11,0,2172,0,0,52,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
814,SouthfuryRiver,Río Furia del Sur,1,14,664,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
815,SouthfuryRiver,Río Furia del Sur,1,17,665,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
816,RazormaneGrounds,Tierras Crines de Acero,1,14,666,0,11,0,2172,0,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
817,SkullRock,Roca del Cráneo,1,14,667,0,11,0,2172,0,0,10,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
818,PalemaneRock,Roca Crines Pálidas,1,215,668,0,11,0,2172,0,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
819,WindfuryRidge,Cresta Viento Furioso,1,215,669,0,11,0,2172,0,0,9,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
820,TheGoldenPlains,Las Llanuras Doradas,1,215,670,0,11,0,2172,0,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
821,TheRollingPlains,Las Llanuras Onduladas,1,215,671,0,11,0,2172,0,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
836,DunAlgaz,Dun Algaz,0,11,672,0,11,0,2172,0,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
837,DunAlgaz,Dun Algaz,0,38,673,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
838,NorthGatePass,Paso de la Puerta Norte,0,38,306,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
839,SouthGatePass,Paso de la Puerta Sur,0,38,307,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
856,TwilightGrove,Arboleda del Crepúsculo,0,10,674,0,11,0,2172,2,0,19,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
876,GMIsland,Isla de los MJ,1,0,675,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
877,Delete ME,Delete ME,1,17,676,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
878,SouthfuryRiver,Río Furia del Sur,1,16,677,0,11,0,2172,8,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
879,SouthfuryRiver,Río Furia del Sur,1,331,678,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
880,ThandolSpan,Puente Thandol,0,45,679,0,11,0,2172,0,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
881,ThandolSpan,Puente Thandol,0,11,680,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
896,PurgationIsle,Isla del Purgatorio,0,267,308,0,11,40,2172,193,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
916,TheJansenStead,La Finca de Jansen,0,40,681,0,11,0,2172,0,0,9,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
917,TheDeadAcre,El Campo Funesto,0,40,682,0,11,0,2172,0,0,18,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
918,TheMolsenFarm,La Granja de Molsen,0,40,683,0,11,0,2172,0,0,14,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
919,Stendel'sPond,Estanque de Stendel,0,40,684,0,11,0,2172,0,0,14,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
920,TheDaggerHills,Las Colinas Afiladas,0,40,309,0,11,0,2172,0,0,17,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
921,Demont'sPlace,Paraje de Demont,0,40,310,0,11,0,2172,0,0,16,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
922,TheDustPlains,Los Yermos Polvorientos,0,40,311,0,11,0,2172,0,0,18,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
923,StonesplinterValley,Valle Rompecantos,0,38,312,0,11,0,2172,0,0,13,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
924,ValleyofKings,Valle de los Reyes,0,38,313,0,11,0,2172,0,0,11,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
925,AlgazStation,Estación de Algaz,0,38,314,0,11,0,2172,0,0,12,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
926,BucklebreeFarm,La granja de Bucklebree,0,130,315,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
927,TheShiningStrand,La Playa Plateada,0,130,316,0,11,0,2172,0,0,14,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
928,NorthTide'sHollow,Cuenca Mareanorte,0,130,317,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
936,GrizzlepawRidge,Fuerte Zarpagris,0,38,318,0,11,0,2172,0,0,12,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
956,TheVerdantFields,Los Verdegales,169,0,319,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
976,Gadgetzan,Gadgetzan,1,440,320,0,0,0,2172,0,0,40,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
977,SteamwheedlePort,Puerto Bonvapor,1,440,390,0,0,0,2172,3,0,40,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
978,Zul'Farrak,Zul'Farrak,1,440,321,0,0,25,2172,176,0,45,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
979,SandsorrowWatch,Vigía Penas de Arena,1,440,322,0,0,0,2172,0,0,44,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
980,ThistleshrubValley,Valle Cardizal,1,440,323,0,0,0,2172,0,0,49,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
981,TheGapingChasm,Sima Abierta,1,440,324,0,0,0,2172,0,0,48,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
982,TheNoxiousLair,La Guarida Ponzoñosa,1,440,325,0,0,0,2172,0,0,48,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
983,DunemaulCompound,Base Machacaduna,1,440,326,0,0,0,2172,0,0,47,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
984,EastmoonRuins,Ruinas de Lunaeste,1,440,327,0,0,0,2172,0,0,47,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
985,WaterspringField,Campo del Manantial,1,440,328,0,0,0,2172,0,0,44,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
986,Zalashji'sDen,Guarida de Zalashji,1,440,329,0,0,0,2172,0,0,45,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
987,Land'sEndBeach,Playa Finisterrae,1,440,330,0,0,0,2172,0,0,48,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
988,WavestriderBeach,Playa Baile de las Olas,1,440,331,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
989,Uldum,Uldum,1,440,332,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
990,ValleyoftheWatchers,Valle de los Vigías,1,440,333,0,0,0,2172,0,0,50,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
991,Gunstan'sPost,Puesto de Gunstan,1,440,334,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
992,SouthmoonRuins,Ruinas de Lunasur,1,440,335,0,0,0,2172,0,0,47,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
996,Render'sCamp,Campamento de Render,0,44,408,0,0,0,2172,0,0,22,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
997,Render'sValley,Valle de Render,0,44,409,0,0,0,2172,0,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
998,Render'sRock,Roca de Render,0,44,410,0,0,0,2172,0,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
999,StonewatchTower,Torre de Petravista,0,44,411,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1000,GalardellValley,Valle de Galardell,0,44,412,0,0,0,2172,0,0,22,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1001,LakeridgeHighway,Camino del Lago,0,44,336,0,0,0,2172,0,0,16,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1002,ThreeCorners,Tres Caminos,0,44,337,0,0,0,2172,0,0,16,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1016,DireforgeHill,Cerro Fraguaferoz,0,11,338,0,0,0,2172,0,0,28,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1017,RaptorRidge,Colina del Raptor,0,11,339,0,0,0,2172,0,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1018,BlackChannelMarsh,Pantano del Canal Negro,0,11,340,0,0,0,2172,0,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1019,TheGreenBelt,La Franja Verde,0,139,341,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1020,MosshideFen,Pantano Pellejomusgo,0,11,342,0,0,0,2172,0,0,22,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1021,ThelgenRock,Roca Thelgen,0,11,343,0,0,0,2172,0,0,22,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1022,BluegillMarsh,Pantano Branquiazul,0,11,344,0,0,0,2172,0,0,24,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1023,SaltsprayGlen,Cañada Salobre,0,11,345,0,0,0,2172,0,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1024,SundownMarsh,Pantano del Ocaso,0,11,346,0,0,0,2172,0,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1025,TheGreenBelt,La Franja Verde,0,11,347,0,0,0,2172,0,0,21,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1036,AngerfangEncampment,Campamento Dentellada,0,11,391,0,0,0,2172,0,0,28,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1037,GrimBatol,Grim Batol,0,11,392,0,0,0,2172,0,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1038,DragonmawGates,Puertas Faucedraco,0,11,393,0,0,0,2172,0,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1039,TheLostFleet,La Flota Perdida,0,11,394,0,0,0,2172,0,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1056,DarrowHill,Colinas de Darrow,0,267,348,0,0,0,2172,0,0,31,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1057,Thoradin'sWall,Muralla de Thoradin,0,267,349,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1076,WebwinderPath,Senda de las Tejedoras,1,406,368,0,0,0,2172,0,0,21,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1097,TheHushedBank,La Ribera Silente,0,10,351,0,0,0,2172,0,0,19,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1098,ManorMistmantle,Mansión Mantoniebla,0,10,352,0,0,0,2172,0,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1099,CampMojache,Campamento Mojache,1,357,353,0,0,0,2172,226,0,42,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1100,GrimtotemCompound,Dominios Tótem Siniestro,1,357,395,0,0,0,2172,0,0,41,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1101,TheWrithingDeep,Las Galerías Retorcidas,1,357,396,0,0,0,2172,0,0,44,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1102,WildwindLake,Lago Ventosalvaje,1,357,350,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1103,GordunniOutpost,Avanzada Gordunni,1,357,397,0,0,0,2172,0,0,42,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1104,Mok'Gordun,Mok'Gordun,1,357,398,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1105,FeralScarVale,Vega Cicatriz Feral,1,357,354,0,0,0,2172,0,0,44,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1106,FrayfeatherHighlands,Tierras Altas de Plumavieja,1,357,399,0,0,0,2172,0,0,46,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1107,IdlewindLake,Lago Soplo,1,357,400,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1108,TheForgottenCoast,La Costa Olvidada,1,357,355,0,0,0,2172,0,0,49,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1109,EastPillar,Pilar Este,1,357,401,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1110,WestPillar,Pilar Oeste,1,357,402,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1111,DreamBough,Rama Oniria,1,357,403,0,0,0,2172,0,0,60,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1112,JademirLake,Lago Jademir,1,357,404,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1113,Oneiros,Oneiros,1,357,405,0,0,0,2172,0,0,60,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1114,RuinsofRavenwind,Ruinas de Viento Azabache,1,357,356,0,0,0,2172,0,0,49,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1115,RageScarHold,Dominios de los Cicatriz de Rabia,1,357,357,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1116,FeathermoonStronghold,Bastión Plumaluna,1,357,358,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1117,RuinsofSolarsal,Ruinas de Solarsal,1,357,359,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1118,LowerWilds UNUSED,Lower Wilds UNUSED,1,357,360,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1119,TheTwinColossals,Los Dos Colosos,1,357,369,0,0,0,2172,0,0,48,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1120,SardorIsle,Isla de Sardor,1,357,413,0,0,0,2172,0,0,43,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1121,IsleofDread,Isla del Terror,1,357,414,0,0,0,2172,0,0,44,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1136,HighWilderness,Altas Tierras Salvajes,1,357,361,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1137,LowerWilds,Bajas Tierras Salvajes,1,357,370,0,0,0,2172,0,0,42,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1156,SouthernBarrens,Baldíos del Sur,1,17,362,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1157,SouthernGoldRoad,Camino del Oro Sur,1,17,406,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1176,Zul'Farrak,Zul'Farrak,209,0,371,0,0,25,2172,176,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
1196,UNUSEDAlcazIsland,UNUSEDAlcaz Island,1,0,363,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
1216,TimbermawHold,Bastión Fauces de Madera,1,16,364,0,0,0,2172,0,0,49,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1217,VanndirEncampment,Campamento Vanndir,1,16,365,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1218,TESTAzshara,TESTAzshara,1,16,366,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1219,LegashEncampment,Campamento Legashi,1,16,367,0,0,0,2172,0,0,52,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1220,ThalassianBaseCamp,Campamento Base Thalassiano,1,16,415,0,0,0,2172,76,0,52,302,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1221,RuinsofEldarath,Ruinas de Eldarath,1,16,416,0,0,0,2172,176,0,48,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1222,Hetaera'sClutch,Guarida de Hetaera,1,16,417,0,0,0,2172,176,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1223,TempleofZin-Malor,Templo de Zin-Malor,1,16,418,0,0,0,2172,15,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1224,Bear'sHead,Cabeza de Oso,1,16,419,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1225,Ursolan,Ursolan,1,16,420,0,0,0,2172,0,0,49,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1226,TempleofArkkoran,Templo de Arkkoran,1,16,421,0,0,0,2172,176,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1227,BayofStorms,Bahía de la Tempestad,1,16,422,0,0,0,2172,176,0,50,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1228,TheShatteredStrand,La Playa Arrasada,1,16,423,0,0,0,2172,176,0,52,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1229,TowerofEldara,Torre de Eldara,1,16,424,0,0,0,2172,176,0,53,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1230,JaggedReef,Arrecife Dentado,1,16,425,0,0,0,2172,176,0,51,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1231,SouthridgeBeach,Playa del Arrecife Sur,1,16,426,0,0,0,2172,176,0,52,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1232,RavencrestMonument,Monumento Cresta Cuervo,1,16,427,0,0,0,2172,176,0,54,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1233,ForlornRidge,Loma Desolada,1,16,428,0,0,0,2172,215,0,49,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1234,LakeMennar,Lago Mennar,1,16,429,0,0,0,2172,0,0,52,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1235,ShadowsongShrine,Santuario Cantosombrío,1,16,430,0,0,0,2172,15,0,46,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1236,HaldarrEncampment,Campamento Haldarr,1,16,431,0,0,0,2172,3,0,45,121,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1237,Valormok,Valormok,1,16,432,0,0,0,2172,228,0,49,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1256,TheRuinedReaches,Las Ruinas,1,16,433,0,0,0,2172,176,0,42,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1276,TheTalondeepPath,El Paso del Espolón,1,331,434,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1277,TheTalondeepPath,El Paso del Espolón,1,406,435,0,0,0,2172,0,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1296,RocktuskFarm,Granja Rocamuela,1,14,372,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1297,JaggedswineFarm,La Pocilga,1,14,407,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1316,RazorfenDowns,Zahúrda Rajacieno,1,17,436,0,0,70,2172,176,0,33,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1336,LostRiggerCove,Cala del Aparejo Perdido,1,440,373,0,0,0,2172,0,0,45,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1337,Uldaman,Uldaman,70,0,437,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
1338,LordamereLake,Lago Lordamere,0,130,438,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1339,LordamereLake,Lago Lordamere,0,36,439,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1357,Gallows'Corner,Camino de la Horca,0,36,440,0,0,37,2172,10,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1377,Silithus,Silithus,1,0,374,0,0,38,2172,176,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
1397,EmeraldForest,Bosque Esmeralda,169,0,376,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
1417,SunkenTemple,Templo Sumergido,109,0,377,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
1437,DreadmaulHold,Bastión Machacamiedo,0,4,378,0,0,0,2172,0,0,47,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1438,NethergardeKeep,Castillo de Nethergarde,0,4,379,0,0,0,2172,205,0,50,303,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1439,DreadmaulPost,Puesto Machacamiedo,0,4,380,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1440,Serpent'sCoil,Serpiente Enroscada,0,4,381,0,0,0,2172,0,0,51,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1441,AltarofStorms,Altar de la Tempestad,0,4,382,0,0,0,2172,10,0,54,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1442,FirewatchRidge,Cresta Vigía,0,51,383,0,0,0,2172,0,0,48,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1443,TheSlagPit,La Fosa de la Escoria,0,51,384,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1444,TheSeaofCinders,El Mar de las Cenizas,0,51,385,0,0,0,2172,0,0,56,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1445,BlackrockMountain,Montaña Roca Negra,0,51,386,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1446,ThoriumPoint,Puesto del Torio,0,51,387,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1457,GarrisonArmory,Arsenal del Cuartel,0,4,388,0,0,0,2172,0,0,47,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1477,TheTempleOfAtal'Hakkar,El Templo de Atal'Hakkar,0,0,389,0,0,33,2172,3,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
1497,Undercity,Entrañas,0,0,685,0,0,40,2172,0,0,10,0,0,4,0,0,-1,0,0,0,312,0,0,0,0,0
1517,Uldaman,Uldaman,0,3,686,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1518,NotIUsedDeadmines,Not Used Deadmines,0,40,687,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1519,StormwindCity,Ciudad de Ventormenta,0,0,688,0,0,31,2172,13,0,10,61,0,2,0,0,-1,0,0,0,312,0,0,0,0,0
1537,Ironforge,Forjaz,0,0,689,0,0,42,2172,0,0,10,0,0,2,0,0,-1,0,0,0,312,0,0,0,0,0
1557,SplithoofHold,Campamento Pezuña Quebrada,1,400,690,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1577,TheCapeofStranglethorn,El Cabo de Tuercespina,0,33,691,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1578,SouthernSavageCoast,Costa Salvaje del Sur,0,33,692,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1579,UnusedTheDeadmines002,Unused The Deadmines 002,0,0,693,0,0,0,2172,0,0,0,0,0,2,0,0,-1,0,0,0,64,0,0,0,0,0
1580,UnusedIroncladCove003,Unused Ironclad Cove 003,36,1579,694,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1581,TheDeadmines,Las Minas de la Muerte,36,0,695,76,0,53,2172,204,0,0,0,0,2,0,0,-1,0,0,0,0,0,0,0,0,0
1582,IroncladCove,Cala del Acorazado,36,1581,696,76,0,53,2172,204,0,0,181,0,2,0,0,-1,0,0,0,1073741824,0,0,0,0,0
1583,BlackrockSpire,Cumbre de Roca Negra,0,0,697,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
1584,BlackrockDepths,Profundidades de Roca Negra,0,0,698,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
1597,RaptorGroundsUNUSED,Raptor Grounds UNUSED,1,17,699,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1598,Grol'domFarmUNUSED,Grol'dom Farm UNUSED,1,17,700,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1599,Mor'shanBaseCamp,Campamento de Mor'shan,1,17,701,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1600,Honor'sStandUNUSED,Honor's Stand UNUSED,1,17,702,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1601,BlackthornRidgeUNUSED,Blackthorn Ridge UNUSED,1,17,703,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1602,BramblescarUNUSED,Bramblescar UNUSED,1,17,704,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1603,Agama'gorUNUSED,Agama'gor UNUSED,1,17,705,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1617,ValleyofHeroes,Valle de los Héroes,0,1519,706,0,0,43,2172,13,0,0,0,0,2,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1637,Orgrimmar,Orgrimmar,1,0,707,0,0,25,2172,7,0,10,62,0,4,0,0,-1,0,0,0,312,0,0,0,0,0
1638,ThunderBluff,Cima del Trueno,1,0,708,0,0,45,2172,226,0,10,381,0,4,0,0,-1,0,0,0,312,0,0,0,0,0
1639,ElderRise,Alto de los Ancestros,1,1638,709,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1640,SpiritRise,Alto de los Espíritus,1,1638,710,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1641,HunterRise,Alto de los Cazadores,1,1638,711,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1657,Darnassus,Darnassus,1,0,712,0,0,48,2172,76,0,10,63,0,2,0,0,-1,0,0,0,312,0,0,0,0,0
1658,CenarionEnclave,Enclave Cenarion,1,1657,713,0,0,0,2172,0,0,0,103,0,2,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1659,Craftsmen'sTerrace,Bancal del Artesano,1,1657,714,0,0,0,2172,0,0,0,0,0,2,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1660,Warrior'sTerrace,Bancal del Guerrero,1,1657,715,0,0,0,2172,0,0,0,0,0,2,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1661,TheTempleGardens,Los Jardines del Templo,1,1657,716,0,0,0,2172,0,0,0,0,0,2,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1662,Tradesmen'sTerrace,Bancal de los Mercaderes,1,1657,717,0,0,0,2172,0,0,0,0,0,2,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1677,Gavin'sNaze,Saliente de Gavin,0,36,718,0,0,0,2172,0,0,33,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1678,Sofera'sNaze,Saliente de Sofera,0,36,719,0,0,0,2172,0,0,33,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1679,Corrahn'sDagger,Daga de Corrahn,0,36,720,0,0,0,2172,0,0,33,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1680,TheHeadland,La Punta,0,36,721,0,0,0,2172,0,0,34,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1681,MistyShore,Costa de la Neblina,0,36,722,0,0,0,2172,0,0,31,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1682,Dandred'sFold,Redil de Dandred,0,36,723,0,0,0,2172,0,0,39,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1683,GrowlessCave,Caverna Estrecha,0,36,724,0,0,37,2172,10,0,34,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1684,ChillwindPoint,Alto del Orvallo,0,36,725,0,0,0,2172,0,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1697,RaptorGrounds,Tierras de los Raptores,1,17,726,0,0,0,2172,0,0,18,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1698,Bramblescar,Rajazarza,1,17,727,0,0,0,2172,0,0,20,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1699,ThornHill,Colina Espinosa,1,17,728,0,0,0,2172,0,0,13,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1700,Agama'gor,Agama'gor,1,17,729,0,0,0,2172,0,0,19,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1701,BlackthornRidge,Loma Espina Negra,1,17,730,0,0,0,2172,0,0,20,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1702,Honor'sStand,El Alto del Honor,1,17,731,0,0,0,2172,0,0,18,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1703,TheMor'shanRampart,La Empalizada de Mor'shan,1,17,732,0,0,0,2172,0,0,17,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1704,Grol'domFarm,Granja de Grol'dom,1,17,733,0,0,0,2172,0,0,11,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1717,RazorfenKraul,Horado Rajacieno,1,17,734,0,0,0,2172,0,0,24,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1718,TheGreatLift,El Gran Elevador,1,17,735,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1737,MistvaleValley,Valle del Velo de Bruma,0,33,736,0,0,0,2172,0,0,40,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1738,Nek'maniWellspring,Manantial Nek'mani,0,33,737,0,0,0,2172,0,0,43,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1739,BloodsailCompound,Complejo Velasangre,0,33,738,0,0,0,2172,0,0,42,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1740,VentureCo.BaseCamp,Base de Ventura y Cía.,0,33,739,0,0,0,2172,0,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1741,GurubashiArena,Arena Gurubashi,0,33,740,0,0,0,2172,0,0,43,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1742,SpiritDen,Cubil del Espíritu,0,33,741,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1757,TheCrimsonVeil,El Velo Carmesí,0,33,742,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1758,TheRiptide,Las Mareas Vivas,0,33,743,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1759,TheDamsel'sLuck,La Damisela Afortunada,0,33,744,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1760,VentureCo.OperationsCenter,Centro de Operaciones de Ventura y Cía.,0,33,745,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1761,DeadwoodVillage,Aldea Muertobosque,1,361,746,0,0,0,2172,194,0,47,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1762,FelpawVillage,Poblado Zarpavil,1,361,747,0,0,0,2172,194,0,54,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1763,Jaedenar,Jaedenar,1,361,748,0,0,0,2172,193,0,51,161,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1764,BloodvenomRiver,Río del Veneno,1,361,749,0,0,0,2172,193,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1765,BloodvenomFalls,Cascadas del Veneno,1,361,750,0,0,0,2172,193,0,52,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1766,ShatterScarVale,Cañada Gran Cicatriz,1,361,751,0,0,0,2172,0,0,53,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1767,IrontreeWoods,Bosque de Troncoferro,1,361,752,0,0,0,2172,0,0,53,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1768,IrontreeCavern,Caverna de Troncoferro,1,361,753,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1769,TimbermawHold,Bastión Fauces de Madera,1,361,754,0,0,0,2172,0,0,54,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1770,ShadowHold,Guarida Sombría,1,361,755,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1771,ShrineoftheDeceiver,Santuario del Impostor,1,361,756,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1777,Itharius'sCave,Cueva de Itharius,0,8,757,0,0,0,2172,0,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1778,Sorrowmurk,Tinieblas de las Penas,0,8,758,0,0,0,2172,0,0,41,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1779,Draenil'durVillage,Aldea Draenil'dur,0,8,759,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1780,SplinterspearJunction,Cruce Lanzarrota,0,8,760,0,0,0,2172,0,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1797,Stagalbog,Stagalbog,0,8,761,0,0,0,2172,0,0,41,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1798,TheShiftingMire,Lodo Traicionero,0,8,762,0,0,0,2172,0,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1817,StagalbogCave,Cueva Stagalbog,0,8,763,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1837,WitherbarkCaverns,Cuevas Secacorteza,0,45,764,0,0,0,2172,3,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1857,Thoradin'sWall,Muralla de Thoradin,0,45,765,0,0,0,2172,0,0,32,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1858,Boulder'gor,Roca'gor,0,45,766,0,0,0,2172,0,0,32,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1877,ValleyofFangs,Valle de los Colmillos,0,3,767,0,0,0,2172,0,0,42,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1878,TehDustbowl,Terraseca,0,3,768,0,0,0,2172,0,0,39,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1879,MirageFlats,Explanada del Espejismo,0,3,769,0,0,0,2172,0,0,40,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1880,Featherbeard'sHovel,Cobertizo de Barbapluma,0,47,770,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1881,Shindigger'sCamp,Campamento Machacacanillas,0,47,771,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1882,PlaguemistRavine,Barranco Bruma Enferma,0,47,772,0,0,0,2172,0,0,45,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1883,ValorwindLake,Lago Ventobravo,0,47,773,0,0,0,2172,0,0,48,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1884,Agol'watha,Agol'watha,0,47,774,0,0,0,2172,0,0,46,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1885,Hiri'watha,Hiri'watha,0,47,775,0,0,0,2172,0,0,42,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1886,TheCreepingRuin,Las Ruinas Abyectas,0,47,776,0,0,0,2172,0,0,47,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1887,Bogen'sLedge,Arrecife de Bogen,0,47,777,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1897,TheMaker'sTerrace,Bancal del Hacedor,0,3,778,0,0,0,2172,0,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1898,DustwindGulch,Barranco Viento Seco,0,3,779,0,0,0,2172,0,0,39,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1917,Shaol'watha,Shaol'watha,0,47,780,0,0,0,2172,0,0,49,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1937,NoonshadeRuins,Ruinas Sombrasol,1,440,781,0,0,0,2172,0,0,42,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1938,BrokenPillar,Pilar Partido,1,440,782,0,0,0,2172,0,0,45,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1939,AbyssalSands,Arenas Abisales,1,440,783,0,0,0,2172,0,0,45,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1940,SouthbreakShore,Tierras del Sur,1,440,784,0,0,0,2172,0,0,49,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1941,CavernsofTime,Cavernas del Tiempo,1,0,785,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
1942,TheMarshlands,Los Pantanales,1,490,786,0,0,0,2172,0,0,48,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1943,IronstonePlateau,Meseta Roca de Hierro,1,490,787,0,0,0,2172,0,0,50,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1957,BlackcharCave,Cueva Tizonegro,0,51,788,0,0,0,2172,0,0,47,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1958,TannerCamp,Base de Peleteros,0,51,789,0,0,0,2172,0,0,43,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1959,DustfireValley,Valle Polvofuego,0,51,790,0,0,0,2172,0,0,45,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1977,ZulGurub,Zul'Gurub,309,0,791,0,11,32,2172,3,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
1978,MistyReedPost,Puesto Juncobruma,0,8,792,0,0,0,2172,0,0,41,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1997,BloodvenomPost,Puesto del Veneno,1,361,793,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1998,TalonbranchGlade,Claro Ramaespolón,1,361,794,0,0,0,2172,0,0,53,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2017,Stratholme,Stratholme,329,0,795,0,0,37,2172,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
2037,UNUSEDShadowfangKeep003,UNUSEDShadowfang Keep 003,0,0,796,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
2057,Scholomance,Scholomance,289,0,797,0,0,37,2172,15,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
2077,TwilightVale,Vega Crepuscular,1,148,798,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2078,TwilightShore,Orilla Crepuscular,1,148,799,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2079,AlcazIsland,Isla de Alcaz,1,15,800,0,0,32,2172,3,0,61,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2097,DarkcloudPinnacle,Cumbre de la Nube Negra,1,400,801,0,0,0,2172,226,0,26,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2098,DawningWoodCatacombs,Catacumbas del Bosque Aurora,0,10,802,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2099,StonewatchKeep,Fuerte de Petravista,0,44,803,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2100,Maraudon,Maraudon,349,0,804,0,0,0,2172,7,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
2101,StoutlagerInn,Pensión La Cebada,0,38,805,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2102,ThunderbrewDistillery,Destilería Cebatruenos,0,1,806,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2103,MenethilKeep,Castillo de Menethil,0,11,807,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2104,DeepwaterTavern,Mesón Aguahonda,0,11,808,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2117,ShadowGrave,Sepulcro Sombrío,0,85,809,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2118,BrillTownHall,Concejo de Rémol,0,85,810,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2119,Gallows'EndTavern,Mesón La Horca,0,85,811,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2137,ThePoolsofVisionUNUSED,The Pools of VisionUNUSED,1,215,812,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2138,DreadmistDen,Cubil Calígine,1,17,813,0,0,0,2172,10,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2157,Bael'dunKeep,Fortaleza de Bael'dun,1,17,814,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2158,Emberstrife'sDen,Cubil de Brasaliza,1,15,815,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2159,OnyxiasLair,Guarida de Onyxia,1,0,816,0,0,33,2172,237,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
2160,WindshearMine,Mina Cortaviento,1,406,817,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2161,Roland'sDoom,Condena de Roland,0,10,818,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2177,BattleRing,Liza,0,33,819,0,0,0,2172,0,0,0,325,0,0,0,0,-1,0,0,0,1073742032,0,0,0,0,0
2197,ThePoolsofVision,Pozas de las Visiones,1,1638,820,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2198,ShadowbreakRavine,Barranco Rompesombras,1,405,821,0,0,0,2172,237,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2217,BrokenSpearVillage,Aldea Lanza Partida,1,405,822,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2237,WhitereachPost,Campamento del Tramo Blanco,1,400,823,0,0,0,2172,0,0,28,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2238,Gornia,Gornia,1,400,824,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2239,Zane'sEyeCrater,Cráter del Ojo de Zane,1,400,825,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2240,MirageRaceway,Circuito del Espejismo,1,400,826,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2241,FrostsaberRock,Roca Sable de Hielo,1,618,827,0,0,0,2172,0,0,57,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2242,TheHiddenGrove,La Arboleda Oculta,1,618,828,0,0,0,2172,0,0,58,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2243,TimbermawPost,Puesto de los Fauces de Madera,1,618,829,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2244,WinterfallVillage,Poblado Nevada,1,618,830,0,0,0,2172,0,0,57,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2245,Mazthoril,Mazthoril,1,618,831,0,0,0,2172,223,0,56,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2246,FrostfireHotSprings,Baños de Fuego de Escarcha,1,618,832,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2247,IceThistleHills,Colinas Cardo Nevado,1,618,833,0,0,0,2172,0,0,56,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2248,DunMandarr,Dun Mandarr,1,618,834,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2249,FrostwhisperGorge,Cañón Levescarcha,1,618,835,0,0,0,2172,0,0,60,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2250,OwlWingThicket,Matorral del Ala del Búho,1,618,836,0,0,0,2172,0,0,56,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2251,LakeKel'Theril,Lago Kel'Theril,1,618,837,0,0,0,2172,0,0,56,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2252,TheRuinsofKel'Theril,Las Ruinas de Kel'Theril,1,618,838,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2253,StarfallVillage,Aldea Estrella Fugaz,1,618,839,0,0,0,2172,76,0,55,103,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2254,Ban'ThallowBarrowDen,Túmulo de Ban'Thallow,1,618,840,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2255,Everlook,Vista Eterna,1,618,841,0,0,0,2172,235,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2256,DarkwhisperGorge,Garganta Negro Rumor,1,618,842,0,0,37,2172,205,0,60,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2257,DeeprunTram,Tranvía Subterráneo,369,0,843,0,0,0,2172,0,0,0,0,0,2,0,0,-1,0,0,0,0,0,0,0,0,0
2258,TheFungalVale,Cuenca Fungal,0,139,844,0,0,0,2172,0,0,58,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2259,UNUSEDTheMarrisStead,UNUSEDThe Marris Stead,0,139,845,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2260,TheMarrisStead,Hacienda de Marris,0,139,846,0,0,0,2172,0,0,54,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2261,TheUndercroft,La Subgranja,0,139,847,0,0,0,2172,0,0,54,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2262,Darrowshire,Villa Darrow,0,139,848,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2263,CrownGuardTower,Torre de la Corona,0,139,849,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2264,Corin'sCrossing,Cruce de Corin,0,139,850,0,0,0,2172,0,0,57,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2265,ScarletBaseCamp,Campamento Base Escarlata,0,139,851,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2266,Tyr'sHand,Mano de Tyr,0,139,852,0,0,0,2172,193,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2267,TheScarletBasilica,La Basílica Escarlata,0,139,853,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2268,Light'sHopeChapel,Capilla de la Esperanza de la Luz,0,139,854,0,0,0,2172,0,0,58,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2269,BrowmanMill,Molino Cejifrente,0,139,855,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2270,TheNoxiousGlade,El Claro Ponzoñoso,0,139,856,0,0,0,2172,0,0,58,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2271,EastwallTower,Torre de la Muralla del Este,0,139,857,0,0,0,2172,0,0,56,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2272,Northdale,Vallenorte,0,139,858,0,0,0,2172,0,0,58,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2273,Zul'Mashar,Zul'Mashar,0,139,859,0,0,0,2172,227,0,57,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2274,Mazra'Alor,Mazra'Alor,0,139,860,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2275,NorthpassTower,Torre del Paso Norte,0,139,861,0,0,0,2172,0,0,56,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2276,Quel'LithienLodge,Refugio Quel'Lithien,0,139,862,0,0,0,2172,76,0,59,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2277,Plaguewood,Bosque de la Peste,0,139,863,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2278,Scourgehold,Fuerte de la Plaga,0,139,864,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2279,Stratholme,Stratholme,0,139,865,0,0,37,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2280,UNUSEDStratholme,UNUSED Stratholme,0,0,866,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
2297,DarrowmereLake,Lago Darrowmere,0,28,867,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2298,CaerDarrow,Castel Darrow,0,28,868,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2299,DarrowmereLake,Lago Darrowmere,0,139,869,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2300,CavernsofTime,Cavernas del Tiempo,1,440,870,0,0,0,2172,0,0,50,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2301,ThistlefurVillage,Poblado Piel de Cardo,1,331,871,0,0,28,2172,194,0,23,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2302,TheQuagmire,El Lodazal,1,15,872,0,0,0,2172,0,0,39,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2303,WindbreakCanyon,Cañón Rompevientos,1,400,873,0,0,0,2172,0,0,27,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2317,SouthSeas,Mares del Sur,1,440,874,0,0,24,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2318,TheGreatSea,Mare Magnum,1,15,875,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2319,TheGreatSea,Mare Magnum,1,17,876,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2320,TheGreatSea,Mare Magnum,1,14,877,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2321,TheGreatSea,Mare Magnum,1,16,878,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2322,TheVeiledSea,Mar de la Bruma,1,141,879,0,0,0,2172,0,0,0,0,0,2,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2323,TheVeiledSea,Mar de la Bruma,1,357,880,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2324,TheVeiledSea,Mar de la Bruma,1,405,881,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2325,TheVeiledSea,Mar de la Bruma,1,331,882,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2326,TheVeiledSea,Mar de la Bruma,1,148,883,0,0,0,2172,0,0,0,0,0,2,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2337,RazorHillBarracks,Cuartel de Cerrotajo,1,14,884,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2338,SouthSeas,Mares del Sur,0,33,885,0,0,24,2172,0,0,0,122,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2339,TheGreatSea,Mare Magnum,0,33,886,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2357,BloodtoothCamp,Asentamiento Sangradientes,1,331,887,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2358,ForestSong,Canción del Bosque,1,331,888,0,0,0,2172,188,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2359,Greenpaw Village,Poblado Zarpaverde,1,331,889,0,0,0,2172,0,0,24,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2360,SilverwingOutpost,Avanzada Ala de Plata,1,331,890,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2361,Nighthaven,Amparo de la Noche,1,493,891,0,0,0,2172,0,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2362,ShrineofRemulos,Santuario de Remulos,1,493,892,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2363,StormrageBarrowDens,Túmulo de Tempestira,1,493,893,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2364,TheGreatSea,Mare Magnum,0,40,894,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2365,TheGreatSea,Mare Magnum,0,11,895,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2366,TheBlackMorass,La Ciénaga Negra,269,0,896,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
2367,OldHillsbrad Foothills,Antiguas Laderas de Trabalomas,269,0,897,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
2368,TarrenMill,Molino Tarren,269,2367,898,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2369,Southshore,Costasur,269,2367,899,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2370,DurnholdeKeep,Castillo de Durnholde,269,2367,900,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2371,DunGarok,Dun Garok,269,2367,901,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2372,Hillsbrad Fields,Campos de Trabalomas,269,2367,902,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2373,EasternStrand,Playa del Este,269,2367,903,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2374,NethanderStead,Granja Nethander,269,2367,904,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2375,DarrowHill,Colinas de Darrow,269,2367,905,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2376,SouthpointTower,Torre Austral,269,2367,906,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2377,Thoradin'sWall,Muralla de Thoradin,269,2367,907,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2378,WesternStrand,Playa del Oeste,269,2367,908,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2379,AzurelodeMine,Mina Azur,269,2367,909,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2397,TheGreatSea,Mare Magnum,0,267,910,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2398,TheGreatSea,Mare Magnum,0,130,911,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2399,TheGreatSea,Mare Magnum,0,85,912,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2400,TheForbiddingSea,Mar Adusto,0,47,913,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2401,TheForbiddingSea,Mar Adusto,0,45,914,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2402,TheForbiddingSea,Mar Adusto,0,11,915,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2403,TheForbiddingSea,Mar Adusto,0,8,916,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2404,TethrisAran,Tethris Aran,1,405,917,0,0,0,2172,0,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2405,EthelRethor,Ethel Rethor,1,405,918,0,0,0,2172,227,0,32,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2406,RanazjarIsle,Isla Ranazjar,1,405,919,0,0,0,2172,0,0,35,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2407,Kormek'sHut,Cabaña de Kormek,1,405,920,0,0,0,2172,0,0,32,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2408,ShadowpreyVillage,Aldea Cazasombras,1,405,921,0,0,0,2172,185,0,33,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2417,BlackrockPass,Desfiladero de Roca Negra,0,46,922,0,0,0,2172,0,0,54,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2418,Morgan'sVigil,Vigilia de Morgan,0,46,923,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2419,SlitherRock,Roca Desliz,0,46,924,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2420,TerrorWingPath,Senda del Ala del Terror,0,46,925,0,0,0,2172,0,0,52,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2421,Draco'dar,Draco'dar,0,46,926,0,0,0,2172,0,0,54,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2437,Ragefire,Sima Ígnea,389,0,927,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,0,0,0,0,0,0
2457,NightsongWoods,Bosque Arrullanoche,1,331,928,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2477,TheVeiledSea,Mar de la Bruma,1,1377,929,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2478,Morlos'Aran,Morlos'Aran,1,361,930,0,0,0,2172,0,0,47,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2479,EmeraldSanctuary,Santuario Esmeralda,1,361,931,0,0,0,2172,0,0,48,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2480,JadefireGlen,Cañada Fuego de Jade,1,361,932,0,0,0,2172,0,0,50,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2481,RuinsofConstellas,Ruinas de Constellas,1,361,933,0,0,0,2172,0,0,51,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2497,BitterReaches,Costa Amarga,1,16,934,0,0,0,2172,0,0,53,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2517,RiseoftheDefiler,Alto de los Rapiñadores,0,4,935,0,0,0,2172,0,0,46,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2518,LarissPavilion,Pabellón de Lariss,1,357,936,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2519,WoodpawHills,Colinas Zarpaleña,1,357,937,0,0,0,2172,0,0,41,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2520,WoodpawDen,Guarida de los Zarpaleña,1,357,938,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2521,VerdantisRiver,Río Verdantis,1,357,939,0,0,0,2172,0,0,-1,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2522,RuinsofIsildien,Ruinas de Isildien,1,357,940,0,0,0,2172,0,0,45,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2537,GrimtotemPost,Poblado Tótem Siniestro,1,406,941,0,0,0,2172,226,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2538,CampAparaje,Campamento Aparaje,1,406,942,0,0,0,2172,226,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2539,Malaka'jin,Malaka'jin,1,406,943,0,0,0,2172,185,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2540,BoulderslideRavine,Barranco del Alud,1,406,944,0,0,0,2172,0,0,16,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2541,SishirCanyon,Cañón Sishir,1,406,945,0,0,0,2172,229,0,18,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2557,DireMaul,La Masacre,429,0,946,0,0,29,2172,11,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
2558,DeadwindRavine,Barranco de la Muerte,0,41,947,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2559,DiamondheadRiver,Río Diamante,0,41,948,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2560,Ariden'sCamp,Campamento de Ariden,0,41,949,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2561,TheVice,El Vicio,0,41,950,0,0,0,2172,0,0,57,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2562,Karazhan,Karazhan,0,41,951,0,0,0,2172,0,0,60,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2563,Morgan'sPlot,Terreno de Morgan,0,41,952,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2577,DireMaul,La Masacre,1,357,953,0,0,29,2172,11,0,44,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2597,AlteracValley,Valle de Alterac,30,0,954,0,0,42,2172,242,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
2617,Scrabblescrew'sCamp,Campamento de los Mezclatornillos,1,405,955,0,0,0,2172,226,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2618,JadefireRun,Camino Fuego de Jade,1,361,956,0,0,0,2172,0,0,50,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2619,ThondrorilRiver,Río Thondroril,0,139,957,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2620,ThondrorilRiver,Río Thondroril,0,28,958,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2621,LakeMereldar,Lago Mereldar,0,139,959,0,0,0,2172,0,0,54,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2622,PestilentScar,Cicatriz Pestilente,0,139,960,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2623,TheInfectisScar,La Cicatriz Purulenta,0,139,961,0,0,0,2172,0,0,59,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2624,BlackwoodLake,Lago del Bosque Negro,0,139,962,0,0,0,2172,0,0,58,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2625,EastwallGate,Puerta de la Muralla del Este,0,139,963,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2626,TerrorwebTunnel,Túnel Terroarácnido,0,139,964,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2627,Terrordale,Valle del Terror,0,139,965,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2637,KargathiaKeep,Fuerte de Kargathia,1,331,966,0,0,28,2172,228,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2657,ValleyofBones,Valle de los Huesos,1,405,967,0,0,0,2172,193,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2677,BlackwingLair,Guarida de Alanegra,469,0,968,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
2697,Deadman'sCrossing,Cruce de la Muerte,0,41,969,0,0,0,2172,0,0,50,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2717,MoltenCore,Núcleo de Magma,409,0,970,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
2737,TheScarabWall,El Muro del Escarabajo,1,1377,971,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2738,Southwind Village,Aldea del Viento del Sur,1,1377,972,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2739,TwilightBaseCamp,Campamento Crepúsculo,1,1377,973,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2740,TheCrystalVale,La Vega de Cristal,1,1377,974,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2741,TheScarabDais,Estrado del Escarabajo,1,1377,975,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2742,Hive'Ashi,Colmen'Ashi,1,1377,976,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2743,Hive'Zora,Colmen'Zora,1,1377,977,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2744,Hive'Regal,Colmen'Regal,1,1377,978,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2757,Shrineofthefallenwarrior,Santuario del Guerrero Caído,1,17,979,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2777,AlteracValley,UNUSED Alterac Valley,0,267,980,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2797,BlackfathomDeeps,Cavernas de Brazanegra,1,331,981,0,0,24,2172,176,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2817,***On Map Dungeon***,***On Map Dungeon***,30,0,1157,3,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,68,0,0,0,0,0
2837,TheMaster'sCellar,El Sótano del Maestro,1,41,982,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2838,StonewroughtPass,Paso de Fraguapiedra,0,51,983,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2839,AlteracValley,Valle de Alterac,0,36,984,0,0,38,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2857,TheRumbleCage,La Jaula del Rugido,1,440,985,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741952,0,0,0,0,0
2877,ChunkTest,Chunk Test,451,22,986,0,0,0,2172,0,0,60,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2897,Zoram'garOutpost,Avanzada de Zoram'gar,1,331,987,0,0,24,2172,185,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2917,HallofLegends,Sala de las Leyendas,450,0,988,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,32,0,0,0,0,0
2918,Champions'Hall,Sala de los Campeones,449,0,989,0,0,0,2172,0,0,0,0,0,2,0,0,-1,0,0,0,32,0,0,0,0,0
2937,Grosh'gokCompound,Dominios Grosh'gok,0,41,990,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2938,SleepingGorge,Desfiladero del Letargo,0,41,991,0,0,0,2172,0,0,50,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2957,IrondeepMine,Mina Ferrohondo,30,2597,992,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2958,StonehearthOutpost,Avanzada Piedrahogar,30,2597,993,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2959,DunBaldar,Dun Baldar,30,2597,994,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2960,IcewingPass,Paso de Ala Gélida,30,2597,995,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2961,FrostwolfVillage,Aldea Lobo Gélido,30,2597,996,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2962,TowerPoint,Torre de la Punta,30,2597,997,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2963,ColdtoothMine,Mina Dentefrío,30,2597,998,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2964,WinteraxHold,Fuerte Hacha Invernal,30,2597,999,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2977,IcebloodGarrison,Baluarte Sangrehielo,30,2597,1000,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2978,FrostwolfKeep,Bastión Lobo Gélido,30,2597,1001,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2979,Tor'krenFarm,Granja Tor'kren,1,14,1002,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3017,FrostDaggerPass,Paso de la Daga Escarcha,30,2597,1003,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3037,IronstoneCamp,Campamento Roca de Hierro,1,400,1004,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3038,Weazel'sCrater,Cráter de la Comadreja,1,400,1005,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3039,TahondaRuins,Ruinas de Tahonda,1,400,1006,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3057,FieldofStrife,Tierra de Disputa,30,2597,1007,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3058,IcewingCavern,Cueva Ala Gélida,30,2597,1008,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3077,Valor'sRest,Sosiego del Valor,1,1377,1009,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3097,TheSwarmingPillar,El Pilar de la Ascensión,1,1377,1010,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3098,TwilightPost,Puesto Crepúsculo,1,1377,1011,0,0,0,2172,0,0,57,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3099,TwilightOutpost,Avanzada Crepúsculo,1,1377,1012,0,0,0,2172,0,0,59,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3100,RavagedTwilightCamp,Campamento Crepúsculo Devastado,1,1377,1013,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3117,Shalzaru'sLair,Guarida de Shalzaru,1,357,1014,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3137,TalrendisPoint,Punta Talrendis,1,16,1015,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3138,RethressSanctum,Sagrario de Rethress,1,16,1016,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3139,MoonHorrorDen,Cubil del Horror de la Luna,1,618,1017,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3140,Scalebeard'sCave,Cueva de Barbaescamas,1,16,1018,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3157,BoulderslideCavern,Cueva del Alud,1,406,1019,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3177,WarsongLaborCamp,Campo de trabajos forzados Grito de Guerra,1,331,1020,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3197,ChillwindCamp,Campamento del Orvallo,0,28,1021,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3217,TheMaul,La Marra,1,2557,1022,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741952,0,0,0,0,0
3237,TheMaulUNUSED,The Maul UNUSED,1,2557,1023,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741952,0,0,0,0,0
3257,BonesofGrakkarond,Huesos de Grakkarond,1,1377,1024,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3277,WarsongGulch,Garganta Grito de Guerra,489,0,1025,0,0,38,2172,243,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
3297,FrostwolfGraveyard,Cementerio Lobo Gélido,30,2597,1026,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3298,FrostwolfPass,Paso Lobo Gélido,30,2597,1027,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3299,DunBaldarPass,Paso de Dun Baldar,30,2597,1028,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3300,IcebloodGraveyard,Cementerio Sangrehielo,30,2597,1029,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3301,SnowfallGraveyard,Cementerio Avalancha,30,2597,1030,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3302,StonehearthGraveyard,Cementerio Piedrahogar,30,2597,1031,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3303,StormpikeGraveyard,Cementerio Pico Tormenta,30,2597,1032,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3304,IcewingBunker,Búnker Ala Gélida,30,2597,1033,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3305,StonehearthBunker,Búnker Piedrahogar,30,2597,1034,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3306,WildpawRidge,Risco Zarpa Salvaje,30,2597,1035,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3317,RevantuskVillage,Poblado Sañadiente,0,47,1036,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3318,RockofDurotan,Roca de Durotan,30,2597,1037,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3319,SilverwingGrove,Claro Ala de Plata,1,331,1038,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3320,WarsongLumberMill,Serrería Grito de Guerra,489,3277,1039,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3321,SilverwingHold,Bastión Ala de Plata,489,3277,1040,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3337,WildpawCavern,Caverna Zarpa Salvaje,30,2597,1041,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3338,TheVeiledCleft,La Grieta Velada,30,2597,1042,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3357,YojambaIsle,Isla Yojamba,0,33,1043,0,0,0,2172,245,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3358,ArathiBasin,Cuenca de Arathi,529,0,1044,0,11,37,2172,219,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
3377,TheCoil,El Serpenteo,309,1977,1045,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3378,AltarofHir'eek,Altar de Hir'eek,309,1977,1046,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3379,Shadra'zaar,Shadra'zaar,309,1977,1047,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3380,HakkariGrounds,Tierras Hakkari,309,1977,1048,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3381,NazeofShirvallah,Saliente de Shirvallah,309,1977,1049,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3382,TempleofBethekk,Templo de Bethekk,309,1977,1050,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3383,TheBloodfirePit,Foso de las Llamas de Sangre,309,1977,1051,0,0,0,2172,245,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3384,AltaroftheBloodGod,Altar del Dios de la Sangre,309,1977,1052,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3397,Zanza'sRise,Alto de Zanza,309,1977,1053,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3398,EdgeofMadness,Cabo de la Locura,309,1977,1054,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3417,TrollbaneHall,Bastión de Aterratrols,529,3358,1055,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3418,Defiler'sDen,Guarida de los Rapiñadores,529,3358,1056,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3419,Pagle'sPointe,Punta de Pagle,309,1977,1057,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3420,Farm,Granja,529,3358,1058,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3421,Blacksmith,Herrería,529,3358,1059,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3422,LumberMill,Aserradero,529,3358,1060,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3423,GoldMine,Mina de oro,529,3358,1061,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3424,Stables,Establos,529,3358,1062,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3425,CenarionHold,Fuerte Cenarion,1,1377,1063,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3426,StaghelmPoint,Punta de Corzocelada,1,1377,1064,0,0,0,2172,0,0,59,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3427,BronzebeardEncampment,Campamento Barbabronce,1,1377,1065,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3428,AhnQiraj,Ahn'Qiraj,531,0,1161,0,0,352,2172,248,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
3429,RuinsofAhnQiraj,Ruinas de Ahn'Qiraj,509,0,1162,0,0,352,2172,248,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
3446,TwilightsRun,Paseo Crepúsculo,1,1377,1163,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3447,Ortell'sHideout,Guarida de Ortell,1,1377,1164,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3448,ScarabTerrace,Bancal del Escarabajo,509,3429,1068,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3449,General'sTerrace,Bancal del General,509,3429,1069,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3450,TheReservoir,La Presa,509,3429,1070,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3451,TheHatchery,El Criadero,509,3429,1071,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3452,TheComb,El Panal,509,3429,1072,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3453,Watchers'Terrace,Bancal de los Oteadores,509,3429,1073,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3454,RuinsofAhn'Qiraj,Ruinas de Ahn'Qiraj,1,1377,1074,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3456,Naxxrammas,Naxxramas,533,0,1158,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,3,0,0,0,0,21
3459,CityChannel,Ciudad,0,0,1160,3,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,512,0,0,0,0,0
3478,GatesofAhn'Qiraj,Puerta de Ahn'Qiraj,1,0,1159,0,0,38,2172,176,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
3486,RavenholdtManor,Mansión Ravenholdt,0,36,1076,0,0,0,2172,0,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
13649,TestDungeon,Test Dungeon,13,0,12255,0,0,0,0,0,0,0,0,0,0,0,3,-1,0,0,0,64,0,0,0,0,0
]]

-- Exported from https://wow.tools/dbc/?dbc=taxinodes&build=1.14.1.41030&locale=esMX
local taxiNodesCSV = [[
Name_lang,Pos[0],Pos[1],Pos[2],MapOffset[0],MapOffset[1],FlightMapOffset[0],FlightMapOffset[1],ID,ContinentID,ConditionID,CharacterBitNumber,Flags,UiTextureKitID,Facing,SpecialIconConditionID,VisibilityConditionID,MountCreatureID[0],MountCreatureID[1]
Abadía de Villanorte,-8888.98,-0.54,94.39,0,0,0,0,1,0,0,1,0,0,0,0,0,308,0
"Ventormenta, Elwynn",-8840.56,489.7,109.61,0,0,0,0,2,0,0,2,1,0,0,0,0,0,541
Isla del programador,16391.81,16341.21,69.44,0,0,0,0,3,0,0,3,0,0,0,0,0,308,0
"Colina del Centinela, Páramos de Poniente",-10628.89,1036.68,34.06,0,0,0,0,4,0,0,4,1,0,0,0,0,0,541
"Villa del Lago, Crestagrana",-9429.1,-2231.4,68.65,0,0,0,0,5,0,0,5,1,0,0,0,0,0,541
"Forjaz, Dun Morogh",-4821.78,-1155.44,502.21,0,0,0,0,6,0,0,6,1,0,0,0,0,0,541
"Puerto de Menethil, Los Humedales",-3792.26,-783.29,9.06,0,0,0,0,7,0,0,7,1,0,0,0,0,0,541
"Thelsamar, Loch Modan",-5421.91,-2930.01,347.25,0,0,0,0,8,0,0,8,1,0,0,0,0,0,541
"Bahía del Botín, Tuercespina",-14271.77,299.87,31.09,0,0,0,0,9,0,0,9,0,0,0,0,0,0,541
"El Sepulcro, Bosque de Argénteos",478.86,1536.59,131.32,0,0,0,0,10,0,0,10,2,0,0,0,0,3574,0
"Entrañas, Tirisfal",1568.62,267.97,-43.1,0,0,0,0,11,0,0,11,2,0,0,0,0,3574,0
"Villa Oscura, Bosque del Ocaso",-10515.46,-1261.65,41.34,0,0,0,0,12,0,0,12,1,0,0,0,0,0,541
"Molino Tarren, Trabalomas",-0.06,-859.91,58.83,0,0,0,0,13,0,0,13,2,0,0,0,0,3574,0
"Costasur, Trabalomas",-711.48,-515.48,26.11,0,0,0,0,14,0,0,14,1,0,0,0,0,0,541
Tierras de la Peste del Este,2253.4,-5344.9,83.38,0,0,0,0,15,0,0,15,0,0,0,0,0,0,541
"Refugio de la Zaga, Arathi",-1240.53,-2515.11,22.16,0,0,0,0,16,0,0,16,1,0,0,0,0,0,541
"Sentencia, Arathi",-916.29,-3496.89,70.45,0,0,0,0,17,0,0,17,2,0,0,0,0,2224,0
"Bahía del Botín, Tuercespina",-14444.29,509.62,26.2,0,0,0,0,18,0,0,18,2,0,0,0,0,2224,0
"Bahía del Botín, Tuercespina",-14473.05,464.15,36.43,0,0,0,0,19,0,0,19,1,0,0,0,0,0,541
"Grom'gol, Tuercespina",-12414.18,146.29,3.28,0,0,0,0,20,0,0,20,2,0,0,0,0,2224,0
"Kargath, Tierras Inhóspitas",-6633.99,-2180.05,244.14,0,0,0,0,21,0,0,21,2,0,0,0,0,2224,0
"Cima del Trueno, Mulgore",-1197.21,29.71,176.95,0,0,0,0,22,1,0,22,2,0,0,0,0,2224,0
"Orgrimmar, Durotar",1677.59,-4315.71,61.17,0,0,0,0,23,1,0,23,2,0,0,0,0,2224,0
"Genérico, Objetivo mundial de rutas de zepelines",-6666,-2222.3,278.6,0,0,0,0,24,0,0,24,0,0,0,0,0,0,0
"El Cruce, Los Baldíos",-441.8,-2596.08,96.06,0,0,0,0,25,1,0,25,2,0,0,0,0,2224,0
"Auberdine, Costa Oscura",6341.38,557.68,16.29,0,0,0,0,26,1,0,26,1,0,0,0,0,0,3837
"Aldea Rut'theran, Teldrassil",8643.59,841.05,23.3,0,0,0,0,27,1,0,27,1,0,0,0,0,0,3837
"Astranaar, Vallefresno",2827.34,-289.24,107.16,0,0,0,0,28,1,0,28,1,0,0,0,0,0,3837
"Refugio Roca del Sol, Sierra Espolón",966.57,1040.32,104.27,0,0,0,0,29,1,0,29,2,0,0,0,0,2224,0
"Poblado Viento Libre, Las Mil Agujas",-5407.71,-2414.3,90.32,0,0,0,0,30,1,0,30,2,0,0,0,0,2224,0
"Thalanaar, Feralas",-4491.88,-775.89,-39.52,0,0,0,0,31,1,0,31,1,0,0,0,0,0,3837
"Theramore, Marjal Revolcafango",-3825.37,-4516.58,10.44,0,0,0,0,32,1,0,32,1,0,0,0,0,0,541
"Cima del Espolón, Sierra Espolón",2681.13,1461.68,232.88,0,0,0,0,33,1,0,33,1,0,0,0,0,0,3837
Transporte: Bahía del Botín a Trinquete,-1965.17,-5824.29,-1.06,0,0,0,0,34,1,0,34,0,0,0,0,0,0,0
"Transporte, Zepelines de Orgrimmar",1320.07,-4649.2,21.57,0,0,0,0,35,1,0,35,0,0,0,0,0,0,0
"Genérico, Objetivo mundial",-8644.62,433.28,59.46,0,0,0,0,36,0,0,36,0,0,0,0,0,15665,0
"Punta de Nijel, Desolace",139.24,1325.82,193.5,0,0,0,0,37,1,0,37,1,0,0,0,0,0,3837
"Aldea Cazasombras, Desolace",-1767.64,3263.89,4.94,0,0,0,0,38,1,0,38,2,0,0,0,0,2224,0
"Gadgetzan, Tanaris",-7223.97,-3734.59,8.39,0,0,0,0,39,1,0,39,1,0,0,0,0,0,541
"Gadgetzan, Tanaris",-7048.89,-3780.36,10.19,0,0,0,0,40,1,0,40,2,0,0,0,0,2224,0
"Plumaluna, Feralas",-4373.8,3338.65,12.27,0,0,0,0,41,1,0,41,1,0,0,0,0,0,3837
"Campamento Mojache, Feralas",-4419.86,199.31,25.06,0,0,0,0,42,1,0,42,2,0,0,0,0,2224,0
"Pico Nidal, Tierras del Interior",283.74,-2002.76,194.74,0,0,0,0,43,0,0,43,1,0,0,0,0,0,541
"Valormok, Azshara",3661.52,-4390.38,113.05,0,0,0,0,44,1,0,44,2,0,0,0,0,2224,0
"Castillo de Nethergarde, Las Tierras Devastadas",-11112.25,-3435.74,79.09,0,0,0,0,45,0,0,45,1,0,0,0,0,0,541
"Transbordador de Costasur, Trabalomas",-986.43,-547.86,-3.86,0,0,0,0,46,0,0,46,0,0,0,0,0,0,0
Transporte: Grom'gol a Orgrimmar,-12418.77,235.43,1.12,0,0,0,0,47,0,0,47,0,0,0,0,0,0,0
"Puesto del Veneno, Frondavil",5068.4,-337.22,367.41,0,0,0,0,48,1,0,48,2,0,0,0,0,2224,0
Claro de la Luna,7458.45,-2487.21,462.33,0,0,0,0,49,1,0,49,1,0,0,0,0,0,3837
"Transporte, Naves de Menethil",0,0,0,0,0,0,0,50,0,0,50,0,0,0,0,0,0,0
Transporte: Rut'theran a Auberdine,0,0,0,0,0,0,0,51,0,0,51,0,0,0,0,0,0,0
"Vista Eterna, Cuna del Invierno",6799.24,-4742.44,701.5,0,0,0,0,52,1,0,52,1,0,0,0,0,0,3837
"Vista Eterna, Cuna del Invierno",6813.06,-4611.12,710.67,0,0,0,0,53,1,0,53,2,0,0,0,0,2224,0
Transporte: Plumaluna a Feralas,-4203.87,3284,-12.86,0,0,0,0,54,1,0,54,0,0,0,0,0,0,0
"Poblado Murohelecho, Marjal Revolcafango",-3147.39,-2842.18,34.61,0,0,0,0,55,1,0,55,2,0,0,0,0,2224,0
"Rocal, Pantano de las Penas",-10456.97,-3279.25,21.35,0,0,0,0,56,0,0,56,2,0,0,0,0,2224,0
"Aldea Pesquera, Teldrassil",8701.51,991.37,14.21,0,0,0,0,57,1,0,57,0,0,0,0,0,0,3837
"Avanzada de Zoram'gar, Vallefresno",3374.71,996.97,5.19,0,0,0,0,58,1,0,58,2,0,0,0,0,2224,0
"Dun Baldar, Valle de Alterac",574.21,-46.65,37.61,0,0,0,0,59,30,0,59,1,0,0,0,0,0,541
"Bastión Lobo Gélido, Valle de Alterac",-1335.44,-319.69,90.66,0,0,0,0,60,30,0,60,2,0,0,0,0,3574,0
"Puesto del Hachazo, Vallefresno",2302.39,-2524.55,104.4,0,0,0,0,61,1,0,61,2,0,0,0,0,2224,0
"Amparo de la Noche, Claro de la Luna",7793.61,-2403.47,489.32,0,0,0,0,62,1,0,62,1,0,0,0,0,0,3837
"Amparo de la Noche, Claro de la Luna",7787.72,-2404.1,489.56,0,0,0,0,63,1,0,63,2,0,0,0,0,2224,0
"Punta Talrendis, Azshara",2721.99,-3880.64,100.87,0,0,0,0,64,1,0,64,1,0,0,0,0,0,3837
"Claro Ramaespolón, Frondavil",6205.88,-1949.63,571.29,0,0,0,0,65,1,0,65,1,0,0,0,0,0,3837
"Campamento del Orvallo, Tierras de la Peste del Oeste",931.32,-1430.11,64.67,0,0,0,0,66,0,0,66,1,0,0,0,0,0,541
"Capilla de la Esperanza de la Luz, Tierras de la Peste del Este",2271.09,-5340.8,87.11,0,0,0,0,67,0,0,67,1,0,0,0,0,0,541
"Capilla de la Esperanza de la Luz, Tierras de la Peste del Este",2327.41,-5286.89,81.78,0,0,0,0,68,0,0,68,2,0,0,0,0,3574,0
Claro de la Luna,7470.39,-2123.38,492.34,0,0,0,0,69,1,0,69,2,0,0,0,0,2224,0
"Peñasco Llamarada, Las Estepas Ardientes",-7504.03,-2187.54,165.53,0,0,0,0,70,0,0,70,2,0,0,0,0,2224,0
"Vigilia de Morgan, Las Estepas Ardientes",-8364.61,-2738.35,185.46,0,0,0,0,71,0,0,71,1,0,0,0,0,0,541
"Fuerte Cenarion, Silithus",-6811.39,836.74,49.81,0,0,0,0,72,1,0,72,2,0,0,0,0,2224,0
"Fuerte Cenarion, Silithus",-6761.83,772.03,88.91,0,0,0,0,73,1,0,73,1,0,0,0,0,0,3837
"Puesto del Torio, La Garganta de Fuego",-6552.59,-1168.27,309.31,0,0,0,0,74,0,0,74,1,0,0,0,0,0,541
"Puesto del Torio, La Garganta de Fuego",-6554.93,-1100.05,309.57,0,0,0,0,75,0,0,75,2,0,0,0,0,2224,0
"Poblado Sañadiente, Tierras del Interior",-635.26,-4720.5,5.38,0,0,0,0,76,0,0,76,2,0,0,0,0,2224,0
"Campamento Taurajo, Los Baldíos",-2380.67,-1882.67,95.85,0,0,0,0,77,1,0,77,2,0,0,0,0,2224,0
Naxxramas,3133.31,-3399.93,139.53,0,0,0,0,78,0,0,78,0,0,0,0,0,0,0
"Refugio de Marshal, Cráter de Un'Goro",-6113.82,-1142.7,-187.63,0,0,0,0,79,1,0,79,3,0,0,0,0,2224,541
"Trinquete, Los Baldíos",-894.59,-3773.01,11.48,0,0,0,0,80,1,0,80,3,0,0,0,0,2224,541
"Torre del Bosque de la Peste, Tierras de la Peste de Este",2998.71,-3050.1,117.19,0,0,0,0,84,0,0,84,3,0,0,0,0,17660,17660
"Torre del Paso Norte, Tierras de la Peste del Este",3109.31,-4285.13,109.45,0,0,0,0,85,0,0,85,3,0,0,0,0,3574,541
"Torre de la Muralla del Este, Tierras de la Peste del Este",2499.23,-4742.85,93.5,0,0,0,0,86,0,0,86,3,0,0,0,0,3574,541
"Torre de la Corona, Tierras de la Peste del Este",1857.56,-3658.47,143.73,0,0,0,0,87,0,0,87,3,0,0,0,0,3574,541
]]

L.areaTable = addon.LoadCSVData(areaTableCSV, "ID")
L.taxiNodes = addon.LoadCSVData(taxiNodesCSV, "ID")
