-- You can run this SQL script to insert problems into the database
-- Use the command psql -d insert_db_name -f problems.sql

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
