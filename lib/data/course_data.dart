import 'package:flutter/material.dart';

import '../models/course.dart';

const List<Course> courses = [
  Course(
    id: 'flutter-dart',
    title: 'Flutter & Dart: Build Apps and Websites',
    category: 'App Development',
    instructor: 'Aarav Mehta',
    description:
        'Go from zero to building beautiful, responsive apps and websites with a single Flutter codebase. Learn Dart, widgets, layouts, navigation, forms and deployment.',
    level: 'Beginner',
    rating: 4.8,
    students: 12450,
    price: 499,
    hours: 32,
    icon: Icons.phone_android,
    color: Color(0xFF0284C7),
    lessons: [
      Lesson('Introduction to Dart', '18 min'),
      Lesson('Widgets, Layouts and Styling', '42 min'),
      Lesson('Navigation and Routing', '35 min'),
      Lesson('Forms and Validation', '30 min'),
      Lesson('Building and Deploying Flutter Web', '28 min'),
    ],
    outcomes: [
      'Build responsive apps for web and mobile',
      'Understand the widget tree and state management',
      'Deploy a live website to the internet',
    ],
  ),
  Course(
    id: 'web-dev',
    title: 'Complete Web Development: HTML, CSS & JavaScript',
    category: 'Web Development',
    instructor: 'Priya Sharma',
    description:
        'Learn the building blocks of every website. Build real projects with semantic HTML, modern CSS layouts and interactive JavaScript.',
    level: 'Beginner',
    rating: 4.7,
    students: 18200,
    price: 0,
    hours: 40,
    icon: Icons.language,
    color: Color(0xFFEA580C),
    lessons: [
      Lesson('HTML Structure and Semantics', '25 min'),
      Lesson('CSS Flexbox and Grid', '45 min'),
      Lesson('JavaScript Fundamentals', '50 min'),
      Lesson('DOM Manipulation', '38 min'),
      Lesson('Capstone: Portfolio Website', '60 min'),
    ],
    outcomes: [
      'Create responsive web pages from scratch',
      'Write clean, interactive JavaScript',
      'Publish your own portfolio website',
    ],
  ),
  Course(
    id: 'python-data',
    title: 'Python for Data Science',
    category: 'Data Science',
    instructor: 'Dr. Rohan Iyer',
    description:
        'Master Python, NumPy, Pandas and Matplotlib to clean, analyse and visualise real-world datasets.',
    level: 'Intermediate',
    rating: 4.9,
    students: 15300,
    price: 599,
    hours: 28,
    icon: Icons.insights,
    color: Color(0xFF16A34A),
    lessons: [
      Lesson('Python Refresher', '30 min'),
      Lesson('NumPy Arrays', '35 min'),
      Lesson('Data Analysis with Pandas', '55 min'),
      Lesson('Visualisation with Matplotlib', '40 min'),
    ],
    outcomes: [
      'Analyse datasets with Pandas',
      'Create charts that tell a story',
      'Prepare data for machine learning',
    ],
  ),
  Course(
    id: 'ui-ux',
    title: 'UI/UX Design Fundamentals',
    category: 'Design',
    instructor: 'Sneha Kapoor',
    description:
        'Learn user research, wireframing, colour, typography and prototyping to design products people love to use.',
    level: 'Beginner',
    rating: 4.6,
    students: 9800,
    price: 399,
    hours: 18,
    icon: Icons.brush,
    color: Color(0xFFDB2777),
    lessons: [
      Lesson('Design Thinking Basics', '22 min'),
      Lesson('Wireframes and User Flows', '34 min'),
      Lesson('Colour and Typography', '28 min'),
      Lesson('Prototyping and Testing', '40 min'),
    ],
    outcomes: [
      'Design clean and usable interfaces',
      'Create wireframes and prototypes',
      'Apply colour and type with confidence',
    ],
  ),
  Course(
    id: 'dsa-java',
    title: 'Data Structures & Algorithms in Java',
    category: 'Programming',
    instructor: 'Karthik Reddy',
    description:
        'Crack coding interviews and write efficient programs. Covers arrays, linked lists, trees, graphs, sorting and dynamic programming.',
    level: 'Intermediate',
    rating: 4.8,
    students: 21000,
    price: 699,
    hours: 45,
    icon: Icons.account_tree,
    color: Color(0xFF7C3AED),
    lessons: [
      Lesson('Time and Space Complexity', '24 min'),
      Lesson('Arrays and Linked Lists', '48 min'),
      Lesson('Stacks, Queues and Trees', '55 min'),
      Lesson('Graphs and Traversals', '52 min'),
      Lesson('Dynamic Programming', '60 min'),
    ],
    outcomes: [
      'Choose the right data structure for a problem',
      'Analyse algorithm complexity',
      'Solve interview-style problems',
    ],
  ),
  Course(
    id: 'aws-cloud',
    title: 'Cloud Computing with AWS Essentials',
    category: 'Cloud & DevOps',
    instructor: 'Neha Verma',
    description:
        'Understand cloud concepts and get hands-on with core AWS services such as EC2, S3, IAM and Lambda.',
    level: 'Beginner',
    rating: 4.5,
    students: 7600,
    price: 549,
    hours: 22,
    icon: Icons.cloud,
    color: Color(0xFF0891B2),
    lessons: [
      Lesson('Cloud Concepts', '20 min'),
      Lesson('EC2 and Networking', '38 min'),
      Lesson('S3 Storage and IAM', '33 min'),
      Lesson('Serverless with Lambda', '36 min'),
    ],
    outcomes: [
      'Launch and manage cloud servers',
      'Store and secure data in the cloud',
      'Deploy a serverless function',
    ],
  ),
  Course(
    id: 'ml-az',
    title: 'Machine Learning A-Z',
    category: 'Data Science',
    instructor: 'Dr. Ananya Rao',
    description:
        'Learn regression, classification, clustering and neural network basics with hands-on Python projects.',
    level: 'Advanced',
    rating: 4.9,
    students: 11200,
    price: 799,
    hours: 38,
    icon: Icons.psychology,
    color: Color(0xFFDC2626),
    lessons: [
      Lesson('Introduction to Machine Learning', '26 min'),
      Lesson('Regression Models', '44 min'),
      Lesson('Classification Models', '47 min'),
      Lesson('Clustering and Neural Networks', '58 min'),
    ],
    outcomes: [
      'Train and evaluate ML models',
      'Pick the right algorithm for a task',
      'Build an end-to-end ML project',
    ],
  ),
  Course(
    id: 'sql-db',
    title: 'SQL & Database Management',
    category: 'Programming',
    instructor: 'Vikram Singh',
    description:
        'Design databases and write powerful queries. Covers joins, indexing, normalisation and transactions.',
    level: 'Beginner',
    rating: 4.6,
    students: 13400,
    price: 0,
    hours: 16,
    icon: Icons.storage,
    color: Color(0xFF475569),
    lessons: [
      Lesson('Relational Database Basics', '20 min'),
      Lesson('SELECT, WHERE and JOIN', '36 min'),
      Lesson('Normalisation and Design', '30 min'),
      Lesson('Indexes and Transactions', '32 min'),
    ],
    outcomes: [
      'Write complex SQL queries',
      'Design normalised database schemas',
      'Understand transactions and indexing',
    ],
  ),
];

/// All distinct categories, with 'All' first.
List<String> get categories =>
    ['All', ...courses.map((c) => c.category).toSet()];

Course? findCourse(String id) {
  for (final c in courses) {
    if (c.id == id) return c;
  }
  return null;
}
