-- You can run this SQL script to insert problems into the database
-- Use the command psql -d insert_db_name -f problems.sql

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