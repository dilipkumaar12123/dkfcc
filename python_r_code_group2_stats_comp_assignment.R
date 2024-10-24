#Python code for question 1
import pandas as pd
df = pd.read_stata("C:/Users/Dilip/Downloads/36151-0002-Data.dta")
new_df = df[df['STATEID'] != 'Himachal Pradesh 02']

#question 1 a
num_observations, num_variables = new_df.shape
print("Number of Observations (Rows):", num_observations)
print("Number of Variables (Columns):", num_variables)
#observations = 40676, variables = 758

#question 1 b
continuous = new_df.select_dtypes(include='number')
categorical = new_df.select_dtypes(exclude='number')

print("Continuous Variables:")
print(len(continuous.columns))  #380

print("\nCategorical Variables:")
print(len(categorical.columns)) #378

#question 1 c
new_df.dtypes
categories_counts = new_df['HHEDUC'].value_counts() 
print(categories_counts)

new_df.head(4)
new_df['STATEID'].value_counts()
unique_catogories= new_df['HHEDUC'].unique() 
print("unique_catogories in HHEDUC:",unique_catogories)

dummies= pd.get_dummies(new_df['HHEDUC'], prefix='HHEDUC') 
new_df=pd.concat([new_df,dummies], axis=1)

#1d.
grade_to_category = {
  '1st class 1': '1', 
  '2nd class 2': '1', 
  '3rd class 3': '1', 
  '4th class 4': '1', 
  '5th class 5': '1', 
  '6th class 6': '2', 
  '7th class 7': '2', 
  '8th class 8': '2', 
  '9th class 9': '2', 
  'secondary 10':'2',}
new_df['Education Level'] = new_df['HHEDUC'].map(grade_to_category).fillna('3')
new_df['Education Level'].value_counts()

#----------------------------------------------------------------------------------------------------------------------------

#R code for questions 2,3,4
library(foreign)      #foreign package for reading stata file
library(dplyr)        #dplyr package for data manipulation
library(ggplot2)      #ggplot2 package for graphs
library(psych)        #psych package for easier desc stats
#user defined mode fn
mode_fn <- function(x) {
  x <- x[!is.na(x) & x != 0]
  tbl <- table(x)
  modes <- as.numeric(names(tbl)[tbl == max(tbl)])
  return(modes)
}

df <- read.dta("C:/Users/Dilip/Downloads/36151-0002-Data.dta")
new_df <- filter(df, STATEID != "Himachal Pradesh 02")

new_df <- new_df %>%
  replace(is.na(.), 0)     #replacing NA values to 0

#q2
#with urban2011 - 2 categories
table_2_1 <- table(new_df$URBAN2011, new_df$DB8A)               #2a
print(table_2_1)
table_2 <- table(new_df$URBAN2011, new_df$DB8A, new_df$DB1)     #2b,c
print(table_2)

#q2e
#with urban4_2011 - 4 categories
table_2e <- table(new_df$URBAN4_2011, new_df$DB8A, new_df$DB1)  #2c for e
print(table_2e)

#q3
conditional_df <- new_df %>%
                  filter(
                    DB1A == levels(new_df$DB1A)[2],
                    DB1B == levels(new_df$DB1B)[2],
                    DB1D == levels(new_df$DB1D)[2]
                  )
conditional_df$mpce <- conditional_df$COTOTAL / 12 / conditional_df$NPERSONS
#log transformation of mpce used to accomodate its larger values
#q3a - box plot
ggplot(data = conditional_df, aes(x = URBAN4_2011, y = mpce)) +
  geom_boxplot() +
  labs(x = "Urban-Rural Categories", y = "mpce") +
  ggtitle("Boxplot of mpce Across Urban4_2011 Categories")
 
#q3b - stats for the 2 variables
#mean, median, mode, sd, skew, kurt
#mpce_rural
q3b_rural <- new_df %>%
  filter(URBAN2011 == levels(new_df$URBAN2011)[1])
q3b_rural$mpce_rural <- q3b_rural$COTOTAL / 12 / q3b_rural$NPERSONS
q3b_rural_mpce_stat <- describe(q3b_rural$mpce_rural)
print(data.frame(q3b_rural_mpce_stat[c(3,5)],mode = mode_fn(q3b_rural$mpce_rural),q3b_rural_mpce_stat[c(4,11,12)])[1,])

#mpce_urban
q3b_urban <- new_df %>%
  filter(URBAN2011 == levels(new_df$URBAN2011)[2])
q3b_urban$mpce_urban <- q3b_urban$COTOTAL / 12 / q3b_urban$NPERSONS
q3b_urban_mpce_stat <- describe(q3b_urban$mpce_urban)
print(data.frame(q3b_urban_mpce_stat[c(3,5)],mode = mode_fn(q3b_urban$mpce_urban),q3b_urban_mpce_stat[c(4,11,12)]))

#q3c - chebyshev's inequality
chebyshev <- function(x,y) {
  x <- x[!is.na(x) & x != 0]
  y <- y[!is.na(y) & y != 0]
  mean_ci <- mean(x, na.rm = TRUE)
  sd_ci <- sd(x, na.rm = TRUE)
  lower_bound <- mean_ci - (y * sd_ci)
  upper_bound <- mean_ci + (y * sd_ci)
  z1 <- (lower_bound - mean_ci)/sd_ci
  z2 <- (upper_bound - mean_ci)/sd_ci
  result <- pnorm(z2) - pnorm(z1)
  print(lower_bound)
  print(upper_bound)
  print(result)
  }

#rural
mpce_r <- q3b_rural$mpce_rural
chebyshev(mpce_r,1)
chebyshev(mpce_r,2)
chebyshev(mpce_r,3)

#urban
mpce_u <- q3b_urban$mpce_urban
chebyshev(mpce_u,1)
chebyshev(mpce_u,2)
chebyshev(mpce_u,3)

#q4
loan_amt_bor <- new_df$DB2B

mpce <- new_df$COTOTAL / 12 / new_df$NPERSONS

food_exp <- new_df$CO1E + new_df$CO2E + new_df$CO3E + new_df$CO4E + new_df$CO5E +
            new_df$CO15 + new_df$CO16 + new_df$CO17 + new_df$CO19 + new_df$CO20 +
            new_df$CO6T + new_df$CO7T + new_df$CO8T + new_df$CO9T + new_df$CO10T+
            new_df$CO11T+ new_df$CO12T+ new_df$CO13T+ new_df$CO14T

food_exp_share <- ifelse(new_df$COTOTAL == 0 | food_exp == 0, 0, food_exp / new_df$COTOTAL / 12)
#to avoid infinity values in fes 0/0

household_size <- new_df$NPERSONS

incomepc <- new_df$INCOMEPC

#q4a
options(scipen = 999)       #to avoid scientific notations
#statistics - mean, min, max, range, sd, quantiles, skewness, kurtosis
#statistics - loan amount borrowed
stats4_1 <- describe(loan_amt_bor)
stat_lab <- c(stats4_1[c(3,4,10)],quantiles = quantile(loan_amt_bor , probs = c(0.25, 0.5, 0.75, 1), na.rm = TRUE),stats4_1[c(11,12)])

#statistics - mpce
stats4_2 <- describe(mpce)
stat_mpce <- c(stats4_2[c(3,4,10)],quantiles = quantile(food_exp_share , probs = c(0.25, 0.5, 0.75, 1), na.rm = TRUE),stats4_2[c(11,12)])

#statistics - food expenditure share
stats4_3 <- describe(food_exp_share)
stat_fes <- c(stats4_3[c(3,4,10)],quantiles = quantile(food_exp_share , probs = c(0.25, 0.5, 0.75, 1), na.rm = TRUE),stats4_3[c(11,12)])

#statistics - household size
stats4_4 <- describe(household_size)
stat_hhs <- c(stats4_4[c(3,4,10)],quantiles = quantile(household_size , probs = c(0.25, 0.5, 0.75, 1), na.rm = TRUE),stats4_4[c(11,12)])

#statistics - incomepc
stats4_5 <- describe(incomepc)
stat_ipc <- c(stats4_5[c(3,4,10)],quantiles = quantile(incomepc , probs = c(0.25, 0.5, 0.75, 1), na.rm = TRUE),stats4_5[c(11,12)])

q4a <- as.data.frame(rbind(stat_lab,stat_mpce,stat_fes,stat_hhs,stat_ipc))
print(q4a)

#q4b
#cor matrix
q4b <- data.frame(loan_amt_bor,household_size,incomepc,mpce,food_exp_share)
corq4b <- cor(q4b)
print(corq4b)

#q4c
#lab
log_lab <- log(loan_amt_bor)
ggplot(new_df, aes(x = log_lab)) +
  geom_histogram(aes(y = ..density..)) +
  ggtitle("histogram for the natural log of loan amt borrowed") +
  geom_density(col = "red")

#hhs
log_hhs <- log(household_size)
ggplot(new_df, aes(x = log_hhs)) +
  geom_histogram(aes(y = ..density..)) +
  ggtitle("histogram for the natural log of house hold size") +
  geom_density(col = "red")

#ipc
log_ipc <- log(incomepc)
ggplot(new_df, aes(x = log_ipc)) +
  geom_histogram(aes(y = ..density..)) +
  ggtitle("histogram for the natural log of incomepc") +
  geom_density(col = "red")

#mpce
log_mpce <- log(mpce)
ggplot(new_df, aes(x = log_mpce)) +
  geom_histogram(aes(y = ..density..)) +
  ggtitle("histogram for the natural log of mpce") +
  geom_density(col = "red")

#fes
log_fes <- log(food_exp_share)
ggplot(new_df, aes(x = log_fes)) +
  geom_histogram(aes(y = ..density..)) +
  ggtitle("histogram for the natural log of food exp share") +
  geom_density(col = "red")
