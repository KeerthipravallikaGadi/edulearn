import 'package:flutter/material.dart';

import '../core/theme.dart';
import '../models/course.dart';

/// Course card with a hover lift animation (desktop) and tap navigation.
class CourseCard extends StatefulWidget {
  final Course course;
  const CourseCard({super.key, required this.course});

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final c = widget.course;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, '/course/${c.id}'),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.translationValues(0, _hover ? -6 : 0, 0),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(_hover ? 0.14 : 0.06),
                blurRadius: _hover ? 24 : 12,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 130,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [c.color, c.color.withOpacity(0.6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  children: [
                    Center(child: Icon(c.icon, size: 56, color: Colors.white)),
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          c.category,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: c.color),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 48,
                      child: Text(
                        c.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            height: 1.3,
                            color: AppColors.dark),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(c.instructor,
                        style: const TextStyle(color: AppColors.text)),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.star,
                            size: 18, color: AppColors.accent),
                        const SizedBox(width: 4),
                        Text('${c.rating}',
                            style:
                                const TextStyle(fontWeight: FontWeight.w700)),
                        const SizedBox(width: 6),
                        Text('(${c.students} students)',
                            style: const TextStyle(
                                fontSize: 12, color: AppColors.text)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.schedule,
                            size: 16, color: AppColors.text),
                        const SizedBox(width: 4),
                        Text('${c.hours} hrs',
                            style: const TextStyle(
                                fontSize: 13, color: AppColors.text)),
                        const SizedBox(width: 14),
                        const Icon(Icons.bar_chart,
                            size: 16, color: AppColors.text),
                        const SizedBox(width: 4),
                        Text(c.level,
                            style: const TextStyle(
                                fontSize: 13, color: AppColors.text)),
                      ],
                    ),
                    const Divider(height: 28),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          c.priceLabel,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: c.price == 0
                                  ? const Color(0xFF16A34A)
                                  : AppColors.primary),
                        ),
                        const Row(
                          children: [
                            Text('View course',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primary)),
                            SizedBox(width: 4),
                            Icon(Icons.arrow_forward,
                                size: 16, color: AppColors.primary),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
