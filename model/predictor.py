from preprocessing import Preprocessing
import sys
import os
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))
from config.phishing_cfg import ModelConfig
import joblib
import asyncio
class Predictor():
    def __init__(self, model_path=ModelConfig.MODEL_PATH) -> None:
        self.process = Preprocessing()
        self.model = self.load_model(model_path)
    
    async def predict(self, url: str):
        processed_url = self.process(url)
        processed_url = processed_url.reshape(1, -1)
        print(f"Processed URL: {processed_url}")
        pred = await self.model_inference(processed_url)
        return pred
        
    async def model_inference(self, processed_url):
        output = self.model.predict(processed_url)
        return output
    
    def load_model(self, model_path):
        return joblib.load(model_path)
    
async def pred(url: str):
    predictor = Predictor()
    pred = await predictor.predict(url)  # Await the prediction
    print("Result:" ,pred)


# Run the async main function
if __name__ == '__main__':
    url = "https://www.google.com"
    asyncio.run(pred(url))
    
