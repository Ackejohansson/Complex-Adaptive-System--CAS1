import unittest
import Task3
import numpy as np


class TestMain(unittest.TestCase):
    def test_update_theta(self):
        self.assertEqual(Task3.update_theta(np.array([0, 0]), 1, 20, np.array([1,2]), 1e-2), np.array([0, 0]))


if __name__ == '__main__':
    unittest.main()