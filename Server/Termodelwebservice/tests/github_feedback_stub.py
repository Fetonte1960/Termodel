import json
import sys
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path

capture_path = Path(sys.argv[1])


class Handler(BaseHTTPRequestHandler):
    def do_POST(self):
        if self.path != "/repos/Fetonte1960/Termodel/issues":
            self.send_response(404)
            self.end_headers()
            return

        if self.headers.get("Transfer-Encoding", "").lower() == "chunked":
            chunks = []
            while True:
                size_line = self.rfile.readline().strip()
                size = int(size_line.split(b";", 1)[0], 16)
                if size == 0:
                    self.rfile.readline()
                    break
                chunks.append(self.rfile.read(size))
                self.rfile.read(2)
            raw = b"".join(chunks)
        else:
            length = int(self.headers.get("Content-Length", "0"))
            raw = self.rfile.read(length)

        payload = json.loads(raw.decode("utf-8"))

        capture = {
            "path": self.path,
            "authorization": self.headers.get("Authorization", ""),
            "userAgent": self.headers.get("User-Agent", ""),
            "accept": self.headers.get("Accept", ""),
            "apiVersion": self.headers.get("X-GitHub-Api-Version", ""),
            "payload": payload,
        }
        capture_path.write_text(
            json.dumps(capture, ensure_ascii=False, indent=2),
            encoding="utf-8",
        )

        response = {
            "number": 4242,
            "html_url": "https://github.com/Fetonte1960/Termodel/issues/4242",
        }
        body = json.dumps(response).encode("utf-8")

        self.send_response(201)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def log_message(self, format, *args):
        return


server = ThreadingHTTPServer(("127.0.0.1", 5099), Handler)
server.serve_forever()
