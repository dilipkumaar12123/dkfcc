#libraries for this project
library(readxl)
library(latticeExtra)
library(plm)

#importing data into environment
df <- read_excel("C:/Users/Dilip/Desktop/Singapore_PCGDP_PPP_Data.xlsx")

#adding a new column for the ln of PCGDP_PPP
df$ln_PCGDP_PPP <- log(df$PCGDP_PPP)

#plotting line graph for both y and ln_y
obj1 <- xyplot(
  PCGDP_PPP ~ year, df, type = "l", 
  scales = list(x = list(at = seq(1998, 2022, by = 2))))
obj2 <- xyplot(
  ln_PCGDP_PPP ~ year, df, type = "l", 
  scales = list(x = list(at = seq(1998, 2022, by = 2))))
doubleYScale(
  obj1, obj2, 
  text = c("PCGDP_PPP", "ln_PCGDP_PPP"), 
  add.ylab2 = TRUE) + panel.grid()

df$t <- df$year - 2010
df$ln_t <- df$ln_PCGDP_PPP * df$t
table1 <- data.frame(df$year, df$PCGDP_PPP, df$ln_PCGDP_PPP, df$t, df$ln_t)

#time trend variable
years <- seq(1,25,by = 1)
#regression model
model <- lm(ln_PCGDP_PPP ~ years, data = df)
obs_lny <- df$ln_PCGDP_PPP
fit_lny <- predict(model,df)
error_term <- obs_lny - fit_lny
table2 <- data.frame(obs_lny,fit_lny,error_term)

model_sum <- summary(model)

#sum of squares
RSS <- sum(model_sum$residuals^2)
TSS <- sum((df$ln_PCGDP_PPP - mean(df$ln_PCGDP_PPP))^2)
ESS <- TSS - RSS
R2 <- 1 - RSS/TSS

#plot of fit_lny over ln_y
plot(table2$obs_lny, table2$fit_lny, main = "Figure 2: scatter plot of fit_lny over ln_y", lty = 1, lwd = 1 , xlab = "ln_y", ylab = "fit_lny")

#plot of residual values over time trend
graph <- plot(df$years, table2$error_term, main = "figure 3",lty = 1, lwd = 1 , xlab = "time_trend", ylab = "residual")
abline(h = 0, col = "red", lty = 1)
lines(data$time_trend, data$error_term, type = "o", col = "blue")

#p-value
summary(model)$coefficients[,4]

#t-tab
ttab <- qt(0.05, 23, lower.tail="False")

#extras
sxx <- sum((years)^2) - (25*(mean(years)^2))
sxy <- sum((years) * (df$ln_PCGDP_PPP)) - (25* mean(years)* mean(df$ln_PCGDP_PPP))
#beta_hat:
beta_hat <- sxy/sxx
#alpha_hat
alpha_hat <- mean(df$ln_PCGDP_PPP) - beta_hat*mean(years)
#ols estimators
beta_1 <- sum((df$ln_PCGDP_PPP - mean(df$ln_PCGDP_PPP))*(years - sum(years)))/sum((df$ln_PCGDP_PPP - mean(df$ln_PCGDP_PPP))^2)
beta_0 <- mean(df$ln_PCGDP_PPP) - beta_1*mean(years)

#predited model
df1 <- data.frame(years = seq(1,26,by=1),PCGDP_PPP = c(df$PCGDP_PPP,NA))
model2 <- lm(PCGDP_PPP ~ years, data = df1)
predict(object = model2, newdata = df1)c

#anova
one.way <- aov(df$ln_PCGDP_PPP ~ df$year)
summary(one.way)

#confidence interval
confint.lm(model, level = 0.90)

#growth estimation
b <- sum(table1$df.ln_t)/sum((table1$df.t)^2)
g <- exp(b)-1
cat("growth percentage:",g*100,"%","\n")






#1 (a)regressing ln_y on t:
lm_model1a <- lm(table1$df.ln_PCGDP_PPP ~ table1$df.t, data = df)
s1a <- summary(lm_model1a)

#  (b) regressing ln_y on time_trend:
lm_model1b <- lm(table1$df.ln_PCGDP_PPP ~ years, data = df)
s1b <- summary(lm_model1b)                

#  (c) regressing ln_y on year:
lm_model1c <- lm(table1$df.ln_PCGDP_PPP ~ table1$df.year, data = df)
s1c <- summary(lm_model1c)

#2 (b) regressing lnY* on time_trend:
table1$lny1000 <- log(table1$df.PCGDP_PPP/1000)
lm_model2b <- lm(table1$lny1000 ~ years)
s2b <- summary(lm_model2b)

#3 (a) regressing PCGDP_PPP on t:
lm_model3a <- lm(table1$df.PCGDP_PPP ~ table1$df.t)
s3a <- summary(lm_model3a)

#  (b) regressing PCGDP_PPP on year:
lm_model10 <- lm(table1$df.PCGDP_PPP ~ table1$df.year)
s3b <- summary(lm_model10)

#  (c) regressing lnYcap on t:
table1$y1000 <- table1$df.PCGDP_PPP/1000
lm_model11 <- lm(table1$y1000 ~ table1$df.t)
s3c <- summary(lm_model11)



results <- data.frame(coeff = c(s1a$coefficients[, 1],s1b$coefficients[, 1],
                      s1c$coefficients[, 1],s2b$coefficients[, 1],s3a$coefficients[, 1],
                      s3b$coefficients[, 1],s3c$coefficients[, 1]), 
                      se = c(s1a$coefficients[, 2],s1b$coefficients[, 2],
                            s1c$coefficients[, 2],s2b$coefficients[, 2],s3a$coefficients[, 2],
                            s3b$coefficients[, 2],s3c$coefficients[, 2]),
                      tstat = c(s1a$coefficients[, 3],s1b$coefficients[, 3],
                                s1c$coefficients[, 3],s2b$coefficients[, 3],s3a$coefficients[, 3],
                                s3b$coefficients[, 3],s3c$coefficients[, 3]),
                      r2 = c(s1a$r.squared,s1b$r.squared,s1c$r.squared,s2b$r.squared,s3a$r.squared,s3b$r.squared,s3c$r.squared))

