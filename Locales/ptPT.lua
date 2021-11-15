local addonName, addon = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "ptPT")
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
-- L["CREATE_NEW_JOURNEY"] = "Create New Journey"
-- L["CREATE_NEW_JOURNEY_DESC"] = "Create a new journey, make it active and open it in the journey editor."
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
-- Exported from https://wow.tools/dbc/?dbc=areatable&build=1.14.1.41030&locale=ptPT
local areaTableCSV = [[
ID,ZoneName,AreaName_lang,ContinentID,ParentAreaID,AreaBit,SoundProviderPref,SoundProviderPrefUnderwater,AmbienceID,UwAmbience,ZoneMusic,UwZoneMusic,ExplorationLevel,IntroSound,UwIntroSound,FactionGroupMask,Ambient_multiplier,MountFlags,PvpCombatWorldStateID,WildBattlePetLevelMin,WildBattlePetLevelMax,WindSettingsID,Flags[0],Flags[1],LiquidTypeID[0],LiquidTypeID[1],LiquidTypeID[2],LiquidTypeID[3]
1,DunMorogh,Dun Morogh,0,0,119,0,11,42,2172,8,0,0,0,0,2,0,0,-1,0,0,0,65,0,0,0,0,0
2,Longshore,Praia Grande,0,40,120,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3,Badlands,Ermos,0,0,121,0,11,25,2172,7,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
4,BlastedLands,Barreira do Inferno,0,0,122,0,11,210,2172,7,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
7,DarkwaterCove,Angra Aguanegra,0,33,123,0,11,0,2172,3,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
8,SwampofSorrows,Pântano das Mágoas,0,0,124,0,11,33,2172,223,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
9,NorthshireValley,Vale de Vila Norte,0,12,125,0,11,35,2172,1,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
10,Duskwood,Floresta do Crepúsculo,0,0,617,0,11,40,2172,2,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
11,Wetlands,Pantanal,0,0,618,0,11,44,2172,227,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
12,ElwynnForest,Floresta de Elwynn,0,0,126,0,11,35,2172,1,0,0,0,0,2,0,0,-1,0,0,0,64,0,0,0,0,0
13,TheWorldTree,A Árvore do Mundo,0,10,555,0,11,48,2172,11,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
14,Durotar,Durotar,1,0,127,0,11,25,2172,9,0,0,0,0,4,0,0,-1,0,0,0,64,0,0,0,0,0
15,DustwallowMarsh,Pântano Vadeoso,1,0,128,0,11,33,2172,227,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
16,Azshara,Azshara,1,0,129,0,11,31,2172,205,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
17,TheBarrens,Sertões,1,0,130,0,11,38,2172,7,0,0,0,0,4,0,0,-1,0,0,0,64,0,0,0,0,0
18,CrystalLake,Lago de Cristal,0,12,131,0,11,35,2172,1,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
19,Zul'Gurub,Zul'Gurub,0,33,574,0,11,32,2172,3,0,40,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
20,Moonbrook,Arroio da Lua,0,40,132,0,11,0,2172,9,0,14,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
21,KulTiras,Kul Tiraz,0,0,133,0,11,0,2172,8,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
22,ProgrammerIsle,Ilha dos Programadores,451,0,547,0,11,38,2172,2,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
23,NorthshireRiver,Rio Vila Norte,0,12,134,0,11,35,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
24,Northshireabbey,Abadia de Vila Norte,0,12,135,73,11,35,2172,1,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
25,BlackrockMountain,Montanha Rocha Negra,0,0,136,0,11,46,2172,10,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
26,Lighthouse,Farol,0,40,602,0,11,0,2172,7,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
28,WesternPlaguelands,Terras Pestilentas Ocidentais,0,0,137,0,11,37,2172,205,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
30,Nine,Nove,0,0,138,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
32,TheCemetary,O Cemitério,0,10,139,0,11,0,2172,2,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
33,StranglethornJungle,Selva do Espinhaço,0,0,140,0,11,32,2172,3,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
34,EchoRidgeMine,Mina da Serra do Eco,0,12,141,0,11,35,2172,1,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
35,BootyBay,Angra do Butim,0,33,142,0,11,0,2172,3,0,42,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
36,AlteracMountains,Montanhas de Alterac,0,0,143,0,11,31,2172,1,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
37,LakeNazferiti,Lago Nazferiti,0,33,144,0,11,0,2172,3,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
38,LochModan,Loch Modan,0,0,145,0,11,31,2172,1,0,0,0,0,2,0,0,-1,0,0,0,64,0,0,0,0,0
40,Westfall,Cerro Oeste,0,0,146,0,11,47,2172,9,0,0,0,0,2,0,0,-1,0,0,0,64,0,0,0,0,0
41,DeadwindPass,Trilha do Vento Morto,0,0,556,0,11,49,2172,2,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
42,Darkshire,Vila Sombria,0,10,147,0,11,0,2172,2,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
43,WildShore,Praia Selvagem,0,33,148,0,11,0,2172,3,0,42,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
44,RedridgeMountains,Montanhas Cristarrubra,0,0,149,0,11,31,2172,1,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
45,ArathiHighlands,Planalto Arathi,0,0,150,0,11,30,2172,8,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
46,BurningSteppes,Estepes Ardentes,0,0,151,0,11,46,2172,10,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
47,TheHinterlands,Terras Agrestes,0,0,152,0,11,31,2172,1,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
49,DeadMansHole,Antro do Morto,0,22,153,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
51,SearingGorge,Garganta Abrasadora,0,0,154,0,11,46,2172,10,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
53,ThievesCamp,Acampamento dos Ladrões,0,12,155,0,11,35,2172,1,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
54,JasperlodeMine,Mina de Jaspe,0,12,550,0,11,35,2172,1,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
55,ValleyofHeroesUNUSED,Valley of Heroes UNUSED,0,12,156,0,11,35,2172,17,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
56,Heroes'Vigil,Vigia dos Heróis,0,12,157,0,11,35,2172,1,0,0,303,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
57,FargodeepMine,Mina Vailafundo,0,12,158,0,11,35,2172,1,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
59,NorthshireVineyards,Vinhedos de Vila Norte,0,12,159,0,11,35,2172,1,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
60,Forest'sEdge,Boca da Mata,0,12,606,0,11,35,2172,1,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
61,ThunderFalls,Cachoeira do Trovão,0,12,160,0,11,35,2172,1,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
62,PumpkinPatch,Plantação de Abóboras dos Braga,0,12,161,0,11,35,2172,1,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
63,TheStonefieldFarm,Fazenda dos Campedra,0,12,162,0,11,35,2172,1,0,6,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
64,TheMaclureVineyards,Vinhedos dos Madruga,0,12,163,0,11,35,2172,1,0,6,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
65,***On Map Dungeon***,***On Map Dungeon***,0,0,164,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,68,0,0,0,0,0
66,***On Map Dungeon***,***On Map Dungeon***,1,0,165,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,68,0,0,0,0,0
67,***On Map Dungeon***,***On Map Dungeon***,17,0,166,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,68,0,0,0,0,0
68,LakeEverstill,Lago Plácido,0,44,557,0,11,0,2172,1,0,16,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
69,Lakeshire,Vila Plácida,0,44,167,0,11,0,2172,1,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
70,Stonewatch,Mirante de Pedra,0,44,168,0,11,0,2172,1,0,24,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
71,StonewatchFalls,Cachoeira do Mirante de Pedra,0,44,627,0,11,0,2172,1,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
72,TheDarkPortal,Portal Negro,0,4,169,0,11,210,2172,7,0,63,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
73,TheTaintedScar,Rasgo Infecto,0,4,170,0,11,0,2172,7,0,50,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
74,PoolofTears,Poço de Lágrimas,0,8,171,0,11,0,2172,0,0,43,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
75,Stonard,Pedregal,0,8,172,0,11,0,2172,0,0,37,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
76,FallowSanctuary,Retiro Alqueivado,0,8,173,0,11,0,2172,0,0,37,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
77,Anvilmar,Sidermar,0,1,174,0,11,0,2172,8,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
80,StormwindMountains,Montanhas de Ventobravo,0,12,175,0,11,35,2172,17,0,10,0,0,2,0,0,-1,0,0,0,1073741888,0,0,0,0,0
81,JeffNEQuadrantChanged,Jeff NE Quadrant Changed,451,22,575,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
82,JeffNWQuadrant,Jeff NW Quadrant,451,22,176,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
83,JeffSEQuadrant,Jeff SE Quadrant,451,22,177,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
84,JeffSWQuadrant,Jeff SW Quadrant,451,22,178,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
85,TirisfalGlades,Clareiras de Tirisfal,0,0,179,0,11,40,2172,2,0,0,0,0,4,0,0,-1,0,0,0,64,0,0,0,0,0
86,StoneCircleLake,Lago do Monumento,0,12,180,0,11,35,2172,1,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
87,Goldshire,Vila d'Ouro,0,12,548,0,11,35,2172,1,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
88,EastvaleLoggingCamp,Madeireira Vale do Leste,0,12,181,0,11,35,2172,1,0,6,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
89,ThunderFallsOrchard,Pomar do Lago Espelhado,0,12,182,0,11,35,2172,1,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
91,TowerofAzora,Torre de Azora,0,12,183,0,11,35,2172,1,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
92,MirrorLake,Lago Espelhado,0,12,558,0,11,35,2172,1,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
93,Vul'GolOgreMound,Gruta de Vul'Gol,0,10,628,0,11,0,2172,214,0,28,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
94,RavenHill,Monte Corvo,0,10,184,0,11,0,2172,2,0,24,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
95,RedridgeCanyon,Garganta Cristarrubra,0,44,185,0,11,0,2172,1,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
96,TowerofIlgalar,Torre de Ilgalar,0,44,186,0,11,0,2172,1,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
97,Alther'sMill,Serraria Alther,0,44,187,0,11,0,2172,1,0,19,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
98,RethbanCaverns,Cavernas Retibanas,0,44,188,0,11,0,2172,1,0,17,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
99,RebelCamp,Acampamento dos Rebeldes,0,33,189,0,11,0,2172,3,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
100,Nesingwary'sExpedition,Expedição do Rosarães,0,33,585,0,11,0,2172,3,0,31,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
101,Kurzen'sCompound,Complexo do Kurzen,0,33,190,0,11,0,2172,3,0,32,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
102,RuinsofZul'Kunda,Ruínas de Zul'Kanda,0,33,586,0,11,0,2172,3,0,41,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
103,RuinsofZul'Mamwe,Ruínas de Zul'Mamwe,0,33,191,0,11,0,2172,3,0,40,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
104,TheVileReef,O Arrecife Torpe,0,33,192,0,11,0,2172,3,0,37,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
105,Mosh'OggOgreMound,Gruta de Mosh'Ogg,0,33,193,0,11,0,2172,3,0,42,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
106,TheStockpile,O Arsenal,0,33,194,0,11,0,2172,3,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
107,Saldean'sFarm,Fazenda dos Saldanha,0,40,195,0,11,0,2172,9,0,14,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
108,SentinelHill,Morro da Sentinela,0,40,196,0,11,0,2172,9,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
109,Furlbrow'sPumpkinFarm,Plantação de Abóboras do Taturana,0,40,197,0,11,0,2172,9,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
111,JangolodeMine,Mina Veiojango,0,40,198,0,11,0,2172,9,0,12,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
113,GoldCoastQuarry,Pedreira Costa Dourada,0,40,576,0,11,0,2172,9,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
115,WestfallLighthouse,Farol de Cerro Oeste,0,40,199,0,11,24,2172,9,0,17,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
116,MistyValley,Vale Nebuloso,0,8,200,0,11,0,2172,0,0,39,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
117,Grom'golBaseCamp,Acampamento Grom'gol,0,33,629,0,11,0,2172,228,0,35,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
118,Whelgar'sExcavationSite,Sítio de Escavação de Whelgar,0,11,201,0,11,0,2172,191,0,22,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
120,WestbrookGarrison,Guarnição da Ribeira d'Oeste,0,12,559,0,11,35,2172,0,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
121,TranquilGardensCemetery,Cemitério Jardins da Paz,0,10,202,0,11,0,2172,15,0,28,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
122,ZuuldaiaRuins,Ruínas Zuuldaia,0,33,203,0,11,0,2172,3,0,37,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
123,Bal'lalRuins,Ruínas de Bal'lal,0,33,204,0,11,0,2172,3,0,34,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
125,Kal'aiRuins,Ruínas de Kal'ai,0,33,205,0,11,0,2172,3,0,35,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
126,TkashiRuins,Ruínas de Tkashi,0,33,206,0,11,0,2172,3,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
127,Balia'mahRuins,Ruínas de Balia'mah,0,33,207,0,11,0,2172,3,0,40,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
128,Ziata'jaiRuins,Ruínas Ziata'jai,0,33,208,0,11,0,2172,3,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
129,MizjahRuins,Ruínas de Nizjah,0,33,209,0,11,0,2172,3,0,37,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
130,SilverpineForest,Floresta de Pinhaprata,0,0,210,0,11,28,2172,2,0,0,0,0,4,0,0,-1,0,0,0,64,0,0,0,0,0
131,Kharanos,Kharanos,0,1,211,0,11,0,2172,0,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
132,ColdridgeValley,Vale Cristálgida,0,1,212,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
133,Gnomeregan,Gnomeregan,0,1,213,0,11,42,2172,8,0,10,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
134,Gol'BolarQuarry,Pedreira Gol'Bolar,0,1,214,0,11,0,2172,8,0,10,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
135,FrostmaneHold,Fortaleza Jubafria,0,1,215,0,11,0,2172,0,0,7,121,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
136,TheGrizzledDen,Covil Cinzento,0,1,216,0,11,0,2172,0,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
137,BrewnallVillage,Aldeia da Cevada,0,1,217,0,11,0,2172,0,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
138,MistyPineRefuge,Refúgio Pinhal das Brumas,0,1,218,0,11,0,2172,8,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
139,EasternPlaguelands,Terras Pestilentas Orientais,0,0,219,0,11,37,2172,205,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
141,Teldrassil,Teldrassil,1,0,220,0,11,48,2172,11,0,0,0,0,2,0,0,-1,0,0,0,64,0,0,0,0,0
142,Ironband'sExcavationSite,Sítio de Escavação de Bandaferro,0,38,221,0,11,0,2172,1,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
143,Mo'groshStronghold,Fortaleza Mo'grosh,0,38,222,0,11,0,2172,14,0,18,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
144,Thelsamar,Thelsamar,0,38,223,0,11,0,2172,1,0,10,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
145,AlgazGate,Portão de Algaz,0,38,224,0,11,0,2172,1,0,18,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
146,StonewroughtDam,Dique Lapidado,0,38,225,0,11,230,2172,1,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
147,TheFarstriderLodge,Pavilhão dos Andarilhos,0,38,226,0,11,0,2172,1,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
148,Darkshore,Costa Negra,1,0,227,0,11,28,2172,191,0,0,0,0,2,0,0,-1,0,0,0,64,0,0,0,0,0
149,SilverStreamMine,Mina da Prata,0,38,228,0,11,0,2172,1,0,12,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
150,MenethilHarbor,Porto de Menethil,0,11,229,0,11,0,2172,191,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
151,DesignerIsland,Ilha dos Designers,451,0,560,0,11,47,2172,226,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
152,TheBulwark,O Baluarte,0,85,230,0,11,0,2172,2,0,9,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
153,RuinsofLordaeron,Ruínas de Lordaeron,0,85,607,0,11,0,2172,2,0,10,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
154,Deathknell,Plangemortis,0,85,231,0,11,0,2172,15,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
155,NightWeb'sHollow,Vale Teia da Noite,0,85,232,0,11,0,2172,2,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
156,SollidenFarmstead,Fazenda dos Solliden,0,85,233,0,11,0,2172,2,0,6,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
157,AgamandMills,Moinhos dos Agamand,0,85,234,0,11,0,2172,15,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
158,AgamandFamilyCrypt,Cripta da Família Agamand,0,85,235,0,11,0,2172,15,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
159,Brill,Montalvo,0,85,236,0,11,0,2172,15,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
160,WhisperingGardens,Jardins Murmurantes,0,85,237,0,11,0,2172,2,0,12,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
161,TerraceofRepose,Terraço do Repouso,0,85,238,0,11,0,2172,2,0,10,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
162,BrightwaterLake,Lago Águas Claras,0,85,239,0,11,0,2172,2,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
163,Gunther'sRetreat,Refúgio de Tertuliano,0,85,240,0,11,0,2172,2,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
164,Garren'sHaunt,Sítio dos Garren,0,85,241,0,11,0,2172,2,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
165,BalnirFarmstead,Fazenda dos Balnir,0,85,242,0,11,0,2172,15,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
166,ColdHearthManor,Casarão Lar Glacial,0,85,243,0,11,0,2172,2,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
167,CrusaderOutpost,Guarita dos Cruzados,0,85,244,0,11,0,2172,2,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
168,TheNorthCoast,Costa Norte,0,85,245,0,11,0,2172,2,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
169,Whispering Shore,Praia Sibilante,0,85,577,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
170,LordamereLake,Espelho de Lordaeron,0,0,246,0,11,31,2172,2,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
172,FenrisIsle,Ilha de Fenris,0,130,247,0,11,0,2172,2,0,18,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
173,Faol'sRest,Repouso de Faol,0,85,620,0,11,0,2172,2,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
186,Dolanaar,Dolanaar,1,141,622,0,11,0,2172,11,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
187,DarnassusUNUSED,Darnassus UNUSED,1,141,248,0,11,48,2172,76,0,7,63,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
188,Shadowglen,Umbravale,1,141,561,0,11,0,2172,11,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
189,Steelgrill'sDepot,Garagem do Gradaço,0,1,249,0,11,0,2172,8,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
190,Hearthglen,Amparo,0,28,250,0,11,0,2172,0,0,56,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
192,NorthridgeLumberCamp,Madeireira Beiranorte,0,28,251,0,11,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
193,RuinsofAndorhal,Ruínas de Andorhal,0,28,252,0,11,0,2172,15,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
195,SchoolofNecromancy,Escola de Necromancia,0,28,253,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
196,Uther'sTomb,Tumba de Uther,0,28,578,0,11,0,2172,15,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
197,SorrowHill,Colina do Pesar,0,28,254,0,11,0,2172,0,0,50,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
198,TheWeepingCave,Caverna das Lágrimas,0,28,255,0,11,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
199,FelstoneField,Campo Pedravil,0,28,256,0,11,0,2172,10,0,50,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
200,Dalson'sTears,Lágrimas de Dalson,0,28,257,0,11,0,2172,10,0,54,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
201,Gahrron'sWithering,Aridez de Garrão,0,28,258,0,11,0,2172,10,0,57,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
202,TheWrithingHaunt,O Antro Repelente,0,28,259,0,11,0,2172,10,0,46,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
203,MardenholdeKeep,Bastilha Mardenforte,0,28,260,0,11,37,2172,193,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
204,PyrewoodVillage,Vilarejo Lenhardente,0,130,261,0,11,0,2172,191,0,15,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
205,DunModr,Dun Modr,0,11,262,0,11,0,2172,191,0,28,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
206,Westfall,Cerro Oeste,36,0,263,0,11,47,2172,9,0,0,0,0,0,0,0,-1,0,0,0,65600,0,0,0,0,0
207,TheGreatSea,O Grande Oceano,36,0,264,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
208,UnusedIroncladcove,Unused Ironcladcove,36,0,265,76,11,34,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
209,ShadowfangKeep,Bastilha da Presa Negra,33,0,266,0,11,28,2172,2,0,16,0,0,4,0,0,-1,0,0,0,0,0,0,0,0,0
210,***On Map Dungeon***,***On Map Dungeon***,36,0,267,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,68,0,0,0,0,0
211,IceflowLake,Lago Nevado,0,1,268,0,11,0,2172,8,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
212,Helm'sBedLake,Lago Helm,0,1,269,0,11,0,2172,8,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
213,DeepElemMine,Mina Elenfunda,0,130,270,0,11,0,2172,2,0,13,324,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
214,TheGreatSea,O Grande Oceano,0,0,271,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
215,Mulgore,Mulgore,1,0,272,0,11,30,2172,9,0,0,0,0,4,0,0,-1,0,0,0,64,0,0,0,0,0
219,AlexstonFarmstead,Fazenda dos Aleixo,0,40,273,0,11,0,2172,9,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
220,RedCloudMesa,Chapada Nuvem Vermelha,1,215,562,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
221,CampNarache,Aldeia Narache,1,215,274,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
222,BloodhoofVillage,Aldeia Casco Sangrento,1,215,275,0,11,0,2172,226,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
223,StonebullLake,Lago da Ferradura,1,215,276,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
224,RavagedCaravan,Caravana Devastada,1,215,277,0,11,0,2172,9,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
225,RedRocks,Rochedo Vermelho,1,215,278,0,11,0,2172,9,0,9,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
226,TheSkitteringDark,Penumbra Furtiva,0,130,551,0,11,0,2172,0,0,11,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
227,Valgan'sField,Sítio do Valgan,0,130,279,0,11,0,2172,2,0,11,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
228,TheSepulcher,O Sepulcro,0,130,280,0,11,0,2172,15,0,10,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
229,Olsen'sFarthing,Miséria de Olsen,0,130,281,0,11,0,2172,0,0,12,161,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
230,TheGreymaneWall,Muralha Greymane,0,130,282,0,11,0,2172,0,0,18,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
231,Beren'sPeril,Cilada de Beren,0,130,283,0,11,0,2172,191,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
232,TheDawningIsles,Ilhas da Aurora,0,130,284,0,11,0,2172,2,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
233,Ambermill,Lenhâmbar,0,130,285,0,11,0,2172,191,0,15,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
235,FenrisKeep,Castelo Fenris,0,130,608,0,11,0,2172,219,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
236,Shadowfang Keep,Bastilha da Presa Negra,0,130,286,0,11,28,2172,2,0,16,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
237,TheDecrepitFerry,Campos Apodrecidos,0,130,287,0,11,0,2172,2,0,16,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
238,Malden'sOrchard,Horto dos Maldonado,0,130,587,0,11,0,2172,2,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
239,TheIvarPatch,Plantação do Ivar,0,130,588,0,11,0,2172,2,0,11,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
240,TheDeadField,Campo Morto,0,130,288,0,11,0,2172,2,0,12,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
241,TheRottingOrchard,O Horto Pútrido,0,10,289,0,11,0,2172,2,0,26,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
242,BrightwoodGrove,Bosque Brilhante,0,10,290,0,11,0,2172,2,0,28,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
243,ForlornRowe,Morro dos Esquecidos,0,10,291,0,11,0,2172,2,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
244,TheWhippleEstate,Propriedade dos Whipple,0,10,292,0,11,0,2172,2,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
245,TheYorgenFarmstead,Fazenda dos Figueira,0,10,563,0,11,0,2172,2,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
246,TheCauldron,O Caldeirão,0,51,293,0,11,0,2172,10,0,48,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
247,GrimesiltDigSite,Escavação Pedrassuja,0,51,294,0,11,0,2172,0,0,45,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
249,DreadmaulRock,Rochedo Malhorrendo,0,46,1,0,11,0,2172,10,0,50,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
250,RuinsofThaurisan,Ruínas de Thaurissan,0,46,579,0,11,0,2172,0,0,54,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
251,FlameCrest,Monte Candente,0,46,2,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
252,BlackrockStronghold,Fortaleza Rocha Negra,0,46,3,0,11,0,2172,0,0,57,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
253,ThePillarofAsh,Pilar de Cinzas,0,46,4,0,11,0,2172,0,0,56,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
254,BlackrockMountain,Montanha Rocha Negra,0,46,630,0,11,0,2172,10,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
255,AltarofStorms,Altar das Tempestades,0,46,5,0,11,0,2172,10,0,59,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
256,Aldrassil,Aldrassil,1,141,6,0,11,0,2172,11,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
257,ShadowthreadCave,Caverna Fionumbra,1,141,7,0,11,0,2172,11,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
258,FelRock,Pedra Vil,1,141,8,0,11,0,2172,11,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
259,LakeIl'Ameth,Lago Al'Ameth,1,141,9,0,11,0,2172,11,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
260,StarbreezeVillage,Vilarejo Brisastral,1,141,10,0,11,0,2172,11,0,6,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
261,GnarlpineHold,Acampamento Masca-pinho,1,141,11,0,11,0,2172,0,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
262,Ban'ethilBarrowDen,Gruta de Ban'ethil,1,141,12,0,11,0,2172,11,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
263,TheCleft,A Fenda,1,141,13,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
264,TheOracleGlade,Clareira do Oráculo,1,141,14,0,11,0,2172,11,0,9,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
265,WellspringRiver,Rio Olho-d'Água,1,141,15,0,11,0,2172,0,0,11,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
266,WellspringLake,Lago Olho-d'Água,1,141,16,0,11,0,2172,0,0,9,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
267,HillsbradFoothills,Contraforte de Eira dos Montes,0,0,17,0,11,31,2172,1,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
268,AzsharaCrater,Cratera de Azshara,37,0,580,0,11,42,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
269,DunAlgaz,Dun Algaz,0,0,18,0,11,31,2172,0,0,18,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
271,Southshore,Costa Sul,0,267,615,0,11,0,2172,1,0,22,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
272,TarrenMill,Serraria Tarren,0,267,19,0,11,0,2172,182,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
275,DurnholdeKeep,Forte do Desterro,0,267,20,0,11,0,2172,191,0,21,302,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
276,StonewroughtPass,UNUSED Stonewrought Pass,0,0,564,0,11,31,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
277,TheFoothillCaverns,Caverna do Pé da Serra,0,36,21,0,11,0,2172,1,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
278,LordamereInternmentCamp,Campo de Internação de Lordaeron,0,36,22,0,11,0,2172,1,0,32,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
279,Dalaran,Dalaran,0,36,23,0,11,0,2172,0,0,30,81,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
280,Strahnbrad,Strahnbrad,0,36,24,0,11,37,2172,10,0,34,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
281,RuinsofAlterac,Ruínas de Alterac,0,36,25,0,11,37,2172,10,0,36,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
282,CrushridgeHold,Bastilha Esmagaterra,0,36,26,0,11,37,2172,10,0,35,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
283,SlaughterHollow,Antro do Massacre,0,36,27,0,11,37,2172,10,0,35,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
284,TheUplands,As Terras Altas,0,36,28,0,11,0,2172,1,0,27,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
285,SouthpointTower,Torre do Sul,0,267,29,0,11,0,2172,2,0,21,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
286,HillsbradFields,Campos de Eira dos Montes,0,267,30,0,11,0,2172,1,0,22,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
287,Hillsbrad,Eira dos Montes,0,267,31,0,11,0,2172,1,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
288,AzurelodeMine,Mina Veioazul,0,267,32,0,11,0,2172,0,0,27,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
289,NethanderStead,Sítio de Nethander,0,267,33,0,11,0,2172,1,0,26,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
290,DunGarok,Dun Garok,0,267,34,0,11,0,2172,1,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
293,Thoradin'sWall,Muralha de Thoradin,0,0,35,0,11,31,2172,1,0,30,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
294,EasternStrand,Praia Oriental,0,267,36,0,11,0,2172,1,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
295,WesternStrand,Praia Ocidental,0,267,616,0,11,0,2172,1,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
296,SouthSeasUNUSED,South Seas UNUSED,0,0,37,0,11,24,2172,0,0,0,122,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
297,JagueroIsle,Ilha Jaguara,0,33,38,0,11,0,2172,0,0,50,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
298,BaradinBay,Baía de Baradin,0,11,39,0,11,0,2172,3,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
299,MenethilBay,Baía de Menethil,0,11,40,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
300,MistyReedStrand,Praia Brumalga,0,8,41,0,11,0,2172,0,0,41,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
301,TheSavageCoast,Costa Selvagem,0,33,42,0,11,0,2172,3,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
302,TheCrystalShore,Praia Cristalina,0,33,565,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
303,ShellBeach,Praia da Concha,0,33,43,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
305,NorthTide'sRun,Costa da Maré do Norte,0,130,44,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
306,SouthTide'sRun,Costa da Maré do Sul,0,130,45,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
307,TheOverlookCliffs,Penhascos Panorâmicos,0,47,46,0,11,0,2172,1,0,48,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
308,TheForbiddingSea,O Mar Proibido,0,0,631,0,11,0,2172,1,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
309,Ironbeard'sTomb,Tumba dos Barbaférreos,0,11,47,0,11,0,2172,0,0,24,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
310,CrystalveinMine,Mina Veia de Cristal,0,33,48,0,11,0,2172,0,0,41,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
311,RuinsofAboraz,Ruínas de Aboraz,0,33,589,0,11,0,2172,0,0,44,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
312,Janeiro'sPoint,Pontal de Janeiro,0,33,49,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
313,NorthfoldManor,Casa Grande do Norte,0,45,632,0,11,0,2172,0,0,31,302,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
314,Go'ShekFarm,Fazenda Go'Shek,0,45,50,0,11,0,2172,0,0,33,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
315,Dabyrie'sFarmstead,Fazenda dos Dabyrie,0,45,590,0,11,0,2172,0,0,31,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
316,BoulderfistHall,Forte Punho de Pedra,0,45,51,0,11,31,2172,0,0,35,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
317,WitherbarkVillage,Aldeia Cascasseca,0,45,609,0,11,0,2172,3,0,33,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
318,DrywhiskerGorge,Garganta Seca,0,45,52,0,11,0,2172,0,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
320,RefugePointe,Ponta do Refúgio,0,45,53,0,11,0,2172,0,0,30,123,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
321,Hammerfall,Ruína do Martelo,0,45,54,0,11,0,2172,14,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
322,BlackwaterShipwrecks,Destroços de Aguanegra,0,45,581,0,11,0,2172,8,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
323,O'Breen'sCamp,Acampamento do Nabrava,0,45,55,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
324,StromgardeKeep,Bastilha de Stromgarde,0,45,56,0,11,0,2172,186,0,36,182,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
325,TheTowerofArathor,Torre de Arathor,0,45,57,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
326,TheSanctum,O Sacrário,0,45,58,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
327,Faldir'sCove,Enseada de Faldir,0,45,59,0,11,0,2172,3,0,40,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
328,TheDrownedReef,Recife dos Afogados,0,45,566,0,11,0,2172,192,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
330,ThandolSpan,Ponte Thandol,0,0,60,0,11,44,2172,3,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
331,Ashenvale,Vale Gris,1,0,61,0,11,48,2172,11,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
332,TheGreatSea,O Grande Oceano,1,0,62,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
333,CircleofEastBinding,Círculo de União Oriental,0,45,63,0,11,0,2172,0,0,38,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
334,CircleofWestBinding,Círculo de União Ocidental,0,45,64,0,11,0,2172,0,0,38,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
335,CircleofInnerBinding,Círculo de União Interno,0,45,65,0,11,0,2172,0,0,38,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
336,CircleofOuterBinding,Círculo de União Externo,0,45,66,0,11,0,2172,0,0,38,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
337,Apocryphan'sRest,Descanso do Apócrifo,0,3,67,0,11,25,2172,7,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
338,AngorFortress,Fortaleza Angor,0,3,633,0,11,25,2172,7,0,39,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
339,LethlorRavine,Ravina Lethlor,0,3,634,0,11,25,2172,0,0,45,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
340,Kargath,Karrath,0,3,68,0,11,25,2172,0,0,38,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
341,CampKosh,Acampamento Kosh,0,3,69,0,11,25,2172,0,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
342,CampBoff,Acampamento Barf,0,3,70,0,11,25,2172,0,0,39,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
343,CampWurg,Acampamento Wurg,0,3,71,0,11,25,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
344,CampCagg,Acampamento Cang,0,3,72,0,11,25,2172,0,0,43,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
345,Agmond'sEnd,Ruína de Agmundo,0,3,73,0,11,25,2172,7,0,39,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
346,Hammertoe'sDigsite,Sítio de Escavação do Pé-de-malho,0,3,74,0,11,25,2172,0,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
347,DustbelchGrotto,Gruta Arrota-pó,0,3,75,0,11,25,2172,0,0,43,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
348,AeriePeak,Ninho da Águia,0,47,76,0,11,0,2172,1,0,41,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
349,WildhammerKeep,Bastilha Martelo Feroz,0,47,77,0,11,0,2172,1,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
350,Quel'DanilLodge,Pavilhão Quel'Danil,0,47,78,0,11,0,2172,1,0,45,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
351,SkulkRock,Rocha Oculta,0,47,79,0,11,0,2172,1,0,48,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
352,Zun'watha,Zun'watha,0,47,80,0,11,0,2172,1,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
353,Shadra'Alor,Shadra'Alor,0,47,81,0,11,0,2172,3,0,44,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
354,Jintha'Alor,Jintha'Alor,0,47,591,0,11,0,2172,227,0,45,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
355,TheAltarofZul,Altar de Zul,0,47,592,0,11,0,2172,176,0,46,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
356,Seradane,Seradane,0,47,82,0,11,0,2172,76,0,41,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
357,Feralas,Feralas,1,0,83,0,11,48,2172,3,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
358,BramblebladeRavine,Ravina da Lâmina Espinhenta,1,215,84,0,11,25,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
359,BaelModan,Bael Modan,1,17,85,0,11,0,2172,7,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
360,TheVentureCo.Mine,Mina da Empreendimentos S.A.,1,215,86,0,11,0,2172,9,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
361,Felwood,Selva Maleva,1,0,87,0,11,28,2172,193,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
362,RazorHill,Monte Navalha,1,14,88,0,11,0,2172,9,0,5,421,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
363,ValleyofTrials,Vale das Provações,1,14,89,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
364,TheDen,O Covil,1,14,90,75,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
365,BurningBladeCoven,Covil da Lâmina Ardente,1,14,91,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
366,KolkarCrag,Penedo de Kolkar,1,14,92,0,11,0,2172,9,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
367,Sen'jinVillage,Aldeia Sen'jin,1,14,93,0,11,0,2172,185,0,6,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
368,EchoIsles,Ilhas do Eco,1,14,94,0,11,32,2172,3,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
369,ThunderRidge,Desfiladeiro do Trovão,1,14,95,0,11,0,2172,9,0,9,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
370,DrygulchRavine,Barranco da Ravina Seca,1,14,96,0,11,0,2172,9,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
371,DustwindCave,Caverna Sopravento,1,14,567,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
372,TiragardeKeep,Bastilha Tiragarde,1,14,97,0,11,0,2172,186,0,6,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
373,ScuttleCoast,Praia do Bota-a-pique,1,14,98,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
374,BladefistBay,Baía Carpunhal,1,14,99,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
375,DeadeyeShore,Praia do Olho Seco,1,14,100,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
377,SouthfuryRiver,Rio Furiaustral,1,0,101,0,11,0,2172,9,0,9,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
378,CampTaurajo,Acampamento Taurajo,1,17,102,0,11,0,2172,226,0,10,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
379,FarWatchPost,Posto Remoto,1,17,103,0,11,0,2172,7,0,10,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
380,TheCrossroads,A Encruzilhada,1,17,104,0,11,0,2172,228,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
381,BoulderLodeMine,Mina Veio do Pedregulho,1,17,105,0,11,0,2172,0,0,17,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
382,TheSludgeFen,Charco de Lodo,1,17,552,0,11,0,2172,3,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
383,TheDryHills,Montes Áridos,1,17,106,0,11,0,2172,0,0,14,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
384,DreadmistPeak,Morro de Brumedo,1,17,107,0,11,46,2172,10,0,11,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
385,NorthwatchHold,Fortaleza da Guardanorte,1,17,108,0,11,0,2172,3,0,15,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
386,TheForgottenPools,Os Charcos Esquecidos,1,17,109,0,11,32,2172,3,0,12,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
387,LushwaterOasis,Oásis das Águas Claras,1,17,582,0,11,32,2172,3,0,12,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
388,TheStagnantOasis,O Oásis Estagnado,1,17,110,0,11,32,2172,3,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
390,FieldofGiants,Campo dos Gigantes,1,17,111,0,11,0,2172,0,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
391,TheMerchantCoast,Costa dos Mercadores,1,17,112,0,11,32,2172,3,0,12,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
392,Ratchet,Vila Catraca,1,17,113,0,11,0,2172,3,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
393,DarkspearStrand,Praia Lançanegra,1,14,114,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
394,DarrowmereLakeUNUSED,Darrowmere Lake UNUSED,0,0,115,0,11,37,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
395,CaerDarrowUNUSED,Caer Darrow UNUSED,0,394,116,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
396,WinterhoofWaterWell,Poço Casco Invernal,1,215,117,0,11,0,2172,9,0,6,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
397,ThunderhornWaterWell,Poço Chifre Troante,1,215,118,0,11,0,2172,9,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
398,WildmaneWaterWell,Poço Juba Agreste,1,215,441,0,11,0,2172,9,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
399,SkylineRidge,Serra do Horizonte,1,215,610,0,11,0,2172,9,0,6,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
400,ThousandNeedles,Mil Agulhas,1,0,442,0,11,25,2172,9,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
401,TheTidusStair,Escadaria de Tidus,1,17,443,0,11,32,2172,3,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
403,ShadyRestInn,Estalagem Pouso do Umbral,1,15,568,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
404,Bael'dunDigsite,Sítio de Escavação de Bael'Dun,1,215,444,0,11,0,2172,9,0,8,102,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
405,Desolace,Desolação,1,0,445,0,11,39,2172,7,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
406,StonetalonMountains,Cordilheira das Torres de Pedra,1,0,446,0,11,25,2172,7,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
407,OrgrimmarUNUSED,Orgrimmar UNUSED,1,14,447,0,11,0,2172,14,0,10,62,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
408,Gillijim'sIsle,Ilha de Gillijim,0,0,448,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
409,IslandofDoctorLapidis,Ilha do Doutor Lapidis,0,0,449,0,11,32,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
410,RazorwindCanyon,Garganta do Vento Cortante,1,14,450,0,11,0,2172,9,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
411,Bathran'sHaunt,Refúgio de Bathran,1,331,451,0,11,0,2172,205,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
412,TheRuinsofOrdil'Aran,Ruínas de Ordil'Aran,1,331,625,0,11,0,2172,205,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
413,Maestra'sPost,Entreposto de Maestra,1,331,452,0,11,0,2172,0,0,19,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
414,TheZoramStrand,Praia de Zoram,1,331,453,0,11,24,2172,176,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
415,Astranaar,Astranaar,1,331,454,0,11,0,2172,11,0,20,81,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
416,TheShrineofAessina,Altar de Aessina,1,331,455,0,11,0,2172,199,0,23,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
417,FireScarShrine,Santuário Cicatriz de Fogo,1,331,456,0,11,28,2172,193,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
418,TheRuinsofStardust,Ruínas de Poeira Estelar,1,331,457,0,11,28,2172,193,0,23,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
419,TheHowlingVale,Vale Uivante,1,331,458,0,11,0,2172,204,0,28,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
420,SilverwindRefuge,Refúgio Brisaprata,1,331,459,0,11,0,2172,0,0,25,81,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
421,MystralLake,Lago Mistral,1,331,460,0,11,0,2172,0,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
422,FallenSkyLake,Lago Céu Caído,1,331,461,0,11,0,2172,0,0,26,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
424,IrisLake,Lago Íris,1,331,462,0,11,28,2172,194,0,22,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
425,Moonwell,Poço Lunar,1,331,549,0,11,0,2172,199,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
426,RaynewoodRetreat,Refúgio Bosque Real,1,331,463,0,11,0,2172,0,0,24,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
427,TheShadyNook,Gruta Escura,1,331,464,0,11,0,2172,11,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
428,Night Run,Trilha da Noite,1,331,569,0,11,0,2172,3,0,25,121,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
429,Xavian,Xavian,1,331,611,0,11,0,2172,3,0,0,121,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
430,Satyrnaar,Satyrnaar,1,331,465,0,11,0,2172,3,0,28,121,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
431,Splintertree Post,Posto Machadada,1,331,553,0,11,0,2172,228,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
432,TheDor'DanilBarrowDen,Retiro de Dor'Danil,1,331,466,0,11,0,2172,205,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
433,FalfarrenRiver,Rio Felfarren,1,331,467,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
434,FelfireHill,Monte Fogovil,1,331,570,0,11,48,2172,193,0,29,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
435,DemonFallCanyon,Cânion do Demônio Caído,1,331,468,0,11,49,2172,193,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
436,DemonFallRidge,Serra do Demônio Caído,1,331,469,0,11,49,2172,193,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
437,Warsong Lumber Camp,Acampamento de Lenhadores Brado Guerreiro,1,331,612,0,11,28,2172,228,0,22,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
438,BoughShadow,Sombrarrama,1,331,470,0,11,0,2172,188,0,20,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
439,TheShimmeringFlats,Chapada Cintilante,1,400,471,0,11,39,2172,0,0,35,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
440,Tanaris,Tanaris,1,0,472,0,11,39,2172,176,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
441,LakeFalathim,Lago Falathim,1,331,473,0,11,48,2172,0,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
442,Auberdine,Auberdine,1,148,474,0,11,0,2172,0,0,12,81,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
443,RuinsofMathystra,Ruínas de Mathistra,1,148,475,0,11,0,2172,176,0,19,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
444,TowerofAlthalaxx,Torre de Althalaxx,1,148,476,0,11,0,2172,0,0,16,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
445,CliffspringFalls,Quedas de Fontescarpa,1,148,477,0,11,0,2172,0,0,14,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
446,Bashal'Aran,Bashal'Aran,1,148,478,0,11,0,2172,0,0,11,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
447,Ameth'Aran,Ameth'Aran,1,148,479,0,11,0,2172,15,0,11,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
448,GroveoftheAncients,Bosque dos Ancientes,1,148,480,0,11,0,2172,0,0,15,302,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
449,TheMaster'sGlaive,Glaive do Mestre,1,148,481,0,11,0,2172,0,0,16,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
450,Remtravel'sExcavation,Escavação de Trilheiro,1,148,482,0,11,0,2172,0,0,19,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
452,Mist'sEdge,Beira das Névoas,1,148,483,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
453,TheLongWash,Praia da Ressaca,1,148,583,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
454,WildbendRiver,Rio Crenado,1,148,484,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
455,BlackwoodDen,Antro dos Bosqueneros,1,148,485,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
456,CliffspringRiver,Rio Fontescarpa,1,148,486,0,11,0,2172,0,0,14,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
457,TheVeiledSea,Mar Velado,1,0,571,0,11,24,2172,200,0,0,201,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
458,GoldRoad,Estrada do Ouro,1,17,487,0,11,0,2172,7,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
459,ScarletWatchPost,Posto da Vigília Escarlate,0,85,375,0,11,0,2172,0,0,10,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
460,SunRockRetreat,Retiro Rocha do Sol,1,406,488,0,11,0,2172,228,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
461,Windshear Crag,Rochedo Cortavento,1,406,489,0,11,0,2172,7,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
463,CragpoolLake,Lago do Rochedo,1,406,490,0,11,0,2172,7,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
464,MirkfallonLake,Lago Mirkfallon,1,406,491,0,11,0,2172,7,0,21,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
465,TheCharredVale,Vale Carbonizado,1,406,492,0,11,0,2172,7,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
466,ValleyoftheBloodfuries,Vale Furissangue,1,406,493,0,11,0,2172,7,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
467,StonetalonPeak,Morro das Torres de Pedra,1,406,613,0,11,29,2172,11,0,25,201,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
468,TheTalonDen,Retiro do Gadanho,1,406,494,0,11,29,2172,11,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
469,GreatwoodVale,Vale Matagrande,1,406,495,0,11,0,2172,7,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
470,ThunderBluffUNUSED,Thunder Bluff UNUSED,1,215,496,0,11,45,2172,9,0,10,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
471,BraveWindMesa,Chapada Vento Valente,1,215,497,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
472,FireStoneMesa,Chapada Rocha de Fogo,1,215,498,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
473,MantleRock,Manto de Rocha,1,215,554,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
474,HunterRiseUNUSED,Hunter Rise UNUSED,1,215,499,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
475,SpiritRiseUNUSED,Spirit RiseUNUSED,1,215,500,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
476,ElderRiseUNUSED,Elder RiseUNUSED,1,215,501,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
477,RuinsofJubuwal,Ruínas de Jubuwal,0,33,502,0,11,0,2172,3,0,43,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
478,PoolsofArlithrien,Águas de Arlithrien,1,141,503,0,11,0,2172,11,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
479,TheRustmaulDigSite,Sítio de Escavação Velhomalho,1,400,504,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
480,CampE'thok,Aldeia E'thok,1,400,505,0,11,0,2172,9,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
481,SplithoofCrag,Rochedo do Casco Fendido,1,400,572,0,11,0,2172,9,0,24,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
482,Highperch,Alcândora,1,400,506,0,11,0,2172,9,0,29,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
483,TheScreechingCanyon,Garganta Uivante,1,400,507,0,11,0,2172,9,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
484,FreewindPost,Aldeia Vento Livre,1,400,508,0,11,0,2172,226,0,26,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
485,TheGreatLift,O Grande Elevador,1,400,509,0,11,0,2172,9,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
486,GalakHold,Castelo Galath,1,400,510,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
487,RoguefeatherDen,Covil Plumerrante,1,400,511,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
488,TheWeatheredNook,Gruta Velha,1,400,512,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
489,Thalanaar,Thalanaar,1,357,513,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
490,Un'GoroCrater,Cratera Un'Goro,1,0,514,0,11,33,2172,223,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
491,RazorfenKraul,Urzal dos Tuscos,47,0,515,0,11,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,0,0,0,0,0,0
492,RavenHillCemetery,Cemitério de Monte Corvo,0,10,516,0,11,0,2172,15,0,26,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
493,Moonglade,Clareira da Lua,1,0,517,0,11,28,2172,191,0,0,201,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
495,DELETEME,DELETE ME,0,0,519,0,11,0,2172,11,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
496,BrackenwallVillage,Aldeia Muralha Verde,1,15,518,0,11,0,2172,214,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
497,SwamplightManor,Casarão do Pantanal Iluminado,1,15,520,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
498,BloodfenBurrow,Antro do Dinossangue,1,15,521,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
499,DarkmistCavern,Caverna Névoa Negra,1,15,522,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
500,MogglePoint,Cabo Moggle,1,15,623,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
501,Beezil'sWreck,Destroços de Beezil,1,15,614,0,11,0,2172,3,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
502,WitchHill,Morro das Bruxas,1,15,624,0,11,0,2172,0,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
503,SentryPoint,Pontal de Vigília,1,15,573,0,11,0,2172,191,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
504,NorthPointTower,Torre Norte,1,15,523,0,11,0,2172,191,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
505,WestPointTower,Torre Oeste,1,15,524,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
506,LostPoint,Posto Perdido,1,15,525,0,11,0,2172,191,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
507,Bluefen,Charneca Azul,1,15,526,0,11,0,2172,0,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
508,StonemaulRuins,Ruínas Pedramalho,1,15,527,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
509,TheDenofFlame,Antro das Chamas,1,15,528,0,11,0,2172,0,0,38,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
510,TheDragonmurk,Draconumbra,1,15,584,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
511,Wyrmbog,Pântano da Serpe,1,15,529,0,11,0,2172,0,0,43,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
512,Onyxia'sLairUNUSED,Onyxia's Lair UNUSED,1,15,530,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
513,TheramoreIsle,Ilha Theramore,1,15,531,0,11,43,2172,13,0,36,401,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
514,FootholdCitadel,Cidadela do Esteio,1,15,532,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
515,IroncladPrison,Prisão Encouraçado,1,15,533,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
516,DustwallowBay,Baía de Vadeoso,1,15,534,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
517,TidefuryCove,Enseada da Fúria das Marés,1,15,535,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
518,DreadmurkShore,Costa Tenebrosa,1,15,536,0,11,0,2172,0,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
536,Addle'sStead,Quinta dos Aguiar,0,10,537,0,11,0,2172,2,0,24,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
537,FirePlumeRidge,Pico Penacho de Fogo,1,490,538,0,11,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
538,LakkariTarPits,Poços de Piche Lakkari,1,490,539,0,11,0,2172,0,0,49,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
539,TerrorRun,Terroral,1,490,540,0,11,0,2172,0,0,53,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
540,TheSlitheringScar,Fenda Coleante,1,490,541,0,11,0,2172,0,0,51,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
541,Marshal'sRefuge,Refúgio do Marshal,1,490,542,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
542,FungalRock,Pedra do Limo,1,490,543,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
543,GolakkaHotSprings,Fontes Termais Golakka,1,490,544,0,11,0,2172,0,0,53,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
556,TheLoch,Loch,0,38,545,0,11,0,2172,1,0,12,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
576,Beggar'sHaunt,Refúgio dos Mendigos,0,10,546,0,11,0,2172,2,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
596,KodoGraveyard,Cemitério dos Kodos,1,405,593,0,11,0,2172,7,0,35,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
597,GhostWalkerPost,Entreposto do Espírito que Anda,1,405,594,0,11,0,2172,226,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
598,Sar'therisStrand,Praia de Sar'theris,1,405,595,0,11,31,2172,227,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
599,ThunderAxeFortress,Fortaleza Machado do Trovão,1,405,596,0,11,0,2172,193,0,30,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
600,Bolgan'sHole,Covil do Bolgan,1,405,597,0,11,0,2172,7,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
602,MannorocCoven,Ruínas de Mannoroc,1,405,599,0,11,0,2172,193,0,39,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
603,Sargeron,Sargeron,1,405,600,0,11,0,2172,76,0,31,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
604,MagramVillage,Aldeia Magram,1,405,601,0,11,0,2172,7,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
606,GelkisVillage,Aldeia Gelkis,1,405,603,0,11,0,2172,7,0,34,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
607,ValleyofSpears,Vale das Lanças,1,405,604,0,11,0,2172,7,0,37,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
608,Nijel'sPoint,Posto do Nijel,1,405,605,0,11,0,2172,206,0,30,103,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
609,KolkarVillage,Aldeia Kolkar,1,405,598,0,11,0,2172,7,0,32,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
616,Hyjal,Hyjal,1,0,619,0,11,31,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
618,Winterspring,Hibérnia,1,0,621,0,11,42,2172,8,0,0,0,0,0,0,0,-1,0,0,0,65,0,0,0,0,0
636,BlackwolfRiver,Rio Lobonegro,1,406,626,0,11,0,2172,7,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
637,KodoRock,Rocha dos Kodos,1,215,635,0,11,0,2172,9,0,0,121,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
638,HiddenPath,Caminho Oculto,1,14,636,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
639,SpiritRock,Rocha dos Espíritos,1,14,637,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
640,ShrineoftheDormantFlame,Altar da Chama Latente,1,14,638,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
656,LakeElune'ara,Lago Eluna'ara,1,493,295,0,11,0,2172,0,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
657,TheHarborage,O Refúgio,0,8,296,0,11,0,2172,0,0,37,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
676,Outland,Terralém,150,0,297,0,11,46,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
696,Craftsmen'sTerraceUNUSED,Craftsmen's Terrace UNUSED,1,141,298,0,11,48,2172,76,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
697,Tradesmen'sTerraceUNUSED,Tradesmen's Terrace UNUSED,1,141,299,0,11,48,2172,76,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
698,TheTempleGardensUNUSED,The Temple Gardens UNUSED,1,141,300,0,11,48,2172,76,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
699,TempleofEluneUNUSED,Temple of Elune UNUSED,1,141,301,0,11,48,2172,76,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
700,CenarionEnclaveUNUSED,Cenarion Enclave UNUSED,1,141,302,0,11,48,2172,76,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
701,Warrior'sTerraceUNUSED,Warrior's Terrace UNUSED,1,141,303,0,11,48,2172,76,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
702,Rut'theranVillage,Vila de Rut'theran,1,141,304,0,11,0,2172,0,0,11,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
716,Ironband'sCompound,Complexo de Bandaferro,0,1,639,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
717,TheStockade,O Cárcere,34,0,640,0,11,0,2172,0,0,0,0,0,2,0,0,-1,0,0,0,0,0,0,0,0,0
718,WailingCaverns,Caverna Ululante,43,0,641,0,11,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,0,0,0,0,0,0
719,BlackfathomDeeps,Profundezas Negras,48,0,642,75,11,0,2172,176,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
720,FrayIsland,Ilha da Peleja,1,17,643,0,11,32,2172,3,0,0,121,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
721,Gnomeregan,Gnomeregan,90,0,305,0,11,42,2172,0,0,0,0,0,2,0,0,-1,0,0,0,0,0,0,0,0,0
722,RazorfenDowns,Urzal dos Mortos,129,0,644,0,11,38,2172,0,0,0,0,0,4,0,0,-1,0,0,0,3,0,0,0,0,0
736,Ban'ethilHollow,Ravina de Ban'ethil,1,141,645,0,11,0,2172,0,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
796,ScarletMonastery,Monastério Escarlate,189,0,646,0,11,0,2172,205,0,0,0,0,4,0,0,-1,0,0,0,0,0,0,0,0,0
797,Jerod'sLanding,Ancoradouro de Jerod,0,12,647,0,11,35,2172,0,0,8,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
798,RidgepointTower,Torre Serrana,0,12,648,0,11,35,2172,0,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
799,TheDarkenedBank,Margem Escurecida,0,10,649,0,11,0,2172,2,0,10,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
800,ColdridgePass,Caminho de Cristálgida,0,1,650,0,11,0,2172,0,0,4,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
801,ChillBreezeValley,Vale Brisa Álgida,0,1,651,0,11,0,2172,0,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
802,ShimmerRidge,Cordilheira Cintilante,0,1,652,0,11,0,2172,0,0,8,121,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
803,AmberstillRanch,Rancho Ambarmanso,0,1,653,0,11,0,2172,0,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
804,TheTundridHills,Montes Túndricos,0,1,654,0,11,0,2172,0,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
805,SouthGatePass,Desfiladeiro do Portão Sul,0,1,655,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
806,SouthGateOutpost,Posto de Guarda do Portão Sul,0,1,656,0,11,0,2172,0,0,12,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
807,NorthGatePass,Desfiladeiro do Portão Norte,0,1,657,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
808,NorthGateOutpost,Posto de Guarda do Portão Norte,0,1,658,0,11,0,2172,0,0,11,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
809,GatesofIronforge,Portões de Altaforja,0,1,659,0,11,0,2172,0,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
810,StillwaterPond,Lagoa das Águas Paradas,0,85,660,0,11,0,2172,0,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
811,NightmareVale,Vale do Pesadelo,0,85,661,0,11,0,2172,0,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
812,VenomwebVale,Vale Veneracnídeo,0,85,662,0,11,0,2172,0,0,10,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
813,TheBulwark,O Baluarte,0,28,663,0,11,0,2172,0,0,52,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
814,SouthfuryRiver,Rio Furiaustral,1,14,664,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
815,SouthfuryRiver,Rio Furiaustral,1,17,665,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
816,RazormaneGrounds,Terras Crinavalha,1,14,666,0,11,0,2172,0,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
817,SkullRock,Rocha da Caveira,1,14,667,0,11,0,2172,0,0,10,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
818,PalemaneRock,Rochedo Jubalba,1,215,668,0,11,0,2172,0,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
819,WindfuryRidge,Serra Ventofúria,1,215,669,0,11,0,2172,0,0,9,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
820,TheGoldenPlains,Planícies Douradas,1,215,670,0,11,0,2172,0,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
821,TheRollingPlains,Morros Ondulantes,1,215,671,0,11,0,2172,0,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
836,DunAlgaz,Dun Algaz,0,11,672,0,11,0,2172,0,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
837,DunAlgaz,Dun Algaz,0,38,673,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
838,NorthGatePass,Desfiladeiro do Portão Norte,0,38,306,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
839,SouthGatePass,Desfiladeiro do Portão Sul,0,38,307,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
856,TwilightGrove,Bosque do Crepúsculo,0,10,674,0,11,0,2172,2,0,19,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
876,GMIsland,Ilha dos MJs,1,0,675,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
877,Delete ME,Delete ME,1,17,676,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
878,SouthfuryRiver,Rio Furiaustral,1,16,677,0,11,0,2172,8,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
879,SouthfuryRiver,Rio Furiaustral,1,331,678,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
880,ThandolSpan,Ponte Thandol,0,45,679,0,11,0,2172,0,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
881,ThandolSpan,Ponte Thandol,0,11,680,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
896,PurgationIsle,Ilha da Purgação,0,267,308,0,11,40,2172,193,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
916,TheJansenStead,Sítio dos Jansen,0,40,681,0,11,0,2172,0,0,9,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
917,TheDeadAcre,O Alqueire Morto,0,40,682,0,11,0,2172,0,0,18,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
918,TheMolsenFarm,Fazenda dos Peçanha,0,40,683,0,11,0,2172,0,0,14,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
919,Stendel'sPond,Lago Stendel,0,40,684,0,11,0,2172,0,0,14,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
920,TheDaggerHills,Os Obeliscos,0,40,309,0,11,0,2172,0,0,17,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
921,Demont'sPlace,Recanto de Demont,0,40,310,0,11,0,2172,0,0,16,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
922,TheDustPlains,Planícies do Pó,0,40,311,0,11,0,2172,0,0,18,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
923,StonesplinterValley,Vale Lascapedra,0,38,312,0,11,0,2172,0,0,13,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
924,ValleyofKings,Vale dos Reis,0,38,313,0,11,0,2172,0,0,11,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
925,AlgazStation,Estação Algaz,0,38,314,0,11,0,2172,0,0,12,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
926,BucklebreeFarm,Fazenda dos Bucklebree,0,130,315,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
927,TheShiningStrand,Margem Brilhante,0,130,316,0,11,0,2172,0,0,14,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
928,NorthTide'sHollow,Atracadouro da Maré do Norte,0,130,317,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
936,GrizzlepawRidge,Serra Garracinza,0,38,318,0,11,0,2172,0,0,12,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
956,TheVerdantFields,Campos Verdejantes,169,0,319,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
976,Gadgetzan,Geringontzan,1,440,320,0,0,0,2172,0,0,40,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
977,SteamwheedlePort,Porto de Bondebico,1,440,390,0,0,0,2172,3,0,40,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
978,Zul'Farrak,Zul'Farrak,1,440,321,0,0,25,2172,176,0,45,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
979,SandsorrowWatch,Posto Silitriste,1,440,322,0,0,0,2172,0,0,44,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
980,ThistleshrubValley,Vale Moitagulhas,1,440,323,0,0,0,2172,0,0,49,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
981,TheGapingChasm,Fenda Hazzali,1,440,324,0,0,0,2172,0,0,48,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
982,TheNoxiousLair,Covil Nóxio,1,440,325,0,0,0,2172,0,0,48,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
983,DunemaulCompound,Complexo Dunamalho,1,440,326,0,0,0,2172,0,0,47,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
984,EastmoonRuins,Ruínas de Lunaleste,1,440,327,0,0,0,2172,0,0,47,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
985,WaterspringField,Campo das Minas d'Água,1,440,328,0,0,0,2172,0,0,44,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
986,Zalashji'sDen,Covil de Zalashji,1,440,329,0,0,0,2172,0,0,45,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
987,Land'sEndBeach,Praia do Fim do Mundo,1,440,330,0,0,0,2172,0,0,48,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
988,WavestriderBeach,Praia das Sete Ondas,1,440,331,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
989,Uldum,Uldum,1,440,332,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
990,ValleyoftheWatchers,Vale dos Vigilantes,1,440,333,0,0,0,2172,0,0,50,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
991,Gunstan'sPost,Posto de Gunstan,1,440,334,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
992,SouthmoonRuins,Ruínas de Lunassul,1,440,335,0,0,0,2172,0,0,47,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
996,Render'sCamp,Acampamento dos Laceradores,0,44,408,0,0,0,2172,0,0,22,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
997,Render'sValley,Vale dos Laceradores,0,44,409,0,0,0,2172,0,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
998,Render'sRock,Rocha dos Laceradores,0,44,410,0,0,0,2172,0,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
999,StonewatchTower,Torre Mirante de Pedra,0,44,411,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1000,GalardellValley,Vale Galardell,0,44,412,0,0,0,2172,0,0,22,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1001,LakeridgeHighway,Estrada Beira-lago,0,44,336,0,0,0,2172,0,0,16,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1002,ThreeCorners,Três Caminhos,0,44,337,0,0,0,2172,0,0,16,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1016,DireforgeHill,Monte Umbraforja,0,11,338,0,0,0,2172,0,0,28,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1017,RaptorRidge,Serra dos Raptores,0,11,339,0,0,0,2172,0,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1018,BlackChannelMarsh,Pântano do Canal Negro,0,11,340,0,0,0,2172,0,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1019,TheGreenBelt,Zona Verde,0,139,341,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1020,MosshideFen,Charco Pelemusgo,0,11,342,0,0,0,2172,0,0,22,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1021,ThelgenRock,Rocha de Thelgen,0,11,343,0,0,0,2172,0,0,22,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1022,BluegillMarsh,Pântano Peixeazul,0,11,344,0,0,0,2172,0,0,24,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1023,SaltsprayGlen,Vale Espuma de Sal,0,11,345,0,0,0,2172,0,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1024,SundownMarsh,Pântano do Ocaso,0,11,346,0,0,0,2172,0,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1025,TheGreenBelt,Zona Verde,0,11,347,0,0,0,2172,0,0,21,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1036,AngerfangEncampment,Acampamento Presirada,0,11,391,0,0,0,2172,0,0,28,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1037,GrimBatol,Grim Batol,0,11,392,0,0,0,2172,0,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1038,DragonmawGates,Portões Presa do Dragão,0,11,393,0,0,0,2172,0,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1039,TheLostFleet,Frota Perdida,0,11,394,0,0,0,2172,0,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1056,DarrowHill,Monte das Flechas,0,267,348,0,0,0,2172,0,0,31,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1057,Thoradin'sWall,Muralha de Thoradin,0,267,349,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1076,WebwinderPath,Passagem Tramateia,1,406,368,0,0,0,2172,0,0,21,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1097,TheHushedBank,Margem Silenciada,0,10,351,0,0,0,2172,0,0,19,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1098,ManorMistmantle,Casarão dos Brumanto,0,10,352,0,0,0,2172,0,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1099,CampMojache,Aldeia Mojache,1,357,353,0,0,0,2172,226,0,42,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1100,GrimtotemCompound,Complexo do Temível Totem,1,357,395,0,0,0,2172,0,0,41,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1101,TheWrithingDeep,Profundeza Atormentada,1,357,396,0,0,0,2172,0,0,44,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1102,WildwindLake,Lago Vento Selvagem,1,357,350,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1103,GordunniOutpost,Assentamento Gordunni,1,357,397,0,0,0,2172,0,0,42,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1104,Mok'Gordun,Mok'Gordun,1,357,398,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1105,FeralScarVale,Vale dos Abomináveis,1,357,354,0,0,0,2172,0,0,44,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1106,FrayfeatherHighlands,Planalto Esfiapluma,1,357,399,0,0,0,2172,0,0,46,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1107,IdlewindLake,Lago Soprocioso,1,357,400,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1108,TheForgottenCoast,Costa Esquecida,1,357,355,0,0,0,2172,0,0,49,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1109,EastPillar,Pilar Leste,1,357,401,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1110,WestPillar,Pilar Oeste,1,357,402,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1111,DreamBough,Ramo de Morfeu,1,357,403,0,0,0,2172,0,0,60,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1112,JademirLake,Lago Jademir,1,357,404,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1113,Oneiros,Oneiros,1,357,405,0,0,0,2172,0,0,60,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1114,RuinsofRavenwind,Ruínas dos Ventos Corvejantes,1,357,356,0,0,0,2172,0,0,49,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1115,RageScarHold,Bastilha Cortifúria,1,357,357,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1116,FeathermoonStronghold,Domínio de Plumaluna,1,357,358,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1117,RuinsofSolarsal,Ruínas de Solarsal,1,357,359,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1118,LowerWilds UNUSED,Lower Wilds UNUSED,1,357,360,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1119,TheTwinColossals,Colossos Gêmeos,1,357,369,0,0,0,2172,0,0,48,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1120,SardorIsle,Ilha de Sardor,1,357,413,0,0,0,2172,0,0,43,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1121,IsleofDread,Ilha do Medo,1,357,414,0,0,0,2172,0,0,44,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1136,HighWilderness,Selva Alta,1,357,361,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1137,LowerWilds,Baixio Selvagem,1,357,370,0,0,0,2172,0,0,42,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1156,SouthernBarrens,Sertões Meridionais,1,17,362,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1157,SouthernGoldRoad,Estrada do Ouro Sul,1,17,406,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1176,Zul'Farrak,Zul'Farrak,209,0,371,0,0,25,2172,176,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
1196,UNUSEDAlcazIsland,UNUSEDAlcaz Island,1,0,363,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
1216,TimbermawHold,Domínio dos Presamatos,1,16,364,0,0,0,2172,0,0,49,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1217,VanndirEncampment,Acampamento Vanndir,1,16,365,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1218,TESTAzshara,TESTAzshara,1,16,366,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1219,LegashEncampment,Assentamento Legash,1,16,367,0,0,0,2172,0,0,52,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1220,ThalassianBaseCamp,Base Darnassiana,1,16,415,0,0,0,2172,76,0,52,302,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1221,RuinsofEldarath,Ruínas de Eldarath,1,16,416,0,0,0,2172,176,0,48,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1222,Hetaera'sClutch,Ninho de Hetaera,1,16,417,0,0,0,2172,176,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1223,TempleofZin-Malor,Templo de Zin-Malor,1,16,418,0,0,0,2172,15,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1224,Bear'sHead,Campo dos Ursos,1,16,419,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1225,Ursolan,Ursolan,1,16,420,0,0,0,2172,0,0,49,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1226,TempleofArkkoran,Templo de Arkkoran,1,16,421,0,0,0,2172,176,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1227,BayofStorms,Baía das Tempestades,1,16,422,0,0,0,2172,176,0,50,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1228,TheShatteredStrand,Areal Despedaçado,1,16,423,0,0,0,2172,176,0,52,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1229,TowerofEldara,Torre de Eldara,1,16,424,0,0,0,2172,176,0,53,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1230,JaggedReef,Costa Rasgada,1,16,425,0,0,0,2172,176,0,51,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1231,SouthridgeBeach,Praia do Recife Sul,1,16,426,0,0,0,2172,176,0,52,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1232,RavencrestMonument,Monumento a Cristacorvo,1,16,427,0,0,0,2172,176,0,54,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1233,ForlornRidge,Cordilheira Esquecida,1,16,428,0,0,0,2172,215,0,49,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1234,LakeMennar,Lago Mennar,1,16,429,0,0,0,2172,0,0,52,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1235,ShadowsongShrine,Ermida Cantonegro,1,16,430,0,0,0,2172,15,0,46,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1236,HaldarrEncampment,Assentamento Haldarr,1,16,431,0,0,0,2172,3,0,45,121,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1237,Valormok,Valormok,1,16,432,0,0,0,2172,228,0,49,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1256,TheRuinedReaches,Profundezas Devastadas,1,16,433,0,0,0,2172,176,0,42,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1276,TheTalondeepPath,Túnel Garracava,1,331,434,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1277,TheTalondeepPath,Túnel Garracava,1,406,435,0,0,0,2172,0,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1296,RocktuskFarm,Fazenda Petradente,1,14,372,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1297,JaggedswineFarm,Fazenda do Beberrão,1,14,407,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1316,RazorfenDowns,Urzal dos Mortos,1,17,436,0,0,70,2172,176,0,33,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1336,LostRiggerCove,Enseada do Armador Perdido,1,440,373,0,0,0,2172,0,0,45,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1337,Uldaman,Uldaman,70,0,437,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
1338,LordamereLake,Espelho de Lordaeron,0,130,438,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1339,LordamereLake,Espelho de Lordaeron,0,36,439,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1357,Gallows'Corner,Canto da Forca,0,36,440,0,0,37,2172,10,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1377,Silithus,Silithus,1,0,374,0,0,38,2172,176,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
1397,EmeraldForest,Floresta Esmeralda,169,0,376,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
1417,SunkenTemple,Templo Submerso,109,0,377,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
1437,DreadmaulHold,Domínio de Malhorrendo,0,4,378,0,0,0,2172,0,0,47,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1438,NethergardeKeep,Bastilha de Etergarde,0,4,379,0,0,0,2172,205,0,50,303,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1439,DreadmaulPost,Posto Malhorrendo,0,4,380,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1440,Serpent'sCoil,Cavernas Serpeantes,0,4,381,0,0,0,2172,0,0,51,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1441,AltarofStorms,Altar das Tempestades,0,4,382,0,0,0,2172,10,0,54,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1442,FirewatchRidge,Cerro da Sentinela de Fogo,0,51,383,0,0,0,2172,0,0,48,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1443,TheSlagPit,Fosso de Lava,0,51,384,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1444,TheSeaofCinders,Mar de Cinzas,0,51,385,0,0,0,2172,0,0,56,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1445,BlackrockMountain,Montanha Rocha Negra,0,51,386,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1446,ThoriumPoint,Posto de Tório,0,51,387,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1457,GarrisonArmory,Armaria da Guarnição,0,4,388,0,0,0,2172,0,0,47,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1477,TheTempleOfAtal'Hakkar,Templo de Atal'Hakkar,0,0,389,0,0,33,2172,3,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
1497,Undercity,Cidade Baixa,0,0,685,0,0,40,2172,0,0,10,0,0,4,0,0,-1,0,0,0,312,0,0,0,0,0
1517,Uldaman,Uldaman,0,3,686,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1518,NotIUsedDeadmines,Not Used Deadmines,0,40,687,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1519,StormwindCity,Ventobravo,0,0,688,0,0,31,2172,13,0,10,61,0,2,0,0,-1,0,0,0,312,0,0,0,0,0
1537,Ironforge,Altaforja,0,0,689,0,0,42,2172,0,0,10,0,0,2,0,0,-1,0,0,0,312,0,0,0,0,0
1557,SplithoofHold,Castelo do Casco Fendido,1,400,690,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1577,TheCapeofStranglethorn,Cabo do Espinhaço,0,33,691,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1578,SouthernSavageCoast,Costa Selvagem Sul,0,33,692,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1579,UnusedTheDeadmines002,Unused The Deadmines 002,0,0,693,0,0,0,2172,0,0,0,0,0,2,0,0,-1,0,0,0,64,0,0,0,0,0
1580,UnusedIroncladCove003,Unused Ironclad Cove 003,36,1579,694,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1581,TheDeadmines,Minas Mortas,36,0,695,76,0,53,2172,204,0,0,0,0,2,0,0,-1,0,0,0,0,0,0,0,0,0
1582,IroncladCove,Covil Encouraçado,36,1581,696,76,0,53,2172,204,0,0,181,0,2,0,0,-1,0,0,0,1073741824,0,0,0,0,0
1583,BlackrockSpire,Pico da Rocha Negra,0,0,697,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
1584,BlackrockDepths,Abismo Rocha Negra,0,0,698,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
1597,RaptorGroundsUNUSED,Raptor Grounds UNUSED,1,17,699,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1598,Grol'domFarmUNUSED,Grol'dom Farm UNUSED,1,17,700,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1599,Mor'shanBaseCamp,Campo-base Mor'shan,1,17,701,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1600,Honor'sStandUNUSED,Honor's Stand UNUSED,1,17,702,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1601,BlackthornRidgeUNUSED,Blackthorn Ridge UNUSED,1,17,703,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1602,BramblescarUNUSED,Bramblescar UNUSED,1,17,704,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1603,Agama'gorUNUSED,Agama'gor UNUSED,1,17,705,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1617,ValleyofHeroes,Vale dos Heróis,0,1519,706,0,0,43,2172,13,0,0,0,0,2,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1637,Orgrimmar,Orgrimmar,1,0,707,0,0,25,2172,7,0,10,62,0,4,0,0,-1,0,0,0,312,0,0,0,0,0
1638,ThunderBluff,Penhasco do Trovão,1,0,708,0,0,45,2172,226,0,10,381,0,4,0,0,-1,0,0,0,312,0,0,0,0,0
1639,ElderRise,Platô dos Anciãos,1,1638,709,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1640,SpiritRise,Platô dos Espíritos,1,1638,710,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1641,HunterRise,Platô dos Caçadores,1,1638,711,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1657,Darnassus,Darnassus,1,0,712,0,0,48,2172,76,0,10,63,0,2,0,0,-1,0,0,0,312,0,0,0,0,0
1658,CenarionEnclave,Enclave Cenariano,1,1657,713,0,0,0,2172,0,0,0,103,0,2,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1659,Craftsmen'sTerrace,Terraço dos Artesãos,1,1657,714,0,0,0,2172,0,0,0,0,0,2,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1660,Warrior'sTerrace,Terraço dos Guerreiros,1,1657,715,0,0,0,2172,0,0,0,0,0,2,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1661,TheTempleGardens,Jardins do Templo,1,1657,716,0,0,0,2172,0,0,0,0,0,2,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1662,Tradesmen'sTerrace,Terraço dos Mercadores,1,1657,717,0,0,0,2172,0,0,0,0,0,2,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1677,Gavin'sNaze,Promontório de Gavin,0,36,718,0,0,0,2172,0,0,33,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1678,Sofera'sNaze,Promontório de Sofera,0,36,719,0,0,0,2172,0,0,33,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1679,Corrahn'sDagger,Adaga de Corrahn,0,36,720,0,0,0,2172,0,0,33,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1680,TheHeadland,Terralta,0,36,721,0,0,0,2172,0,0,34,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1681,MistyShore,Costa da Bruma,0,36,722,0,0,0,2172,0,0,31,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1682,Dandred'sFold,Nicho de Dandred,0,36,723,0,0,0,2172,0,0,39,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1683,GrowlessCave,Caverna Rugido,0,36,724,0,0,37,2172,10,0,34,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1684,ChillwindPoint,Morro do Ventogelante,0,36,725,0,0,0,2172,0,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1697,RaptorGrounds,Terra dos Raptores,1,17,726,0,0,0,2172,0,0,18,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1698,Bramblescar,Espinheira,1,17,727,0,0,0,2172,0,0,20,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1699,ThornHill,Morro dos Espinhos,1,17,728,0,0,0,2172,0,0,13,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1700,Agama'gor,Agama'gor,1,17,729,0,0,0,2172,0,0,19,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1701,BlackthornRidge,Serra de Abrunhal,1,17,730,0,0,0,2172,0,0,20,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1702,Honor'sStand,Posto da Honra,1,17,731,0,0,0,2172,0,0,18,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1703,TheMor'shanRampart,Paliçada Mor'shan,1,17,732,0,0,0,2172,0,0,17,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1704,Grol'domFarm,Fazenda Grol'dom,1,17,733,0,0,0,2172,0,0,11,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1717,RazorfenKraul,Urzal dos Tuscos,1,17,734,0,0,0,2172,0,0,24,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1718,TheGreatLift,O Grande Elevador,1,17,735,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1737,MistvaleValley,Vale da Névoa,0,33,736,0,0,0,2172,0,0,40,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1738,Nek'maniWellspring,Olho-d'água Nek'mani,0,33,737,0,0,0,2172,0,0,43,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1739,BloodsailCompound,Complexo da Vela Sangrenta,0,33,738,0,0,0,2172,0,0,42,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1740,VentureCo.BaseCamp,Base da Empreendimentos S.A.,0,33,739,0,0,0,2172,0,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1741,GurubashiArena,Arena de Gurubashi,0,33,740,0,0,0,2172,0,0,43,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1742,SpiritDen,Covil dos Espíritos,0,33,741,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1757,TheCrimsonVeil,Véu Carmesim,0,33,742,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1758,TheRiptide,O Rasgamar,0,33,743,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1759,TheDamsel'sLuck,O Sorte da Donzela,0,33,744,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1760,VentureCo.OperationsCenter,Centro de Operações da Empreendimentos S.A.,0,33,745,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1761,DeadwoodVillage,Vila da Lenha Morta,1,361,746,0,0,0,2172,194,0,47,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1762,FelpawVillage,Aldeia Patavil,1,361,747,0,0,0,2172,194,0,54,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1763,Jaedenar,Jaedenar,1,361,748,0,0,0,2172,193,0,51,161,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1764,BloodvenomRiver,Rio Peçonha,1,361,749,0,0,0,2172,193,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1765,BloodvenomFalls,Salto da Peçonha,1,361,750,0,0,0,2172,193,0,52,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1766,ShatterScarVale,Vale das Escaras Pungentes,1,361,751,0,0,0,2172,0,0,53,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1767,IrontreeWoods,Floresta Ferrárbol,1,361,752,0,0,0,2172,0,0,53,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1768,IrontreeCavern,Caverna Ferrárbol,1,361,753,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1769,TimbermawHold,Domínio dos Presamatos,1,361,754,0,0,0,2172,0,0,54,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1770,ShadowHold,Fortaleza do Concílio das Sombras,1,361,755,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1771,ShrineoftheDeceiver,Santuário do Embusteiro,1,361,756,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1777,Itharius'sCave,Caverna de Itharius,0,8,757,0,0,0,2172,0,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1778,Sorrowmurk,Penumbra das Mágoas,0,8,758,0,0,0,2172,0,0,41,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1779,Draenil'durVillage,Vila Draenil'dur,0,8,759,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1780,SplinterspearJunction,Entroncamento da Lança Lascada,0,8,760,0,0,0,2172,0,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1797,Stagalbog,Pantanal dos Cervos,0,8,761,0,0,0,2172,0,0,41,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1798,TheShiftingMire,Lodaçal Mutante,0,8,762,0,0,0,2172,0,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1817,StagalbogCave,Caverna Pantanal dos Cervos,0,8,763,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1837,WitherbarkCaverns,Caverna Cascasseca,0,45,764,0,0,0,2172,3,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1857,Thoradin'sWall,Muralha de Thoradin,0,45,765,0,0,0,2172,0,0,32,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1858,Boulder'gor,Pedre'gor,0,45,766,0,0,0,2172,0,0,32,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1877,ValleyofFangs,Vale das Presas,0,3,767,0,0,0,2172,0,0,42,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1878,TehDustbowl,Terrasseca,0,3,768,0,0,0,2172,0,0,39,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1879,MirageFlats,Chapada da Ilusão,0,3,769,0,0,0,2172,0,0,40,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1880,Featherbeard'sHovel,Casa de Barbapena,0,47,770,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1881,Shindigger'sCamp,Alambique do Borracho,0,47,771,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1882,PlaguemistRavine,Trilha da Névoa Pestilenta,0,47,772,0,0,0,2172,0,0,45,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1883,ValorwindLake,Lago Valovento,0,47,773,0,0,0,2172,0,0,48,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1884,Agol'watha,Agol'watha,0,47,774,0,0,0,2172,0,0,46,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1885,Hiri'watha,Hiri'watha,0,47,775,0,0,0,2172,0,0,42,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1886,TheCreepingRuin,Ruína Assustadora,0,47,776,0,0,0,2172,0,0,47,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1887,Bogen'sLedge,Covil do Bogen,0,47,777,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1897,TheMaker'sTerrace,Terraço do Criador,0,3,778,0,0,0,2172,0,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1898,DustwindGulch,Ravina de Sopravento,0,3,779,0,0,0,2172,0,0,39,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1917,Shaol'watha,Shaol'watha,0,47,780,0,0,0,2172,0,0,49,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1937,NoonshadeRuins,Ruínas da Sombrassolar,1,440,781,0,0,0,2172,0,0,42,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1938,BrokenPillar,Pilar Partido,1,440,782,0,0,0,2172,0,0,45,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1939,AbyssalSands,Areias Abissais,1,440,783,0,0,0,2172,0,0,45,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1940,SouthbreakShore,Costa Quebra-sul,1,440,784,0,0,0,2172,0,0,49,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1941,CavernsofTime,Cavernas do Tempo,1,0,785,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
1942,TheMarshlands,Os Pântanos,1,490,786,0,0,0,2172,0,0,48,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1943,IronstonePlateau,Platô Petraferro,1,490,787,0,0,0,2172,0,0,50,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1957,BlackcharCave,Caverna Calcinar,0,51,788,0,0,0,2172,0,0,47,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1958,TannerCamp,Acampamento Curtume,0,51,789,0,0,0,2172,0,0,43,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1959,DustfireValley,Vale Calcinado,0,51,790,0,0,0,2172,0,0,45,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1977,ZulGurub,Zul'Gurub,309,0,791,0,11,32,2172,3,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
1978,MistyReedPost,Posto Brumalga,0,8,792,0,0,0,2172,0,0,41,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1997,BloodvenomPost,Posto Peçonha,1,361,793,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1998,TalonbranchGlade,Clareira da Galhaça,1,361,794,0,0,0,2172,0,0,53,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2017,Stratholme,Stratholme,329,0,795,0,0,37,2172,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
2037,UNUSEDShadowfangKeep003,UNUSEDShadowfang Keep 003,0,0,796,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
2057,Scholomance,Scolomântia,289,0,797,0,0,37,2172,15,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
2077,TwilightVale,Vale do Crepúsculo,1,148,798,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2078,TwilightShore,Costa do Crepúsculo,1,148,799,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2079,AlcazIsland,Ilha Alcaz,1,15,800,0,0,32,2172,3,0,61,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2097,DarkcloudPinnacle,Pináculo da Nuvem Negra,1,400,801,0,0,0,2172,226,0,26,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2098,DawningWoodCatacombs,Catacumbas do Bosque da Aurora,0,10,802,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2099,StonewatchKeep,Bastilha Mirante de Pedra,0,44,803,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2100,Maraudon,Maraudon,349,0,804,0,0,0,2172,7,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
2101,StoutlagerInn,Estalagem Pilsen,0,38,805,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2102,ThunderbrewDistillery,Destilaria Cervaforte,0,1,806,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2103,MenethilKeep,Bastilha Menethil,0,11,807,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2104,DeepwaterTavern,Taberna Aguafunda,0,11,808,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2117,ShadowGrave,Sepulcro Sombrio,0,85,809,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2118,BrillTownHall,Prefeitura de Montalvo,0,85,810,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2119,Gallows'EndTavern,Taberna Finda Forca,0,85,811,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2137,ThePoolsofVisionUNUSED,The Pools of VisionUNUSED,1,215,812,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2138,DreadmistDen,Covil de Brumedo,1,17,813,0,0,0,2172,10,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2157,Bael'dunKeep,Bastilha Bael'Dun,1,17,814,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2158,Emberstrife'sDen,Covil de Ardeluta,1,15,815,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2159,OnyxiasLair,Covil da Onyxia,1,0,816,0,0,33,2172,237,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
2160,WindshearMine,Mina Cortavento,1,406,817,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2161,Roland'sDoom,O Descanso de Rolando,0,10,818,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2177,BattleRing,Ringue de Batalha,0,33,819,0,0,0,2172,0,0,0,325,0,0,0,0,-1,0,0,0,1073742032,0,0,0,0,0
2197,ThePoolsofVision,Poços das Visões,1,1638,820,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2198,ShadowbreakRavine,Ravina da Sombra Partida,1,405,821,0,0,0,2172,237,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2217,BrokenSpearVillage,Vila da Lança Partida,1,405,822,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2237,WhitereachPost,Posto Confinalvo,1,400,823,0,0,0,2172,0,0,28,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2238,Gornia,Górnia,1,400,824,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2239,Zane'sEyeCrater,Cratera Olho do Zane,1,400,825,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2240,MirageRaceway,Circuito da Ilusão,1,400,826,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2241,FrostsaberRock,Pedra Sabre-de-gelo,1,618,827,0,0,0,2172,0,0,57,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2242,TheHiddenGrove,Bosque Oculto,1,618,828,0,0,0,2172,0,0,58,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2243,TimbermawPost,Posto Presamatos,1,618,829,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2244,WinterfallVillage,Aldeia dos Invernosos,1,618,830,0,0,0,2172,0,0,57,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2245,Mazthoril,Mazthoril,1,618,831,0,0,0,2172,223,0,56,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2246,FrostfireHotSprings,Fontes Termais de Fogofrio,1,618,832,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2247,IceThistleHills,Serra Cardo de Gelo,1,618,833,0,0,0,2172,0,0,56,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2248,DunMandarr,Dun Mandarr,1,618,834,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2249,FrostwhisperGorge,Garganta dos Sussurros Gelados,1,618,835,0,0,0,2172,0,0,60,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2250,OwlWingThicket,Matagal da Asa da Coruja,1,618,836,0,0,0,2172,0,0,56,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2251,LakeKel'Theril,Lago Kel'Theril,1,618,837,0,0,0,2172,0,0,56,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2252,TheRuinsofKel'Theril,Ruínas de Kel'Theril,1,618,838,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2253,StarfallVillage,Aldeia Chuva Estelar,1,618,839,0,0,0,2172,76,0,55,103,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2254,Ban'ThallowBarrowDen,Gruta de Ban'Thallow,1,618,840,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2255,Everlook,Visteterna,1,618,841,0,0,0,2172,235,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2256,DarkwhisperGorge,Garganta do Sussurro Sombrio,1,618,842,0,0,37,2172,205,0,60,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2257,DeeprunTram,Metrô Correfundo,369,0,843,0,0,0,2172,0,0,0,0,0,2,0,0,-1,0,0,0,0,0,0,0,0,0
2258,TheFungalVale,Vale Fungi,0,139,844,0,0,0,2172,0,0,58,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2259,UNUSEDTheMarrisStead,UNUSEDThe Marris Stead,0,139,845,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2260,TheMarrisStead,Sítio dos Marris,0,139,846,0,0,0,2172,0,0,54,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2261,TheUndercroft,Chácara Secreta,0,139,847,0,0,0,2172,0,0,54,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2262,Darrowshire,Vila das Flechas,0,139,848,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2263,CrownGuardTower,Torre da Coroa,0,139,849,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2264,Corin'sCrossing,Cruzamento de Corin,0,139,850,0,0,0,2172,0,0,57,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2265,ScarletBaseCamp,Base de Operações Escarlate,0,139,851,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2266,Tyr'sHand,Manopla de Tyr,0,139,852,0,0,0,2172,193,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2267,TheScarletBasilica,Basílica Escarlate,0,139,853,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2268,Light'sHopeChapel,Capela Esperança da Luz,0,139,854,0,0,0,2172,0,0,58,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2269,BrowmanMill,Engenho Assombrado,0,139,855,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2270,TheNoxiousGlade,Clareira Nociva,0,139,856,0,0,0,2172,0,0,58,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2271,EastwallTower,Torre da Muralha Leste,0,139,857,0,0,0,2172,0,0,56,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2272,Northdale,Vilarejo do Norte,0,139,858,0,0,0,2172,0,0,58,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2273,Zul'Mashar,Zul'Mashar,0,139,859,0,0,0,2172,227,0,57,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2274,Mazra'Alor,Mazra'Alor,0,139,860,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2275,NorthpassTower,Torre do Passo Norte,0,139,861,0,0,0,2172,0,0,56,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2276,Quel'LithienLodge,Abrigo Quel'Lithien,0,139,862,0,0,0,2172,76,0,59,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2277,Plaguewood,Bosque Pestilento,0,139,863,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2278,Scourgehold,Fortaleza do Flagelo,0,139,864,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2279,Stratholme,Stratholme,0,139,865,0,0,37,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2280,UNUSEDStratholme,UNUSED Stratholme,0,0,866,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
2297,DarrowmereLake,Lago das Flechas,0,28,867,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2298,CaerDarrow,Castro das Flechas,0,28,868,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2299,DarrowmereLake,Lago das Flechas,0,139,869,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2300,CavernsofTime,Cavernas do Tempo,1,440,870,0,0,0,2172,0,0,50,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2301,ThistlefurVillage,Aldeia dos Pelocardo,1,331,871,0,0,28,2172,194,0,23,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2302,TheQuagmire,O Atoleiro,1,15,872,0,0,0,2172,0,0,39,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2303,WindbreakCanyon,Garganta do Quebravento,1,400,873,0,0,0,2172,0,0,27,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2317,SouthSeas,Mares do Sul,1,440,874,0,0,24,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2318,TheGreatSea,O Grande Oceano,1,15,875,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2319,TheGreatSea,O Grande Oceano,1,17,876,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2320,TheGreatSea,O Grande Oceano,1,14,877,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2321,TheGreatSea,O Grande Oceano,1,16,878,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2322,TheVeiledSea,Mar Velado,1,141,879,0,0,0,2172,0,0,0,0,0,2,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2323,TheVeiledSea,Mar Velado,1,357,880,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2324,TheVeiledSea,Mar Velado,1,405,881,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2325,TheVeiledSea,Mar Velado,1,331,882,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2326,TheVeiledSea,Mar Velado,1,148,883,0,0,0,2172,0,0,0,0,0,2,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2337,RazorHillBarracks,Guarnição do Monte Navalha,1,14,884,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2338,SouthSeas,Mares do Sul,0,33,885,0,0,24,2172,0,0,0,122,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2339,TheGreatSea,O Grande Oceano,0,33,886,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2357,BloodtoothCamp,Aldeia Dente Sangrento,1,331,887,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2358,ForestSong,Cantilenda,1,331,888,0,0,0,2172,188,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2359,Greenpaw Village,Aldeia Pataverde,1,331,889,0,0,0,2172,0,0,24,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2360,SilverwingOutpost,Posto Avançado Asa de Prata,1,331,890,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2361,Nighthaven,Refúgio Noturno,1,493,891,0,0,0,2172,0,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2362,ShrineofRemulos,Santuário de Remulos,1,493,892,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2363,StormrageBarrowDens,Templos de Tempesfúria,1,493,893,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2364,TheGreatSea,O Grande Oceano,0,40,894,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2365,TheGreatSea,O Grande Oceano,0,11,895,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2366,TheBlackMorass,Lamaçal Negro,269,0,896,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
2367,OldHillsbrad Foothills,Antigo Contraforte de Eira dos Montes,269,0,897,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
2368,TarrenMill,Serraria Tarren,269,2367,898,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2369,Southshore,Costa Sul,269,2367,899,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2370,DurnholdeKeep,Forte do Desterro,269,2367,900,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2371,DunGarok,Dun Garok,269,2367,901,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2372,Hillsbrad Fields,Campos de Eira dos Montes,269,2367,902,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2373,EasternStrand,Praia Oriental,269,2367,903,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2374,NethanderStead,Sítio de Nethander,269,2367,904,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2375,DarrowHill,Monte das Flechas,269,2367,905,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2376,SouthpointTower,Torre do Sul,269,2367,906,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2377,Thoradin'sWall,Muralha de Thoradin,269,2367,907,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2378,WesternStrand,Praia Ocidental,269,2367,908,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2379,AzurelodeMine,Mina Veioazul,269,2367,909,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2397,TheGreatSea,O Grande Oceano,0,267,910,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2398,TheGreatSea,O Grande Oceano,0,130,911,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2399,TheGreatSea,O Grande Oceano,0,85,912,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2400,TheForbiddingSea,O Mar Proibido,0,47,913,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2401,TheForbiddingSea,O Mar Proibido,0,45,914,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2402,TheForbiddingSea,O Mar Proibido,0,11,915,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2403,TheForbiddingSea,O Mar Proibido,0,8,916,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2404,TethrisAran,Tethris Aran,1,405,917,0,0,0,2172,0,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2405,EthelRethor,Ethel Rethor,1,405,918,0,0,0,2172,227,0,32,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2406,RanazjarIsle,Ilha Ranazjar,1,405,919,0,0,0,2172,0,0,35,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2407,Kormek'sHut,Barraco do Kormek,1,405,920,0,0,0,2172,0,0,32,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2408,ShadowpreyVillage,Aldeia Pescassombra,1,405,921,0,0,0,2172,185,0,33,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2417,BlackrockPass,Estreito Rocha Negra,0,46,922,0,0,0,2172,0,0,54,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2418,Morgan'sVigil,Vigia de Morgan,0,46,923,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2419,SlitherRock,Rocha Coleante,0,46,924,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2420,TerrorWingPath,Vale Asa do Terror,0,46,925,0,0,0,2172,0,0,52,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2421,Draco'dar,Draco'dar,0,46,926,0,0,0,2172,0,0,54,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2437,Ragefire,Cavernas Ígneas,389,0,927,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,0,0,0,0,0,0
2457,NightsongWoods,Floresta Noturcanto,1,331,928,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2477,TheVeiledSea,Mar Velado,1,1377,929,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2478,Morlos'Aran,Morlos'Aran,1,361,930,0,0,0,2172,0,0,47,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2479,EmeraldSanctuary,Santuário Esmeralda,1,361,931,0,0,0,2172,0,0,48,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2480,JadefireGlen,Grota Flamejade,1,361,932,0,0,0,2172,0,0,50,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2481,RuinsofConstellas,Ruínas de Constellas,1,361,933,0,0,0,2172,0,0,51,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2497,BitterReaches,Confins Amargos,1,16,934,0,0,0,2172,0,0,53,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2517,RiseoftheDefiler,Cerro do Profanador,0,4,935,0,0,0,2172,0,0,46,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2518,LarissPavilion,Pavilhão Lariss,1,357,936,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2519,WoodpawHills,Serra dos Patábua,1,357,937,0,0,0,2172,0,0,41,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2520,WoodpawDen,Covil dos Patábua,1,357,938,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2521,VerdantisRiver,Rio Verdantis,1,357,939,0,0,0,2172,0,0,-1,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2522,RuinsofIsildien,Ruínas de Isildien,1,357,940,0,0,0,2172,0,0,45,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2537,GrimtotemPost,Aldeia do Temível Totem,1,406,941,0,0,0,2172,226,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2538,CampAparaje,Aldeia Apareje,1,406,942,0,0,0,2172,226,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2539,Malaka'jin,Malaka'jin,1,406,943,0,0,0,2172,185,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2540,BoulderslideRavine,Ravina da Avalanche,1,406,944,0,0,0,2172,0,0,16,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2541,SishirCanyon,Desfiladeiro Sishir,1,406,945,0,0,0,2172,229,0,18,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2557,DireMaul,Gládio Cruel,429,0,946,0,0,29,2172,11,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
2558,DeadwindRavine,Garganta do Vento Morto,0,41,947,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2559,DiamondheadRiver,Rio Diamante,0,41,948,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2560,Ariden'sCamp,Acampamento de Ariden,0,41,949,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2561,TheVice,A Garra,0,41,950,0,0,0,2172,0,0,57,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2562,Karazhan,Karazhan,0,41,951,0,0,0,2172,0,0,60,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2563,Morgan'sPlot,Terreno de Morgan,0,41,952,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2577,DireMaul,Gládio Cruel,1,357,953,0,0,29,2172,11,0,44,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2597,AlteracValley,Vale Alterac,30,0,954,0,0,42,2172,242,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
2617,Scrabblescrew'sCamp,Acampamento do Rabiscafuso,1,405,955,0,0,0,2172,226,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2618,JadefireRun,Aldeia Flamejade,1,361,956,0,0,0,2172,0,0,50,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2619,ThondrorilRiver,Rio Thondroril,0,139,957,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2620,ThondrorilRiver,Rio Thondroril,0,28,958,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2621,LakeMereldar,Lago Mereldar,0,139,959,0,0,0,2172,0,0,54,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2622,PestilentScar,Cicatriz Pestilenta,0,139,960,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2623,TheInfectisScar,Fenda Infectis,0,139,961,0,0,0,2172,0,0,59,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2624,BlackwoodLake,Lago Bosquenero,0,139,962,0,0,0,2172,0,0,58,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2625,EastwallGate,Portão da Muralha Leste,0,139,963,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2626,TerrorwebTunnel,Túnel Terrorteia,0,139,964,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2627,Terrordale,Várzea do Medo,0,139,965,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2637,KargathiaKeep,Bastilha Karrathia,1,331,966,0,0,28,2172,228,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2657,ValleyofBones,Vale dos Ossos,1,405,967,0,0,0,2172,193,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2677,BlackwingLair,Covil Asa Negra,469,0,968,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
2697,Deadman'sCrossing,Encruzilhada do Defunto,0,41,969,0,0,0,2172,0,0,50,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2717,MoltenCore,Núcleo Derretido,409,0,970,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
2737,TheScarabWall,Muralha do Escaravelho,1,1377,971,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2738,Southwind Village,Vila do Vento Sul,1,1377,972,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2739,TwilightBaseCamp,Acampamento do Crepúsculo,1,1377,973,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2740,TheCrystalVale,Vale de Cristal,1,1377,974,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2741,TheScarabDais,Palanque do Escaravelho,1,1377,975,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2742,Hive'Ashi,Colme'Ashi,1,1377,976,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2743,Hive'Zora,Colme'Zora,1,1377,977,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2744,Hive'Regal,Colme'Régia,1,1377,978,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2757,Shrineofthefallenwarrior,Altar do Guerreiro Caído,1,17,979,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2777,AlteracValley,UNUSED Alterac Valley,0,267,980,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2797,BlackfathomDeeps,Profundezas Negras,1,331,981,0,0,24,2172,176,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2817,***On Map Dungeon***,***On Map Dungeon***,30,0,1157,3,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,68,0,0,0,0,0
2837,TheMaster'sCellar,Porão do Senhorio,1,41,982,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2838,StonewroughtPass,Galeria Lapidada,0,51,983,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2839,AlteracValley,Vale Alterac,0,36,984,0,0,38,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2857,TheRumbleCage,Jaula Troante,1,440,985,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741952,0,0,0,0,0
2877,ChunkTest,Teste de Chunk,451,22,986,0,0,0,2172,0,0,60,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2897,Zoram'garOutpost,Assentamento Zoram'gar,1,331,987,0,0,24,2172,185,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2917,HallofLegends,Salão dos Lendários,450,0,988,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,32,0,0,0,0,0
2918,Champions'Hall,Salão dos Campeões,449,0,989,0,0,0,2172,0,0,0,0,0,2,0,0,-1,0,0,0,32,0,0,0,0,0
2937,Grosh'gokCompound,Complexo Grosh'gok,0,41,990,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2938,SleepingGorge,Garganta Adormecida,0,41,991,0,0,0,2172,0,0,50,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2957,IrondeepMine,Mina Ferrofundo,30,2597,992,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2958,StonehearthOutpost,Posto Avançado Larpétreo,30,2597,993,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2959,DunBaldar,Dun Baldar,30,2597,994,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2960,IcewingPass,Desfiladeiro Asálgida,30,2597,995,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2961,FrostwolfVillage,Aldeia Lobo do Gelo,30,2597,996,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2962,TowerPoint,Torre do Pontal,30,2597,997,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2963,ColdtoothMine,Mina Dentefrio,30,2597,998,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2964,WinteraxHold,Fortaleza Invernacha,30,2597,999,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2977,IcebloodGarrison,Guarnição Sanguefrio,30,2597,1000,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2978,FrostwolfKeep,Bastilha Lobo do Gelo,30,2597,1001,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2979,Tor'krenFarm,Fazenda Tor'kren,1,14,1002,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3017,FrostDaggerPass,Desfiladeiro Punhal de Gelo,30,2597,1003,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3037,IronstoneCamp,Acampamento Petraferro,1,400,1004,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3038,Weazel'sCrater,Cratera do Furão,1,400,1005,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3039,TahondaRuins,Ruínas de Tahonda,1,400,1006,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3057,FieldofStrife,Campo de Disputa,30,2597,1007,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3058,IcewingCavern,Caverna Asálgida,30,2597,1008,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3077,Valor'sRest,Repouso dos Valorosos,1,1377,1009,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3097,TheSwarmingPillar,Pilar Enxameante,1,1377,1010,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3098,TwilightPost,Posto Crepúsculo,1,1377,1011,0,0,0,2172,0,0,57,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3099,TwilightOutpost,Posto Avançado do Crepúsculo,1,1377,1012,0,0,0,2172,0,0,59,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3100,RavagedTwilightCamp,Acampamento Arrasado do Crepúsculo,1,1377,1013,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3117,Shalzaru'sLair,Covil de Shalzaru,1,357,1014,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3137,TalrendisPoint,Campo Talrendis,1,16,1015,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3138,RethressSanctum,Sacrário de Rethress,1,16,1016,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3139,MoonHorrorDen,Antro Lunorror,1,618,1017,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3140,Scalebeard'sCave,Caverna do Barbescama,1,16,1018,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3157,BoulderslideCavern,Caverna da Avalanche,1,406,1019,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3177,WarsongLaborCamp,Campo de Trabalho Brado Guerreiro,1,331,1020,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3197,ChillwindCamp,Acampamento Ventogelante,0,28,1021,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3217,TheMaul,A Arena,1,2557,1022,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741952,0,0,0,0,0
3237,TheMaulUNUSED,The Maul UNUSED,1,2557,1023,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741952,0,0,0,0,0
3257,BonesofGrakkarond,Ossos de Grakkarond,1,1377,1024,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3277,WarsongGulch,Ravina Brado Guerreiro,489,0,1025,0,0,38,2172,243,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
3297,FrostwolfGraveyard,Cemitério Lobo do Gelo,30,2597,1026,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3298,FrostwolfPass,Desfiladeiro Lobo do Gelo,30,2597,1027,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3299,DunBaldarPass,Desfiladeiro de Dun Baldar,30,2597,1028,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3300,IcebloodGraveyard,Cemitério Sanguefrio,30,2597,1029,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3301,SnowfallGraveyard,Cemitério Nevado,30,2597,1030,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3302,StonehearthGraveyard,Cemitério Larpétreo,30,2597,1031,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3303,StormpikeGraveyard,Cemitério Lançatroz,30,2597,1032,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3304,IcewingBunker,Casamata Asálgida,30,2597,1033,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3305,StonehearthBunker,Casamata Larpétreo,30,2597,1034,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3306,WildpawRidge,Cordilheira Garragreste,30,2597,1035,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3317,RevantuskVillage,Aldeia Revatusco,0,47,1036,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3318,RockofDurotan,Rocha de Durotan,30,2597,1037,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3319,SilverwingGrove,Bosque Asa de Prata,1,331,1038,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3320,WarsongLumberMill,Serraria Brado Guerreiro,489,3277,1039,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3321,SilverwingHold,Castelo Asa de Prata,489,3277,1040,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3337,WildpawCavern,Caverna Garragreste,30,2597,1041,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3338,TheVeiledCleft,Fenda Oculta,30,2597,1042,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3357,YojambaIsle,Ilha Yojamba,0,33,1043,0,0,0,2172,245,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3358,ArathiBasin,Bacia Arathi,529,0,1044,0,11,37,2172,219,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
3377,TheCoil,A Espiral,309,1977,1045,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3378,AltarofHir'eek,Altar de Hir'eek,309,1977,1046,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3379,Shadra'zaar,Shadra'zaar,309,1977,1047,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3380,HakkariGrounds,Terras Hakkari,309,1977,1048,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3381,NazeofShirvallah,Cerne de Shirvallah,309,1977,1049,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3382,TempleofBethekk,Templo de Bethekk,309,1977,1050,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3383,TheBloodfirePit,Fossa Rubrofogo,309,1977,1051,0,0,0,2172,245,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3384,AltaroftheBloodGod,Altar do Deus Sanguinário,309,1977,1052,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3397,Zanza'sRise,Terraço de Zanza,309,1977,1053,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3398,EdgeofMadness,Beira da Loucura,309,1977,1054,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3417,TrollbaneHall,Salão dos Matatroll,529,3358,1055,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3418,Defiler'sDen,Covil do Profanador,529,3358,1056,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3419,Pagle'sPointe,Pontal do Pagle,309,1977,1057,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3420,Farm,Fazenda,529,3358,1058,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3421,Blacksmith,Ferraria,529,3358,1059,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3422,LumberMill,Serraria,529,3358,1060,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3423,GoldMine,Mina de Ouro,529,3358,1061,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3424,Stables,Estábulos,529,3358,1062,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3425,CenarionHold,Forte Cenariano,1,1377,1063,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3426,StaghelmPoint,Posto Guenelmo,1,1377,1064,0,0,0,2172,0,0,59,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3427,BronzebeardEncampment,Acampamento Barbabronze,1,1377,1065,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3428,AhnQiraj,Ahn'Qiraj,531,0,1161,0,0,352,2172,248,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
3429,RuinsofAhnQiraj,Ruínas de Ahn'Qiraj,509,0,1162,0,0,352,2172,248,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
3446,TwilightsRun,Passeio do Crepúsculo,1,1377,1163,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3447,Ortell'sHideout,Esconderijo de Ortell,1,1377,1164,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3448,ScarabTerrace,Terraço dos Escaravelhos,509,3429,1068,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3449,General'sTerrace,Terraço do General,509,3429,1069,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3450,TheReservoir,O Reservatório,509,3429,1070,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3451,TheHatchery,Incubadora,509,3429,1071,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3452,TheComb,O Cortiço,509,3429,1072,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3453,Watchers'Terrace,Terraço dos Vigilantes,509,3429,1073,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3454,RuinsofAhn'Qiraj,Ruínas de Ahn'Qiraj,1,1377,1074,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3456,Naxxrammas,Naxxramas,533,0,1158,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,3,0,0,0,0,21
3459,CityChannel,Cidade,0,0,1160,3,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,512,0,0,0,0,0
3478,GatesofAhn'Qiraj,Portões de Ahn'Qiraj,1,0,1159,0,0,38,2172,176,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
3486,RavenholdtManor,Mansão de Corvoforte,0,36,1076,0,0,0,2172,0,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
13649,TestDungeon,Test Dungeon,13,0,12255,0,0,0,0,0,0,0,0,0,0,0,3,-1,0,0,0,64,0,0,0,0,0
]]

-- Exported from https://wow.tools/dbc/?dbc=taxinodes&build=1.14.1.41030&locale=ptPT
local taxiNodesCSV = [[
Name_lang,Pos[0],Pos[1],Pos[2],MapOffset[0],MapOffset[1],FlightMapOffset[0],FlightMapOffset[1],ID,ContinentID,ConditionID,CharacterBitNumber,Flags,UiTextureKitID,Facing,SpecialIconConditionID,VisibilityConditionID,MountCreatureID[0],MountCreatureID[1]
Abadia de Vila Norte,-8888.98,-0.54,94.39,0,0,0,0,1,0,0,1,0,0,0,0,0,308,0
"Ventobravo, Elwynn",-8840.56,489.7,109.61,0,0,0,0,2,0,0,2,1,0,0,0,0,0,541
Ilha dos Programadores,16391.81,16341.21,69.44,0,0,0,0,3,0,0,3,0,0,0,0,0,308,0
"Morro da Sentinela, Cerro Oeste",-10628.89,1036.68,34.06,0,0,0,0,4,0,0,4,1,0,0,0,0,0,541
"Vila Plácida, Montanhas Cristarrubra",-9429.1,-2231.4,68.65,0,0,0,0,5,0,0,5,1,0,0,0,0,0,541
"Altaforja, Dun Morogh",-4821.78,-1155.44,502.21,0,0,0,0,6,0,0,6,1,0,0,0,0,0,541
"Porto de Menethil, Pantanal",-3792.26,-783.29,9.06,0,0,0,0,7,0,0,7,1,0,0,0,0,0,541
"Thelsamar, Loch Modan",-5421.91,-2930.01,347.25,0,0,0,0,8,0,0,8,1,0,0,0,0,0,541
"Angra do Butim, Selva do Espinhaço",-14271.77,299.87,31.09,0,0,0,0,9,0,0,9,0,0,0,0,0,0,541
"O Sepulcro, Floresta de Pinhaprata",478.86,1536.59,131.32,0,0,0,0,10,0,0,10,2,0,0,0,0,3574,0
"Cidade Baixa, Tirisfal",1568.62,267.97,-43.1,0,0,0,0,11,0,0,11,2,0,0,0,0,3574,0
"Vila Sombria, Floresta do Crepúsculo",-10515.46,-1261.65,41.34,0,0,0,0,12,0,0,12,1,0,0,0,0,0,541
"Serraria Tarren, Eira dos Montes",-0.06,-859.91,58.83,0,0,0,0,13,0,0,13,2,0,0,0,0,3574,0
"Costa Sul, Eira dos Montes",-711.48,-515.48,26.11,0,0,0,0,14,0,0,14,1,0,0,0,0,0,541
Terras Pestilentas Orientais,2253.4,-5344.9,83.38,0,0,0,0,15,0,0,15,0,0,0,0,0,0,541
"Ponta do Refúgio, Arathi",-1240.53,-2515.11,22.16,0,0,0,0,16,0,0,16,1,0,0,0,0,0,541
"Ruína do Martelo, Arathi",-916.29,-3496.89,70.45,0,0,0,0,17,0,0,17,2,0,0,0,0,2224,0
"Angra do Butim, Selva do Espinhaço",-14444.29,509.62,26.2,0,0,0,0,18,0,0,18,2,0,0,0,0,2224,0
"Angra do Butim, Selva do Espinhaço",-14473.05,464.15,36.43,0,0,0,0,19,0,0,19,1,0,0,0,0,0,541
"Grom'gol, Selva do Espinhaço",-12414.18,146.29,3.28,0,0,0,0,20,0,0,20,2,0,0,0,0,2224,0
"Karrath, Ermos",-6633.99,-2180.05,244.14,0,0,0,0,21,0,0,21,2,0,0,0,0,2224,0
"Penhasco do Trovão, Mulgore",-1197.21,29.71,176.95,0,0,0,0,22,1,0,22,2,0,0,0,0,2224,0
"Orgrimmar, Durotar",1677.59,-4315.71,61.17,0,0,0,0,23,1,0,23,2,0,0,0,0,2224,0
"Genérico, Alvo mundial para Rotas de Zepelim",-6666,-2222.3,278.6,0,0,0,0,24,0,0,24,0,0,0,0,0,0,0
"Encruzilhada, Sertões",-441.8,-2596.08,96.06,0,0,0,0,25,1,0,25,2,0,0,0,0,2224,0
"Auberdine, Costa Negra",6341.38,557.68,16.29,0,0,0,0,26,1,0,26,1,0,0,0,0,0,3837
"Vila de Rut'theran, Teldrassil",8643.59,841.05,23.3,0,0,0,0,27,1,0,27,1,0,0,0,0,0,3837
"Astranaar, Vale Gris",2827.34,-289.24,107.16,0,0,0,0,28,1,0,28,1,0,0,0,0,0,3837
"Retiro Rocha do Sol, Cordilheira das Torres de Pedra",966.57,1040.32,104.27,0,0,0,0,29,1,0,29,2,0,0,0,0,2224,0
"Aldeia Vento Livre, Mil Agulhas",-5407.71,-2414.3,90.32,0,0,0,0,30,1,0,30,2,0,0,0,0,2224,0
"Thalanaar, Feralas",-4491.88,-775.89,-39.52,0,0,0,0,31,1,0,31,1,0,0,0,0,0,3837
"Theramore, Pântano Vadeoso",-3825.37,-4516.58,10.44,0,0,0,0,32,1,0,32,1,0,0,0,0,0,541
"Morro das Torres de Pedra, Cordilheira das Torres de Pedra",2681.13,1461.68,232.88,0,0,0,0,33,1,0,33,1,0,0,0,0,0,3837
"Transporte, Angra do Butim - Vila Catraca",-1965.17,-5824.29,-1.06,0,0,0,0,34,1,0,34,0,0,0,0,0,0,0
"Transporte, Zepelins de Orgrimmar",1320.07,-4649.2,21.57,0,0,0,0,35,1,0,35,0,0,0,0,0,0,0
"Genérico, Alvo mundial",-8644.62,433.28,59.46,0,0,0,0,36,0,0,36,0,0,0,0,0,15665,0
"Posto do Nijel, Desolação",139.24,1325.82,193.5,0,0,0,0,37,1,0,37,1,0,0,0,0,0,3837
"Aldeia Pescassombra, Desolação",-1767.64,3263.89,4.94,0,0,0,0,38,1,0,38,2,0,0,0,0,2224,0
"Geringontzan, Tanaris",-7223.97,-3734.59,8.39,0,0,0,0,39,1,0,39,1,0,0,0,0,0,541
"Geringontzan, Tanaris",-7048.89,-3780.36,10.19,0,0,0,0,40,1,0,40,2,0,0,0,0,2224,0
"Plumaluna, Feralas",-4373.8,3338.65,12.27,0,0,0,0,41,1,0,41,1,0,0,0,0,0,3837
"Aldeia Mojache, Feralas",-4419.86,199.31,25.06,0,0,0,0,42,1,0,42,2,0,0,0,0,2224,0
"Ninho da Águia, Terras Agrestes",283.74,-2002.76,194.74,0,0,0,0,43,0,0,43,1,0,0,0,0,0,541
"Valormok, Azshara",3661.52,-4390.38,113.05,0,0,0,0,44,1,0,44,2,0,0,0,0,2224,0
"Bastilha de Etergarde, Barreira do Inferno",-11112.25,-3435.74,79.09,0,0,0,0,45,0,0,45,1,0,0,0,0,0,541
"Balsa da Costa Sul, Eira dos Montes",-986.43,-547.86,-3.86,0,0,0,0,46,0,0,46,0,0,0,0,0,0,0
"Transporte, Grom'gol - Orgrimmar",-12418.77,235.43,1.12,0,0,0,0,47,0,0,47,0,0,0,0,0,0,0
"Posto Peçonha, Selva Maleva",5068.4,-337.22,367.41,0,0,0,0,48,1,0,48,2,0,0,0,0,2224,0
Clareira da Lua,7458.45,-2487.21,462.33,0,0,0,0,49,1,0,49,1,0,0,0,0,0,3837
"Transporte, Navios de Menethil",0,0,0,0,0,0,0,50,0,0,50,0,0,0,0,0,0,0
"Transporte, Rut'theran - Auberdine",0,0,0,0,0,0,0,51,0,0,51,0,0,0,0,0,0,0
"Visteterna, Hibérnia",6799.24,-4742.44,701.5,0,0,0,0,52,1,0,52,1,0,0,0,0,0,3837
"Visteterna, Hibérnia",6813.06,-4611.12,710.67,0,0,0,0,53,1,0,53,2,0,0,0,0,2224,0
"Transporte, Plumaluna - Feralas",-4203.87,3284,-12.86,0,0,0,0,54,1,0,54,0,0,0,0,0,0,0
"Aldeia Muralha Verde, Pântano Vadeoso",-3147.39,-2842.18,34.61,0,0,0,0,55,1,0,55,2,0,0,0,0,2224,0
"Pedregal, Pântano das Mágoas",-10456.97,-3279.25,21.35,0,0,0,0,56,0,0,56,2,0,0,0,0,2224,0
"Colônia de Pescadores, Teldrassil",8701.51,991.37,14.21,0,0,0,0,57,1,0,57,0,0,0,0,0,0,3837
"Assentamento Zoram'gar, Vale Gris",3374.71,996.97,5.19,0,0,0,0,58,1,0,58,2,0,0,0,0,2224,0
"Dun Baldar, Vale Alterac",574.21,-46.65,37.61,0,0,0,0,59,30,0,59,1,0,0,0,0,0,541
"Bastilha Lobo do Gelo, Vale Alterac",-1335.44,-319.69,90.66,0,0,0,0,60,30,0,60,2,0,0,0,0,3574,0
"Posto Machadada, Vale Gris",2302.39,-2524.55,104.4,0,0,0,0,61,1,0,61,2,0,0,0,0,2224,0
"Refúgio Noturno, Clareira da Lua",7793.61,-2403.47,489.32,0,0,0,0,62,1,0,62,1,0,0,0,0,0,3837
"Refúgio Noturno, Clareira da Lua",7787.72,-2404.1,489.56,0,0,0,0,63,1,0,63,2,0,0,0,0,2224,0
"Campo Talrendis, Azshara",2721.99,-3880.64,100.87,0,0,0,0,64,1,0,64,1,0,0,0,0,0,3837
"Clareira da Galhaça, Selva Maleva",6205.88,-1949.63,571.29,0,0,0,0,65,1,0,65,1,0,0,0,0,0,3837
"Acampamento Ventogelante, Terras Pestilentas Ocidentais",931.32,-1430.11,64.67,0,0,0,0,66,0,0,66,1,0,0,0,0,0,541
"Capela Esperança da Luz, Terras Pestilentas Orientais",2271.09,-5340.8,87.11,0,0,0,0,67,0,0,67,1,0,0,0,0,0,541
"Capela Esperança da Luz, Terras Pestilentas Orientais",2327.41,-5286.89,81.78,0,0,0,0,68,0,0,68,2,0,0,0,0,3574,0
Clareira da Lua,7470.39,-2123.38,492.34,0,0,0,0,69,1,0,69,2,0,0,0,0,2224,0
"Monte Candente, Estepes Ardentes",-7504.03,-2187.54,165.53,0,0,0,0,70,0,0,70,2,0,0,0,0,2224,0
"Vigia de Morgan, Estepes Ardentes",-8364.61,-2738.35,185.46,0,0,0,0,71,0,0,71,1,0,0,0,0,0,541
"Forte Cenariano, Silithus",-6811.39,836.74,49.81,0,0,0,0,72,1,0,72,2,0,0,0,0,2224,0
"Forte Cenariano, Silithus",-6761.83,772.03,88.91,0,0,0,0,73,1,0,73,1,0,0,0,0,0,3837
"Posto de Tório, Garganta Abrasadora",-6552.59,-1168.27,309.31,0,0,0,0,74,0,0,74,1,0,0,0,0,0,541
"Posto de Tório, Garganta Abrasadora",-6554.93,-1100.05,309.57,0,0,0,0,75,0,0,75,2,0,0,0,0,2224,0
"Aldeia Revatusco, Terras Agrestes",-635.26,-4720.5,5.38,0,0,0,0,76,0,0,76,2,0,0,0,0,2224,0
"Acampamento Taurajo, Sertões",-2380.67,-1882.67,95.85,0,0,0,0,77,1,0,77,2,0,0,0,0,2224,0
Naxxramas,3133.31,-3399.93,139.53,0,0,0,0,78,0,0,78,0,0,0,0,0,0,0
"Refúgio do Marshal, Cratera Un'Goro",-6113.82,-1142.7,-187.63,0,0,0,0,79,1,0,79,3,0,0,0,0,2224,541
"Vila Catraca, Sertões",-894.59,-3773.01,11.48,0,0,0,0,80,1,0,80,3,0,0,0,0,2224,541
"Torre do Bosque Pestilento, Terras Pestilentas Orientais",2998.71,-3050.1,117.19,0,0,0,0,84,0,0,84,3,0,0,0,0,17660,17660
"Torre do Passo Norte, Terras Pestilentas Orientais",3109.31,-4285.13,109.45,0,0,0,0,85,0,0,85,3,0,0,0,0,3574,541
"Torre da Muralha Leste, Terras Pestilentas Orientais",2499.23,-4742.85,93.5,0,0,0,0,86,0,0,86,3,0,0,0,0,3574,541
"Torre da Coroa, Terras Pestilentas Orientais",1857.56,-3658.47,143.73,0,0,0,0,87,0,0,87,3,0,0,0,0,3574,541
]]

L.areaTable = addon.LoadCSVData(areaTableCSV, "ID")
L.taxiNodes = addon.LoadCSVData(taxiNodesCSV, "ID")
