import 'package:flutter/material.dart';

import '../widgets/page_scaffold.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      child: Padding(
        padding: const EdgeInsets.all(64),
        child: Center(
          child: Column(
            children: [
              const Text('404',
                  style: TextStyle(fontSize: 80, fontWeight: FontWeight.w800)),
              const Text('Page not found', style: TextStyle(fontSize: 22)),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pushReplacementNamed(context, '/'),
                child: const Text('Back to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
