-- You can run this SQL script to insert problems into the database
-- Use the command psql -d insert_db_name -f problems.sql

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