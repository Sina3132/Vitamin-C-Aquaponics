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

#1. A project-specific ‘R’ project + Git Hub repository (10 points)
#2. Evidence of version control (5 points)


#Git Hub repository: https://github.com/Sina3132/Vitamin-C-Aquaponics/blob/main/Sina-%20Final%20Project.R


install.packages("writexl")    #making an EXEL FILE
library(writexl)
write_xlsx(experiment_data, "C:/Users/30NA/Desktop/R/Final Project/vitaminC-Aquaponics.xlsx")

#3. Reading-in data (2 points)

library(readxl)
VitaminC <- read_excel("C:/Users/30NA/Desktop/R/Final Project/vitaminC-Aquaponics.xlsx")

head(VitaminC)

#4. Application of the appropriate data storage structure: list, data frame, matrix or array (2 points)

#data frame is the best structure for me because it allows for a mix of data types
#and it is compatible with most data manipulation and analysis packages like tidyverse.
  
#5. Example of indexing (1 point)

#for Initial_weight column
VitaminC [ ,3]

#for havin entire rows of 8 mg per liter vitamin C
VitaminC [10:12, ]


#6.Sub-set the data (1 point)

#for subset rows for the treatments more than 4 mg/L VitC and Cortisol level more than 12 ug/dL
subseted <- VitaminC[VitaminC$vitamin.C.mg.per.L > 4 & VitaminC$Cortisol_Level_ug_dL > 12, ]
print(subseted)


#7.Re-ordering (i.e., sorting) data (1 point)

#for sorting data by fish Final Weight in ascending order
sorted.data <- VitaminC[order(VitaminC$Final_Weight_g), ]


#8. Grouping and generating summary statistics (2 points)
library(dplyr)

#For grouping data by vitamin.C level and calculate the mean of Saffron Yield
Groupingg <- VitaminC %>%
  group_by(vitamin.C.mg.per.L) %>%
  summarize(mean_yield = mean(Saffron_Yield_g))

