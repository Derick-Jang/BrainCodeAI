-- You can run this SQL script to insert problems into the database
-- Use the command psql -d insert_db_name -f problems.sql

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