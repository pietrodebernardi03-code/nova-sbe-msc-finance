# Credit Score Prediction
**Introduction to Machine Learning · Nova SBE · 2025/26**

---

## Overview

This project builds a machine learning pipeline to predict individual credit scores from a set of financial and behavioural features. The work covers the full supervised learning workflow: exploratory data analysis, preprocessing, feature engineering, model selection, hyperparameter tuning, and evaluation — with interpretability analysis to understand which features drive predictions.

---

## Pipeline

### Data Preprocessing
- Handling of missing values and class imbalance
- Encoding of categorical features
- Feature scaling for distance-based and regularised models

### Models Evaluated
The project benchmarks multiple supervised learning algorithms:

| Model | Type |
|---|---|
| Logistic Regression | Linear baseline |
| Random Forest | Ensemble (bagging) |
| Gradient Boosting / XGBoost | Ensemble (boosting) |
| Support Vector Machine | Kernel-based |

### Evaluation Metrics
Given the class imbalance typical of credit data, accuracy alone is insufficient. The project reports precision, recall, F1-score, and ROC-AUC for each model.

### Interpretability
Feature importance is analysed to identify the principal drivers of credit score predictions, providing economic intuition alongside the statistical results.

---

## Files

| File | Description |
|---|---|
| `credit-score-prediction.ipynb` | Full notebook: EDA, preprocessing pipeline, model training and evaluation, feature importance analysis |

---

## Requirements

```bash
pip install pandas numpy scikit-learn xgboost matplotlib seaborn
```

---

## Data

> **Note:** The dataset used in this project is not included in the repository. Please refer to the course materials for access to the original data file. The notebook expects a CSV with credit-related features including payment history, credit utilisation, account age, and derogatory marks.

---
