import json
import threading
import urllib.request
from http.server import BaseHTTPRequestHandler, HTTPServer


def fetch_json(url, timeout=5):
    with urllib.request.urlopen(url, timeout=timeout) as resp:
        raw = resp.read()
    try:
        return json.loads(raw)
    except json.JSONDecodeError as e:
        raise ValueError(f"response from {url} was not valid JSON") from e


class _JsonHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.end_headers()
        self.wfile.write(b'{"ok": true}')

    def log_message(self, *args):
        pass


class _NotJsonHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.end_headers()
        self.wfile.write(b"not json")

    def log_message(self, *args):
        pass


def _run(handler_cls):
    server = HTTPServer(("127.0.0.1", 0), handler_cls)
    threading.Thread(target=server.serve_forever, daemon=True).start()
    return server


if __name__ == "__main__":
    json_server = _run(_JsonHandler)
    port = json_server.server_address[1]
    assert fetch_json(f"http://127.0.0.1:{port}/") == {"ok": True}
    json_server.shutdown()

    bad_server = _run(_NotJsonHandler)
    port = bad_server.server_address[1]
    try:
        fetch_json(f"http://127.0.0.1:{port}/")
        assert False, "expected ValueError"
    except ValueError:
        pass
    bad_server.shutdown()

    print("ok")
