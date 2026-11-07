import 'package:flutter/material.dart';

import '../core/responsive.dart';
import '../core/theme.dart';
import '../data/course_data.dart';
import '../models/course.dart';
import '../widgets/course_card.dart';
import '../widgets/layout.dart';
import '../widgets/page_scaffold.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  static const _sorts = [
    'Most Popular',
    'Top Rated',
    'Price: Low to High',
    'Price: High to Low',
  ];

  final TextEditingController _search = TextEditingController();
  String _category = 'All';
  String _sort = _sorts.first;
  bool _argsRead = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_argsRead) {
      final arg = ModalRoute.of(context)?.settings.arguments;
      if (arg is String && categories.contains(arg)) _category = arg;
      _argsRead = true;
    }
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  List<Course> get _filtered {
    final q = _search.text.trim().toLowerCase();
    final list = courses.where((c) {
      final matchesCategory = _category == 'All' || c.category == _category;
      final matchesSearch = q.isEmpty ||
          c.title.toLowerCase().contains(q) ||
          c.instructor.toLowerCase().contains(q) ||
          c.category.toLowerCase().contains(q);
      return matchesCategory && matchesSearch;
    }).toList();

    switch (_sort) {
      case 'Top Rated':
        list.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'Price: Low to High':
        list.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Price: High to Low':
        list.sort((a, b) => b.price.compareTo(a.price));
        break;
      default:
        list.sort((a, b) => b.students.compareTo(a.students));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final mobile = Responsive.isMobile(context);
    final results = _filtered;

    final searchField = TextField(
      controller: _search,
      onChanged: (_) => setState(() {}),
      decoration: InputDecoration(
        hintText: 'Search courses, instructors or topics',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: _search.text.isEmpty
            ? null
            : IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () => setState(_search.clear),
              ),
      ),
    );

    final sortBox = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: DropdownButton<String>(
        value: _sort,
        underline: const SizedBox.shrink(),
        isExpanded: mobile,
        items: [
          for (final s in _sorts) DropdownMenuItem(value: s, child: Text(s)),
        ],
        onChanged: (v) => setState(() => _sort = v ?? _sort),
      ),
    );

    return PageScaffold(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(gradient: AppColors.hero),
            padding: EdgeInsets.symmetric(vertical: mobile ? 36 : 56),
            child: const ContentWrapper(
              child: Column(
                children: [
                  Text('All Courses',
                      style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                          color: Colors.white)),
                  SizedBox(height: 8),
                  Text('Find the perfect course for your goals',
                      style: TextStyle(fontSize: 16, color: Colors.white70)),
                ],
              ),
            ),
          ),
          PageSection(
            vertical: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (mobile) ...[
                  searchField,
                  const SizedBox(height: 12),
                  sortBox,
                ] else
                  Row(
                    children: [
                      Expanded(child: searchField),
                      const SizedBox(width: 16),
                      sortBox,
                    ],
                  ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    for (final cat in categories)
                      ChoiceChip(
                        label: Text(cat),
                        selected: _category == cat,
                        selectedColor: AppColors.primary,
                        labelStyle: TextStyle(
                          color: _category == cat
                              ? Colors.white
                              : AppColors.dark,
                          fontWeight: FontWeight.w600,
                        ),
                        onSelected: (_) => setState(() => _category = cat),
                      ),
                  ],
                ),
                const SizedBox(height: 24),
                Text('${results.length} course(s) found',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, color: AppColors.text)),
                const SizedBox(height: 20),
                if (results.isEmpty)
                  _emptyState()
                else
                  ResponsiveGrid(
                    children: [
                      for (final c in results) CourseCard(course: c)
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _emptyState() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const SizedBox(height: 40),
          const Icon(Icons.search_off, size: 64, color: AppColors.text),
          const SizedBox(height: 12),
          const Text('No courses match your search',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          const Text('Try a different keyword or category.'),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () => setState(() {
              _search.clear();
              _category = 'All';
            }),
            child: const Text('Reset filters'),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
