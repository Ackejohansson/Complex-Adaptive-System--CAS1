import unittest
import main


class TestMain(unittest.TestCase):

    def test_add(self):
        self.assertEqual(main.add(10, 5), 15)
        self.assertEqual(main.add(-1, -1), -2)
        self.assertEqual(main.add(3, -1), 2)
        self.assertEqual(main.add(10, 5), 15)

if __name__ == '__main__':
    unittest.main()
