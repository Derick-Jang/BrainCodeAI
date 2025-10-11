-- You can run this SQL script to insert problems into the database
-- Use the command psql -d insert_db_name -f problems.sql

-- Graph
-- 1. Number of Islands
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    200,
    'number-of-islands',
    'Number of Islands',
    'Medium',
    'Given an m x n 2D binary grid grid which represents a map of ''1''s (land) and ''0''s (water), return the number of islands. An island is surrounded by water and is formed by connecting adjacent lands horizontally or vertically.',
    ARRAY[
        'm == grid.length',
        'n == grid[i].length',
        '1 <= m, n <= 300',
        'grid[i][j] is ''0'' or ''1''.'
    ],
    '[
        {"input": "grid = [[1,1,1,1,0],[1,1,0,1,0],[1,1,0,0,0],[0,0,0,0,0]]", "output": "1", "explanation": "All land cells are connected."},
        {"input": "grid = [[1,1,0,0,0],[1,1,0,0,0],[0,0,1,0,0],[0,0,0,1,1]]", "output": "3", "explanation": "Three separate islands."}
    ]'::jsonb,
    'Graphs'
) ON CONFLICT (slug) DO NOTHING;

-- 2. Clone Graph
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    133,
    'clone-graph',
    'Clone Graph',
    'Medium',
    'Given a reference of a node in a connected undirected graph, return a deep copy (clone) of the graph. Each node in the graph contains a val (int) and a list (List[Node]) of its neighbors.',
    ARRAY[
        '1 <= node.val <= 100',
        'node.val is unique for each node.',
        'There are no repeated edges and no self-loops in the graph.',
        'The graph is connected and has at most 100 nodes.'
    ],
    '[
        {"input": "graph = [[2,4],[1,3],[2,4],[1,3]]", "output": "[[2,4],[1,3],[2,4],[1,3]]", "explanation": "Cloned graph is identical to the original."}
    ]'::jsonb,
    'Graphs'
) ON CONFLICT (slug) DO NOTHING;

-- 3. Pacific Atlantic Water Flow
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    417,
    'pacific-atlantic-water-flow',
    'Pacific Atlantic Water Flow',
    'Medium',
    'Given an m x n matrix of non-negative integers representing the heights of water cells in a continent, find the list of grid coordinates where water can flow to both the Pacific and Atlantic oceans.',
    ARRAY[
        'm == heights.length',
        'n == heights[i].length',
        '1 <= m, n <= 50',
        '0 <= heights[i][j] <= 100'
    ],
    '[
        {"input": "heights = [[1,2,3],[8,9,4],[7,6,5]]", "output": "[[0,2],[1,1],[2,0]]", "explanation": "Cells that can flow to both oceans."}
    ]'::jsonb,
    'Graphs'
) ON CONFLICT (slug) DO NOTHING;

-- 4. Course Schedule
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    207,
    'course-schedule',
    'Course Schedule',
    'Medium',
    'There are a total of numCourses courses you have to take, labeled from 0 to numCourses - 1. Some courses may have prerequisites, which are represented as a list of pairs where each pair [a, b] indicates that to take course a you have to first take course b.',
    ARRAY[
        '1 <= numCourses <= 2000',
        '0 <= prerequisites.length <= 5000',
        'prerequisites[i].length == 2',
        '0 <= prerequisites[i][0], prerequisites[i][1] < numCourses',
        'All the pairs [a, b] are distinct.'
    ],
    '[
        {"input": "numCourses = 2, prerequisites = [[1,0]]", "output": "true", "explanation": "Course 1 can be taken after course 0."},
        {"input": "numCourses = 2, prerequisites = [[1,0],[0,1]]", "output": "false", "explanation": "Cycle detected, cannot finish courses."}
    ]'::jsonb,
    'Graphs'
) ON CONFLICT (slug) DO NOTHING;

-- 5. Graph Valid Tree
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    261,
    'graph-valid-tree',
    'Graph Valid Tree',
    'Medium',
    'Given n nodes labeled from 0 to n - 1 and a list of edges, determine if these edges form a valid tree.',
    ARRAY[
        '1 <= n <= 1000',
        '0 <= edges.length <= 1000',
        'edges[i].length == 2',
        '0 <= edges[i][0], edges[i][1] < n',
        'There are no repeated edges.'
    ],
    '[
        {"input": "n = 5, edges = [[0,1],[0,2],[0,3],[1,4]]", "output": "true", "explanation": "Graph is connected and acyclic."},
        {"input": "n = 5, edges = [[0,1],[1,2],[2,3],[1,3],[1,4]]", "output": "false", "explanation": "Graph contains a cycle."}
    ]'::jsonb,
    'Graphs'
) ON CONFLICT (slug) DO NOTHING;

-- 6. Number of Connected Components In An Undirected Graph
INSERT INTO problems (leetcode_problem_id, slug, title, difficulty, description, constraints, examples, category)
VALUES (
    323,
    'number-of-connected-components-in-an-undirected-graph',
    'Number of Connected Components In An Undirected Graph',
    'Medium',
    'Given n nodes labeled from 0 to n - 1 and a list of edges, find the number of connected components in an undirected graph.',
    ARRAY[
        '1 <= n <= 2000',
        '0 <= edges.length <= 5000',
        'edges[i].length == 2',
        '0 <= edges[i][0], edges[i][1] < n',
        'There are no repeated edges.'
    ],
    '[
        {"input": "n = 5, edges = [[0,1],[0,2],[3,4]]", "output": "2", "explanation": "Two separate components."},
        {"input": "n = 5, edges = [[0,1],[1,2],[2,3],[3,4]]", "output": "1", "explanation": "One connected component."}
    ]'::jsonb,
    'Graphs'
) ON CONFLICT (slug) DO NOTHING;