#using ISLR package

install.packages("ISLR")
library(ISLR)

##linear regression with weight as the response and horsepower as the predictor
data("Auto")
lm_auto <- lm(weight ~ horsepower, data = Auto)
summary(lm_auto)
new_auto_data <- data.frame(horsepower = 150)
pred_confidence <- predict(lm_auto, new_auto_data, interval = 'confidence', level = 0.97)
pred_confidence
pred_prediction <- predict(lm_auto, new_auto_data, interval = 'prediction', level = 0.97)
pred_prediction

#plotting the response and the predictor
plot(Auto$horsepower, Auto$weight, xlab = 'Horsepower', ylab = 'Weight')
abline(lm_auto, col = 'red')

#plotting the 97% confidence and prediction intervals 
new_sorted_data <- Auto[order(Auto$horsepower),]
new_sorted_data_df <- data.frame(horsepower = new_sorted_data$horsepower)
new_sorted_data_conf <- predict(lm_auto, new_sorted_data_df, interval = 'confidence', level = 0.97)
new_sorted_data_pred <- predict(lm_auto, new_sorted_data_df, interval = 'prediction', level = 0.97)

lines(new_sorted_data$horsepower, new_sorted_data_conf[,"lwr"], col="green", type="b", pch="+")
lines(new_sorted_data$horsepower, new_sorted_data_conf[,"upr"], col="green", type="b", pch="+")
lines(new_sorted_data$horsepower, new_sorted_data_pred[,"upr"], col="blue", type="b", pch="*")
lines(new_sorted_data$horsepower, new_sorted_data_pred[,"lwr"], col="blue", type="b", pch="*")
legend("bottomright",
       pch=c("+","*"),
       col=c("green","blue"),
       legend = c("confidence","prediction"))