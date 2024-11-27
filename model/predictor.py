from preprocessing import Preprocessing


class Predictor():
    def __init__(self, model_path) -> None:
        self.process = Preprocessing()
        self.model = self.load_model(model_path)
        pass
    
    async def predict(self, url: str):
        processed_url = self.process(url)
        pred = await self.model_inference(processed_url)
        ## To do code here
        return pred
        
    async def model_inference(self, processed_url):
        output = self.model.predict(processed_url)
        ## To do code here
        return output
    
    def load_model(self, model_path):
        ## To do code here
        pass