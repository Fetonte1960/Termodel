import base64
import json
import sys
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path

capture_path = Path(sys.argv[1])

BASE_COMMIT = "basecommit0000000000000000000000000000000000"
BASE_TREE = "basetree000000000000000000000000000000000000"
NEW_TREE = "newtree0000000000000000000000000000000000000"
NEW_COMMIT = "newcommit00000000000000000000000000000000000"

state = {
    "branch_sha": None,
    "blob_counter": 0,
    "blobs": {},
    "tree": None,
    "commit": None,
    "updated_ref": None,
    "requests": [],
}


def read_body(handler):
    if handler.headers.get("Transfer-Encoding", "").lower() == "chunked":
        chunks = []
        while True:
            size_line = handler.rfile.readline().strip()
            size = int(size_line.split(b";", 1)[0], 16)
            if size == 0:
                handler.rfile.readline()
                break
            chunks.append(handler.rfile.read(size))
            handler.rfile.read(2)
        return b"".join(chunks)

    length = int(handler.headers.get("Content-Length", "0"))
    return handler.rfile.read(length)


def json_response(handler, status, payload):
    body = json.dumps(payload).encode("utf-8")
    handler.send_response(status)
    handler.send_header("Content-Type", "application/json")
    handler.send_header("Content-Length", str(len(body)))
    handler.end_headers()
    handler.wfile.write(body)


def record_request(handler, payload=None):
    state["requests"].append(
        {
            "method": handler.command,
            "path": handler.path,
            "authorization": handler.headers.get("Authorization", ""),
            "userAgent": handler.headers.get("User-Agent", ""),
            "payload": payload,
        }
    )


def flush_capture():
    serializable = dict(state)
    serializable["blobs"] = {
        sha: {
            "size": len(raw),
            "base64": base64.b64encode(raw).decode("ascii"),
        }
        for sha, raw in state["blobs"].items()
    }
    capture_path.write_text(
        json.dumps(serializable, ensure_ascii=False, indent=2),
        encoding="utf-8",
    )


class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        record_request(self)

        if self.path == "/repos/Fetonte1960/Termodel/git/ref/heads/service-snapshots":
            if state["branch_sha"] is None:
                json_response(self, 404, {"message": "Not Found"})
            else:
                json_response(
                    self,
                    200,
                    {
                        "ref": "refs/heads/service-snapshots",
                        "object": {"sha": state["branch_sha"]},
                    },
                )
            return

        if self.path == "/repos/Fetonte1960/Termodel/git/ref/heads/main":
            json_response(
                self,
                200,
                {"ref": "refs/heads/main", "object": {"sha": BASE_COMMIT}},
            )
            return

        if self.path == f"/repos/Fetonte1960/Termodel/git/commits/{BASE_COMMIT}":
            json_response(self, 200, {"sha": BASE_COMMIT, "tree": {"sha": BASE_TREE}})
            return

        if self.path == f"/repos/Fetonte1960/Termodel/git/commits/{NEW_COMMIT}":
            json_response(self, 200, {"sha": NEW_COMMIT, "tree": {"sha": NEW_TREE}})
            return

        json_response(self, 404, {"message": "Not Found"})

    def do_POST(self):
        raw = read_body(self)
        payload = json.loads(raw.decode("utf-8") or "{}")
        record_request(self, payload)

        if self.path == "/repos/Fetonte1960/Termodel/git/refs":
            if payload.get("ref") != "refs/heads/service-snapshots":
                json_response(self, 422, {"message": "unexpected ref"})
                return
            state["branch_sha"] = payload.get("sha")
            flush_capture()
            json_response(
                self,
                201,
                {
                    "ref": payload["ref"],
                    "object": {"sha": state["branch_sha"]},
                },
            )
            return

        if self.path == "/repos/Fetonte1960/Termodel/git/blobs":
            state["blob_counter"] += 1
            sha = f"blob{state['blob_counter']:038d}"
            if payload.get("encoding") != "base64":
                json_response(self, 422, {"message": "encoding must be base64"})
                return
            state["blobs"][sha] = base64.b64decode(payload.get("content", ""))
            flush_capture()
            json_response(self, 201, {"sha": sha})
            return

        if self.path == "/repos/Fetonte1960/Termodel/git/trees":
            if payload.get("base_tree") not in (BASE_TREE, NEW_TREE):
                json_response(self, 422, {"message": "unexpected base tree"})
                return
            state["tree"] = payload
            flush_capture()
            json_response(self, 201, {"sha": NEW_TREE})
            return

        if self.path == "/repos/Fetonte1960/Termodel/git/commits":
            if payload.get("tree") != NEW_TREE:
                json_response(self, 422, {"message": "unexpected tree"})
                return
            state["commit"] = payload
            flush_capture()
            json_response(self, 201, {"sha": NEW_COMMIT})
            return

        json_response(self, 404, {"message": "Not Found"})

    def do_PATCH(self):
        raw = read_body(self)
        payload = json.loads(raw.decode("utf-8") or "{}")
        record_request(self, payload)

        if self.path == "/repos/Fetonte1960/Termodel/git/refs/heads/service-snapshots":
            if payload.get("sha") != NEW_COMMIT or payload.get("force") is not False:
                json_response(self, 422, {"message": "invalid ref update"})
                return
            state["branch_sha"] = NEW_COMMIT
            state["updated_ref"] = payload
            flush_capture()
            json_response(
                self,
                200,
                {
                    "ref": "refs/heads/service-snapshots",
                    "object": {"sha": NEW_COMMIT},
                },
            )
            return

        json_response(self, 404, {"message": "Not Found"})

    def log_message(self, format, *args):
        return


server = ThreadingHTTPServer(("127.0.0.1", 5100), Handler)
server.serve_forever()
