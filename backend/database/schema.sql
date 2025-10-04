-- You can run this SQL script to create the database and tables
-- Use the command psql -d insert_db_name -f schema.sql

-- Create Users table
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,                          -- Unique user ID
    auth0_id VARCHAR(255) UNIQUE NOT NULL,         -- Auth0 user ID (e.g., "auth0|123456789")
    email VARCHAR(255) UNIQUE NOT NULL,            -- Email for login/reset
    name VARCHAR(255) NOT NULL                     -- User's name
);

-- Create Problems table
CREATE TABLE IF NOT EXISTS problems (
    id SERIAL PRIMARY KEY,                          -- Unique problem ID
    leetcode_problem_id INT UNIQUE NOT NULL,                            -- Problem number in list
    slug VARCHAR(100) UNIQUE NOT NULL,             -- URL-friendly identifier (e.g., "two-sum")
    title VARCHAR(255) NOT NULL,                    -- Problem title
    difficulty VARCHAR(20) NOT NULL CHECK (difficulty IN ('Easy', 'Medium', 'Hard')), -- Difficulty level
    description TEXT NOT NULL,                      -- Full problem description
    constraints TEXT[],                             -- Array of constraints
    examples JSONB NOT NULL,                        -- JSON array of example objects
    category VARCHAR(100) NOT NULL                  -- Problem pattern/category (e.g., "Array")
);

-- Create User Completions table
CREATE TABLE IF NOT EXISTS user_completions (
    id SERIAL PRIMARY KEY,                           -- Unique completion ID
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,     -- Foreign key to users
    problem_id INTEGER REFERENCES problems(id) ON DELETE CASCADE, -- Foreign key to problems
    category VARCHAR(100) NOT NULL,                  -- Store category at completion
    attempts INTEGER DEFAULT 1,                      -- Number of attempts before completion
    UNIQUE(user_id, problem_id)                      -- Prevent duplicate completions
);

-- Indexes for faster queries
CREATE INDEX IF NOT EXISTS idx_problems_category ON problems(category);
CREATE INDEX IF NOT EXISTS idx_user_completions_user ON user_completions(user_id);
CREATE INDEX IF NOT EXISTS idx_user_completions_problem ON user_completions(problem_id);

-- Arrays-&-Hashing
-- 217. Contains Duplicate
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category) 
VALUES (
    217,
    'contains-duplicate',
    'Contains Duplicate',
    'Easy',
    'Given an integer array nums, return true if any value appears at least twice in the array, and return false if every element is distinct.',
    ARRAY[
        '1 <= nums.length <= 10^5',
        '-10^9 <= nums[i] <= 10^9'
    ],
    '[
        {"input": "nums = [1,2,3,1]", "output": "true", "explanation": "1 appears twice."},
        {"input": "nums = [1,2,3,4]", "output": "false", "explanation": "All elements are distinct."},
        {"input": "nums = [1,1,1,3,3,4,3,2,4,2]", "output": "true", "explanation": "Multiple duplicates exist."}
    ]'::jsonb,
    'Arrays-&-Hashing'
) ON CONFLICT (slug) DO NOTHING;

-- 242. Valid Anagram
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category) 
VALUES (
    242,
    'valid-anagram',
    'Valid Anagram',
    'Easy',
    'Given two strings s and t, return true if t is an anagram of s, and false otherwise.',
    ARRAY[
        '1 <= s.length, t.length <= 5 * 10^4',
        's and t consist of lowercase English letters.'
    ],
    '[
        {"input": "s = \"anagram\", t = \"nagaram\"", "output": "true", "explanation": "Rearranging s gives t."},
        {"input": "s = \"rat\", t = \"car\"", "output": "false", "explanation": "Cannot form t from s."},
        {"input": "s = \"a\", t = \"a\"", "output": "true", "explanation": "Single letter anagram."}
    ]'::jsonb,
    'Arrays-&-Hashing'
) ON CONFLICT (slug) DO NOTHING;

-- 1. Two Sum
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category) 
VALUES (
    1,
    'two-sum',
    'Two Sum',
    'Easy',
    'Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.

You may assume that each input would have exactly one solution, and you may not use the same element twice.

You can return the answer in any order.',
    ARRAY[
        '2 <= nums.length <= 10^4',
        '-10^9 <= nums[i] <= 10^9',
        '-10^9 <= target <= 10^9',
        'Only one valid answer exists.'
    ],
    '[
        {"input": "nums = [2,7,11,15], target = 9", "output": "[0,1]", "explanation": "nums[0] + nums[1] == 9"},
        {"input": "nums = [3,2,4], target = 6", "output": "[1,2]", "explanation": "nums[1] + nums[2] == 6"},
        {"input": "nums = [3,3], target = 6", "output": "[0,1]", "explanation": "nums[0] + nums[1] == 6"}
    ]'::jsonb,
    'Arrays-&-Hashing'
) ON CONFLICT (slug) DO NOTHING;

-- 49. Group Anagrams
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category) 
VALUES (
    49,
    'group-anagrams',
    'Group Anagrams',
    'Medium',
    'Given an array of strings strs, group the anagrams together. You can return the answer in any order.',
    ARRAY[
        '1 <= strs.length <= 10^4',
        '0 <= strs[i].length <= 100',
        'strs[i] consists of lowercase English letters.'
    ],
    '[
        {"input": "strs = [\"eat\",\"tea\",\"tan\",\"ate\",\"nat\",\"bat\"]", "output": "[[\"eat\",\"tea\",\"ate\"],[\"tan\",\"nat\"],[\"bat\"]]", "explanation": "Group all anagrams together."},
        {"input": "strs = [\"\"]", "output": "[[\"\"]]", "explanation": "Single empty string."},
        {"input": "strs = [\"a\"]", "output": "[[\"a\"]]", "explanation": "Single string."}
    ]'::jsonb,
    'Arrays-&-Hashing'
) ON CONFLICT (slug) DO NOTHING;

-- 347. Top K Frequent Elements
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category) 
VALUES (
    347,
    'top-k-frequent-elements',
    'Top K Frequent Elements',
    'Medium',
    'Given an integer array nums and an integer k, return the k most frequent elements. You may return the answer in any order.',
    ARRAY[
        '1 <= nums.length <= 10^5',
        '-10^4 <= nums[i] <= 10^4',
        'k is in the range [1, the number of unique elements in nums].'
    ],
    '[
        {"input": "nums = [1,1,1,2,2,3], k = 2", "output": "[1,2]", "explanation": "1 appears 3 times, 2 appears 2 times."},
        {"input": "nums = [1], k = 1", "output": "[1]", "explanation": "Only one element."}
    ]'::jsonb,
    'Arrays-&-Hashing'
) ON CONFLICT (slug) DO NOTHING;

-- 271. Encode and Decode Strings
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category) 
VALUES (
    271,
    'encode-and-decode-strings',
    'Encode and Decode Strings',
    'Medium',
    'Design an algorithm to encode a list of strings to a single string. Then design a method to decode the single string back to the original list of strings.',
    ARRAY[
        '1 <= strs.length <= 10^4',
        '0 <= strs[i].length <= 1000',
        'strs[i] contains any possible characters.'
    ],
    '[
        {"input": "strs = [\"hello\",\"world\"]", "output": "\"5#hello5#world\"", "explanation": "Encode then decode successfully."},
        {"input": "strs = [\"\"]", "output": "\"0#\"", "explanation": "Encode empty string list."}
    ]'::jsonb,
    'Arrays-&-Hashing'
) ON CONFLICT (slug) DO NOTHING;

-- 238. Product of Array Except Self
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category) 
VALUES (
    238,
    'product-of-array-except-self',
    'Product of Array Except Self',
    'Medium',
    'Given an integer array nums, return an array answer such that answer[i] is equal to the product of all the elements of nums except nums[i].',
    ARRAY[
        '2 <= nums.length <= 10^5',
        '-30 <= nums[i] <= 30',
        'The product of any prefix or suffix of nums is guaranteed to fit in a 32-bit integer.'
    ],
    '[
        {"input": "nums = [1,2,3,4]", "output": "[24,12,8,6]", "explanation": "Products except self."},
        {"input": "nums = [-1,1,0,-3,3]", "output": "[0,0,9,0,0]", "explanation": "Products including zero."}
    ]'::jsonb,
    'Arrays-&-Hashing'
) ON CONFLICT (slug) DO NOTHING;

-- 128. Longest Consecutive Sequence
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category) 
VALUES (
    128,
    'longest-consecutive-sequence',
    'Longest Consecutive Sequence',
    'Hard',
    'Given an unsorted array of integers nums, return the length of the longest consecutive elements sequence.',
    ARRAY[
        '0 <= nums.length <= 10^5',
        '-10^9 <= nums[i] <= 10^9'
    ],
    '[
        {"input": "nums = [100,4,200,1,3,2]", "output": "4", "explanation": "Longest sequence is [1,2,3,4]."},
        {"input": "nums = [0,3,7,2,5,8,4,6,0,1]", "output": "9", "explanation": "Longest sequence is [0,1,2,3,4,5,6,7,8]."}
    ]'::jsonb,
    'Arrays-&-Hashing'
) ON CONFLICT (slug) DO NOTHING;

-- Two-Pointers
-- 125. Valid Palindrome
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category) 
VALUES (
    125,
    'valid-palindrome',
    'Valid Palindrome',
    'Easy',
    'Given a string s, determine if it is a palindrome, considering only alphanumeric characters and ignoring cases.',
    ARRAY[
        '1 <= s.length <= 2 * 10^5',
        's consists only of printable ASCII characters.'
    ],
    '[
        {"input": "s = \"A man, a plan, a canal: Panama\"", "output": "true", "explanation": "Ignoring non-alphanumeric and case, it reads the same backwards."},
        {"input": "s = \"race a car\"", "output": "false", "explanation": "It is not a palindrome."},
        {"input": "s = \"\"", "output": "true", "explanation": "Empty string is a palindrome."}
    ]'::jsonb,
    'Two-Pointers'
) ON CONFLICT (slug) DO NOTHING;

-- 15. 3Sum
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category) 
VALUES (
    15,
    '3sum',
    '3Sum',
    'Medium',
    'Given an integer array nums, return all the triplets [nums[i], nums[j], nums[k]] such that i != j != k and nums[i] + nums[j] + nums[k] == 0. The solution set must not contain duplicate triplets.',
    ARRAY[
        '3 <= nums.length <= 3000',
        '-10^5 <= nums[i] <= 10^5'
    ],
    '[
        {"input": "nums = [-1,0,1,2,-1,-4]", "output": "[[-1,-1,2],[-1,0,1]]", "explanation": "Two unique triplets sum to zero."},
        {"input": "nums = [0,1,1]", "output": "[]", "explanation": "No triplet sums to zero."},
        {"input": "nums = [0,0,0]", "output": "[[0,0,0]]", "explanation": "Single triplet sums to zero."}
    ]'::jsonb,
    'Two-Pointers'
) ON CONFLICT (slug) DO NOTHING;

-- 11. Container With Most Water
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category) 
VALUES (
    11,
    'container-with-most-water',
    'Container With Most Water',
    'Medium',
    'Given n non-negative integers height where each represents a vertical line on the x-axis, find two lines that together with the x-axis form a container, such that the container contains the most water.',
    ARRAY[
        '2 <= height.length <= 10^5',
        '0 <= height[i] <= 10^4'
    ],
    '[
        {"input": "height = [1,8,6,2,5,4,8,3,7]", "output": "49", "explanation": "Lines at indices 1 and 8 form the container with most water."},
        {"input": "height = [1,1]", "output": "1", "explanation": "Only two lines exist."}
    ]'::jsonb,
    'Two-Pointers'
) ON CONFLICT (slug) DO NOTHING;

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

-- Stack
-- 20. Valid Parentheses
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category) 
VALUES (
    20,
    'valid-parentheses',
    'Valid Parentheses',
    'Easy',
    'Given a string s containing just the characters ''('', '')'', ''{'' ,''}'', ''['' and '']'', determine if the input string is valid. An input string is valid if: 
1. Open brackets must be closed by the same type of brackets.
2. Open brackets must be closed in the correct order.',
    ARRAY[
        '1 <= s.length <= 10^4',
        's consists of parentheses only: ''()[]{}'''
    ],
    '[
        {"input": "s = \"()\"", "output": "true", "explanation": "Simple matching parentheses."},
        {"input": "s = \"()[]{}\"", "output": "true", "explanation": "Multiple types of brackets in correct order."},
        {"input": "s = \"(]\"", "output": "false", "explanation": "Mismatched brackets."}
    ]'::jsonb,
    'Stack'
) ON CONFLICT (slug) DO NOTHING;

-- Binary Search
-- 153. Find Minimum In Rotated Sorted Array
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category) 
VALUES (
    153,
    'find-minimum-in-rotated-sorted-array',
    'Find Minimum In Rotated Sorted Array',
    'Medium',
    'Suppose an array of length n sorted in ascending order is rotated between 1 and n times. Given the rotated array nums, return the minimum element of this array.',
    ARRAY[
        '1 <= nums.length <= 5000',
        '-5000 <= nums[i] <= 5000',
        'All integers in nums are unique.',
        'nums is rotated at some pivot.'
    ],
    '[
        {"input": "nums = [3,4,5,1,2]", "output": "1", "explanation": "1 is the minimum element."},
        {"input": "nums = [4,5,6,7,0,1,2]", "output": "0", "explanation": "0 is the minimum element."},
        {"input": "nums = [11,13,15,17]", "output": "11", "explanation": "Array not rotated, minimum is first element."}
    ]'::jsonb,
    'Binary-Search'
) ON CONFLICT (slug) DO NOTHING;

-- 33. Search In Rotated Sorted Array
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category) 
VALUES (
    33,
    'search-in-rotated-sorted-array',
    'Search In Rotated Sorted Array',
    'Medium',
    'You are given a rotated sorted array nums and an integer target. Return the index of target if it exists, otherwise return -1.',
    ARRAY[
        '1 <= nums.length <= 5000',
        '-10^4 <= nums[i] <= 10^4',
        'All integers in nums are unique.',
        'nums is rotated at some pivot.'
    ],
    '[
        {"input": "nums = [4,5,6,7,0,1,2], target = 0", "output": "4", "explanation": "Target found at index 4."},
        {"input": "nums = [4,5,6,7,0,1,2], target = 3", "output": "-1", "explanation": "Target not in array."},
        {"input": "nums = [1], target = 0", "output": "-1", "explanation": "Single-element array, target not found."}
    ]'::jsonb,
    'Binary-Search'
) ON CONFLICT (slug) DO NOTHING;

-- Linked List
-- 206. Reverse Linked List
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category) 
VALUES (
    206,
    'reverse-linked-list',
    'Reverse Linked List',
    'Easy',
    'Given the head of a singly linked list, reverse the list, and return the reversed list.',
    ARRAY[
        'The number of nodes in the list is in the range [0, 5000]',
        '-5000 <= Node.val <= 5000'
    ],
    '[
        {"input": "head = [1,2,3,4,5]", "output": "[5,4,3,2,1]", "explanation": "Reverse the list."},
        {"input": "head = [1,2]", "output": "[2,1]", "explanation": "Reverse the list."},
        {"input": "head = []", "output": "[]", "explanation": "Empty list remains empty."}
    ]'::jsonb,
    'Linked-List'
) ON CONFLICT (slug) DO NOTHING;

-- 21. Merge Two Sorted Lists
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category) 
VALUES (
    21,
    'merge-two-sorted-lists',
    'Merge Two Sorted Lists',
    'Easy',
    'Merge two sorted linked lists and return it as a sorted list. The list should be made by splicing together the nodes of the first two lists.',
    ARRAY[
        'The number of nodes in both lists is in the range [0, 50]',
        '-100 <= Node.val <= 100'
    ],
    '[
        {"input": "l1 = [1,2,4], l2 = [1,3,4]", "output": "[1,1,2,3,4,4]", "explanation": "Merge sorted lists."},
        {"input": "l1 = [], l2 = []", "output": "[]", "explanation": "Both lists empty."},
        {"input": "l1 = [], l2 = [0]", "output": "[0]", "explanation": "One empty list."}
    ]'::jsonb,
    'Linked-List'
) ON CONFLICT (slug) DO NOTHING;

-- 141. Linked List Cycle
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category) 
VALUES (
    141,
    'linked-list-cycle',
    'Linked List Cycle',
    'Easy',
    'Given head, determine if the linked list has a cycle in it. Return true if there is a cycle, otherwise false.',
    ARRAY[
        'The number of nodes in the list is in the range [0, 10^4]',
        '-10^5 <= Node.val <= 10^5'
    ],
    '[
        {"input": "head = [3,2,0,-4], pos = 1", "output": "true", "explanation": "Cycle at position 1."},
        {"input": "head = [1,2], pos = 0", "output": "true", "explanation": "Cycle at position 0."},
        {"input": "head = [1], pos = -1", "output": "false", "explanation": "No cycle."}
    ]'::jsonb,
    'Linked-List'
) ON CONFLICT (slug) DO NOTHING;

-- 143. Reorder List
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category) 
VALUES (
    143,
    'reorder-list',
    'Reorder List',
    'Medium',
    'Given the head of a singly linked list, reorder it to: L0 → Ln → L1 → Ln-1 → L2 → Ln-2 → …',
    ARRAY[
        'The number of nodes in the list is in the range [1, 5 * 10^4]',
        '1 <= Node.val <= 1000'
    ],
    '[
        {"input": "head = [1,2,3,4]", "output": "[1,4,2,3]", "explanation": "Reorder the list."},
        {"input": "head = [1,2,3,4,5]", "output": "[1,5,2,4,3]", "explanation": "Reorder the list."}
    ]'::jsonb,
    'Linked-List'
) ON CONFLICT (slug) DO NOTHING;

-- 19. Remove Nth Node From End of List
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category) 
VALUES (
    19,
    'remove-nth-node-from-end-of-list',
    'Remove Nth Node From End of List',
    'Medium',
    'Given the head of a linked list, remove the nth node from the end and return its head.',
    ARRAY[
        'The number of nodes in the list is in the range [1, 30]',
        '0 <= Node.val <= 100',
        '1 <= n <= size of list'
    ],
    '[
        {"input": "head = [1,2,3,4,5], n = 2", "output": "[1,2,3,5]", "explanation": "Remove second from end."},
        {"input": "head = [1], n = 1", "output": "[]", "explanation": "Remove only node."},
        {"input": "head = [1,2], n = 1", "output": "[1]", "explanation": "Remove last node."}
    ]'::jsonb,
    'Linked-List'
) ON CONFLICT (slug) DO NOTHING;

-- 23. Merge K Sorted Lists
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category) 
VALUES (
    23,
    'merge-k-sorted-lists',
    'Merge K Sorted Lists',
    'Hard',
    'You are given an array of k linked-lists lists, each linked list is sorted in ascending order. Merge all the linked lists into one sorted linked list and return it.',
    ARRAY[
        'k == lists.length',
        '0 <= k <= 10^4',
        '0 <= lists[i].length <= 500',
        '-10^4 <= Node.val <= 10^4',
        'lists[i] is sorted in ascending order.'
    ],
    '[
        {"input": "lists = [[1,4,5],[1,3,4],[2,6]]", "output": "[1,1,2,3,4,4,5,6]", "explanation": "Merge all lists."},
        {"input": "lists = []", "output": "[]", "explanation": "Empty array of lists."},
        {"input": "lists = [[]]", "output": "[]", "explanation": "Array with empty list."}
    ]'::jsonb,
    'Linked-List'
) ON CONFLICT (slug) DO NOTHING;

-- Trees
-- 226. Invert Binary Tree
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category) 
VALUES (
    226,
    'invert-binary-tree',
    'Invert Binary Tree',
    'Easy',
    'Given the root of a binary tree, invert the tree and return its root.',
    ARRAY[
        'The number of nodes in the tree is in the range [0, 100]',
        '-100 <= Node.val <= 100'
    ],
    '[
        {"input": "root = [4,2,7,1,3,6,9]", "output": "[4,7,2,9,6,3,1]", "explanation": "Invert left and right subtrees recursively."},
        {"input": "root = [2,1,3]", "output": "[2,3,1]", "explanation": "Swap left and right children."}
    ]'::jsonb,
    'Trees'
) ON CONFLICT (slug) DO NOTHING;

-- 104. Maximum Depth of Binary Tree
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category) 
VALUES (
    104,
    'maximum-depth-of-binary-tree',
    'Maximum Depth of Binary Tree',
    'Easy',
    'Given the root of a binary tree, return its maximum depth.',
    ARRAY[
        'The number of nodes in the tree is in the range [0, 10^4]',
        '-100 <= Node.val <= 100'
    ],
    '[
        {"input": "root = [3,9,20,null,null,15,7]", "output": "3", "explanation": "Depth is 3."},
        {"input": "root = [1,null,2]", "output": "2", "explanation": "Depth is 2."}
    ]'::jsonb,
    'Trees'
) ON CONFLICT (slug) DO NOTHING;

-- 100. Same Tree
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    100,
    'same-tree',
    'Same Tree',
    'Easy',
    'Given the roots of two binary trees p and q, check if they are the same. Two binary trees are the same if they are structurally identical and the nodes have the same value.',
    ARRAY[
        'The number of nodes in both trees is in the range [0, 100]',
        '-10^4 <= Node.val <= 10^4'
    ],
    '[
        {"input": "p = [1,2,3], q = [1,2,3]", "output": "true", "explanation": "Trees are identical."},
        {"input": "p = [1,2], q = [1,null,2]", "output": "false", "explanation": "Trees have different structures."}
    ]'::jsonb,
    'Trees'
) ON CONFLICT (slug) DO NOTHING;

-- 572. Subtree of Another Tree
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    572,
    'subtree-of-another-tree',
    'Subtree of Another Tree',
    'Easy',
    'Given the roots of two binary trees root and subRoot, return true if there is a subtree of root with the same structure and node values as subRoot.',
    ARRAY[
        'The number of nodes in root is in the range [1, 2000]',
        'The number of nodes in subRoot is in the range [1, 1000]',
        '-10^4 <= Node.val <= 10^4'
    ],
    '[
        {"input": "root = [3,4,5,1,2], subRoot = [4,1,2]", "output": "true", "explanation": "subRoot is a subtree of root."},
        {"input": "root = [3,4,5,1,2,null,null,null,null,0], subRoot = [4,1,2]", "output": "false", "explanation": "subRoot is not a subtree."}
    ]'::jsonb,
    'Trees'
) ON CONFLICT (slug) DO NOTHING;

-- 235. Lowest Common Ancestor of a BST
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    235,
    'lowest-common-ancestor-of-bst',
    'Lowest Common Ancestor of a Binary Search Tree',
    'Easy',
    'Given a BST and two nodes p and q, return their lowest common ancestor (LCA).',
    ARRAY[
        'The number of nodes in the tree is in the range [2, 10^5]',
        '-10^9 <= Node.val <= 10^9',
        'All Node.val are unique.',
        'p != q'
    ],
    '[
        {"input": "root = [6,2,8,0,4,7,9], p = 2, q = 8", "output": "6", "explanation": "LCA is 6."},
        {"input": "root = [6,2,8,0,4,7,9], p = 2, q = 4", "output": "2", "explanation": "LCA is 2."}
    ]'::jsonb,
    'Trees'
) ON CONFLICT (slug) DO NOTHING;

-- 102. Binary Tree Level Order Traversal
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    102,
    'binary-tree-level-order-traversal',
    'Binary Tree Level Order Traversal',
    'Medium',
    'Return the level order traversal of a binary tree''s nodes'' values (left to right, level by level).',
    ARRAY[
        'The number of nodes in the tree is in the range [0, 2000]',
        '-1000 <= Node.val <= 1000'
    ],
    '[
        {"input": "root = [3,9,20,null,null,15,7]", "output": "[[3],[9,20],[15,7]]", "explanation": "Level order traversal."},
        {"input": "root = [1]", "output": "[[1]]", "explanation": "Single node."}
    ]'::jsonb,
    'Trees'
) ON CONFLICT (slug) DO NOTHING;

-- 98. Validate Binary Search Tree
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    98,
    'validate-binary-search-tree',
    'Validate Binary Search Tree',
    'Medium',
    'Determine if a binary tree is a valid binary search tree (BST).',
    ARRAY[
        'The number of nodes in the tree is in the range [1, 10^4]',
        '-2^31 <= Node.val <= 2^31 - 1'
    ],
    '[
        {"input": "root = [2,1,3]", "output": "true", "explanation": "Valid BST."},
        {"input": "root = [5,1,4,null,null,3,6]", "output": "false", "explanation": "Invalid BST."}
    ]'::jsonb,
    'Trees'
) ON CONFLICT (slug) DO NOTHING;

-- 230. Kth Smallest Element in a BST
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    230,
    'kth-smallest-element-in-bst',
    'Kth Smallest Element In a BST',
    'Medium',
    'Return the kth smallest value (1-indexed) of all nodes in a BST.',
    ARRAY[
        'The number of nodes in the tree is in the range [1, 10^4]',
        '0 <= Node.val <= 10^4',
        '1 <= k <= number of nodes'
    ],
    '[
        {"input": "root = [3,1,4,null,2], k = 1", "output": "1", "explanation": "Smallest element is 1."},
        {"input": "root = [5,3,6,2,4,null,null,1], k = 3", "output": "3", "explanation": "3rd smallest element is 3."}
    ]'::jsonb,
    'Trees'
) ON CONFLICT (slug) DO NOTHING;

-- 105. Construct Binary Tree from Preorder and Inorder Traversal
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    105,
    'construct-binary-tree-from-preorder-inorder',
    'Construct Binary Tree From Preorder And Inorder Traversal',
    'Medium',
    'Construct a binary tree from preorder and inorder traversal arrays and return its root.',
    ARRAY[
        '1 <= preorder.length <= 3000',
        'inorder.length == preorder.length',
        '-3000 <= Node.val <= 3000',
        'preorder and inorder consist of unique values.'
    ],
    '[
        {"input": "preorder = [3,9,20,15,7], inorder = [9,3,15,20,7]", "output": "[3,9,20,null,null,15,7]", "explanation": "Reconstruct the tree."},
        {"input": "preorder = [-1], inorder = [-1]", "output": "[-1]", "explanation": "Single node."}
    ]'::jsonb,
    'Trees'
) ON CONFLICT (slug) DO NOTHING;

-- 124. Binary Tree Maximum Path Sum
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    124,
    'binary-tree-maximum-path-sum',
    'Binary Tree Maximum Path Sum',
    'Hard',
    'Find the maximum path sum. A path is any sequence of nodes from some starting node to any node in the tree along parent-child connections.',
    ARRAY[
        'The number of nodes in the tree is in the range [1, 3 * 10^4]',
        '-1000 <= Node.val <= 1000'
    ],
    '[
        {"input": "root = [1,2,3]", "output": "6", "explanation": "Path 2 -> 1 -> 3 gives 6."},
        {"input": "root = [-10,9,20,null,null,15,7]", "output": "42", "explanation": "Path 15 -> 20 -> 7 gives 42."}
    ]'::jsonb,
    'Trees'
) ON CONFLICT (slug) DO NOTHING;

-- 297. Serialize and Deserialize Binary Tree
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    297,
    'serialize-and-deserialize-binary-tree',
    'Serialize And Deserialize Binary Tree',
    'Hard',
    'Design an algorithm to serialize and deserialize a binary tree. There is no restriction on how your serialization/deserialization algorithm should work.',
    ARRAY[
        'The number of nodes in the tree is in the range [0, 10^4]',
        '-1000 <= Node.val <= 1000'
    ],
    '[
        {"input": "root = [1,2,3,null,null,4,5]", "output": "[1,2,3,null,null,4,5]", "explanation": "Serialize and deserialize to same structure."},
        {"input": "root = []", "output": "[]", "explanation": "Empty tree."}
    ]'::jsonb,
    'Trees'
) ON CONFLICT (slug) DO NOTHING;

-- Heap / Priority Queue
-- 295. Find Median From Data Stream
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category) 
VALUES (
    295,
    'find-median-from-data-stream',
    'Find Median From Data Stream',
    'Hard',
    'The MedianFinder class is designed to find the median from a stream of integers. Implement the following methods:\n- addNum(int num): Add an integer from the data stream to the data structure.\n- findMedian(): Return the median of all elements so far.',
    ARRAY[
        '-10^5 <= num <= 10^5',
        'There will be at least one element before calling findMedian.',
        'At most 5 * 10^4 calls to addNum and findMedian combined.'
    ],
    '[
        {"input": "addNum(1), addNum(2), findMedian()", "output": "1.5", "explanation": "Median of [1,2] is (1+2)/2 = 1.5."},
        {"input": "addNum(3), findMedian()", "output": "2", "explanation": "Median of [1,2,3] is 2."}
    ]'::jsonb,
    'Heap-&-Priority-Queue'
) ON CONFLICT (slug) DO NOTHING;

-- Backtracking
-- 39. Combination Sum
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    39,
    'combination-sum',
    'Combination Sum',
    'Medium',
    'Given an array of distinct integers candidates and a target integer target, return a list of all unique combinations of candidates where the chosen numbers sum to target. You may return the combinations in any order. The same number may be chosen from candidates an unlimited number of times.',
    ARRAY[
        '1 <= candidates.length <= 30',
        '2 <= candidates[i] <= 40',
        'All elements of candidates are distinct.',
        '1 <= target <= 40'
    ],
    '[
        {"input": "candidates = [2,3,6,7], target = 7", "output": "[[7],[2,2,3]]", "explanation": "7 can be made by [7] or [2,2,3]."},
        {"input": "candidates = [2,3,5], target = 8", "output": "[[2,2,2,2],[2,3,3],[3,5]]", "explanation": "All unique combinations that sum to 8."}
    ]'::jsonb,
    'Backtracking'
) ON CONFLICT (slug) DO NOTHING;

-- 79. Word Search
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    79,
    'word-search',
    'Word Search',
    'Medium',
    'Given an m x n grid of characters board and a string word, return true if word exists in the grid. The word can be constructed from letters of sequentially adjacent cells, where "adjacent" cells are horizontally or vertically neighboring. The same letter cell may not be used more than once.',
    ARRAY[
        'm == board.length',
        'n == board[i].length',
        '1 <= m, n <= 6',
        '1 <= word.length <= 15',
        'board and word consist of only lowercase and uppercase English letters.'
    ],
    '[
        {"input": "board = [[\"A\",\"B\",\"C\",\"E\"],[\"S\",\"F\",\"C\",\"S\"],[\"A\",\"D\",\"E\",\"E\"]], word = \"ABCCED\"", "output": "true", "explanation": "Word exists in the grid."},
        {"input": "board = [[\"A\",\"B\",\"C\",\"E\"],[\"S\",\"F\",\"C\",\"S\"],[\"A\",\"D\",\"E\",\"E\"]], word = \"SEE\"", "output": "true", "explanation": "Word exists in the grid."},
        {"input": "board = [[\"A\",\"B\",\"C\",\"E\"],[\"S\",\"F\",\"C\",\"S\"],[\"A\",\"D\",\"E\",\"E\"]], word = \"ABCB\"", "output": "false", "explanation": "Word cannot be formed."}
    ]'::jsonb,
    'Backtracking'
) ON CONFLICT (slug) DO NOTHING;

-- Tries
-- 208. Implement Trie (Prefix Tree)
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    208,
    'implement-trie-prefix-tree',
    'Implement Trie (Prefix Tree)',
    'Medium',
    'Implement a trie with insert, search, and startsWith methods. A trie is a tree-like data structure used to efficiently store and search a dynamic set of strings.',
    ARRAY[
        '1 <= word.length, prefix.length <= 2000',
        'word and prefix consist only of lowercase English letters',
        'At most 3 * 10^4 calls will be made to insert, search, and startsWith'
    ],
    '[
        {"input": "Trie trie = new Trie(); trie.insert(\"apple\"); trie.search(\"apple\")", "output": "true", "explanation": "Inserted \"apple\" and searched it."},
        {"input": "trie.search(\"app\")", "output": "false", "explanation": "\"app\" is a prefix, not a word."},
        {"input": "trie.startsWith(\"app\")", "output": "true", "explanation": "Prefix exists in trie."}
    ]'::jsonb,
    'Tries'
) ON CONFLICT (slug) DO NOTHING;

-- 211. Design Add and Search Words Data Structure
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    211,
    'design-add-and-search-words-data-structure',
    'Design Add And Search Words Data Structure',
    'Medium',
    'Design a data structure that supports adding new words and finding if a string matches any previously added string. The search can include the dot character ''.'' to represent any letter.',
    ARRAY[
        '1 <= word.length <= 25',
        'word consists of lowercase English letters',
        'At most 3 * 10^4 calls will be made to addWord and search'
    ],
    '[
        {"input": "WordDictionary wordDictionary = new WordDictionary(); wordDictionary.addWord(\"bad\"); wordDictionary.search(\"bad\")", "output": "true", "explanation": "Word \"bad\" added and searched."},
        {"input": "wordDictionary.search(\".ad\")", "output": "true", "explanation": "Dot represents any letter."},
        {"input": "wordDictionary.search(\"b..\")", "output": "true", "explanation": "Matches \"bad\"."}
    ]'::jsonb,
    'Tries'
) ON CONFLICT (slug) DO NOTHING;

-- Graph
-- 1. Number of Islands
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    200,
    'number-of-islands',
    'Number of Islands',
    'Medium',
    'Given an m x n 2D binary grid grid which represents a map of ''1''s (land) and ''0''s (water), return the number of islands. An island is surrounded by water and is formed by connecting adjacent lands horizontally or vertically.',
    ARRAY[
        'm == grid.length',
        'n == grid[i].length',
        '1 <= m, n <= 300',
        'grid[i][j] is ''0'' or ''1''.'
    ],
    '[
        {"input": "grid = [[1,1,1,1,0],[1,1,0,1,0],[1,1,0,0,0],[0,0,0,0,0]]", "output": "1", "explanation": "All land cells are connected."},
        {"input": "grid = [[1,1,0,0,0],[1,1,0,0,0],[0,0,1,0,0],[0,0,0,1,1]]", "output": "3", "explanation": "Three separate islands."}
    ]'::jsonb,
    'Graphs'
) ON CONFLICT (slug) DO NOTHING;

-- 2. Clone Graph
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    133,
    'clone-graph',
    'Clone Graph',
    'Medium',
    'Given a reference of a node in a connected undirected graph, return a deep copy (clone) of the graph. Each node in the graph contains a val (int) and a list (List[Node]) of its neighbors.',
    ARRAY[
        '1 <= node.val <= 100',
        'node.val is unique for each node.',
        'There are no repeated edges and no self-loops in the graph.',
        'The graph is connected and has at most 100 nodes.'
    ],
    '[
        {"input": "graph = [[2,4],[1,3],[2,4],[1,3]]", "output": "[[2,4],[1,3],[2,4],[1,3]]", "explanation": "Cloned graph is identical to the original."}
    ]'::jsonb,
    'Graphs'
) ON CONFLICT (slug) DO NOTHING;

-- 3. Pacific Atlantic Water Flow
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    417,
    'pacific-atlantic-water-flow',
    'Pacific Atlantic Water Flow',
    'Medium',
    'Given an m x n matrix of non-negative integers representing the heights of water cells in a continent, find the list of grid coordinates where water can flow to both the Pacific and Atlantic oceans.',
    ARRAY[
        'm == heights.length',
        'n == heights[i].length',
        '1 <= m, n <= 50',
        '0 <= heights[i][j] <= 100'
    ],
    '[
        {"input": "heights = [[1,2,3],[8,9,4],[7,6,5]]", "output": "[[0,2],[1,1],[2,0]]", "explanation": "Cells that can flow to both oceans."}
    ]'::jsonb,
    'Graphs'
) ON CONFLICT (slug) DO NOTHING;

-- 4. Course Schedule
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    207,
    'course-schedule',
    'Course Schedule',
    'Medium',
    'There are a total of numCourses courses you have to take, labeled from 0 to numCourses - 1. Some courses may have prerequisites, which are represented as a list of pairs where each pair [a, b] indicates that to take course a you have to first take course b.',
    ARRAY[
        '1 <= numCourses <= 2000',
        '0 <= prerequisites.length <= 5000',
        'prerequisites[i].length == 2',
        '0 <= prerequisites[i][0], prerequisites[i][1] < numCourses',
        'All the pairs [a, b] are distinct.'
    ],
    '[
        {"input": "numCourses = 2, prerequisites = [[1,0]]", "output": "true", "explanation": "Course 1 can be taken after course 0."},
        {"input": "numCourses = 2, prerequisites = [[1,0],[0,1]]", "output": "false", "explanation": "Cycle detected, cannot finish courses."}
    ]'::jsonb,
    'Graphs'
) ON CONFLICT (slug) DO NOTHING;

-- 5. Graph Valid Tree
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    261,
    'graph-valid-tree',
    'Graph Valid Tree',
    'Medium',
    'Given n nodes labeled from 0 to n - 1 and a list of edges, determine if these edges form a valid tree.',
    ARRAY[
        '1 <= n <= 1000',
        '0 <= edges.length <= 1000',
        'edges[i].length == 2',
        '0 <= edges[i][0], edges[i][1] < n',
        'There are no repeated edges.'
    ],
    '[
        {"input": "n = 5, edges = [[0,1],[0,2],[0,3],[1,4]]", "output": "true", "explanation": "Graph is connected and acyclic."},
        {"input": "n = 5, edges = [[0,1],[1,2],[2,3],[1,3],[1,4]]", "output": "false", "explanation": "Graph contains a cycle."}
    ]'::jsonb,
    'Graphs'
) ON CONFLICT (slug) DO NOTHING;

-- 6. Number of Connected Components In An Undirected Graph
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    323,
    'number-of-connected-components-in-an-undirected-graph',
    'Number of Connected Components In An Undirected Graph',
    'Medium',
    'Given n nodes labeled from 0 to n - 1 and a list of edges, find the number of connected components in an undirected graph.',
    ARRAY[
        '1 <= n <= 2000',
        '0 <= edges.length <= 5000',
        'edges[i].length == 2',
        '0 <= edges[i][0], edges[i][1] < n',
        'There are no repeated edges.'
    ],
    '[
        {"input": "n = 5, edges = [[0,1],[0,2],[3,4]]", "output": "2", "explanation": "Two separate components."},
        {"input": "n = 5, edges = [[0,1],[1,2],[2,3],[3,4]]", "output": "1", "explanation": "One connected component."}
    ]'::jsonb,
    'Graphs'
) ON CONFLICT (slug) DO NOTHING;

-- Advanced Graphs
-- 1. Alien Dictionary
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    269,
    'alien-dictionary',
    'Alien Dictionary',
    'Hard',
    'Given a list of words from an alien language sorted lexicographically by the rules of this language, return the order of letters in the alien language. If there is no solution, return an empty string. If there are multiple valid solutions, return any of them.',
    ARRAY[
        '1 <= words.length <= 100',
        '1 <= words[i].length <= 100',
        'words[i] consists of only lowercase English letters',
        'All the strings in words are non-empty'
    ],
    '[
        {
            "input": "words = [\"wrt\", \"wrf\", \"er\", \"ett\", \"rftt\"]",
            "output": "wertf",
            "explanation": "The correct order is: w -> e -> r -> t -> f."
        },
        {
            "input": "words = [\"z\", \"x\"]",
            "output": "zx",
            "explanation": "The correct order is: z -> x."
        },
        {
            "input": "words = [\"z\", \"x\", \"z\"]",
            "output": "",
            "explanation": "The order is invalid due to a cycle: z -> x -> z."
        }
    ]'::jsonb,
    'Advanced Graphs'
) ON CONFLICT (slug) DO NOTHING;

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

-- Greedy
-- 1. Maximum Subarray
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    53,
    'maximum-subarray',
    'Maximum Subarray',
    'Easy',
    'Given an integer array nums, find the contiguous subarray (containing at least one number) which has the largest sum and return its sum.',
    ARRAY[
        '1 <= nums.length <= 10^5',
        '-10^4 <= nums[i] <= 10^4'
    ],
    '[
        {"input": "nums = [-2,1,-3,4,-1,2,1,-5,4]", "output": "6", "explanation": "The contiguous subarray [4,-1,2,1] has the largest sum 6."},
        {"input": "nums = [1]", "output": "1", "explanation": "The largest sum is the only element 1."},
        {"input": "nums = [5,4,-1,7,8]", "output": "23", "explanation": "The contiguous subarray [5,4,-1,7,8] has the largest sum 23."}
    ]'::jsonb,
    'Greedy'
) ON CONFLICT (slug) DO NOTHING;

-- Interval
-- 1. Insert Interval
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    57,
    'insert-interval',
    'Insert Interval',
    'Hard',
    'Given a set of non-overlapping intervals, insert a new interval into the intervals (merge if necessary).',
    ARRAY[
        '0 <= intervals.length <= 10^4',
        'intervals[i].length == 2',
        '0 <= intervals[i][0] < intervals[i][1] <= 10^5'
    ],
    '[
        {"input": "intervals = [[1,3],[6,9]], newInterval = [2,5]", "output": "[[1,5],[6,9]]", "explanation": "The new interval [2,5] merges with [1,3] to form [1,5]."},
        {"input": "intervals = [[1,2],[3,5],[6,7],[8,10],[12,16]], newInterval = [4,8]", "output": "[[1,2],[3,10],[12,16]]", "explanation": "The new interval [4,8] merges with [3,5], [6,7], and [8,10] to form [3,10]."}
    ]'::jsonb,
    'Intervals'
) ON CONFLICT (slug) DO NOTHING;

-- 2. Merge Intervals
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    56,
    'merge-intervals',
    'Merge Intervals',
    'Medium',
    'Given a collection of intervals, merge all overlapping intervals.',
    ARRAY[
        '1 <= intervals.length <= 10^4',
        'intervals[i].length == 2',
        '0 <= intervals[i][0] < intervals[i][1] <= 10^5'
    ],
    '[
        {"input": "intervals = [[1,3],[2,6],[8,10],[15,18]]", "output": "[[1,6],[8,10],[15,18]]", "explanation": "The intervals [1,3] and [2,6] overlap, so they are merged into [1,6]."},
        {"input": "intervals = [[1,4],[4,5]]", "output": "[[1,5]]", "explanation": "The intervals [1,4] and [4,5] overlap, so they are merged into [1,5]."}
    ]'::jsonb,
    'Intervals'
) ON CONFLICT (slug) DO NOTHING;

-- 3. Non-overlapping Intervals
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    435,
    'non-overlapping-intervals',
    'Non-overlapping Intervals',
    'Medium',
    'Given a collection of intervals, find the minimum number of intervals you need to remove to make the rest of the intervals non-overlapping.',
    ARRAY[
        '1 <= intervals.length <= 10^2',
        'intervals[i].length == 2',
        '0 <= intervals[i][0] < intervals[i][1] <= 10^5'
    ],
    '[
        {"input": "intervals = [[1,2],[2,3],[3,4],[1,3]]", "output": "1", "explanation": "Remove the interval [1,3] to make the rest non-overlapping."},
        {"input": "intervals = [[1,2],[1,2],[1,2]]", "output": "2", "explanation": "Remove two intervals to make the rest non-overlapping."}
    ]'::jsonb,
    'Intervals'
) ON CONFLICT (slug) DO NOTHING;

-- 4. Meeting Rooms
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    252,
    'meeting-rooms',
    'Meeting Rooms',
    'Easy',
    'Given an array of meeting time intervals consisting of start and end times, determine if a person could attend all meetings.',
    ARRAY[
        '1 <= intervals.length <= 10^4',
        'intervals[i].length == 2',
        '0 <= intervals[i][0] < intervals[i][1] <= 10^5'
    ],
    '[
        {"input": "intervals = [[0,30],[5,10],[15,20]]", "output": "false", "explanation": "The person cannot attend all meetings due to overlap."},
        {"input": "intervals = [[7,10],[2,4]]", "output": "true", "explanation": "The person can attend all meetings as there is no overlap."}
    ]'::jsonb,
    'Intervals'
) ON CONFLICT (slug) DO NOTHING;

-- 5. Meeting Rooms II
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    253,
    'meeting-rooms-ii',
    'Meeting Rooms II',
    'Medium',
    'Given an array of meeting time intervals consisting of start and end times, find the minimum number of conference rooms required.',
    ARRAY[
        '1 <= intervals.length <= 10^4',
        'intervals[i].length == 2',
        '0 <= intervals[i][0] < intervals[i][1] <= 10^5'
    ],
    '[
        {"input": "intervals = [[0,30],[5,10],[15,20]]", "output": "2", "explanation": "Two meeting rooms are required."},
        {"input": "intervals = [[7,10],[2,4]]", "output": "1", "explanation": "Only one meeting room is required."}
    ]'::jsonb,
    'Intervals'
) ON CONFLICT (slug) DO NOTHING;

-- Math & Geometry
-- 1. Rotate Image
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    48,
    'rotate-image',
    'Rotate Image',
    'Medium',
    'You are given an n x n 2D matrix representing an image. Rotate the image by 90 degrees (clockwise) in-place.',
    ARRAY[
        'n == matrix.length == matrix[i].length',
        '1 <= n <= 20',
        '-1000 <= matrix[i][j] <= 1000'
    ],
    '[
        {"input": "matrix = [[1,2,3],[4,5,6],[7,8,9]]", "output": "[[7,4,1],[8,5,2],[9,6,3]]", "explanation": "Rotate the matrix 90 degrees clockwise."},
        {"input": "matrix = [[5,1,9,11],[2,4,8,10],[13,3,6,7],[15,14,12,16]]", "output": "[[15,13,2,5],[14,3,4,1],[12,6,8,9],[16,7,10,11]]", "explanation": "Rotate the 4x4 matrix 90 degrees clockwise."}
    ]'::jsonb,
    'Math-&-Geometry'
) ON CONFLICT (slug) DO NOTHING;

-- 2. Spiral Matrix
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    54,
    'spiral-matrix',
    'Spiral Matrix',
    'Medium',
    'Given an m x n matrix, return all elements of the matrix in spiral order.',
    ARRAY[
        'm == matrix.length',
        'n == matrix[i].length',
        '1 <= m, n <= 10^2',
        '-100 <= matrix[i][j] <= 100'
    ],
    '[
        {"input": "matrix = [[1,2,3],[4,5,6],[7,8,9]]", "output": "[1,2,3,6,9,8,7,4,5]", "explanation": "Traverse the matrix in spiral order."},
        {"input": "matrix = [[1,2,3,4],[5,6,7,8],[9,10,11,12]]", "output": "[1,2,3,4,8,12,11,10,9,5,6,7]", "explanation": "Traverse the 3x4 matrix in spiral order."}
    ]'::jsonb,
    'Math-&-Geometry'
) ON CONFLICT (slug) DO NOTHING;

-- 3. Set Matrix Zeroes
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    73,
    'set-matrix-zeroes',
    'Set Matrix Zeroes',
    'Medium',
    'Given an m x n integer matrix, if an element is 0, set its entire row and column to 0. Do it in-place.',
    ARRAY[
        'm == matrix.length',
        'n == matrix[i].length',
        '1 <= m, n <= 200',
        '-2^31 <= matrix[i][j] <= 2^31 - 1'
    ],
    '[
        {"input": "matrix = [[1,1,1],[1,0,1],[1,1,1]]", "output": "[[1,0,1],[0,0,0],[1,0,1]]", "explanation": "Set row and column to 0 if an element is 0."},
        {"input": "matrix = [[0,1,2,0],[3,4,5,2],[1,3,1,5]]", "output": "[[0,0,0,0],[0,4,5,0],[0,3,1,0]]", "explanation": "Set row and column to 0 for all zeros in the matrix."}
    ]'::jsonb,
    'Math-&-Geometry'
) ON CONFLICT (slug) DO NOTHING;

-- Bit Manipulation
-- 1. Number of 1 Bits
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    191,
    'number-of-1-bits',
    'Number of 1 Bits',
    'Easy',
    'Write a function that takes an unsigned integer and returns the number of ’1’ bits it has (also known as the Hamming weight).',
    ARRAY[
        'The input must be a binary string of length 32'
    ],
    '[
        {"input": "n = 11", "output": "3", "explanation": "Binary representation 1011 has three 1s."},
        {"input": "n = 128", "output": "1", "explanation": "Binary representation 10000000 has one 1."}
    ]'::jsonb,
    'Bit Manipulation'
) ON CONFLICT (slug) DO NOTHING;

-- 2. Counting Bits
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    338,
    'counting-bits',
    'Counting Bits',
    'Easy',
    'Given an integer n, return an array ans of length n + 1 such that for each i (0 <= i <= n), ans[i] is the number of 1 bits in the binary representation of i.',
    ARRAY[
        '0 <= n <= 10^5'
    ],
    '[
        {"input": "n = 2", "output": "[0,1,1]", "explanation": "0 has 0 ones, 1 has 1 one, 2 has 1 one."},
        {"input": "n = 5", "output": "[0,1,1,2,1,2]", "explanation": "Binary representations: 0,1,10,11,100,101."}
    ]'::jsonb,
    'Bit Manipulation'
) ON CONFLICT (slug) DO NOTHING;

-- 3. Reverse Bits
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    190,
    'reverse-bits',
    'Reverse Bits',
    'Easy',
    'Reverse the bits of a given 32 bits unsigned integer.',
    ARRAY[
        'The input must be a binary string of length 32'
    ],
    '[
        {"input": "n = 43261596", "output": "964176192", "explanation": "Binary 00000010100101000001111010011100 reversed is 00111001011110000010100101000000."},
        {"input": "n = 4294967293", "output": "3221225471", "explanation": "Binary 11111111111111111111111111111101 reversed is 10111111111111111111111111111111."}
    ]'::jsonb,
    'Bit Manipulation'
) ON CONFLICT (slug) DO NOTHING;

-- 4. Missing Number
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    268,
    'missing-number',
    'Missing Number',
    'Easy',
    'Given an array nums containing n distinct numbers in the range [0, n], return the only number in the range that is missing from the array.',
    ARRAY[
        'n == nums.length',
        '1 <= n <= 10^4',
        '0 <= nums[i] <= n',
        'All the numbers of nums are unique.'
    ],
    '[
        {"input": "nums = [3,0,1]", "output": "2", "explanation": "The missing number is 2."},
        {"input": "nums = [0,1]", "output": "2", "explanation": "The missing number is 2."}
    ]'::jsonb,
    'Bit Manipulation'
) ON CONFLICT (slug) DO NOTHING;

-- 5. Sum of Two Integers
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    371,
    'sum-of-two-integers',
    'Sum of Two Integers',
    'Medium',
    'Calculate the sum of two integers a and b, but you are not allowed to use the operator + and -. Return the sum.',
    ARRAY[
        '-1000 <= a, b <= 1000'
    ],
    '[
        {"input": "a = 1, b = 2", "output": "3", "explanation": "1 + 2 = 3."},
        {"input": "a = -2, b = 3", "output": "1", "explanation": "-2 + 3 = 1."}
    ]'::jsonb,
    'Bit Manipulation'
) ON CONFLICT (slug) DO NOTHING;
