-- You can run this SQL script to insert problems into the database
-- Use the command psql -d insert_db_name -f problems.sql

-- 1-D Dynamic Programming
-- 1. Climbing Stairs
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    70,
    'climbing-stairs',
    'Climbing Stairs',
    'Easy',
    'You are climbing a staircase. It takes n steps to reach the top. Each time you can either climb 1 or 2 steps. In how many distinct ways can you reach the top?',
    ARRAY[
        '1 <= n <= 45'
    ],
    '[
        {"input": "n = 2", "output": "2", "explanation": "There are two ways to reach the top: 1 step + 1 step or 2 steps."},
        {"input": "n = 3", "output": "3", "explanation": "There are three ways to reach the top: 1+1+1, 1+2, or 2+1."}
    ]'::jsonb,
    '1-D Dynamic Programming'
) ON CONFLICT (slug) DO NOTHING;

-- 2. House Robber
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    198,
    'house-robber',
    'House Robber',
    'Medium',
    'You are a professional robber planning to rob houses along a street. Each house has a certain amount of money stashed. All houses at this place are arranged in a circle. That means the first house is the neighbor of the last one. Meanwhile, adjacent houses have a security system connected, and it will automatically contact the police if two adjacent houses are broken into on the same night.',
    ARRAY[
        '1 <= nums.length <= 100',
        '0 <= nums[i] <= 400'
    ],
    '[
        {"input": "nums = [2,3,2]", "output": "3", "explanation": "Maximum amount of money you can rob is 3."},
        {"input": "nums = [1,2,3,1]", "output": "4", "explanation": "Maximum amount of money you can rob is 4."}
    ]'::jsonb,
    '1-D Dynamic Programming'
) ON CONFLICT (slug) DO NOTHING;

-- 3. House Robber II
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    213,
    'house-robber-ii',
    'House Robber II',
    'Medium',
    'You are a professional robber planning to rob houses along a street. Each house has a certain amount of money stashed. All houses at this place are arranged in a circle. That means the first house is the neighbor of the last one. Meanwhile, adjacent houses have a security system connected, and it will automatically contact the police if two adjacent houses are broken into on the same night.',
    ARRAY[
        '1 <= nums.length <= 100',
        '0 <= nums[i] <= 400'
    ],
    '[
        {"input": "nums = [2,3,2]", "output": "3", "explanation": "Maximum amount of money you can rob is 3."},
        {"input": "nums = [1,2,3,1]", "output": "4", "explanation": "Maximum amount of money you can rob is 4."}
    ]'::jsonb,
    '1-D Dynamic Programming'
) ON CONFLICT (slug) DO NOTHING;

-- 4. Longest Palindromic Substring
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    5,
    'longest-palindromic-substring',
    'Longest Palindromic Substring',
    'Medium',
    'Given a string s, return the longest palindromic substring in s.',
    ARRAY[
        '1 <= s.length <= 1000',
        's consist of only digits and English letters'
    ],
    '[
        {"input": "s = \"babad\"", "output": "\"bab\"", "explanation": "\"aba\" is also a valid answer."},
        {"input": "s = \"cbbd\"", "output": "\"bb\"", "explanation": "The longest palindromic substring is \"bb\"."}
    ]'::jsonb,
    '1-D Dynamic Programming'
) ON CONFLICT (slug) DO NOTHING;

-- 5. Palindromic Substrings
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    647,
    'palindromic-substrings',
    'Palindromic Substrings',
    'Medium',
    'Given a string s, return the number of palindromic substrings in it.',
    ARRAY[
        '1 <= s.length <= 1000',
        's consist of only digits and English letters'
    ],
    '[
        {"input": "s = \"abc\"", "output": "3", "explanation": "Three palindromic strings: \"a\", \"b\", \"c\"."},
        {"input": "s = \"aaa\"", "output": "6", "explanation": "Six palindromic strings: \"a\", \"a\", \"a\", \"aa\", \"aa\", \"aaa\"."}
    ]'::jsonb,
    '1-D Dynamic Programming'
) ON CONFLICT (slug) DO NOTHING;

-- 6. Decode Ways
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    91,
    'decode-ways',
    'Decode Ways',
    'Medium',
    'A message containing letters from A-Z can be encoded into numbers using the following mapping:',
    ARRAY[
        '1 <= s.length <= 100',
        's consist of only digits and may contain leading zero(s)'
    ],
    '[
        {"input": "s = \"12\"", "output": "2", "explanation": "\"AB\" (1 2) or \"L\" (12)." },
        {"input": "s = \"226\"", "output": "3", "explanation": "\"BBF\" (2 2 6), \"BZ\" (2 26), or \"VF\" (22 6)." }
    ]'::jsonb,
    '1-D Dynamic Programming'
) ON CONFLICT (slug) DO NOTHING;

-- 7. Coin Change
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    322,
    'coin-change',
    'Coin Change',
    'Medium',
    'You are given an integer array coins representing coins of different denominations and an integer amount representing a total amount of money.',
    ARRAY[
        '1 <= coins.length <= 12',
        '1 <= coins[i] <= 2^31 - 1',
        '0 <= amount <= 5000'
    ],
    '[
        {"input": "coins = [1,2,5], amount = 11", "output": "3", "explanation": "11 = 5 + 5 + 1."},
        {"input": "coins = [2], amount = 3", "output": "-1", "explanation": "Cannot make change for 3."}
    ]'::jsonb,
    '1-D Dynamic Programming'
) ON CONFLICT (slug) DO NOTHING;

-- 8. Maximum Product Subarray
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    152,
    'maximum-product-subarray',
    'Maximum Product Subarray',
    'Medium',
    'Given an integer array nums, find a contiguous subarray within an array (containing at least one number) which has the largest product.',
    ARRAY[
        '1 <= nums.length <= 2 * 10^4',
        '-10 <= nums[i] <= 10'
    ],
    '[
        {"input": "nums = [2,3,-2,4]", "output": "6", "explanation": "Subarray [2,3] has the largest product 6."},
        {"input": "nums = [-2,0,-1]", "output": "0", "explanation": "Subarray [-2] has the largest product 0."}
    ]'::jsonb,
    '1-D Dynamic Programming'
) ON CONFLICT (slug) DO NOTHING;

-- 9. Word Break
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    139,
    'word-break',
    'Word Break',
    'Medium',
    'Given a string s and a dictionary of strings wordDict, return true if s can be segmented into a space-separated sequence of one or more dictionary words.',
    ARRAY[
        '1 <= s.length <= 300',
        '1 <= wordDict.length <= 1000',
        '1 <= wordDict[i].length <= 20',
        's and wordDict[i] consist of only lowercase English letters.'
    ],
    '[
        {"input": "s = \"leetcode\", wordDict = [\"leet\",\"code\"]", "output": "true", "explanation": "Return true because \"leetcode\" can be segmented as \"leet code\"."},
        {"input": "s = \"applepenapple\", wordDict = [\"apple\",\"pen\"]", "output": "true", "explanation": "Return true because \"applepenapple\" can be segmented as \"apple pen apple\"."}
    ]'::jsonb,
    '1-D Dynamic Programming'
) ON CONFLICT (slug) DO NOTHING;

-- 10. Longest Increasing Subsequence
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    300,
    'longest-increasing-subsequence',
    'Longest Increasing Subsequence',
    'Medium',
    'Given an integer array nums, return the length of the longest strictly increasing subsequence.',
    ARRAY[
        '1 <= nums.length <= 2500',
        '-10^4 <= nums[i] <= 10^4'
    ],
    '[
        {"input": "nums = [10,9,2,5,3,7,101,18]", "output": "4", "explanation": "The longest increasing subsequence is [2,3,7,101], therefore the length is 4."},
        {"input": "nums = [0,1,0,3,2,3]", "output": "4", "explanation": "The longest increasing subsequence is [0,1,2,3]."},
        {"input": "nums = [7,7,7,7,7,7,7]", "output": "1", "explanation": "All elements are the same, so the longest increasing subsequence has length 1."}
    ]'::jsonb,
    '1-D Dynamic Programming'
) ON CONFLICT (slug) DO NOTHING;

-- 2-D Dynamic Programming
-- 1. Unique Paths
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    62,
    'unique-paths',
    'Unique Paths',
    'Medium',
    'A robot is located at the top-left corner of an m x n grid. The robot can only move either down or right at any point in time. The robot is trying to reach the bottom-right corner of the grid. Return the number of possible unique paths.',
    ARRAY[
        '1 <= m, n <= 100'
    ],
    '[
        {"input": "m = 3, n = 7", "output": "28", "explanation": "There are 28 unique paths for the robot to reach the bottom-right corner."},
        {"input": "m = 3, n = 2", "output": "3", "explanation": "Three possible paths: down->down->right, down->right->down, right->down->down."}
    ]'::jsonb,
    '2-D Dynamic Programming'
) ON CONFLICT (slug) DO NOTHING;

-- 2. Longest Common Subsequence
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    1143,
    'longest-common-subsequence',
    'Longest Common Subsequence',
    'Medium',
    'Given two strings text1 and text2, return the length of their longest common subsequence. A subsequence of a string is a new string generated from the original string with some characters (can be none) deleted without changing the relative order of the remaining characters.',
    ARRAY[
        '1 <= text1.length, text2.length <= 1000',
        'text1 and text2 consist of only lowercase English characters.'
    ],
    '[
        {"input": "text1 = \"abcde\", text2 = \"ace\"", "output": "3", "explanation": "The longest common subsequence is \"ace\"."},
        {"input": "text1 = \"abc\", text2 = \"abc\"", "output": "3", "explanation": "The longest common subsequence is \"abc\"."},
        {"input": "text1 = \"abc\", text2 = \"def\"", "output": "0", "explanation": "There is no common subsequence."}
    ]'::jsonb,
    '2-D Dynamic Programming'
) ON CONFLICT (slug) DO NOTHING;