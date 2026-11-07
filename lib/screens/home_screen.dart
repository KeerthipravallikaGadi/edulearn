import 'package:flutter/material.dart';

import '../core/responsive.dart';
import '../core/theme.dart';
import '../data/course_data.dart';
import '../services/app_state.dart';
import '../widgets/course_card.dart';
import '../widgets/layout.dart';
import '../widgets/page_scaffold.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      child: Column(
        children: [
          _hero(context),
          _categories(context),
          _featured(context),
          _whyUs(context),
          _testimonials(context),
          _cta(context),
        ],
      ),
    );
  }

  // ---------- Hero ----------
  Widget _hero(BuildContext context) {
    final mobile = Responsive.isMobile(context);
    final align = mobile ? CrossAxisAlignment.center : CrossAxisAlignment.start;

    final text = ListenableBuilder(
      listenable: AppState.instance,
      builder: (context, _) {
        final loggedIn = AppState.instance.isLoggedIn;
        return Column(
          crossAxisAlignment: align,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Text('Trusted by 10,000+ learners',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600)),
            ),
            const SizedBox(height: 20),
            Text(
              'Learn Without Limits',
              textAlign: mobile ? TextAlign.center : TextAlign.start,
              style: TextStyle(
                fontSize: mobile ? 38 : 58,
                fontWeight: FontWeight.w800,
                height: 1.1,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Master web development, data science, design and more with '
              'project-based courses taught by industry experts. Start free today.',
              textAlign: mobile ? TextAlign.center : TextAlign.start,
              style: TextStyle(
                  fontSize: 18,
                  height: 1.6,
                  color: Colors.white.withOpacity(0.9)),
            ),
            const SizedBox(height: 32),
            Wrap(
              spacing: 14,
              runSpacing: 14,
              alignment: mobile ? WrapAlignment.center : WrapAlignment.start,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.primary),
                  onPressed: () => Navigator.pushNamed(context, '/courses'),
                  icon: const Icon(Icons.explore),
                  label: const Text('Explore Courses'),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white)),
                  onPressed: () => Navigator.pushNamed(
                      context, loggedIn ? '/dashboard' : '/auth',
                      arguments: loggedIn ? null : true),
                  child: Text(loggedIn ? 'My Learning' : 'Join for Free'),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Wrap(
              spacing: 36,
              runSpacing: 16,
              alignment: mobile ? WrapAlignment.center : WrapAlignment.start,
              children: const [
                _Stat('10K+', 'Learners'),
                _Stat('8+', 'Courses'),
                _Stat('4.8', 'Avg. rating'),
              ],
            ),
          ],
        );
      },
    );

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(gradient: AppColors.hero),
      padding: EdgeInsets.symmetric(vertical: mobile ? 48 : 88),
      child: ContentWrapper(
        child: mobile
            ? text
            : Row(
                children: [
                  Expanded(flex: 6, child: text),
                  const SizedBox(width: 48),
                  const Expanded(flex: 5, child: _HeroArt()),
                ],
              ),
      ),
    );
  }

  // ---------- Categories ----------
  Widget _categories(BuildContext context) {
    final cats = categories.where((c) => c != 'All').toList();
    return PageSection(
      child: Column(
        children: [
          const SectionTitle(
              title: 'Browse by Category',
              subtitle: 'Pick a topic and start learning something new today.'),
          ResponsiveGrid(
            spacing: 16,
            desktop: 4,
            tablet: 3,
            mobile: 2,
            children: [
              for (final cat in cats)
                _CategoryTile(
                  label: cat,
                  icon: courses.firstWhere((c) => c.category == cat).icon,
                  color: courses.firstWhere((c) => c.category == cat).color,
                  onTap: () =>
                      Navigator.pushNamed(context, '/courses', arguments: cat),
                ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------- Featured ----------
  Widget _featured(BuildContext context) {
    return PageSection(
      color: Colors.white,
      child: Column(
        children: [
          const SectionTitle(
              title: 'Featured Courses',
              subtitle: 'Hand-picked, highly rated courses to kick-start your career.'),
          ResponsiveGrid(
            children: [for (final c in courses.take(3)) CourseCard(course: c)],
          ),
          const SizedBox(height: 40),
          OutlinedButton(
            onPressed: () => Navigator.pushNamed(context, '/courses'),
            child: const Text('View All Courses'),
          ),
        ],
      ),
    );
  }

  // ---------- Why us ----------
  Widget _whyUs(BuildContext context) {
    const items = [
      [Icons.person_search, 'Expert Instructors', 'Learn from professionals with real industry experience.'],
      [Icons.access_time, 'Learn at Your Pace', 'Lifetime access so you can study whenever it suits you.'],
      [Icons.workspace_premium, 'Certificates', 'Earn a certificate after completing every course.'],
      [Icons.trending_up, 'Track Progress', 'Mark lessons complete and watch your progress grow.'],
    ];
    return PageSection(
      child: Column(
        children: [
          const SectionTitle(
              title: 'Why Choose EduLearn?',
              subtitle: 'Everything you need to learn effectively in one platform.'),
          ResponsiveGrid(
            desktop: 4,
            tablet: 2,
            children: [
              for (final i in items)
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(i[0] as IconData,
                            color: AppColors.primary, size: 28),
                      ),
                      const SizedBox(height: 16),
                      Text(i[1] as String,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 8),
                      Text(i[2] as String,
                          style: const TextStyle(
                              height: 1.5, color: AppColors.text)),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------- Testimonials ----------
  Widget _testimonials(BuildContext context) {
    const items = [
      ['The Flutter course helped me build and deploy my first website in a week. Clear and practical!', 'Rahul K.', 'B.Tech Student'],
      ['Loved the structured lessons and progress tracking. It kept me consistent.', 'Divya S.', 'Junior Developer'],
      ['The Python for Data Science course was exactly what I needed to switch careers.', 'Imran A.', 'Data Analyst'],
    ];
    return PageSection(
      color: Colors.white,
      child: Column(
        children: [
          const SectionTitle(
              title: 'What Our Learners Say',
              subtitle: 'Join thousands of students who have transformed their careers.'),
          ResponsiveGrid(
            children: [
              for (final t in items)
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.star, color: AppColors.accent, size: 20),
                          Icon(Icons.star, color: AppColors.accent, size: 20),
                          Icon(Icons.star, color: AppColors.accent, size: 20),
                          Icon(Icons.star, color: AppColors.accent, size: 20),
                          Icon(Icons.star, color: AppColors.accent, size: 20),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Text(t[0],
                          style: const TextStyle(
                              fontSize: 16, height: 1.6, color: AppColors.dark)),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColors.primary,
                            child: Text(t[1][0],
                                style: const TextStyle(color: Colors.white)),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(t[1],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700)),
                              Text(t[2],
                                  style: const TextStyle(
                                      fontSize: 13, color: AppColors.text)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------- Call to action ----------
  Widget _cta(BuildContext context) {
    return PageSection(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(Responsive.isMobile(context) ? 28 : 56),
        decoration: BoxDecoration(
          gradient: AppColors.hero,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            const Text('Ready to start learning?',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: Colors.white)),
            const SizedBox(height: 12),
            Text('Create a free account and enroll in your first course in minutes.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16, color: Colors.white.withOpacity(0.9))),
            const SizedBox(height: 28),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.primary),
              onPressed: () =>
                  Navigator.pushNamed(context, '/auth', arguments: true),
              child: const Text('Get Started Free'),
            ),
          ],
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String value;
  final String label;
  const _Stat(this.value, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                fontSize: 28, fontWeight: FontWeight.w800, color: Colors.white)),
        Text(label,
            style: TextStyle(color: Colors.white.withOpacity(0.8))),
      ],
    );
  }
}

class _CategoryTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  const _CategoryTile(
      {required this.label,
      required this.icon,
      required this.color,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: color.withOpacity(0.12),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 12),
            Text(label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.w700, color: AppColors.dark)),
          ],
        ),
      ),
    );
  }
}

/// Decorative illustration for the hero section (no image assets needed).
class _HeroArt extends StatelessWidget {
  const _HeroArt();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 360,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.school, size: 130, color: Colors.white),
          ),
          const Positioned(
              top: 20,
              left: 10,
              child: _FloatCard(Icons.play_circle_fill, 'Video Lessons')),
          const Positioned(
              bottom: 40,
              left: 0,
              child: _FloatCard(Icons.workspace_premium, 'Certificates')),
          const Positioned(
              top: 90,
              right: 0,
              child: _FloatCard(Icons.groups, 'Community')),
        ],
      ),
    );
  }
}

class _FloatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  const _FloatCard(this.icon, this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 16, offset: Offset(0, 6))
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(width: 8),
          Text(label,
              style: const TextStyle(
                  fontWeight: FontWeight.w700, color: AppColors.dark)),
        ],
      ),
    );
  }
}
