-- You can run this SQL script to insert problems into the database
-- Use the command psql -d insert_db_name -f problems.sql

-- Interval
-- 1. Insert Interval
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    57,
    'insert-interval',
    'Insert Interval',
    'Hard',
    'Given a set of non-overlapping intervals, insert a new interval into the intervals (merge if necessary).',
    ARRAY[
        '0 <= intervals.length <= 10^4',
        'intervals[i].length == 2',
        '0 <= intervals[i][0] < intervals[i][1] <= 10^5'
    ],
    '[
        {"input": "intervals = [[1,3],[6,9]], newInterval = [2,5]", "output": "[[1,5],[6,9]]", "explanation": "The new interval [2,5] merges with [1,3] to form [1,5]."},
        {"input": "intervals = [[1,2],[3,5],[6,7],[8,10],[12,16]], newInterval = [4,8]", "output": "[[1,2],[3,10],[12,16]]", "explanation": "The new interval [4,8] merges with [3,5], [6,7], and [8,10] to form [3,10]."}
    ]'::jsonb,
    'Intervals'
) ON CONFLICT (slug) DO NOTHING;

-- 2. Merge Intervals
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    56,
    'merge-intervals',
    'Merge Intervals',
    'Medium',
    'Given a collection of intervals, merge all overlapping intervals.',
    ARRAY[
        '1 <= intervals.length <= 10^4',
        'intervals[i].length == 2',
        '0 <= intervals[i][0] < intervals[i][1] <= 10^5'
    ],
    '[
        {"input": "intervals = [[1,3],[2,6],[8,10],[15,18]]", "output": "[[1,6],[8,10],[15,18]]", "explanation": "The intervals [1,3] and [2,6] overlap, so they are merged into [1,6]."},
        {"input": "intervals = [[1,4],[4,5]]", "output": "[[1,5]]", "explanation": "The intervals [1,4] and [4,5] overlap, so they are merged into [1,5]."}
    ]'::jsonb,
    'Intervals'
) ON CONFLICT (slug) DO NOTHING;

-- 3. Non-overlapping Intervals
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    435,
    'non-overlapping-intervals',
    'Non-overlapping Intervals',
    'Medium',
    'Given a collection of intervals, find the minimum number of intervals you need to remove to make the rest of the intervals non-overlapping.',
    ARRAY[
        '1 <= intervals.length <= 10^2',
        'intervals[i].length == 2',
        '0 <= intervals[i][0] < intervals[i][1] <= 10^5'
    ],
    '[
        {"input": "intervals = [[1,2],[2,3],[3,4],[1,3]]", "output": "1", "explanation": "Remove the interval [1,3] to make the rest non-overlapping."},
        {"input": "intervals = [[1,2],[1,2],[1,2]]", "output": "2", "explanation": "Remove two intervals to make the rest non-overlapping."}
    ]'::jsonb,
    'Intervals'
) ON CONFLICT (slug) DO NOTHING;

-- 4. Meeting Rooms
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    252,
    'meeting-rooms',
    'Meeting Rooms',
    'Easy',
    'Given an array of meeting time intervals consisting of start and end times, determine if a person could attend all meetings.',
    ARRAY[
        '1 <= intervals.length <= 10^4',
        'intervals[i].length == 2',
        '0 <= intervals[i][0] < intervals[i][1] <= 10^5'
    ],
    '[
        {"input": "intervals = [[0,30],[5,10],[15,20]]", "output": "false", "explanation": "The person cannot attend all meetings due to overlap."},
        {"input": "intervals = [[7,10],[2,4]]", "output": "true", "explanation": "The person can attend all meetings as there is no overlap."}
    ]'::jsonb,
    'Intervals'
) ON CONFLICT (slug) DO NOTHING;

-- 5. Meeting Rooms II
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    253,
    'meeting-rooms-ii',
    'Meeting Rooms II',
    'Medium',
    'Given an array of meeting time intervals consisting of start and end times, find the minimum number of conference rooms required.',
    ARRAY[
        '1 <= intervals.length <= 10^4',
        'intervals[i].length == 2',
        '0 <= intervals[i][0] < intervals[i][1] <= 10^5'
    ],
    '[
        {"input": "intervals = [[0,30],[5,10],[15,20]]", "output": "2", "explanation": "Two meeting rooms are required."},
        {"input": "intervals = [[7,10],[2,4]]", "output": "1", "explanation": "Only one meeting room is required."}
    ]'::jsonb,
    'Intervals'
) ON CONFLICT (slug) DO NOTHING;