-- You can run this SQL script to insert problems into the database
-- Use the command psql -d insert_db_name -f problems.sql

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