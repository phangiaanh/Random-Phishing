import sys
sys.path.insert(1, 'service')

import service.requestphishing_pb2_grpc as phishing_grpc
import service.requestphishing_pb2 as phishing
import grpc
import logging
import numpy as np
from concurrent import futures
import functools
            

class PhishingServer(phishing_grpc.PhishingDetectorServicer):
    def RequestCheckingPhishing(self, request, context):

        
        return phishing.PhishingResponse()
    


def serve():
    port = "9999"
    server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
    phishing_grpc.add_PhishingDetectorServicer_to_server(PhishingServer(), server)
    server.add_insecure_port("[::]:" + port)
    server.start()
    print("Server started, listening on " + port)
    server.wait_for_termination()


if __name__=="__main__":
    logging.basicConfig()
    serve()