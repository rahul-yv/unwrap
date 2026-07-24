# Exercises: Networking and APIs

1. Write `fetch_json(url, timeout=5)` that opens `url` with `urllib.request.urlopen(url, timeout=timeout)` and returns the parsed JSON body. If the response body isn't valid JSON, raise `ValueError` with a clear message instead of letting `json.JSONDecodeError` propagate uncaught.

Check your answer against [`solutions/exercise_1.py`](./solutions/exercise_1.py).
