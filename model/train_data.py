from sklearn.model_selection import train_test_split, GridSearchCV
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import classification_report, confusion_matrix

import sys
import os
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))
from config.phishing_cfg import DatasetConfig, ModelConfig

import pandas as pd
import joblib


class TrainingData():
    def __init__(self, conf=None) -> None:
        self.config = DatasetConfig()
        self.model_config = ModelConfig()
        self.full_data = None
        self.training_data = self.load_data(self.model_config.TEST_RATIO)
        
    def load_data(self, test_ratio):
        self.full_data = pd.read_csv(self.config.DATASET_PATH, usecols=['UsingIP', 'LongURL', 'ShortURL', 'Redirecting//', 'PrefixSuffix-', 'Symbol@', 'SubDomains', 'HTTPS', 'class'])
        x = self.full_data.drop('class', axis=1).values
        y = self.full_data['class'].values
        x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=test_ratio, random_state=42)
        return x_train, x_test, y_train, y_test
    
    def train(self, 
              params = {
                "n_estimators": [50, 100, 200],
                'criterion': ["gini", "entropy", "log_loss"],
                'max_depth': [None, 2, 5]}
              ):
        x_train, x_test, y_train, y_test = self.training_data
        grid_search = GridSearchCV(
            estimator=RandomForestClassifier(),
            param_grid=params,
            scoring="recall",
            cv=6,
            n_jobs=-1,
            verbose=1
        )
        
        grid_search.fit(x_train, y_train)
        print(grid_search.best_estimator_)
        print(grid_search.best_params_)
        print(grid_search.best_score_)
        
        y_predict = grid_search.predict(x_test)
        self.save_model(grid_search)
        
        return classification_report(y_test, y_predict), confusion_matrix(y_test, y_predict)
            
    def save_model(self, grid_search):
        # Save model
        model_path = self.model_config.MODEL_PATH
        joblib.dump(grid_search.best_estimator_, model_path)
        
if __name__ == '__main__':
    train = TrainingData()
    report, matrix = train.train()
    print(report)
    print(matrix)
        