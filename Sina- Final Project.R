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

#9. Merge or Join data frames (5 points)

# I will create a new 12-rows data frame to merge with my data frame
newwww <- data.frame(
  vitamin.C.mg.per.L = c(0, 0, 0, 4, 4, 4, 6, 6, 6, 8, 8, 8),
  Fish.Mortality = c(5, 10, 8, 12, 6, 7, 9, 11, 5, 6, 8, 10),
  Feeding.fish.per.kg = c(2, 2.5, 3, 3.5, 4, 4.5, 5, 5.5, 6, 6.5, 7, 7.5))

#Now, I can merge 2 data frames
merged <- merge(VitaminC, newwww, by = "vitamin.C.mg.per.L", all.x = TRUE)


#10. Custom function(s) (5 points each; max. 15 points)


growth.rate <- function(initial_weight, final_weight) {
  growth.rate.percentage <- ((final_weight - initial_weight) / initial_weight) * 100
  return(growth.rate.percentage)}
VitaminC$growth.rate.percentage <- growth.rate(VitaminC$Initial_Weight_g, VitaminC$Final_Weight_g)


cortisol.category <- function(cortisol_level) {
  if (cortisol_level < 12) {
    return("Low")
  } else if (cortisol_level <= 15) {
    return("Moderate")
  } else {
    return("High")}}
VitaminC$Cortisol.Category <- sapply(VitaminC$Cortisol_Level_ug_dL, cortisol.category)


#11. ‘if else’ statement (10 points)

VitaminC$Saffron_Yield_Classification <- ifelse(
  VitaminC$Saffron_Yield_g >= 6, "High",
  ifelse(VitaminC$Saffron_Yield_g > 4, "Moderate", "Low")
)
print(VitaminC)


#12. Using a ‘apply’, ‘lapply’, or ‘sapply’ function (3 points each; max. 12 points)

range <- apply(VitaminC[, c("Initial_Weight_g", "Final_Weight_g", "Saffron_Yield_g")], 
2, function(x) max(x) - min(x))
print(range)
  

mean <- sapply(VitaminC[, c("Initial_Weight_g", "Final_Weight_g", "Saffron_Yield_g")], mean)
print(mean)


#13. Reshaping data with spread() or gather() functions (5 points)

library(tidyverse)
VitaminC.wide <- spread(VitaminC, key = vitamin.C.mg.per.L, value = Saffron_Yield_Classification)

print(VitaminC.wide)


#15. Using a ‘for loop’ (10 points)

VitaminC$Innovative.index <- NA

for (i in 1:nrow(VitaminC)) {
  VitaminC$Innovative.index[i] <- VitaminC$Final_Weight_g[i] + (VitaminC$Saffron_Yield_g [i] *5)
}

print(VitaminC)
