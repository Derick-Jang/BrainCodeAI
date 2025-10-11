-- You can run this SQL script to insert problems into the database
-- Use the command psql -d insert_db_name -f problems.sql

-- Heap / Priority Queue
-- 295. Find Median From Data Stream
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category) 
VALUES (
    295,
    'find-median-from-data-stream',
    'Find Median From Data Stream',
    'Hard',
    'The MedianFinder class is designed to find the median from a stream of integers. Implement the following methods:\n- addNum(int num): Add an integer from the data stream to the data structure.\n- findMedian(): Return the median of all elements so far.',
    ARRAY[
        '-10^5 <= num <= 10^5',
        'There will be at least one element before calling findMedian.',
        'At most 5 * 10^4 calls to addNum and findMedian combined.'
    ],
    '[
        {"input": "addNum(1), addNum(2), findMedian()", "output": "1.5", "explanation": "Median of [1,2] is (1+2)/2 = 1.5."},
        {"input": "addNum(3), findMedian()", "output": "2", "explanation": "Median of [1,2,3] is 2."}
    ]'::jsonb,
    'Heap-&-Priority-Queue'
) ON CONFLICT (slug) DO NOTHING;