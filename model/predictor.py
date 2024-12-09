from preprocessing import Preprocessing

import joblib
# import asyncio

class Predictor():
    def __init__(self, model_path) -> None:
        self.process = Preprocessing()
        self.model = self.load_model(model_path)
    
    async def predict(self, url: str):
        processed_url = self.process(url)
        processed_url = processed_url.reshape(1, -1)
        print(f"Processed URL: {processed_url}")
        pred = await self.model_inference(processed_url)
        ## To do code here
        return pred
        
    async def model_inference(self, processed_url):
        output = self.model.predict(processed_url)
        ## To do code here
        return output
    
    def load_model(self, model_path):
        ## To do code here
        return joblib.load(model_path)
    
# async def main():
#     model_path = "./model/weights/phishing_model.pkl"
#     predictor = Predictor(model_path)
#     url = "htt://www.google.com"
#     pred = await predictor.predict(url)  # Await the prediction
#     print(pred)

# # Run the async main function
# if __name__ == '__main__':
#     asyncio.run(main())
