-- You can run this SQL script to insert problems into the database
-- Use the command psql -d insert_db_name -f problems.sql

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