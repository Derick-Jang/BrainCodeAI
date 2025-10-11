-- You can run this SQL script to insert problems into the database
-- Use the command psql -d insert_db_name -f problems.sql

-- Linked List
-- 206. Reverse Linked List
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category) 
VALUES (
    206,
    'reverse-linked-list',
    'Reverse Linked List',
    'Easy',
    'Given the head of a singly linked list, reverse the list, and return the reversed list.',
    ARRAY[
        'The number of nodes in the list is in the range [0, 5000]',
        '-5000 <= Node.val <= 5000'
    ],
    '[
        {"input": "head = [1,2,3,4,5]", "output": "[5,4,3,2,1]", "explanation": "Reverse the list."},
        {"input": "head = [1,2]", "output": "[2,1]", "explanation": "Reverse the list."},
        {"input": "head = []", "output": "[]", "explanation": "Empty list remains empty."}
    ]'::jsonb,
    'Linked-List'
) ON CONFLICT (slug) DO NOTHING;

-- 21. Merge Two Sorted Lists
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category) 
VALUES (
    21,
    'merge-two-sorted-lists',
    'Merge Two Sorted Lists',
    'Easy',
    'Merge two sorted linked lists and return it as a sorted list. The list should be made by splicing together the nodes of the first two lists.',
    ARRAY[
        'The number of nodes in both lists is in the range [0, 50]',
        '-100 <= Node.val <= 100'
    ],
    '[
        {"input": "l1 = [1,2,4], l2 = [1,3,4]", "output": "[1,1,2,3,4,4]", "explanation": "Merge sorted lists."},
        {"input": "l1 = [], l2 = []", "output": "[]", "explanation": "Both lists empty."},
        {"input": "l1 = [], l2 = [0]", "output": "[0]", "explanation": "One empty list."}
    ]'::jsonb,
    'Linked-List'
) ON CONFLICT (slug) DO NOTHING;

-- 141. Linked List Cycle
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category) 
VALUES (
    141,
    'linked-list-cycle',
    'Linked List Cycle',
    'Easy',
    'Given head, determine if the linked list has a cycle in it. Return true if there is a cycle, otherwise false.',
    ARRAY[
        'The number of nodes in the list is in the range [0, 10^4]',
        '-10^5 <= Node.val <= 10^5'
    ],
    '[
        {"input": "head = [3,2,0,-4], pos = 1", "output": "true", "explanation": "Cycle at position 1."},
        {"input": "head = [1,2], pos = 0", "output": "true", "explanation": "Cycle at position 0."},
        {"input": "head = [1], pos = -1", "output": "false", "explanation": "No cycle."}
    ]'::jsonb,
    'Linked-List'
) ON CONFLICT (slug) DO NOTHING;

-- 143. Reorder List
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category) 
VALUES (
    143,
    'reorder-list',
    'Reorder List',
    'Medium',
    'Given the head of a singly linked list, reorder it to: L0 → Ln → L1 → Ln-1 → L2 → Ln-2 → …',
    ARRAY[
        'The number of nodes in the list is in the range [1, 5 * 10^4]',
        '1 <= Node.val <= 1000'
    ],
    '[
        {"input": "head = [1,2,3,4]", "output": "[1,4,2,3]", "explanation": "Reorder the list."},
        {"input": "head = [1,2,3,4,5]", "output": "[1,5,2,4,3]", "explanation": "Reorder the list."}
    ]'::jsonb,
    'Linked-List'
) ON CONFLICT (slug) DO NOTHING;

-- 19. Remove Nth Node From End of List
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category) 
VALUES (
    19,
    'remove-nth-node-from-end-of-list',
    'Remove Nth Node From End of List',
    'Medium',
    'Given the head of a linked list, remove the nth node from the end and return its head.',
    ARRAY[
        'The number of nodes in the list is in the range [1, 30]',
        '0 <= Node.val <= 100',
        '1 <= n <= size of list'
    ],
    '[
        {"input": "head = [1,2,3,4,5], n = 2", "output": "[1,2,3,5]", "explanation": "Remove second from end."},
        {"input": "head = [1], n = 1", "output": "[]", "explanation": "Remove only node."},
        {"input": "head = [1,2], n = 1", "output": "[1]", "explanation": "Remove last node."}
    ]'::jsonb,
    'Linked-List'
) ON CONFLICT (slug) DO NOTHING;

-- 23. Merge K Sorted Lists
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category) 
VALUES (
    23,
    'merge-k-sorted-lists',
    'Merge K Sorted Lists',
    'Hard',
    'You are given an array of k linked-lists lists, each linked list is sorted in ascending order. Merge all the linked lists into one sorted linked list and return it.',
    ARRAY[
        'k == lists.length',
        '0 <= k <= 10^4',
        '0 <= lists[i].length <= 500',
        '-10^4 <= Node.val <= 10^4',
        'lists[i] is sorted in ascending order.'
    ],
    '[
        {"input": "lists = [[1,4,5],[1,3,4],[2,6]]", "output": "[1,1,2,3,4,4,5,6]", "explanation": "Merge all lists."},
        {"input": "lists = []", "output": "[]", "explanation": "Empty array of lists."},
        {"input": "lists = [[]]", "output": "[]", "explanation": "Array with empty list."}
    ]'::jsonb,
    'Linked-List'
) ON CONFLICT (slug) DO NOTHING;