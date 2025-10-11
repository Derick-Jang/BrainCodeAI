-- You can run this SQL script to insert problems into the database
-- Use the command psql -d insert_db_name -f problems.sql

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
