from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import classification_report, confusion_matrix

import sys
import os
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))
from config.phishing_cfg import DatasetConfig, ModelConfig

import pandas as pd
import joblib
a

class TrainingData():
    def __init__(self) -> None:
        # To do code here
        pass
    
    
    def train(self):
        # To do code here
        pass
    
    def save_model(self):
        # To do code here
        # You need to save to weights folder
        pass