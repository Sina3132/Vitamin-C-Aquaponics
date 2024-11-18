set.seed(123)

vitamin.C.levels <- rep(c(0, 4, 6, 8), each = 3)
replicates <- rep(1:3, times = 4)

initial_weight <- rnorm(12, mean = 13.2, sd = 0.2)

final_weight <- c(rnorm(3, mean = 21.3, sd = 0.5),
                  rnorm(3, mean = 22.9, sd = 0.4),
                  rnorm(3, mean = 38.1, sd = 0.5),  
                  rnorm(3, mean = 36.7, sd = 0.6)) 

cortisol_level <- c(rnorm(3, mean = 17, sd = 0.5),
                    rnorm(3, mean = 13.9, sd =0.5), 
                    rnorm(3, mean = 13.4, sd = 0.5),
                    rnorm(3, mean = 9.8, sd = 0.5))      

saffron_leaf_growth <- c(rnorm(3, mean = 7.2, sd = 0.5),
                         rnorm(3, mean = 7.6, sd = 0.5),
                         rnorm(3, mean = 11.6, sd = 0.5),
                         rnorm(3, mean = 11.9, sd = 0.5))

saffron_yield <- c(rnorm(3, mean = 3.3, sd = 0.5),
                   rnorm(3, mean = 5.5, sd = 0.5),  
                   rnorm(3, mean = 5.6, sd = 0.5),  
                   rnorm(3, mean = 5.5, sd = 0.5))   

experiment_data <- data.frame(
  vitamin.C.mg.per.L = vitamin.C.levels,
  Replicate = replicates,
  Initial_Weight_g = initial_weight,
  Final_Weight_g = final_weight,
  Cortisol_Level_ug_dL = cortisol_level,
  Saffron_Leaf_Growth_cm = saffron_leaf_growth,
  Saffron_Yield_g = saffron_yield
)

print(experiment_data)


