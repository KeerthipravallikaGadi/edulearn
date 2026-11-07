import 'package:flutter/material.dart';

import '../core/responsive.dart';
import '../core/theme.dart';
import '../data/course_data.dart';
import '../models/course.dart';
import '../services/app_state.dart';
import '../widgets/layout.dart';
import '../widgets/page_scaffold.dart';

class CourseDetailScreen extends StatelessWidget {
  final String courseId;
  const CourseDetailScreen({super.key, required this.courseId});

  Future<void> _enroll(BuildContext context, Course course) async {
    final state = AppState.instance;
    final messenger = ScaffoldMessenger.of(context);
    if (!state.isLoggedIn) {
      messenger.showSnackBar(
          const SnackBar(content: Text('Please log in to enroll in a course.')));
      Navigator.pushNamed(context, '/auth', arguments: false);
      return;
    }
    await state.enroll(course.id);
    messenger.showSnackBar(
        SnackBar(content: Text('Enrolled in "${course.title}". Happy learning!')));
  }

  @override
  Widget build(BuildContext context) {
    final course = findCourse(courseId);
    if (course == null) {
      return PageScaffold(
        child: Padding(
          padding: const EdgeInsets.all(64),
          child: Center(
            child: Column(
              children: [
                const Icon(Icons.error_outline, size: 64),
                const SizedBox(height: 12),
                const Text('Course not found',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, '/courses'),
                  child: const Text('Browse courses'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return PageScaffold(
      child: ListenableBuilder(
        listenable: AppState.instance,
        builder: (context, _) {
          final state = AppState.instance;
          final enrolled = state.isEnrolled(course.id);
          final mobile = Responsive.isMobile(context);

          final main = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('What you will learn',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
              const SizedBox(height: 12),
              for (final o in course.outcomes)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.check_circle,
                          color: Color(0xFF16A34A), size: 20),
                      const SizedBox(width: 10),
                      Expanded(child: Text(o, style: const TextStyle(fontSize: 16))),
                    ],
                  ),
                ),
              const SizedBox(height: 28),
              const Text('About this course',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
              const SizedBox(height: 12),
              Text(course.description,
                  style: const TextStyle(
                      fontSize: 16, height: 1.6, color: AppColors.text)),
              const SizedBox(height: 28),
              Row(
                children: [
                  const Expanded(
                    child: Text('Curriculum',
                        style:
                            TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                  ),
                  Text('${course.lessons.length} lessons',
                      style: const TextStyle(color: AppColors.text)),
                ],
              ),
              const SizedBox(height: 12),
              if (!enrolled)
                const Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: Text('Enroll to unlock lessons and track your progress.',
                      style: TextStyle(color: AppColors.text)),
                ),
              for (var i = 0; i < course.lessons.length; i++)
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: ListTile(
                    leading: enrolled
                        ? Checkbox(
                            value: state.isLessonDone(course.id, i),
                            activeColor: AppColors.primary,
                            onChanged: (_) => state.toggleLesson(course.id, i),
                          )
                        : const Icon(Icons.lock_outline),
                    title: Text('${i + 1}. ${course.lessons[i].title}',
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                    trailing: Text(course.lessons[i].duration,
                        style: const TextStyle(color: AppColors.text)),
                  ),
                ),
            ],
          );

          final side = Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 8)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(course.priceLabel,
                    style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary)),
                const SizedBox(height: 16),
                if (enrolled) ...[
                  Text(
                      '${state.completedCount(course)} of ${course.lessons.length} lessons completed',
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: state.progress(course),
                      minHeight: 10,
                      backgroundColor: AppColors.border,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: null,
                      child: Text('You are enrolled'),
                    ),
                  ),
                ] else
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _enroll(context, course),
                      child: const Text('Enroll Now'),
                    ),
                  ),
                const SizedBox(height: 20),
                _info(Icons.schedule, '${course.hours} hours of content'),
                _info(Icons.bar_chart, course.level),
                _info(Icons.all_inclusive, 'Lifetime access'),
                _info(Icons.workspace_premium, 'Certificate of completion'),
              ],
            ),
          );

          return Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.dark, course.color],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: mobile ? 32 : 56),
                child: ContentWrapper(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton.icon(
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.white70,
                            padding: EdgeInsets.zero),
                        onPressed: () => Navigator.pushReplacementNamed(
                            context, '/courses'),
                        icon: const Icon(Icons.arrow_back, size: 18),
                        label: const Text('Back to courses'),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(course.category,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600)),
                      ),
                      const SizedBox(height: 16),
                      Text(course.title,
                          style: TextStyle(
                              fontSize: mobile ? 28 : 40,
                              fontWeight: FontWeight.w800,
                              height: 1.2,
                              color: Colors.white)),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 20,
                        runSpacing: 8,
                        children: [
                          _meta(Icons.person, course.instructor),
                          _meta(Icons.star, '${course.rating} rating'),
                          _meta(Icons.groups, '${course.students} students'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              PageSection(
                vertical: 40,
                child: mobile
                    ? Column(children: [side, const SizedBox(height: 32), main])
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: main),
                          const SizedBox(width: 40),
                          SizedBox(width: 340, child: side),
                        ],
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _meta(IconData icon, String text) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: Colors.white70),
          const SizedBox(width: 6),
          Text(text, style: const TextStyle(color: Colors.white)),
        ],
      );

  Widget _info(IconData icon, String text) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            Icon(icon, size: 20, color: AppColors.primary),
            const SizedBox(width: 10),
            Expanded(child: Text(text)),
          ],
        ),
      );
}
