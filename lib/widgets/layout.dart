import 'package:flutter/material.dart';

import '../core/responsive.dart';

/// Centers content and limits its width on large screens.
class ContentWrapper extends StatelessWidget {
  final Widget child;
  const ContentWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Responsive.isMobile(context) ? 16 : 32),
          child: child,
        ),
      ),
    );
  }
}

/// A full-width page section with optional background colour.
class PageSection extends StatelessWidget {
  final Widget child;
  final Color? color;
  final double vertical;
  const PageSection(
      {super.key, required this.child, this.color, this.vertical = 64});

  @override
  Widget build(BuildContext context) {
    final v = Responsive.isMobile(context) ? vertical * 0.65 : vertical;
    return Container(
      width: double.infinity,
      color: color,
      padding: EdgeInsets.symmetric(vertical: v),
      child: ContentWrapper(child: child),
    );
  }
}

/// A responsive grid built with Wrap: 1/2/3 columns depending on width.
class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final int desktop;
  final int tablet;
  final int mobile;

  const ResponsiveGrid({
    super.key,
    required this.children,
    this.spacing = 24,
    this.desktop = 3,
    this.tablet = 2,
    this.mobile = 1,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final w = constraints.maxWidth;
      final cols = w >= 900 ? desktop : (w >= 560 ? tablet : mobile);
      final itemWidth = ((w - spacing * (cols - 1)) / cols).floorToDouble();
      return Wrap(
        spacing: spacing,
        runSpacing: spacing,
        children: children
            .map((child) => SizedBox(width: itemWidth, child: child))
            .toList(),
      );
    });
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  const SectionTitle({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final mobile = Responsive.isMobile(context);
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: mobile ? 26 : 34,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 12),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 16, height: 1.5, color: Color(0xFF475569)),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
