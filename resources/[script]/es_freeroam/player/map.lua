local blips = {
   -- -- Airport and Airfield
   -- {name="Airport", id=90, x=-1032.690, y=-2728.141, z=13.757},
   -- {name="Airport", id=90, x=1743.6820, y=3286.2510, z=40.087},
   -- -- barbers
   -- {name="Barber", id=71, x=-827.333, y=-190.916, z=37.599},
   -- {name="Barber", id=71, x=130.512, y=-1715.535, z=29.226},
   -- {name="Barber", id=71, x=-1291.472, y=-1117.230, z=6.641},
   -- {name="Barber", id=71, x=1936.451, y=3720.533, z=32.638},
   -- {name="Barber", id=71, x=1200.214, y=-468.822, z=66.268},
   -- {name="Barber", id=71, x=-30.109, y=-141.693, z=57.041},
   -- {name="Barber", id=71, x=-285.238, y=6236.365, z=31.455},
   -- -- Stores
    -- {name="Store", id=52, x=28.463, y=-1353.033, z=29.340},
    -- {name="Store", id=52, x=-54.937, y=-1759.108, z=29.005},
    -- {name="Store", id=52, x=375.858, y=320.097, z=103.433},
    -- {name="Store", id=52, x=1143.813, y=-980.601, z=46.205},
    -- {name="Store", id=52, x=1695.284, y=4932.052, z=42.078},
    -- {name="Store", id=52, x=2686.051, y=3281.089, z=55.241},
    -- {name="Store", id=52, x=1967.648, y=3735.871, z=32.221},
    -- {name="Store", id=52, x=-2977.137, y=390.652, z=15.024},
    -- {name="Store", id=52, x=1160.269, y=-333.137, z=68.783},
    -- {name="Store", id=52, x=-1492.784, y=-386.306, z=39.798},
    -- {name="Store", id=52, x=-1229.355, y=-899.230, z=12.263},
    -- {name="Store", id=52, x=-712.091, y=-923.820, z=19.014},
    -- {name="Store", id=52, x=-1816.544, y=782.072, z=137.600},
    -- {name="Store", id=52, x=1729.689, y=6405.970, z=34.453},
    -- {name="Store", id=52, x=2565.705, y=385.228, z=108.463},
    -- -- Clothing
    -- {name="Clothing", id=73, x=88.291, y=-1391.929, z=29.200},
    -- {name="Clothing", id=73, x=-718.985, y=-158.059, z=36.996},
    -- {name="Clothing", id=73, x=-151.204, y=-306.837, z=38.724},
    -- {name="Clothing", id=73, x=414.646, y=-807.452, z=29.338},
    -- {name="Clothing", id=73, x=-815.193, y=-1083.333, z=11.022},
    -- {name="Clothing", id=73, x=-1208.098, y=-782.020, z=17.163},
    -- {name="Clothing", id=73, x=-1457.954, y=-229.426, z=49.185},
    -- {name="Clothing", id=73, x=-2.777, y=6518.491, z=31.533},
    -- {name="Clothing", id=73, x=1681.586, y=4820.133, z=42.046},
    -- {name="Clothing", id=73, x=130.216, y=-202.940, z=54.505},
    -- {name="Clothing", id=73, x=618.701, y=2740.564, z=41.905},
    -- {name="Clothing", id=73, x=1199.169, y=2694.895, z=37.866},
    -- {name="Clothing", id=73, x=-3164.172, y=1063.927, z=20.674},
    -- {name="Clothing", id=73, x=-1091.373, y=2702.356, z=19.422},
    -- -- ammunationblips
    -- {name="Weapon store", id=110, x=1701.292, y=3750.450, z=34.365},
    -- {name="Weapon store", id=110, x=237.428, y=-43.655, z=69.698},
    -- {name="Weapon store", id=110, x=843.604, y=-1017.784, z=27.546},
    -- {name="Weapon store", id=110, x=-321.524, y=6072.479, z=31.299},
    -- {name="Weapon store", id=110, x=-664.218, y=-950.097, z=21.509},
    -- {name="Weapon store", id=110, x=-1320.983, y=-389.260, z=36.483},
    -- {name="Weapon store", id=110, x=-1109.053, y=2686.300, z=18.775},
    -- {name="Weapon store", id=110, x=2568.379, y=309.629, z=108.461},
    -- {name="Weapon store", id=110, x=-3157.450, y=1079.633, z=20.692},
    -- -- Basic
    -- {name="Comedy Club", id=102, x=377.088, y=-991.869, z=-97.604},
    -- {name="Franklin", id=210, x=7.900, y=548.100, z=175.500},
    -- {name="Franklin", id=210, x=-14.128,	y=-1445.483,	z=30.648},
    -- {name="Michael", id=124, x=-852.400, y=160.000, z=65.600},
    -- {name="Trevor", id=208, x=1985.700, y=3812.200, z=32.200},
    -- {name="Trevor", id=208, x=-1159.034,	y=-1521.180, z=10.633},
    -- {name="FIB", id=106, x=105.455, y=-745.483, z=44.754},
    -- {name="Lifeinvader", id=77, x=-1047.900, y=-233.000, z=39.000},
    -- {name="Cluckin Bell", id=357, x=-72.68752, y=6253.72656, z=31.08991},
    -- {name="Tequil-La La", id=93, x=-565.171, y=276.625, z=83.286},
    -- {name="O'Neil Ranch", id=438, x=2441.200, y=4968.500, z=51.700},
    -- {name="Play Boy Mansion", id=439, x=-1475.234, y=167.088, z=55.841},
    -- {name="Hippy Camp", id=140, x=2476.712, y=3789.645, z=41.226},
    --{name="Chop shop", id=446, x=479.056, y=-1316.825, z=28.203},
	--{name="Chop shop", id=446, x=1008.35, y=-1316.825, z=28.203},
    -- {name="Rebel Radio", id=136, x=736.153, y=2583.143, z=79.634},
    -- {name="Morgue", id=310, x=243.351, y=-1376.014, z=39.534},
    -- {name="Golf", id=109, x=-1336.715, y=59.051, z=55.246 },
    -- {name="Jewelry Store", id=52,  x=-630.400, y=-236.700, z=40.00},
    -- -- Propperty
    -- {name="Casino", id=207, x=925.329, y=46.152, z=80.908 },
    -- {name="Maze Bank Arena", id=135, x=-250.604, y=-2030.000, z=30.000},
    -- {name="Stripbar", id=121, x=134.476, y=-1307.887, z=28.983},
    -- {name="Smoke on the Water", id=140, x=-1171.42, y=-1572.72, z=3.6636},
    -- {name="Weed Farm", id=140, x=2208.777, y=5578.235, z=53.735},
    -- {name="Downtown Cab Co", id=375, x=900.461, y=-181.466, z=73.89},
    -- {name="Theater", id=135, x=293.089, y=180.466, z=104.301},
    -- -- Gangs
    -- {name="Gang", id=437, x=298.68, y=-2010.10, z=20.07},
    -- {name="Gang", id=437, x=86.64, y=-1924.60, z=20.79},
    -- {name="Gang", id=437, x=-183.52, y=-1632.62, z=33.34},
    -- {name="Gang", id=437, x=989.37, y=-1777.56, z=31.32},
    -- {name="Gang", id=437, x=960.24, y=-140.31, z=74.50},
    -- {name="Gang", id=437, x=-1042.29, y=4910.17, z=94.92},
    -- Gas stations
    {name="Station Essence", id=361, x=49.4187,   y=2778.793,  z=58.043},
    {name="Station Essence", id=361, x=263.894,   y=2606.463,  z=44.983},
    {name="Station Essence", id=361, x=1039.958,  y=2671.134,  z=39.550},
    {name="Station Essence", id=361, x=1207.260,  y=2660.175,  z=37.899},
    {name="Station Essence", id=361, x=2539.685,  y=2594.192,  z=37.944},
    {name="Station Essence", id=361, x=2679.858,  y=3263.946,  z=55.240},
    {name="Station Essence", id=361, x=2005.055,  y=3773.887,  z=32.403},
    {name="Station Essence", id=361, x=1687.156,  y=4929.392,  z=42.078},
    {name="Station Essence", id=361, x=1701.314,  y=6416.028,  z=32.763},
    {name="Station Essence", id=361, x=179.857,   y=6602.839,  z=31.868},
    {name="Station Essence", id=361, x=-94.4619,  y=6419.594,  z=31.489},
    {name="Station Essence", id=361, x=-2554.996, y=2334.40,  z=33.078},
    {name="Station Essence", id=361, x=-1800.375, y=803.661,  z=138.651},
    {name="Station Essence", id=361, x=-1437.622, y=-276.747,  z=46.207},
    {name="Station Essence", id=361, x=-2096.243, y=-320.286,  z=13.168},
    {name="Station Essence", id=361, x=-724.619, y=-935.1631,  z=19.213},
    {name="Station Essence", id=361, x=-526.019, y=-1211.003,  z=18.184},
    {name="Station Essence", id=361, x=-70.2148, y=-1761.792,  z=29.534},
    {name="Station Essence", id=361, x=265.648,  y=-1261.309,  z=29.292},
    {name="Station Essence", id=361, x=819.653,  y=-1028.846,  z=26.403},
    {name="Station Essence", id=361, x=1208.951, y= -1402.567, z=35.224},
    {name="Station Essence", id=361, x=1181.381, y= -330.847,  z=69.316},
    {name="Station Essence", id=361, x=620.843,  y= 269.100,  z=103.089},
    {name="Station Essence", id=361, x=2581.321, y=362.039, 108.468},
    -- Police Stations
    {name="Poste de Police", id=60, x=425.130, y=-979.558, z=30.711},
    {name="Poste de Police", id=60, x=1859.234, y= 3678.742, z=33.690},
    {name="Poste de Police", id=60, x=-438.862, y=6020.768, z=31.490},
    {name="Poste de Police", id=60, x=818.221, y=-1289.883, z=26.300},
    {name="Prison", id=285, x=1679.049, y=2513.711, z=45.565},
    -- Hospitals
    -- {name="Hospital", id=61, x= 1839.6, y= 3672.93, z= 34.28},
    -- {name="Hospital", id=61, x= -247.76, y= 6331.23, z=32.43},
     {name="Hospital", id=61, x= -449.67, y= -340.83, z= 34.50},
    -- {name="Hospital", id=61, x= 357.43, y= -593.36, z= 28.79},
    -- {name="Hospital", id=61, x= 295.83, y= -1446.94, z= 29.97},
    -- {name="Hospital", id=61, x= -676.98, y= 310.68, z= 83.08},
    -- {name="Hospital", id=61, x= 1151.21, y= -1529.62, z= 35.37},
    -- {name="Hospital", id=61, x= -874.64, y= -307.71, z= 39.58},
    -- Vehicle Shop (Simeon)
    -- {name="Simeon", id=120, x=-33.803, y=-1102.322, z=25.422},
    -- -- LS Customs
    -- {name="LS Customs", id=72, x= -362.796, y= -132.400, z= 38.252},
    -- {name="LS Customs", id=72, x= -1140.19, y= -1985.478, z= 12.729},
    -- {name="LS Customs", id=72, x= 716.464, y= -1088.869, z= 21.929},
    -- {name="LS Customs", id=72, x= 1174.81, y= 2649.954, z= 37.371},
    -- {name="LS Customs", id=72, x= 118.485, y= 6619.560, z= 31.802},
    -- -- Lester
    -- {name="Lester", id=77, x=1248.183, y=-1728.104, z=56.000},
    -- {name="Lester", id=77, x=719.000, y=-975.000, y=25.000},
    -- -- Survivals
    -- {name="Survival", id=305, x=2351.331, y=3086.969, z=48.057},
    -- {name="Survival", id=305, x=-1695.803, y=-1139.190, z=13.152},
    -- {name="Survival", id=305, x=1532.52, y=-2138.682, z=77.120},
    -- {name="Survival", id=305, x=-593.724, y=5283.231, z=70.230},
    -- {name="Survival", id=305, x=1891.436, y=3737.409, z=32.513},
    -- {name="Survival", id=305, x=195.572, y=-942.493, z=30.692},
    -- {name="Survival", id=305, x=1488.579, y=3582.804, z=35.345},

    -- {name="Safehouse", id=357, x=-952.35943603516, y= -1077.5021972656, z=2.6772258281708},
    -- {name="Safehouse", id=357, x=-59.124889373779, y= -616.55456542969, z=37.356777191162},
    -- {name="Safehouse", id=357, x=-255.05390930176, y= -943.32885742188, z=31.219989776611},
    -- {name="Safehouse", id=357, x=-771.79888916016, y= 351.59423828125, z=87.998191833496},
    -- {name="Safehouse", id=357, x=-3086.428, y=339.252, z=6.371},
    -- {name="Safehouse", id=357, x=-917.289, y=-450.206, z=39.600},
	-- Safehouses
    -- {name="Logement", id=357, x=-63.292, y= -616.444, z=34.265},
    -- {name="Logement", id=357, x=-1446.868, y= -538.276, z=32.820},
    -- {name="Logement", id=357, x=-937.054382324219, y= -379.453918457031, z=36.9613342285156},
    -- {name="Logement", id=357, x=-614.111328125, y= 45.2735786437988, z=41.5914611816406},
    -- {name="Logement", id=357, x=-770.377319335938, y=317.040802001953, z=83.6626510620117},
    -- {name="Logement", id=357, x=-175.676788330078, y=502.43408203125, z=135.420684814453},
    -- {name="Logement", id=357, x=347.220794677734, y=441.418212890625, z=145.701843261719},
    -- {name="Logement", id=357, x=373.370208740234, y=428.043243408203, z=143.684555053711},
    -- {name="Logement", id=357, x=-686.790588378906, y=596.580810546875, z=141.642028808594},
    -- {name="Logement", id=357, x=-751.216918945313, y=621.410888671875, z=140.261199951172},
    -- {name="Logement", id=357, x=-853.353759765625, y=696.033020019531, z=146.784759521484},
	-- {name="Logement", id=357, x=119.131958007813, y=564.880004882813, z=181.959335327148},
	-- {name="Logement", id=357, x=-1294.97436523438, y=455.17041015625, z=95.4321670532227},

    -- {name="Race", id=316, x=-1277.629, y=-2030.913, z=1.2823},
    -- {name="Race", id=316, x=2384.969, y=4277.583, z=30.379},
    -- {name="Race", id=316, x=1577.881, y=3836.107, z=30.7717},
    -- Yacht
    {name="Yacht", id=410, x=-2045.800, y=-1031.200, z=11.900},
    {name="Cargo", id=410, x=-90.000, y=-2365.800, z=14.300},
  }

Citizen.CreateThread(function()

    for _, item in pairs(blips) do
      item.blip = AddBlipForCoord(item.x, item.y, item.z)
      SetBlipSprite(item.blip, item.id)
      SetBlipAsShortRange(item.blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(item.name)
      EndTextCommandSetBlipName(item.blip)
    end

  --load unloaded ipl's
  LoadMpDlcMaps()
  EnableMpDlcMaps(true)
  
                                                                                                                                                                                                                                                                                                                                                                                                            
RequestIpl("chop_props")
RemoveIpl("FIBlobbyfake")
RequestIpl("FBI_colPLUG")
RequestIpl("FBI_repair")
RequestIpl("v_tunnel_hole")
RequestIpl("TrevorsMP")
RequestIpl("TrevorsTrailer")
RemoveIpl("CS1_02_cf_offmission")
RequestIpl("CS1_02_cf_onmission1")                                                                                                                                                                                                                                                                                                                                                                                                
RequestIpl("CS1_02_cf_onmission2")                                                                                                                                                                                                                                                                                                                                                                                                
RequestIpl("CS1_02_cf_onmission3")                                                                                                                                                                                                                                                                                                                                                                                                
RequestIpl("CS1_02_cf_onmission4")     
RequestIpl("v_rockclub")
RemoveIpl("v_carshowroom")
RemoveIpl("shutter_open")
RemoveIpl("shutter_closed")
RemoveIpl("shr_int")
RemoveIpl("csr_inMission")
RequestIpl("v_carshowroom")
RequestIpl("shr_int")
RequestIpl("shutter_closed")
RequestIpl("railing_start")
RemoveIpl("sp1_10_fake_interior")
RemoveIpl("sp1_10_fake_interior_lod")
RequestIpl("sp1_10_real_interior")
RequestIpl("sp1_10_real_interior_lod")
RemoveIpl("id2_14_during_door")
RemoveIpl("id2_14_during1")
RemoveIpl("id2_14_during2")
RemoveIpl("id2_14_on_fire")
RemoveIpl("id2_14_post_no_int")
RemoveIpl("id2_14_pre_no_int")
RemoveIpl("id2_14_during_door")
RequestIpl("id2_14_during1")
RequestIpl("coronertrash")
RequestIpl("Coroner_Int_on")
RemoveIpl("Coroner_Int_off")
RemoveIpl("bh1_16_refurb")
RemoveIpl("jewel2fake")
RemoveIpl("bh1_16_doors_shut")
RequestIpl("refit_unload")
RequestIpl("post_hiest_unload")
RequestIpl("Carwash_with_spinners")
RequestIpl("ferris_finale_Anim")
RemoveIpl("ch1_02_closed")
RequestIpl("ch1_02_open")
RequestIpl("AP1_04_TriAf01")
RequestIpl("CS2_06_TriAf02")
RequestIpl("CS4_04_TriAf03")
RemoveIpl("scafstartimap")
RequestIpl("scafendimap")
RemoveIpl("DT1_05_HC_REMOVE")
RequestIpl("DT1_05_HC_REQ")
RequestIpl("DT1_05_REQUEST")
RemoveIpl("DT1_03_Shutter")
RemoveIpl("DT1_03_Gr_Closed")
RequestIpl("ex_sm_13_office_01a")
RequestIpl("ex_sm_13_office_01b")
RequestIpl("ex_sm_13_office_02a")
RequestIpl("ex_sm_13_office_02b")
RequestIpl("redCarpet")                                                                                                                                                                                                                                                                                                                                                                                                 
RequestIpl("apa_ss1_11_flats")                                                                                                                                                                                                                                                                                                                                                                                                    
RequestIpl("ss1_11_ss1_emissive_a")                                                                                                                                                                                                                                                                                                                                                                                               
RequestIpl("ss1_11_detail01b")                                                                                                                                                                                                                                                                                                                                                                                                    
RequestIpl("ss1_11_Flats_LOD")                                                                                                                                                                                                                                                                                                                                                                                                    
RequestIpl("SS1_02_Building01_LOD")                                                                                                                                                                                                                                                                                                                                                                                               
RequestIpl("SS1_LOD_01_02_08_09_10_11")                                                                                                                                                                                                                                                                                                                                                                                           
RequestIpl("SS1_02_SLOD1")                                                                                                                                                                                                                                                                                                                                                                                                        
RequestIpl("apa_ss1_02_building01")                                                                                                                                                                                                                                                                                                                                                                                               
RequestIpl("SS1_Emissive_SS1_02a_LOD")                                                                                                                                                                                                                                                                                                                                                                                            
RequestIpl("ss1_02_ss1_emissive_ss1_02")                                                                                                                                                                                                                                                                                                                                                                                          
RequestIpl("hei_dt1_03_build1x")                                                                                                                                                                                                                                                                                                                                                                                                  
RequestIpl("DT1_Emissive_DT1_03_b1")                                                                                                                                                                                                                                                                                                                                                                                              
RequestIpl("dt1_03_dt1_Emissive_b1")                                                                                                                                                                                                                                                                                                                                                                                              
RequestIpl("apa_ch2_05e_res5")                                                                                                                                                                                                                                                                                                                                                                                                    
RequestIpl("apa_ch2_05e_res5_LOD")                                                                                                                                                                                                                                                                                                                                                                                                
RequestIpl("apa_ch2_09c_hs07")                                                                                                                                                                                                                                                                                                                                                                                                    
RequestIpl("ch2_09c_build_11_07_LOD")                                                                                                                                                                                                                                                                                                                                                                                             
RequestIpl("CH2_09c_Emissive_07_LOD")                                                                                                                                                                                                                                                                                                                                                                                             
RequestIpl("apa_ch2_09c_build_11_07_LOD")                                                                                                                                                                                                                                                                                                                                                                                         
RequestIpl("ch2_09c_hs07_details")                                                                                                                                                                                                                                                                                                                                                                                                
RequestIpl("CH2_09c_Emissive_07")                                                                                                                                                                                                                                                                                                                                                                                                 
RequestIpl("dt1_11_dt1_emissive_dt1_11")                                                                                                                                                                                                                                                                                                                                                                                          
RequestIpl("dt1_11_dt1_tower")                                                                                                                                                                                                                                                                                                                                                                                                    
RequestIpl("ex_dt1_11_office_01a")                                                                                                                                                                                                                                                                                                                                                                                                
RequestIpl("ex_dt1_11_office_01b")                                                                                                                                                                                                                                                                                                                                                                                                
RequestIpl("ex_dt1_11_office_01c")                                                                                                                                                                                                                                                                                                                                                                                                
RequestIpl("ex_dt1_11_office_02a")                                                                                                                                                                                                                                                                                                                                                                                                
RequestIpl("ex_dt1_11_office_02b")                                                                                                                                                                                                                                                                                                                                                                                                
RequestIpl("ex_dt1_11_office_02c")                                                                                                                                                                                                                                                                                                                                                                                                
RequestIpl("ex_dt1_11_office_03a")                                                                                                                                                                                                                                                                                                                                                                                                
RequestIpl("ex_dt1_11_office_03b")                                                                                                                                                                                                                                                                                                                                                                                                
RequestIpl("ex_dt1_11_office_03c")                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
RequestIpl("v_ilev_bs_door")                                                                                                                                                                                                                                                                                                                                                                                                      
RequestIpl("v_ilev_hd_door_l")                                                                                                                                                                                                                                                                                                                                                                                                    
RequestIpl("v_ilev_hd_door_r")                                                                                                                                                                                                                                                                                                                                                                                                    
RequestIpl("v_ilev_cs_door01")                                                                                                                                                                                                                                                                                                                                                                                                    
RequestIpl("v_ilev_cs_door01_r")                                                                                                                                                                                                                                                                                                                                                                                                  
RequestIpl("v_ilev_clothmiddoor")                                                                                                                                                                                                                                                                                                                                                                                                 
RequestIpl("v_ilev_ch_glassdoor")                                                                                                                                                                                                                                                                                                                                                                                                 
RequestIpl("v_ilev_ta_door")                                                                                                                                                                                                                                                                                                                                                                                                      
RequestIpl("v_ilev_mm_doorm_l")                                                                                                                                                                                                                                                                                                                                                                                                   
RequestIpl("v_ilev_mm_doorm_r")                                                                                                                                                                                                                                                                                                                                                                                                   
RequestIpl("prop_ld_garaged_01")                                                                                                                                                                                                                                                                                                                                                                                                  
RequestIpl("prop_bh1_48_backdoor_l")                                                                                                                                                                                                                                                                                                                                                                                              
RequestIpl("prop_bh1_48_backdoor_r")                                                                                                                                                                                                                                                                                                                                                                                              
RequestIpl("prop_bh1_48_gate_1")                                                                                                                                                                                                                                                                                                                                                                                                  
RequestIpl("v_ilev_mm_windowwc")                                                                                                                                                                                                                                                                                                                                                                                                  
RequestIpl("v_ilev_fa_frontdoor")                                                                                                                                                                                                                                                                                                                                                                                                 
RequestIpl("v_ilev_fh_frntdoor")                                                                                                                                                                                                                                                                                                                                                                                                  
RequestIpl("prop_sc1_21_g_door_01")                                                                                                                                                                                                                                                                                                                                                                                               
RequestIpl("v_ilev_fh_frontdoor")                                                                                                                                                                                                                                                                                                                                                                                                 
RequestIpl("v_ilev_trevtraildr")                                                                                                                                                                                                                                                                                                                                                                                                  
RequestIpl("prop_cs4_10_tr_gd_01")                                                                                                                                                                                                                                                                                                                                                                                                
RequestIpl("v_ilev_trev_doorfront")                                                                                                                                                                                                                                                                                                                                                                                               
RequestIpl("prop_com_ls_door_01")                                                                                                                                                                                                                                                                                                                                                                                                 
RequestIpl("prop_id2_11_gdoor")                                                                                                                                                                                                                                                                                                                                                                                                   
RequestIpl("v_ilev_carmod3door")                                                                                                                                                                                                                                                                                                                                                                                                  
RequestIpl("v_ilev_janitor_frontdoor")                                                                                                                                                                                                                                                                                                                                                                                            
RequestIpl("v_ilev_ss_door8")                                                                                                                                                                                                                                                                                                                                                                                                     
RequestIpl("v_ilev_ss_door7")                                                                                                                                                                                                                                                                                                                                                                                                     
RequestIpl("v_ilev_ss_door02")                                                                                                                                                                                                                                                                                                                                                                                                    
RequestIpl("v_ilev_ss_door03")                                                                                                                                                                                                                                                                                                                                                                                                    
RequestIpl("v_ilev_store_door")                                                                                                                                                                                                                                                                                                                                                                                                   
RequestIpl("v_ilev_ss_door04")                                                                                                                                                                                                                                                                                                                                                                                                    
RequestIpl("prop_ron_door_01")        
RequestIpl("v_ilev_bank4door02")                                                                                                                                                                                                                                                                                                                                                                                                  
RequestIpl("v_ilev_bank4door01")                                                                                                                                                                                                                                                                                                                                                                                                  
RequestIpl("v_ilev_lester_doorfront")                                                                                                                                                                                                                                                                                                                                                                                             
RequestIpl("v_ilev_lester_doorveranda")                                                                                                                                                                                                                                                                                                                                                                                           
RequestIpl("v_ilev_deviantfrontdoor")                                                                                                                                                                                                                                                                                                                                                                                             
RequestIpl("prop_com_gar_door_01")                                                                                                                                                                                                                                                                                                                                                                                                
RequestIpl("v_ilev_cs_door")                                                                                                                                                                                                                                                                                                                                                                                                      
RequestIpl("prop_strip_door_01")                                                                                                                                                                                                                                                                                                                                                                                                  
RequestIpl("prop_magenta_door")                                                                                                                                                                                                                                                                                                                                                                                                   
RequestIpl("prop_motel_door_09")                                                                                                                                                                                                                                                                                                                                                                                                  
RequestIpl("v_ilev_gangsafedoor")                                                                                                                                                                                                                                                                                                                                                                                                 
RequestIpl("v_ilev_ra_door1_l")                                                                                                                                                                                                                                                                                                                                                                                                   
RequestIpl("v_ilev_ra_door1_r")                                                                                                                                                                                                                                                                                                                                                                                                   
RequestIpl("prop_cs6_03_door_l")                                                                                                                                                                                                                                                                                                                                                                                                  
RequestIpl("prop_cs6_03_door_r")                                                                                                                                                                                                                                                                                                                                                                                                  
RequestIpl("prop_gar_door_01")                                                                                                                                                                                                                                                                                                                                                                                                    
RequestIpl("prop_gar_door_02")                                                                                                                                                                                                                                                                                                                                                                                                    
RequestIpl("prop_map_door_01")                                                                                                                                                                                                                                                                                                                                                                                                    
RequestIpl("v_ilev_fib_door1")                                                                                                                                                                                                                                                                                                                                                                                                    
RequestIpl("v_ilev_tort_door")                                                                                                                                                                                                                                                                                                                                                                                                    
RequestIpl("v_ilev_bl_shutter2")                                                                                                                                                                                                                                                                                                                                                                                                  
RequestIpl("v_ilev_rc_door3_l")                                                                                                                                                                                                                                                                                                                                                                                                   
RequestIpl("v_ilev_rc_door3_r")                                                                                                                                                                                                                                                                                                                                                                                                   
RequestIpl("prop_epsilon_door_l")                                                                                                                                                                                                                                                                                                                                                                                                 
RequestIpl("prop_epsilon_door_r")                                                                                                                                                                                                                                                                                                                                                                                                 
RequestIpl("prop_ch2_09c_garage_door")                                                                                                                                                                                                                                                                                                                                                                                            
RequestIpl("v_ilev_door_orangesolid")                                                                                                                                                                                                                                                                                                                                                                                             
RequestIpl("prop_cs4_05_tdoor")                                                                                                                                                                                                                                                                                                                                                                                                   
RequestIpl("v_ilev_housedoor1")                                                                                                                                                                                                                                                                                                                                                                                                   
RequestIpl("p_cut_door_03")                                                                                                                                                                                                                                                                                                                                                                                                       
RequestIpl("p_cut_door_02")                                                                                                                                                                                                                                                                                                                                                                                                       
RequestIpl("v_ilev_po_door")                                                                                                                                                                                                                                                                                                                                                                                                      
RequestIpl("prop_ss1_10_door_l")                                                                                                                                                                                                                                                                                                                                                                                                  
RequestIpl("prop_ss1_10_door_r")                                                                                                                                                                                                                                                                                                                                                                                                  
RequestIpl("v_ilev_fibl_door02")                                                                                                                                                                                                                                                                                                                                                                                                  
RequestIpl("v_ilev_fibl_door01")                                                                                                                                                                                                                                                                                                                                                                                                  
RequestIpl("v_ilev_ct_door01")                                                                                                                                                                                                                                                                                                                                                                                                    
RequestIpl("ap1_02_door_l")                                                                                                                                                                                                                                                                                                                                                                                                       
RequestIpl("ap1_02_door_r")                                                                                                                                                                                                                                                                                                                                                                                                       
RequestIpl("v_ilev_fb_doorshortl")                                                                                                                                                                                                                                                                                                                                                                                                
RequestIpl("v_ilev_fb_doorshortr")                                                                                                                                                                                                                                                                                                                                                                                                
RequestIpl("v_ilev_fb_door01")                                                                                                                                                                                                                                                                                                                                                                                                    
RequestIpl("v_ilev_fb_door02")                                                                                                                                                                                                                                                                                                                                                                                                    
RequestIpl("v_ilev_gtdoor")                                                                                                                                                                                                                                                                                                                                                                                                       
RequestIpl("prop_damdoor_01")                                                                                                                                                                                                                                                                                                                                                                                                     
RequestIpl("v_ilev_genbankdoor2")                                                                                                                                                                                                                                                                                                                                                                                                 
RequestIpl("v_ilev_genbankdoor1")                                                                                                                                                                                                                                                                                                                                                                                                 
RequestIpl("v_ilev_roc_door4")                                                                                                                                                                                                                                                                                                                                                                                                    
RequestIpl("p_jewel_door_l")                                                                                                                                                                                                                                                                                                                                                                                                      
RequestIpl("p_jewel_door_r1")                                                                                                                                                                                                                                                                                                                                                                                                     
RequestIpl("v_ilev_bk_door")                                                                                                                                                                                                                                                                                                                                                                                                      
RequestIpl("v_ilev_shrf2door")                                                                                                                                                                                                                                                                                                                                                                                                    
RequestIpl("v_ilev_shrfdoor")                                                                                                                                                                                                                                                                                                                                                                                                     
RequestIpl("prop_bhhotel_door_l")                                                                                                                                                                                                                                                                                                                                                                                                 
RequestIpl("prop_bhhotel_door_r")                                                                                                                                                                                                                                                                                                                                                                                                 
RequestIpl("prop_ch3_04_door_01l")                                                                                                                                                                                                                                                                                                                                                                                                
RequestIpl("prop_ch3_04_door_01r")                                                                                                                                                                                                                                                                                                                                                                                                
RequestIpl("prop_ch3_01_trlrdoor_l")                                                                                                                                                                                                                                                                                                                                                                                              
RequestIpl("prop_ch3_01_trlrdoor_r")                                                                                                                                                                                                                                                                                                                                                                                              
RequestIpl("v_ilev_gc_door04")                                                                                                                                                                                                                                                                                                                                                                                                    
RequestIpl("v_ilev_gc_door03")                                                                                                                                                                                                                                                                                                                                                                                                    
RequestIpl("v_ilev_gc_door01")                                                                                                                                                                                                                                                                                                                                                                                                    
RequestIpl("prop_lrggate_01c_l")                                                                                                                                                                                                                                                                                                                                                                                                  
RequestIpl("prop_lrggate_01c_r")                                                                                                                                                                                                                                                                                                                                                                                                  
RequestIpl("v_ilev_bl_doorel_l")                                                                                                                                                                                                                                                                                                                                                                                                  
RequestIpl("v_ilev_bl_doorel_r")                                                                                                                                                                                                                                                                                                                                                                                                  
RequestIpl("v_ilev_cbankcountdoor01")                                                                                                                                                                                                                                                                                                                                                                                             
RequestIpl("prop_fnclink_03gate5")                                                                                                                                                                                                                                                                                                                                                                                                
RequestIpl("v_ilev_csr_door_l")                                                                                                                                                                                                                                                                                                                                                                                                   
RequestIpl("v_ilev_csr_door_r")                                                                                                                                                                                                                                                                                                                                                                                                   
RequestIpl("v_ilev_abbmaindoor")                                                                                                                                                                                                                                                                                                                                                                                                  
RequestIpl("v_ilev_abbmaindoor2")                                                                                                                                                                                                                                                                                                                                                                                                 
RequestIpl("prop_ch3_04_door_02")                                                                                                                                                                                                                                                                                                                                                                                                 
RequestIpl("prop_ch1_07_door_01l")                                                                                                                                                                                                                                                                                                                                                                                                
RequestIpl("prop_ch1_07_door_01r")                                                                                                                                                                                                                                                                                                                                                                                                
RequestIpl("prop_gar_door_04")                                                                                                                                                                                                                                                                                                                                                                                                    
RequestIpl("prop_gate_tep_01_l")                                                                                                                                                                                                                                                                                                                                                                                                  
RequestIpl("prop_gate_tep_01_r")                                                                                                                                                                                                                                                                                                                                                                                                  
RequestIpl("prop_artgallery_02_dr")                                                                                                                                                                                                                                                                                                                                                                                               
RequestIpl("prop_artgallery_02_dl")                                                                                                                                                                                                                                                                                                                                                                                               
RequestIpl("prop_fnclink_07gate1")                                                                                                                                                                                                                                                                                                                                                                                                
RequestIpl("prop_abat_slide")                                                                                                                                                                                                                                                                                                                                                                                                     
RemoveIpl("facelobbyfake")                                                                                                                                                                                                                                                                                                                                                                                                       
RemoveIpl("fakeint")                                                                                                                                                                                                                                                                                                                                                                                                             
RequestIpl("vb_30_crimetape")                                                                                                                                                                                                                                                                                                                                                                                                     
   
                                                                                                                                                                                                                                                                                                                                                                                                     
RequestIpl("sheriff_cap")                                                                                                                                                                                                                                                                                                                                                                                                  
RequestIpl("v_sheriff2")                                                                                                                                                                                                                                                                                                                                                                                                         
RemoveIpl("CS1_16_sheriff_cap")                                                                                                                                                                                                                                                                                                                                                                                                  
RequestIpl("chemgrill_grp1") 
                                                                                                                                                                                                                                                                                                                                                                                               
                                                                                                                                                                                                                                                                                                                                                                                                    
                                                                                                                                                                                                                                                                                                                                                                                                    
RemoveIpl("RC12B_Fixed")   
RemoveIpl("RC12B_Default")                                                                                                                                                                                                                                                                                                                                                                                                       
RemoveIpl("Hospitaldoorsfixed")                                                                                                                                                                                                                                                                                                                                                                                                  
RequestIpl("RC12B_Destroyed")  
RequestIpl("RC12B_HospitalInterior")
 
                                                                                                                                                                                                                                                                                                                                                                                                 
RequestIpl("DT1_03_Shutter")                                                                                                                                                                                                                                                                                                                                                                                                      
RequestIpl("ch1_02_closed")                                                                                                                                                                                                                                                                                                                                                                                                       
RequestIpl("facelobby")                                                                                                                                                                                                                                                                                                                                                                                                           
RequestIpl("shr_int")                                                                                                                                                                                                                                                                                                                                                                                                             
RequestIpl("FIBlobby")                                                                                                                                                                                                                                                                                                                                                                                                            
RequestIpl("post_hiest_unload")                                                                                                                                                                                                                                                                                                                                                                                                   
                                                                                                                                                                                                                                                                                                                                                                                                      
                                                                                                                                                                                                                                                                                                                                                                                           
                                                                                                                                                                                                                                                                                                                                                                                            
RequestIpl("burnt_switch_off")                                                                                                                                                                                                                                                                                                                                                                                                    
RequestIpl("farm")                                                                                                                                                                                                                                                                                                                                                                                                                
RequestIpl("farmint")                                                                                                                                                                                                                                                                                                                                                                                                             
RequestIpl("des_farmhouse")                                                                                                                                                                                                                                                                                                                                                                                                       
                                                                                                                                                                                                                                                                                                                                                                                                     
RequestIpl("FINBANK")                                                                                                                                                                                                                                                                                                                                                                                                             
RequestIpl("ch1_02_open")                                                                                                                                                                                                                                                                                                                                                                                                         
RequestIpl("hei_yacht_heist")                                                                                                                                                                                                                                                                                                                                                                                                     
RequestIpl("hei_yacht_heist_enginrm")                                                                                                                                                                                                                                                                                                                                                                                             
RequestIpl("hei_yacht_heist_lounge")                                                                                                                                                                                                                                                                                                                                                                                              
RequestIpl("hei_yacht_heist_bridge")                                                                                                                                                                                                                                                                                                                                                                                              
RequestIpl("hei_yacht_heist_bar")                                                                                                                                                                                                                                                                                                                                                                                                 
RequestIpl("hei_yacht_heist_bedrm")                                                                                                                                                                                                                                                                                                                                                                                               
RequestIpl("hei_carrier")                                                                                                                                                                                                                                                                                                                                                                                                         
RequestIpl("hei_Carrier_int1")                                                                                                                                                                                                                                                                                                                                                                                                    
RequestIpl("hei_Carrier_int2")                                                                                                                                                                                                                                                                                                                                                                                                    
RequestIpl("hei_Carrier_int3")                                                                                                                                                                                                                                                                                                                                                                                                    
RequestIpl("hei_Carrier_int4")                                                                                                                                                                                                                                                                                                                                                                                                    
RequestIpl("hei_Carrier_int5")                                                                                                                                                                                                                                                                                                                                                                                                    
RequestIpl("hei_Carrier_int6")                                                                                                                                                                                                                                                                                                                                                                                                    
RequestIpl("hei_yacht_heist_distantlights")                                                                                                                                                                                                                                                                                                                                                                                       
RequestIpl("hei_yacht_heist_lodlights")                                                                                                                                                                                                                                                                                                                                                                                           
RequestIpl("hei_carrier_DistantLights")  
RequestIpl("hei_bh1_33_interior_v_cinema_milo_")                                                                                                                                                                                                                                                                                                                                                                                         
RequestIpl("hei_carrier_LODLights")                                                                                                                                                                                                                                                                                                                                                                                               
RequestIpl("lr_cs6_08_grave_closed")                                                                                                                                                                                                                                                                                                                                                                                              
RequestIpl("bkr_bi_id1_23_door")                                                                                                                                                                                                                                                                                                                                                                                                  
RequestIpl("Apa_V_mp_h_0%d_A")                                                                                                                                                                                                                                                                                                                                                                                                    
RequestIpl("lower_walls_default")                                                                                                                                                                                                                                                                                                                                                                                                 
RequestIpl("Furnishings_02")                                                                                                                                                                                                                                                                                                                                                                                                      
RequestIpl("Walls_02")                                                                                                                                                                                                                                                                                                                                                                                                            
RequestIpl("Decorative_02")                                                                                                                                                                                                                                                                                                                                                                                                       
RequestIpl("Mural_02")                                                                                                                                                                                                                                                                                                                                                                                                            
RequestIpl("Furnishings_01")                                                                                                                                                                                                                                                                                                                                                                                                      
RequestIpl("Walls_01")                                                                                                                                                                                                                                                                                                                                                                                                            
RequestIpl("Decorative_01")                                                                                                                                                                                                                                                                                                                                                                                                       
RequestIpl("Mural_01")                                                                                                                                                                                                                                                                                                                                                                                                            
RequestIpl("V_57_FranklinStuff")                                                                                                                                                                                                                                                                                                                                                                                                  
RequestIpl("swap_clean_apt")                                                                                                                                                                                                                                                                                                                                                                                                      
RequestIpl("layer_whiskey")                                                                                                                                                                                                                                                                                                                                                                                                      
RequestIpl("layer_sextoys_a")                                                                                                                                                                                                                                                                                                                                                                                                     
RequestIpl("swap_mrJam_A")                                                                                                                                                                                                                                                                                                                                                                                                        
RequestIpl("swap_sofa_A")                                                                                                                                                                                                                                                                                                                                                                                                         
RequestIpl("V_Michael_bed_tidy")                                                                                                                                                                                                                                                                                                                                                                                                  
RequestIpl("V_Michael_L_Items")                                                                                                                                                                                                                                                                                                                                                                                                   
RequestIpl("V_Michael_S_Items")                                                                                                                                                                                                                                                                                                                                                                                                   
RequestIpl("V_Michael_D_Items")                                                                                                                                                                                                                                                                                                                                                                                                   
RequestIpl("V_Michael_M_Items")                                                                                                                                                                                                                                                                                                                                                                                                   
RequestIpl("Michael_premier")                                                                                                                                                                                                                                                                                                                                                                                                     
RequestIpl("V_Michael_plane_ticket")                                                                                                                                                                                                                                                                                                                                                                                              
RequestIpl("showhome_only")                                                                                                                                                                                                                                                                                                                                                                                                       
RequestIpl("franklin_settled")                                                                                                                                                                                                                                                                                                                                                                                                    
RequestIpl("franklin_unpacking")                                                                                                                                                                                                                                                                                                                                                                                                  
RequestIpl("bong_and_wine") 
 RequestIpl("FIBlobby")
  RemoveIpl("FIBlobbyfake")
  RequestIpl("TrevorsTrailerTidy")
  RemoveIpl("farm_burnt")
  RemoveIpl("farm_burnt_lod")
  RemoveIpl("farm_burnt_props")
  RemoveIpl("farmint_cap")
  RemoveIpl("farmint_cap_lod")
  RequestIpl("farm")
  RequestIpl("farmint")
  RequestIpl("farm_lod")
  RequestIpl("farm_props")
  RequestIpl("facelobby")
  RemoveIpl("smboat")
  RequestIpl("cargoship")
  RemoveIpl("sp1_10_fake_interior")
  RequestIpl("sp1_10_real_interior")
  RequestIpl("Coroner_Int_on")
RequestIpl("post_hiest_unload")
  RequestIpl("Carwash_with_spinners")
  RequestIpl("ferris_finale_Anim")
  RemoveIpl("ch1_02_closed")
  RequestIpl("ch1_02_open")
  RequestIpl("AP1_04_TriAf01")
  RequestIpl("CS2_06_TriAf02")
  RequestIpl("CS4_04_TriAf03")
  RemoveIpl("scafstartimap")
  RequestIpl("scafendimap")
  RemoveIpl("DT1_05_HC_REMOVE")
  RequestIpl("DT1_05_HC_REQ")
  RequestIpl("DT1_05_REQUEST")
  RequestIpl("FINBANK")
  RemoveIpl("DT1_03_Shutter")
  RemoveIpl("DT1_03_Gr_Closed")
  RequestIpl("ex_sm_13_office_01a")
  RequestIpl("ex_sm_13_office_01b")
  RequestIpl("ex_sm_13_office_02a")
  RequestIpl("ex_sm_13_office_02b") 
  
  RemoveIpl("hei_bi_hw1_13_door")
  RequestIpl("bkr_bi_hw1_13_int")      

  RemoveIpl("trailerparkA_grp1")
  RemoveIpl("trailerparkA_grp2")
  RemoveIpl("occl_trailerA_grp1")
  RemoveIpl("trailerparkB_grp1")
  RemoveIpl("trailerparkB_grp2")
  RemoveIpl("occl_trailerB_grp1")
  RemoveIpl("trailerparkC_grp1")
  RemoveIpl("trailerparkC_grp2")
  RemoveIpl("occl_trailerC_grp1")
  RemoveIpl("trailerparkD_grp1")
  RemoveIpl("trailerparkD_grp2")
  RemoveIpl("occl_trailerD_grp1")
  RemoveIpl("trailerparkE_grp1")
  RemoveIpl("trailerparkE_grp2")
  RemoveIpl("occl_trailerE_grp1")
  RemoveIpl("des_methtrailer")
  RemoveIpl("methtrailer_grp1")
  RemoveIpl("methtrailer_grp2")
  RemoveIpl("methtrailer_grp3")
  RemoveIpl("occl_meth_grp1")
  RemoveIpl("occl_meth_grp1")
  RequestIpl("trailerparkA_grp1")
  RequestIpl("occl_trailerA_grp1")
  RequestIpl("trailerparkB_grp1")
  RequestIpl("occl_trailerB_grp1")
  RequestIpl("trailerparkC_grp1")
  RequestIpl("occl_trailerC_grp1")
  RequestIpl("trailerparkD_grp1")
  RequestIpl("occl_trailerD_grp1")
  RequestIpl("trailerparkE_grp1")
  RequestIpl("occl_trailerE_grp1")
  RequestIpl("occl_meth_grp1")
  RequestIpl("methtrailer_grp1")
  
  	-- -- Simeon: -47.16170 -1115.3327 26.5
--RequestIpl("shr_int")

	-- -- Trevor: 1985.48132, 3828.76757, 32.5
	-- -- Trash or Tidy. Only choose one.
--RequestIpl("TrevorsTrailerTrash")
--RequestIpl("trevorstrailertidy")
	
	-- -- Heist Jewel: -637.20159 -239.16250 38.1
--RequestIpl("post_hiest_unload")
	
	-- Max Renda: -585.8247, -282.72, 35.45475
		RequestIpl("refit_unload")
  
	-- -- Heist Union Depository: 2.69689322, -667.0166, 16.1306286
--RequestIpl("FINBANK")

	-- -- Morgue: 239.75195, -1360.64965, 39.53437
--RequestIpl("Coroner_Int_on")
--RequestIpl("coronertrash")
	
	-- -- Cluckin Bell: -146.3837, 6161.5, 30.2062
--RequestIpl("CS1_02_cf_onmission1")
--RequestIpl("CS1_02_cf_onmission2")
--RequestIpl("CS1_02_cf_onmission3")
--		 RequestIpl("CS1_02_cf_onmission4")
	
	-- -- Grapeseed's farm: 2447.9, 4973.4, 47.7
--		 RequestIpl("farm")
--		 RequestIpl("farmint")
--		 RequestIpl("farm_lod")
--		 RequestIpl("farm_props")
--		 RequestIpl("des_farmhouse")
	
	-- -- FIB lobby: 105.4557, -745.4835, 44.7548
--		 RequestIpl("FIBlobby")
	
	-- Billboard: iFruit
		RequestIpl("FruitBB")
		RequestIpl("sc1_01_newbill")
		RequestIpl("hw1_02_newbill")
		RequestIpl("hw1_emissive_newbill")
		RequestIpl("sc1_14_newbill")
		RequestIpl("dt1_17_newbill")

	-- -- Lester's factory: 716.84, -962.05, 31.59
--		 RequestIpl("id2_14_during_door")
--		 RequestIpl("id2_14_during1")
	
	-- -- Life Invader lobby: -1047.9, -233.0, 39.0
--		 RequestIpl("facelobby")
	
	-- -- Tunnels
--		 RequestIpl("v_tunnel_hole")

	-- Carwash: 55.7, -1391.3, 30.5
		RequestIpl("Carwash_with_spinners")
	
	-- -- Stadium "Fame or Shame": -248.49159240722656, -2010.509033203125, 34.57429885864258
--		 RequestIpl("sp1_10_real_interior")
--		 RequestIpl("sp1_10_real_interior_lod")
	
	-- House in Banham Canyon: -3086.428, 339.2523, 6.3717
		RequestIpl("ch1_02_open")
		
	-- Garage in La Mesa (autoshop): 970.27453, -1826.56982, 31.11477
		RequestIpl("bkr_bi_id1_23_door")
		
	-- Hill Valley church - Grave: -282.46380000, 2835.84500000, 55.91446000
		RequestIpl("lr_cs6_08_grave_closed")
	
	-- -- Lost's trailer park: 49.49379000, 3744.47200000, 46.38629000
--		 RequestIpl("methtrailer_grp1")
		
	-- Raton Canyon river: -1652.83, 4445.28, 2.52
		RequestIpl("CanyonRvrShallow")	
		
	-- Zancudo Gates (GTAO like): -1600.30100000, 2806.73100000, 18.79683000
		RequestIpl("CS3_07_MPGates")
		
	-- Pillbox hospital:
		RequestIpl("rc12b_default")

	-- Josh's house: -1117.1632080078, 303.090698, 66.52217
		RequestIpl("bh1_47_joshhse_unburnt")
		RequestIpl("bh1_47_joshhse_unburnt_lod")

	-- -- Optional
		-- -- Bahama Mamas: -1388.0013, -618.41967, 30.819599
--			 RequestIpl("hei_sm_16_interior_v_bahama_milo_")
		
		-- Lost safehouse: 984.1552, -95.3662, 74.50
			RequestIpl("bkr_bi_hw1_13_int")

		-- -- Heist Carrier: 3082.3117 -4717.1191 15.2622
--			 RequestIpl("hei_carrier")
--			 RequestIpl("hei_carrier_distantlights")
--			 RequestIpl("hei_Carrier_int1")
--			 RequestIpl("hei_Carrier_int2")
--			 RequestIpl("hei_Carrier_int3")
--			 RequestIpl("hei_Carrier_int4")
--			 RequestIpl("hei_Carrier_int5")
--			 RequestIpl("hei_Carrier_int6")
--			 RequestIpl("hei_carrier_lodlights")
--			 RequestIpl("hei_carrier_slod")
		
		-- -- Heist Yatch: -2043.974,-1031.582, 11.981
--			 RequestIpl("hei_yacht_heist")
--			 RequestIpl("hei_yacht_heist_Bar")
--			 RequestIpl("hei_yacht_heist_Bedrm")
--			 RequestIpl("hei_yacht_heist_Bridge")
--			 RequestIpl("hei_yacht_heist_DistantLights")
--			 RequestIpl("hei_yacht_heist_enginrm")
--			 RequestIpl("hei_yacht_heist_LODLights")
--			--RequestIpl("hei_yacht_heist_Lounge")
			
			--load unloaded ipl's
			

-- TEST NEWS IPL FOX

RequestIpl("chop_props")
--
RemoveIpl("v_carshowroom")
RemoveIpl("shutter_open")
RemoveIpl("shutter_closed")
RemoveIpl("shr_int")
RemoveIpl("csr_inMission")
RequestIpl("v_carshowroom")
RequestIpl("shutter_closed")
--
RequestIpl("TrevorsMP")
--RequestIpl("TrevorsTrailer")
RequestIpl("TrevorsTrailerTidy")
--
RequestIpl("post_hiest_unload")
--
RequestIpl("refit_unload")
--
RequestIpl("FINBANK")
--
RemoveIpl("Coroner_Int_off")
RequestIpl("coronertrash")
RequestIpl("Coroner_Int_on")
--
RemoveIpl("CS1_02_cf_offmission")
RequestIpl("CS1_02_cf_onmission1")
RequestIpl("CS1_02_cf_onmission2")
RequestIpl("CS1_02_cf_onmission3")
RequestIpl("CS1_02_cf_onmission4")
--
RemoveIpl("farm_burnt")
RemoveIpl("farm_burnt_lod")
RemoveIpl("farm_burnt_props")
RemoveIpl("farmint_cap")
RemoveIpl("farmint_cap_lod")
RequestIpl("farm")
RequestIpl("farmint")
RequestIpl("farm_lod")
RequestIpl("farm_props")
RequestIpl("des_farmhouse")
--
RemoveIpl("FIBlobbyfake")
RequestIpl("FIBlobby")
RequestIpl("FBI_colPLUG")
RequestIpl("FBI_repair")
--
RequestIpl("FruitBB")
RequestIpl("sc1_01_newbill")
RequestIpl("hw1_02_newbill")
RequestIpl("hw1_emissive_newbill")
RequestIpl("sc1_14_newbill")
RequestIpl("dt1_17_newbill")
--
RemoveIpl("id2_14_during_door")
RemoveIpl("id2_14_during1")
RemoveIpl("id2_14_during2")
RemoveIpl("id2_14_on_fire")
RemoveIpl("id2_14_post_no_int")
RemoveIpl("id2_14_pre_no_int")
RemoveIpl("id2_14_during_door")
RequestIpl("id2_14_during1")
--
RequestIpl("facelobby")
--
RequestIpl("v_tunnel_hole")
--
RequestIpl("Carwash_with_spinners")
--
RemoveIpl("sp1_10_fake_interior")
RemoveIpl("sp1_10_fake_interior_lod")
RequestIpl("sp1_10_real_interior")
RequestIpl("sp1_10_real_interior_lod")
--
RemoveIpl("ch1_02_closed")
RequestIpl("ch1_02_open")
-- Garage in La Mesa (autoshop): 970.27453, -1826.56982, 31.11477
RequestIpl("bkr_bi_id1_23_door")
-- Hill Valley church - Grave: -282.46380000, 2835.84500000, 55.91446000
RequestIpl("lr_cs6_08_grave_closed")
-- Lost's trailer park: 49.49379000, 3744.47200000, 46.38629000
RequestIpl("methtrailer_grp1")
-- Raton Canyon river: -1652.83, 4445.28, 2.52
RequestIpl("CanyonRvrShallow")	
-- Zancudo Gates (GTAO like): -1600.30100000, 2806.73100000, 18.79683000
RequestIpl("CS3_07_MPGates")
--
RemoveIpl("RC12B_Default")
RemoveIpl("RC12B_Fixed")
RequestIpl("RC12B_Destroyed")
RequestIpl("RC12B_HospitalInterior")
--
RequestIpl("bh1_47_joshhse_unburnt")
RequestIpl("bh1_47_joshhse_unburnt_lod")
-- Bahama Mamas: -1388.0013, -618.41967, 30.819599
RequestIpl("hei_sm_16_interior_v_bahama_milo_")
-- Lost safehouse: 984.1552, -95.3662, 74.50
RemoveIpl("hei_bi_hw1_13_door")
RequestIpl("bkr_bi_hw1_13_int")
-- Heist Carrier: 3082.3117 -4717.1191 15.2622
RequestIpl("hei_carrier")
RequestIpl("hei_carrier_distantlights")
RequestIpl("hei_Carrier_int1")
RequestIpl("hei_Carrier_int2")
RequestIpl("hei_Carrier_int3")
RequestIpl("hei_Carrier_int4")
RequestIpl("hei_Carrier_int5")
RequestIpl("hei_Carrier_int6")
RequestIpl("hei_carrier_lodlights")
RequestIpl("hei_carrier_slod")
-- Heist Yatch: -2043.974,-1031.582, 11.981
RequestIpl("hei_yacht_heist")
RequestIpl("hei_yacht_heist_Bar")
RequestIpl("hei_yacht_heist_Bedrm")
RequestIpl("hei_yacht_heist_Bridge")
RequestIpl("hei_yacht_heist_DistantLights")
RequestIpl("hei_yacht_heist_enginrm")
RequestIpl("hei_yacht_heist_LODLights")
RequestIpl("hei_yacht_heist_Lounge")
--
-- Red Carpet: 300.5927, 199.7589, 104.3776
--RequestIpl("redCarpet") 

-- UFO
-- Zancudo: -2051.99463, 3237.05835, 1456.97021
-- Hippie base: 2490.47729, 3774.84351, 2414.035
-- Chiliad: 501.52880000, 5593.86500000, 796.23250000
-- RequestIpl("ufo")
-- RequestIpl("ufo_eye")
-- RequestIpl("ufo_lod")

-- North Yankton: 3217.697, -4834.826, 111.8152
-- RequestIpl("prologue01")
-- RequestIpl("prologue01c")
-- RequestIpl("prologue01d")
-- RequestIpl("prologue01e")
-- RequestIpl("prologue01f")
-- RequestIpl("prologue01g")
-- RequestIpl("prologue01h")
-- RequestIpl("prologue01i")
-- RequestIpl("prologue01j")
-- RequestIpl("prologue01k")
-- RequestIpl("prologue01z")
-- RequestIpl("prologue02")
-- RequestIpl("prologue03")
-- RequestIpl("prologue03b")
-- RequestIpl("prologue04")
-- RequestIpl("prologue04b")
-- RequestIpl("prologue05")
-- RequestIpl("prologue05b")
-- RequestIpl("prologue06")
-- RequestIpl("prologue06b")
-- RequestIpl("prologue06_int")
-- RequestIpl("prologuerd")
-- RequestIpl("prologuerdb ")
-- RequestIpl("prologue_DistantLights")
-- RequestIpl("prologue_LODLights")
-- RequestIpl("prologue_m2_door")

--
RequestIpl("v_rockclub")
--
RequestIpl("cargoship")
RequestIpl("railing_start")
--
RemoveIpl("bh1_16_refurb")
RemoveIpl("jewel2fake")
RemoveIpl("bh1_16_doors_shut")
--
RequestIpl("ferris_finale_Anim")
--
RequestIpl("AP1_04_TriAf01")
RequestIpl("CS2_06_TriAf02")
RequestIpl("CS4_04_TriAf03")
--
RemoveIpl("scafstartimap")
RequestIpl("scafendimap")
--
RemoveIpl("DT1_05_HC_REMOVE")
RequestIpl("DT1_05_HC_REQ")
RequestIpl("DT1_05_REQUEST")
--
RemoveIpl("DT1_03_Shutter")
RemoveIpl("DT1_03_Gr_Closed")
--
RequestIpl("ex_sm_13_office_01a")
RequestIpl("ex_sm_13_office_01b")
RequestIpl("ex_sm_13_office_02a")
RequestIpl("ex_sm_13_office_02b")
--
RequestIpl("v_hospital")
--
-- RequestIpl("redCarpet")
-- online appartments
RequestIpl("apa_v_mp_h_01_a")
RequestIpl("apa_v_mp_h_01_c")
RequestIpl("apa_v_mp_h_01_b")

RequestIpl("apa_v_mp_h_02_a")
RequestIpl("apa_v_mp_h_02_c")
RequestIpl("apa_v_mp_h_02_b")

RequestIpl("apa_v_mp_h_03_a")
RequestIpl("apa_v_mp_h_03_c")
RequestIpl("apa_v_mp_h_03_b")

RequestIpl("apa_v_mp_h_04_a")
RequestIpl("apa_v_mp_h_04_c")
RequestIpl("apa_v_mp_h_04_b")

RequestIpl("apa_v_mp_h_05_a")
RequestIpl("apa_v_mp_h_05_c")
RequestIpl("apa_v_mp_h_05_b")

RequestIpl("apa_v_mp_h_06_a")
RequestIpl("apa_v_mp_h_06_c")
RequestIpl("apa_v_mp_h_06_b")

RequestIpl("apa_v_mp_h_07_a")
RequestIpl("apa_v_mp_h_07_c")
RequestIpl("apa_v_mp_h_07_b")

RequestIpl("apa_v_mp_h_08_a")
RequestIpl("apa_v_mp_h_08_c")
RequestIpl("apa_v_mp_h_08_b")

-- arcadius building center
RequestIpl("ex_dt1_02_office_02b")
-- RequestIpl("ex_dt1_02_office_02a")
-- RequestIpl("ex_dt1_02_office_02c")
-- RequestIpl("ex_dt1_02_office_01a")
RequestIpl("ex_dt1_02_office_01b")
-- RequestIpl("ex_dt1_02_office_01c")
-- RequestIpl("ex_dt1_02_office_03a")
RequestIpl("ex_dt1_02_office_03b")
-- RequestIpl("ex_dt1_02_office_03c")

-- maze bank
RequestIpl("ex_dt1_11_office_02b")
-- RequestIpl("ex_dt1_11_office_02c")
-- RequestIpl("ex_dt1_11_office_02c")
RequestIpl("ex_dt1_11_office_01a")
-- RequestIpl("ex_dt1_11_office_01b")
-- RequestIpl("ex_dt1_11_office_01c")
RequestIpl("ex_dt1_11_office_03a")
-- RequestIpl("ex_dt1_11_office_03b")
-- RequestIpl("ex_dt1_11_office_03c")


-- Lom Bank Corp Towers
RequestIpl("ex_dt1_13_office_02b")
-- RequestIpl("ex_dt1_13_office_02a")
-- RequestIpl("ex_dt1_13_office_02c")
RequestIpl("ex_dt1_13_office_01a")
-- RequestIpl("ex_dt1_13_office_01b")
-- RequestIpl("ex_dt1_13_office_01c")
RequestIpl("ex_dt1_13_office_03a")
-- RequestIpl("ex_dt1_13_office_03b")
-- RequestIpl("ex_dt1_13_office_03c")

-- maze bank west
RequestIpl("ex_dt1_15_office_02b")
-- RequestIpl("ex_dt1_15_office_02a")
-- RequestIpl("ex_dt1_15_office_02c")
RequestIpl("ex_dt1_15_office_01a")
-- RequestIpl("ex_dt1_15_office_01b")
-- RequestIpl("ex_dt1_15_office_01c")
-- RequestIpl("ex_dt1_15_office_03a")
RequestIpl("ex_dt1_15_office_03b")
-- RequestIpl("ex_dt1_15_office_03c")

-- biker clubhouses and warehouses
RequestIpl("bkr_biker_interior_placement_interior_0_biker_dlc_int_01_milo")
RequestIpl("bkr_biker_interior_placement_interior_1_biker_dlc_int_02_milo")
RequestIpl("bkr_biker_interior_placement_interior_2_biker_dlc_int_ware01_milo")
RequestIpl("bkr_biker_interior_placement_interior_3_biker_dlc_int_ware02_milo")
RequestIpl("bkr_biker_interior_placement_interior_4_biker_dlc_int_ware03_milo")
RequestIpl("bkr_biker_interior_placement_interior_5_biker_dlc_int_ware04_milo")
RequestIpl("bkr_biker_interior_placement_interior_6_biker_dlc_int_ware05_milo")
RequestIpl("ex_exec_warehouse_placement_interior_1_int_warehouse_s_dlc_milo")
RequestIpl("ex_exec_warehouse_placement_interior_0_int_warehouse_m_dlc_milo")
RequestIpl("ex_exec_warehouse_placement_interior_2_int_warehouse_l_dlc_milo")
RequestIpl("canyonriver01")
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local players = {}

    for i = 0, 31 do
      if NetworkIsPlayerActive(i) then
        table.insert(players, i)
      end
    end

    for k, v in pairs(players) do
      if not GetBlipFromEntity(GetPlayerPed(v)) then
        if GetPlayerPed(v) == GetPlayerPed(-1) then return end
        local blip = AddBlipForEntity(GetPlayerPed(v))
        SetBlipColour(blip, 1)
      end
    end
  end
end)
