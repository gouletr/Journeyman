local addonName, addon = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "frFR")
if not L then return end

L["AUTO_SCROLL"] = "Défilement automatique"
L["AUTO_SCROLL_DESC"] = "Défiler automatiquement la fenêtre jusqu'à l'étape courante."
L["AUTO_SET_WAYPOINT"] = "Flèche de direction automatique"
L["AUTO_SET_WAYPOINT_DESC"] = "Réglez automatiquement la flèche de direction sur l'étape suivante."
L["AUTO_SET_WAYPOINT_MIN"] = "Distance minimum"
L["AUTO_SET_WAYPOINT_MIN_DESC"] = "Distance minimale pour définir automatiquement la flèche de direction."
L["CHAPTER_INDEX_LABEL"] = "Indice du Chapitre"
L["CHAPTER_TITLE"] = "Chapitre %d: %s"
L["CHAPTER_TITLE_LABEL"] = "Titre du Chapitre"
L["CLAMP_WINDOW"] = "Serrer la fenêtre"
L["CLAMP_WINDOW_DESC"] = "Empêcher la fenêtre de sortir de l'écran."
L["COPY_CHAPTER"] = "Copier le chapitre"
L["COPY_TEXT_BELOW"] = "Copier le texte ci-dessous"
L["CREATE_NEW_JOURNEY"] = "Créer nouveau périple"
L["CREATE_NEW_JOURNEY_DESC"] = "Créer un nouveau périple, le rendre actif et l'ouvrir dans l'éditeur de périples."
L["DEBUGGING_OPTIONS"] = "Options de débogage"
L["DELETE_CHAPTER"] = "Supprimer le Chapitre"
L["DELETE_JOURNEY"] = "Supprimer le Périple"
L["DELETE_STEP"] = "Supprimer l'étape"
L["DIE_AND_SPIRIT_RES"] = "Vous pouvez choisir de mourir maintenant et utiliser le service de guérisseur spirituel."
L["DROPDOWN_ACCEPT_QUEST"] = "Accepter la Quête"
L["DROPDOWN_BIND_HEARTHSTONE"] = "Lier Pierre de Foyer"
L["DROPDOWN_COMPLETE_QUEST"] = "Terminer la Quête"
L["DROPDOWN_DIE_AND_RES"] = "Mourez et ressuscitez"
L["DROPDOWN_FLY_TO"] = "Voler à"
L["DROPDOWN_GO_TO_AREA"] = "Aller au Lieu"
L["DROPDOWN_GO_TO_COORD"] = "Aller aux Coordonnées"
L["DROPDOWN_GO_TO_ZONE"] = "Voyager à la Zone"
L["DROPDOWN_LEARN_COOKING"] = "Apprendre à Cuisinier"
L["DROPDOWN_LEARN_FIRST_AID"] = "Apprendre Secourisme"
L["DROPDOWN_LEARN_FISHING"] = "Apprendre à Pêcher"
L["DROPDOWN_LEARN_FLIGHT_PATH"] = "Apprendre la Trajectoire"
L["DROPDOWN_REACH_LEVEL"] = "Atteindre le Niveau"
L["DROPDOWN_REACH_REPUTATION"] = "Atteindre la Réputation"
L["DROPDOWN_TRAIN_CLASS"] = "Former la Classe"
L["DROPDOWN_TRAIN_SPELLS"] = "Apprendre les Sorts"
L["DROPDOWN_TURNIN_QUEST"] = "Déposer la Quête"
L["DROPDOWN_USE_HEARTHSTONE"] = "Utiliser Pierre de Foyer"
L["ENABLE_DEBUG"] = "Activer le débogage"
L["ENABLE_DEBUG_DESC"] = "Basculer le mode de débogage."
L["ENABLE_DEBUG_TEXT"] = "Cette option contrôle si les informations et les outils de débogage sont activés ou non. Cela peut ajouter beaucoup de messages dans la console, et ne devrait pas être nécessaire sauf s'il y as des problèmes."
L["EXPORT_JOURNEY"] = "Exporter un périple"
L["EXPORT_JOURNEY_DESC"] = "Exporter un périple vers une chaîne de caractères."
L["FONT_SIZE"] = "Taille de police"
L["FONT_SIZE_DESC"] = "Taille de la police utilisée dans la fenêtre."
L["HARDCORE_MODE"] = "Mode Hardcore"
L["HARDCORE_MODE_DESC"] = "Active le mode hardcore. Désactive les étapes mourir."
L["IMPORT_JOURNEY"] = "Importer un périple"
L["IMPORT_JOURNEY_DESC"] = "Importer un périple à partir d'une chaîne de caractères."
L["INDENT_SIZE"] = "Taille d'indentation"
L["INDENT_SIZE_DESC"] = "Taille de l'indentation du texte dans la fenêtre."
L["INVALID_JOURNEY"] = "Périple invalide"
L["JOURNEY_INDEX_LABEL"] = "Indice du Périple"
L["JOURNEY_OPTIONS"] = "Options de périple"
L["JOURNEY_TITLE_LABEL"] = "Titre du Périple"
L["LINE_SPACING"] = "Interligne"
L["LINE_SPACING_DESC"] = "Espace entre les lignes de texte dans la fenêtre."
L["LOCK_WINDOW"] = "Verrouiller la fenêtre"
L["LOCK_WINDOW_DESC"] = "Basculez le verrouillage de la fenêtre pour empêcher le déplacement ou le redimensionnement."
L["MISSING_CHAPTER_TITLE"] = "Aucun Chapitre"
L["NEW_CHAPTER"] = "Nouveau Chapitre"
L["NEW_CHAPTER_TITLE"] = "Nouveau Chapitre"
L["NEW_JOURNEY"] = "Nouveau Périple"
L["NEW_JOURNEY_TITLE"] = "Nouveau Périple"
L["NEW_STEP"] = "Nouvelle étape"
L["NOT_A_NUMBER"] = "Pas un numéro"
L["NOT_A_STRING"] = "Pas une chaîne"
L["NO_JOURNEY_SELECTED"] = "Aucun périple sélectionné, veuillez sélectionner un périple pour continuer."
L["NO_VALUE"] = "Pas de Valeur"
L["OPEN_OPTIONS"] = "Ouvrir les options"
L["PASTE_CHAPTER"] = "Coller le chapitre"
L["PASTE_TEXT_BELOW"] = "Coller le texte ci-dessous"
L["RESET_POSITION"] = "Réinitialiser la position"
L["RESET_POSITION_DESC"] = "Réinitialiser la position de la fenêtre."
L["SAVED_PER_CHARACTER"] = "Enregistré par personnage."
L["SELECT_CHAPTER"] = "Sélectionner le chapitre"
L["SELECT_JOURNEY"] = "Sélectionner le périple"
L["SELECT_JOURNEY_DESC"] = "Sélectionner le périple à utiliser."
L["SELECT_STEP"] = "Sélectionner l'étape"
L["SHOW_COMPLETED_STEPS"] = "Afficher les étapes terminées"
L["SHOW_COMPLETED_STEPS_DESC"] = "Basculer l'affichage des étapes terminées."
L["SHOW_QUEST_LEVEL"] = "Afficher le niveau de quête"
L["SHOW_QUEST_LEVEL_DESC"] = "Basculer l'affichage du niveau de quête."
L["SHOW_SCROLL_BAR"] = "Afficher la barre de défilement"
L["SHOW_SCROLL_BAR_DESC"] = "Basculer l'affichage de la barre de défilement à côté de la fenêtre."
L["SHOW_SKIPPED_STEPS"] = "Afficher les étapes ignorées"
L["SHOW_SKIPPED_STEPS_DESC"] = "Basculer l'affichage des étapes ignorées."
L["SHOW_WINDOW"] = "Afficher la fenêtre"
L["SHOW_WINDOW_DESC"] = "Basculer l'affichage de la fenêtre."
L["STEPS_SHOWN"] = "Nombre d'étapes"
L["STEPS_SHOWN_DESC"] = "Nombre d'étapes affichées dans la fenêtre."
L["STEP_DATA_LABEL"] = "Données de l'Étape"
L["STEP_INDEX_LABEL"] = "Indice de l'Étape"
L["STEP_NOTE_LABEL"] = "Note de l'Étape"
L["STEP_PREFIX_GO_TALK_TO"] = "Aller parler à"
L["STEP_PREFIX_GO_TO"] = "Aller à"
L["STEP_REQUIRED_CLASSES_LABEL"] = "Classes requises de l'Étape"
L["STEP_REQUIRED_RACES_LABEL"] = "Races requises de l'Étape"
L["STEP_TEXT_ACCEPT_QUEST"] = "Accepter %s"
L["STEP_TEXT_BIND_HEARTHSTONE"] = "Lier %s à %s"
L["STEP_TEXT_COMPLETE_QUEST"] = "Terminer %s"
L["STEP_TEXT_DIE_AND_RES"] = "Mourez et ressuscitez au cimetière"
L["STEP_TEXT_FLY_TO"] = "Voler à %s"
L["STEP_TEXT_GAIN_XP"] = "Gagner %s xp"
L["STEP_TEXT_GO_TO_COORD"] = "Aller à %s dans %s"
L["STEP_TEXT_GO_TO_ZONE"] = "Voyager à %s"
L["STEP_TEXT_LEARN_COOKING"] = "Apprendre le métier de cuisinier"
L["STEP_TEXT_LEARN_FIRST_AID"] = "Apprendre le métier de secouriste"
L["STEP_TEXT_LEARN_FISHING"] = "Apprendre le métier de pêcheur"
L["STEP_TEXT_LEARN_FLIGHT_PATH"] = "Apprendre la trajectoire vers %s"
L["STEP_TEXT_NOTE"] = "Note: %s"
L["STEP_TEXT_REACH_LEVEL"] = "Atteindre le niveau %s"
L["STEP_TEXT_REACH_REPUTATION"] = "Atteindre %s avec la faction %s"
L["STEP_TEXT_TRAIN_CLASS"] = "Former votre classe"
L["STEP_TEXT_TRAIN_SPELLS"] = "Apprendre les sorts %s"
L["STEP_TEXT_TURNIN_QUEST"] = "Déposer %s"
L["STEP_TEXT_USE_HEARTHSTONE"] = "Utiliser %s à %s"
L["STEP_TYPE_LABEL"] = "Type de l'Étape"
L["UNDEFINED"] = "Indéfini"
L["UPDATE_ACTIVE_JOURNEY"] = "Mettre à jour le périple actif"
L["UPDATE_ACTIVE_JOURNEY_CONFIRM"] = "Activer cette option ajoutera des nouvelles étapes au périple actif durant vos aventures, continuer?"
L["UPDATE_ACTIVE_JOURNEY_DESC"] = "Mettre à jour le périple actif avec les nouvelles étapes."
L["UPDATE_ACTIVE_JOURNEY_DISABLED"] = "L'option 'Mettre à jour le périple actif' as été désactivée pour ce personnage."
L["UPDATE_ACTIVE_JOURNEY_TEXT"] = "Activer cette option ajoutera des nouvelles étapes au chapitre du périple actif durant vos aventures. Changer le périple actif désactivera cette option."
L["UPDATE_FREQUENCY"] = "Fréquence de la mise à jour (secondes)"
L["UPDATE_FREQUENCY_CONFIRM"] = "La modification de cette option nécessite un rechargement de l'interface utilisateur, continuer?"
L["UPDATE_FREQUENCY_DESC"] = "Période de temps en secondes entre chaque vérification de mise à jour."
L["UPDATE_FREQUENCY_TEXT"] = "Cette option contrôle la fréquence des mise à jour. Diminuer la valeur amènera le module à vérifier plus souvent si des mises à jour sont nécessaires. Il est recommandé de ne pas modifier cette valeur."
L["UPDATE_OPTIONS"] = "Options de mise à jour"
L["WINDOW_BG_COLOR"] = "Couleur de fond"
L["WINDOW_BG_COLOR_DESC"] = "Couleur de fond de la fenêtre."
L["WINDOW_HEIGHT"] = "Hauteur"
L["WINDOW_HEIGHT_DESC"] = "Hauteur de la fenêtre."
L["WINDOW_LEVEL"] = "Niveau"
L["WINDOW_LEVEL_DESC"] = "Contrôler le niveau (ordre d'affichage) de la fenêtre."
L["WINDOW_OPTIONS"] = "Options de fenêtre"
L["WINDOW_STEP_SPACING"] = "Espace entre les étapes"
L["WINDOW_STEP_SPACING_DESC"] = "Espace entre les étapes dans la fenêtre."
L["WINDOW_STRATA"] = "Strata"
L["WINDOW_STRATA_DESC"] = "Contrôler le strata (couche d'affichage) de la fenêtre."
L["WINDOW_WIDTH"] = "Largeur"
L["WINDOW_WIDTH_DESC"] = "Largeur de la fenêtre."

-- Exported from https://wow.tools/dbc/?dbc=areatable&build=1.14.1.41030&locale=frFR
local areaTableCSV = [[
ID,ZoneName,AreaName_lang,ContinentID,ParentAreaID,AreaBit,SoundProviderPref,SoundProviderPrefUnderwater,AmbienceID,UwAmbience,ZoneMusic,UwZoneMusic,ExplorationLevel,IntroSound,UwIntroSound,FactionGroupMask,Ambient_multiplier,MountFlags,PvpCombatWorldStateID,WildBattlePetLevelMin,WildBattlePetLevelMax,WindSettingsID,Flags[0],Flags[1],LiquidTypeID[0],LiquidTypeID[1],LiquidTypeID[2],LiquidTypeID[3]
1,DunMorogh,Dun Morogh,0,0,119,0,11,42,2172,8,0,0,0,0,2,0,0,-1,0,0,0,65,0,0,0,0,0
2,Longshore,Longrivage,0,40,120,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3,Badlands,Terres ingrates (Badlands),0,0,121,0,11,25,2172,7,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
4,BlastedLands,Terres foudroyées (Blasted Lands),0,0,122,0,11,210,2172,7,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
7,DarkwaterCove,Crique des Flots noirs,0,33,123,0,11,0,2172,3,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
8,SwampofSorrows,Marais des Chagrins (Swamp of Sorrows),0,0,124,0,11,33,2172,223,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
9,NorthshireValley,Vallée de Northshire,0,12,125,0,11,35,2172,1,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
10,Duskwood,Bois de la Pénombre (Duskwood),0,0,617,0,11,40,2172,2,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
11,Wetlands,Les Paluns (Wetlands),0,0,618,0,11,44,2172,227,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
12,ElwynnForest,Forêt d'Elwynn,0,0,126,0,11,35,2172,1,0,0,0,0,2,0,0,-1,0,0,0,64,0,0,0,0,0
13,TheWorldTree,L'Arbre-monde,0,10,555,0,11,48,2172,11,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
14,Durotar,Durotar,1,0,127,0,11,25,2172,9,0,0,0,0,4,0,0,-1,0,0,0,64,0,0,0,0,0
15,DustwallowMarsh,Marécage d'Âprefange (Dustwallow Marsh),1,0,128,0,11,33,2172,227,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
16,Azshara,Azshara,1,0,129,0,11,31,2172,205,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
17,TheBarrens,Les Tarides (the Barrens),1,0,130,0,11,38,2172,7,0,0,0,0,4,0,0,-1,0,0,0,64,0,0,0,0,0
18,CrystalLake,Lac de Cristal,0,12,131,0,11,35,2172,1,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
19,Zul'Gurub,Zul'Gurub,0,33,574,0,11,32,2172,3,0,40,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
20,Moonbrook,Ruisselune,0,40,132,0,11,0,2172,9,0,14,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
21,KulTiras,Kul Tiras,0,0,133,0,11,0,2172,8,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
22,ProgrammerIsle,Ile des programmeurs,451,0,547,0,11,38,2172,2,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
23,NorthshireRiver,Fleuve Northshire,0,12,134,0,11,35,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
24,Northshireabbey,Abbaye de Northshire,0,12,135,73,11,35,2172,1,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
25,BlackrockMountain,Mont Blackrock,0,0,136,0,11,46,2172,10,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
26,Lighthouse,Phare,0,40,602,0,11,0,2172,7,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
28,WesternPlaguelands,Maleterres de l'ouest (Western Plaguelands),0,0,137,0,11,37,2172,205,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
30,Nine,Neuf,0,0,138,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
32,TheCemetary,Le cimetière,0,10,139,0,11,0,2172,2,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
33,StranglethornJungle,Vallée de Strangleronce (Stranglethorn Vale),0,0,140,0,11,32,2172,3,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
34,EchoRidgeMine,Mine de la crête aux échos,0,12,141,0,11,35,2172,1,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
35,BootyBay,Baie-du-Butin,0,33,142,0,11,0,2172,3,0,42,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
36,AlteracMountains,Montagnes d'Alterac,0,0,143,0,11,31,2172,1,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
37,LakeNazferiti,Lac Nazfériti,0,33,144,0,11,0,2172,3,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
38,LochModan,Loch Modan,0,0,145,0,11,31,2172,1,0,0,0,0,2,0,0,-1,0,0,0,64,0,0,0,0,0
40,Westfall,Marche de l'Ouest (Westfall),0,0,146,0,11,47,2172,9,0,0,0,0,2,0,0,-1,0,0,0,64,0,0,0,0,0
41,DeadwindPass,Défilé de Deuillevent (Deadwind Pass),0,0,556,0,11,49,2172,2,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
42,Darkshire,Darkshire,0,10,147,0,11,0,2172,2,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
43,WildShore,Le Rivage cruel,0,33,148,0,11,0,2172,3,0,42,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
44,RedridgeMountains,Les Carmines (Redridge Mts),0,0,149,0,11,31,2172,1,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
45,ArathiHighlands,Hautes-terres d'Arathi,0,0,150,0,11,30,2172,8,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
46,BurningSteppes,Steppes ardentes,0,0,151,0,11,46,2172,10,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
47,TheHinterlands,Les Hinterlands,0,0,152,0,11,31,2172,1,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
49,DeadMansHole,Gouffre du mort,0,22,153,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
51,SearingGorge,Gorge des Vents brûlants (Searing Gorge),0,0,154,0,11,46,2172,10,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
53,ThievesCamp,Camp des voleurs,0,12,155,0,11,35,2172,1,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
54,JasperlodeMine,Mine de Jasperlode,0,12,550,0,11,35,2172,1,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
55,ValleyofHeroesUNUSED,Valley of Heroes UNUSED,0,12,156,0,11,35,2172,17,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
56,Heroes'Vigil,Veillée des héros,0,12,157,0,11,35,2172,1,0,0,303,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
57,FargodeepMine,Mine de Fargodeep,0,12,158,0,11,35,2172,1,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
59,NorthshireVineyards,Vignes de Northshire,0,12,159,0,11,35,2172,1,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
60,Forest'sEdge,La Lisière,0,12,606,0,11,35,2172,1,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
61,ThunderFalls,Chutes du Tonnerre,0,12,160,0,11,35,2172,1,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
62,PumpkinPatch,Champ de potirons des Brackwell,0,12,161,0,11,35,2172,1,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
63,TheStonefieldFarm,La ferme des Stonefield,0,12,162,0,11,35,2172,1,0,6,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
64,TheMaclureVineyards,Les Vignes des Maclure,0,12,163,0,11,35,2172,1,0,6,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
65,***On Map Dungeon***,***On Map Dungeon***,0,0,164,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,68,0,0,0,0,0
66,***On Map Dungeon***,***On Map Dungeon***,1,0,165,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,68,0,0,0,0,0
67,***On Map Dungeon***,***On Map Dungeon***,17,0,166,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,68,0,0,0,0,0
68,LakeEverstill,Lac placide,0,44,557,0,11,0,2172,1,0,16,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
69,Lakeshire,Lakeshire,0,44,167,0,11,0,2172,1,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
70,Stonewatch,Guet-de-pierre,0,44,168,0,11,0,2172,1,0,24,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
71,StonewatchFalls,Chutes de Guet-de-pierre,0,44,627,0,11,0,2172,1,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
72,TheDarkPortal,La Porte des ténèbres,0,4,169,0,11,210,2172,7,0,63,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
73,TheTaintedScar,La Balafre impure,0,4,170,0,11,0,2172,7,0,50,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
74,PoolofTears,Bassin des larmes,0,8,171,0,11,0,2172,0,0,43,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
75,Stonard,Stonard,0,8,172,0,11,0,2172,0,0,37,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
76,FallowSanctuary,Sanctuaire des friches,0,8,173,0,11,0,2172,0,0,37,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
77,Anvilmar,Anvilmar,0,1,174,0,11,0,2172,8,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
80,StormwindMountains,Monts Stormwind,0,12,175,0,11,35,2172,17,0,10,0,0,2,0,0,-1,0,0,0,1073741888,0,0,0,0,0
81,JeffNEQuadrantChanged,Jeff NE Quadrant Changed,451,22,575,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
82,JeffNWQuadrant,Jeff NW Quadrant,451,22,176,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
83,JeffSEQuadrant,Jeff SE Quadrant,451,22,177,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
84,JeffSWQuadrant,Jeff SW Quadrant,451,22,178,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
85,TirisfalGlades,Clairières de Tirisfal,0,0,179,0,11,40,2172,2,0,0,0,0,4,0,0,-1,0,0,0,64,0,0,0,0,0
86,StoneCircleLake,Lac du Cairn,0,12,180,0,11,35,2172,1,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
87,Goldshire,Goldshire,0,12,548,0,11,35,2172,1,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
88,EastvaleLoggingCamp,Camp de bûcherons du Val d'est,0,12,181,0,11,35,2172,1,0,6,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
89,ThunderFallsOrchard,Verger du lac Miroir,0,12,182,0,11,35,2172,1,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
91,TowerofAzora,Tour d'Azora,0,12,183,0,11,35,2172,1,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
92,MirrorLake,Lac Miroir,0,12,558,0,11,35,2172,1,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
93,Vul'GolOgreMound,Tertre des ogres Vul'Gol,0,10,628,0,11,0,2172,214,0,28,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
94,RavenHill,Colline-aux-Corbeaux,0,10,184,0,11,0,2172,2,0,24,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
95,RedridgeCanyon,Canyons des Carmines,0,44,185,0,11,0,2172,1,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
96,TowerofIlgalar,Tour d'Ilgalar,0,44,186,0,11,0,2172,1,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
97,Alther'sMill,Scierie d'Alther,0,44,187,0,11,0,2172,1,0,19,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
98,RethbanCaverns,Cavernes de Rethban,0,44,188,0,11,0,2172,1,0,17,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
99,RebelCamp,Camp rebelle,0,33,189,0,11,0,2172,3,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
100,Nesingwary'sExpedition,Expédition de Nesingwary,0,33,585,0,11,0,2172,3,0,31,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
101,Kurzen'sCompound,Base de Kurzen,0,33,190,0,11,0,2172,3,0,32,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
102,RuinsofZul'Kunda,Ruines de Zul'Kunda,0,33,586,0,11,0,2172,3,0,41,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
103,RuinsofZul'Mamwe,Ruines de Zul'Mamwe,0,33,191,0,11,0,2172,3,0,40,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
104,TheVileReef,Le Récif infâme,0,33,192,0,11,0,2172,3,0,37,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
105,Mosh'OggOgreMound,Tertre des ogres Mosh'Ogg,0,33,193,0,11,0,2172,3,0,42,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
106,TheStockpile,La réserve,0,33,194,0,11,0,2172,3,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
107,Saldean'sFarm,Ferme des Saldean,0,40,195,0,11,0,2172,9,0,14,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
108,SentinelHill,Colline des sentinelles,0,40,196,0,11,0,2172,9,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
109,Furlbrow'sPumpkinFarm,Ferme de potirons de Furlbrow,0,40,197,0,11,0,2172,9,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
111,JangolodeMine,Mine de Jangolode,0,40,198,0,11,0,2172,9,0,12,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
113,GoldCoastQuarry,Carrière de la côte de l'Or,0,40,576,0,11,0,2172,9,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
115,WestfallLighthouse,Phare de l'Ouest,0,40,199,0,11,24,2172,9,0,17,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
116,MistyValley,Vallée des brumes,0,8,200,0,11,0,2172,0,0,39,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
117,Grom'golBaseCamp,Campement Grom'gol,0,33,629,0,11,0,2172,228,0,35,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
118,Whelgar'sExcavationSite,Excavations de Whelgar,0,11,201,0,11,0,2172,191,0,22,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
120,WestbrookGarrison,Garnison du ruisseau de l'ouest,0,12,559,0,11,35,2172,0,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
121,TranquilGardensCemetery,Cimetière des jardins paisibles,0,10,202,0,11,0,2172,15,0,28,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
122,ZuuldaiaRuins,Ruines de Zuuldaia,0,33,203,0,11,0,2172,3,0,37,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
123,Bal'lalRuins,Ruines de Bal'lal,0,33,204,0,11,0,2172,3,0,34,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
125,Kal'aiRuins,Ruines de Kal'ai,0,33,205,0,11,0,2172,3,0,35,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
126,TkashiRuins,Ruines de Tkashi,0,33,206,0,11,0,2172,3,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
127,Balia'mahRuins,Ruines de Balia'mah,0,33,207,0,11,0,2172,3,0,40,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
128,Ziata'jaiRuins,Ruines de Ziata'jai,0,33,208,0,11,0,2172,3,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
129,MizjahRuins,Ruines de Mizjah,0,33,209,0,11,0,2172,3,0,37,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
130,SilverpineForest,Forêt des Pins argentés (Silverpine Forest),0,0,210,0,11,28,2172,2,0,0,0,0,4,0,0,-1,0,0,0,64,0,0,0,0,0
131,Kharanos,Kharanos,0,1,211,0,11,0,2172,0,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
132,ColdridgeValley,Vallée des Frigères,0,1,212,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
133,Gnomeregan,Gnomeregan,0,1,213,0,11,42,2172,8,0,10,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
134,Gol'BolarQuarry,Carrière de Gol'Bolar,0,1,214,0,11,0,2172,8,0,10,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
135,FrostmaneHold,Repaire des Frostmane,0,1,215,0,11,0,2172,0,0,7,121,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
136,TheGrizzledDen,L'antre Gris,0,1,216,0,11,0,2172,0,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
137,BrewnallVillage,Brassetout,0,1,217,0,11,0,2172,0,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
138,MistyPineRefuge,Refuge de Brumepins,0,1,218,0,11,0,2172,8,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
139,EasternPlaguelands,Maleterres de l'est (Eastern Plaguelands),0,0,219,0,11,37,2172,205,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
141,Teldrassil,Teldrassil,1,0,220,0,11,48,2172,11,0,0,0,0,2,0,0,-1,0,0,0,64,0,0,0,0,0
142,Ironband'sExcavationSite,Excavations d'Ironband,0,38,221,0,11,0,2172,1,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
143,Mo'groshStronghold,Bastion des Mo'grosh,0,38,222,0,11,0,2172,14,0,18,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
144,Thelsamar,Thelsamar,0,38,223,0,11,0,2172,1,0,10,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
145,AlgazGate,Porte d'Algaz,0,38,224,0,11,0,2172,1,0,18,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
146,StonewroughtDam,Barrage de Formepierre,0,38,225,0,11,230,2172,1,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
147,TheFarstriderLodge,Le pavillon des Pérégrins,0,38,226,0,11,0,2172,1,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
148,Darkshore,Sombrivage (Darkshore),1,0,227,0,11,28,2172,191,0,0,0,0,2,0,0,-1,0,0,0,64,0,0,0,0,0
149,SilverStreamMine,Mine du Ru d'argent,0,38,228,0,11,0,2172,1,0,12,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
150,MenethilHarbor,Port de Menethil,0,11,229,0,11,0,2172,191,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
151,DesignerIsland,Ile des concepteurs,451,0,560,0,11,47,2172,226,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
152,TheBulwark,La Barricade,0,85,230,0,11,0,2172,2,0,9,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
153,RuinsofLordaeron,Ruines de Lordaeron,0,85,607,0,11,0,2172,2,0,10,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
154,Deathknell,Le Glas,0,85,231,0,11,0,2172,15,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
155,NightWeb'sHollow,Grottes des Tisse-nuit,0,85,232,0,11,0,2172,2,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
156,SollidenFarmstead,Ferme des Solliden,0,85,233,0,11,0,2172,2,0,6,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
157,AgamandMills,Moulins d'Agamand,0,85,234,0,11,0,2172,15,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
158,AgamandFamilyCrypt,Crypte de la famille Agamand,0,85,235,0,11,0,2172,15,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
159,Brill,Brill,0,85,236,0,11,0,2172,15,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
160,WhisperingGardens,Jardins des murmures,0,85,237,0,11,0,2172,2,0,12,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
161,TerraceofRepose,Terrasse de la quiétude,0,85,238,0,11,0,2172,2,0,10,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
162,BrightwaterLake,Lac Etincelant,0,85,239,0,11,0,2172,2,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
163,Gunther'sRetreat,Retraite de Gunther,0,85,240,0,11,0,2172,2,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
164,Garren'sHaunt,Antre de Garren,0,85,241,0,11,0,2172,2,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
165,BalnirFarmstead,Ferme des Balnir,0,85,242,0,11,0,2172,15,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
166,ColdHearthManor,Manoir du Foyer froid,0,85,243,0,11,0,2172,2,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
167,CrusaderOutpost,Avant-poste des Croisés,0,85,244,0,11,0,2172,2,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
168,TheNorthCoast,La Côte nord,0,85,245,0,11,0,2172,2,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
169,Whispering Shore,Rivage des murmures,0,85,577,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
170,LordamereLake,Lac Lordamere,0,0,246,0,11,31,2172,2,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
172,FenrisIsle,Ile de Fenris,0,130,247,0,11,0,2172,2,0,18,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
173,Faol'sRest,Repos de Faol,0,85,620,0,11,0,2172,2,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
186,Dolanaar,Dolanaar,1,141,622,0,11,0,2172,11,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
187,DarnassusUNUSED,Darnassus UNUSED,1,141,248,0,11,48,2172,76,0,7,63,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
188,Shadowglen,Sombrevallon,1,141,561,0,11,0,2172,11,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
189,Steelgrill'sDepot,Dépôt de Steelgrill,0,1,249,0,11,0,2172,8,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
190,Hearthglen,Hearthglen,0,28,250,0,11,0,2172,0,0,56,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
192,NorthridgeLumberCamp,Camp de bûcherons de la Crête du nord,0,28,251,0,11,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
193,RuinsofAndorhal,Ruines d'Andorhal,0,28,252,0,11,0,2172,15,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
195,SchoolofNecromancy,Ecole de nécromancie,0,28,253,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
196,Uther'sTomb,Tombeau d'Uther,0,28,578,0,11,0,2172,15,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
197,SorrowHill,Colline des chagrins,0,28,254,0,11,0,2172,0,0,50,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
198,TheWeepingCave,La grotte des Pleurs,0,28,255,0,11,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
199,FelstoneField,Champ de Felstone,0,28,256,0,11,0,2172,10,0,50,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
200,Dalson'sTears,Larmes de Dalson,0,28,257,0,11,0,2172,10,0,54,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
201,Gahrron'sWithering,La Flétrissure de Gahrron,0,28,258,0,11,0,2172,10,0,57,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
202,TheWrithingHaunt,Le Repaire putride,0,28,259,0,11,0,2172,10,0,46,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
203,MardenholdeKeep,Donjon de Mardenholde,0,28,260,0,11,37,2172,193,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
204,PyrewoodVillage,Bois-du-Bûcher,0,130,261,0,11,0,2172,191,0,15,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
205,DunModr,Dun Modr,0,11,262,0,11,0,2172,191,0,28,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
206,Westfall,Marche de l'Ouest (Westfall),36,0,263,0,11,47,2172,9,0,0,0,0,0,0,0,-1,0,0,0,65600,0,0,0,0,0
207,TheGreatSea,La Grande mer,36,0,264,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
208,UnusedIroncladcove,Unused Ironcladcove,36,0,265,76,11,34,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
209,ShadowfangKeep,Donjon d'Ombrecroc,33,0,266,0,11,28,2172,2,0,16,0,0,4,0,0,-1,0,0,0,0,0,0,0,0,0
210,***On Map Dungeon***,***On Map Dungeon***,36,0,267,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,68,0,0,0,0,0
211,IceflowLake,Lac glacial,0,1,268,0,11,0,2172,8,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
212,Helm'sBedLake,Lac du Lit d'Helm,0,1,269,0,11,0,2172,8,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
213,DeepElemMine,Mine du gouffre d'Elem,0,130,270,0,11,0,2172,2,0,13,324,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
214,TheGreatSea,La Grande mer,0,0,271,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
215,Mulgore,Mulgore,1,0,272,0,11,30,2172,9,0,0,0,0,4,0,0,-1,0,0,0,64,0,0,0,0,0
219,AlexstonFarmstead,Ferme des Alexston,0,40,273,0,11,0,2172,9,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
220,RedCloudMesa,Mesa de Nuage rouge,1,215,562,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
221,CampNarache,Camp Narache,1,215,274,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
222,BloodhoofVillage,Village Bloodhoof,1,215,275,0,11,0,2172,226,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
223,StonebullLake,Lac Taureau-de-pierre,1,215,276,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
224,RavagedCaravan,Caravane dévastée,1,215,277,0,11,0,2172,9,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
225,RedRocks,Rochers rouges,1,215,278,0,11,0,2172,9,0,9,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
226,TheSkitteringDark,Le Grouillement,0,130,551,0,11,0,2172,0,0,11,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
227,Valgan'sField,Champ de Valgan,0,130,279,0,11,0,2172,2,0,11,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
228,TheSepulcher,Le Sépulcre,0,130,280,0,11,0,2172,15,0,10,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
229,Olsen'sFarthing,Ferme des Olsen,0,130,281,0,11,0,2172,0,0,12,161,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
230,TheGreymaneWall,Le mur de Greymane,0,130,282,0,11,0,2172,0,0,18,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
231,Beren'sPeril,Péril de Beren,0,130,283,0,11,0,2172,191,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
232,TheDawningIsles,Les îles de l'aube,0,130,284,0,11,0,2172,2,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
233,Ambermill,Moulin-de-l'Ambre,0,130,285,0,11,0,2172,191,0,15,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
235,FenrisKeep,Donjon de Fenris,0,130,608,0,11,0,2172,219,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
236,Shadowfang Keep,Donjon d'Ombrecroc,0,130,286,0,11,28,2172,2,0,16,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
237,TheDecrepitFerry,Le bac délabré,0,130,287,0,11,0,2172,2,0,16,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
238,Malden'sOrchard,Verger de Malden,0,130,587,0,11,0,2172,2,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
239,TheIvarPatch,Le lopin d'Ivar,0,130,588,0,11,0,2172,2,0,11,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
240,TheDeadField,Le Champ des morts,0,130,288,0,11,0,2172,2,0,12,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
241,TheRottingOrchard,Le verger pourrissant,0,10,289,0,11,0,2172,2,0,26,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
242,BrightwoodGrove,Bosquet de Clairbois,0,10,290,0,11,0,2172,2,0,28,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
243,ForlornRowe,La masure lugubre,0,10,291,0,11,0,2172,2,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
244,TheWhippleEstate,Le domaine de Whipple,0,10,292,0,11,0,2172,2,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
245,TheYorgenFarmstead,La ferme des Yorgen,0,10,563,0,11,0,2172,2,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
246,TheCauldron,Le Chaudron,0,51,293,0,11,0,2172,10,0,48,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
247,GrimesiltDigSite,Site de fouilles de Grimesilt,0,51,294,0,11,0,2172,0,0,45,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
249,DreadmaulRock,Rocher des Cognepeurs,0,46,1,0,11,0,2172,10,0,50,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
250,RuinsofThaurisan,Ruines de Thaurissan,0,46,579,0,11,0,2172,0,0,54,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
251,FlameCrest,Corniche des flammes,0,46,2,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
252,BlackrockStronghold,Bastion des Blackrock,0,46,3,0,11,0,2172,0,0,57,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
253,ThePillarofAsh,Le Pilier de cendres,0,46,4,0,11,0,2172,0,0,56,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
254,BlackrockMountain,Mont Blackrock,0,46,630,0,11,0,2172,10,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
255,AltarofStorms,Autel des tempêtes,0,46,5,0,11,0,2172,10,0,59,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
256,Aldrassil,Aldrassil,1,141,6,0,11,0,2172,11,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
257,ShadowthreadCave,Grotte de Sombrefil,1,141,7,0,11,0,2172,11,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
258,FelRock,Gangreroche,1,141,8,0,11,0,2172,11,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
259,LakeIl'Ameth,Lac Al'Ameth,1,141,9,0,11,0,2172,11,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
260,StarbreezeVillage,Brise-stellaire,1,141,10,0,11,0,2172,11,0,6,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
261,GnarlpineHold,Camp des Pins-tordus,1,141,11,0,11,0,2172,0,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
262,Ban'ethilBarrowDen,Refuge des saisons de Ban'ethil,1,141,12,0,11,0,2172,11,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
263,TheCleft,La Faille,1,141,13,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
264,TheOracleGlade,La Clairière de l'Oracle,1,141,14,0,11,0,2172,11,0,9,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
265,WellspringRiver,L'Aigue-vive,1,141,15,0,11,0,2172,0,0,11,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
266,WellspringLake,Lac d'Aigue-vive,1,141,16,0,11,0,2172,0,0,9,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
267,HillsbradFoothills,Contreforts d'Hillsbrad,0,0,17,0,11,31,2172,1,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
268,AzsharaCrater,Cratère d'Azshara,37,0,580,0,11,42,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
269,DunAlgaz,Dun Algaz,0,0,18,0,11,31,2172,0,0,18,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
271,Southshore,Southshore,0,267,615,0,11,0,2172,1,0,22,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
272,TarrenMill,Moulin-de-Tarren,0,267,19,0,11,0,2172,182,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
275,DurnholdeKeep,Donjon de Durnholde,0,267,20,0,11,0,2172,191,0,21,302,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
276,StonewroughtPass,UNUSED Stonewrought Pass,0,0,564,0,11,31,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
277,TheFoothillCaverns,Les cavernes des contreforts,0,36,21,0,11,0,2172,1,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
278,LordamereInternmentCamp,Camp d'internement de Lordamere,0,36,22,0,11,0,2172,1,0,32,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
279,Dalaran,Dalaran,0,36,23,0,11,0,2172,0,0,30,81,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
280,Strahnbrad,Strahnbrad,0,36,24,0,11,37,2172,10,0,34,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
281,RuinsofAlterac,Ruines d'Alterac,0,36,25,0,11,37,2172,10,0,36,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
282,CrushridgeHold,Bastion Cassecrête,0,36,26,0,11,37,2172,10,0,35,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
283,SlaughterHollow,Creux du massacre,0,36,27,0,11,37,2172,10,0,35,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
284,TheUplands,Les Hauteurs,0,36,28,0,11,0,2172,1,0,27,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
285,SouthpointTower,Tour de la Pointe du Midi,0,267,29,0,11,0,2172,2,0,21,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
286,HillsbradFields,Champs d'Hillsbrad,0,267,30,0,11,0,2172,1,0,22,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
287,Hillsbrad,Hillsbrad,0,267,31,0,11,0,2172,1,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
288,AzurelodeMine,Mine d'Azurelode,0,267,32,0,11,0,2172,0,0,27,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
289,NethanderStead,Ferme des Nethander,0,267,33,0,11,0,2172,1,0,26,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
290,DunGarok,Dun Garok,0,267,34,0,11,0,2172,1,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
293,Thoradin'sWall,Mur de Thoradin,0,0,35,0,11,31,2172,1,0,30,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
294,EasternStrand,Rivage oriental,0,267,36,0,11,0,2172,1,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
295,WesternStrand,Rivage occidental,0,267,616,0,11,0,2172,1,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
296,SouthSeasUNUSED,South Seas UNUSED,0,0,37,0,11,24,2172,0,0,0,122,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
297,JagueroIsle,Ile aux jagueros,0,33,38,0,11,0,2172,0,0,50,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
298,BaradinBay,Baie de Baradin,0,11,39,0,11,0,2172,3,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
299,MenethilBay,Baie de Menethil,0,11,40,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
300,MistyReedStrand,Grève de Brumejonc,0,8,41,0,11,0,2172,0,0,41,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
301,TheSavageCoast,La Côte sauvage,0,33,42,0,11,0,2172,3,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
302,TheCrystalShore,Le Rivage de cristal,0,33,565,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
303,ShellBeach,Plage aux coquillages,0,33,43,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
305,NorthTide'sRun,La côte nord,0,130,44,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
306,SouthTide'sRun,La côte sud,0,130,45,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
307,TheOverlookCliffs,Les Hauts-Surplombs,0,47,46,0,11,0,2172,1,0,48,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
308,TheForbiddingSea,La Mer interdite,0,0,631,0,11,0,2172,1,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
309,Ironbeard'sTomb,Tombe d'Ironbeard,0,11,47,0,11,0,2172,0,0,24,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
310,CrystalveinMine,Mine aux cristaux,0,33,48,0,11,0,2172,0,0,41,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
311,RuinsofAboraz,Ruines d'Aboraz,0,33,589,0,11,0,2172,0,0,44,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
312,Janeiro'sPoint,Cap Janeiro,0,33,49,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
313,NorthfoldManor,Manoir de Nordclos,0,45,632,0,11,0,2172,0,0,31,302,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
314,Go'ShekFarm,Ferme de Go'Shek,0,45,50,0,11,0,2172,0,0,33,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
315,Dabyrie'sFarmstead,Ferme des Dabyrie,0,45,590,0,11,0,2172,0,0,31,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
316,BoulderfistHall,Hall Rochepoing,0,45,51,0,11,31,2172,0,0,35,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
317,WitherbarkVillage,Village Witherbark,0,45,609,0,11,0,2172,3,0,33,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
318,DrywhiskerGorge,Gorge des Sèches-moustaches,0,45,52,0,11,0,2172,0,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
320,RefugePointe,Refuge de l'Ornière,0,45,53,0,11,0,2172,0,0,30,123,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
321,Hammerfall,Trépas-d'Orgrim,0,45,54,0,11,0,2172,14,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
322,BlackwaterShipwrecks,Epaves des Flots noirs,0,45,581,0,11,0,2172,8,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
323,O'Breen'sCamp,Camp de O'Breen,0,45,55,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
324,StromgardeKeep,Donjon de Stromgarde,0,45,56,0,11,0,2172,186,0,36,182,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
325,TheTowerofArathor,La Tour d'Arathor,0,45,57,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
326,TheSanctum,Le Sanctuaire,0,45,58,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
327,Faldir'sCove,La Crique de Faldir,0,45,59,0,11,0,2172,3,0,40,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
328,TheDrownedReef,Le récif englouti,0,45,566,0,11,0,2172,192,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
330,ThandolSpan,Viaduc de Thandol,0,0,60,0,11,44,2172,3,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
331,Ashenvale,Ashenvale,1,0,61,0,11,48,2172,11,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
332,TheGreatSea,La Grande mer,1,0,62,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
333,CircleofEastBinding,Cercle de lien oriental,0,45,63,0,11,0,2172,0,0,38,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
334,CircleofWestBinding,Cercle de lien occidental,0,45,64,0,11,0,2172,0,0,38,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
335,CircleofInnerBinding,Cercle de lien intérieur,0,45,65,0,11,0,2172,0,0,38,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
336,CircleofOuterBinding,Cercle de lien extérieur,0,45,66,0,11,0,2172,0,0,38,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
337,Apocryphan'sRest,Repos d'Apocryphan,0,3,67,0,11,25,2172,7,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
338,AngorFortress,Forteresse d'Angor,0,3,633,0,11,25,2172,7,0,39,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
339,LethlorRavine,Ravin de Lethlor,0,3,634,0,11,25,2172,0,0,45,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
340,Kargath,Kargath,0,3,68,0,11,25,2172,0,0,38,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
341,CampKosh,Camp Kosh,0,3,69,0,11,25,2172,0,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
342,CampBoff,Camp Boff,0,3,70,0,11,25,2172,0,0,39,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
343,CampWurg,Camp Wurg,0,3,71,0,11,25,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
344,CampCagg,Camp Cagg,0,3,72,0,11,25,2172,0,0,43,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
345,Agmond'sEnd,Fin d'Agmond,0,3,73,0,11,25,2172,7,0,39,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
346,Hammertoe'sDigsite,Site de fouilles d'Hammertoe,0,3,74,0,11,25,2172,0,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
347,DustbelchGrotto,Grotte de Crache-poussière,0,3,75,0,11,25,2172,0,0,43,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
348,AeriePeak,Nid-de-l'Aigle,0,47,76,0,11,0,2172,1,0,41,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
349,WildhammerKeep,Donjon des Wildhammer,0,47,77,0,11,0,2172,1,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
350,Quel'DanilLodge,Gîte de Quel'Danil,0,47,78,0,11,0,2172,1,0,45,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
351,SkulkRock,Rocher de l'Affût,0,47,79,0,11,0,2172,1,0,48,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
352,Zun'watha,Zun'watha,0,47,80,0,11,0,2172,1,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
353,Shadra'Alor,Shadra'Alor,0,47,81,0,11,0,2172,3,0,44,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
354,Jintha'Alor,Jintha'Alor,0,47,591,0,11,0,2172,227,0,45,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
355,TheAltarofZul,L'Autel de Zul,0,47,592,0,11,0,2172,176,0,46,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
356,Seradane,Seradane,0,47,82,0,11,0,2172,76,0,41,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
357,Feralas,Feralas,1,0,83,0,11,48,2172,3,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
358,BramblebladeRavine,Ravin de Roncelame,1,215,84,0,11,25,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
359,BaelModan,Bael Modan,1,17,85,0,11,0,2172,7,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
360,TheVentureCo.Mine,Mine de la KapitalRisk,1,215,86,0,11,0,2172,9,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
361,Felwood,Gangrebois (Felwood),1,0,87,0,11,28,2172,193,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
362,RazorHill,Tranchecolline,1,14,88,0,11,0,2172,9,0,5,421,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
363,ValleyofTrials,Vallée des épreuves,1,14,89,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
364,TheDen,L'Antre,1,14,90,75,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
365,BurningBladeCoven,Convent de la Lame ardente,1,14,91,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
366,KolkarCrag,Combe des Kolkar,1,14,92,0,11,0,2172,9,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
367,Sen'jinVillage,Village de Sen'jin,1,14,93,0,11,0,2172,185,0,6,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
368,EchoIsles,Îles de l'Écho,1,14,94,0,11,32,2172,3,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
369,ThunderRidge,Falaises du Tonnerre,1,14,95,0,11,0,2172,9,0,9,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
370,DrygulchRavine,Ravin asséché,1,14,96,0,11,0,2172,9,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
371,DustwindCave,Caverne des Terrevent,1,14,567,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
372,TiragardeKeep,Donjon de Tiragarde,1,14,97,0,11,0,2172,186,0,6,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
373,ScuttleCoast,Côte des naufrages,1,14,98,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
374,BladefistBay,Baie de Bladefist,1,14,99,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
375,DeadeyeShore,Rivage de Deadeye,1,14,100,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
377,SouthfuryRiver,Fleuve Furie-du-Sud,1,0,101,0,11,0,2172,9,0,9,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
378,CampTaurajo,Camp Taurajo,1,17,102,0,11,0,2172,226,0,10,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
379,FarWatchPost,Poste de garde extérieur,1,17,103,0,11,0,2172,7,0,10,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
380,TheCrossroads,La Croisée,1,17,104,0,11,0,2172,228,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
381,BoulderLodeMine,Mine des Pierriers,1,17,105,0,11,0,2172,0,0,17,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
382,TheSludgeFen,La Videfange,1,17,552,0,11,0,2172,3,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
383,TheDryHills,Les Collines arides,1,17,106,0,11,0,2172,0,0,14,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
384,DreadmistPeak,Pic de Brume-funeste,1,17,107,0,11,46,2172,10,0,11,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
385,NorthwatchHold,Fort du Nord,1,17,108,0,11,0,2172,3,0,15,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
386,TheForgottenPools,Les Bassins oubliés,1,17,109,0,11,32,2172,3,0,12,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
387,LushwaterOasis,Oasis luxuriante,1,17,582,0,11,32,2172,3,0,12,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
388,TheStagnantOasis,L'oasis stagnante,1,17,110,0,11,32,2172,3,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
390,FieldofGiants,Champ des Géants,1,17,111,0,11,0,2172,0,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
391,TheMerchantCoast,La Côte des marchands,1,17,112,0,11,32,2172,3,0,12,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
392,Ratchet,Ratchet,1,17,113,0,11,0,2172,3,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
393,DarkspearStrand,Grève des Darkspear,1,14,114,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
394,DarrowmereLakeUNUSED,Darrowmere Lake UNUSED,0,0,115,0,11,37,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
395,CaerDarrowUNUSED,Caer Darrow UNUSED,0,394,116,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
396,WinterhoofWaterWell,Puits Winterhoof,1,215,117,0,11,0,2172,9,0,6,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
397,ThunderhornWaterWell,Puits Thunderhorn,1,215,118,0,11,0,2172,9,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
398,WildmaneWaterWell,Puits Wildmane,1,215,441,0,11,0,2172,9,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
399,SkylineRidge,Crête de Skyline,1,215,610,0,11,0,2172,9,0,6,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
400,ThousandNeedles,Mille pointes (Thousand Needles),1,0,442,0,11,25,2172,9,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
401,TheTidusStair,L'Escalier des marées,1,17,443,0,11,32,2172,3,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
403,ShadyRestInn,Auberge du Repos ombragé,1,15,568,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
404,Bael'dunDigsite,Site de fouilles de Bael'Dun,1,215,444,0,11,0,2172,9,0,8,102,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
405,Desolace,Désolace,1,0,445,0,11,39,2172,7,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
406,StonetalonMountains,Les Serres-Rocheuses (Stonetalon Mts),1,0,446,0,11,25,2172,7,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
407,OrgrimmarUNUSED,Orgrimmar UNUSED,1,14,447,0,11,0,2172,14,0,10,62,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
408,Gillijim'sIsle,Ile de Gillijim,0,0,448,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
409,IslandofDoctorLapidis,Ile du docteur Lapidis,0,0,449,0,11,32,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
410,RazorwindCanyon,Canyon de Tranchevent,1,14,450,0,11,0,2172,9,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
411,Bathran'sHaunt,Repaire de Bathran,1,331,451,0,11,0,2172,205,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
412,TheRuinsofOrdil'Aran,Les Ruines d'Ordil'Aran,1,331,625,0,11,0,2172,205,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
413,Maestra'sPost,Poste de Maestra,1,331,452,0,11,0,2172,0,0,19,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
414,TheZoramStrand,La grève de Zoram,1,331,453,0,11,24,2172,176,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
415,Astranaar,Astranaar,1,331,454,0,11,0,2172,11,0,20,81,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
416,TheShrineofAessina,Le sanctuaire d'Aessina,1,331,455,0,11,0,2172,199,0,23,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
417,FireScarShrine,Sanctuaire de Scarfeu,1,331,456,0,11,28,2172,193,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
418,TheRuinsofStardust,Les ruines de Chimétoile,1,331,457,0,11,28,2172,193,0,23,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
419,TheHowlingVale,Le Val hurlant,1,331,458,0,11,0,2172,204,0,28,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
420,SilverwindRefuge,Refuge de Vent-argent,1,331,459,0,11,0,2172,0,0,25,81,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
421,MystralLake,Lac Mystral,1,331,460,0,11,0,2172,0,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
422,FallenSkyLake,Lac Tombeciel,1,331,461,0,11,0,2172,0,0,26,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
424,IrisLake,Lac Iris,1,331,462,0,11,28,2172,194,0,22,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
425,Moonwell,Puits de lune,1,331,549,0,11,0,2172,199,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
426,RaynewoodRetreat,Retraite de Raynewood,1,331,463,0,11,0,2172,0,0,24,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
427,TheShadyNook,Le creux ombragé,1,331,464,0,11,0,2172,11,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
428,Night Run,Défilé de la nuit,1,331,569,0,11,0,2172,3,0,25,121,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
429,Xavian,Xavian,1,331,611,0,11,0,2172,3,0,0,121,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
430,Satyrnaar,Satyrnaar,1,331,465,0,11,0,2172,3,0,28,121,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
431,Splintertree Post,Poste de Bois-brisé,1,331,553,0,11,0,2172,228,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
432,TheDor'DanilBarrowDen,Le Refuge des saisons de Dor'danil,1,331,466,0,11,0,2172,205,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
433,FalfarrenRiver,Fleuve Falfarren,1,331,467,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
434,FelfireHill,Colline Gangrefeu,1,331,570,0,11,48,2172,193,0,29,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
435,DemonFallCanyon,Canyon de la Malechute,1,331,468,0,11,49,2172,193,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
436,DemonFallRidge,Crête de la Malechute,1,331,469,0,11,49,2172,193,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
437,Warsong Lumber Camp,Camp de bûcherons Warsong,1,331,612,0,11,28,2172,228,0,22,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
438,BoughShadow,L'Ombrage,1,331,470,0,11,0,2172,188,0,20,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
439,TheShimmeringFlats,Les Salines,1,400,471,0,11,39,2172,0,0,35,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
440,Tanaris,Tanaris,1,0,472,0,11,39,2172,176,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
441,LakeFalathim,Lac Falathim,1,331,473,0,11,48,2172,0,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
442,Auberdine,Auberdine,1,148,474,0,11,0,2172,0,0,12,81,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
443,RuinsofMathystra,Ruines de Mathystra,1,148,475,0,11,0,2172,176,0,19,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
444,TowerofAlthalaxx,Tour d'Althalaxx,1,148,476,0,11,0,2172,0,0,16,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
445,CliffspringFalls,Chutes de la Bondissante,1,148,477,0,11,0,2172,0,0,14,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
446,Bashal'Aran,Bashal'Aran,1,148,478,0,11,0,2172,0,0,11,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
447,Ameth'Aran,Ameth'Aran,1,148,479,0,11,0,2172,15,0,11,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
448,GroveoftheAncients,Bosquet des Anciens,1,148,480,0,11,0,2172,0,0,15,302,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
449,TheMaster'sGlaive,Le Glaive du Maître,1,148,481,0,11,0,2172,0,0,16,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
450,Remtravel'sExcavation,Excavations de Remtravel,1,148,482,0,11,0,2172,0,0,19,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
452,Mist'sEdge,La lisière des brumes,1,148,483,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
453,TheLongWash,Le Lent reflux,1,148,583,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
454,WildbendRiver,La Sinueuse,1,148,484,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
455,BlackwoodDen,Tanière des Noirbois,1,148,485,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
456,CliffspringRiver,La Bondissante,1,148,486,0,11,0,2172,0,0,14,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
457,TheVeiledSea,La Mer voilée,1,0,571,0,11,24,2172,200,0,0,201,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
458,GoldRoad,Route de l'or,1,17,487,0,11,0,2172,7,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
459,ScarletWatchPost,Poste de garde de la Croisade,0,85,375,0,11,0,2172,0,0,10,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
460,SunRockRetreat,Retraite de Roche-Soleil,1,406,488,0,11,0,2172,228,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
461,Windshear Crag,Combe des Cisailles,1,406,489,0,11,0,2172,7,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
463,CragpoolLake,Lac de la Combe,1,406,490,0,11,0,2172,7,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
464,MirkfallonLake,Lac Mirkfallon,1,406,491,0,11,0,2172,7,0,21,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
465,TheCharredVale,Le Val calciné,1,406,492,0,11,0,2172,7,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
466,ValleyoftheBloodfuries,Vallée des Rouges-furies,1,406,493,0,11,0,2172,7,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
467,StonetalonPeak,Pic des Serres-Rocheuses,1,406,613,0,11,29,2172,11,0,25,201,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
468,TheTalonDen,L'antre des Serres,1,406,494,0,11,29,2172,11,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
469,GreatwoodVale,Val de Grandbois,1,406,495,0,11,0,2172,7,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
470,ThunderBluffUNUSED,Thunder Bluff UNUSED,1,215,496,0,11,45,2172,9,0,10,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
471,BraveWindMesa,Mesa de Brave-vent,1,215,497,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
472,FireStoneMesa,Mesa de Pierrefeu,1,215,498,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
473,MantleRock,Roc de Mantle,1,215,554,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
474,HunterRiseUNUSED,Hunter Rise UNUSED,1,215,499,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
475,SpiritRiseUNUSED,Spirit RiseUNUSED,1,215,500,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
476,ElderRiseUNUSED,Elder RiseUNUSED,1,215,501,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
477,RuinsofJubuwal,Ruines de Jubuwal,0,33,502,0,11,0,2172,3,0,43,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
478,PoolsofArlithrien,Bassins d'Arlithrien,1,141,503,0,11,0,2172,11,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
479,TheRustmaulDigSite,Site de fouilles de Rustmaul,1,400,504,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
480,CampE'thok,Camp E'thok,1,400,505,0,11,0,2172,9,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
481,SplithoofCrag,Combe du Sabot fendu,1,400,572,0,11,0,2172,9,0,24,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
482,Highperch,Haut-perchoir,1,400,506,0,11,0,2172,9,0,29,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
483,TheScreechingCanyon,Canyon des hurlements,1,400,507,0,11,0,2172,9,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
484,FreewindPost,Poste de Librevent,1,400,508,0,11,0,2172,226,0,26,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
485,TheGreatLift,La Grande élévation,1,400,509,0,11,0,2172,9,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
486,GalakHold,Repaire des Galak,1,400,510,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
487,RoguefeatherDen,Tanière des Volplumes,1,400,511,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
488,TheWeatheredNook,La niche érodée,1,400,512,0,11,0,2172,9,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
489,Thalanaar,Thalanaar,1,357,513,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
490,Un'GoroCrater,Cratère d'Un'Goro,1,0,514,0,11,33,2172,223,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
491,RazorfenKraul,Kraal de Tranchebauge,47,0,515,0,11,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,0,0,0,0,0,0
492,RavenHillCemetery,Cimetière de Colline-aux-Corbeaux,0,10,516,0,11,0,2172,15,0,26,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
493,Moonglade,Reflet-de-Lune (Moonglade),1,0,517,0,11,28,2172,191,0,0,201,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
495,DELETEME,DELETE ME,0,0,519,0,11,0,2172,11,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
496,BrackenwallVillage,Mur-de-Fougères,1,15,518,0,11,0,2172,214,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
497,SwamplightManor,Manoir des Flammeroles,1,15,520,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
498,BloodfenBurrow,Terrier des Rougefanges,1,15,521,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
499,DarkmistCavern,Caverne de Sombrebrume,1,15,522,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
500,MogglePoint,Cap Moggle,1,15,623,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
501,Beezil'sWreck,Epave de Beezil,1,15,614,0,11,0,2172,3,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
502,WitchHill,Colline des sorcières,1,15,624,0,11,0,2172,0,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
503,SentryPoint,Halte de la Vigie,1,15,573,0,11,0,2172,191,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
504,NorthPointTower,Tour de la halte nord,1,15,523,0,11,0,2172,191,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
505,WestPointTower,Tour du cap ouest,1,15,524,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
506,LostPoint,Halte perdue,1,15,525,0,11,0,2172,191,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
507,Bluefen,Marais bleu,1,15,526,0,11,0,2172,0,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
508,StonemaulRuins,Ruines Cognepierres,1,15,527,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
509,TheDenofFlame,L'Antre des flammes,1,15,528,0,11,0,2172,0,0,38,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
510,TheDragonmurk,Le cloaque aux dragons,1,15,584,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
511,Wyrmbog,Tourbière du Ver,1,15,529,0,11,0,2172,0,0,43,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
512,Onyxia'sLairUNUSED,Onyxia's Lair UNUSED,1,15,530,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
513,TheramoreIsle,Ile de Theramore,1,15,531,0,11,43,2172,13,0,36,401,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
514,FootholdCitadel,Citadelle de Theramore,1,15,532,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
515,IroncladPrison,Prison du cuirassé,1,15,533,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
516,DustwallowBay,Baie d'Âprefange,1,15,534,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
517,TidefuryCove,Crique du Mascaret,1,15,535,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
518,DreadmurkShore,Rivage de Troubleffroi,1,15,536,0,11,0,2172,0,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
536,Addle'sStead,Ferme des Addle,0,10,537,0,11,0,2172,2,0,24,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
537,FirePlumeRidge,Crête de la Fournaise,1,490,538,0,11,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
538,LakkariTarPits,Fosses de goudron de Lakkari,1,490,539,0,11,0,2172,0,0,49,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
539,TerrorRun,Coteaux de la terreur,1,490,540,0,11,0,2172,0,0,53,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
540,TheSlitheringScar,La Balafre sinueuse,1,490,541,0,11,0,2172,0,0,51,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
541,Marshal'sRefuge,Refuge des Marshal,1,490,542,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
542,FungalRock,Rocher fongique,1,490,543,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
543,GolakkaHotSprings,Sources de Golakka,1,490,544,0,11,0,2172,0,0,53,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
556,TheLoch,Le Loch,0,38,545,0,11,0,2172,1,0,12,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
576,Beggar'sHaunt,Repaire des mendiants,0,10,546,0,11,0,2172,2,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
596,KodoGraveyard,Cimetière des kodos,1,405,593,0,11,0,2172,7,0,35,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
597,GhostWalkerPost,Poste de Rôdeur-fantôme,1,405,594,0,11,0,2172,226,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
598,Sar'therisStrand,Grève de Sar'theris,1,405,595,0,11,31,2172,227,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
599,ThunderAxeFortress,Forteresse de Hache-Tonnerre,1,405,596,0,11,0,2172,193,0,30,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
600,Bolgan'sHole,Trou de Bolgan,1,405,597,0,11,0,2172,7,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
602,MannorocCoven,Convent de Mannoroc,1,405,599,0,11,0,2172,193,0,39,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
603,Sargeron,Sargeron,1,405,600,0,11,0,2172,76,0,31,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
604,MagramVillage,Village des Magram,1,405,601,0,11,0,2172,7,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
606,GelkisVillage,Village des Gelkis,1,405,603,0,11,0,2172,7,0,34,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
607,ValleyofSpears,Vallée des Lances,1,405,604,0,11,0,2172,7,0,37,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
608,Nijel'sPoint,Combe de Nijel,1,405,605,0,11,0,2172,206,0,30,103,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
609,KolkarVillage,Village des Kolkar,1,405,598,0,11,0,2172,7,0,32,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
616,Hyjal,Hyjal,1,0,619,0,11,31,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
618,Winterspring,Berceau-de-l'Hiver (Winterspring),1,0,621,0,11,42,2172,8,0,0,0,0,0,0,0,-1,0,0,0,65,0,0,0,0,0
636,BlackwolfRiver,Fleuve Loup-noir,1,406,626,0,11,0,2172,7,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
637,KodoRock,Rocher des kodos,1,215,635,0,11,0,2172,9,0,0,121,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
638,HiddenPath,Chemin secret,1,14,636,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
639,SpiritRock,Rocher des esprits,1,14,637,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
640,ShrineoftheDormantFlame,Autel de la flamme dormante,1,14,638,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
656,LakeElune'ara,Lac Elune'ara,1,493,295,0,11,0,2172,0,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
657,TheHarborage,Le Havre boueux,0,8,296,0,11,0,2172,0,0,37,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
676,Outland,Outreterre,150,0,297,0,11,46,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
696,Craftsmen'sTerraceUNUSED,Craftsmen's Terrace UNUSED,1,141,298,0,11,48,2172,76,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
697,Tradesmen'sTerraceUNUSED,Tradesmen's Terrace UNUSED,1,141,299,0,11,48,2172,76,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
698,TheTempleGardensUNUSED,The Temple Gardens UNUSED,1,141,300,0,11,48,2172,76,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
699,TempleofEluneUNUSED,Temple of Elune UNUSED,1,141,301,0,11,48,2172,76,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
700,CenarionEnclaveUNUSED,Cenarion Enclave UNUSED,1,141,302,0,11,48,2172,76,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
701,Warrior'sTerraceUNUSED,Warrior's Terrace UNUSED,1,141,303,0,11,48,2172,76,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
702,Rut'theranVillage,Rut'theran,1,141,304,0,11,0,2172,0,0,11,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
716,Ironband'sCompound,Base d'Ironband,0,1,639,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
717,TheStockade,La Prison,34,0,640,0,11,0,2172,0,0,0,0,0,2,0,0,-1,0,0,0,0,0,0,0,0,0
718,WailingCaverns,Cavernes des lamentations,43,0,641,0,11,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,0,0,0,0,0,0
719,BlackfathomDeeps,Profondeurs de Brassenoire,48,0,642,75,11,0,2172,176,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
720,FrayIsland,Ile de la Dispute,1,17,643,0,11,32,2172,3,0,0,121,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
721,Gnomeregan,Gnomeregan,90,0,305,0,11,42,2172,0,0,0,0,0,2,0,0,-1,0,0,0,0,0,0,0,0,0
722,RazorfenDowns,Souilles de Tranchebauge,129,0,644,0,11,38,2172,0,0,0,0,0,4,0,0,-1,0,0,0,3,0,0,0,0,0
736,Ban'ethilHollow,Creux de Ban'ethil,1,141,645,0,11,0,2172,0,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
796,ScarletMonastery,Monastère écarlate,189,0,646,0,11,0,2172,205,0,0,0,0,4,0,0,-1,0,0,0,0,0,0,0,0,0
797,Jerod'sLanding,Le Débarcadère de Jerod,0,12,647,0,11,35,2172,0,0,8,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
798,RidgepointTower,Tour de la Crête,0,12,648,0,11,35,2172,0,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
799,TheDarkenedBank,La Rive sombre,0,10,649,0,11,0,2172,2,0,10,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
800,ColdridgePass,Passe des Frigères,0,1,650,0,11,0,2172,0,0,4,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
801,ChillBreezeValley,Vallée de la bise,0,1,651,0,11,0,2172,0,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
802,ShimmerRidge,Crête scintillante,0,1,652,0,11,0,2172,0,0,8,121,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
803,AmberstillRanch,Ferme des Amberstill,0,1,653,0,11,0,2172,0,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
804,TheTundridHills,Les Collines de Tundrid,0,1,654,0,11,0,2172,0,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
805,SouthGatePass,Passage de la porte Sud,0,1,655,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
806,SouthGateOutpost,Avant-poste de la porte Sud,0,1,656,0,11,0,2172,0,0,12,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
807,NorthGatePass,Passage de la porte Nord,0,1,657,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
808,NorthGateOutpost,Avant-poste de la porte Nord,0,1,658,0,11,0,2172,0,0,11,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
809,GatesofIronforge,Portes d'Ironforge,0,1,659,0,11,0,2172,0,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
810,StillwaterPond,Etang immobile,0,85,660,0,11,0,2172,0,0,7,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
811,NightmareVale,Vallée des cauchemars,0,85,661,0,11,0,2172,0,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
812,VenomwebVale,Vallée de Tissevenin,0,85,662,0,11,0,2172,0,0,10,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
813,TheBulwark,La Barricade,0,28,663,0,11,0,2172,0,0,52,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
814,SouthfuryRiver,Fleuve Furie-du-Sud,1,14,664,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
815,SouthfuryRiver,Fleuve Furie-du-Sud,1,17,665,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
816,RazormaneGrounds,Terres des Tranchecrins,1,14,666,0,11,0,2172,0,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
817,SkullRock,Rocher du crâne,1,14,667,0,11,0,2172,0,0,10,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
818,PalemaneRock,Rocher des crins-pâles,1,215,668,0,11,0,2172,0,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
819,WindfuryRidge,Crête des Furies-des-vents,1,215,669,0,11,0,2172,0,0,9,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
820,TheGoldenPlains,Les plaines dorées,1,215,670,0,11,0,2172,0,0,5,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
821,TheRollingPlains,Les plaines vallonnées,1,215,671,0,11,0,2172,0,0,8,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
836,DunAlgaz,Dun Algaz,0,11,672,0,11,0,2172,0,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
837,DunAlgaz,Dun Algaz,0,38,673,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
838,NorthGatePass,Passage de la porte Nord,0,38,306,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
839,SouthGatePass,Passage de la porte Sud,0,38,307,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
856,TwilightGrove,Bosquet du crépuscule,0,10,674,0,11,0,2172,2,0,19,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
876,GMIsland,Ile des MJ,1,0,675,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
877,Delete ME,Delete ME,1,17,676,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
878,SouthfuryRiver,Fleuve Furie-du-Sud,1,16,677,0,11,0,2172,8,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
879,SouthfuryRiver,Fleuve Furie-du-Sud,1,331,678,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
880,ThandolSpan,Viaduc de Thandol,0,45,679,0,11,0,2172,0,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
881,ThandolSpan,Viaduc de Thandol,0,11,680,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
896,PurgationIsle,Ile de la purification,0,267,308,0,11,40,2172,193,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
916,TheJansenStead,La ferme des Jansen,0,40,681,0,11,0,2172,0,0,9,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
917,TheDeadAcre,L'acre mort,0,40,682,0,11,0,2172,0,0,18,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
918,TheMolsenFarm,La ferme des Molsen,0,40,683,0,11,0,2172,0,0,14,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
919,Stendel'sPond,Etang de Stendel,0,40,684,0,11,0,2172,0,0,14,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
920,TheDaggerHills,Les collines de la Dague,0,40,309,0,11,0,2172,0,0,17,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
921,Demont'sPlace,Maison de Demont,0,40,310,0,11,0,2172,0,0,16,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
922,TheDustPlains,Les Plaines de poussière,0,40,311,0,11,0,2172,0,0,18,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
923,StonesplinterValley,Vallée des Brisepierre,0,38,312,0,11,0,2172,0,0,13,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
924,ValleyofKings,Vallée des rois,0,38,313,0,11,0,2172,0,0,11,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
925,AlgazStation,Poste d'Algaz,0,38,314,0,11,0,2172,0,0,12,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
926,BucklebreeFarm,Ferme des Bucklebree,0,130,315,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
927,TheShiningStrand,Le Rivage rayonnant,0,130,316,0,11,0,2172,0,0,14,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
928,NorthTide'sHollow,Creux de la côte nord,0,130,317,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
936,GrizzlepawRidge,Falaise de Vieillegriffe,0,38,318,0,11,0,2172,0,0,12,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
956,TheVerdantFields,Les Champs verdoyants,169,0,319,0,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
976,Gadgetzan,Gadgetzan,1,440,320,0,0,0,2172,0,0,40,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
977,SteamwheedlePort,Port Gentepression,1,440,390,0,0,0,2172,3,0,40,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
978,Zul'Farrak,Zul'Farrak,1,440,321,0,0,25,2172,176,0,45,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
979,SandsorrowWatch,Guet de Tristesable,1,440,322,0,0,0,2172,0,0,44,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
980,ThistleshrubValley,Vallée des Chardonniers,1,440,323,0,0,0,2172,0,0,49,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
981,TheGapingChasm,Le Gouffre béant,1,440,324,0,0,0,2172,0,0,48,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
982,TheNoxiousLair,Le Repaire nuisible,1,440,325,0,0,0,2172,0,0,48,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
983,DunemaulCompound,Base des Cognedunes,1,440,326,0,0,0,2172,0,0,47,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
984,EastmoonRuins,Ruines d'Estelune,1,440,327,0,0,0,2172,0,0,47,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
985,WaterspringField,Champ des puisatiers,1,440,328,0,0,0,2172,0,0,44,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
986,Zalashji'sDen,La tanière de Zalashji,1,440,329,0,0,0,2172,0,0,45,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
987,Land'sEndBeach,Plage du Bout-du-Monde,1,440,330,0,0,0,2172,0,0,48,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
988,WavestriderBeach,Plage des Déferlantes,1,440,331,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
989,Uldum,Uldum,1,440,332,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
990,ValleyoftheWatchers,Vallée des guetteurs,1,440,333,0,0,0,2172,0,0,50,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
991,Gunstan'sPost,Poste de Gunstan,1,440,334,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
992,SouthmoonRuins,Ruines de Sudelune,1,440,335,0,0,0,2172,0,0,47,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
996,Render'sCamp,Camp des Etripeurs,0,44,408,0,0,0,2172,0,0,22,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
997,Render'sValley,Vallée des Etripeurs,0,44,409,0,0,0,2172,0,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
998,Render'sRock,Rocher des Etripeurs,0,44,410,0,0,0,2172,0,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
999,StonewatchTower,Tour de Guet-de-pierre,0,44,411,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1000,GalardellValley,Vallée de Galardell,0,44,412,0,0,0,2172,0,0,22,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1001,LakeridgeHighway,Grand-route de la Crête du lac,0,44,336,0,0,0,2172,0,0,16,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1002,ThreeCorners,Trois chemins,0,44,337,0,0,0,2172,0,0,16,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1016,DireforgeHill,Colline de Morneforge,0,11,338,0,0,0,2172,0,0,28,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1017,RaptorRidge,Crête des raptors,0,11,339,0,0,0,2172,0,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1018,BlackChannelMarsh,Marais des eaux-noires,0,11,340,0,0,0,2172,0,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1019,TheGreenBelt,La Ceinture verte,0,139,341,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1020,MosshideFen,Marais des Poils-moussus,0,11,342,0,0,0,2172,0,0,22,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1021,ThelgenRock,Rocher de Thelgen,0,11,343,0,0,0,2172,0,0,22,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1022,BluegillMarsh,Marais des Branchies-bleues,0,11,344,0,0,0,2172,0,0,24,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1023,SaltsprayGlen,Vallon des embruns,0,11,345,0,0,0,2172,0,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1024,SundownMarsh,Marais du couchant,0,11,346,0,0,0,2172,0,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1025,TheGreenBelt,La Ceinture verte,0,11,347,0,0,0,2172,0,0,21,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1036,AngerfangEncampment,Campement de Hargnecroc,0,11,391,0,0,0,2172,0,0,28,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1037,GrimBatol,Grim Batol,0,11,392,0,0,0,2172,0,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1038,DragonmawGates,Portes des Dragonmaw,0,11,393,0,0,0,2172,0,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1039,TheLostFleet,La flotte perdue,0,11,394,0,0,0,2172,0,0,25,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1056,DarrowHill,Colline de Darrow,0,267,348,0,0,0,2172,0,0,31,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1057,Thoradin'sWall,Mur de Thoradin,0,267,349,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1076,WebwinderPath,Sentier des Tisseuses,1,406,368,0,0,0,2172,0,0,21,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1097,TheHushedBank,La Rive silencieuse,0,10,351,0,0,0,2172,0,0,19,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1098,ManorMistmantle,Manoir Mistmantle,0,10,352,0,0,0,2172,0,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1099,CampMojache,Camp Mojache,1,357,353,0,0,0,2172,226,0,42,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1100,GrimtotemCompound,Base des Totem sinistre,1,357,395,0,0,0,2172,0,0,41,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1101,TheWrithingDeep,Gouffre grouillant,1,357,396,0,0,0,2172,0,0,44,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1102,WildwindLake,Lac des rafales,1,357,350,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1103,GordunniOutpost,Avant-poste des Gordunni,1,357,397,0,0,0,2172,0,0,42,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1104,Mok'Gordun,Mok'Gordun,1,357,398,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1105,FeralScarVale,Val des Griffes farouches,1,357,354,0,0,0,2172,0,0,44,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1106,FrayfeatherHighlands,Hautes-terres des Aigreplumes,1,357,399,0,0,0,2172,0,0,46,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1107,IdlewindLake,Lac Idlewind,1,357,400,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1108,TheForgottenCoast,La Côte oubliée,1,357,355,0,0,0,2172,0,0,49,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1109,EastPillar,Pilier Est,1,357,401,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1110,WestPillar,Pilier Ouest,1,357,402,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1111,DreamBough,Bosquet du rêve,1,357,403,0,0,0,2172,0,0,60,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1112,JademirLake,Lac Jademir,1,357,404,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1113,Oneiros,Oneiros,1,357,405,0,0,0,2172,0,0,60,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1114,RuinsofRavenwind,Ruines de Vent-du-Corbeau,1,357,356,0,0,0,2172,0,0,49,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1115,RageScarHold,Repaire des Griffes féroces,1,357,357,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1116,FeathermoonStronghold,Bastion de Feathermoon,1,357,358,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1117,RuinsofSolarsal,Ruines de Solarsal,1,357,359,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1118,LowerWilds UNUSED,Lower Wilds UNUSED,1,357,360,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1119,TheTwinColossals,Les Colosses jumeaux,1,357,369,0,0,0,2172,0,0,48,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1120,SardorIsle,Ile de Sardor,1,357,413,0,0,0,2172,0,0,43,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1121,IsleofDread,lle de l'effroi,1,357,414,0,0,0,2172,0,0,44,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1136,HighWilderness,Les plateaux sauvages,1,357,361,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1137,LowerWilds,Etendues sauvages,1,357,370,0,0,0,2172,0,0,42,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1156,SouthernBarrens,Tarides du sud,1,17,362,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1157,SouthernGoldRoad,Route de l'or méridionale,1,17,406,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1176,Zul'Farrak,Zul'Farrak,209,0,371,0,0,25,2172,176,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
1196,UNUSEDAlcazIsland,UNUSEDAlcaz Island,1,0,363,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
1216,TimbermawHold,Repaire des Grumegueules,1,16,364,0,0,0,2172,0,0,49,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1217,VanndirEncampment,Campement de Vanndir,1,16,365,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1218,TESTAzshara,TESTAzshara,1,16,366,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1219,LegashEncampment,Campement Legashi,1,16,367,0,0,0,2172,0,0,52,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1220,ThalassianBaseCamp,Camp de base thalassien,1,16,415,0,0,0,2172,76,0,52,302,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1221,RuinsofEldarath,Ruines d'Eldarath,1,16,416,0,0,0,2172,176,0,48,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1222,Hetaera'sClutch,Frai d'Hetaera,1,16,417,0,0,0,2172,176,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1223,TempleofZin-Malor,Temple de Zin-Malor,1,16,418,0,0,0,2172,15,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1224,Bear'sHead,Tête d'ours,1,16,419,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1225,Ursolan,Ursolan,1,16,420,0,0,0,2172,0,0,49,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1226,TempleofArkkoran,Temple d'Arkkoran,1,16,421,0,0,0,2172,176,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1227,BayofStorms,Baie des tempêtes,1,16,422,0,0,0,2172,176,0,50,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1228,TheShatteredStrand,La Grève fracassée,1,16,423,0,0,0,2172,176,0,52,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1229,TowerofEldara,Tour d'Eldara,1,16,424,0,0,0,2172,176,0,53,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1230,JaggedReef,Récif déchiqueté,1,16,425,0,0,0,2172,176,0,51,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1231,SouthridgeBeach,Plage des Crêtes du sud,1,16,426,0,0,0,2172,176,0,52,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1232,RavencrestMonument,Colosse de Ravencrest,1,16,427,0,0,0,2172,176,0,54,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1233,ForlornRidge,La crête lugubre,1,16,428,0,0,0,2172,215,0,49,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1234,LakeMennar,Lac Mennar,1,16,429,0,0,0,2172,0,0,52,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1235,ShadowsongShrine,Sanctuaire de Shadowsong,1,16,430,0,0,0,2172,15,0,46,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1236,HaldarrEncampment,Campement des Haldarr,1,16,431,0,0,0,2172,3,0,45,121,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1237,Valormok,Valormok,1,16,432,0,0,0,2172,228,0,49,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1256,TheRuinedReaches,Les Confins dévastés,1,16,433,0,0,0,2172,176,0,42,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1276,TheTalondeepPath,La Perce des Serres,1,331,434,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1277,TheTalondeepPath,La Perce des Serres,1,406,435,0,0,0,2172,0,0,20,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1296,RocktuskFarm,Ferme Brochepierre,1,14,372,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1297,JaggedswineFarm,Ferme Rêche-pourceau,1,14,407,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1316,RazorfenDowns,Souilles de Tranchebauge,1,17,436,0,0,70,2172,176,0,33,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1336,LostRiggerCove,Crique des Gréements,1,440,373,0,0,0,2172,0,0,45,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1337,Uldaman,Uldaman,70,0,437,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
1338,LordamereLake,Lac Lordamere,0,130,438,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1339,LordamereLake,Lac Lordamere,0,36,439,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1357,Gallows'Corner,Fourche du gibet,0,36,440,0,0,37,2172,10,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1377,Silithus,Silithus,1,0,374,0,0,38,2172,176,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
1397,EmeraldForest,Forêt d'émeraude,169,0,376,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
1417,SunkenTemple,Temple englouti,109,0,377,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
1437,DreadmaulHold,Bastion Cognepeur,0,4,378,0,0,0,2172,0,0,47,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1438,NethergardeKeep,Rempart-du-Néant,0,4,379,0,0,0,2172,205,0,50,303,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1439,DreadmaulPost,Poste Cognepeur,0,4,380,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1440,Serpent'sCoil,Anneaux du serpent,0,4,381,0,0,0,2172,0,0,51,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1441,AltarofStorms,Autel des tempêtes,0,4,382,0,0,0,2172,10,0,54,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1442,FirewatchRidge,Crête de Guet-du-feu,0,51,383,0,0,0,2172,0,0,48,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1443,TheSlagPit,La Fosse aux scories,0,51,384,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1444,TheSeaofCinders,La Mer de braises,0,51,385,0,0,0,2172,0,0,56,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1445,BlackrockMountain,Mont Blackrock,0,51,386,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1446,ThoriumPoint,Halte du Thorium,0,51,387,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1457,GarrisonArmory,Armurerie de la garnison,0,4,388,0,0,0,2172,0,0,47,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1477,TheTempleOfAtal'Hakkar,Le temple d'Atal'Hakkar,0,0,389,0,0,33,2172,3,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
1497,Undercity,Undercity,0,0,685,0,0,40,2172,0,0,10,0,0,4,0,0,-1,0,0,0,312,0,0,0,0,0
1517,Uldaman,Uldaman,0,3,686,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1518,NotIUsedDeadmines,Not Used Deadmines,0,40,687,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1519,StormwindCity,Cité de Stormwind,0,0,688,0,0,31,2172,13,0,10,61,0,2,0,0,-1,0,0,0,312,0,0,0,0,0
1537,Ironforge,Ironforge,0,0,689,0,0,42,2172,0,0,10,0,0,2,0,0,-1,0,0,0,312,0,0,0,0,0
1557,SplithoofHold,Bastion du Sabot fendu,1,400,690,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1577,TheCapeofStranglethorn,Le cap Strangleronce,0,33,691,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1578,SouthernSavageCoast,Côte sauvage du sud,0,33,692,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1579,UnusedTheDeadmines002,Unused The Deadmines 002,0,0,693,0,0,0,2172,0,0,0,0,0,2,0,0,-1,0,0,0,64,0,0,0,0,0
1580,UnusedIroncladCove003,Unused Ironclad Cove 003,36,1579,694,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1581,TheDeadmines,Les Mortemines,36,0,695,76,0,53,2172,204,0,0,0,0,2,0,0,-1,0,0,0,0,0,0,0,0,0
1582,IroncladCove,Crique du cuirassé,36,1581,696,76,0,53,2172,204,0,0,181,0,2,0,0,-1,0,0,0,1073741824,0,0,0,0,0
1583,BlackrockSpire,Pic Blackrock,0,0,697,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
1584,BlackrockDepths,Profondeurs de Blackrock,0,0,698,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
1597,RaptorGroundsUNUSED,Raptor Grounds UNUSED,1,17,699,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1598,Grol'domFarmUNUSED,Grol'dom Farm UNUSED,1,17,700,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1599,Mor'shanBaseCamp,Campement de Mor'shan,1,17,701,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1600,Honor'sStandUNUSED,Honor's Stand UNUSED,1,17,702,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1601,BlackthornRidgeUNUSED,Blackthorn Ridge UNUSED,1,17,703,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1602,BramblescarUNUSED,Bramblescar UNUSED,1,17,704,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1603,Agama'gorUNUSED,Agama'gor UNUSED,1,17,705,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1617,ValleyofHeroes,Vallée des héros,0,1519,706,0,0,43,2172,13,0,0,0,0,2,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1637,Orgrimmar,Orgrimmar,1,0,707,0,0,25,2172,7,0,10,62,0,4,0,0,-1,0,0,0,312,0,0,0,0,0
1638,ThunderBluff,Thunder Bluff,1,0,708,0,0,45,2172,226,0,10,381,0,4,0,0,-1,0,0,0,312,0,0,0,0,0
1639,ElderRise,Cime des Anciens,1,1638,709,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1640,SpiritRise,Cime des Esprits,1,1638,710,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1641,HunterRise,Cime des chasseurs,1,1638,711,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1657,Darnassus,Darnassus,1,0,712,0,0,48,2172,76,0,10,63,0,2,0,0,-1,0,0,0,312,0,0,0,0,0
1658,CenarionEnclave,Enclave cénarienne,1,1657,713,0,0,0,2172,0,0,0,103,0,2,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1659,Craftsmen'sTerrace,Terrasse des Artisans,1,1657,714,0,0,0,2172,0,0,0,0,0,2,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1660,Warrior'sTerrace,Terrasse des Guerriers,1,1657,715,0,0,0,2172,0,0,0,0,0,2,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1661,TheTempleGardens,Les Jardins du temple,1,1657,716,0,0,0,2172,0,0,0,0,0,2,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1662,Tradesmen'sTerrace,Terrasse des Marchands,1,1657,717,0,0,0,2172,0,0,0,0,0,2,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1677,Gavin'sNaze,Promontoire de Gavin,0,36,718,0,0,0,2172,0,0,33,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1678,Sofera'sNaze,Promontoire de Sofera,0,36,719,0,0,0,2172,0,0,33,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1679,Corrahn'sDagger,Dague de Corrahn,0,36,720,0,0,0,2172,0,0,33,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1680,TheHeadland,L'Avancée,0,36,721,0,0,0,2172,0,0,34,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1681,MistyShore,Rivage brumeux,0,36,722,0,0,0,2172,0,0,31,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1682,Dandred'sFold,Clos de Dandred,0,36,723,0,0,0,2172,0,0,39,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1683,GrowlessCave,Caverne stérile,0,36,724,0,0,37,2172,10,0,34,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1684,ChillwindPoint,Pointe du Noroît,0,36,725,0,0,0,2172,0,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1697,RaptorGrounds,Terres des Raptors,1,17,726,0,0,0,2172,0,0,18,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1698,Bramblescar,Ronceplaie,1,17,727,0,0,0,2172,0,0,20,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1699,ThornHill,Colline des épines,1,17,728,0,0,0,2172,0,0,13,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1700,Agama'gor,Agama'gor,1,17,729,0,0,0,2172,0,0,19,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1701,BlackthornRidge,Crête de Noirépine,1,17,730,0,0,0,2172,0,0,20,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1702,Honor'sStand,Le lieu de l'Honneur,1,17,731,0,0,0,2172,0,0,18,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1703,TheMor'shanRampart,Le Rempart de Mor'shan,1,17,732,0,0,0,2172,0,0,17,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1704,Grol'domFarm,Ferme de Grol'dom,1,17,733,0,0,0,2172,0,0,11,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1717,RazorfenKraul,Kraal de Tranchebauge,1,17,734,0,0,0,2172,0,0,24,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1718,TheGreatLift,La Grande élévation,1,17,735,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1737,MistvaleValley,Valbrume,0,33,736,0,0,0,2172,0,0,40,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1738,Nek'maniWellspring,Fontaine des Nek'mani,0,33,737,0,0,0,2172,0,0,43,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1739,BloodsailCompound,Base de la Voile sanglante,0,33,738,0,0,0,2172,0,0,42,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1740,VentureCo.BaseCamp,Campement de la KapitalRisk,0,33,739,0,0,0,2172,0,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1741,GurubashiArena,Arène des Gurubashi,0,33,740,0,0,0,2172,0,0,43,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1742,SpiritDen,Antre des esprits,0,33,741,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1757,TheCrimsonVeil,Le Voile cramoisi,0,33,742,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1758,TheRiptide,Le Courant,0,33,743,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1759,TheDamsel'sLuck,La Chance de la demoiselle,0,33,744,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1760,VentureCo.OperationsCenter,Centre d'opérations de la KapitalRisk,0,33,745,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1761,DeadwoodVillage,Village des Mort-bois,1,361,746,0,0,0,2172,194,0,47,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1762,FelpawVillage,Village de Gangrepatte,1,361,747,0,0,0,2172,194,0,54,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1763,Jaedenar,Jaedenar,1,361,748,0,0,0,2172,193,0,51,161,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1764,BloodvenomRiver,La Vénéneuse,1,361,749,0,0,0,2172,193,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1765,BloodvenomFalls,Chutes de la Vénéneuse,1,361,750,0,0,0,2172,193,0,52,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1766,ShatterScarVale,Val Grêlé,1,361,751,0,0,0,2172,0,0,53,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1767,IrontreeWoods,Bois d'Arbrefer,1,361,752,0,0,0,2172,0,0,53,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1768,IrontreeCavern,Caverne d'Arbrefer,1,361,753,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1769,TimbermawHold,Repaire des Grumegueules,1,361,754,0,0,0,2172,0,0,54,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1770,ShadowHold,Fort des ombres,1,361,755,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1771,ShrineoftheDeceiver,Sanctuaire du Trompeur,1,361,756,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1777,Itharius'sCave,Caverne d'Itharius,0,8,757,0,0,0,2172,0,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1778,Sorrowmurk,Noirchagrin,0,8,758,0,0,0,2172,0,0,41,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1779,Draenil'durVillage,Village de Draenil'dur,0,8,759,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1780,SplinterspearJunction,Croisement de Lance-brisée,0,8,760,0,0,0,2172,0,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1797,Stagalbog,Stagalbog,0,8,761,0,0,0,2172,0,0,41,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1798,TheShiftingMire,Le Bourbier changeant,0,8,762,0,0,0,2172,0,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1817,StagalbogCave,Caverne de Stagalbog,0,8,763,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1837,WitherbarkCaverns,Cavernes Witherbark,0,45,764,0,0,0,2172,3,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1857,Thoradin'sWall,Mur de Thoradin,0,45,765,0,0,0,2172,0,0,32,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1858,Boulder'gor,Boulder'gor,0,45,766,0,0,0,2172,0,0,32,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1877,ValleyofFangs,Vallée des crocs,0,3,767,0,0,0,2172,0,0,42,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1878,TehDustbowl,Vallée de la poussière,0,3,768,0,0,0,2172,0,0,39,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1879,MirageFlats,Vallée des mirages,0,3,769,0,0,0,2172,0,0,40,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1880,Featherbeard'sHovel,Taudis de Featherbeard,0,47,770,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1881,Shindigger'sCamp,Camp de Shindigger,0,47,771,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1882,PlaguemistRavine,Ravin de Pestebrume,0,47,772,0,0,0,2172,0,0,45,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1883,ValorwindLake,Lac Vent-vaillant,0,47,773,0,0,0,2172,0,0,48,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1884,Agol'watha,Agol'watha,0,47,774,0,0,0,2172,0,0,46,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1885,Hiri'watha,Hiri'watha,0,47,775,0,0,0,2172,0,0,42,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1886,TheCreepingRuin,La Ruine aux rampants,0,47,776,0,0,0,2172,0,0,47,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1887,Bogen'sLedge,Escarpement de Bogen,0,47,777,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1897,TheMaker'sTerrace,La Terrasse des faiseurs,0,3,778,0,0,0,2172,0,0,36,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1898,DustwindGulch,Goulet de la Bourrasque,0,3,779,0,0,0,2172,0,0,39,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1917,Shaol'watha,Shaol'watha,0,47,780,0,0,0,2172,0,0,49,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1937,NoonshadeRuins,Ruines d'Ombre-du-Zénith,1,440,781,0,0,0,2172,0,0,42,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1938,BrokenPillar,Pilier brisé,1,440,782,0,0,0,2172,0,0,45,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1939,AbyssalSands,Désert Abysséen,1,440,783,0,0,0,2172,0,0,45,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1940,SouthbreakShore,Rivage de Brisesud,1,440,784,0,0,0,2172,0,0,49,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1941,CavernsofTime,Grottes du temps,1,0,785,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
1942,TheMarshlands,La Fondrière,1,490,786,0,0,0,2172,0,0,48,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1943,IronstonePlateau,Plateau de Rochefer,1,490,787,0,0,0,2172,0,0,50,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1957,BlackcharCave,Caverne de Noircharbon,0,51,788,0,0,0,2172,0,0,47,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1958,TannerCamp,Camp de Tanner,0,51,789,0,0,0,2172,0,0,43,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1959,DustfireValley,Vallée des Escarbilles,0,51,790,0,0,0,2172,0,0,45,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1977,ZulGurub,Zul'Gurub,309,0,791,0,11,32,2172,3,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
1978,MistyReedPost,Poste de Brumejonc,0,8,792,0,0,0,2172,0,0,41,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1997,BloodvenomPost,Poste de la Vénéneuse,1,361,793,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
1998,TalonbranchGlade,Clairière de Griffebranche,1,361,794,0,0,0,2172,0,0,53,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2017,Stratholme,Stratholme,329,0,795,0,0,37,2172,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
2037,UNUSEDShadowfangKeep003,UNUSEDShadowfang Keep 003,0,0,796,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
2057,Scholomance,Scholomance,289,0,797,0,0,37,2172,15,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
2077,TwilightVale,Vallée du crépuscule,1,148,798,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2078,TwilightShore,Rivage du crépuscule,1,148,799,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2079,AlcazIsland,Ile d'Alcaz,1,15,800,0,0,32,2172,3,0,61,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2097,DarkcloudPinnacle,Cime de Noir-nuage,1,400,801,0,0,0,2172,226,0,26,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2098,DawningWoodCatacombs,Catacombes du Bois-de-l'Aube,0,10,802,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2099,StonewatchKeep,Donjon de Guet-de-pierre,0,44,803,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2100,Maraudon,Maraudon,349,0,804,0,0,0,2172,7,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
2101,StoutlagerInn,Auberge de la Fortebière,0,38,805,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2102,ThunderbrewDistillery,Distillerie Thunderbrew,0,1,806,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2103,MenethilKeep,Donjon de Menethil,0,11,807,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2104,DeepwaterTavern,Taverne de l'Eau-profonde,0,11,808,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2117,ShadowGrave,Tombeau des ombres,0,85,809,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2118,BrillTownHall,Hôtel de ville de Brill,0,85,810,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2119,Gallows'EndTavern,Taverne des Pendus,0,85,811,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2137,ThePoolsofVisionUNUSED,The Pools of VisionUNUSED,1,215,812,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2138,DreadmistDen,Refuge de Brume-funeste,1,17,813,0,0,0,2172,10,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2157,Bael'dunKeep,Donjon de Bael'dun,1,17,814,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2158,Emberstrife'sDen,Tanière de Brandeguerre,1,15,815,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2159,OnyxiasLair,Repaire d'Onyxia,1,0,816,0,0,33,2172,237,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
2160,WindshearMine,Mine des Cisailles,1,406,817,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2161,Roland'sDoom,Destin de Roland,0,10,818,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2177,BattleRing,L'arène,0,33,819,0,0,0,2172,0,0,0,325,0,0,0,0,-1,0,0,0,1073742032,0,0,0,0,0
2197,ThePoolsofVision,Les Bassins de la Vision,1,1638,820,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2198,ShadowbreakRavine,Ravin de Brèche-de-l'Ombre,1,405,821,0,0,0,2172,237,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2217,BrokenSpearVillage,Village de la Lance brisée,1,405,822,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2237,WhitereachPost,Poste de Blanc-relais,1,400,823,0,0,0,2172,0,0,28,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2238,Gornia,Gornia,1,400,824,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2239,Zane'sEyeCrater,Cratère de l'Oeil de Zane,1,400,825,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2240,MirageRaceway,Piste des mirages,1,400,826,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2241,FrostsaberRock,Roc des Sabres-de-Givre,1,618,827,0,0,0,2172,0,0,57,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2242,TheHiddenGrove,Le Bosquet caché,1,618,828,0,0,0,2172,0,0,58,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2243,TimbermawPost,Poste des Grumegueules,1,618,829,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2244,WinterfallVillage,Village Tombe-hiver,1,618,830,0,0,0,2172,0,0,57,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2245,Mazthoril,Mazthoril,1,618,831,0,0,0,2172,223,0,56,301,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2246,FrostfireHotSprings,Sources de Givrefeu,1,618,832,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2247,IceThistleHills,Collines des Chardons de glace,1,618,833,0,0,0,2172,0,0,56,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2248,DunMandarr,Dun Mandarr,1,618,834,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2249,FrostwhisperGorge,Gorge du Blanc murmure,1,618,835,0,0,0,2172,0,0,60,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2250,OwlWingThicket,Fourré de l'Aile de la chouette,1,618,836,0,0,0,2172,0,0,56,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2251,LakeKel'Theril,Lac Kel'Theril,1,618,837,0,0,0,2172,0,0,56,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2252,TheRuinsofKel'Theril,Les ruines de Kel'Theril,1,618,838,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2253,StarfallVillage,Pluie-d'Etoiles,1,618,839,0,0,0,2172,76,0,55,103,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2254,Ban'ThallowBarrowDen,Refuge des saisons de Ban'Thallow,1,618,840,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2255,Everlook,Long-guet,1,618,841,0,0,0,2172,235,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2256,DarkwhisperGorge,Gorge du Sombre murmure,1,618,842,0,0,37,2172,205,0,60,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2257,DeeprunTram,Tram des profondeurs,369,0,843,0,0,0,2172,0,0,0,0,0,2,0,0,-1,0,0,0,0,0,0,0,0,0
2258,TheFungalVale,La Vallée des fongus,0,139,844,0,0,0,2172,0,0,58,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2259,UNUSEDTheMarrisStead,UNUSEDThe Marris Stead,0,139,845,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2260,TheMarrisStead,La ferme des Marris,0,139,846,0,0,0,2172,0,0,54,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2261,TheUndercroft,Le caveau de Zaeldarr,0,139,847,0,0,0,2172,0,0,54,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2262,Darrowshire,Darrowshire,0,139,848,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2263,CrownGuardTower,Tour de garde de la couronne,0,139,849,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2264,Corin'sCrossing,La Croisée de Corin,0,139,850,0,0,0,2172,0,0,57,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2265,ScarletBaseCamp,Camp de la Croisade,0,139,851,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2266,Tyr'sHand,Main de Tyr,0,139,852,0,0,0,2172,193,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2267,TheScarletBasilica,La Basilique écarlate,0,139,853,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2268,Light'sHopeChapel,Chapelle de l'Espoir de Lumière,0,139,854,0,0,0,2172,0,0,58,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2269,BrowmanMill,Scierie de Browman,0,139,855,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2270,TheNoxiousGlade,La Clairière nocive,0,139,856,0,0,0,2172,0,0,58,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2271,EastwallTower,Tour du Mur d'est,0,139,857,0,0,0,2172,0,0,56,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2272,Northdale,Valnord,0,139,858,0,0,0,2172,0,0,58,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2273,Zul'Mashar,Zul'Mashar,0,139,859,0,0,0,2172,227,0,57,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2274,Mazra'Alor,Mazra'Alor,0,139,860,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2275,NorthpassTower,Tour du Col du nord,0,139,861,0,0,0,2172,0,0,56,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2276,Quel'LithienLodge,Gîte de Quel'Lithien,0,139,862,0,0,0,2172,76,0,59,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2277,Plaguewood,Pestebois,0,139,863,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2278,Scourgehold,Fort-Fléau,0,139,864,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2279,Stratholme,Stratholme,0,139,865,0,0,37,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2280,UNUSEDStratholme,UNUSED Stratholme,0,0,866,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,64,0,0,0,0,0
2297,DarrowmereLake,Lac Darrowmere,0,28,867,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2298,CaerDarrow,Caer Darrow,0,28,868,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2299,DarrowmereLake,Lac Darrowmere,0,139,869,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2300,CavernsofTime,Grottes du temps,1,440,870,0,0,0,2172,0,0,50,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2301,ThistlefurVillage,Village des Crins-de-Chardon,1,331,871,0,0,28,2172,194,0,23,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2302,TheQuagmire,Le Bourbier,1,15,872,0,0,0,2172,0,0,39,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2303,WindbreakCanyon,Canyon de Brisevent,1,400,873,0,0,0,2172,0,0,27,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2317,SouthSeas,Mers du sud,1,440,874,0,0,24,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2318,TheGreatSea,La Grande mer,1,15,875,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2319,TheGreatSea,La Grande mer,1,17,876,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2320,TheGreatSea,La Grande mer,1,14,877,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2321,TheGreatSea,La Grande mer,1,16,878,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2322,TheVeiledSea,La Mer voilée,1,141,879,0,0,0,2172,0,0,0,0,0,2,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2323,TheVeiledSea,La Mer voilée,1,357,880,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2324,TheVeiledSea,La Mer voilée,1,405,881,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2325,TheVeiledSea,La Mer voilée,1,331,882,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2326,TheVeiledSea,La Mer voilée,1,148,883,0,0,0,2172,0,0,0,0,0,2,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2337,RazorHillBarracks,Caserne de Tranchecolline,1,14,884,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2338,SouthSeas,Mers du sud,0,33,885,0,0,24,2172,0,0,0,122,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2339,TheGreatSea,La Grande mer,0,33,886,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2357,BloodtoothCamp,Camp de Dent-rouge,1,331,887,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2358,ForestSong,Chant des forêts,1,331,888,0,0,0,2172,188,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2359,Greenpaw Village,Village des Pattes-vertes,1,331,889,0,0,0,2172,0,0,24,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2360,SilverwingOutpost,Avant-poste d'Aile-argent,1,331,890,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2361,Nighthaven,Havrenuit,1,493,891,0,0,0,2172,0,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2362,ShrineofRemulos,Sanctuaire de Remulos,1,493,892,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2363,StormrageBarrowDens,Refuge des saisons de Malfurion,1,493,893,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2364,TheGreatSea,La Grande mer,0,40,894,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2365,TheGreatSea,La Grande mer,0,11,895,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2366,TheBlackMorass,Le Noir Marécage,269,0,896,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
2367,OldHillsbrad Foothills,Anciens contreforts d'Hillsbrad,269,0,897,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
2368,TarrenMill,Moulin-de-Tarren,269,2367,898,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2369,Southshore,Southshore,269,2367,899,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2370,DurnholdeKeep,Donjon de Durnholde,269,2367,900,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2371,DunGarok,Dun Garok,269,2367,901,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2372,Hillsbrad Fields,Champs d'Hillsbrad,269,2367,902,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2373,EasternStrand,Rivage oriental,269,2367,903,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2374,NethanderStead,Ferme des Nethander,269,2367,904,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2375,DarrowHill,Colline de Darrow,269,2367,905,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2376,SouthpointTower,Tour de la Pointe du Midi,269,2367,906,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2377,Thoradin'sWall,Mur de Thoradin,269,2367,907,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2378,WesternStrand,Rivage occidental,269,2367,908,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2379,AzurelodeMine,Mine d'Azurelode,269,2367,909,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2397,TheGreatSea,La Grande mer,0,267,910,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2398,TheGreatSea,La Grande mer,0,130,911,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2399,TheGreatSea,La Grande mer,0,85,912,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2400,TheForbiddingSea,La Mer interdite,0,47,913,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2401,TheForbiddingSea,La Mer interdite,0,45,914,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2402,TheForbiddingSea,La Mer interdite,0,11,915,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2403,TheForbiddingSea,La Mer interdite,0,8,916,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2404,TethrisAran,Tethris Aran,1,405,917,0,0,0,2172,0,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2405,EthelRethor,Ethel Rethor,1,405,918,0,0,0,2172,227,0,32,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2406,RanazjarIsle,Ile de Ranazjar,1,405,919,0,0,0,2172,0,0,35,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2407,Kormek'sHut,Hutte de Kormek,1,405,920,0,0,0,2172,0,0,32,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2408,ShadowpreyVillage,Proie-de-l'Ombre,1,405,921,0,0,0,2172,185,0,33,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2417,BlackrockPass,Défilé des Blackrock,0,46,922,0,0,0,2172,0,0,54,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2418,Morgan'sVigil,Veille de Morgan,0,46,923,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2419,SlitherRock,Roc sinueux,0,46,924,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2420,TerrorWingPath,Chemin de l'Aile de la terreur,0,46,925,0,0,0,2172,0,0,52,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2421,Draco'dar,Draco'dar,0,46,926,0,0,0,2172,0,0,54,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2437,Ragefire,Gouffre de Ragefeu,389,0,927,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,0,0,0,0,0,0
2457,NightsongWoods,Bois de Chantenuit,1,331,928,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2477,TheVeiledSea,La Mer voilée,1,1377,929,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2478,Morlos'Aran,Morlos'Aran,1,361,930,0,0,0,2172,0,0,47,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2479,EmeraldSanctuary,Sanctuaire d'émeraude,1,361,931,0,0,0,2172,0,0,48,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2480,JadefireGlen,Vallon des Jadefeu,1,361,932,0,0,0,2172,0,0,50,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2481,RuinsofConstellas,Ruines de Constellas,1,361,933,0,0,0,2172,0,0,51,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2497,BitterReaches,Confins amers,1,16,934,0,0,0,2172,0,0,53,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2517,RiseoftheDefiler,Cime du Souilleur,0,4,935,0,0,0,2172,0,0,46,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2518,LarissPavilion,Pavillon de Lariss,1,357,936,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2519,WoodpawHills,Collines des Griffebois,1,357,937,0,0,0,2172,0,0,41,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2520,WoodpawDen,Tanière des Griffebois,1,357,938,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2521,VerdantisRiver,La Verdantis,1,357,939,0,0,0,2172,0,0,-1,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2522,RuinsofIsildien,Ruines d'Isildien,1,357,940,0,0,0,2172,0,0,45,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2537,GrimtotemPost,Poste Totem sinistre,1,406,941,0,0,0,2172,226,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2538,CampAparaje,Camp Aparaje,1,406,942,0,0,0,2172,226,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2539,Malaka'jin,Malaka'jin,1,406,943,0,0,0,2172,185,0,15,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2540,BoulderslideRavine,Ravin des Eboulis,1,406,944,0,0,0,2172,0,0,16,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2541,SishirCanyon,Canyon de Sishir,1,406,945,0,0,0,2172,229,0,18,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2557,DireMaul,Hache-tripes,429,0,946,0,0,29,2172,11,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
2558,DeadwindRavine,Ravin de Deuillevent,0,41,947,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2559,DiamondheadRiver,Rivière Diamondhead,0,41,948,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2560,Ariden'sCamp,Camp d'Ariden,0,41,949,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2561,TheVice,L'Etau,0,41,950,0,0,0,2172,0,0,57,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2562,Karazhan,Karazhan,0,41,951,0,0,0,2172,0,0,60,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2563,Morgan'sPlot,Le lopin de Morgan,0,41,952,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2577,DireMaul,Hache-tripes,1,357,953,0,0,29,2172,11,0,44,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2597,AlteracValley,Vallée d'Alterac,30,0,954,0,0,42,2172,242,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
2617,Scrabblescrew'sCamp,Camp de Scrabblescrew,1,405,955,0,0,0,2172,226,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2618,JadefireRun,Défilé des Jadefeu,1,361,956,0,0,0,2172,0,0,50,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2619,ThondrorilRiver,La Thondroril,0,139,957,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2620,ThondrorilRiver,La Thondroril,0,28,958,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2621,LakeMereldar,Lac Mereldar,0,139,959,0,0,0,2172,0,0,54,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2622,PestilentScar,Balafre pestilentielle,0,139,960,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2623,TheInfectisScar,La Balafre infecte,0,139,961,0,0,0,2172,0,0,59,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2624,BlackwoodLake,Lac de Noirbois,0,139,962,0,0,0,2172,0,0,58,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2625,EastwallGate,Porte du Mur d'est,0,139,963,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2626,TerrorwebTunnel,Tunnel de Tisse-terreur,0,139,964,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2627,Terrordale,Val-Terreur,0,139,965,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2637,KargathiaKeep,Donjon de Kargathia,1,331,966,0,0,28,2172,228,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2657,ValleyofBones,Vallée des ossements,1,405,967,0,0,0,2172,193,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2677,BlackwingLair,Repaire de l'Aile noire,469,0,968,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
2697,Deadman'sCrossing,Croisée de l'homme mort,0,41,969,0,0,0,2172,0,0,50,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2717,MoltenCore,Cœur du Magma,409,0,970,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
2737,TheScarabWall,Le Mur du scarabée,1,1377,971,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2738,Southwind Village,Village de Sudevent,1,1377,972,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2739,TwilightBaseCamp,Campement du crépuscule,1,1377,973,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2740,TheCrystalVale,La Vallée des cristaux,1,1377,974,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2741,TheScarabDais,L'Estrade du scarabée,1,1377,975,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2742,Hive'Ashi,Ruche'Ashi,1,1377,976,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2743,Hive'Zora,Ruche'Zora,1,1377,977,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2744,Hive'Regal,Ruche'Regal,1,1377,978,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2757,Shrineofthefallenwarrior,Autel du Guerrier mort,1,17,979,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2777,AlteracValley,UNUSED Alterac Valley,0,267,980,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2797,BlackfathomDeeps,Profondeurs de Brassenoire,1,331,981,0,0,24,2172,176,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2817,***On Map Dungeon***,***On Map Dungeon***,30,0,1157,3,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,68,0,0,0,0,0
2837,TheMaster'sCellar,La cave du maître,1,41,982,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2838,StonewroughtPass,Passage de Formepierre,0,51,983,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2839,AlteracValley,Vallée d'Alterac,0,36,984,0,0,38,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2857,TheRumbleCage,La Cage des grondements,1,440,985,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741952,0,0,0,0,0
2877,ChunkTest,Test de Chunk,451,22,986,0,0,0,2172,0,0,60,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2897,Zoram'garOutpost,Avant-poste de Zoram'gar,1,331,987,0,0,24,2172,185,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2917,HallofLegends,Hall des Légendes,450,0,988,0,0,0,2172,0,0,0,0,0,4,0,0,-1,0,0,0,32,0,0,0,0,0
2918,Champions'Hall,Hall des Champions,449,0,989,0,0,0,2172,0,0,0,0,0,2,0,0,-1,0,0,0,32,0,0,0,0,0
2937,Grosh'gokCompound,Base des Grosh'gok,0,41,990,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2938,SleepingGorge,Gorge endormie,0,41,991,0,0,0,2172,0,0,50,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
2957,IrondeepMine,Mine de Gouffrefer,30,2597,992,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2958,StonehearthOutpost,Avant-poste de Stonehearth,30,2597,993,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2959,DunBaldar,Dun Baldar,30,2597,994,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2960,IcewingPass,Défilé de l'Aile de glace,30,2597,995,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2961,FrostwolfVillage,Village Frostwolf,30,2597,996,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2962,TowerPoint,Tour de la halte,30,2597,997,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2963,ColdtoothMine,Mine de Froide-dent,30,2597,998,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2964,WinteraxHold,Repaire des Winterax,30,2597,999,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2977,IcebloodGarrison,Garnison de Glace-sang,30,2597,1000,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2978,FrostwolfKeep,Donjon Frostwolf,30,2597,1001,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
2979,Tor'krenFarm,Ferme de Tor'kren,1,14,1002,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3017,FrostDaggerPass,Défilé de la Dague de givre,30,2597,1003,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3037,IronstoneCamp,Camp Rochefer,1,400,1004,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3038,Weazel'sCrater,Cratère de Weazel,1,400,1005,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3039,TahondaRuins,Ruines de Tahonda,1,400,1006,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3057,FieldofStrife,Champ sanglant,30,2597,1007,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3058,IcewingCavern,Caverne de l'Aile de glace,30,2597,1008,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3077,Valor'sRest,Le repos des vaillants,1,1377,1009,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3097,TheSwarmingPillar,Le pilier grouillant,1,1377,1010,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3098,TwilightPost,Poste du Crépuscule,1,1377,1011,0,0,0,2172,0,0,57,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3099,TwilightOutpost,Avant-poste du Crépuscule,1,1377,1012,0,0,0,2172,0,0,59,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3100,RavagedTwilightCamp,Camp du Crépuscule ravagé,1,1377,1013,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3117,Shalzaru'sLair,Antre de Shalzaru,1,357,1014,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3137,TalrendisPoint,Halte de Talrendis,1,16,1015,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3138,RethressSanctum,Sanctuaire de Rethress,1,16,1016,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3139,MoonHorrorDen,Antre de l'Horreur lunaire,1,618,1017,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3140,Scalebeard'sCave,Caverne de Barbe-d'écailles,1,16,1018,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3157,BoulderslideCavern,Caverne des Eboulis,1,406,1019,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3177,WarsongLaborCamp,Camp de travail Warsong,1,331,1020,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3197,ChillwindCamp,Camp du Noroît,0,28,1021,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3217,TheMaul,L'Etripoir,1,2557,1022,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741952,0,0,0,0,0
3237,TheMaulUNUSED,The Maul UNUSED,1,2557,1023,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741952,0,0,0,0,0
3257,BonesofGrakkarond,Restes de Grakkarond,1,1377,1024,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3277,WarsongGulch,Goulet des Warsong,489,0,1025,0,0,38,2172,243,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
3297,FrostwolfGraveyard,Cimetière Frostwolf,30,2597,1026,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3298,FrostwolfPass,Col Frostwolf,30,2597,1027,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3299,DunBaldarPass,Col de Dun Baldar,30,2597,1028,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3300,IcebloodGraveyard,Cimetière de Glace-sang,30,2597,1029,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3301,SnowfallGraveyard,Cimetière des neiges,30,2597,1030,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3302,StonehearthGraveyard,Cimetière de Stonehearth,30,2597,1031,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3303,StormpikeGraveyard,Cimetière Stormpike,30,2597,1032,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3304,IcewingBunker,Fortin de l'Aile de glace,30,2597,1033,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3305,StonehearthBunker,Fortin de Stoneheartth,30,2597,1034,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3306,WildpawRidge,Crête des Follepattes,30,2597,1035,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3317,RevantuskVillage,Village des Revantusk,0,47,1036,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3318,RockofDurotan,Rocher de Durotan,30,2597,1037,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3319,SilverwingGrove,Bosquet d'Aile-argent,1,331,1038,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3320,WarsongLumberMill,Scierie des Warsong,489,3277,1039,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3321,SilverwingHold,Fort d'Aile-argent,489,3277,1040,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3337,WildpawCavern,Caverne des Follepattes,30,2597,1041,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3338,TheVeiledCleft,La Faille voilée,30,2597,1042,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3357,YojambaIsle,Ile de Yojamba,0,33,1043,0,0,0,2172,245,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3358,ArathiBasin,Bassin d'Arathi,529,0,1044,0,11,37,2172,219,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
3377,TheCoil,L'Anneau,309,1977,1045,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3378,AltarofHir'eek,Autel d'Hir'eek,309,1977,1046,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3379,Shadra'zaar,Shadra'zaar,309,1977,1047,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3380,HakkariGrounds,Terres hakkari,309,1977,1048,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3381,NazeofShirvallah,Promontoire de Shirvallah,309,1977,1049,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3382,TempleofBethekk,Temple de Bethekk,309,1977,1050,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3383,TheBloodfirePit,Fosse du Sang igné,309,1977,1051,0,0,0,2172,245,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3384,AltaroftheBloodGod,Autel du Dieu sanglant,309,1977,1052,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3397,Zanza'sRise,Cime de Zanza,309,1977,1053,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3398,EdgeofMadness,Frontière de la folie,309,1977,1054,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3417,TrollbaneHall,Salle de Trollbane,529,3358,1055,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3418,Defiler'sDen,L'antre des Profanateurs,529,3358,1056,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3419,Pagle'sPointe,Pointe de Pagle,309,1977,1057,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3420,Farm,Ferme,529,3358,1058,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3421,Blacksmith,Forge,529,3358,1059,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3422,LumberMill,Scierie,529,3358,1060,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3423,GoldMine,Mine d'or,529,3358,1061,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3424,Stables,Ecuries,529,3358,1062,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3425,CenarionHold,Fort cénarien,1,1377,1063,0,0,0,2172,0,0,55,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3426,StaghelmPoint,Halte de Staghelm,1,1377,1064,0,0,0,2172,0,0,59,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3427,BronzebeardEncampment,Campement de Bronzebeard,1,1377,1065,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3428,AhnQiraj,Ahn'Qiraj,531,0,1161,0,0,352,2172,248,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
3429,RuinsofAhnQiraj,Ruines d'Ahn'Qiraj,509,0,1162,0,0,352,2172,248,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
3446,TwilightsRun,Défilé du Crépuscule,1,1377,1163,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3447,Ortell'sHideout,La planque d'Ortell,1,1377,1164,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3448,ScarabTerrace,Terrasse du scarabée,509,3429,1068,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3449,General'sTerrace,Terrasse du général,509,3429,1069,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3450,TheReservoir,Le réservoir,509,3429,1070,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3451,TheHatchery,La chambre des œufs,509,3429,1071,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3452,TheComb,Les rayons,509,3429,1072,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3453,Watchers'Terrace,Terrasse des guetteurs,509,3429,1073,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741824,0,0,0,0,0
3454,RuinsofAhn'Qiraj,Ruines d'Ahn'Qiraj,1,1377,1074,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
3456,Naxxrammas,Naxxramas,533,0,1158,0,0,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,3,0,0,0,0,21
3459,CityChannel,Capitales,0,0,1160,3,11,0,2172,0,0,0,0,0,0,0,0,-1,0,0,0,512,0,0,0,0,0
3478,GatesofAhn'Qiraj,Portes d'Ahn'Qiraj,1,0,1159,0,0,38,2172,176,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
3486,RavenholdtManor,Manoir de Ravenholdt,0,36,1076,0,0,0,2172,0,0,30,0,0,0,0,0,-1,0,0,0,1073741888,0,0,0,0,0
13649,TestDungeon,Test Dungeon,13,0,12255,0,0,0,0,0,0,0,0,0,0,0,3,-1,0,0,0,64,0,0,0,0,0
]]

-- Exported from https://wow.tools/dbc/?dbc=taxinodes&build=1.14.1.41030&locale=frFR
local taxiNodesCSV = [[
Name_lang,Pos[0],Pos[1],Pos[2],MapOffset[0],MapOffset[1],FlightMapOffset[0],FlightMapOffset[1],ID,ContinentID,ConditionID,CharacterBitNumber,Flags,UiTextureKitID,Facing,SpecialIconConditionID,VisibilityConditionID,MountCreatureID[0],MountCreatureID[1]
Abbaye de Northshire,-8888.98,-0.54,94.39,0,0,0,0,1,0,0,1,0,0,0,0,0,308,0
"Stormwind, Elwynn",-8840.56,489.7,109.61,0,0,0,0,2,0,0,2,1,0,0,0,0,0,541
Ile des programmeurs,16391.81,16341.21,69.44,0,0,0,0,3,0,0,3,0,0,0,0,0,308,0
"Colline des sentinelles, marche de l'Ouest",-10628.89,1036.68,34.06,0,0,0,0,4,0,0,4,1,0,0,0,0,0,541
"Lakeshire, les Carmines",-9429.1,-2231.4,68.65,0,0,0,0,5,0,0,5,1,0,0,0,0,0,541
"Ironforge, Dun Morogh",-4821.78,-1155.44,502.21,0,0,0,0,6,0,0,6,1,0,0,0,0,0,541
"Port de Menethil, les Paluns",-3792.26,-783.29,9.06,0,0,0,0,7,0,0,7,1,0,0,0,0,0,541
"Thelsamar, Loch Modan",-5421.91,-2930.01,347.25,0,0,0,0,8,0,0,8,1,0,0,0,0,0,541
"Baie-du-Butin, Strangleronce",-14271.77,299.87,31.09,0,0,0,0,9,0,0,9,0,0,0,0,0,0,541
"Le Sépulcre, forêt des Pins argentés",478.86,1536.59,131.32,0,0,0,0,10,0,0,10,2,0,0,0,0,3574,0
"Undercity, Tirisfal",1568.62,267.97,-43.1,0,0,0,0,11,0,0,11,2,0,0,0,0,3574,0
"Darkshire, bois de la Pénombre",-10515.46,-1261.65,41.34,0,0,0,0,12,0,0,12,1,0,0,0,0,0,541
"Moulin-de-Tarren, Hillsbrad",-0.06,-859.91,58.83,0,0,0,0,13,0,0,13,2,0,0,0,0,3574,0
"Southshore, Hillsbrad",-711.48,-515.48,26.11,0,0,0,0,14,0,0,14,1,0,0,0,0,0,541
Maleterres de l'est,2253.4,-5344.9,83.38,0,0,0,0,15,0,0,15,0,0,0,0,0,0,541
"Refuge de l'Ornière, Arathi",-1240.53,-2515.11,22.16,0,0,0,0,16,0,0,16,1,0,0,0,0,0,541
"Trépas-d'Orgrim, Arathi",-916.29,-3496.89,70.45,0,0,0,0,17,0,0,17,2,0,0,0,0,2224,0
"Baie-du-Butin, Strangleronce",-14444.29,509.62,26.2,0,0,0,0,18,0,0,18,2,0,0,0,0,2224,0
"Baie-du-Butin, Strangleronce",-14473.05,464.15,36.43,0,0,0,0,19,0,0,19,1,0,0,0,0,0,541
"Grom'gol, Strangleronce",-12414.18,146.29,3.28,0,0,0,0,20,0,0,20,2,0,0,0,0,2224,0
"Kargath, Terres ingrates",-6633.99,-2180.05,244.14,0,0,0,0,21,0,0,21,2,0,0,0,0,2224,0
"Thunder Bluff, Mulgore",-1197.21,29.71,176.95,0,0,0,0,22,1,0,22,2,0,0,0,0,2224,0
"Orgrimmar, Durotar",1677.59,-4315.71,61.17,0,0,0,0,23,1,0,23,2,0,0,0,0,2224,0
"Générique, Cible monde pour les voies des zeppelins",-6666,-2222.3,278.6,0,0,0,0,24,0,0,24,0,0,0,0,0,0,0
"La Croisée, Tarides",-441.8,-2596.08,96.06,0,0,0,0,25,1,0,25,2,0,0,0,0,2224,0
"Auberdine, Sombrivage",6341.38,557.68,16.29,0,0,0,0,26,1,0,26,1,0,0,0,0,0,3837
"Rut'theran, Teldrassil",8643.59,841.05,23.3,0,0,0,0,27,1,0,27,1,0,0,0,0,0,3837
"Astranaar, Ashenvale",2827.34,-289.24,107.16,0,0,0,0,28,1,0,28,1,0,0,0,0,0,3837
"Retraite de Roche-Soleil, Serres-Rocheuses",966.57,1040.32,104.27,0,0,0,0,29,1,0,29,2,0,0,0,0,2224,0
"Poste de Librevent, Mille Pointes",-5407.71,-2414.3,90.32,0,0,0,0,30,1,0,30,2,0,0,0,0,2224,0
"Thalanaar, Feralas",-4491.88,-775.89,-39.52,0,0,0,0,31,1,0,31,1,0,0,0,0,0,3837
"Theramore, marécage d'Âprefange",-3825.37,-4516.58,10.44,0,0,0,0,32,1,0,32,1,0,0,0,0,0,541
"Pic des Serres-Rocheuses, Serres-Rocheuses",2681.13,1461.68,232.88,0,0,0,0,33,1,0,33,1,0,0,0,0,0,3837
"Transport, Ratchet - Baie-du-Butin",-1965.17,-5824.29,-1.06,0,0,0,0,34,1,0,34,0,0,0,0,0,0,0
"Transport, zeppelins d'Orgrimmar",1320.07,-4649.2,21.57,0,0,0,0,35,1,0,35,0,0,0,0,0,0,0
"Générique, cible monde",-8644.62,433.28,59.46,0,0,0,0,36,0,0,36,0,0,0,0,0,15665,0
"Combe de Nijel, Désolace",139.24,1325.82,193.5,0,0,0,0,37,1,0,37,1,0,0,0,0,0,3837
"Proie-de-l'Ombre, Désolace",-1767.64,3263.89,4.94,0,0,0,0,38,1,0,38,2,0,0,0,0,2224,0
"Gadgetzan, Tanaris",-7223.97,-3734.59,8.39,0,0,0,0,39,1,0,39,1,0,0,0,0,0,541
"Gadgetzan, Tanaris",-7048.89,-3780.36,10.19,0,0,0,0,40,1,0,40,2,0,0,0,0,2224,0
"Feathermoon, Feralas",-4373.8,3338.65,12.27,0,0,0,0,41,1,0,41,1,0,0,0,0,0,3837
"Camp Mojache, Feralas",-4419.86,199.31,25.06,0,0,0,0,42,1,0,42,2,0,0,0,0,2224,0
"Nid-de-l'Aigle, Les Hinterlands",283.74,-2002.76,194.74,0,0,0,0,43,0,0,43,1,0,0,0,0,0,541
"Valormok, Azshara",3661.52,-4390.38,113.05,0,0,0,0,44,1,0,44,2,0,0,0,0,2224,0
"Rempart-du-Néant, Terres foudroyées",-11112.25,-3435.74,79.09,0,0,0,0,45,0,0,45,1,0,0,0,0,0,541
"Bac de Southshore, Hillsbrad",-986.43,-547.86,-3.86,0,0,0,0,46,0,0,46,0,0,0,0,0,0,0
"Transport, Grom'gol - Orgrimmar",-12418.77,235.43,1.12,0,0,0,0,47,0,0,47,0,0,0,0,0,0,0
"Poste de la Vénéneuse, Gangrebois",5068.4,-337.22,367.41,0,0,0,0,48,1,0,48,2,0,0,0,0,2224,0
Reflet-de-Lune,7458.45,-2487.21,462.33,0,0,0,0,49,1,0,49,1,0,0,0,0,0,3837
"Transport, vaisseaux de Menethil",0,0,0,0,0,0,0,50,0,0,50,0,0,0,0,0,0,0
"Transport, Rut'theran - Auberdine",0,0,0,0,0,0,0,51,0,0,51,0,0,0,0,0,0,0
"Long-guet, Berceau-de-l'Hiver",6799.24,-4742.44,701.5,0,0,0,0,52,1,0,52,1,0,0,0,0,0,3837
"Long-guet, Berceau-de-l'Hiver",6813.06,-4611.12,710.67,0,0,0,0,53,1,0,53,2,0,0,0,0,2224,0
"Transport, Feathermoon - Feralas",-4203.87,3284,-12.86,0,0,0,0,54,1,0,54,0,0,0,0,0,0,0
"Mur-de-Fougères, marécage d'Âprefange",-3147.39,-2842.18,34.61,0,0,0,0,55,1,0,55,2,0,0,0,0,2224,0
"Stonard, marais des Chagrins",-10456.97,-3279.25,21.35,0,0,0,0,56,0,0,56,2,0,0,0,0,2224,0
"Village de pêcheurs, Teldrassil",8701.51,991.37,14.21,0,0,0,0,57,1,0,57,0,0,0,0,0,0,3837
"Avant-poste de Zoram'gar, Ashenvale",3374.71,996.97,5.19,0,0,0,0,58,1,0,58,2,0,0,0,0,2224,0
"Dun Baldar, Vallée d'Alterac",574.21,-46.65,37.61,0,0,0,0,59,30,0,59,1,0,0,0,0,0,541
"Donjon Frostwolf, Vallée d'Alterac",-1335.44,-319.69,90.66,0,0,0,0,60,30,0,60,2,0,0,0,0,3574,0
"Poste de Bois-brisé, Ashenvale",2302.39,-2524.55,104.4,0,0,0,0,61,1,0,61,2,0,0,0,0,2224,0
"Havrenuit, Reflet-de-Lune",7793.61,-2403.47,489.32,0,0,0,0,62,1,0,62,1,0,0,0,0,0,3837
"Havrenuit, Reflet-de-Lune",7787.72,-2404.1,489.56,0,0,0,0,63,1,0,63,2,0,0,0,0,2224,0
"Halte de Talrendis, Azshara",2721.99,-3880.64,100.87,0,0,0,0,64,1,0,64,1,0,0,0,0,0,3837
"Clairière de Griffebranche, Gangrebois",6205.88,-1949.63,571.29,0,0,0,0,65,1,0,65,1,0,0,0,0,0,3837
"Camp du Noroît, Maleterres de l'ouest",931.32,-1430.11,64.67,0,0,0,0,66,0,0,66,1,0,0,0,0,0,541
"Chapelle de l'Espoir de Lumière, Maleterres de l'est",2271.09,-5340.8,87.11,0,0,0,0,67,0,0,67,1,0,0,0,0,0,541
"Chapelle de l'Espoir de Lumière, Maleterres de l'est",2327.41,-5286.89,81.78,0,0,0,0,68,0,0,68,2,0,0,0,0,3574,0
Reflet-de-Lune,7470.39,-2123.38,492.34,0,0,0,0,69,1,0,69,2,0,0,0,0,2224,0
"Corniches des flammes, Steppes ardentes",-7504.03,-2187.54,165.53,0,0,0,0,70,0,0,70,2,0,0,0,0,2224,0
"Veille de Morgan, Steppes ardentes",-8364.61,-2738.35,185.46,0,0,0,0,71,0,0,71,1,0,0,0,0,0,541
"Fort cénarien, Silithus",-6811.39,836.74,49.81,0,0,0,0,72,1,0,72,2,0,0,0,0,2224,0
"Fort cénarien, Silithus",-6761.83,772.03,88.91,0,0,0,0,73,1,0,73,1,0,0,0,0,0,3837
"Halte du Thorium, Gorge des Vents brûlants",-6552.59,-1168.27,309.31,0,0,0,0,74,0,0,74,1,0,0,0,0,0,541
"Halte du Thorium, Gorge des Vents brûlants",-6554.93,-1100.05,309.57,0,0,0,0,75,0,0,75,2,0,0,0,0,2224,0
"Village des Revantusk, les Hinterlands",-635.26,-4720.5,5.38,0,0,0,0,76,0,0,76,2,0,0,0,0,2224,0
"Camp Taurajo, les Tarides",-2380.67,-1882.67,95.85,0,0,0,0,77,1,0,77,2,0,0,0,0,2224,0
Naxxramas,3133.31,-3399.93,139.53,0,0,0,0,78,0,0,78,0,0,0,0,0,0,0
"Refuge des Marshal, cratère d'Un'Goro",-6113.82,-1142.7,-187.63,0,0,0,0,79,1,0,79,3,0,0,0,0,2224,541
"Ratchet, les Tarides",-894.59,-3773.01,11.48,0,0,0,0,80,1,0,80,3,0,0,0,0,2224,541
"Tour de Pestebois, Maleterres de l'est",2998.71,-3050.1,117.19,0,0,0,0,84,0,0,84,3,0,0,0,0,17660,17660
"Tour du Col du nord, Maleterres de l'est",3109.31,-4285.13,109.45,0,0,0,0,85,0,0,85,3,0,0,0,0,3574,541
"Tour du Mur d'est, Maleterres de l'est",2499.23,-4742.85,93.5,0,0,0,0,86,0,0,86,3,0,0,0,0,3574,541
"Tour de garde de la couronne, Maleterres de l'est",1857.56,-3658.47,143.73,0,0,0,0,87,0,0,87,3,0,0,0,0,3574,541
]]

L.areaTable = addon.LoadCSVData(areaTableCSV, "ID")
L.taxiNodes = addon.LoadCSVData(taxiNodesCSV, "ID")
