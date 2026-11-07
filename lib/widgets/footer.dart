import 'package:flutter/material.dart';

import '../core/theme.dart';
import 'layout.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.dark,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: ContentWrapper(
        child: Column(
          children: [
            Wrap(
              spacing: 56,
              runSpacing: 32,
              children: [
                SizedBox(
                  width: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(children: [
                        Icon(Icons.school, color: AppColors.secondary),
                        SizedBox(width: 8),
                        Text('EduLearn',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w800)),
                      ]),
                      const SizedBox(height: 12),
                      Text(
                        'Learn in-demand skills from expert instructors, anytime and anywhere.',
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.7), height: 1.5),
                      ),
                    ],
                  ),
                ),
                _column(context, 'Platform', {
                  'Home': '/',
                  'All Courses': '/courses',
                  'My Learning': '/dashboard',
                }),
                _column(context, 'Company', {
                  'About Us': '/about',
                  'Contact': '/contact',
                  'Sign Up': '/auth',
                }),
                SizedBox(
                  width: 220,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _heading('Contact'),
                      _plain('support@edulearn.example'),
                      _plain('+91 98765 43210'),
                      _plain('Hyderabad, Telangana'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Divider(color: Colors.white.withOpacity(0.15)),
            const SizedBox(height: 16),
            Text(
              '© ${DateTime.now().year} EduLearn. Built with Flutter & Dart.',
              style: TextStyle(color: Colors.white.withOpacity(0.6)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _heading(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Text(text,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 16)),
      );

  Widget _plain(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child:
            Text(text, style: TextStyle(color: Colors.white.withOpacity(0.7))),
      );

  Widget _column(BuildContext context, String title, Map<String, String> links) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _heading(title),
        for (final e in links.entries)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: InkWell(
              onTap: () => Navigator.pushNamed(context, e.value),
              child: Text(e.key,
                  style: TextStyle(color: Colors.white.withOpacity(0.7))),
            ),
          ),
      ],
    );
  }
}
