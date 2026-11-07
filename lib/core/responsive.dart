import 'package:flutter/material.dart';

/// Breakpoints used across the whole app.
class Responsive {
  static double width(BuildContext c) => MediaQuery.of(c).size.width;
  static bool isMobile(BuildContext c) => width(c) < 700;
  static bool isTablet(BuildContext c) => width(c) >= 700 && width(c) < 1100;
  static bool isDesktop(BuildContext c) => width(c) >= 1100;
  static bool isCompactNav(BuildContext c) => width(c) < 900;
}
