import 'package:flutter/material.dart';

import '../core/responsive.dart';
import '../core/theme.dart';
import '../widgets/layout.dart';
import '../widgets/page_scaffold.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mobile = Responsive.isMobile(context);
    const team = [
      ['Aarav Mehta', 'Founder & Lead Instructor'],
      ['Priya Sharma', 'Head of Curriculum'],
      ['Rohan Iyer', 'Data Science Mentor'],
      ['Sneha Kapoor', 'Design Mentor'],
    ];
    return PageScaffold(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(gradient: AppColors.hero),
            padding: EdgeInsets.symmetric(vertical: mobile ? 36 : 64),
            child: const ContentWrapper(
              child: Column(
                children: [
                  Text('About EduLearn',
                      style: TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.w800,
                          color: Colors.white)),
                  SizedBox(height: 12),
                  Text('Making quality education accessible to everyone',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 17, color: Colors.white70)),
                ],
              ),
            ),
          ),
          PageSection(
            child: Column(
              children: [
                const SectionTitle(
                    title: 'Our Mission',
                    subtitle:
                        'EduLearn was created to help students and professionals learn practical, job-ready skills through short, project-based lessons. We believe anyone can learn to build the future with the right guidance.'),
                ResponsiveGrid(
                  desktop: 3,
                  tablet: 3,
                  mobile: 1,
                  children: const [
                    _Value(Icons.lightbulb_outline, 'Practical Learning',
                        'Every course ends with a real project.'),
                    _Value(Icons.public, 'Accessible to All',
                        'Many courses are free, and all are self-paced.'),
                    _Value(Icons.favorite_border, 'Learner First',
                        'We design everything around your success.'),
                  ],
                ),
              ],
            ),
          ),
          PageSection(
            color: Colors.white,
            child: Column(
              children: [
                const SectionTitle(
                    title: 'Meet the Team',
                    subtitle: 'The people behind your learning experience.'),
                ResponsiveGrid(
                  desktop: 4,
                  tablet: 2,
                  mobile: 1,
                  children: [
                    for (final t in team)
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 36,
                              backgroundColor: AppColors.primary,
                              child: Text(t[0][0],
                                  style: const TextStyle(
                                      fontSize: 28, color: Colors.white)),
                            ),
                            const SizedBox(height: 14),
                            Text(t[0],
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w700)),
                            const SizedBox(height: 4),
                            Text(t[1],
                                textAlign: TextAlign.center,
                                style:
                                    const TextStyle(color: AppColors.text)),
                          ],
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Value extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;
  const _Value(this.icon, this.title, this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 36, color: AppColors.primary),
          const SizedBox(height: 14),
          Text(title,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Text(text, style: const TextStyle(color: AppColors.text, height: 1.5)),
        ],
      ),
    );
  }
}
