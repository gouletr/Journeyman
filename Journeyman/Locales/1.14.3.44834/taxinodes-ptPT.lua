local addonName, addon = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "ptPT")
if not L then return end

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

L.taxiNodes = addon.LoadCSVData(taxiNodesCSV, "ID")
