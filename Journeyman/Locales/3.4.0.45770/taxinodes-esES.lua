local addonName, addon = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "esES")
if not L then return end

local taxiNodesCSV = [[
Name_lang,Pos[0],Pos[1],Pos[2],MapOffset[0],MapOffset[1],FlightMapOffset[0],FlightMapOffset[1],ID,ContinentID,ConditionID,CharacterBitNumber,Flags,UiTextureKitID,Facing,SpecialIconConditionID,VisibilityConditionID,MountCreatureID[0],MountCreatureID[1]
Abadía de Villanorte,-8888.98,-0.54,94.39,0,0,0,0,1,0,0,1,0,0,0,0,0,308,0
"Ventormenta, Elwynn",-8840.56,489.7,109.61,0,0,0,0,2,0,0,2,1,0,0,0,0,0,541
Isla del programador,16391.81,16341.21,69.44,0,0,0,0,3,0,0,3,0,0,0,0,0,308,0
"Colina del Centinela, Páramos de Poniente",-10629.29,1036.95,34.02,0,0,0,0,4,0,0,4,1,0,0,0,0,0,541
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
"Genérico, Objetivo mundial 002",-6666,-2222.3,278.6,0,0,0,0,24,0,0,24,0,0,0,0,0,0,0
"El Cruce, Los Baldíos",-441.8,-2596.08,96.06,0,0,0,0,25,1,0,25,2,0,0,0,0,2224,0
"Auberdine, Costa Oscura",6341.38,557.68,16.29,0,0,0,0,26,1,0,26,1,0,0,0,0,0,3837
"Aldea Rut'theran, Teldrassil",8643.59,841.05,23.3,0,0,0,0,27,1,0,27,1,0,0,0,0,0,3837
"Astranaar, Vallefresno",2827.34,-289.24,107.16,0,0,0,0,28,1,0,28,1,0,0,0,0,0,3837
"Refugio Roca del Sol, Sierra Espolón",966.57,1040.32,104.27,0,0,0,0,29,1,0,29,2,0,0,0,0,2224,0
"Poblado Viento Libre, Las Mil Agujas",-5407.71,-2414.3,90.32,0,0,0,0,30,1,0,30,2,0,0,0,0,2224,0
"Thalanaar, Feralas",-4491.88,-775.89,-39.52,0,0,0,0,31,1,0,31,1,0,0,0,0,0,3837
"Theramore, Marjal Revolcafango",-3825.37,-4516.58,10.44,0,0,0,0,32,1,0,32,1,0,0,0,0,0,541
"Cima del Espolón, Sierra Espolón",2681.13,1461.68,232.88,0,0,0,0,33,1,0,33,1,0,0,0,0,0,3837
"Transporte, Bahía del Botín",-1965.17,-5824.29,-1.06,0,0,0,0,34,1,0,34,0,0,0,0,0,0,0
"Transporte, Orgrimmar",1320.07,-4649.2,21.57,0,0,0,0,35,1,0,35,0,0,0,0,0,0,0
"Genérico, Objetivo mundial 001",-8644.62,433.28,59.46,0,0,0,0,36,0,0,36,2,0,0,0,0,15665,0
"Punta de Nijel, Desolace",139.24,1325.82,193.5,0,0,0,0,37,1,0,37,1,0,0,0,0,0,3837
"Aldea Cazasombras, Desolace",-1767.64,3263.89,4.94,0,0,0,0,38,1,0,38,2,0,0,0,0,2224,0
"Gadgetzan, Tanaris",-7223.97,-3734.59,8.39,0,0,0,0,39,1,0,39,1,0,0,0,0,0,541
"Gadgetzan, Tanaris",-7048.89,-3780.36,10.19,0,0,0,0,40,1,0,40,2,0,0,0,0,2224,0
"Plumaluna, Feralas",-4373.8,3338.65,12.27,0,0,0,0,41,1,0,41,1,0,0,0,0,0,3837
"Campamento Mojache, Feralas",-4419.86,199.31,25.06,0,0,0,0,42,1,0,42,2,0,0,0,0,2224,0
"Pico Nidal, Tierras del Interior",283.74,-2002.76,194.74,0,0,0,0,43,0,0,43,1,0,0,0,0,0,541
"Valormok, Azshara",3661.52,-4390.38,113.05,0,0,0,0,44,1,0,44,2,0,0,0,0,2224,0
"Castillo de Nethergarde, Las Tierras Devastadas",-11112.25,-3435.74,79.09,0,0,0,0,45,0,0,45,1,0,0,0,0,0,541
"Transporte, Costasur",-986.43,-547.86,-3.86,0,0,0,0,46,0,0,46,0,0,0,0,0,0,0
"Transporte, Grom'gol",-12418.77,235.43,1.12,0,0,0,0,47,0,0,47,0,0,0,0,0,0,0
Puesto del Veneno,5068.4,-337.22,367.41,0,0,0,0,48,1,0,48,2,0,0,0,0,2224,0
Claro de la Luna,7458.45,-2487.21,462.33,0,0,0,0,49,1,0,49,1,0,0,0,0,0,3837
"Transporte, Puerto de Menethil",0,0,0,0,0,0,0,50,0,0,50,0,0,0,0,0,0,0
"Transporte, Auberdine",0,0,0,0,0,0,0,51,0,0,51,0,0,0,0,0,0,0
"Vista Eterna, Cuna del Invierno",6796.8,-4742.39,701.5,0,0,0,0,52,1,0,52,1,0,0,0,0,0,3837
"Vista Eterna, Cuna del Invierno",6813.06,-4611.12,710.67,0,0,0,0,53,1,0,53,2,0,0,0,0,2224,0
"Transporte, Plumaluna",-4203.87,3284,-12.86,0,0,0,0,54,1,0,54,0,0,0,0,0,0,0
"Poblado Murohelecho, Marjal Revolcafango",-3147.39,-2842.18,34.61,0,0,0,0,55,1,0,55,2,0,0,0,0,2224,0
"Rocal, Pantano de las Penas",-10456.97,-3279.25,21.35,0,0,0,0,56,0,0,56,2,0,0,0,0,2224,0
"Aldea Pesquera, Teldrassil",8701.51,991.37,14.21,0,0,0,0,57,1,0,57,0,0,0,0,0,0,3837
"Avanzada de Zoram'gar, Vallefresno",3374.71,996.97,5.19,0,0,0,0,58,1,0,58,2,0,0,0,0,2224,0
"Dun Baldar, Valle de Alterac",574.21,-46.65,37.61,0,0,0,0,59,30,0,59,0,0,0,0,0,0,541
"Bastión Lobo Gélido, Valle de Alterac",-1335.44,-319.69,90.66,0,0,0,0,60,30,0,60,0,0,0,0,0,3574,0
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
Ciudad de Lunargenta,9375.24,-7165.89,9.03,0,0,0,0,82,530,0,82,2,0,0,0,0,19917,0
"Tranquilien, Tierras Fantasma",7594.47,-6784.29,86.46,0,0,0,0,83,530,0,83,2,0,0,0,0,19917,0
"Torre del Bosque de la Peste, Tierras de la Peste de Este",2998.71,-3050.1,117.19,0,0,0,0,84,0,0,84,3,0,0,0,0,32942,32942
"Torre del Paso Norte, Tierras de la Peste del Este",3109.31,-4285.13,109.45,0,0,0,0,85,0,0,85,3,0,0,0,0,3574,541
"Torre de la Muralla del Este, Tierras de la Peste del Este",2499.23,-4742.85,93.5,0,0,0,0,86,0,0,86,3,0,0,0,0,3574,541
"Torre de la Corona, Tierras de la Peste del Este",1857.56,-3658.47,143.73,0,0,0,0,87,0,0,87,3,0,0,0,0,3574,541
"Transporte, El Exodar",-4284.01,-11194.74,13.01,0,0,0,0,88,530,0,88,0,0,0,0,0,0,0
"Transporte, Theramore",0,0,0,0,0,0,0,89,0,0,89,0,0,0,0,0,0,0
"Transporte, Entrañas",0,0,0,0,0,0,0,90,9770568,0,90,0,0,0,0,0,0,0
Misión - Chamán Bruma Azur Objetivo,-3996.01,-11892.97,0.22,0,0,0,0,91,530,0,91,0,0,0,0,0,0,0
Misión - Chamán Bruma Azur Comienzo,-3679.31,-11413.04,310.57,0,0,0,0,92,530,0,92,0,0,0,0,0,0,0
"Avanzada de Sangre, Isla Bruma de Sangre",-1933.27,-11954.61,57.19,0,0,0,0,93,530,0,93,1,0,0,0,0,0,3837
El Exodar,-4054.89,-11793.35,9.05,0,0,0,0,94,530,0,94,1,0,0,0,0,0,3837
Marisma de Zangar - Misión - Mientras el cuervo vuela,-146.29,5532.56,30.89,0,0,0,0,95,530,0,95,2,0,0,0,0,17972,0
Marisma de Zangar - Misión - Mientras el cuervo vuela - Fin,-145.23,5533.03,30.95,0,0,0,0,96,530,0,96,0,0,0,0,0,0,0
Misión - El camino de Elekk a Kessel,-3968.37,-11929.15,-1.22,0,0,0,0,97,530,0,97,1,0,0,0,0,0,18167
Misión - De Elekk a Kessel Objetivo,-2662.3,-12144.6,16.91,0,0,0,0,98,530,0,98,0,0,0,0,0,0,0
"Thrallmar, Península del Fuego Infernal",228.5,2633.57,87.67,0,0,0,0,99,530,0,99,2,0,0,0,0,2224,0
"Bastión del Honor, Península del Fuego Infernal",-673.42,2717.27,94.18,0,0,0,0,100,530,0,100,1,0,0,0,0,0,541
"Templo de Telhamat, Península del Fuego Infernal",199.16,4241.56,121.75,0,0,0,0,101,530,0,101,1,0,0,0,0,0,3837
"Avanzada del Halcón, Península del Fuego Infernal",-587.41,4101.01,91.37,0,0,0,0,102,530,0,102,2,0,0,0,0,2224,0
Nagrand - JcJ - Ataque 1 Puesta en Marcha Comienzo,-1810.16,8032.11,-25.95,0,0,0,0,103,530,0,103,3,0,0,0,0,18345,18345
Nagrand - JcJ - Ataque 1 Puesta en Marcha Fin,-1824.18,8049.29,-26.85,0,0,0,0,104,530,0,104,3,0,0,0,0,13161,13161
Nagrand - JcJ - Ataque 2 Puesta en Marcha Comienzo,-1513.4,8140.93,-19.6,0,0,0,0,105,530,0,105,3,0,0,0,0,18345,18345
Nagrand - JcJ - Ataque 2 Puesta en Marcha Fin,-1511.26,8149.71,-18.58,0,0,0,0,106,530,0,106,1,0,0,0,0,541,541
Nagrand - JcJ - Ataque 3 Puesta en Marcha Comienzo,-1387.07,7782.41,-11.47,0,0,0,0,107,530,0,107,3,0,0,0,0,18345,18345
Nagrand - JcJ - Ataque 3 Puesta en Marcha Fin,-1376.72,7771.17,-10.08,0,0,0,0,108,530,0,108,1,0,0,0,0,541,541
Nagrand - JcJ - Ataque 4 Puesta en Marcha Comienzo,-1656.6,7724.91,-15.59,0,0,0,0,109,530,0,109,3,0,0,0,0,18345,18345
Nagrand - JcJ - Ataque 4 Puesta en Marcha Fin,-1658.9,7724.71,-15.79,0,0,0,0,110,530,0,110,1,0,0,0,0,541,541
"Bosque Canción Eterna, Teletransporte a Ocaso Marchito",9335.83,-7883.07,74.91,0,0,0,0,111,530,0,111,3,0,0,0,0,18392,18392
"Bosque Canción Eterna, Teletransporte a Ocaso Marchito Fin",9335.67,-7809.71,136.57,0,0,0,0,112,530,0,112,3,0,0,0,0,17972,17972
"Misión, Nethrandamus Comienzo",-1544.36,8792.07,35.22,0,0,0,0,113,530,0,113,3,0,0,0,0,18543,18543
"Misión, Nethrandamus Fin Objetivo",-1544.36,8792.09,35.22,0,0,0,0,114,530,0,114,0,0,0,0,0,0,0
"Misión, Cavernas del Tiempo OH - Comienzo",2384.73,1169.38,66.86,0,0,0,0,115,560,0,115,0,0,0,0,0,18768,18768
"Misión, Cavernas del Tiempo OH - Fin",2014.65,239.65,68.52,0,0,0,0,116,560,0,116,0,0,0,0,0,0,0
"Telredor, Marisma de Zangar",213.75,6063.75,148.31,0,0,0,0,117,530,0,117,1,0,0,0,0,0,3837
"Zabra'jin, Marisma de Zangar",219.45,7816,22.72,0,0,0,0,118,530,0,118,2,0,0,0,0,2224,2224
"Telaar, Nagrand",-2729,7305.3,88.64,0,0,0,0,119,530,0,119,1,0,0,0,0,0,3837
"Garadar, Nagrand",-1261.09,7133.39,57.34,0,0,0,0,120,530,0,120,2,0,0,0,0,2224,0
"Bastión Allerian, Bosque de Terokkar",-2987.24,3872.78,9.13,0,0,0,0,121,530,0,121,1,0,0,0,0,0,541
"Área 52, Tormenta Abisal",3082.31,3596.11,144.02,0,0,0,0,122,530,0,122,3,0,0,0,0,2224,541
"Aldea Sombraluna, Valle Sombraluna",-3018.62,2557.09,79.09,0,0,0,0,123,530,0,123,2,0,0,0,0,2224,0
"Bastión Martillo Salvaje, Valle Sombraluna",-3982.07,2156.47,105.15,0,0,0,0,124,530,0,124,1,0,0,0,0,0,541
"Sylvanaar, Montañas Filospada",2183.65,6794.46,183.28,0,0,0,0,125,530,0,125,1,0,0,0,0,0,3837
"Bastión Señor del Trueno, Montañas Filospada",2446.37,6020.93,154.34,0,0,0,0,126,530,0,126,2,0,0,0,0,2224,0
"Bastión Rompepedras, Bosque de Terokkar",-2567.33,4423.83,39.33,0,0,0,0,127,530,0,127,2,0,0,0,0,2224,0
"Shattrath, Bosque de Terokkar",-1837.23,5301.9,-12.43,0,0,0,0,128,530,0,128,3,0,0,0,0,2224,541
"Península del Fuego Infernal, El Portal Oscuro, Alianza",-327.35,1020.49,54.25,0,0,0,0,129,530,0,129,1,0,0,0,0,0,541
"Península del Fuego Infernal, El Portal Oscuro, Horda",-178.09,1026.72,54.19,0,0,0,0,130,530,0,130,2,0,0,0,0,2224,0
"Misión, Fuego Infernal Horda Comienzo",-25.51,2133.45,112.6,0,0,0,0,131,530,0,131,3,0,0,0,0,19275,18376
"Misión, Fuego Infernal Horda Fin",-25.6,2133.4,112.58,0,0,0,0,132,530,0,132,2,0,0,0,0,19275,0
"Misión, Península del Fuego Infernal (Camino Alianza) Comienzo",-673.73,1855.29,68.97,0,0,0,0,133,530,0,133,3,0,0,0,0,19324,19324
"Misión, Península del Fuego Infernal (Alianza) Fin",-673.75,1855.32,68.96,0,0,0,0,134,530,0,134,3,0,0,0,0,19324,19324
"Misión, Fuego Infernal, Misión Aérea (Horda) Comienzo",-27.65,2126.57,111.85,0,0,0,0,135,530,0,135,3,0,0,0,0,19275,19324
"Misión, Fuego Infernal, Misión Aérea (Horda) Fin",-27.52,2126.5,111.88,0,0,0,0,136,530,0,136,3,0,0,0,0,19275,19324
"Misión, Fuego Infernal, Misión Aérea (Alianza) Comienzo",298.5,1501.26,-14.28,0,0,0,0,137,530,0,137,3,0,0,0,0,19275,19324
"Misión, Fuego Infernal, Misión Aérea (Alianza) Fin",298.59,1501.13,-14.25,0,0,0,0,138,530,0,138,3,0,0,0,0,19275,19324
"La Flecha de la Tormenta, Tormenta Abisal",4157.58,2959.69,352.08,0,0,0,0,139,530,0,139,3,0,0,0,0,2224,541
"Altar de Sha'tar, Valle Sombraluna",-3065.6,749.42,-10.1,0,0,0,0,140,530,6211,140,3,0,0,0,0,2224,541
"Cresta Rompeloma, Península del Fuego Infernal",-1316.84,2358.62,88.96,0,0,0,0,141,530,0,141,2,0,0,0,0,2224,0
Península del Fuego Infernal - Caída del Atracador Vil,-29.16,2125.72,111.47,0,0,0,0,142,530,0,142,2,0,0,0,0,2224,0
Misión - Cavernas del Tiempo (Ruta de Vuelo) (Fin),-8360.73,-4327.73,-208.33,0,0,0,0,143,1,0,143,3,0,0,0,0,16081,16081
Misión - Cavernas del Tiempo (Ruta de Vuelo) (Comienzo),-8162.01,-4796.23,35.78,0,0,0,0,144,1,0,144,3,0,0,0,0,18768,18768
Misión - Tormenta Abisal - Vuelo sigilo - Comienzo,3079.01,3599.08,144.07,0,0,0,0,145,530,0,145,2,0,0,0,0,2224,0
Misión - Tormenta Abisal - Vuelo en sigilo - Fin,2235.34,2793.77,128.03,0,0,0,0,146,530,0,146,0,0,0,0,0,0,0
Península del Fuego Infernal - Force Camp Beach Head,509.17,1988.69,109.62,0,0,0,0,147,530,0,147,1,0,0,0,0,0,19324
"Puesto Devastación, Península del Fuego Infernal (Asalto a la playa)",298.46,1501.18,-14.28,0,0,0,0,148,530,0,148,1,0,0,0,0,0,19324
"Puesto Devastación, Península del Fuego Infernal",276.2,1486.91,-15.1,0,0,0,0,149,530,0,149,1,0,0,0,0,0,541
"Cosmotirón, Tormenta Abisal",2974.95,1848.24,141.28,0,0,0,0,150,530,0,150,3,0,0,0,0,2224,541
"Avanzada Rata del Pantano, Marisma de Zangar",91.67,5214.92,23.1,0,0,0,0,151,530,0,151,2,0,0,0,0,2224,0
Misión - Tormenta Abisal - Forja de Maná Ultris (Comienzo),4262.39,2136.92,139.44,0,0,0,0,152,530,0,152,3,0,0,0,0,20903,20903
Misión - Tormenta Abisal - Forja de Maná Ultris (Fin),4266.7,2133.38,138.82,0,0,0,0,153,530,0,153,3,0,0,0,0,20903,20903
Misión - Tormenta Abisal - Forja de Maná Ultris (Segundo Paso) Comienzo,20047.88,5200.69,19742.78,0,0,0,0,154,530,0,154,3,0,0,0,0,20903,20903
Misión - Tormenta Abisal - Forja de Maná Ultris (Segundo Paso) Fin,4267.14,2133.03,138.77,0,0,0,0,155,530,0,155,0,0,0,0,0,0,0
"Estación de Toshley, Montañas Filospada",1857.35,5531.87,277.01,0,0,0,0,156,530,0,156,1,0,0,0,0,0,541
Misión - Filospada - Guía de visión - Comienzo,2277.74,5983.35,142.6,0,0,0,0,157,530,0,157,2,0,0,0,0,21396,0
Misión - Filospada - Guía de visión - Fin,2278.56,5983.71,142.57,0,0,0,0,158,530,0,158,0,0,0,0,0,0,0
"Sagrario de las Estrellas, Valle Sombraluna",-4073.17,1123.61,42.47,0,0,0,0,159,530,6212,159,3,0,0,0,0,2224,541
"Soto Eterno, Montañas Filospada",2976.01,5501.13,143.67,0,0,0,0,160,530,0,160,3,0,0,0,0,2224,541
Misión - Aliado dragón abisal - Comienzo,0,0,0,0,0,0,0,161,654135852,0,161,0,0,0,0,0,22360,22360
Misión - Aliado dragón abisal - Fin,-4100.27,950.38,22.11,0,0,0,0,162,530,0,162,0,0,0,0,0,0,0
"Aldea Mok'Nathal, Montañas Filospada",2028.79,4705.27,150.51,0,0,0,0,163,530,0,163,2,0,0,0,0,2224,0
"Puerto Orebor, Marisma de Zangar",966.67,7399.16,29.14,0,0,0,0,164,530,0,164,1,0,0,0,0,3837,3837
"Transporte, Rasganorte 2",0,0,0,0,0,0,0,165,3,0,0,0,0,0,0,0,0,0
"Santuario Esmeralda, Frondavil",3978.74,-1316.42,250.11,0,0,0,0,166,1,0,166,3,0,0,0,0,2224,3837
"Canción del Bosque, Vallefresno",3000.25,-3202.41,189.77,0,0,0,0,167,1,0,167,1,0,0,0,0,0,3837
Grabando,-9441.18,65.05,56.18,0,0,0,0,168,0,0,168,1,0,0,0,0,0,3837
Misión - Arrecife del Ala Abisal - Paseo en vagoneta - Sur - Comienzo,-5224.53,631.85,48.36,0,0,0,0,169,530,0,169,3,0,0,0,0,23372,23372
Misión - Arrecife del Ala Abisal - Paseo en vagoneta - Sur - Fin,-5185.71,172.95,-11.57,0,0,0,0,170,530,0,170,3,0,0,0,0,23289,23289
Skettis,-3364.68,3650.18,284.78,0,0,0,0,171,530,0,171,3,0,0,0,0,23422,23422
Ogri'la,2531.1,7322.09,373.64,0,0,0,0,172,530,0,172,3,0,0,0,0,23422,23422
"Misión, Vuelo de Yarzill, Inicio",-5141.36,620.11,82.7,0,0,0,0,173,530,0,173,3,0,0,0,0,23468,23468
"Misión, Vuelo de Yarzill, Fin",-1636.09,5275.87,-41.1,0,0,0,0,174,530,0,174,0,0,0,0,0,0,0
"Transporte, Fiordo Aquilonal",784.89,-5066.18,-7.88,0,0,0,0,175,571,0,0,0,0,0,0,0,0,0
"Misión, Fiordo Aquilonal, Canoa tauren (Inicio)",245.36,-3309.2,0.91,0,0,0,0,176,571,0,0,3,0,0,0,0,23518,23518
"Misión, Fiordo Aquilonal, Canoa tauren (Fin)",-147.47,-3587.36,0.34,0,0,0,0,177,571,0,0,3,0,0,0,0,23518,23518
"Transporte, Tundra Boreal",0,0,0,0,0,0,0,178,3,0,0,0,0,0,0,0,0,0
"Piñón de Barro, Marjal Revolcafango",-4566.23,-3226.05,34.7,0,0,0,0,179,1,0,179,3,0,0,0,0,2224,541
"Misión, Revolcafango, Inicio de sondeo de Alcaz",-3822.66,-4511.33,10.84,0,0,0,0,180,1,0,180,1,0,0,0,0,0,541
"Misión, Revolcafango, Fin de sondeo de Alcaz",-3822.71,-4509.65,10.98,0,0,0,0,181,1,0,181,1,0,0,0,0,0,541
"Misión, Fiordo Aquilonal, Zepelín de Rompe el bloqueo",1415.89,-3082.49,121.91,0,0,0,0,182,571,0,0,0,0,0,0,0,0,0
"Puerto de Valgarde, Fiordo Aquilonal",567.41,-5010.97,11.5,0,0,0,0,183,571,0,183,1,0,0,0,0,0,541
"Fuerte Vildervar, Fiordo Aquilonal",2468.77,-5029.82,283.49,0,0,0,0,184,571,0,184,1,0,0,0,0,0,541
"Fortaleza de la Guardia Oeste, Fiordo Aquilonal",1342.84,-3287.9,174.45,0,0,0,0,185,571,0,185,1,0,0,0,0,0,541
"Misión, Fiordo Aquilonal, Vuelo a El Brisaveloz - Inicio",1911.82,-6179.07,24.61,0,0,0,0,186,571,0,0,2,0,0,0,0,3574,0
"Misión, Fiordo Aquilonal, Vuelo a El Brisaveloz - Fin",1652.83,-6512.11,18.48,0,0,0,0,187,571,0,0,2,0,0,0,0,3574,0
"Misión, Fiordo Aquilonal, Test at Sea - Inicio",1912.78,-6178.81,24.64,0,0,0,0,188,571,0,0,2,0,0,0,0,3574,0
"Misión, Fiordo Aquilonal, Test at Sea - Fin",1913.9,-6177.87,24.62,0,0,0,0,189,571,0,0,0,0,0,0,0,0,0
"Nuevo Agamand, Fiordo Aquilonal",401.12,-4544.3,244.54,0,0,0,0,190,571,0,190,2,0,0,0,0,3574,0
"Campo Venganza, Fiordo Aquilonal",1918.6,-6175.89,24.41,0,0,0,0,191,571,0,191,2,0,0,0,0,3574,0
"Campamento Pezuña Invernal, Fiordo Aquilonal",2652.89,-4392.71,283.32,0,0,0,0,192,571,0,192,2,0,0,0,0,2224,0
"Misión, Fiordo Aquilonal, Misión: Echar pestes - Fin",1341.44,-3288.57,174.45,0,0,0,0,193,571,0,0,1,0,0,0,0,0,541
"Misión, Fiordo Aquilonal, Misión: Echar pestes - Inicio",1341.08,-3288.37,174.45,0,0,0,0,194,571,0,0,1,0,0,0,0,0,541
"Asentamiento Rebelde, Vega de Tuercespina",-11343.97,-216.83,75.22,0,0,0,0,195,0,0,195,1,0,0,0,0,0,541
Test - SP,9283.1,-9749.81,62.16,0,0,0,0,196,451,0,196,0,0,0,0,0,12374,541
Test SP2,-9148.62,243.04,87.39,0,0,0,0,197,0,0,197,0,0,0,0,0,0,0
Test SP1,9405.83,-9882.69,0,0,0,0,0,198,451,0,198,0,0,0,0,0,24489,541
"Misión, Fiordo Aquilonal, McGoyver Inicio",638.34,-5074.57,-0.23,0,0,0,0,199,571,0,0,3,0,0,0,0,24716,24716
"Misión, Fiordo Aquilonal, McGoyver Fin",483.92,-5913.1,308.61,0,0,0,0,200,571,0,0,3,0,0,0,0,24716,24716
Territorio en desarrollo - Kyle Radue inicio,15992.44,-16371.94,76.73,0,0,0,0,201,451,0,201,0,0,0,0,0,23468,23468
Territorio en desarrollo - Kyle Radue Fin,15991.68,-16371.95,76.7,0,0,0,0,202,451,0,202,0,0,0,0,0,0,0
Misión - Reposo Estelar -> Hibergarde,3505.3,1990.83,65.1,0,0,0,0,203,571,0,0,1,0,0,0,0,0,27127
Misión - Nuevo Agamand -> Rencor Venenoso,0,0,0,0,0,0,0,204,12,0,0,0,0,0,0,0,27179,0
"Zul'Aman, Tierras Fantasma",6789.79,-7747.58,126.51,0,0,0,0,205,530,0,205,3,0,0,0,0,3574,541
"Transporte, Plumaluna (barco NE)",-4348.01,2427.29,6.64,0,0,0,0,206,1,0,206,0,0,0,0,0,0,0
"Misión, Fiordo Aquilonal, Hermana Misericordia (Inicio)",15.32,-4043.79,0.1,0,0,0,0,207,571,0,0,0,0,0,0,0,0,0
"Misión, Fiordo Aquilonal, Hermana Misericordia (Fin)",15.32,-4043.71,0.1,0,0,0,0,208,571,0,0,0,0,0,0,0,0,0
"Misión, diaria de Fuente del Sol, bombardeo de La Cicatriz Muerta - Inicio",13008.38,-6911.81,9.58,0,0,0,0,209,530,0,209,2,0,0,0,0,25044,0
"Misión, diaria de Fuente del Sol, bombardeo de La Cicatriz Muerta - Fin",13008.51,-6912.2,9.58,0,0,0,0,210,530,0,210,2,0,0,0,0,25044,0
"Misión, diaria de Fuente del Sol, bombardeo de barco - Inicio",13007.5,-6911.81,9.58,0,0,0,0,211,530,0,211,2,0,0,0,0,25044,0
"Misión, diaria de Fuente del Sol, bombardeo de barco - Fin",13188.04,-7047.04,4.79,0,0,0,0,212,530,0,212,2,0,0,0,0,25044,0
Zona de escala de Sol Devastado,13012.7,-6908.37,9.58,0,0,0,0,213,530,96423,213,11,0,0,0,0,19917,19917
"Misión, Fiordo Aquilonal, Naglfar (Inicio)",0,0,0,0,0,0,0,214,0,0,0,0,0,0,0,0,0,0
"Misión, Fiordo Aquilonal, Naglfar (Nodos)",0,0,0,0,0,0,0,215,0,0,0,0,0,0,0,0,0,0
,0,0,0,0,0,0,0,216,0,0,0,0,0,0,0,0,0,0
,0,0,0,0,0,0,0,217,0,0,0,0,0,0,0,0,0,0
"Transporte, Fiordo Aquilonal (Góndola, superior)",690.99,-3819.6,249.06,0,0,0,0,218,571,0,0,0,0,0,0,0,0,0
"Transporte, Fiordo Aquilonal (Góndola, inferior)",607.96,-2906.17,38.54,0,0,0,0,219,571,0,0,0,0,0,0,0,0,0
,3051.76,3690.41,142.63,0,0,0,0,220,530,0,220,0,0,0,0,0,5403,0
"El Saliente Ámbar, Boreal (a Berilo)",3465.66,5901.76,144.17,0,0,0,0,221,571,0,0,2,0,0,0,0,26088,0
"Alto de Berilo, Boreal",3213.74,6084.72,138,0,0,0,0,222,571,0,0,2,0,0,0,0,25695,0
"Misión, Naglevar",0,0,0,0,0,0,0,223,0,0,0,0,0,0,0,0,0,0
"Tundra Boreal, Naglevar",0,0,0,0,0,0,0,224,0,0,0,0,0,0,0,0,0,0
"El Saliente Ámbar, Boreal (a Gelidar)",3574.06,5971.04,136.11,0,0,0,0,225,571,0,0,2,0,0,0,0,25695,0
"Escudo de Tránsito, Gelidar",3575.44,6661.64,195.19,0,0,0,0,226,571,0,226,3,0,0,0,0,26899,26899
"Transport, PattyMacDevTest",16625.63,16862.9,46.98,0,0,0,0,227,451,0,0,0,0,0,0,0,28901,25968
Development Land - Pat Test Start,0,0,0,0,0,0,0,228,0,0,0,0,0,0,0,0,0,0
Development Land - Pat Test End,0,0,0,0,0,0,0,229,0,0,0,0,0,0,0,0,0,0
"Transporte, colmillarr 01",2690.26,889.81,4.61,0,0,0,0,230,571,0,0,0,0,0,0,0,0,0
"Transporte, colmillarr 02",2690.33,897.63,4.62,0,0,0,0,231,571,0,0,0,0,0,0,0,0,0
"Tundra Boreal, Lobo de Bastión Grito de Guerra inicio",2774.69,6258.14,83.68,0,0,0,0,232,571,0,0,2,0,0,0,0,26128,0
"Tundra Boreal, Lobo de Bastión Grito de Guerra Fin",3443.52,4103.95,16.01,0,0,0,0,233,571,0,0,0,0,0,0,0,0,0
"Saliente de Gelidar, Gelidar",4130.62,7372.31,534.11,0,0,0,0,234,571,0,0,2,0,0,0,0,26263,0
"Escudo de Tránsito, Gelidar (NOT USED)",3575.56,6651.84,195.21,0,0,0,0,235,571,0,0,2,0,0,0,0,25695,0
"Gelidar, Keristrasza a Malygos",4026.95,7085.54,165.54,0,0,0,0,236,571,0,0,2,0,0,0,0,26263,0
"Gelidar, Alto de Keristrasza",3929.4,6590.74,170.34,0,0,0,0,237,571,0,0,0,0,0,0,0,0,0
,0,0,0,0,0,0,0,238,0,0,0,0,0,0,0,0,0,0
"Tundra Boreal, Misión, Anochecer, Final",3109,3819.54,23.24,0,0,0,0,239,571,0,0,2,0,0,0,0,26404,0
"Tundra Boreal, Misión, Anochecer, Inicio",3614.3,3670.12,35.78,0,0,0,0,240,571,0,0,2,0,0,0,0,11195,0
"Transporte, Fortaleza Denuedo",0,0,0,0,0,0,0,241,0,0,0,0,0,0,0,0,0,0
Misión - Cementerio de Dragones - Visión espiritual - Comienzo,2739.73,882.37,6.64,0,0,0,0,242,571,0,0,2,0,0,0,0,21396,0
Misión - Cementerio de Dragones - Visión espiritual - Fin,2738.47,882.46,6.5,0,0,0,0,243,571,0,0,0,0,0,0,0,0,0
"Fortaleza de Hibergarde, Cementerio de Dragones",3712.43,-694.86,215.57,0,0,0,0,244,571,0,244,1,0,0,0,0,0,541
"Fortaleza Denuedo, Tundra Boreal",2269.54,5173.69,11.1,0,0,0,0,245,571,0,245,1,0,0,0,0,0,541
"Pista de Aterrizaje de Palanqueta, Tundra Boreal",4127.23,5313.07,28.67,0,0,0,0,246,571,0,246,1,0,0,0,0,0,28360
"Reposo Estelar, Cementerio de Dragones",3504.13,1992.03,64.96,0,0,0,0,247,571,0,247,1,0,0,0,0,0,3837
"Campamento de los Boticarios, Fiordo Aquilonal",2108.11,-2970.62,148.58,0,0,0,0,248,571,0,248,2,0,0,0,0,3574,0
"Campamento Oneqwah, Colinas Pardas",3876.34,-4520.08,217.32,0,0,0,0,249,571,0,249,2,0,0,0,0,2224,0
"Bastión de la Conquista, Colinas Pardas",3258.9,-2263.09,114.37,0,0,0,0,250,571,0,250,2,0,0,0,0,2224,0
"Bastión de Fordragón, Cementerio de Dragones",4612.21,1406.6,195.06,0,0,0,0,251,571,0,251,1,0,0,0,0,0,541
"Templo del Reposo del Dragón, Cementerio de Dragones",3653.21,247.58,52.26,0,0,0,0,252,571,0,252,3,0,0,0,0,26899,26899
"Refugio Pino Ámbar, Colinas Pardas",3446.35,-2754.1,199.4,0,0,0,0,253,571,0,253,1,0,0,0,0,0,541
"Rencor Venenoso, Cementerio de Dragones",3242.96,-666.16,166.79,0,0,0,0,254,571,0,254,2,0,0,0,0,3574,0
"Brigada de los Páramos de Poniente, Colinas Pardas",4584.98,-4254.69,182.21,0,0,0,0,255,571,0,255,1,0,0,0,0,0,541
"Martillo de Agmar, Cementerio de Dragones",3865.87,1525.63,90.04,0,0,0,0,256,571,0,256,2,0,0,0,0,2224,0
"Bastión Grito de Guerra, Tundra Boreal",2920.29,6242.85,208.8,0,0,0,0,257,571,0,257,2,0,0,0,0,2224,0
"Poblado Taunka'le, Tundra Boreal",3449.51,4089.52,16.64,0,0,0,0,258,571,0,258,2,0,0,0,0,2224,0
"Avanzada Bor'gorok, Tundra Boreal",4474.79,5712.13,81.28,0,0,0,0,259,571,0,259,2,0,0,0,0,2224,0
"Vanguardia Kor'kron, Cementerio de Dragones",4946.67,1165.94,239.57,0,0,0,0,260,571,0,260,2,0,0,0,0,2224,0
Misión – Reposo Estelar a Hibergarde Fin,3711.31,-698.18,215.57,0,0,0,0,261,571,0,0,1,0,0,0,0,0,27127
"Colinas Pardas, comienzo de viaje de la Alianza 01",4267.39,-3050.93,318.16,0,0,0,0,262,571,0,0,2,0,0,0,0,29878,0
"Colinas Pardas, fin de viaje de la Alianza 01",2663.67,-2181.45,3.43,0,0,0,0,263,571,0,0,0,0,0,0,0,0,0
"Transporte, Auberdine (NUEVO)",0,0,0,0,0,0,0,264,0,0,0,0,0,0,0,0,0,0
"Transporte, Theramore (NUEVO)",0,0,0,0,0,0,0,265,0,0,0,0,0,0,0,0,0,0
"Transporte, Menethil (NUEVO)",0,0,0,0,0,0,0,266,0,0,0,0,0,0,0,0,0,0
"Colinas Pardas, comienzo de viaje de la Alianza",4272.09,-3248.26,324.93,0,0,0,0,267,571,0,0,2,0,0,0,0,29878,0
"Colinas Pardas, fin de viaje de la Alianza",2664.22,-2344.63,21.7,0,0,0,0,268,571,0,0,0,0,0,0,0,0,0
Misión - Fortaleza de la Guardia Oeste a Fortaleza de Hibergarde Comienzo,1341.67,-3288.74,174.45,0,0,0,0,269,571,0,0,1,0,0,0,0,0,27491
Misión - Fortaleza de la Guardia Oeste a Fortaleza de Hibergarde Fin,3712.23,-693.85,215.42,0,0,0,0,270,571,0,0,1,0,0,0,0,0,27491
"Colinas Pardas, comienzo de viaje de la Horda",4311.25,-2956.61,317.31,0,0,0,0,271,571,0,0,2,0,0,0,0,29879,0
"Colinas Pardas, fin de viaje de la Horda",2883.75,-1673.71,6.48,0,0,0,0,272,571,0,0,0,0,0,0,0,0,0
"Templo del Reposo del Dragón - de abajo a arriba, Cementerio de Dragones - Comienzo",3547.22,381.49,52.26,0,0,0,0,273,571,0,0,3,0,0,0,0,26899,26899
"Templo del Reposo del Dragón - de abajo a arriba, Cementerio de Dragones - Fin",3590.38,277.54,340.85,0,0,0,0,274,571,0,0,0,0,0,0,0,0,0
"Templo del Reposo del Dragón - de arriba a abajo, Cementerio de Dragones - Comienzo",3587.65,279.21,340.83,0,0,0,0,275,571,0,0,3,0,0,0,0,26899,26899
"Templo del Reposo del Dragón - de arriba a abajo, Cementerio de Dragones - Fin",3511.48,373.93,52.26,0,0,0,0,276,571,0,0,0,0,0,0,0,0,0
"Templo del Reposo del Dragón - de arriba a la mitad, Cementerio de Dragones – Comienzo",3587.55,279.14,340.83,0,0,0,0,277,571,0,0,3,0,0,0,0,26899,26899
"Templo del Reposo del Dragón - de arriba a la mitad, Cementerio de Dragones -Fin",3543.24,307.04,116.73,0,0,0,0,278,571,0,0,0,0,0,0,0,0,0
"Templo del Reposo del Dragón – de la mitad a arriba, Cementerio de Dragones - Fin",3587.04,277.14,340.82,0,0,0,0,279,571,0,0,0,0,0,0,0,0,0
"Templo del Reposo del Dragón – de la mitad a arriba, Cementerio de Dragones - Comienzo",3545.62,273.6,116.84,0,0,0,0,280,571,0,0,3,0,0,0,0,26899,26899
"Templo del Reposo del Dragón – de la mitad abajo, Cementerio de Dragones - Fin",3512.22,373.57,52.26,0,0,0,0,281,571,0,0,0,0,0,0,0,0,0
"Templo del Reposo del Dragón – de la mitad abajo, Cementerio de Dragones - Comienzo",3545.61,273.6,116.84,0,0,0,0,282,571,0,0,3,0,0,0,0,26899,26899
"Templo del Reposo del Dragón - de abajo a la mitad, Cementerio de Dragones - Fin",3543.37,307.06,116.73,0,0,0,0,283,571,0,0,0,0,0,0,0,0,0
"Templo del Reposo del Dragón - de abajo a la mitad, Cementerio de Dragones - Comienzo",3548.15,381.01,52.26,0,0,0,0,284,571,0,0,3,0,0,0,0,26899,26899
Misión – Hibergarde -> Reposo Estelar (Comienzo),0,0,0,0,0,0,0,285,0,0,0,1,0,0,0,0,0,27764
Misión – Hibergarde -> Reposo Estelar (Fin),3503.76,1990.11,65.12,0,0,0,0,286,571,0,0,0,0,0,0,0,0,0
Misión - Valgarde -> Fortaleza de la Guardia Oeste Inicio,0,0,0,0,0,0,0,287,0,0,0,1,0,0,0,0,0,27491
Misión - Valgarde -> Fortaleza de la Guardia Oeste Fin,1341.23,-3288.91,174.46,0,0,0,0,288,571,0,0,0,0,0,0,0,0,0
"El Saliente Ámbar, Tundra Boreal",3587.84,5973.3,136.22,0,0,0,0,289,571,0,289,3,0,0,0,0,26899,26899
"El Confín Argenta, Zul'Drak",5450.3,-2606.27,306.91,0,0,0,0,290,571,0,0,2,0,0,0,0,28172,0
"Puesto 01 de la Ciudad en Ruinas, Zul'Drak",5028.69,-3020.38,292.42,0,0,0,0,291,571,0,0,0,0,0,0,0,0,0
Flavor - Stormwind Harbor  - Start,-8338.36,1107.01,57.26,0,0,0,0,292,0,0,0,1,0,0,0,0,0,541
Flavor - Stormwind Harbor - Stop,-8341.09,1101.85,57.26,0,0,0,0,293,0,0,0,0,0,0,0,0,0,0
"Moa'ki, Cementerio de Dragones",2792.45,908.96,22.33,0,0,0,0,294,571,0,294,3,0,0,0,0,2224,541
"Komawa, Fiordo Aquilonal",785.27,-2887.71,5.89,0,0,0,0,295,571,0,295,3,0,0,0,0,2224,541
"Unu'pe, Tundra Boreal",2919.19,4046.09,1.85,0,0,0,0,296,571,0,296,3,0,0,0,0,2224,541
"Cuenca de Sholazar, misión, reconocimiento, comienzo",5557.57,5802.05,-66.09,0,0,0,0,297,571,0,0,0,0,0,0,0,0,0
"Cuenca de Sholazar, misión, reconocimiento, fin",5505.35,4747.79,-194.43,0,0,0,0,298,571,0,0,0,0,0,0,0,0,0
Transporte: Menethil <-> Valgarde,0,0,0,0,0,0,0,299,0,0,0,0,0,0,0,0,0,0
"Transporte, Ventormenta",0,0,0,0,0,0,0,300,0,0,0,0,0,0,0,0,0,0
"Misión, Tundra Boreal, Preséntate ante Bixie, comienzo",4125.51,5310.99,28.68,0,0,0,0,301,571,0,0,1,0,0,0,0,0,28360
"Misión, Tundra Boreal, Preséntate ante Bixie, final",4171.83,4335.63,36.23,0,0,0,0,302,571,0,0,0,0,0,0,0,0,0
"Campamento de Aterrizaje de Denuedo, Conquista del Invierno",5100.81,2185.65,365.62,0,0,0,0,303,571,0,303,1,0,0,0,0,0,541
"El Confín Argenta, Zul'Drak",5521.63,-2672.25,303.95,0,0,0,0,304,571,0,304,3,0,0,0,0,2224,541
"Puesto de Vigilancia de Ébano, Zul'Drak",5218.9,-1302.22,242.16,0,0,0,0,305,571,0,305,3,0,0,0,0,32981,32981
"Brecha de la Luz, Zul'Drak",5190.11,-2206.46,239.4,0,0,0,0,306,571,0,306,3,0,0,0,0,2224,541
"Zim'Torga, Zul'Drak",5777.4,-3594.94,386.69,0,0,0,0,307,571,0,307,3,0,0,0,0,2224,541
"Corazón del Río, Cuenca de Sholazar",5506.23,4748.1,-194.43,0,0,0,0,308,571,0,308,3,0,0,0,0,28625,28625
"Campamento Base de Nesingwary, Cuenca de Sholazar",5596.1,5824.37,-67.73,0,0,0,0,309,571,7376,309,3,0,0,0,0,28625,28625
Dalaran,5813.89,449.13,658.75,0,0,0,0,310,571,0,310,3,0,0,0,0,2224,541
"Campamento Oneqwah, Colinas Pardas (Misión)",3877.91,-4519.59,217.29,0,0,0,0,311,571,0,0,2,0,0,0,0,2224,0
"Brecha de la Luz, Zul'Drak (misión)",5189.67,-2206.85,239.4,0,0,0,0,312,571,0,0,0,0,0,0,0,0,0
"Brigada de los Páramos de Poniente, Colinas Pardas (Misión)",4584.01,-4250.38,182.17,0,0,0,0,313,571,0,0,1,0,0,0,0,0,541
"Zim'Torga, Zul'Drak (Misión)",5779.13,-3596.42,386.85,0,0,0,0,314,571,0,0,2,0,0,0,0,3574,0
Acherus: El Bastión de Ébano,2352.37,-5666.91,382.24,0,0,0,0,315,0,7305,315,3,0,0,0,0,32981,32981
"Bastión de Ébano - Acherus -> Brecha de la Muerte, Final",0,0,0,0,0,0,0,316,0,0,0,3,0,0,0,0,29488,29488
"Bastión de Ébano - Acherus -> Brecha de la Muerte, Inicio",2431,-5730.21,157.94,0,0,0,0,317,609,0,0,0,0,0,0,0,0,0
"Bastión de Ébano - Brecha de la Muerte -> Acherus, Inicio",0,0,0,0,0,0,0,318,0,0,0,3,0,0,0,0,29501,29501
"Bastión de Ébano - Brecha de la Muerte -> Acherus, Final",2356.51,-5664.18,382.25,0,0,0,0,319,609,0,0,0,0,0,0,0,0,0
"K3, Las Cumbres Tormentosas",6186.75,-1052.91,410.2,0,0,0,0,320,571,0,320,3,0,0,0,0,2224,541
"Fuerte Escarcha, Las Cumbres Tormentosas",6667.04,-258.7,961.9,0,0,0,0,321,571,0,321,1,0,0,0,0,0,541
"Dun Nifflelem, Las Cumbres Tormentosas",7308.04,-2607.6,814.8,0,0,0,0,322,571,0,322,3,0,0,0,0,32585,32585
"Lugar del accidente de Grom'arsh, Las Cumbres Tormentosas",7857.3,-735.02,1177.15,0,0,0,0,323,571,0,323,2,0,0,0,0,2224,0
"Campamento Tunka'lo, Las Cumbres Tormentosas",7793.85,-2810.09,1217.03,0,0,0,0,324,571,0,324,2,0,0,0,0,2224,0
"Ascenso de la Muerte, Corona de Hielo",7427.32,4224.16,314.11,0,0,0,0,325,571,0,325,3,0,0,0,0,32981,32981
"Ulduar, Las Cumbres Tormentosas",8864.74,-1324.33,1032.82,0,0,0,0,326,571,0,326,3,0,0,0,0,2224,541
"Refugio de Pedruscón, Las Cumbres Tormentosas",8472.46,-335.95,906.48,0,0,0,0,327,571,0,327,3,0,0,0,0,2224,541
"Transporte, Dirigible Corona de Hielo (A)",7501.65,1140.28,682.23,0,0,0,0,328,571,0,0,0,0,0,0,0,0,0
"Transporte, Dirigible Corona de Hielo (H)",7561.81,1724.59,683.56,0,0,0,0,329,571,0,0,0,0,0,0,0,0,0
"Transporte, Corona de Hielo (objetivo)",7489.64,1477.72,328.64,0,0,0,0,330,571,0,0,0,0,0,0,0,0,0
"Gundrak, Zul'Drak",6897.65,-4118.23,467.35,0,0,0,0,331,571,0,331,3,0,0,0,0,2224,541
"Campamento Grito de Guerra, Conquista del Invierno",5024.99,3685.55,362.94,0,0,0,0,332,571,0,332,2,0,0,0,0,2224,0
"La Cámara de las Sombras, Corona de Hielo",8408.09,2702.66,655.11,0,0,0,0,333,571,0,333,2,0,0,0,0,32981,0
"La Vanguardia Argenta, Corona de Hielo",6164.49,-61.31,388.18,0,0,0,0,334,571,0,334,3,0,0,0,0,2224,541
"Pináculo de los Cruzados, Corona de Hielo",6402.06,467.86,511.29,0,0,0,0,335,571,0,335,3,0,0,0,0,32586,32586
"Mirador Brisaveloz, Bosque Canto de Cristal",5035.65,-519.96,225.41,0,0,0,0,336,571,0,336,1,0,0,0,0,0,31315
"Dominio de los Atracasol, Bosque Canto de Cristal",5590.49,-693.23,206.63,0,0,0,0,337,571,0,337,2,0,0,0,0,34709,0
"Campos del Torneo Argenta, Corona de Hielo",8475.79,891.2,547.29,0,0,0,0,340,571,0,340,3,0,0,0,0,34709,31315
Banda Ulduar: Interior: Punto de Entrada,-749.2,-99.99,429.68,0,0,0,0,341,603,0,0,0,0,0,0,0,25968,25968
Banda Ulduar: Explanada de Hierro,119.96,-71.62,409.8,0,0,0,0,342,603,0,0,0,0,0,0,0,25968,25968
Transporte: Cima del Trueno <-> Orgrimmar (Zepelín),0,0,0,0,0,0,0,348,0,0,0,0,0,0,0,0,0,0
"Isla de la Conquista, Barcos de guerra",0,0,0,0,0,0,0,352,0,0,0,0,0,0,0,0,0,0
,0,0,0,0,0,0,0,353,0,0,0,0,0,0,0,0,0,0
,0,0,0,0,0,0,0,357,0,0,0,0,0,0,0,0,0,0
"Misión, Corona de Hielo, Bombardeo del Kraken de El Mar del Norte (Inicio)",8498.32,1066.32,552.19,0,0,0,0,358,571,0,0,3,0,0,0,0,35146,35146
"Misión, Corona de Hielo, Bombardeo del Kraken de El Mar del Norte (Fin)",8501.53,1064.02,552.19,0,0,0,0,359,571,0,0,3,0,0,0,0,33857,33857
REUSEME,0,0,0,0,0,0,0,375,0,0,0,0,0,0,0,0,0,0
Banda de la Corona de Hielo - Rutas de vuelo de la batalla aérea,0,0,0,0,0,0,0,376,0,0,0,0,0,0,0,0,0,0
"Mazmorra de Corona de Hielo, naves de guerra",0,0,0,0,0,0,0,377,0,0,0,0,0,0,0,0,0,0
Banda de la Corona de Hielo - Nave de Colmillosauro (fin),-200.59,1437.53,-452.27,0,0,0,0,379,631,0,0,0,0,0,0,0,0,0
Banda de la Corona de Hielo - Nave de Colmillosauro (inicio),0,0,0,0,0,0,0,380,0,0,0,0,0,0,0,0,0,0
"Misión, transporte, banda de la Corona de Hielo - Nave de Colmillosauro (inicio)",0,0,0,0,0,0,0,381,0,0,0,0,0,0,0,0,0,0
"Misión, banda de la Corona de Hielo - Nave de Colmillosauro (fin)",0,0,0,0,0,0,0,382,0,0,0,0,0,0,0,0,0,0
"Río Thondroril, Tierras de la Peste del Oeste",1942.54,-2559.18,61.11,0,0,0,0,383,0,0,383,3,0,0,0,0,2224,541
"El Baluarte, Tirisfal",1726.86,-740.76,59.03,0,0,0,0,384,0,0,384,2,0,0,0,0,3574,0
CC Prologue - GT - Quest - Vent Horizon - Start,-5448.5,-665.08,392.95,0,0,0,0,392,0,0,0,3,0,0,0,0,28625,28625
CC Prologue - GT - Quest - Vent Horizon - End,-5447.85,-665.59,393.16,0,0,0,0,393,0,0,0,3,0,0,0,0,35146,35146
CC Prologue - GT - Battle Flight - Start,-5451.48,-667.73,393.01,0,0,0,0,394,0,0,0,3,0,0,0,0,28625,28625
CC Prologue - GT - Battle Flight - End,-5434.71,523.09,388.3,0,0,0,0,395,0,0,0,0,0,0,0,0,0,0
Durotar - ET - CC Prologue Spy Frog Start,-839.64,-4985.35,14.65,0,0,0,0,404,1,0,0,2,0,0,0,0,40203,0
Durotar - ET - CC Prologue Spy Frog End,-838.01,-4986.28,14.75,0,0,0,0,405,1,0,0,2,0,0,0,0,40203,0
Durotar - ET - CC Prologue Troll Taxi Bat Start,-838.85,-4985.99,14.71,0,0,0,0,438,1,0,0,2,0,0,0,0,3574,0
Durotar - ET - CC Prologue Troll Recruit End,284.38,-4762.36,12.56,0,0,0,0,439,1,0,0,2,0,0,0,0,3574,0
Durotar - ET - CC Prologue - Troll Battle End,-848.2,-5339.46,3.07,0,0,0,0,440,1,0,0,0,0,0,0,0,0,0
]]

L.taxiNodes = addon.LoadCSVData(taxiNodesCSV, "ID")
