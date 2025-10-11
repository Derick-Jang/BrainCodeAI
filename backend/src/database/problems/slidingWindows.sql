-- You can run this SQL script to insert problems into the database
-- Use the command psql -d insert_db_name -f problems.sql

-- Sliding Window
-- 121. Best Time to Buy and Sell Stock
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category) 
VALUES (
    121,
    'best-time-to-buy-and-sell-stock',
    'Best Time to Buy and Sell Stock',
    'Easy',
    'You are given an array prices where prices[i] is the price of a given stock on the ith day. You want to maximize your profit by choosing a single day to buy and a different day to sell. Return the maximum profit you can achieve. If you cannot achieve any profit, return 0.',
    ARRAY[
        '1 <= prices.length <= 10^5',
        '0 <= prices[i] <= 10^4'
    ],
    '[
        {"input": "prices = [7,1,5,3,6,4]", "output": "5", "explanation": "Buy on day 2 (price=1) and sell on day 5 (price=6) for profit 5."},
        {"input": "prices = [7,6,4,3,1]", "output": "0", "explanation": "No profit can be achieved."}
    ]'::jsonb,
    'Sliding-Window'
) ON CONFLICT (slug) DO NOTHING;

-- 3. Longest Substring Without Repeating Characters
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category) 
VALUES (
    3,
    'longest-substring-without-repeating-characters',
    'Longest Substring Without Repeating Characters',
    'Medium',
    'Given a string s, find the length of the longest substring without repeating characters.',
    ARRAY[
        '0 <= s.length <= 5 * 10^4',
        's consists of English letters, digits, symbols, and spaces.'
    ],
    '[
        {"input": "s = \"abcabcbb\"", "output": "3", "explanation": "The answer is \"abc\"."},
        {"input": "s = \"bbbbb\"", "output": "1", "explanation": "The answer is \"b\"."},
        {"input": "s = \"pwwkew\"", "output": "3", "explanation": "The answer is \"wke\"."}
    ]'::jsonb,
    'Sliding-Window'
) ON CONFLICT (slug) DO NOTHING;

-- 424. Longest Repeating Character Replacement
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category) 
VALUES (
    424,
    'longest-repeating-character-replacement',
    'Longest Repeating Character Replacement',
    'Medium',
    'Given a string s and an integer k, you can choose any character and change it to any other uppercase English character. Find the length of the longest substring containing the same letter you can get after performing at most k changes.',
    ARRAY[
        '1 <= s.length <= 10^5',
        's consists of uppercase English letters.',
        '0 <= k <= s.length'
    ],
    '[
        {"input": "s = \"ABAB\", k = 2", "output": "4", "explanation": "Change two B''s to A''s to get \"AAAA\"."},
        {"input": "s = \"AABABBA\", k = 1", "output": "4", "explanation": "Change one B to A to get \"AABAAAA\"."}
    ]'::jsonb,
    'Sliding-Window'
) ON CONFLICT (slug) DO NOTHING;

-- 76. Minimum Window Substring
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category) 
VALUES (
    76,
    'minimum-window-substring',
    'Minimum Window Substring',
    'Hard',
    'Given two strings s and t, return the minimum window substring of s such that every character in t (including duplicates) is included in the window. If there is no such substring, return the empty string "".',
    ARRAY[
        '1 <= s.length, t.length <= 10^5',
        's and t consist of English letters.'
    ],
    '[
        {"input": "s = \"ADOBECODEBANC\", t = \"ABC\"", "output": "\"BANC\"", "explanation": "The minimum window containing A, B, C."},
        {"input": "s = \"a\", t = \"a\"", "output": "\"a\"", "explanation": "Single character match."},
        {"input": "s = \"a\", t = \"aa\"", "output": "\"\"", "explanation": "Not enough characters in s."}
    ]'::jsonb,
    'Sliding-Window'
) ON CONFLICT (slug) DO NOTHING;