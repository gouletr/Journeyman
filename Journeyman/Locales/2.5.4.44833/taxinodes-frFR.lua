local addonName, addon = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "frFR")
if not L then return end

local taxiNodesCSV = [[
Name_lang,Pos[0],Pos[1],Pos[2],MapOffset[0],MapOffset[1],FlightMapOffset[0],FlightMapOffset[1],ID,ContinentID,ConditionID,CharacterBitNumber,Flags,UiTextureKitID,Facing,SpecialIconConditionID,VisibilityConditionID,MountCreatureID[0],MountCreatureID[1]
Abbaye de Comté-du-nord,-8888.98,-0.54,94.39,0,0,0,0,1,0,0,1,0,0,0,0,0,308,0
"Hurlevent, Elwynn",-8840.56,489.7,109.61,0,0,0,0,2,0,0,2,1,0,0,0,0,0,541
Ile des programmeurs,16391.81,16341.21,69.44,0,0,0,0,3,0,0,3,0,0,0,0,0,308,0
"Colline des sentinelles, marche de l'Ouest",-10629.29,1036.95,34.02,0,0,0,0,4,0,0,4,1,0,0,0,0,0,541
"Comté-du-lac, les Carmines",-9429.1,-2231.4,68.65,0,0,0,0,5,0,0,5,1,0,0,0,0,0,541
"Forgefer, Dun Morogh",-4821.78,-1155.44,502.21,0,0,0,0,6,0,0,6,1,0,0,0,0,0,541
"Port de Menethil, Paluns",-3792.26,-783.29,9.06,0,0,0,0,7,0,0,7,1,0,0,0,0,0,541
"Thelsamar, Loch Modan",-5421.91,-2930.01,347.25,0,0,0,0,8,0,0,8,1,0,0,0,0,0,541
"Baie-du-Butin, Strangleronce",-14271.77,299.87,31.09,0,0,0,0,9,0,0,9,0,0,0,0,0,0,541
"Le Sépulcre, forêt des Pins argentés",478.86,1536.59,131.32,0,0,0,0,10,0,0,10,2,0,0,0,0,3574,0
"Fossoyeuse, Tirisfal",1568.62,267.97,-43.1,0,0,0,0,11,0,0,11,2,0,0,0,0,3574,0
"Sombre-comté, bois de la Pénombre",-10515.46,-1261.65,41.34,0,0,0,0,12,0,0,12,1,0,0,0,0,0,541
"Moulin-de-Tarren, Hautebrande",-0.06,-859.91,58.83,0,0,0,0,13,0,0,13,2,0,0,0,0,3574,0
"Austrivage, Hautebrande",-711.48,-515.48,26.11,0,0,0,0,14,0,0,14,1,0,0,0,0,0,541
Maleterres de l'est,2253.4,-5344.9,83.38,0,0,0,0,15,0,0,15,0,0,0,0,0,0,541
"Refuge de l'Ornière, Arathi",-1240.53,-2515.11,22.16,0,0,0,0,16,0,0,16,1,0,0,0,0,0,541
"Trépas-d'Orgrim, Arathi",-916.29,-3496.89,70.45,0,0,0,0,17,0,0,17,2,0,0,0,0,2224,0
"Baie-du-Butin, Strangleronce",-14444.29,509.62,26.2,0,0,0,0,18,0,0,18,2,0,0,0,0,2224,0
"Baie-du-Butin, Strangleronce",-14473.05,464.15,36.43,0,0,0,0,19,0,0,19,1,0,0,0,0,0,541
"Grom'gol, Strangleronce",-12414.18,146.29,3.28,0,0,0,0,20,0,0,20,2,0,0,0,0,2224,0
"Kargath, Terres ingrates",-6633.99,-2180.05,244.14,0,0,0,0,21,0,0,21,2,0,0,0,0,2224,0
"Les Pitons du Tonnerre, Mulgore",-1197.21,29.71,176.95,0,0,0,0,22,1,0,22,2,0,0,0,0,2224,0
"Orgrimmar, Durotar",1677.59,-4315.71,61.17,0,0,0,0,23,1,0,23,2,0,0,0,0,2224,0
"Générique, cible monde 002",-6666,-2222.3,278.6,0,0,0,0,24,0,0,24,0,0,0,0,0,0,0
"La Croisée, Tarides",-441.8,-2596.08,96.06,0,0,0,0,25,1,0,25,2,0,0,0,0,2224,0
"Auberdine, Sombrivage",6341.38,557.68,16.29,0,0,0,0,26,1,0,26,1,0,0,0,0,0,3837
"Rut'theran, Teldrassil",8643.59,841.05,23.3,0,0,0,0,27,1,0,27,1,0,0,0,0,0,3837
"Astranaar, Orneval",2827.34,-289.24,107.16,0,0,0,0,28,1,0,28,1,0,0,0,0,0,3837
"Retraite de Roche-Soleil, Serres-Rocheuses",966.57,1040.32,104.27,0,0,0,0,29,1,0,29,2,0,0,0,0,2224,0
"Poste de Librevent, Mille Pointes",-5407.71,-2414.3,90.32,0,0,0,0,30,1,0,30,2,0,0,0,0,2224,0
"Thalanaar, Féralas",-4491.88,-775.89,-39.52,0,0,0,0,31,1,0,31,1,0,0,0,0,0,3837
"Theramore, marécage d'Âprefange",-3825.37,-4516.58,10.44,0,0,0,0,32,1,0,32,1,0,0,0,0,0,541
"Pic des Serres-Rocheuses, Serres-Rocheuses",2681.13,1461.68,232.88,0,0,0,0,33,1,0,33,1,0,0,0,0,0,3837
"Transport, Baie-du-Butin",-1965.17,-5824.29,-1.06,0,0,0,0,34,1,0,34,0,0,0,0,0,0,0
"Transport, Orgrimmar",1320.07,-4649.2,21.57,0,0,0,0,35,1,0,35,0,0,0,0,0,0,0
"Générique, cible monde 001",-8644.62,433.28,59.46,0,0,0,0,36,0,0,36,0,0,0,0,0,15665,0
"Combe de Nijel, Désolace",139.24,1325.82,193.5,0,0,0,0,37,1,0,37,1,0,0,0,0,0,3837
"Proie-de-l'Ombre, Désolace",-1767.64,3263.89,4.94,0,0,0,0,38,1,0,38,2,0,0,0,0,2224,0
"Gadgetzan, Tanaris",-7223.97,-3734.59,8.39,0,0,0,0,39,1,0,39,1,0,0,0,0,0,541
"Gadgetzan, Tanaris",-7048.89,-3780.36,10.19,0,0,0,0,40,1,0,40,2,0,0,0,0,2224,0
"Pennelune, Féralas",-4373.8,3338.65,12.27,0,0,0,0,41,1,0,41,1,0,0,0,0,0,3837
"Camp Mojache, Féralas",-4419.86,199.31,25.06,0,0,0,0,42,1,0,42,2,0,0,0,0,2224,0
"Nid-de-l'Aigle, Les Hinterlands",283.74,-2002.76,194.74,0,0,0,0,43,0,0,43,1,0,0,0,0,0,541
"Valormok, Azshara",3661.52,-4390.38,113.05,0,0,0,0,44,1,0,44,2,0,0,0,0,2224,0
"Rempart-du-Néant, Terres foudroyées",-11112.25,-3435.74,79.09,0,0,0,0,45,0,0,45,1,0,0,0,0,0,541
"Transport, Austrivage",-986.43,-547.86,-3.86,0,0,0,0,46,0,0,46,0,0,0,0,0,0,0
"Transport, Grom'gol",-12418.77,235.43,1.12,0,0,0,0,47,0,0,47,0,0,0,0,0,0,0
"Poste de la Vénéneuse, Gangrebois",5068.4,-337.22,367.41,0,0,0,0,48,1,0,48,2,0,0,0,0,2224,0
Reflet-de-Lune,7458.45,-2487.21,462.33,0,0,0,0,49,1,0,49,1,0,0,0,0,0,3837
"Transport, port de Menethil",0,0,0,0,0,0,0,50,0,0,50,0,0,0,0,0,0,0
"Transport, Auberdine",0,0,0,0,0,0,0,51,0,0,51,0,0,0,0,0,0,0
"Long-guet, Berceau-de-l'Hiver",6796.8,-4742.39,701.5,0,0,0,0,52,1,0,52,1,0,0,0,0,0,3837
"Long-guet, Berceau-de-l'Hiver",6813.06,-4611.12,710.67,0,0,0,0,53,1,0,53,2,0,0,0,0,2224,0
"Transport, Pennelune",-4203.87,3284,-12.86,0,0,0,0,54,1,0,54,0,0,0,0,0,0,0
"Mur-de-Fougères, marécage d'Âprefange",-3147.39,-2842.18,34.61,0,0,0,0,55,1,0,55,2,0,0,0,0,2224,0
"Pierrêche, marais des Chagrins",-10456.97,-3279.25,21.35,0,0,0,0,56,0,0,56,2,0,0,0,0,2224,0
"Village de pêcheurs, Teldrassil",8701.51,991.37,14.21,0,0,0,0,57,1,0,57,0,0,0,0,0,0,3837
"Avant-poste de Zoram'gar, Orneval",3374.71,996.97,5.19,0,0,0,0,58,1,0,58,2,0,0,0,0,2224,0
"Dun Baldar, Vallée d'Alterac",574.21,-46.65,37.61,0,0,0,0,59,30,0,59,1,0,0,0,0,0,541
"Donjon Loup-de-givre, Vallée d'Alterac",-1335.44,-319.69,90.66,0,0,0,0,60,30,0,60,2,0,0,0,0,3574,0
"Poste de Bois-brisé, Orneval",2302.39,-2524.55,104.4,0,0,0,0,61,1,0,61,2,0,0,0,0,2224,0
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
"Village des Vengebroches, les Hinterlands",-635.26,-4720.5,5.38,0,0,0,0,76,0,0,76,2,0,0,0,0,2224,0
"Camp Taurajo, les Tarides",-2380.67,-1882.67,95.85,0,0,0,0,77,1,0,77,2,0,0,0,0,2224,0
Naxxramas,3133.31,-3399.93,139.53,0,0,0,0,78,0,0,78,0,0,0,0,0,0,0
"Refuge des Marshal, cratère d'Un'Goro",-6113.82,-1142.7,-187.63,0,0,0,0,79,1,0,79,3,0,0,0,0,2224,541
"Cabestan, les Tarides",-894.59,-3773.01,11.48,0,0,0,0,80,1,0,80,3,0,0,0,0,2224,541
Lune-d'argent,9375.24,-7165.89,9.03,0,0,0,0,82,530,0,82,2,0,0,0,0,19917,0
"Tranquillien, Terres fantômes",7594.47,-6784.29,86.46,0,0,0,0,83,530,0,83,2,0,0,0,0,19917,0
"Tour de Pestebois, Maleterres de l'est",2998.71,-3050.1,117.19,0,0,0,0,84,0,0,84,3,0,0,0,0,16081,16081
"Tour du Col du nord, Maleterres de l'est",3109.31,-4285.13,109.45,0,0,0,0,85,0,0,85,3,0,0,0,0,3574,541
"Tour du Mur d'est, Maleterres de l'est",2499.23,-4742.85,93.5,0,0,0,0,86,0,0,86,3,0,0,0,0,3574,541
"Tour de garde de la couronne, Maleterres de l'est",1857.56,-3658.47,143.73,0,0,0,0,87,0,0,87,3,0,0,0,0,3574,541
"Transport, Exodar",-4284.01,-11194.74,13.01,0,0,0,0,88,530,0,88,0,0,0,0,0,0,0
"Transport, Theramore",0,0,0,0,0,0,0,89,0,0,89,0,0,0,0,0,0,0
"Transport, Fossoyeuse",0,0,0,0,0,0,0,90,9770568,0,90,0,0,0,0,0,0,0
Quête - chaman Brume-azur cible,-3996.01,-11892.97,0.22,0,0,0,0,91,530,0,91,0,0,0,0,0,0,0
Quête - chaman Brume-azur début,-3679.31,-11413.04,310.57,0,0,0,0,92,530,0,92,0,0,0,0,0,0,0
"Guet du sang, île de Brume-sang",-1933.27,-11954.61,57.19,0,0,0,0,93,530,0,93,1,0,0,0,0,0,3837
L'Exodar,-4054.89,-11793.35,9.05,0,0,0,0,94,530,0,94,1,0,0,0,0,0,3837
Marécage de Zangar - Quête - A vol d'oiseau,-146.29,5532.56,30.89,0,0,0,0,95,530,0,95,2,0,0,0,0,17972,0
Marécage de Zangar - Quête - A vol d'oiseau - fin,-145.23,5533.03,30.95,0,0,0,0,96,530,0,96,0,0,0,0,0,0,0
Quête - Chemin de l'elekk vers Kessel,-3968.37,-11929.15,-1.22,0,0,0,0,97,530,0,97,1,0,0,0,0,0,18167
Quête - Elekk vers la cible de Kessel,-2662.3,-12144.6,16.91,0,0,0,0,98,530,0,98,0,0,0,0,0,0,0
"Thrallmar, péninsule des Flammes infernales",228.5,2633.57,87.67,0,0,0,0,99,530,0,99,2,0,0,0,0,2224,0
"Bastion de l'Honneur, péninsule des Flammes infernales",-673.42,2717.27,94.18,0,0,0,0,100,530,0,100,1,0,0,0,0,0,541
"Temple de Telhamat, péninsule des Flammes infernales",199.16,4241.56,121.75,0,0,0,0,101,530,0,101,1,0,0,0,0,0,3837
"Guet de l'épervier, péninsule des Flammes infernales",-587.41,4101.01,91.37,0,0,0,0,102,530,0,102,2,0,0,0,0,2224,0
Nagrand - JcJ - Trajet offensif Départ 1,-1810.16,8032.11,-25.95,0,0,0,0,103,530,0,103,3,0,0,0,0,18345,18345
Nagrand - JcJ - Trajet offensif Arrivée 1,-1824.18,8049.29,-26.85,0,0,0,0,104,530,0,104,3,0,0,0,0,13161,13161
Nagrand - JcJ - Trajet offensif Départ 2,-1513.4,8140.93,-19.6,0,0,0,0,105,530,0,105,3,0,0,0,0,18345,18345
Nagrand - JcJ - Trajet offensif Arrivée 2,-1511.26,8149.71,-18.58,0,0,0,0,106,530,0,106,1,0,0,0,0,541,541
Nagrand - JcJ - Trajet offensif Départ 3,-1387.07,7782.41,-11.47,0,0,0,0,107,530,0,107,3,0,0,0,0,18345,18345
Nagrand - JcJ - Trajet offensif Arrivée 3,-1376.72,7771.17,-10.08,0,0,0,0,108,530,0,108,1,0,0,0,0,541,541
Nagrand - JcJ - Trajet offensif Départ 4,-1656.6,7724.91,-15.59,0,0,0,0,109,530,0,109,3,0,0,0,0,18345,18345
Nagrand - JcJ - Trajet offensif Arrivée 4,-1658.9,7724.71,-15.79,0,0,0,0,110,530,0,110,1,0,0,0,0,541,541
Téléporteur Chants éternels - Ternesoir,9335.83,-7883.07,74.91,0,0,0,0,111,530,0,111,3,0,0,0,0,18392,18392
Arrivée du téléporteur Chants éternels - Ternesoir,9335.67,-7809.71,136.57,0,0,0,0,112,530,0,112,3,0,0,0,0,17972,17972
Quête - Néanstradamus départ,-1544.36,8792.07,35.22,0,0,0,0,113,530,0,113,3,0,0,0,0,18543,18543
Quête - Néanstradamus arrivée cible,-1544.36,8792.09,35.22,0,0,0,0,114,530,0,114,0,0,0,0,0,0,0
Quête - Grottes du temps - VH - Début,2384.73,1169.38,66.86,0,0,0,0,115,560,0,115,3,0,0,0,0,18768,18768
Quête - Grottes du temps - VH - Fin,2014.65,239.65,68.52,0,0,0,0,116,560,0,116,0,0,0,0,0,0,0
"Telredor, marécage de Zangar",213.75,6063.75,148.31,0,0,0,0,117,530,0,117,1,0,0,0,0,0,3837
"Zabra'jin, marécage de Zangar",219.45,7816,22.72,0,0,0,0,118,530,0,118,2,0,0,0,0,2224,2224
"Telaar, Nagrand",-2729,7305.3,88.64,0,0,0,0,119,530,0,119,1,0,0,0,0,0,3837
"Garadar, Nagrand",-1261.09,7133.39,57.34,0,0,0,0,120,530,0,120,2,0,0,0,0,2224,0
"Bastion allérien, forêt de Terokkar",-2987.24,3872.78,9.13,0,0,0,0,121,530,0,121,1,0,0,0,0,0,541
"Zone 52, Raz-de-Néant",3082.31,3596.11,144.02,0,0,0,0,122,530,0,122,3,0,0,0,0,2224,541
"Village d'Ombrelune, Vallée d'Ombrelune",-3018.62,2557.09,79.09,0,0,0,0,123,530,0,123,2,0,0,0,0,2224,0
"Bastion des Marteaux-hardis, Vallée d'Ombrelune",-3982.07,2156.47,105.15,0,0,0,0,124,530,0,124,1,0,0,0,0,0,541
"Sylvanaar, les Tranchantes",2183.65,6794.46,183.28,0,0,0,0,125,530,0,125,1,0,0,0,0,0,3837
"Bastion des Sire-tonnerre, les Tranchantes",2446.37,6020.93,154.34,0,0,0,0,126,530,0,126,2,0,0,0,0,2224,0
"Fort des Brise-pierres, Forêt de Terokkar",-2567.33,4423.83,39.33,0,0,0,0,127,530,0,127,2,0,0,0,0,2224,0
"Shattrath, Forêt de Terokkar",-1837.23,5301.9,-12.43,0,0,0,0,128,530,0,128,3,0,0,0,0,2224,541
"Péninsule des Flammes infernales, Porte des ténèbres, Alliance",-327.35,1020.49,54.25,0,0,0,0,129,530,0,129,1,0,0,0,0,0,541
"Péninsule des Flammes infernales, Porte des ténèbres, Horde",-178.09,1026.72,54.19,0,0,0,0,130,530,0,130,2,0,0,0,0,2224,0
"Quête - Péninsule des Fl. infernales (Horde), début",-25.51,2133.45,112.6,0,0,0,0,131,530,0,131,3,0,0,0,0,19275,18376
"Quête - Péninsule des Fl. infernales (Horde), fin",-25.6,2133.4,112.58,0,0,0,0,132,530,0,132,2,0,0,0,0,19275,0
"Quête - Péninsule des Fl. infernales (route de l'Alliance), début",-673.73,1855.29,68.97,0,0,0,0,133,530,0,133,3,0,0,0,0,19324,19324
"Quête - Péninsule des Fl. infernales (Alliance), fin",-673.75,1855.32,68.96,0,0,0,0,134,530,0,134,3,0,0,0,0,19324,19324
"Quête - Fl. infernales, mission aérienne (Horde) début",-27.65,2126.57,111.85,0,0,0,0,135,530,0,135,3,0,0,0,0,19275,19324
"Quête - Fl. infernales, mission aérienne (Alliance) fin",-27.52,2126.5,111.88,0,0,0,0,136,530,0,136,3,0,0,0,0,19275,19324
"Quête - Fl. infernales, mission aérienne (Alliance) début",298.5,1501.26,-14.28,0,0,0,0,137,530,0,137,3,0,0,0,0,19275,19324
"Quête - Fl. infernales, mission aérienne (Alliance) fin",298.59,1501.13,-14.25,0,0,0,0,138,530,0,138,3,0,0,0,0,19275,19324
"La Foudreflèche, Raz-de-Néant",4157.58,2959.69,352.08,0,0,0,0,139,530,0,139,3,0,0,0,0,2224,541
"Autel de Sha'tar, vallée d'Ombrelune",-3065.6,749.42,-10.1,0,0,0,0,140,530,6211,140,3,0,0,0,0,2224,541
"Crête Brise-échine, péninsule des Flammes infernales",-1316.84,2358.62,88.96,0,0,0,0,141,530,0,141,2,0,0,0,0,2224,0
Péninsule des Flammes infernales - Trépas du saccageur,-29.16,2125.72,111.47,0,0,0,0,142,530,0,142,2,0,0,0,0,2224,0
Quête - Grottes du temps (Trajet aérien d'introduction) (fin),-8360.73,-4327.73,-208.33,0,0,0,0,143,1,0,143,3,0,0,0,0,16081,16081
Quête - Grottes du temps (Trajet aérien d'introduction) (début),-8162.01,-4796.23,35.78,0,0,0,0,144,1,0,144,3,0,0,0,0,18768,18768
Quête - Raz-de-Néant - Vol camouflé - Début,3079.01,3599.08,144.07,0,0,0,0,145,530,0,145,2,0,0,0,0,2224,0
Quête - Raz-de-Néant - Vol camouflé - Fin,2235.34,2793.77,128.03,0,0,0,0,146,530,0,146,0,0,0,0,0,0,0
"Péninsule des Flammes infernales, Tête de pont du Camp Force",509.17,1988.69,109.62,0,0,0,0,147,530,0,147,1,0,0,0,0,0,19324
"Halte du Fracas, péninsule des Flammes infernales (Débarquement)",298.46,1501.18,-14.28,0,0,0,0,148,530,0,148,1,0,0,0,0,0,19324
"Halte du Fracas, péninsule des Flammes infernales",276.2,1486.91,-15.1,0,0,0,0,149,530,0,149,1,0,0,0,0,0,541
"Cosmovrille, Raz-de-Néant",2974.95,1848.24,141.28,0,0,0,0,150,530,0,150,3,0,0,0,0,2224,541
"Poste du Rat des marais, marécage de Zangar",91.67,5214.92,23.1,0,0,0,0,151,530,0,151,2,0,0,0,0,2224,0
Quête - Raz-de-Néant - Manaforge Ultris (départ),4262.39,2136.92,139.44,0,0,0,0,152,530,0,152,3,0,0,0,0,20903,20903
Quête - Raz-de-Néant - Manaforge Ultris (arrivée),4266.7,2133.38,138.82,0,0,0,0,153,530,0,153,3,0,0,0,0,20903,20903
Quête - Raz-de-Néant - Manaforge Ultris (seconde passe) départ,20047.88,5200.69,19742.78,0,0,0,0,154,530,0,154,3,0,0,0,0,20903,20903
Quête - Raz-de-Néant - Manaforge Ultris (seconde passe) arrivée,4267.14,2133.03,138.77,0,0,0,0,155,530,0,155,0,0,0,0,0,0,0
"Poste de Toshley, les Tranchantes",1857.35,5531.87,277.01,0,0,0,0,156,530,0,156,1,0,0,0,0,0,541
Quête - Tranchantes - Guide de vision - début,2277.74,5983.35,142.6,0,0,0,0,157,530,0,157,2,0,0,0,0,21396,0
Quête - Tranchantes - Guide de vision - fin,2278.56,5983.71,142.57,0,0,0,0,158,530,0,158,0,0,0,0,0,0,0
"Sanctum des étoiles, vallée d'Ombrelune",-4073.17,1123.61,42.47,0,0,0,0,159,530,6212,159,3,0,0,0,0,2224,541
"Bosquet éternel, les Tranchantes",2976.01,5501.13,143.67,0,0,0,0,160,530,0,160,3,0,0,0,0,2224,541
Quête - Allié dragon du Néant - début,0,0,0,0,0,0,0,161,654135852,0,161,0,0,0,0,0,22360,22360
Quête - Allié dragon du Néant - fin,-4100.27,950.38,22.11,0,0,0,0,162,530,0,162,0,0,0,0,0,0,0
"Mok'Nathal, les Tranchantes",2028.79,4705.27,150.51,0,0,0,0,163,530,0,163,2,0,0,0,0,2224,0
"Havre d'Orebor, Marécage de Zangar",966.67,7399.16,29.14,0,0,0,0,164,530,0,164,1,0,0,0,0,3837,3837
"Sanctuaire d'émeraude, Gangrebois",3978.74,-1316.42,250.11,0,0,0,0,166,1,0,166,3,0,0,0,0,2224,3837
"Chant des forêts, Orneval",3000.25,-3202.41,189.77,0,0,0,0,167,1,0,167,1,0,0,0,0,0,3837
On filme,2999.97,-3202.14,189.73,0,0,0,0,168,1,0,168,0,0,0,0,0,0,3837
Quête - Escarpement de l'Aile-du-Néant - Trajet en chariot de mine - Sud - Départ,-5224.53,631.85,48.36,0,0,0,0,169,530,0,169,3,0,0,0,0,23372,23372
Quête - Escarpement de l'Aile-du-Néant - Trajet en chariot de mine - Sud - Fin,-5185.71,172.95,-11.57,0,0,0,0,170,530,0,170,0,0,0,0,0,23289,23289
Skettis,-3364.68,3650.18,284.78,0,0,0,0,171,530,0,171,3,0,0,0,0,23422,23422
Ogri'La,2531.1,7322.09,373.64,0,0,0,0,172,530,0,172,0,0,0,0,0,23422,23422
Quête - Vol de Yarzill départ,-5141.36,620.11,82.7,0,0,0,0,173,530,0,173,0,0,0,0,0,23468,23468
Quête - Vol de Yarzill arrivée,-1636.09,5275.87,-41.1,0,0,0,0,174,530,0,174,0,0,0,0,0,0,0
"Bourbe-à-brac, marécage d'Âprefange",-4566.23,-3226.05,34.7,0,0,0,0,179,1,0,179,3,0,0,0,0,2224,541
Quête - Âprefange - Obs. d'Alcaz (début),-3822.66,-4511.33,10.84,0,0,0,0,180,1,0,180,0,0,0,0,0,0,541
Quête - Âprefange - Obs. d'Alcaz (fin),-3822.71,-4509.65,10.98,0,0,0,0,181,1,0,181,0,0,0,0,0,0,541
"Camp rebelle, vallée de Strangleronce",-11343.97,-216.83,75.22,0,0,0,0,195,0,0,195,1,0,0,0,0,0,541
Test SP2,2066.8,-4999.82,251.28,0,0,0,0,197,1,0,197,0,0,0,0,0,0,0
Test SP1,1340.02,-4631.29,54.41,0,0,0,0,198,1,0,198,0,0,0,0,0,24489,541
Terrain en développement - Kyle Radue départ,15992.44,-16371.94,76.73,0,0,0,0,201,451,0,201,3,0,0,0,0,23468,23468
Terrain en développement - Kyle Radue fin,15991.68,-16371.95,76.7,0,0,0,0,202,451,0,202,0,0,0,0,0,0,0
"Zul'Aman, Terres fantômes",6789.79,-7747.58,126.51,0,0,0,0,205,530,0,205,3,0,0,0,0,3574,541
"Transport, Pennelune (bateau EN)",-4348.01,2427.29,6.64,0,0,0,0,206,1,0,206,0,0,0,0,0,0,0
Quête - Puits de soleil journalière - Bombarder la Malebrèche - Départ,13008.38,-6911.81,9.58,0,0,0,0,209,530,0,209,2,0,0,0,0,25044,0
Quête - Puits de soleil journalière - Bombarder la Malebrèche - Arrivée,13008.51,-6912.2,9.58,0,0,0,0,210,530,0,210,0,0,0,0,0,25044,0
Quête - Puits de soleil journalière - Bombardement de navire - Départ,13007.5,-6911.81,9.58,0,0,0,0,211,530,0,211,2,0,0,0,0,25044,0
Quête - Puits de soleil journalière - Bombardement de navire - Arrivée,13188.04,-7047.04,4.79,0,0,0,0,212,530,0,212,2,0,0,0,0,25044,0
Zone de rassemblement du Soleil brisé,13012.7,-6908.37,9.58,0,0,0,0,213,530,96423,213,11,0,0,0,0,19917,19917
,3051.76,3690.41,142.63,0,0,0,0,220,530,0,220,0,0,0,0,0,5403,0
]]

L.taxiNodes = addon.LoadCSVData(taxiNodesCSV, "ID")
