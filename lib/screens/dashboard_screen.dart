import 'package:flutter/material.dart';

import '../core/responsive.dart';
import '../core/theme.dart';
import '../data/course_data.dart';
import '../models/course.dart';
import '../services/app_state.dart';
import '../widgets/course_card.dart';
import '../widgets/layout.dart';
import '../widgets/page_scaffold.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      child: ListenableBuilder(
        listenable: AppState.instance,
        builder: (context, _) {
          final state = AppState.instance;

          // Route guard: dashboard needs a logged-in user.
          if (!state.isLoggedIn) {
            return Padding(
              padding: const EdgeInsets.all(64),
              child: Center(
                child: Column(
                  children: [
                    const Icon(Icons.lock_outline, size: 64),
                    const SizedBox(height: 12),
                    const Text('Please log in to view your dashboard',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => Navigator.pushReplacementNamed(
                          context, '/auth',
                          arguments: false),
                      child: const Text('Go to Login'),
                    ),
                  ],
                ),
              ),
            );
          }

          final enrolled = state.enrolledCourses;
          final recommended =
              courses.where((c) => !state.isEnrolled(c.id)).take(3).toList();
          final mobile = Responsive.isMobile(context);

          return Column(
            children: [
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(gradient: AppColors.hero),
                padding: EdgeInsets.symmetric(vertical: mobile ? 32 : 48),
                child: ContentWrapper(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Welcome back, ${state.firstName}!',
                          style: TextStyle(
                              fontSize: mobile ? 26 : 36,
                              fontWeight: FontWeight.w800,
                              color: Colors.white)),
                      const SizedBox(height: 8),
                      Text(state.userEmail,
                          style: const TextStyle(color: Colors.white70)),
                    ],
                  ),
                ),
              ),
              PageSection(
                vertical: 40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ResponsiveGrid(
                      spacing: 16,
                      desktop: 3,
                      tablet: 3,
                      mobile: 1,
                      children: [
                        _StatCard(Icons.menu_book, 'Enrolled Courses',
                            '${enrolled.length}', AppColors.primary),
                        _StatCard(Icons.check_circle, 'Lessons Completed',
                            '${state.totalCompleted}', const Color(0xFF16A34A)),
                        _StatCard(
                            Icons.trending_up,
                            'Average Progress',
                            '${(state.averageProgress * 100).round()}%',
                            AppColors.accent),
                      ],
                    ),
                    const SizedBox(height: 40),
                    const Text('My Courses',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 16),
                    if (enrolled.isEmpty)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Column(
                          children: [
                            const Icon(Icons.school_outlined, size: 56),
                            const SizedBox(height: 12),
                            const Text("You haven't enrolled in any course yet",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700)),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () =>
                                  Navigator.pushNamed(context, '/courses'),
                              child: const Text('Browse Courses'),
                            ),
                          ],
                        ),
                      )
                    else
                      for (final c in enrolled) _EnrolledTile(course: c),
                    if (recommended.isNotEmpty) ...[
                      const SizedBox(height: 40),
                      const Text('Recommended for you',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w800)),
                      const SizedBox(height: 16),
                      ResponsiveGrid(children: [
                        for (final c in recommended) CourseCard(course: c)
                      ]),
                    ],
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  const _StatCard(this.icon, this.label, this.value, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: color.withOpacity(0.12),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value,
                  style: const TextStyle(
                      fontSize: 26, fontWeight: FontWeight.w800)),
              Text(label, style: const TextStyle(color: AppColors.text)),
            ],
          ),
        ],
      ),
    );
  }
}

class _EnrolledTile extends StatelessWidget {
  final Course course;
  const _EnrolledTile({required this.course});

  @override
  Widget build(BuildContext context) {
    final state = AppState.instance;
    final progress = state.progress(course);
    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/course/${course.id}'),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: course.color,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(course.icon, color: Colors.white),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(course.title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 8,
                      backgroundColor: AppColors.border,
                      color: progress == 1
                          ? const Color(0xFF16A34A)
                          : AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                      '${state.completedCount(course)}/${course.lessons.length} lessons • ${(progress * 100).round()}%',
                      style: const TextStyle(
                          fontSize: 13, color: AppColors.text)),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}