import sys
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))

from example import add


class TestAddExercise(unittest.TestCase):
    def test_zero(self):
        self.assertEqual(add(0, 0), 0)

    def test_cancelling_values(self):
        self.assertEqual(add(-1, 1), 0)


if __name__ == "__main__":
    unittest.main()
