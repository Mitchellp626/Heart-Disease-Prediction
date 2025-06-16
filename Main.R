heart_data <- read.csv("heart.csv")
library(tidyverse)
library(caret)
library(randomForest)
library(e1071)
library(ISLR)
library(usethis)
colSums(is.na(heart_data))

str(heart_data)

# A lot of these can be turned into factors
heart_data$Sex <- as.factor(heart_data$Sex)
heart_data$ChestPainType <- as.factor(heart_data$ChestPainType)
heart_data$FastingBS <- as.factor(heart_data$FastingBS)
heart_data$RestingECG <- as.factor(heart_data$RestingECG)
heart_data$ExerciseAngina <- as.factor(heart_data$ExerciseAngina)
heart_data$ST_Slope <- as.factor(heart_data$ST_Slope)
heart_data$HeartDisease <- as.factor(heart_data$HeartDisease)

str(heart_data)

#Splitting the Data into testing / training
set.seed(234)

Trainsamplesize <- floor(0.8 * nrow(heart_data))
train_ind <- sample(seq_len(nrow(heart_data)), size = Trainsamplesize)
train_data <- heart_data[train_ind, ]
test_data <- heart_data[-train_ind, ]

glm_model <- glm(HeartDisease ~., data = train_data, family = "binomial")
# Family = binomial because HeartDisease is  1 or 0
summary(glm_model)

glm_predict <- predict(glm_model, test_data, type = "response")
#Type Response because we want the probabilities.

class <- ifelse(glm_predict > 0.25, 1, 0) 

confusionMatrix(as.factor(class), test_data$HeartDisease)
# Accuracy from my first run is around 82.6 percent
# Accuracy after changing class is around 87%
# Precision: .8205
# Recall: .8649

######### Random forest

forest_model <- randomForest(HeartDisease ~., data = train_data, ntree = 500, mtry= 3, importance = TRUE)
forest_predict <- predict(forest_model, test_data, type = "prob")
forest_class <- ifelse(forest_predict[,"1"] > 0.4, 1, 0)
confusionMatrix(as.factor(forest_class), test_data$HeartDisease)
#Accuracy: 85.3%
# Precision: .8205. 
# Recall:.8421. 
# Accuracy from my first run is around 85.9 percent

varImpPlot(forest_model, main = "Forest Model")
# ST_Slope has an extremely high impact on the model, meaning it is highly correlated with a 
# person having heart disease or not.

# SVM
Svm_model <- svm(HeartDisease ~.,
                 data = train_data, 
                 kernel = "radial", 
                 cost = 1, 
                 gamma = 0.1
)
summary(Svm_model)
svm_predictions <- predict(Svm_model, test_data)

confusionMatrix(svm_predictions, test_data$HeartDisease) 

# we have more false negatives than false positives

set.seed(12345)

tuned_svm <- tune(svm, HeartDisease ~., 
                  data = train_data,
                  kernel = "radial",
                  ranges = list(cost = c(0.1, 1, 10, 100),
                                gamma = c(0.01, 0.1, 1, 10)))
best_model <- tuned_svm$best.model
print(best_model)

tuned_predictions <- predict(best_model, test_data, type = "prob")

confusionMatrix(tuned_predictions, test_data$HeartDisease) # around 87%


