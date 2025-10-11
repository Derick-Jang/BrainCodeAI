-- You can run this SQL script to insert problems into the database
-- Use the command psql -d insert_db_name -f problems.sql

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