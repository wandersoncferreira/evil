# overwrite the SQlite3 from my system because Linux is using an
# outdated and not supported version by ChromaDB

__import__('pysqlite3')
import sys
sys.modules['sqlite3'] = sys.modules.pop('pysqlite3')

## end of overwrite

import urllib.parse
import re
from ssor.config import config
from http.server import BaseHTTPRequestHandler, HTTPServer
from langchain_openai import OpenAIEmbeddings
from langchain_chroma import Chroma

persist_directory = config.get("config", "persist_directory")
openai_api_key = config.get("config", "openai_api_key")

class RequestHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-type', 'text/plain')
        self.end_headers()

        # Input
        request_str = urllib.parse.unquote(self.path.split("/api/")[-1])

        # Retrieve docs
        search_results = vectordb.similarity_search_with_score(request_str, k=10)
        retrieved_docs = sorted(search_results, key=lambda x: x[1], reverse=True)
        org_link_format = "[%.2f]: [[id:%s][%s]] \n %s"
        docs = [org_link_format % (score, doc.metadata["ID"],
                                   doc.metadata["title"].strip(),
                                   doc.metadata["hierarchy"].strip())
                for doc, score in retrieved_docs]

        # Format the output
        response_str = f"#+title: Most similar nodes \n\n:QUERY:\n{request_str} \n:END:\n\n"
        for i, source in enumerate(docs):
            response_str += "* " + source + "\n"

        self.wfile.write(response_str.encode())

def run_server():
    server_address = ('', 17042)
    httpd = HTTPServer(server_address, RequestHandler)
    print(f'Server is running on port {server_address[1]}')
    httpd.serve_forever()

if __name__ == '__main__':
    embedding = OpenAIEmbeddings(
        openai_api_key=openai_api_key,
        model="text-embedding-3-small"
        )
    vectordb = Chroma("langchain_store", embedding_function=embedding, persist_directory=persist_directory)
    run_server()
