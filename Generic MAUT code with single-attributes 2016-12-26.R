generic_maut_function_with_single_attributes <- function(thetas){
  
  ## DESCRIPTION
  ## This is the multi-attribute utility function, using constrained cubic
  ## polynomials to model the single-attribute (dis)utility functions.
  ## It outputs both the utility calculated from the multi-attribute function,
  ## as well as utilities for each of the single attribute functions. The
  ## utility calculated from the multi-attribute function is on the scale where
  ## 0 is the utility of Dead and 1 is the utility of Full Health. The 7
  ## single-attribute functions each have their own scale, where 0 is the 
  ## utility of the worst level of that attribute, and 1 is the utility of the
  ## best level of that attribute.
  
  ## INPUTS
  ## The input thetas must be a 7 element vector of the following form:
  ##   - thetas[1] is a score on the Cognitive Functioning - Abilities domain
  ##   - thetas[2] is a score on the Depression domain
  ##   - thetas[3] is a score on the Fatigue domain
  ##   - thetas[4] is a score on the Pain Interference domain
  ##   - thetas[5] is a score on the Physical Functioning domain
  ##   - thetas[6] is a score on the Sleep Disturbance domain
  ##   - thetas[7] is a score on the Ability to Participate in Social Roles and 
  ##     Activities domain
  ## The thetas must be of the z-score form: usually a number from -3 to 3.  
  ## These are the scores constructed with a population mean of 0 and standard 
  ## deviation of 1. Note in particular, they should not be the "t-score" 
  ## variety.  These scores are transformations of the z-scores such that the 
  ## population mean is 50 and a standard deviation of 10.
  
  ## OUTPUTS
  ## A list with the following components:
  ## $maut -- A number (utility) on the Dead = 0, Full Health = 1 scale. 
  ## Note that 1 is the maximum possible value, but scores less than 0
  ## are possible.
  ## $cognition -- A number (utility) from 0 to 1, where 0 is the utility for 
  ## the lowest level of Cognitive Functioning - Abilities domain. (See the 
  ## state descriptions in the main text.)
  ## $depression -- As above, for the Depression domain
  ## $fatigue -- As above, for the Fatigue domain
  ## $pain -- As above, for the Pain Interference domain
  ## $physical -- As above, for the Physical Functioning domain
  ## $sleep -- As above, for the Sleep Disturbance domain
  ## $social -- As above, for the Ability to Participate in Social Roles and 
  ## Activities domain  
  
  # The values we will need for the computation
  
  # Coefficients for each cubic
  cognition.alpha0 <- 0.176878
  cognition.alpha1 <- -0.08944999
  cognition.alpha2 <- -0.0217652
  cognition.alpha3 <- -0.03496394
  depression.alpha0 <- 0.1312741
  depression.alpha1 <- 0.10745
  depression.alpha2 <- 0.004591097
  depression.alpha3 <- 0.01079734
  fatigue.alpha0 <- 0.1737371
  fatigue.alpha1 <- 0.043119
  fatigue.alpha2 <- 0.008373959
  fatigue.alpha3 <- 0.01021585
  pain.alpha0 <- 0.05245957
  pain.alpha1 <- 0.1250937
  pain.alpha2 <- 0.01266808
  pain.alpha3 <- 0.01272346
  physical.alpha0 <- 0.1748262
  physical.alpha1 <- -0.1251348
  physical.alpha2 <- -0.03877396
  physical.alpha3 <- -0.01942404
  sleep.alpha0 <- 0.1580778
  sleep.alpha1 <- 0.04750736
  sleep.alpha2 <- 0.02019863
  sleep.alpha3 <- 0.01069835
  social.alpha0 <- 0.1951822
  social.alpha1 <- -0.05902308 
  social.alpha2 <- -0.0280192
  social.alpha3 <- -0.05957745
  
  # Corner state disutilities
  c.cognition <- 0.6350450
  c.depression <- 0.6661641
  c.fatigue <- 0.6386135
  c.pain <- 0.6529680
  c.physical <- 0.6883584
  c.sleep <- 0.5629657
  c.social <- 0.6112686
  C <- -0.9991828
  
  # Upper/lower bounds for the domains
  theta.cog.low <- -2.769
  theta.cog.up <- 1.121
  theta.dep.low <- -1.131
  theta.dep.up <- 3.45
  theta.fat.low <- -2.267
  theta.fat.up <- 3.765 
  theta.pain.low <- -0.43
  theta.pain.up <- 3.201
  theta.physical.low <- -3.551
  theta.physical.up <- 0.967
  theta.sleep.low <- -2.489
  theta.sleep.up <- 3.447
  theta.social.low <- -2.401
  theta.social.up <- 1.1490
  
  # Constant for transforming from pits to dead
  to.dead <- 1.021915
  
  
  # Create the output of each single-domain function, including truncation if
  # the theta is out-of-bounds of the range we measured.
  
  # Cognition
  # This is what the cognition output should be if the cognition theta 
  # is within bounds.
  cog.disutility <- cognition.alpha0 + cognition.alpha1*(thetas[1]) + 
    cognition.alpha2*(thetas[1]^2) + cognition.alpha3*(thetas[1]^3)
  # Change it, if it's out-of-bounds
  if(thetas[1] < theta.cog.low){
    cog.disutility <- 1
  }
  if(thetas[1] > theta.cog.up){
    cog.disutility <- 0
  }
  
  # Depression
  # This is what the depression output should be if the depression theta 
  # is within bounds.
  dep.disutility <- depression.alpha0 + depression.alpha1*(thetas[2]) + 
    depression.alpha2*(thetas[2]^2) + depression.alpha3*(thetas[2]^3)
  # Change it, if it's out-of-bounds
  if(thetas[2] < theta.dep.low){
    dep.disutility <- 0
  }
  if(thetas[2] > theta.dep.up){
    dep.disutility <- 1
  }
  
  # Fatigue
  # This is what the fatigue output should be if the fatigue theta 
  # is within bounds.
  fat.disutility <- fatigue.alpha0 + fatigue.alpha1*(thetas[3]) + 
    fatigue.alpha2*(thetas[3]^2) + fatigue.alpha3*(thetas[3]^3)
  # Change it, if it's out-of-bounds
  if(thetas[3] < theta.fat.low){
    fat.disutility <- 0
  }
  if(thetas[3] > theta.fat.up){
    fat.disutility <- 1
  }
  
  # Pain
  # This is what the pain output should be if the pain theta is within bounds.
  pain.disutility <- pain.alpha0 + pain.alpha1*(thetas[4]) + 
    pain.alpha2*(thetas[4]^2) + pain.alpha3*(thetas[4]^3)
  # Change it, if it's out-of-bounds
  if(thetas[4] < theta.pain.low){
    pain.disutility <- 0
  }
  if(thetas[4] > theta.pain.up){
    pain.disutility <- 1
  }
  
  # Physical
  # This is what the physical output should be if the physical theta 
  # is within bounds.
  physical.disutility <- physical.alpha0 + physical.alpha1*(thetas[5]) + 
    physical.alpha2*(thetas[5]^2) + physical.alpha3*(thetas[5]^3)
  # Change it, if it's out-of-bounds
  if(thetas[5] < theta.physical.low){
    physical.disutility <- 1
  }
  if(thetas[5] > theta.physical.up){
    physical.disutility <- 0
  }
  
  # Sleep
  # This is what the sleep output should be if the sleep theta is within bounds.
  sleep.disutility <- sleep.alpha0 + sleep.alpha1*(thetas[6]) + 
    sleep.alpha2*(thetas[6]^2) + sleep.alpha3*(thetas[6]^3)
  # Change it, if it's out-of-bounds
  if(thetas[6] < theta.sleep.low){
    sleep.disutility <- 0
  }
  if(thetas[6] > theta.sleep.up){
    sleep.disutility <- 1
  }
  
  # Social
  # This is what the social output should be if the social theta
  # is within bounds.
  social.disutility <- social.alpha0 + social.alpha1*(thetas[7]) + 
    social.alpha2*(thetas[7]^2) + social.alpha3*(thetas[7]^3)
  # Change it, if it's out-of-bounds
  if(thetas[7] < theta.social.low){
    social.disutility <- 1
  }
  if(thetas[7] > theta.social.up){
    social.disutility <- 0
  }
  
  # Now, plug it into the multiattribute disutility function
  
  multi.attribute.disutility <- (1/C) * (prod(1 + C * c.cognition * cog.disutility,
                                              1 + C * c.depression * dep.disutility,
                                              1 + C * c.fatigue * fat.disutility,
                                              1 + C * c.pain * pain.disutility,
                                              1 + C * c.physical * physical.disutility,
                                              1 + C * c.sleep * sleep.disutility,
                                              1 + C * c.social * social.disutility) - 1)
  
  
  # Now make it a utility, on the dead/full health scale
  utility <- 1 - to.dead * multi.attribute.disutility
  
  # Capture the single-attribute utilities
  cog.utility <- 1 - cog.disutility
  dep.utility <- 1 - dep.disutility
  fat.utility <- 1 - fat.disutility
  pain.utility <- 1 - pain.disutility
  physical.utility <- 1 - physical.disutility
  sleep.utility <- 1 - sleep.disutility
  social.utility <- 1 - social.disutility
  
  # Return the multi-attribute utility and the single-attribute utilities
  utilities <- list(maut = utility,
                    cognition = cog.utility,
                    depression = dep.utility,
                    fatigue = fat.utility,
                    pain = pain.utility,
                    physical = physical.utility,
                    sleep = sleep.utility,
                    social = social.utility)
  
  
  return(utilities)
  
}
