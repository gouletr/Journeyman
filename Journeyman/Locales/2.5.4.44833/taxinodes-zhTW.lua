local addonName, addon = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "zhTW")
if not L then return end

local taxiNodesCSV = [[
Name_lang,Pos[0],Pos[1],Pos[2],MapOffset[0],MapOffset[1],FlightMapOffset[0],FlightMapOffset[1],ID,ContinentID,ConditionID,CharacterBitNumber,Flags,UiTextureKitID,Facing,SpecialIconConditionID,VisibilityConditionID,MountCreatureID[0],MountCreatureID[1]
北郡修道院,-8888.98,-0.54,94.39,0,0,0,0,1,0,0,1,0,0,0,0,0,308,0
暴風城，艾爾文森林,-8840.56,489.7,109.61,0,0,0,0,2,0,0,2,1,0,0,0,0,0,541
Programmer Isle,16391.81,16341.21,69.44,0,0,0,0,3,0,0,3,0,0,0,0,0,308,0
哨兵嶺，西部荒野,-10629.29,1036.95,34.02,0,0,0,0,4,0,0,4,1,0,0,0,0,0,541
湖畔鎮，赤脊山,-9429.1,-2231.4,68.65,0,0,0,0,5,0,0,5,1,0,0,0,0,0,541
鐵爐堡，丹莫洛,-4821.78,-1155.44,502.21,0,0,0,0,6,0,0,6,1,0,0,0,0,0,541
米奈希爾港，濕地,-3792.26,-783.29,9.06,0,0,0,0,7,0,0,7,1,0,0,0,0,0,541
塞爾薩瑪，洛克莫丹,-5421.91,-2930.01,347.25,0,0,0,0,8,0,0,8,1,0,0,0,0,0,541
藏寶海灣，荊棘谷,-14271.77,299.87,31.09,0,0,0,0,9,0,0,9,0,0,0,0,0,0,541
瑟伯切爾，銀松森林,478.86,1536.59,131.32,0,0,0,0,10,0,0,10,2,0,0,0,0,3574,0
幽暗城，提里斯法林地,1568.62,267.97,-43.1,0,0,0,0,11,0,0,11,2,0,0,0,0,3574,0
夜色鎮，暮色森林,-10515.46,-1261.65,41.34,0,0,0,0,12,0,0,12,1,0,0,0,0,0,541
塔倫米爾，希爾斯布萊德,-0.06,-859.91,58.83,0,0,0,0,13,0,0,13,2,0,0,0,0,3574,0
南海鎮，希爾斯布萊德,-711.48,-515.48,26.11,0,0,0,0,14,0,0,14,1,0,0,0,0,0,541
東瘟疫之地,2253.4,-5344.9,83.38,0,0,0,0,15,0,0,15,0,0,0,0,0,0,541
避難谷地，阿拉希高地,-1240.53,-2515.11,22.16,0,0,0,0,16,0,0,16,1,0,0,0,0,0,541
落錘鎮，阿拉希高地,-916.29,-3496.89,70.45,0,0,0,0,17,0,0,17,2,0,0,0,0,2224,0
藏寶海灣，荊棘谷,-14444.29,509.62,26.2,0,0,0,0,18,0,0,18,2,0,0,0,0,2224,0
藏寶海灣，荊棘谷,-14473.05,464.15,36.43,0,0,0,0,19,0,0,19,1,0,0,0,0,0,541
格羅姆高，荊棘谷,-12414.18,146.29,3.28,0,0,0,0,20,0,0,20,2,0,0,0,0,2224,0
卡加斯，荒蕪之地,-6633.99,-2180.05,244.14,0,0,0,0,21,0,0,21,2,0,0,0,0,2224,0
雷霆崖，莫高雷,-1197.21,29.71,176.95,0,0,0,0,22,1,0,22,2,0,0,0,0,2224,0
奧格瑪，杜洛塔,1677.59,-4315.71,61.17,0,0,0,0,23,1,0,23,2,0,0,0,0,2224,0
"Generic, World Target 002",-6666,-2222.3,278.6,0,0,0,0,24,0,0,24,0,0,0,0,0,0,0
十字路口，貧瘠之地,-441.8,-2596.08,96.06,0,0,0,0,25,1,0,25,2,0,0,0,0,2224,0
奧伯丁，黑海岸,6341.38,557.68,16.29,0,0,0,0,26,1,0,26,1,0,0,0,0,0,3837
魯瑟蘭村，泰達希爾,8643.59,841.05,23.3,0,0,0,0,27,1,0,27,1,0,0,0,0,0,3837
阿斯特蘭納，梣谷,2827.34,-289.24,107.16,0,0,0,0,28,1,0,28,1,0,0,0,0,0,3837
烈日石居，石爪山,966.57,1040.32,104.27,0,0,0,0,29,1,0,29,2,0,0,0,0,2224,0
亂風崗 ，千針石林,-5407.71,-2414.3,90.32,0,0,0,0,30,1,0,30,2,0,0,0,0,2224,0
薩蘭納爾，千針石林,-4491.88,-775.89,-39.52,0,0,0,0,31,1,0,31,1,0,0,0,0,0,3837
塞拉摩，塵泥沼澤,-3825.37,-4516.58,10.44,0,0,0,0,32,1,0,32,1,0,0,0,0,0,541
石爪峰，石爪山,2681.13,1461.68,232.88,0,0,0,0,33,1,0,33,1,0,0,0,0,0,3837
傳送，藏寶海灣,-1965.17,-5824.29,-1.06,0,0,0,0,34,1,0,34,0,0,0,0,0,0,0
傳送，奧格瑪,1320.07,-4649.2,21.57,0,0,0,0,35,1,0,35,0,0,0,0,0,0,0
"Generic, World Target 001",-8644.62,433.28,59.46,0,0,0,0,36,0,0,36,0,0,0,0,0,15665,0
尼耶爾前哨站，淒涼之地,139.24,1325.82,193.5,0,0,0,0,37,1,0,37,1,0,0,0,0,0,3837
葬影村，淒涼之地,-1767.64,3263.89,4.94,0,0,0,0,38,1,0,38,2,0,0,0,0,2224,0
加基森，塔納利斯,-7223.97,-3734.59,8.39,0,0,0,0,39,1,0,39,1,0,0,0,0,0,541
加基森，塔納利斯,-7048.89,-3780.36,10.19,0,0,0,0,40,1,0,40,2,0,0,0,0,2224,0
羽月要塞，菲拉斯,-4373.8,3338.65,12.27,0,0,0,0,41,1,0,41,1,0,0,0,0,0,3837
莫沙徹營地，菲拉斯,-4419.86,199.31,25.06,0,0,0,0,42,1,0,42,2,0,0,0,0,2224,0
鷹巢山，辛特蘭,283.74,-2002.76,194.74,0,0,0,0,43,0,0,43,1,0,0,0,0,0,541
瓦羅莫克，艾薩拉,3661.52,-4390.38,113.05,0,0,0,0,44,1,0,44,2,0,0,0,0,2224,0
守望堡，詛咒之地,-11112.25,-3435.74,79.09,0,0,0,0,45,0,0,45,1,0,0,0,0,0,541
傳送，南海鎮,-986.43,-547.86,-3.86,0,0,0,0,46,0,0,46,0,0,0,0,0,0,0
傳送，格羅姆高,-12418.77,235.43,1.12,0,0,0,0,47,0,0,47,0,0,0,0,0,0,0
血毒河，費伍德森林,5068.4,-337.22,367.41,0,0,0,0,48,1,0,48,2,0,0,0,0,2224,0
月光林地,7458.45,-2487.21,462.33,0,0,0,0,49,1,0,49,1,0,0,0,0,0,3837
傳送，米奈希爾港,0,0,0,0,0,0,0,50,0,0,50,0,0,0,0,0,0,0
傳送，奧伯丁,0,0,0,0,0,0,0,51,0,0,51,0,0,0,0,0,0,0
永望鎮，冬泉谷,6796.8,-4742.39,701.5,0,0,0,0,52,1,0,52,1,0,0,0,0,0,3837
永望鎮，冬泉谷,6813.06,-4611.12,710.67,0,0,0,0,53,1,0,53,2,0,0,0,0,2224,0
菲拉斯，羽月要塞,-4203.87,3284,-12.86,0,0,0,0,54,1,0,54,0,0,0,0,0,0,0
蕨牆村，塵泥沼澤,-3147.39,-2842.18,34.61,0,0,0,0,55,1,0,55,2,0,0,0,0,2224,0
斯通納德，悲傷沼澤,-10456.97,-3279.25,21.35,0,0,0,0,56,0,0,56,2,0,0,0,0,2224,0
釣魚村，泰達希爾,8701.51,991.37,14.21,0,0,0,0,57,1,0,57,0,0,0,0,0,0,3837
左拉姆加前哨站，梣谷,3374.71,996.97,5.19,0,0,0,0,58,1,0,58,2,0,0,0,0,2224,0
丹巴達爾，奧特蘭克山谷,574.21,-46.65,37.61,0,0,0,0,59,30,0,59,1,0,0,0,0,0,541
霜狼要塞，奧特蘭克山谷,-1335.44,-319.69,90.66,0,0,0,0,60,30,0,60,2,0,0,0,0,3574,0
碎木崗哨，梣谷,2302.39,-2524.55,104.4,0,0,0,0,61,1,0,61,2,0,0,0,0,2224,0
永夜港，月光林地,7793.61,-2403.47,489.32,0,0,0,0,62,1,0,62,1,0,0,0,0,0,3837
永夜港，月光林地,7787.72,-2404.1,489.56,0,0,0,0,63,1,0,63,2,0,0,0,0,2224,0
塔倫迪斯營地，艾薩拉,2721.99,-3880.64,100.87,0,0,0,0,64,1,0,64,1,0,0,0,0,0,3837
刺枝林地，費伍德森林,6205.88,-1949.63,571.29,0,0,0,0,65,1,0,65,1,0,0,0,0,0,3837
冰風營地，西瘟疫之地,931.32,-1430.11,64.67,0,0,0,0,66,0,0,66,1,0,0,0,0,0,541
聖光之願禮拜堂，東瘟疫之地,2271.09,-5340.8,87.11,0,0,0,0,67,0,0,67,1,0,0,0,0,0,541
聖光之願禮拜堂，東瘟疫之地,2327.41,-5286.89,81.78,0,0,0,0,68,0,0,68,2,0,0,0,0,3574,0
月光林地,7470.39,-2123.38,492.34,0,0,0,0,69,1,0,69,2,0,0,0,0,2224,0
烈焰峰，燃燒平原,-7504.03,-2187.54,165.53,0,0,0,0,70,0,0,70,2,0,0,0,0,2224,0
摩根的崗哨，燃燒平原,-8364.61,-2738.35,185.46,0,0,0,0,71,0,0,71,1,0,0,0,0,0,541
塞納里奧城堡，希利蘇斯,-6811.39,836.74,49.81,0,0,0,0,72,1,0,72,2,0,0,0,0,2224,0
塞納里奧城堡，希利蘇斯,-6761.83,772.03,88.91,0,0,0,0,73,1,0,73,1,0,0,0,0,0,3837
瑟銀哨塔，灼熱峽谷,-6552.59,-1168.27,309.31,0,0,0,0,74,0,0,74,1,0,0,0,0,0,541
瑟銀哨塔，灼熱峽谷,-6554.93,-1100.05,309.57,0,0,0,0,75,0,0,75,2,0,0,0,0,2224,0
惡齒村，辛特蘭,-635.26,-4720.5,5.38,0,0,0,0,76,0,0,76,2,0,0,0,0,2224,0
陶拉祖營地，貧瘠之地,-2380.67,-1882.67,95.85,0,0,0,0,77,1,0,77,2,0,0,0,0,2224,0
納克薩瑪斯,3133.31,-3399.93,139.53,0,0,0,0,78,0,0,78,0,0,0,0,0,0,0
馬紹爾營地，安戈洛環形山,-6113.82,-1142.7,-187.63,0,0,0,0,79,1,0,79,3,0,0,0,0,2224,541
棘齒城，貧瘠之地,-894.59,-3773.01,11.48,0,0,0,0,80,1,0,80,3,0,0,0,0,2224,541
銀月城,9375.24,-7165.89,9.03,0,0,0,0,82,530,0,82,2,0,0,0,0,19917,0
安寧地，鬼魂之地,7594.47,-6784.29,86.46,0,0,0,0,83,530,0,83,2,0,0,0,0,19917,0
病木林哨塔，東瘟疫之地,2998.71,-3050.1,117.19,0,0,0,0,84,0,0,84,3,0,0,0,0,16081,16081
北地哨塔，東瘟疫之地,3109.31,-4285.13,109.45,0,0,0,0,85,0,0,85,3,0,0,0,0,3574,541
東牆之塔，東瘟疫之地,2499.23,-4742.85,93.5,0,0,0,0,86,0,0,86,3,0,0,0,0,3574,541
皇冠哨塔，東瘟疫之地,1857.56,-3658.47,143.73,0,0,0,0,87,0,0,87,3,0,0,0,0,3574,541
傳送，艾克索達,-4284.01,-11194.74,13.01,0,0,0,0,88,530,0,88,0,0,0,0,0,0,0
傳送，塞拉摩島,0,0,0,0,0,0,0,89,0,0,89,0,0,0,0,0,0,0
傳送，幽暗城,0,0,0,0,0,0,0,90,9770568,0,90,0,0,0,0,0,0,0
任務 - 藍謎薩滿目標,-3996.01,-11892.97,0.22,0,0,0,0,91,530,0,91,0,0,0,0,0,0,0
任務 - 藍謎薩滿起點,-3679.31,-11413.04,310.57,0,0,0,0,92,530,0,92,0,0,0,0,0,0,0
血色守望，血謎島,-1933.27,-11954.61,57.19,0,0,0,0,93,530,0,93,1,0,0,0,0,0,3837
艾克索達,-4054.89,-11793.35,9.05,0,0,0,0,94,530,0,94,1,0,0,0,0,0,3837
贊格沼澤 - 任務 - 烏鴉高飛時,-146.29,5532.56,30.89,0,0,0,0,95,530,0,95,2,0,0,0,0,17972,0
贊格沼澤 - 任務 - 烏鴉高飛時 - 終點,-145.23,5533.03,30.95,0,0,0,0,96,530,0,96,0,0,0,0,0,0,0
任務 - 伊萊克小徑到凱索,-3968.37,-11929.15,-1.22,0,0,0,0,97,530,0,97,1,0,0,0,0,0,18167
任務 - 伊萊克到凱索目標,-2662.3,-12144.6,16.91,0,0,0,0,98,530,0,98,0,0,0,0,0,0,0
索爾瑪，地獄火半島,228.5,2633.57,87.67,0,0,0,0,99,530,0,99,2,0,0,0,0,2224,0
榮譽堡，地獄火半島,-673.42,2717.27,94.18,0,0,0,0,100,530,0,100,1,0,0,0,0,0,541
特爾哈曼神廟，地獄火半島,199.16,4241.56,121.75,0,0,0,0,101,530,0,101,1,0,0,0,0,0,3837
獵鷹哨站，地獄火半島,-587.41,4101.01,91.37,0,0,0,0,102,530,0,102,2,0,0,0,0,2224,0
納葛蘭 - PvP - 攻擊路線起點1,-1810.16,8032.11,-25.95,0,0,0,0,103,530,0,103,3,0,0,0,0,18345,18345
納葛蘭 - PvP - 攻擊路線終點1,-1824.18,8049.29,-26.85,0,0,0,0,104,530,0,104,3,0,0,0,0,13161,13161
納葛蘭 - PvP - 攻擊路線起點2,-1513.4,8140.93,-19.6,0,0,0,0,105,530,0,105,3,0,0,0,0,18345,18345
納葛蘭 - PvP - 攻擊路線終點2,-1511.26,8149.71,-18.58,0,0,0,0,106,530,0,106,1,0,0,0,0,541,541
納葛蘭 - PvP - 攻擊路線起點3,-1387.07,7782.41,-11.47,0,0,0,0,107,530,0,107,3,0,0,0,0,18345,18345
納葛蘭 - PvP - 攻擊路線終點3,-1376.72,7771.17,-10.08,0,0,0,0,108,530,0,108,1,0,0,0,0,541,541
納葛蘭 - PvP - 攻擊路線起點4,-1656.6,7724.91,-15.59,0,0,0,0,109,530,0,109,3,0,0,0,0,18345,18345
納葛蘭 - PvP - 攻擊路線終點4,-1658.9,7724.71,-15.79,0,0,0,0,110,530,0,110,1,0,0,0,0,541,541
永歌 - 暗木傳送,9335.83,-7883.07,74.91,0,0,0,0,111,530,0,111,3,0,0,0,0,18392,18392
永歌 - 暗木傳送終點,9335.67,-7809.71,136.57,0,0,0,0,112,530,0,112,3,0,0,0,0,17972,17972
任務 - 尼軒德瑪斯起點,-1544.36,8792.07,35.22,0,0,0,0,113,530,0,113,3,0,0,0,0,18543,18543
任務 - 尼軒德瑪斯終點目標,-1544.36,8792.09,35.22,0,0,0,0,114,530,0,114,0,0,0,0,0,0,0
任務 - 時光之穴 OH - 起點,2384.73,1169.38,66.86,0,0,0,0,115,560,0,115,3,0,0,0,0,18768,18768
任務 - 時光之穴 OH - 終點,2014.65,239.65,68.52,0,0,0,0,116,560,0,116,0,0,0,0,0,0,0
泰倫多爾，贊格沼澤,213.75,6063.75,148.31,0,0,0,0,117,530,0,117,1,0,0,0,0,0,3837
薩布拉金，贊格沼澤,219.45,7816,22.72,0,0,0,0,118,530,0,118,2,0,0,0,0,2224,2224
泰拉，納葛蘭,-2729,7305.3,88.64,0,0,0,0,119,530,0,119,1,0,0,0,0,0,3837
卡拉達爾，納葛蘭,-1261.09,7133.39,57.34,0,0,0,0,120,530,0,120,2,0,0,0,0,2224,0
艾蘭里堡壘，泰洛卡森林,-2987.24,3872.78,9.13,0,0,0,0,121,530,0,121,1,0,0,0,0,0,541
52區，虛空風暴,3082.31,3596.11,144.02,0,0,0,0,122,530,0,122,3,0,0,0,0,2224,541
影月村，影月谷,-3018.62,2557.09,79.09,0,0,0,0,123,530,0,123,2,0,0,0,0,2224,0
蠻錘要塞，影月谷,-3982.07,2156.47,105.15,0,0,0,0,124,530,0,124,1,0,0,0,0,0,541
希瓦納爾，劍刃山脈,2183.65,6794.46,183.28,0,0,0,0,125,530,0,125,1,0,0,0,0,0,3837
雷霆王村，劍刃山脈,2446.37,6020.93,154.34,0,0,0,0,126,530,0,126,2,0,0,0,0,2224,0
碎石堡，泰洛卡森林,-2567.33,4423.83,39.33,0,0,0,0,127,530,0,127,2,0,0,0,0,2224,0
撒塔斯，泰洛卡森林,-1837.23,5301.9,-12.43,0,0,0,0,128,530,0,128,3,0,0,0,0,2224,541
地獄火半島，黑暗之門，聯盟,-327.35,1020.49,54.25,0,0,0,0,129,530,0,129,1,0,0,0,0,0,541
地獄火半島，黑暗之門，部落,-178.09,1026.72,54.19,0,0,0,0,130,530,0,130,2,0,0,0,0,2224,0
任務 - 部落地獄火起點,-25.51,2133.45,112.6,0,0,0,0,131,530,0,131,3,0,0,0,0,19275,18376
任務 - 部落地獄火終點,-25.6,2133.4,112.58,0,0,0,0,132,530,0,132,2,0,0,0,0,19275,0
任務 - 地獄火半島 (聯盟路線) 起點,-673.73,1855.29,68.97,0,0,0,0,133,530,0,133,3,0,0,0,0,19324,19324
任務 - 地獄火半島 (聯盟) 終點,-673.75,1855.32,68.96,0,0,0,0,134,530,0,134,3,0,0,0,0,19324,19324
任務 - 地獄火， 船空任務 (部落) 起點,-27.65,2126.57,111.85,0,0,0,0,135,530,0,135,3,0,0,0,0,19275,19324
任務 - 地獄火， 船空任務 (部落) 終點,-27.52,2126.5,111.88,0,0,0,0,136,530,0,136,3,0,0,0,0,19275,19324
任務 - 地獄火， 船空任務 (聯盟) 起點,298.5,1501.26,-14.28,0,0,0,0,137,530,0,137,3,0,0,0,0,19275,19324
任務 - 地獄火， 船空任務 (聯盟) 終點,298.59,1501.13,-14.25,0,0,0,0,138,530,0,138,3,0,0,0,0,19275,19324
風暴之尖，虛空風暴,4157.58,2959.69,352.08,0,0,0,0,139,530,0,139,3,0,0,0,0,2224,541
薩塔祭壇，影月谷,-3065.6,749.42,-10.1,0,0,0,0,140,530,6211,140,3,0,0,0,0,2224,541
斷脊山脈，地獄火半島,-1316.84,2358.62,88.96,0,0,0,0,141,530,0,141,2,0,0,0,0,2224,0
地獄火半島 - 搶奪者荒野,-29.16,2125.72,111.47,0,0,0,0,142,530,0,142,2,0,0,0,0,2224,0
任務 - 時光之穴(介紹飛行路線)(終點),-8360.73,-4327.73,-208.33,0,0,0,0,143,1,0,143,3,0,0,0,0,16081,16081
任務 - 時光之穴(介紹飛行路線)(起點),-8162.01,-4796.23,35.78,0,0,0,0,144,1,0,144,3,0,0,0,0,18768,18768
任務 - 虛空風暴 - 隱形飛行 - 開始,3079.01,3599.08,144.07,0,0,0,0,145,530,0,145,2,0,0,0,0,2224,0
任務 - 虛空風暴 - 隱形飛行 - 結束,2235.34,2793.77,128.03,0,0,0,0,146,530,0,146,0,0,0,0,0,0,0
地獄火半島 - 軍隊營地海角,509.17,1988.69,109.62,0,0,0,0,147,530,0,147,1,0,0,0,0,0,19324
破碎崗哨，地獄火半島(海邊突襲),298.46,1501.18,-14.28,0,0,0,0,148,530,0,148,1,0,0,0,0,0,19324
破碎崗哨，地獄火半島,276.2,1486.91,-15.1,0,0,0,0,149,530,0,149,1,0,0,0,0,0,541
扭曲太空，虛空風暴,2974.95,1848.24,141.28,0,0,0,0,150,530,0,150,3,0,0,0,0,2224,541
斯溫派特崗哨，贊格沼澤,91.67,5214.92,23.1,0,0,0,0,151,530,0,151,2,0,0,0,0,2224,0
任務 - 虛空風暴 - 法力熔爐奧崔斯 (起點),4262.39,2136.92,139.44,0,0,0,0,152,530,0,152,3,0,0,0,0,20903,20903
任務 - 虛空風暴 - 法力熔爐奧崔斯 (終點),4266.7,2133.38,138.82,0,0,0,0,153,530,0,153,3,0,0,0,0,20903,20903
任務 - 虛空風暴 - 法力熔爐奧崔斯 (第二次通過) 起點,20047.88,5200.69,19742.78,0,0,0,0,154,530,0,154,3,0,0,0,0,20903,20903
任務 - 虛空風暴 - 法力熔爐奧崔斯 (第二次通過) 終點,4267.14,2133.03,138.77,0,0,0,0,155,530,0,155,0,0,0,0,0,0,0
托斯利基地，劍刃山脈,1857.35,5531.87,277.01,0,0,0,0,156,530,0,156,1,0,0,0,0,0,541
任務 - 劍刃山脈 - 視覺引導 - 起點,2277.74,5983.35,142.6,0,0,0,0,157,530,0,157,2,0,0,0,0,21396,0
任務 - 劍刃山脈 - 視覺引導 - 終點,2278.56,5983.71,142.57,0,0,0,0,158,530,0,158,0,0,0,0,0,0,0
星光聖所，影月谷,-4073.17,1123.61,42.47,0,0,0,0,159,530,6212,159,3,0,0,0,0,2224,541
永恆樹林，劍刃山脈,2976.01,5501.13,143.67,0,0,0,0,160,530,0,160,3,0,0,0,0,2224,541
任務 - 虛空龍同盟 - 起點,0,0,0,0,0,0,0,161,654135852,0,161,0,0,0,0,0,22360,22360
任務 - 虛空龍同盟 - 終點,-4100.27,950.38,22.11,0,0,0,0,162,530,0,162,0,0,0,0,0,0,0
摩克納薩爾村，劍刃山脈,2028.79,4705.27,150.51,0,0,0,0,163,530,0,163,2,0,0,0,0,2224,0
奧雷伯爾港，贊格沼澤,966.67,7399.16,29.14,0,0,0,0,164,530,0,164,1,0,0,0,0,3837,3837
翡翠聖地，費伍德森林,3978.74,-1316.42,250.11,0,0,0,0,166,1,0,166,3,0,0,0,0,2224,3837
林歌神殿，梣谷,3000.25,-3202.41,189.77,0,0,0,0,167,1,0,167,1,0,0,0,0,0,3837
薄霧之地,2999.97,-3202.14,189.73,0,0,0,0,168,1,0,168,0,0,0,0,0,0,3837
任務 - 虛空之翼岩架 - 搭乘礦坑推車 - 南方 - 開始,-5224.53,631.85,48.36,0,0,0,0,169,530,0,169,3,0,0,0,0,23372,23372
任務 - 虛空之翼岩架 - 搭乘礦坑推車 - 南方 - 結束,-5185.71,172.95,-11.57,0,0,0,0,170,530,0,170,0,0,0,0,0,23289,23289
司凱堤斯,-3364.68,3650.18,284.78,0,0,0,0,171,530,0,171,3,0,0,0,0,23422,23422
歐格利拉,2531.1,7322.09,373.64,0,0,0,0,172,530,0,172,0,0,0,0,0,23422,23422
任務 - 亞吉歐飛行開始,-5141.36,620.11,82.7,0,0,0,0,173,530,0,173,0,0,0,0,0,23468,23468
任務 - 亞吉歐飛行開始結束,-1636.09,5275.87,-41.1,0,0,0,0,174,530,0,174,0,0,0,0,0,0,0
泥鏈營地，塵泥沼澤,-4566.23,-3226.05,34.7,0,0,0,0,179,1,0,179,3,0,0,0,0,2224,541
任務 - 塵泥 - 勘察奧卡茲開始,-3822.66,-4511.33,10.84,0,0,0,0,180,1,0,180,0,0,0,0,0,0,541
任務 - 塵泥 - 勘察奧卡茲結束,-3822.71,-4509.65,10.98,0,0,0,0,181,1,0,181,0,0,0,0,0,0,541
反抗軍營地，荊棘谷,-11343.97,-216.83,75.22,0,0,0,0,195,0,0,195,1,0,0,0,0,0,541
Test SP2,2066.8,-4999.82,251.28,0,0,0,0,197,1,0,197,0,0,0,0,0,0,0
Test SP1,1340.02,-4631.29,54.41,0,0,0,0,198,1,0,198,0,0,0,0,0,24489,541
開發之地 - 凱爾·雷度開始,15992.44,-16371.94,76.73,0,0,0,0,201,451,0,201,3,0,0,0,0,23468,23468
開發之地 - 凱爾·雷度結束,15991.68,-16371.95,76.7,0,0,0,0,202,451,0,202,0,0,0,0,0,0,0
祖阿曼，鬼魂之地,6789.79,-7747.58,126.51,0,0,0,0,205,530,0,205,3,0,0,0,0,3574,541
傳送，羽月要塞(東北方船),-4348.01,2427.29,6.64,0,0,0,0,206,1,0,206,0,0,0,0,0,0,0
任務 - 太陽之井每日 - 死亡之痕轟炸 - 開始,13008.38,-6911.81,9.58,0,0,0,0,209,530,0,209,2,0,0,0,0,25044,0
任務 - 太陽之井每日 - 死亡之痕轟炸 - 結束,13008.51,-6912.2,9.58,0,0,0,0,210,530,0,210,0,0,0,0,0,25044,0
任務 - 太陽之井每日 - 轟炸船隻 - 開始,13007.5,-6911.81,9.58,0,0,0,0,211,530,0,211,2,0,0,0,0,25044,0
任務 - 太陽之井每日 - 轟炸船隻 - 結束,13188.04,-7047.04,4.79,0,0,0,0,212,530,0,212,2,0,0,0,0,25044,0
破碎之日會所,13012.7,-6908.37,9.58,0,0,0,0,213,530,96423,213,11,0,0,0,0,19917,19917
,3051.76,3690.41,142.63,0,0,0,0,220,530,0,220,0,0,0,0,0,5403,0
]]

L.taxiNodes = addon.LoadCSVData(taxiNodesCSV, "ID")