import numpy as np
# implementation of propr score for PROMIS
# https://doi.org/10.1177/0272989X18776637 (Dewitt et al 2018).


def get_propr_from_thetas(theta_dep, theta_fat, theta_pain, theta_phys, theta_slp, theta_sr, theta_cog):
    """
    :params are theta values of the seven domains. See below for conversion from tscores
    :return: (PROPr score, (cognition_utility, depression_utility, fatigue_utility, pain_utility, physical_utility, sleep_utility, social_utility))
    """
    to_dead = 1.021915
    turncog1 = -2.052
    turncog2 = -1.565
    turncog3 = -1.239
    turncog4 = -0.902
    turncog5 = -0.649
    turncog6 = -0.367
    turncog7 = -0.002
    turncog8 = 0.52
    turncog9 = 1.124
    turndep1 = -1.082
    turndep2 = -0.264
    turndep3 = 0.151
    turndep4 = 0.596
    turndep5 = 0.913
    turndep6 = 1.388
    turndep7 = 1.742
    turndep8 = 2.245
    turndep9 = 2.703
    turnfat1 = -1.648
    turnfat2 = -0.818
    turnfat3 = -0.094
    turnfat4 = 0.303
    turnfat5 = 0.87
    turnfat6 = 1.124
    turnfat7 = 1.688
    turnfat8 = 2.053
    turnfat9 = 2.423
    turnpain1 = -0.773
    turnpain2 = 0.1
    turnpain3 = 0.462
    turnpain4 = 0.827
    turnpain5 = 1.072
    turnpain6 = 1.407
    turnpain7 = 1.724
    turnpain8 = 2.169
    turnpain9 = 2.725
    turnphys1 = -2.575
    turnphys2 = -2.174
    turnphys3 = -1.784
    turnphys4 = -1.377
    turnphys5 = -0.787
    turnphys6 = -0.443
    turnphys7 = -0.211
    turnphys8 = 0.16
    turnphys9 = 0.966
    turnsleep1 = -1.535
    turnsleep2 = -0.775
    turnsleep3 = -0.459
    turnsleep4 = 0.093
    turnsleep5 = 0.335
    turnsleep6 = 0.82
    turnsleep7 = 1.659
    turnsleep8 = 1.934
    turnsocial1 = -2.088
    turnsocial2 = -1.634
    turnsocial3 = -1.293
    turnsocial4 = -0.955
    turnsocial5 = -0.618
    turnsocial6 = -0.276
    turnsocial7 = 0.083
    turnsocial8 = 0.494
    turnsocial9 = 1.221
    slopecog1 = -1.0047
    slopecog2 = -0.1745
    slopecog3 = -0.4223
    slopecog4 = -0.1949
    slopecog5 = -0.1082
    slopecog6 = -0.2468
    slopecog7 = -0.0176
    slopecog8 = -0.2192
    slopedep1 = 0.1572
    slopedep2 = 0
    slopedep3 = 0.1793
    slopedep4 = 0.1817
    slopedep5 = 0.4109
    slopedep6 = 0.1887
    slopedep7 = 0.2115
    slopedep8 = 0.7983
    slopefat1 = 0.1152
    slopefat2 = 0.1077
    slopefat3 = 0.1189
    slopefat4 = 0.1277
    slopefat5 = 0.222
    slopefat6 = 0.0496
    slopefat7 = 0.3233
    slopefat8 = 1.3632
    slopepain1 = 0.0891
    slopepain2 = 0.1721
    slopepain3 = 0.1022
    slopepain4 = 0.4241
    slopepain5 = 0.3815
    slopepain6 = 0.3681
    slopepain7 = 0.1169
    slopepain8 = 0.7594
    slopephys1 = -1.0761
    slopephys2 = -0.1756
    slopephys3 = -0.1764
    slopephys4 = -0.1161
    slopephys5 = -0.2721
    slopephys6 = -0.4082
    slopephys7 = -0.1695
    slopephys8 = -0.1346
    slopesleep1 = 0.1241
    slopesleep2 = 0
    slopesleep3 = 0.0797
    slopesleep4 = 0.3455
    slopesleep5 = 0.3148
    slopesleep6 = 0.1238
    slopesleep7 = 1.8964
    slopesocial1 = -1.1152
    slopesocial2 = -0.2874
    slopesocial3 = -0.1352
    slopesocial4 = -0.132
    slopesocial5 = -0.4012
    slopesocial6 = 0
    slopesocial7 = -0.054
    slopesocial8 = -0.201
    interceptcog1 = -1.0617
    interceptcog2 = 0.2375
    interceptcog3 = -0.0694
    interceptcog4 = 0.1357
    interceptcog5 = 0.192
    interceptcog6 = 0.1411
    interceptcog7 = 0.1416
    interceptcog8 = 0.2464
    interceptdep1 = 0.1701
    interceptdep2 = 0.1286
    interceptdep3 = 0.1015
    interceptdep4 = 0.1001
    interceptdep5 = -0.1092
    interceptdep6 = 0.1993
    interceptdep7 = 0.1595
    interceptdep8 = -1.1577
    interceptfat1 = 0.1898
    interceptfat2 = 0.1837
    interceptfat3 = 0.1848
    interceptfat4 = 0.1821
    interceptfat5 = 0.1
    interceptfat6 = 0.2938
    interceptfat7 = -0.1681
    interceptfat8 = -2.3031
    interceptpain1 = 0.0689
    interceptpain2 = 0.0606
    interceptpain3 = 0.0929
    interceptpain4 = -0.1733
    interceptpain5 = -0.1277
    interceptpain6 = -0.1089
    interceptpain7 = 0.3243
    interceptpain8 = -1.0692
    interceptphys1 = -1.7709
    interceptphys2 = 0.1867
    interceptphys3 = 0.1853
    interceptphys4 = 0.2683
    interceptphys5 = 0.1456
    interceptphys6 = 0.0853
    interceptphys7 = 0.1356
    interceptphys8 = 0.13
    interceptsleep1 = 0.1905
    interceptsleep2 = 0.0943
    interceptsleep3 = 0.1309
    interceptsleep4 = 0.1062
    interceptsleep5 = 0.1164
    interceptsleep6 = 0.2731
    interceptsleep7 = -2.6676
    interceptsocial1 = -1.3285
    interceptsocial2 = 0.0241
    interceptsocial3 = 0.2209
    interceptsocial4 = 0.2239
    interceptsocial5 = 0.0576
    interceptsocial6 = 0.1683
    interceptsocial7 = 0.1728
    interceptsocial8 = 0.2454
    c_cognition = 0.6350450
    c_depression = 0.6661641
    c_fatigue = 0.6386135
    c_pain = 0.6529680
    c_physical = 0.6883584
    c_sleep = 0.5629657
    c_social = 0.6112686
    C = -0.9991828

    cog_disutility = 1
    cog_disutility = interceptcog1 + theta_cog * slopecog1 if (turncog1 <= theta_cog) & (theta_cog < turncog2) else cog_disutility
    cog_disutility = interceptcog2 + theta_cog * slopecog2 if (turncog2 <= theta_cog) & (theta_cog < turncog3) else cog_disutility
    cog_disutility = interceptcog3 + theta_cog * slopecog3 if (turncog3 <= theta_cog) & (theta_cog < turncog4) else cog_disutility
    cog_disutility = interceptcog4 + theta_cog * slopecog4 if (turncog4 <= theta_cog) & (theta_cog < turncog5) else cog_disutility
    cog_disutility = interceptcog5 + theta_cog * slopecog5 if (turncog5 <= theta_cog) & (theta_cog < turncog6) else cog_disutility
    cog_disutility = interceptcog6 + theta_cog * slopecog6 if (turncog6 <= theta_cog) & (theta_cog < turncog7) else cog_disutility
    cog_disutility = interceptcog7 + theta_cog * slopecog7 if (turncog7 <= theta_cog) & (theta_cog < turncog8) else cog_disutility
    cog_disutility = interceptcog8 + theta_cog * slopecog8 if (turncog8 <= theta_cog) & (theta_cog < turncog9) else cog_disutility
    cog_disutility = 0 if turncog9 <= theta_cog else cog_disutility

    dep_disutility = 0
    dep_disutility = interceptdep1 + theta_dep * slopedep1 if (turndep1 <= theta_dep) & (theta_dep < turndep2) else dep_disutility
    dep_disutility = interceptdep2 + theta_dep * slopedep2 if (turndep2 <= theta_dep) & (theta_dep < turndep3) else dep_disutility
    dep_disutility = interceptdep3 + theta_dep * slopedep3 if (turndep3 <= theta_dep) & (theta_dep < turndep4) else dep_disutility
    dep_disutility = interceptdep4 + theta_dep * slopedep4 if (turndep4 <= theta_dep) & (theta_dep < turndep5) else dep_disutility
    dep_disutility = interceptdep5 + theta_dep * slopedep5 if (turndep5 <= theta_dep) & (theta_dep < turndep6) else dep_disutility
    dep_disutility = interceptdep6 + theta_dep * slopedep6 if (turndep6 <= theta_dep) & (theta_dep < turndep7) else dep_disutility
    dep_disutility = interceptdep7 + theta_dep * slopedep7 if (turndep7 <= theta_dep) & (theta_dep < turndep8) else dep_disutility
    dep_disutility = interceptdep8 + theta_dep * slopedep8 if (turndep8 <= theta_dep) & (theta_dep < turndep9) else dep_disutility
    dep_disutility = 1 if (turndep9 <= theta_dep) else dep_disutility

    fat_disutility = 0
    fat_disutility = interceptfat1 + theta_fat * slopefat1 if (turnfat1 <= theta_fat) & (theta_fat < turnfat2) else fat_disutility
    fat_disutility = interceptfat2 + theta_fat * slopefat2 if (turnfat2 <= theta_fat) & (theta_fat < turnfat3) else fat_disutility
    fat_disutility = interceptfat3 + theta_fat * slopefat3 if (turnfat3 <= theta_fat) & (theta_fat < turnfat4) else fat_disutility
    fat_disutility = interceptfat4 + theta_fat * slopefat4 if (turnfat4 <= theta_fat) & (theta_fat < turnfat5) else fat_disutility
    fat_disutility = interceptfat5 + theta_fat * slopefat5 if (turnfat5 <= theta_fat) & (theta_fat < turnfat6) else fat_disutility
    fat_disutility = interceptfat6 + theta_fat * slopefat6 if (turnfat6 <= theta_fat) & (theta_fat < turnfat7) else fat_disutility
    fat_disutility = interceptfat7 + theta_fat * slopefat7 if (turnfat7 <= theta_fat) & (theta_fat < turnfat8) else fat_disutility
    fat_disutility = interceptfat8 + theta_fat * slopefat8 if (turnfat8 <= theta_fat) & (theta_fat < turnfat9) else fat_disutility
    fat_disutility = 1 if turnfat9 <= theta_fat else fat_disutility

    pain_disutility = 0
    pain_disutility = interceptpain1 + theta_pain * slopepain1 if (turnpain1 <= theta_pain) & (theta_pain < turnpain2) else pain_disutility
    pain_disutility = interceptpain2 + theta_pain * slopepain2 if (turnpain2 <= theta_pain) & (theta_pain < turnpain3) else pain_disutility
    pain_disutility = interceptpain3 + theta_pain * slopepain3 if (turnpain3 <= theta_pain) & (theta_pain < turnpain4) else pain_disutility
    pain_disutility = interceptpain4 + theta_pain * slopepain4 if (turnpain4 <= theta_pain) & (theta_pain < turnpain5) else pain_disutility
    pain_disutility = interceptpain5 + theta_pain * slopepain5 if (turnpain5 <= theta_pain) & (theta_pain < turnpain6) else pain_disutility
    pain_disutility = interceptpain6 + theta_pain * slopepain6 if (turnpain6 <= theta_pain) & (theta_pain < turnpain7) else pain_disutility
    pain_disutility = interceptpain7 + theta_pain * slopepain7 if (turnpain7 <= theta_pain) & (theta_pain < turnpain8) else pain_disutility
    pain_disutility = interceptpain8 + theta_pain * slopepain8 if (turnpain8 <= theta_pain) & (theta_pain < turnpain9) else pain_disutility
    pain_disutility = 1 if (turnpain9 <= theta_pain) else pain_disutility

    physical_disutility = 1
    physical_disutility = interceptphys1 + theta_phys * slopephys1 if (turnphys1 <= theta_phys) & (theta_phys < turnphys2) else physical_disutility
    physical_disutility = interceptphys2 + theta_phys * slopephys2 if (turnphys2 <= theta_phys) & (theta_phys < turnphys3) else physical_disutility
    physical_disutility = interceptphys3 + theta_phys * slopephys3 if (turnphys3 <= theta_phys) & (theta_phys < turnphys4) else physical_disutility
    physical_disutility = interceptphys4 + theta_phys * slopephys4 if (turnphys4 <= theta_phys) & (theta_phys < turnphys5) else physical_disutility
    physical_disutility = interceptphys5 + theta_phys * slopephys5 if (turnphys5 <= theta_phys) & (theta_phys < turnphys6) else physical_disutility
    physical_disutility = interceptphys6 + theta_phys * slopephys6 if (turnphys6 <= theta_phys) & (theta_phys < turnphys7) else physical_disutility
    physical_disutility = interceptphys7 + theta_phys * slopephys7 if (turnphys7 <= theta_phys) & (theta_phys < turnphys8) else physical_disutility
    physical_disutility = interceptphys8 + theta_phys * slopephys8 if (turnphys8 <= theta_phys) & (theta_phys < turnphys9) else physical_disutility
    physical_disutility = 0 if (turnphys9 <= theta_phys ) else physical_disutility

    sleep_disutility = 0
    sleep_disutility = interceptsleep1 + theta_slp * slopesleep1 if (turnsleep1 <= theta_slp) & (theta_slp < turnsleep2) else sleep_disutility
    sleep_disutility = interceptsleep2 + theta_slp * slopesleep2 if (turnsleep2 <= theta_slp) & (theta_slp < turnsleep3) else sleep_disutility
    sleep_disutility = interceptsleep3 + theta_slp * slopesleep3 if (turnsleep3 <= theta_slp) & (theta_slp < turnsleep4) else sleep_disutility
    sleep_disutility = interceptsleep4 + theta_slp * slopesleep4 if (turnsleep4 <= theta_slp) & (theta_slp < turnsleep5) else sleep_disutility
    sleep_disutility = interceptsleep5 + theta_slp * slopesleep5 if (turnsleep5 <= theta_slp) & (theta_slp < turnsleep6) else sleep_disutility
    sleep_disutility = interceptsleep6 + theta_slp * slopesleep6 if (turnsleep6 <= theta_slp) & (theta_slp < turnsleep7) else sleep_disutility
    sleep_disutility = interceptsleep7 + theta_slp * slopesleep7 if (turnsleep7 <= theta_slp) & (theta_slp < turnsleep8) else sleep_disutility
    sleep_disutility = 1 if (turnsleep8 <= theta_slp) else sleep_disutility

    social_disutility = 1
    social_disutility = interceptsocial1 + theta_sr * slopesocial1 if (turnsocial1 <= theta_sr) & (theta_sr < turnsocial2) else social_disutility
    social_disutility = interceptsocial2 + theta_sr * slopesocial2 if (turnsocial2 <= theta_sr) & (theta_sr < turnsocial3) else social_disutility
    social_disutility = interceptsocial3 + theta_sr * slopesocial3 if (turnsocial3 <= theta_sr) & (theta_sr < turnsocial4) else social_disutility
    social_disutility = interceptsocial4 + theta_sr * slopesocial4 if (turnsocial4 <= theta_sr) & (theta_sr < turnsocial5) else social_disutility
    social_disutility = interceptsocial5 + theta_sr * slopesocial5 if (turnsocial5 <= theta_sr) & (theta_sr < turnsocial6) else social_disutility
    social_disutility = interceptsocial6 + theta_sr * slopesocial6 if (turnsocial6 <= theta_sr) & (theta_sr < turnsocial7) else social_disutility
    social_disutility = interceptsocial7 + theta_sr * slopesocial7 if (turnsocial7 <= theta_sr) & (theta_sr < turnsocial8) else social_disutility
    social_disutility = interceptsocial8 + theta_sr * slopesocial8 if (turnsocial8 <= theta_sr) & (theta_sr < turnsocial9) else social_disutility
    social_disutility = 0 if (turnsocial9 <= theta_sr) else social_disutility

    multi_attribute_disutility = (1/C) * ((1 + C * c_cognition * cog_disutility)*(1 + C * c_depression * dep_disutility)* (1 + C * c_fatigue * fat_disutility)*  (1 + C * c_pain * pain_disutility)* (1 + C * c_physical * physical_disutility)*  (1 + C * c_sleep * sleep_disutility)* (1 + C * c_social * social_disutility) - 1)

    PROPr = np.round(1 - to_dead * multi_attribute_disutility, 3)

    cognition_utility = round(1 - cog_disutility, 3)
    depression_utility = round(1 - dep_disutility, 3)
    fatigue_utility = round(1 - fat_disutility, 3)
    pain_utility = round(1 - pain_disutility, 3)
    physical_utility = round(1 - physical_disutility, 3)
    sleep_utility = round(1 - sleep_disutility, 3)
    social_utility = round(1 - social_disutility, 3)
    return PROPr, (cognition_utility, depression_utility, fatigue_utility, pain_utility, physical_utility, sleep_utility, social_utility)


def get_propr_from_tscores(t_dep, t_fat, t_pain, t_phys, t_slp, t_sr, t_ax=None, t_cog=None, score_pi=None):
    theta_dep = (t_dep-50)/10
    theta_fat = (t_fat-50)/10
    theta_pain = (t_pain-50)/10
    theta_phys = (t_phys-50)/10
    theta_slp = (t_slp-50)/10
    theta_sr = (t_sr-50)/10

    if t_ax:
        theta_ax = (t_ax - 50) / 10
        theta_cog = 0.009 + (-0.037)*theta_dep + 0.118*theta_phys + (-0.223)*theta_slp + 0.051*theta_sr +(-0.168)*theta_ax + (-0.006)*score_pi
    elif t_cog:
        theta_cog = (t_cog - 50) / 10
    else:
        raise Exception('Missing input param, must have either anxiety t-score or cog t-score')
    return get_propr_from_thetas(theta_dep, theta_fat, theta_pain, theta_phys, theta_slp, theta_sr, theta_cog)