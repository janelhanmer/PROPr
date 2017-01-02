  
 /*  DESCRIPTION
   This is the multi-attribute utility function, using constrained cubic polynomials to model the single-attribute (dis)utility functions.
   This code was written by Janel Hanmer December 2016 using SAS 9.4

   DATASET
   This code presumes the dataset's name is PROPrData
  
   INPUTS
   The input thetas must be a 7 element vector of the following form:
     - theta_cog is a score on the Cognitive Functioning - Abilities domain
     - theta_dep is a score on the Depression domain
     - theta_fat is a score on the Fatigue domain
     - theta_pain is a score on the Pain Interference domain
     - theta_phys is a score on the Physical Functioning domain
     - theta_slp is a score on the Sleep Disturbance domain
     - theta_sr is a score on the Ability to Participate in Social Roles and Activities domain
   The thetas must be of the z-score form: usually a number from -3 to 3.  These are the scores constructed with a population mean of 0 and standard deviation of 1.
   Note in particular, they should not be the "t-score" variety.  These scores are transformations of the z-scores such that the population mean is 50 and a standard deviation of 10.
  
   OUTPUTS
   A number (utility) on the dead = 0, full health = 1 scale. 
   Note that 1 is the maximum possible value, but scores less than 0 are possible.
 */
  
  
 /*  The values we will need for the computation */
 
data PROPrData; set PROPrData; 
  /* Coefficients for each cubic */
  cognition_alpha0 = 0.176878;
  cognition_alpha1 = -0.08944999;
  cognition_alpha2 = -0.0217652;
  cognition_alpha3 = -0.03496394;
  depression_alpha0 = 0.1312741;
  depression_alpha1 = 0.10745;
  depression_alpha2 = 0.004591097;
  depression_alpha3 = 0.01079734;
  fatigue_alpha0 = 0.1737371;
  fatigue_alpha1 = 0.043119;
  fatigue_alpha2 = 0.008373959;
  fatigue_alpha3 = 0.01021585;
  pain_alpha0 = 0.05245957;
  pain_alpha1 = 0.1250937;
  pain_alpha2 = 0.01266808;
  pain_alpha3 = 0.01272346;
  physical_alpha0 = 0.1748262;
  physical_alpha1 = -0.1251348;
  physical_alpha2 = -0.03877396;
  physical_alpha3 = -0.01942404;
  sleep_alpha0 = 0.1580778;
  sleep_alpha1 = 0.04750736;
  sleep_alpha2 = 0.02019863;
  sleep_alpha3 = 0.01069835;
  social_alpha0 = 0.1951822;
  social_alpha1 = -0.05902308 ;
  social_alpha2 = -0.0280192;
  social_alpha3 = -0.05957745;
  
 /*  Corner state disutilities*/
  c_cognition = 0.6350450;
  c_depression = 0.6661641;
  c_fatigue = 0.6386135;
  c_pain = 0.6529680;
  c_physical = 0.6883584;
  c_sleep = 0.5629657;
  c_social = 0.6112686;
  C = -0.9991828;
  
 /*  Upper/lower bounds for the domains */
  theta_cog_low = -2.769;
  theta_cog_up = 1.121;
  theta_dep_low = -1.131;
  theta_dep_up = 3.45;
  theta_fat_low = -2.267;
  theta_fat_up = 3.765 ;
  theta_pain_low = -0.43;
  theta_pain_up = 3.201;
  theta_physical_low = -3.551;
  theta_physical_up = 0.967;
  theta_sleep_low = -2.489;
  theta_sleep_up = 3.447;
  theta_social_low = -2.401;
  theta_social_up = 1.1490;
  
 /*  Constant for transforming from pits to dead */
  to_dead = 1.021915;
  
  
 /*  Create the output of each single-domain function, including truncation if 
   the theta is out-of-bounds of the range we measured. */
  
 /*  Cognition
   This is what the cognition output should be if the cognition theta is within bounds */
  cog_disutility = cognition_alpha0 + cognition_alpha1*(theta_cog) + cognition_alpha2*(theta_cog**2) + cognition_alpha3*(theta_cog**3);
/*   Change it, if it's out-of-bounds */
  if(theta_cog < theta_cog_low) then  cog_disutility = 1;
  if(theta_cog > theta_cog_up) then cog_disutility = 0;
  
 /*  Depression
   This is what the depression output should be if the depression theta is within bounds */
  dep_disutility = depression_alpha0 + depression_alpha1*(theta_dep) + depression_alpha2*(theta_dep**2) + depression_alpha3*(theta_dep**3);
 /*  Change it, if it's out-of-bounds */
  if(theta_dep < theta_dep_low) then dep_disutility = 0;
  if(theta_dep > theta_dep_up) then dep_disutility = 1;
  
 /*  Fatigue
   This is what the fatigue output should be if the fatigue theta is within bounds */
  fat_disutility = fatigue_alpha0 + fatigue_alpha1*(theta_fat) + fatigue_alpha2*(theta_fat**2) + fatigue_alpha3*(theta_fat**3);
 /*  Change it, if it's out-of-bounds*/
  if(theta_fat < theta_fat_low) then fat_disutility = 0;
  if(theta_fat > theta_fat_up) then fat_disutility = 1;
  
 /*  Pain
   This is what the pain output should be if the pain theta is within bounds */
  pain_disutility = pain_alpha0 + pain_alpha1*(theta_pain) + pain_alpha2*(theta_pain**2) + pain_alpha3*(theta_pain**3);
 /*  Change it, if it's out-of-bounds */
  if(theta_pain < theta_pain_low) then pain_disutility = 0;
  if(theta_pain > theta_pain_up) then pain_disutility = 1;
  
 /*  Physical
   This is what the physical output should be if the physical theta is within bounds */
  physical_disutility = physical_alpha0 + physical_alpha1*(theta_phys) + physical_alpha2*(theta_phys**2) + physical_alpha3*(theta_phys**3);
 /*  Change it, if it's out-of-bounds */
  if(theta_phys < theta_physical_low) then physical_disutility = 1;
  if(theta_phys > theta_physical_up) then physical_disutility = 0; 
  
 /*  Sleep
   This is what the sleep output should be if the sleep theta is within bounds */
  sleep_disutility = sleep_alpha0 + sleep_alpha1*(theta_slp) + sleep_alpha2*(theta_slp**2) + sleep_alpha3*(theta_slp**3);
 /*  Change it, if it's out-of-bounds */
  if(theta_slp < theta_sleep_low) then  sleep_disutility = 0;
  if(theta_slp > theta_sleep_up) then sleep_disutility = 1;
  
 /*  Social
   This is what the social output should be if the social theta is within bounds */
  social_disutility = social_alpha0 + social_alpha1*(theta_sr) + social_alpha2*(theta_sr**2) + social_alpha3*(theta_sr**3);
 /*  Change it, if it's out-of-bounds */
  if(theta_sr < theta_social_low) then social_disutility = 1;
  if(theta_sr > theta_social_up) then social_disutility = 0;
  
 /*  Now, plug it into the multiattribute disutility function */
  
  multi_attribute_disutility = (1/C) * ((1 + C * c_cognition * cog_disutility)*
                                              (1 + C * c_depression * dep_disutility)*
                                              (1 + C * c_fatigue * fat_disutility)*
                                              (1 + C * c_pain * pain_disutility)*
                                              (1 + C * c_physical * physical_disutility)*
                                              (1 + C * c_sleep * sleep_disutility)*
                                              (1 + C * c_social * social_disutility) - 1);
  
  
  /* Now make it a utility, on the dead/full health scale */
  PROPr = 1 - to_dead * multi_attribute_disutility;
run;
  
  /* single attribute utility functions */

data PROPrData; set PROPrData;
	cognition_utility = 1 - cog_disutility;
	depression_utility = 1 - dep_disutility;
	fatigue_utility = 1 - fat_disutility;
	pain_utility = 1 - pain_disutility;
	physical_utility = 1 - physical_disutility;
	sleep_utility = 1 - sleep_disutility;
	social_utility = 1 - social_disutility; run;


/* clean up dataset */
data PROPrData; set PROPrData; 
 drop multi_attribute_disutility  to_dead   cognition_alpha0   cognition_alpha1   cognition_alpha2   cognition_alpha3 
  depression_alpha0   depression_alpha1  depression_alpha2 depression_alpha3 fatigue_alpha0 fatigue_alpha1 fatigue_alpha2 
  fatigue_alpha3   pain_alpha0   pain_alpha1   pain_alpha2   pain_alpha3   physical_alpha0   physical_alpha1   physical_alpha2 
  physical_alpha3   sleep_alpha0   sleep_alpha1   sleep_alpha2   sleep_alpha3   social_alpha0   social_alpha1   social_alpha2 
  social_alpha3   c_cognition   c_depression   c_fatigue   c_pain   c_physical   c_sleep   c_social   C   theta_cog_low 
  theta_cog_up   theta_dep_low   theta_dep_up   theta_fat_low   theta_fat_up   theta_pain_low   theta_pain_up   theta_physical_low 
  theta_physical_up   theta_sleep_low   theta_sleep_up   theta_social_low   theta_social_up
  dep_disutility fat_disutility pain_disutility physical_disutility sleep_disutility social_disutility; run;
