-- You can run this SQL script to insert problems into the database
-- Use the command psql -d insert_db_name -f problems.sql

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