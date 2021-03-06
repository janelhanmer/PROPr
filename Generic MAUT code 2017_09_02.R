propr.maut.function.201709 <- function(thetas){ 
 
  # DESCRIPTION This is the multi-attribute utility function, using isotonic
  # regression with linear interpolation for the single-attribute (dis)utility
  # functions. This code was written by Barry Dewitt in September 2017 using R
  # 3.4.0.
  
  # INPUTS
  # The input thetas must be a 7 element vector with the following components
  # (in order):
  #   - theta_cog is a score on the Cognitive Functioning - Abilities domain
  #   - theta_dep is a score on the Depression domain
  #   - theta_fat is a score on the Fatigue domain
  #   - theta_pain is a score on the Pain Interference domain
  #   - theta_phys is a score on the Physical Functioning domain
  #   - theta_slp is a score on the Sleep Disturbance domain
  #   - theta_sr is a score on the Ability to Participate in Social Roles 
  # and Activities domain
  
  # The thetas must be of the z-score form: usually a number from -3 to 3.
  # These are the scores constructed with a population mean of 0 and standard
  # deviation of 1. Note in particular, they should not be the "t-score" form.
  # These scores are transformations of the z-scores such that the population
  # mean is 50 and a standard deviation of 10.
  
  # OUTPUTS
  # A list with the following components:
  
  # PROPr -- A number (utility) on the dead = 0, full health = 1 scale. (Note
  # that 1 is the maximum possible value, but scores less than 0 are possible.)
  # One single-attribute utility score for each domain, where the utility of
  # the (disutility) corner state = 0, and full health = 1. (Note scores are
  # bounded by 0 and 1 for the single-attribute scales.) These components are
  # labeled by the domain names.
  
  # Label input components
  theta_cog <- thetas[1]
  theta_dep <- thetas[2]
  theta_fat <- thetas[3]
  theta_pain <- thetas[4]
  theta_phys <- thetas[5]
  theta_slp <- thetas[6]
  theta_sr <- thetas[7]
  
  # Values where the line segments of the isotonic regression with interpolation
  # change
  
  turncog1 <- -2.052
  turncog2 <- -1.565
  turncog3 <- -1.239
  turncog4 <- -0.902
  turncog5 <- -0.649
  turncog6 <- -0.367
  turncog7 <- -0.002
  turncog8 <- 0.52
  turncog9 <- 1.124
  
  turndep1 <- -1.082
  turndep2 <- -0.264
  turndep3 <- 0.151
  turndep4 <- 0.596
  turndep5 <- 0.913
  turndep6 <- 1.388
  turndep7 <- 1.742
  turndep8 <- 2.245
  turndep9 <- 2.703
  
  turnfat1 <- -1.648
  turnfat2 <- -0.818
  turnfat3 <- -0.094
  turnfat4 <- 0.303
  turnfat5 <- 0.87
  turnfat6 <- 1.124
  turnfat7 <- 1.688
  turnfat8 <- 2.053
  turnfat9 <- 2.423
  
  turnpain1 <- -0.773
  turnpain2 <- 0.1
  turnpain3 <- 0.462
  turnpain4 <- 0.827
  turnpain5 <- 1.072
  turnpain6 <- 1.407
  turnpain7 <- 1.724
  turnpain8 <- 2.169
  turnpain9 <- 2.725
  
  turnphys1 <- -2.575
  turnphys2 <- -2.174
  turnphys3 <- -1.784
  turnphys4 <- -1.377
  turnphys5 <- -0.787
  turnphys6 <- -0.443
  turnphys7 <- -0.211
  turnphys8 <- 0.16
  turnphys9 <- 0.966
  
  turnsleep1 <- -1.535
  turnsleep2 <- -0.775
  turnsleep3 <- -0.459
  turnsleep4 <- 0.093
  turnsleep5 <- 0.335
  turnsleep6 <- 0.82
  turnsleep7 <- 1.659
  turnsleep8 <- 1.934
  
  turnsocial1 <- -2.088
  turnsocial2 <- -1.634
  turnsocial3 <- -1.293
  turnsocial4 <- -0.955
  turnsocial5 <- -0.618
  turnsocial6 <- -0.276
  turnsocial7 <- 0.083
  turnsocial8 <- 0.494
  turnsocial9 <- 1.221
  
  # Slopes of each line segment specification
  
  slopecog1 <- -1.0047
  slopecog2 <- -0.1745
  slopecog3 <- -0.4223
  slopecog4 <- -0.1949
  slopecog5 <- -0.1082
  slopecog6 <- -0.2468
  slopecog7 <- -0.0176
  slopecog8 <- -0.2192
  
  
  slopedep1 <- 0.1572
  slopedep2 <- 0
  slopedep3 <- 0.1793
  slopedep4 <- 0.1817
  slopedep5 <- 0.4109
  slopedep6 <- 0.1887
  slopedep7 <- 0.2115
  slopedep8 <- 0.7983
  
  
  slopefat1 <- 0.1152
  slopefat2 <- 0.1077
  slopefat3 <- 0.1189
  slopefat4 <- 0.1277
  slopefat5 <- 0.222
  slopefat6 <- 0.0496
  slopefat7 <- 0.3233
  slopefat8 <- 1.3632
  
  
  slopepain1 <- 0.0891
  slopepain2 <- 0.1721
  slopepain3 <- 0.1022
  slopepain4 <- 0.4241
  slopepain5 <- 0.3815
  slopepain6 <- 0.3681
  slopepain7 <- 0.1169
  slopepain8 <- 0.7594
  
  
  slopephys1 <- -1.0761
  slopephys2 <- -0.1756
  slopephys3 <- -0.1764
  slopephys4 <- -0.1161
  slopephys5 <- -0.2721
  slopephys6 <- -0.4082
  slopephys7 <- -0.1695
  slopephys8 <- -0.1346
  
  
  slopesleep1 <- 0.1241
  slopesleep2 <- 0
  slopesleep3 <- 0.0797
  slopesleep4 <- 0.3455
  slopesleep5 <- 0.3148
  slopesleep6 <- 0.1238
  slopesleep7 <- 1.8964
  
  
  slopesocial1 <- -1.1152
  slopesocial2 <- -0.2874
  slopesocial3 <- -0.1352
  slopesocial4 <- -0.132
  slopesocial5 <- -0.4012
  slopesocial6 <- 0
  slopesocial7 <- -0.054
  slopesocial8 <- -0.201
  
  
  # Intercepts of each line segment specification
  
  interceptcog1 <- -1.0617
  interceptcog2 <- 0.2375
  interceptcog3 <- -0.0694
  interceptcog4 <- 0.1357
  interceptcog5 <- 0.192
  interceptcog6 <- 0.1411
  interceptcog7 <- 0.1416
  interceptcog8 <- 0.2464
  
  
  interceptdep1 <- 0.1701
  interceptdep2 <- 0.1286
  interceptdep3 <- 0.1015
  interceptdep4 <- 0.1001
  interceptdep5 <- -0.1092
  interceptdep6 <- 0.1993
  interceptdep7 <- 0.1595
  interceptdep8 <- -1.1577
  
  
  interceptfat1 <- 0.1898
  interceptfat2 <- 0.1837
  interceptfat3 <- 0.1848
  interceptfat4 <- 0.1821
  interceptfat5 <- 0.1
  interceptfat6 <- 0.2938
  interceptfat7 <- -0.1681
  interceptfat8 <- -2.3031
  
  
  interceptpain1 <- 0.0689
  interceptpain2 <- 0.0606
  interceptpain3 <- 0.0929
  interceptpain4 <- -0.1733
  interceptpain5 <- -0.1277
  interceptpain6 <- -0.1089
  interceptpain7 <- 0.3243
  interceptpain8 <- -1.0692
  
  
  interceptphys1 <- -1.7709
  interceptphys2 <- 0.1867
  interceptphys3 <- 0.1853
  interceptphys4 <- 0.2683
  interceptphys5 <- 0.1456
  interceptphys6 <- 0.0853
  interceptphys7 <- 0.1356
  interceptphys8 <- 0.13
  
  
  interceptsleep1 <- 0.1905
  interceptsleep2 <- 0.0943
  interceptsleep3 <- 0.1309
  interceptsleep4 <- 0.1062
  interceptsleep5 <- 0.1164
  interceptsleep6 <- 0.2731
  interceptsleep7 <- -2.6676
  
  
  interceptsocial1 <- -1.3285
  interceptsocial2 <- 0.0241
  interceptsocial3 <- 0.2209
  interceptsocial4 <- 0.2239
  interceptsocial5 <- 0.0576
  interceptsocial6 <- 0.1683
  interceptsocial7 <- 0.1728
  interceptsocial8 <- 0.2454
  
  
  # Corner state disutility values
  c_cognition <-  0.6350450
  c_depression <-  0.6661641
  c_fatigue <-  0.6386135
  c_pain <-  0.6529680
  c_physical <-  0.6883584
  c_sleep <-  0.5629657
  c_social <-  0.6112686
  C <-  -0.9991828
  
  # Constant for transforming from all-worst = 0 to dead = 0
  to_dead <-  1.021915
  
  # Create output of each single-attribute disutility function
  
  # Cognition Disutility.  Higher cognition scores are better.
  cog_disutility <- 1
  if(turncog1<=theta_cog & theta_cog <turncog2) {cog_disutility <- 
    interceptcog1 + theta_cog * slopecog1}
  if(turncog2<=theta_cog & theta_cog <turncog3) {cog_disutility <- 
    interceptcog2 + theta_cog * slopecog2}
  if(turncog3<=theta_cog & theta_cog <turncog4) {cog_disutility <- 
    interceptcog3 + theta_cog * slopecog3}
  if(turncog4<=theta_cog & theta_cog <turncog5) {cog_disutility <- 
    interceptcog4 + theta_cog * slopecog4}
  if(turncog5<=theta_cog & theta_cog <turncog6) {cog_disutility <- 
    interceptcog5 + theta_cog * slopecog5}
  if(turncog6<=theta_cog & theta_cog <turncog7) {cog_disutility <- 
    interceptcog6 + theta_cog * slopecog6}
  if(turncog7<=theta_cog & theta_cog <turncog8) {cog_disutility <- 
    interceptcog7 + theta_cog * slopecog7}
  if(turncog8<=theta_cog & theta_cog <turncog9) {cog_disutility <- 
    interceptcog8 + theta_cog * slopecog8}
  if(turncog9<=theta_cog) {cog_disutility <- 0}
  
  # Depression Disutility.  Lower depression scores are better
  dep_disutility <- 0
  if(turndep1<=theta_dep & theta_dep <turndep2) {dep_disutility <- 
    interceptdep1 + theta_dep * slopedep1}
  if(turndep2<=theta_dep & theta_dep <turndep3) {dep_disutility <- 
    interceptdep2 + theta_dep * slopedep2}
  if(turndep3<=theta_dep & theta_dep <turndep4) {dep_disutility <- 
    interceptdep3 + theta_dep * slopedep3}
  if(turndep4<=theta_dep & theta_dep <turndep5) {dep_disutility <- 
    interceptdep4 + theta_dep * slopedep4}
  if(turndep5<=theta_dep & theta_dep <turndep6) {dep_disutility <- 
    interceptdep5 + theta_dep * slopedep5}
  if(turndep6<=theta_dep & theta_dep <turndep7) {dep_disutility <- 
    interceptdep6 + theta_dep * slopedep6}
  if(turndep7<=theta_dep & theta_dep <turndep8) {dep_disutility <- 
    interceptdep7 + theta_dep * slopedep7}
  if(turndep8<=theta_dep & theta_dep <turndep9) {dep_disutility <- 
    interceptdep8 + theta_dep * slopedep8}
  if(turndep9<=theta_dep) {dep_disutility <- 1}
  
  
  # Fatigue Disutility.  Lower fatigue scores are better
  fat_disutility <- 0
  if(turnfat1<=theta_fat & theta_fat <turnfat2) {fat_disutility <- 
    interceptfat1 + theta_fat * slopefat1}
  if(turnfat2<=theta_fat & theta_fat <turnfat3) {fat_disutility <- 
    interceptfat2 + theta_fat * slopefat2}
  if(turnfat3<=theta_fat & theta_fat <turnfat4) {fat_disutility <- 
    interceptfat3 + theta_fat * slopefat3}
  if(turnfat4<=theta_fat & theta_fat <turnfat5) {fat_disutility <- 
    interceptfat4 + theta_fat * slopefat4}
  if(turnfat5<=theta_fat & theta_fat <turnfat6) {fat_disutility <- 
    interceptfat5 + theta_fat * slopefat5}
  if(turnfat6<=theta_fat & theta_fat <turnfat7) {fat_disutility <- 
    interceptfat6 + theta_fat * slopefat6}
  if(turnfat7<=theta_fat & theta_fat <turnfat8) {fat_disutility <- 
    interceptfat7 + theta_fat * slopefat7}
  if(turnfat8<=theta_fat & theta_fat <turnfat9) {fat_disutility <- 
    interceptfat8 + theta_fat * slopefat8}
  if(turnfat9<=theta_fat) {fat_disutility <- 1}
  
  
  #  Pain Disutility.  Lower pain scores are better
  pain_disutility <- 0
  if(turnpain1<=theta_pain & theta_pain <turnpain2) {pain_disutility <- 
    interceptpain1 + theta_pain * slopepain1}
  if(turnpain2<=theta_pain & theta_pain <turnpain3) {pain_disutility <- 
    interceptpain2 + theta_pain * slopepain2}
  if(turnpain3<=theta_pain & theta_pain <turnpain4) {pain_disutility <- 
    interceptpain3 + theta_pain * slopepain3}
  if(turnpain4<=theta_pain & theta_pain <turnpain5) {pain_disutility <- 
    interceptpain4 + theta_pain * slopepain4}
  if(turnpain5<=theta_pain & theta_pain <turnpain6) {pain_disutility <- 
    interceptpain5 + theta_pain * slopepain5}
  if(turnpain6<=theta_pain & theta_pain <turnpain7) {pain_disutility <- 
    interceptpain6 + theta_pain * slopepain6}
  if(turnpain7<=theta_pain & theta_pain <turnpain8) {pain_disutility <- 
    interceptpain7 + theta_pain * slopepain7}
  if(turnpain8<=theta_pain & theta_pain <turnpain9) {pain_disutility <- 
    interceptpain8 + theta_pain * slopepain8}
  if(turnpain9<=theta_pain) {pain_disutility <- 1}
  
  
  #  Physical Disutility.  Higher physical function scores are better
  physical_disutility <- 1
  if(turnphys1<=theta_phys & theta_phys <turnphys2) {physical_disutility <- 
    interceptphys1 + theta_phys * slopephys1}
  if(turnphys2<=theta_phys & theta_phys <turnphys3) {physical_disutility <- 
    interceptphys2 + theta_phys * slopephys2}
  if(turnphys3<=theta_phys & theta_phys <turnphys4) {physical_disutility <- 
    interceptphys3 + theta_phys * slopephys3}
  if(turnphys4<=theta_phys & theta_phys <turnphys5) {physical_disutility <- 
    interceptphys4 + theta_phys * slopephys4}
  if(turnphys5<=theta_phys & theta_phys <turnphys6) {physical_disutility <- 
    interceptphys5 + theta_phys * slopephys5}
  if(turnphys6<=theta_phys & theta_phys <turnphys7) {physical_disutility <- 
    interceptphys6 + theta_phys * slopephys6}
  if(turnphys7<=theta_phys & theta_phys <turnphys8) {physical_disutility <- 
    interceptphys7 + theta_phys * slopephys7}
  if(turnphys8<=theta_phys & theta_phys <turnphys9) {physical_disutility <- 
    interceptphys8 + theta_phys * slopephys8}
  if(turnphys9<=theta_phys) {physical_disutility <- 0}
  
  
  #  Sleep Disutility.  Lower sleep disturbance scores are better
  sleep_disutility <- 0
  if(turnsleep1<=theta_slp & theta_slp <turnsleep2) {sleep_disutility <- 
    interceptsleep1 + theta_slp * slopesleep1}
  if(turnsleep2<=theta_slp & theta_slp <turnsleep3) {sleep_disutility <- 
    interceptsleep2 + theta_slp * slopesleep2}
  if(turnsleep3<=theta_slp & theta_slp <turnsleep4) {sleep_disutility <- 
    interceptsleep3 + theta_slp * slopesleep3}
  if(turnsleep4<=theta_slp & theta_slp <turnsleep5) {sleep_disutility <- 
    interceptsleep4 + theta_slp * slopesleep4}
  if(turnsleep5<=theta_slp & theta_slp <turnsleep6) {sleep_disutility <- 
    interceptsleep5 + theta_slp * slopesleep5}
  if(turnsleep6<=theta_slp & theta_slp <turnsleep7) {sleep_disutility <- 
    interceptsleep6 + theta_slp * slopesleep6}
  if(turnsleep7<=theta_slp & theta_slp <turnsleep8) {sleep_disutility <- 
    interceptsleep7 + theta_slp * slopesleep7}
  if(turnsleep8<=theta_slp) {sleep_disutility <- 1}
  
  #  Social Disutility.  Higher social scores are better
  social_disutility <- 1
  if(turnsocial1<=theta_sr & theta_sr <turnsocial2) {social_disutility <- 
    interceptsocial1 + theta_sr * slopesocial1}
  if(turnsocial2<=theta_sr & theta_sr <turnsocial3) {social_disutility <- 
    interceptsocial2 + theta_sr * slopesocial2}
  if(turnsocial3<=theta_sr & theta_sr <turnsocial4) {social_disutility <- 
    interceptsocial3 + theta_sr * slopesocial3}
  if(turnsocial4<=theta_sr & theta_sr <turnsocial5) {social_disutility <- 
    interceptsocial4 + theta_sr * slopesocial4}
  if(turnsocial5<=theta_sr & theta_sr <turnsocial6) {social_disutility <- 
    interceptsocial5 + theta_sr * slopesocial5}
  if(turnsocial6<=theta_sr & theta_sr <turnsocial7) {social_disutility <- 
    interceptsocial6 + theta_sr * slopesocial6}
  if(turnsocial7<=theta_sr & theta_sr <turnsocial8) {social_disutility <- 
    interceptsocial7 + theta_sr * slopesocial7}
  if(turnsocial8<=theta_sr & theta_sr <turnsocial9) {social_disutility <- 
    interceptsocial8 + theta_sr * slopesocial8}
  if(turnsocial9<=theta_sr) {social_disutility <- 0}
  
  
  # Now, plug it into the multiattribute disutility function
  
  multi_attribute_disutility <- 
    (1/C) * ((1 + C * c_cognition * cog_disutility)*
               (1 + C * c_depression * dep_disutility)*
               (1 + C * c_fatigue * fat_disutility)*
               (1 + C * c_pain * pain_disutility)*
               (1 + C * c_physical * physical_disutility)*
               (1 + C * c_sleep * sleep_disutility)*
               (1 + C * c_social * social_disutility) - 1)
  
  
  # Now make it a utility, on the dead/full health scale 
  PROPr <- round(1 - to_dead * multi_attribute_disutility, 3)
  
  # Single attribute utility functions 
  cognition_utility <- round(1 - cog_disutility, 3)
  depression_utility <- round(1 - dep_disutility, 3)
  fatigue_utility <- round(1 - fat_disutility, 3)
  pain_utility <- round(1 - pain_disutility, 3)
  physical_utility <- round(1 - physical_disutility, 3)
  sleep_utility <- round(1 - sleep_disutility, 3)
  social_utility <- round(1 - social_disutility, 3)
  
  
  # Return PROPr multi-attribute score on dead-full health scale, and individual 
  # scores on each of the single-attribute functions, where 0 = disutility 
  # corner state and 1 = full health.
  propr.values <- list(PROPr = PROPr,
                       cognition = cognition_utility,
                       depression = depression_utility,
                       fatigue = fatigue_utility,
                       pain = pain_utility,
                       physical = physical_utility,
                       sleep = sleep_utility,
                       social = social_utility)
  
  return(propr.values)
}


