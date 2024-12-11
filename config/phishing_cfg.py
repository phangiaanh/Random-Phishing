class DatasetConfig():
    DATASET_PATH = "../model/data/phishing.csv"  


class ModelConfig():
    MODEL_PATH = "../model/weights/phishing_model.pkl"
    
    TEST_RATIO = 0.2
    
    #hyperparameters
    HYPERPARAMS = {
        "n_estimators": [50, 100, 200],
        'criterion': ["gini", "entropy", "log_loss"],
        'max_depth': [None, 2, 5]
    }
