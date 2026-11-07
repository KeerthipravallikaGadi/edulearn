import 'package:flutter/material.dart';

import 'core/theme.dart';
import 'screens/about_screen.dart';
import 'screens/auth_screen.dart';
import 'screens/contact_screen.dart';
import 'screens/course_detail_screen.dart';
import 'screens/courses_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/home_screen.dart';
import 'screens/not_found_screen.dart';

class EduLearnApp extends StatelessWidget {
  const EduLearnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduLearn - Online Learning Platform',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: '/',
      onGenerateRoute: _generateRoute,
    );
  }

  /// Central route table. '/course/<id>' is a dynamic route.
  static Route<dynamic> _generateRoute(RouteSettings settings) {
    final name = settings.name ?? '/';
    Widget page;

    if (name.startsWith('/course/')) {
      page = CourseDetailScreen(courseId: name.substring('/course/'.length));
    } else {
      switch (name) {
        case '/':
          page = const HomeScreen();
          break;
        case '/courses':
          page = const CoursesScreen();
          break;
        case '/auth':
          page = const AuthScreen();
          break;
        case '/dashboard':
          page = const DashboardScreen();
          break;
        case '/about':
          page = const AboutScreen();
          break;
        case '/contact':
          page = const ContactScreen();
          break;
        default:
          page = const NotFoundScreen();
      }
    }

    return PageRouteBuilder<dynamic>(
      settings: settings,
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
    );
  }
}
