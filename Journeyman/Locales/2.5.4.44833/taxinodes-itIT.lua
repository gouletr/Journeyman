local addonName, addon = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "itIT")
if not L then return end

local taxiNodesCSV = [[
Name_lang,Pos[0],Pos[1],Pos[2],MapOffset[0],MapOffset[1],FlightMapOffset[0],FlightMapOffset[1],ID,ContinentID,ConditionID,CharacterBitNumber,Flags,UiTextureKitID,Facing,SpecialIconConditionID,VisibilityConditionID,MountCreatureID[0],MountCreatureID[1]
노스샤이어 대성당,-8888.98,-0.54,94.39,0,0,0,0,1,0,0,1,0,0,0,0,0,308,0
스톰윈드 (엘윈 숲),-8840.56,489.7,109.61,0,0,0,0,2,0,0,2,1,0,0,0,0,0,541
프로그래머의 섬,16391.81,16341.21,69.44,0,0,0,0,3,0,0,3,0,0,0,0,0,308,0
감시의 언덕 (서부 몰락지대),-10629.29,1036.95,34.02,0,0,0,0,4,0,0,4,1,0,0,0,0,0,541
레이크샤이어 (붉은마루 산맥),-9429.1,-2231.4,68.65,0,0,0,0,5,0,0,5,1,0,0,0,0,0,541
아이언포지 (던 모로),-4821.78,-1155.44,502.21,0,0,0,0,6,0,0,6,1,0,0,0,0,0,541
메네실 항구 (저습지),-3792.26,-783.29,9.06,0,0,0,0,7,0,0,7,1,0,0,0,0,0,541
텔사마 (모단 호수),-5421.91,-2930.01,347.25,0,0,0,0,8,0,0,8,1,0,0,0,0,0,541
무법항 (가시덤불 골짜기),-14271.77,299.87,31.09,0,0,0,0,9,0,0,9,0,0,0,0,0,0,541
공동묘지 (은빛소나무 숲),478.86,1536.59,131.32,0,0,0,0,10,0,0,10,2,0,0,0,0,3574,0
언더시티 (티리스팔 숲),1568.62,267.97,-43.1,0,0,0,0,11,0,0,11,2,0,0,0,0,3574,0
다크샤이어 (그늘숲),-10515.46,-1261.65,41.34,0,0,0,0,12,0,0,12,1,0,0,0,0,0,541
타렌 밀농장 (힐스브래드 구릉지),-0.06,-859.91,58.83,0,0,0,0,13,0,0,13,2,0,0,0,0,3574,0
사우스쇼어 (힐스브래드 구릉지),-711.48,-515.48,26.11,0,0,0,0,14,0,0,14,1,0,0,0,0,0,541
동부 역병지대,2253.4,-5344.9,83.38,0,0,0,0,15,0,0,15,0,0,0,0,0,0,541
임시 주둔지 (아라시 고원),-1240.53,-2515.11,22.16,0,0,0,0,16,0,0,16,1,0,0,0,0,0,541
해머폴 (아라시 고원),-916.29,-3496.89,70.45,0,0,0,0,17,0,0,17,2,0,0,0,0,2224,0
무법항 (가시덤불 골짜기),-14444.29,509.62,26.2,0,0,0,0,18,0,0,18,2,0,0,0,0,2224,0
무법항 (가시덤불 골짜기),-14473.05,464.15,36.43,0,0,0,0,19,0,0,19,1,0,0,0,0,0,541
그롬골 (가시덤불 골짜기),-12414.18,146.29,3.28,0,0,0,0,20,0,0,20,2,0,0,0,0,2224,0
카르가스 (황야의 땅),-6633.99,-2180.05,244.14,0,0,0,0,21,0,0,21,2,0,0,0,0,2224,0
썬더 블러프 (멀고어),-1197.21,29.71,176.95,0,0,0,0,22,1,0,22,2,0,0,0,0,2224,0
오그리마 (듀로타),1677.59,-4315.71,61.17,0,0,0,0,23,1,0,23,2,0,0,0,0,2224,0
일반 (세계 목적지 002),-6666,-2222.3,278.6,0,0,0,0,24,0,0,24,0,0,0,0,0,0,0
크로스로드 (불모의 땅),-441.8,-2596.08,96.06,0,0,0,0,25,1,0,25,2,0,0,0,0,2224,0
아우버다인 (어둠의 해안),6341.38,557.68,16.29,0,0,0,0,26,1,0,26,1,0,0,0,0,0,3837
루테란 마을 (텔드랏실),8643.59,841.05,23.3,0,0,0,0,27,1,0,27,1,0,0,0,0,0,3837
아스트라나르 (잿빛 골짜기),2827.34,-289.24,107.16,0,0,0,0,28,1,0,28,1,0,0,0,0,0,3837
해바위 야영지 (돌발톱 산맥),966.57,1040.32,104.27,0,0,0,0,29,1,0,29,2,0,0,0,0,2224,0
높새바람 봉우리 (버섯구름 봉우리),-5407.71,-2414.3,90.32,0,0,0,0,30,1,0,30,2,0,0,0,0,2224,0
탈라나르 (페랄라스),-4491.88,-775.89,-39.52,0,0,0,0,31,1,0,31,1,0,0,0,0,0,3837
테라모어 섬 (먼지진흙 습지대),-3825.37,-4516.58,10.44,0,0,0,0,32,1,0,32,1,0,0,0,0,0,541
돌발톱 봉우리 (돌발톱 산맥),2681.13,1461.68,232.88,0,0,0,0,33,1,0,33,1,0,0,0,0,0,3837
운송 수단 (무법항),-1965.17,-5824.29,-1.06,0,0,0,0,34,1,0,34,0,0,0,0,0,0,0
운송 수단 (오그리마),1320.07,-4649.2,21.57,0,0,0,0,35,1,0,35,0,0,0,0,0,0,0
일반 (세계 목적지 001),-8644.62,433.28,59.46,0,0,0,0,36,0,0,36,0,0,0,0,0,15665,0
나이젤의 야영지 (잊혀진 땅),139.24,1325.82,193.5,0,0,0,0,37,1,0,37,1,0,0,0,0,0,3837
그늘수렵 마을 (잊혀진 땅),-1767.64,3263.89,4.94,0,0,0,0,38,1,0,38,2,0,0,0,0,2224,0
가젯잔 (타나리스),-7223.97,-3734.59,8.39,0,0,0,0,39,1,0,39,1,0,0,0,0,0,541
가젯잔 (타나리스),-7048.89,-3780.36,10.19,0,0,0,0,40,1,0,40,2,0,0,0,0,2224,0
페더문 요새 (페랄라스),-4373.8,3338.65,12.27,0,0,0,0,41,1,0,41,1,0,0,0,0,0,3837
모자케 야영지 (페랄라스),-4419.86,199.31,25.06,0,0,0,0,42,1,0,42,2,0,0,0,0,2224,0
맹금의 봉우리 (동부 내륙지),283.74,-2002.76,194.74,0,0,0,0,43,0,0,43,1,0,0,0,0,0,541
발로르모크 (아즈샤라),3661.52,-4390.38,113.05,0,0,0,0,44,1,0,44,2,0,0,0,0,2224,0
네더가드 요새 (저주받은 땅),-11112.25,-3435.74,79.09,0,0,0,0,45,0,0,45,1,0,0,0,0,0,541
운송 수단 (사우스쇼어),-986.43,-547.86,-3.86,0,0,0,0,46,0,0,46,0,0,0,0,0,0,0
운송 수단 (그롬골),-12418.77,235.43,1.12,0,0,0,0,47,0,0,47,0,0,0,0,0,0,0
피멍울 초소 (악령의 숲),5068.4,-337.22,367.41,0,0,0,0,48,1,0,48,2,0,0,0,0,2224,0
달의 숲,7458.45,-2487.21,462.33,0,0,0,0,49,1,0,49,1,0,0,0,0,0,3837
운송 수단 (메네실 항구),0,0,0,0,0,0,0,50,0,0,50,0,0,0,0,0,0,0
운송 수단 (아우버다인),0,0,0,0,0,0,0,51,0,0,51,0,0,0,0,0,0,0
눈망루 마을 (여명의 설원),6796.8,-4742.39,701.5,0,0,0,0,52,1,0,52,1,0,0,0,0,0,3837
눈망루 마을 (여명의 설원),6813.06,-4611.12,710.67,0,0,0,0,53,1,0,53,2,0,0,0,0,2224,0
운송 수단 (페더문),-4203.87,3284,-12.86,0,0,0,0,54,1,0,54,0,0,0,0,0,0,0
담쟁이 마을 (먼지진흙 습지대),-3147.39,-2842.18,34.61,0,0,0,0,55,1,0,55,2,0,0,0,0,2224,0
스토나드 (슬픔의 늪),-10456.97,-3279.25,21.35,0,0,0,0,56,0,0,56,2,0,0,0,0,2224,0
고기잡이 마을 (텔드랏실),8701.51,991.37,14.21,0,0,0,0,57,1,0,57,0,0,0,0,0,0,3837
조람가르 전초기지 (잿빛 골짜기),3374.71,996.97,5.19,0,0,0,0,58,1,0,58,2,0,0,0,0,2224,0
던 발다르 (알터랙 계곡),574.21,-46.65,37.61,0,0,0,0,59,30,0,59,1,0,0,0,0,0,541
서리늑대 요새 (알터랙 계곡),-1335.44,-319.69,90.66,0,0,0,0,60,30,0,60,2,0,0,0,0,3574,0
토막나무 주둔지 (잿빛 골짜기),2302.39,-2524.55,104.4,0,0,0,0,61,1,0,61,2,0,0,0,0,2224,0
나이트헤이븐 (달의 숲),7793.61,-2403.47,489.32,0,0,0,0,62,1,0,62,1,0,0,0,0,0,3837
나이트헤이븐 (달의 숲),7787.72,-2404.1,489.56,0,0,0,0,63,1,0,63,2,0,0,0,0,2224,0
탈렌드리스 초소 (아즈샤라),2721.99,-3880.64,100.87,0,0,0,0,64,1,0,64,1,0,0,0,0,0,3837
갈퀴가지 숲 (악령의 숲),6205.88,-1949.63,571.29,0,0,0,0,65,1,0,65,1,0,0,0,0,0,3837
서리바람 야영지 (서부 역병지대),931.32,-1430.11,64.67,0,0,0,0,66,0,0,66,1,0,0,0,0,0,541
희망의 빛 예배당 (동부 역병지대),2271.09,-5340.8,87.11,0,0,0,0,67,0,0,67,1,0,0,0,0,0,541
희망의 빛 예배당 (동부 역병지대),2327.41,-5286.89,81.78,0,0,0,0,68,0,0,68,2,0,0,0,0,3574,0
달의 숲,7470.39,-2123.38,492.34,0,0,0,0,69,1,0,69,2,0,0,0,0,2224,0
화염 마루 (불타는 평원),-7504.03,-2187.54,165.53,0,0,0,0,70,0,0,70,2,0,0,0,0,2224,0
모건의 망루 (불타는 평원),-8364.61,-2738.35,185.46,0,0,0,0,71,0,0,71,1,0,0,0,0,0,541
세나리온 요새 (실리더스),-6811.39,836.74,49.81,0,0,0,0,72,1,0,72,2,0,0,0,0,2224,0
세나리온 요새 (실리더스),-6761.83,772.03,88.91,0,0,0,0,73,1,0,73,1,0,0,0,0,0,3837
토륨 조합 거점 (이글거리는 협곡),-6552.59,-1168.27,309.31,0,0,0,0,74,0,0,74,1,0,0,0,0,0,541
토륨 조합 거점 (이글거리는 협곡),-6554.93,-1100.05,309.57,0,0,0,0,75,0,0,75,2,0,0,0,0,2224,0
레반터스크 마을 (동부 내륙지),-635.26,-4720.5,5.38,0,0,0,0,76,0,0,76,2,0,0,0,0,2224,0
타우라조 야영지 (불모의 땅),-2380.67,-1882.67,95.85,0,0,0,0,77,1,0,77,2,0,0,0,0,2224,0
낙스라마스,3133.31,-3399.93,139.53,0,0,0,0,78,0,0,78,0,0,0,0,0,0,0
마샬의 야영지 (운고로 분화구),-6113.82,-1142.7,-187.63,0,0,0,0,79,1,0,79,3,0,0,0,0,2224,541
톱니항 (불모의 땅),-894.59,-3773.01,11.48,0,0,0,0,80,1,0,80,3,0,0,0,0,2224,541
실버문,9375.24,-7165.89,9.03,0,0,0,0,82,530,0,82,2,0,0,0,0,19917,0
트랜퀼리엔 (유령의 땅),7594.47,-6784.29,86.46,0,0,0,0,83,530,0,83,2,0,0,0,0,19917,0
역병의 숲 경비탑 (동부 역병지대),2998.71,-3050.1,117.19,0,0,0,0,84,0,0,84,3,0,0,0,0,16081,16081
북부관문 경비탑 (동부 역병지대),3109.31,-4285.13,109.45,0,0,0,0,85,0,0,85,3,0,0,0,0,3574,541
동부방벽 경비탑 (동부 역병지대),2499.23,-4742.85,93.5,0,0,0,0,86,0,0,86,3,0,0,0,0,3574,541
산마루 경비탑 (동부 역병지대),1857.56,-3658.47,143.73,0,0,0,0,87,0,0,87,3,0,0,0,0,3574,541
운송수단 (엑소다르),-4284.01,-11194.74,13.01,0,0,0,0,88,530,0,88,0,0,0,0,0,0,0
운송수단 (테라모어),0,0,0,0,0,0,0,89,0,0,89,0,0,0,0,0,0,0
운송수단 (언더시티),0,0,0,0,0,0,0,90,9770568,0,90,0,0,0,0,0,0,0
Quest - Azuremyst Shaman Target,-3996.01,-11892.97,0.22,0,0,0,0,91,530,0,91,0,0,0,0,0,0,0
Quest - Azuremyst Shaman Start,-3679.31,-11413.04,310.57,0,0,0,0,92,530,0,92,0,0,0,0,0,0,0
핏빛 감시초소 (핏빛안개 섬),-1933.27,-11954.61,57.19,0,0,0,0,93,530,0,93,1,0,0,0,0,0,3837
엑소다르,-4054.89,-11793.35,9.05,0,0,0,0,94,530,0,94,1,0,0,0,0,0,3837
Zangarmarsh - Quest - As the Crow Flies,-146.29,5532.56,30.89,0,0,0,0,95,530,0,95,2,0,0,0,0,17972,0
Zangarmarsh - Quest - As the Crow Flies - End,-145.23,5533.03,30.95,0,0,0,0,96,530,0,96,0,0,0,0,0,0,0
Quest - Elekk Path to Kessel,-3968.37,-11929.15,-1.22,0,0,0,0,97,530,0,97,1,0,0,0,0,0,18167
Quest - Elekk to Kessel Target,-2662.3,-12144.6,16.91,0,0,0,0,98,530,0,98,0,0,0,0,0,0,0
스랄마 (지옥불 반도),228.5,2633.57,87.67,0,0,0,0,99,530,0,99,2,0,0,0,0,2224,0
명예의 요새 (지옥불 반도),-673.42,2717.27,94.18,0,0,0,0,100,530,0,100,1,0,0,0,0,0,541
텔하마트 사원 (지옥불 반도),199.16,4241.56,121.75,0,0,0,0,101,530,0,101,1,0,0,0,0,0,3837
매의 감시탑 (지옥불 반도),-587.41,4101.01,91.37,0,0,0,0,102,530,0,102,2,0,0,0,0,2224,0
Nagrand - PvP - Attack Run Start 1,-1810.16,8032.11,-25.95,0,0,0,0,103,530,0,103,3,0,0,0,0,18345,18345
Nagrand - PvP - Attack Run End 1,-1824.18,8049.29,-26.85,0,0,0,0,104,530,0,104,3,0,0,0,0,13161,13161
Nagrand - PvP - Attack Run Start 2,-1513.4,8140.93,-19.6,0,0,0,0,105,530,0,105,3,0,0,0,0,18345,18345
Nagrand - PvP - Attack Run End 2,-1511.26,8149.71,-18.58,0,0,0,0,106,530,0,106,1,0,0,0,0,541,541
Nagrand - PvP - Attack Run Start 3,-1387.07,7782.41,-11.47,0,0,0,0,107,530,0,107,3,0,0,0,0,18345,18345
Nagrand - PvP - Attack Run End 3,-1376.72,7771.17,-10.08,0,0,0,0,108,530,0,108,1,0,0,0,0,541,541
Nagrand - PvP - Attack Run Start 4,-1656.6,7724.91,-15.59,0,0,0,0,109,530,0,109,3,0,0,0,0,18345,18345
Nagrand - PvP - Attack Run End 4,-1658.9,7724.71,-15.79,0,0,0,0,110,530,0,110,1,0,0,0,0,541,541
영원노래 숲 - 더스크위더 순간이동,9335.83,-7883.07,74.91,0,0,0,0,111,530,0,111,3,0,0,0,0,18392,18392
영원노래 숲 - 더스크위더 순간이동,9335.67,-7809.71,136.57,0,0,0,0,112,530,0,112,3,0,0,0,0,17972,17972
Quest - Nethrandamus Start,-1544.36,8792.07,35.22,0,0,0,0,113,530,0,113,3,0,0,0,0,18543,18543
Quest - Nethrandamus End Target,-1544.36,8792.09,35.22,0,0,0,0,114,530,0,114,0,0,0,0,0,0,0
Quest - Caverns of Time OH - Begin,2384.73,1169.38,66.86,0,0,0,0,115,560,0,115,3,0,0,0,0,18768,18768
Quest - Caverns of Time OH - End,2014.65,239.65,68.52,0,0,0,0,116,560,0,116,0,0,0,0,0,0,0
텔레도르 (장가르 습지대),213.75,6063.75,148.31,0,0,0,0,117,530,0,117,1,0,0,0,0,0,3837
자브라진 (장가르 습지대),219.45,7816,22.72,0,0,0,0,118,530,0,118,2,0,0,0,0,2224,2224
텔라아르 (나그란드),-2729,7305.3,88.64,0,0,0,0,119,530,0,119,1,0,0,0,0,0,3837
가라다르 (나그란드),-1261.09,7133.39,57.34,0,0,0,0,120,530,0,120,2,0,0,0,0,2224,0
알레리아 성채 (테로카르 숲),-2987.24,3872.78,9.13,0,0,0,0,121,530,0,121,1,0,0,0,0,0,541
52번 구역 (황천의 폭풍),3082.31,3596.11,144.02,0,0,0,0,122,530,0,122,3,0,0,0,0,2224,541
어둠달 마을 (어둠달 골짜기),-3018.62,2557.09,79.09,0,0,0,0,123,530,0,123,2,0,0,0,0,2224,0
와일드해머 성채 (어둠달 골짜기),-3982.07,2156.47,105.15,0,0,0,0,124,530,0,124,1,0,0,0,0,0,541
실바나르 (칼날 산맥),2183.65,6794.46,183.28,0,0,0,0,125,530,0,125,1,0,0,0,0,0,3837
천둥군주 요새 (칼날 산맥),2446.37,6020.93,154.34,0,0,0,0,126,530,0,126,2,0,0,0,0,2224,0
돌망치 요새 (테로카르 숲),-2567.33,4423.83,39.33,0,0,0,0,127,530,0,127,2,0,0,0,0,2224,0
샤트라스 (테로카르 숲),-1837.23,5301.9,-12.43,0,0,0,0,128,530,0,128,3,0,0,0,0,2224,541
"어둠의 문 (지옥불 반도, 얼라이언스)",-327.35,1020.49,54.25,0,0,0,0,129,530,0,129,1,0,0,0,0,0,541
"어둠의 문 (지옥불 반도, 호드)",-178.09,1026.72,54.19,0,0,0,0,130,530,0,130,2,0,0,0,0,2224,0
Quest - Horde Hellfire Start,-25.51,2133.45,112.6,0,0,0,0,131,530,0,131,3,0,0,0,0,19275,18376
Quest - Horde Hellfire End,-25.6,2133.4,112.58,0,0,0,0,132,530,0,132,2,0,0,0,0,19275,0
Quest - Hellfire Peninsula (Alliance Path) Start,-673.73,1855.29,68.97,0,0,0,0,133,530,0,133,3,0,0,0,0,19324,19324
Quest - Hellfire Peninsula (Alliance) End,-673.75,1855.32,68.96,0,0,0,0,134,530,0,134,3,0,0,0,0,19324,19324
"Quest - Hellfire, Aerial Mission (Horde) Start",-27.65,2126.57,111.85,0,0,0,0,135,530,0,135,3,0,0,0,0,19275,19324
"Quest - Hellfire, Aerial Mission (Horde) End",-27.52,2126.5,111.88,0,0,0,0,136,530,0,136,3,0,0,0,0,19275,19324
"Quest - Hellfire, Aerial Mission (Alliance) Start",298.5,1501.26,-14.28,0,0,0,0,137,530,0,137,3,0,0,0,0,19275,19324
"Quest - Hellfire, Aerial Mission (Alliance) End",298.59,1501.13,-14.25,0,0,0,0,138,530,0,138,3,0,0,0,0,19275,19324
폭풍 첨탑 (황천의 폭풍),4157.58,2959.69,352.08,0,0,0,0,139,530,0,139,3,0,0,0,0,2224,541
샤타르 제단 (어둠달 골짜기),-3065.6,749.42,-10.1,0,0,0,0,140,530,6211,140,3,0,0,0,0,2224,541
해골망치 마루 (지옥불 반도),-1316.84,2358.62,88.96,0,0,0,0,141,530,0,141,2,0,0,0,0,2224,0
지옥절단기 함락지 (지옥불 반도),-29.16,2125.72,111.47,0,0,0,0,142,530,0,142,2,0,0,0,0,2224,0
Quest - Caverns of Time (Intro Flight Path) (End),-8360.73,-4327.73,-208.33,0,0,0,0,143,1,0,143,3,0,0,0,0,16081,16081
Quest - Caverns of Time (Intro Flight Path) (Start),-8162.01,-4796.23,35.78,0,0,0,0,144,1,0,144,3,0,0,0,0,18768,18768
퀘스트 - 황천의 폭풍 - 은신 비행 - 시작,3079.01,3599.08,144.07,0,0,0,0,145,530,0,145,2,0,0,0,0,2224,0
퀘스트 - 황천의 폭풍 - 은신 비행 - 끝,2235.34,2793.77,128.03,0,0,0,0,146,530,0,146,0,0,0,0,0,0,0
교두보 거점 (지옥불 반도),509.17,1988.69,109.62,0,0,0,0,147,530,0,147,1,0,0,0,0,0,19324
징검다리 거점 (지옥불 반도 공습),298.46,1501.18,-14.28,0,0,0,0,148,530,0,148,1,0,0,0,0,0,19324
징검다리 거점 (지옥불 반도),276.2,1486.91,-15.1,0,0,0,0,149,530,0,149,1,0,0,0,0,0,541
코스모렌치 (황천의 폭풍),2974.95,1848.24,141.28,0,0,0,0,150,530,0,150,3,0,0,0,0,2224,541
늪쥐 감시초소 (장가르 습지대),91.67,5214.92,23.1,0,0,0,0,151,530,0,151,2,0,0,0,0,2224,0
Quest - Netherstorm - Manaforge Ultris (Start),4262.39,2136.92,139.44,0,0,0,0,152,530,0,152,3,0,0,0,0,20903,20903
Quest - Netherstorm - Manaforge Ultris (End),4266.7,2133.38,138.82,0,0,0,0,153,530,0,153,3,0,0,0,0,20903,20903
Quest - Netherstorm - Manaforge Ultris (Second Pass) Start,20047.88,5200.69,19742.78,0,0,0,0,154,530,0,154,3,0,0,0,0,20903,20903
Quest - Netherstorm - Manaforge Ultris (Second Pass) End,4267.14,2133.03,138.77,0,0,0,0,155,530,0,155,0,0,0,0,0,0,0
토쉴리의 연구기지 (칼날 산맥),1857.35,5531.87,277.01,0,0,0,0,156,530,0,156,1,0,0,0,0,0,541
퀘스트 - 칼날 산맥 - 예언 안내 - 시작,2277.74,5983.35,142.6,0,0,0,0,157,530,0,157,2,0,0,0,0,21396,0
퀘스트 - 칼날 산맥 - 예언 안내 - 끝,2278.56,5983.71,142.57,0,0,0,0,158,530,0,158,0,0,0,0,0,0,0
별의 성소 (어둠달 골짜기),-4073.17,1123.61,42.47,0,0,0,0,159,530,6212,159,3,0,0,0,0,2224,541
영원의 숲 (칼날 산맥),2976.01,5501.13,143.67,0,0,0,0,160,530,0,160,3,0,0,0,0,2224,541
퀘스트 - 황천의 용 연합 - 시작,0,0,0,0,0,0,0,161,654135852,0,161,0,0,0,0,0,22360,22360
퀘스트 - 황천의 용 연합 - 끝,-4100.27,950.38,22.11,0,0,0,0,162,530,0,162,0,0,0,0,0,0,0
모크나탈 마을 (칼날 산맥),2028.79,4705.27,150.51,0,0,0,0,163,530,0,163,2,0,0,0,0,2224,0
오레보르 피난처 (장가르 습지대),966.67,7399.16,29.14,0,0,0,0,164,530,0,164,1,0,0,0,0,3837,3837
에메랄드 성소 (악령의 숲),3978.74,-1316.42,250.11,0,0,0,0,166,1,0,166,3,0,0,0,0,2224,3837
숲의 노래 (잿빛 골짜기),3000.25,-3202.41,189.77,0,0,0,0,167,1,0,167,1,0,0,0,0,0,3837
촬영 장소,2999.97,-3202.14,189.73,0,0,0,0,168,1,0,168,0,0,0,0,0,0,3837
퀘스트 - 황천날개 마루 - 광산 수레 - 남쪽 - 시작점,-5224.53,631.85,48.36,0,0,0,0,169,530,0,169,3,0,0,0,0,23372,23372
퀘스트 - 황천날개 마루 - 광산 수레 - 남쪽 - 도착점,-5185.71,172.95,-11.57,0,0,0,0,170,530,0,170,0,0,0,0,0,23289,23289
스케티스,-3364.68,3650.18,284.78,0,0,0,0,171,530,0,171,3,0,0,0,0,23422,23422
오그릴라,2531.1,7322.09,373.64,0,0,0,0,172,530,0,172,0,0,0,0,0,23422,23422
퀘스트 - 야르질 비행 시작,-5141.36,620.11,82.7,0,0,0,0,173,530,0,173,0,0,0,0,0,23468,23468
퀘스트 - 야르질 비행 완료,-1636.09,5275.87,-41.1,0,0,0,0,174,530,0,174,0,0,0,0,0,0,0
진흙톱니 거점 (먼지진흙 습지대),-4566.23,-3226.05,34.7,0,0,0,0,179,1,0,179,3,0,0,0,0,2224,541
퀘스트 - 먼지진흙 습지대 - 알카즈 조사 시작,-3822.66,-4511.33,10.84,0,0,0,0,180,1,0,180,0,0,0,0,0,0,541
퀘스트 - 먼지진흙 습지대 - 알카즈 조사 완료,-3822.71,-4509.65,10.98,0,0,0,0,181,1,0,181,0,0,0,0,0,0,541
반란군 야영지 (가시덤불 골짜기),-11343.97,-216.83,75.22,0,0,0,0,195,0,0,195,1,0,0,0,0,0,541
테스트 SP2,2066.8,-4999.82,251.28,0,0,0,0,197,1,0,197,0,0,0,0,0,0,0
테스트 SP1,1340.02,-4631.29,54.41,0,0,0,0,198,1,0,198,0,0,0,0,0,24489,541
개발 지역 - 카일 라듀 시작,15992.44,-16371.94,76.73,0,0,0,0,201,451,0,201,3,0,0,0,0,23468,23468
개발 지역 - 카일 라듀 종료,15991.68,-16371.95,76.7,0,0,0,0,202,451,0,202,0,0,0,0,0,0,0
"줄아만, 유령의 땅",6789.79,-7747.58,126.51,0,0,0,0,205,530,0,205,3,0,0,0,0,3574,541
"이동, 페더문 (나이트 엘프 함선)",-4348.01,2427.29,6.64,0,0,0,0,206,1,0,206,0,0,0,0,0,0,0
퀘스트 - 태양샘 일일 - 죽음의 흉터 폭탄 투하 - 시작,13008.38,-6911.81,9.58,0,0,0,0,209,530,0,209,2,0,0,0,0,25044,0
퀘스트 - 태양샘 일일 - 죽음의 흉터 폭탄 투하 - 종료,13008.51,-6912.2,9.58,0,0,0,0,210,530,0,210,0,0,0,0,0,25044,0
Quest - Sunwell Daily - Ship Bombing - Start,13007.5,-6911.81,9.58,0,0,0,0,211,530,0,211,2,0,0,0,0,25044,0
Quest - Sunwell Daily - Ship Bombing - End,13188.04,-7047.04,4.79,0,0,0,0,212,530,0,212,2,0,0,0,0,25044,0
무너진 태양 집결지,13012.7,-6908.37,9.58,0,0,0,0,213,530,96423,213,11,0,0,0,0,19917,19917
,3051.76,3690.41,142.63,0,0,0,0,220,530,0,220,0,0,0,0,0,5403,0
]]

L.taxiNodes = addon.LoadCSVData(taxiNodesCSV, "ID")
