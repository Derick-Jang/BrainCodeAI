-- You can run this SQL script to insert problems into the database
-- Use the command psql -d insert_db_name -f problems.sql

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