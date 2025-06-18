## ❤️ Heart Disease Prediction

- This project builds and compares machine learning models to predict the likelihood of heart disease based on clinical and lifestyle features. It was developed as part of an academic project using R, with a focus on predictive accuracy and interpretability.

## Project Summary

- **Goal:** Predict whether a person is at risk for heart disease using health data.
- **Dataset:** UCI Heart Disease Dataset (11 predictor variables)
- **Tech Stack:** R, caret, randomForest, e1071, ggplot2
- **Best Model Accuracy:** 87% on test data

## Models Used

- **Logistic Regression (GLM)**
- **Support Vector Machine (SVM)**
- **Random Forest**

Each model was evaluated using accuracy and visualized with predicted vs. actual outcomes. SVM and Random Forest showed strong performance.

## Features Used

- Age
- Sex
- Chest Pain Type
- Resting Blood Pressure
- Cholesterol
- Fasting Blood Sugar
- Resting ECG Results
- Max Heart Rate
- Exercise-induced Angina
- Oldpeak (ST depression)
- ST Slope

## Results

| Model             | Accuracy |
|------------------|----------|
| Logistic Regression | ~84%     |
| Random Forest       | ~87%     |
| SVM                 | ~86%     |

> Accuracy may vary slightly based on random seed and cross-validation splits.

## R Packages Used

- `dplyr`, `ggplot2` – data manipulation and visualization
- `caret` – model training and tuning
- `randomForest` – ensemble learning
- `e1071` – SVM modeling

## Sample Outputs
- Confusion matrix
- Accuracy plots
- Predicted vs. actual charts
