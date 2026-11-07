import 'package:flutter/material.dart';

import '../core/responsive.dart';
import '../core/theme.dart';
import '../services/app_state.dart';
import 'footer.dart';

/// Shared page shell: responsive header (navbar / drawer), body and footer.
class PageScaffold extends StatelessWidget {
  final Widget child;
  const PageScaffold({super.key, required this.child});

  static const Map<String, String> _links = {
    '/': 'Home',
    '/courses': 'Courses',
    '/about': 'About',
    '/contact': 'Contact',
  };

  void _go(BuildContext context, String route, {Object? args}) {
    final current = ModalRoute.of(context)?.settings.name;
    if (current == route && args == null) return;
    Navigator.pushReplacementNamed(context, route, arguments: args);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppState.instance,
      builder: (context, _) {
        final state = AppState.instance;
        final compact = Responsive.isCompactNav(context);
        final current = ModalRoute.of(context)?.settings.name ?? '/';

        final links = Map<String, String>.from(_links);
        if (state.isLoggedIn) links['/dashboard'] = 'My Learning';

        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 70,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            elevation: 1,
            shadowColor: Colors.black26,
            titleSpacing: compact ? 16 : 32,
            title: InkWell(
              onTap: () => _go(context, '/'),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      gradient: AppColors.hero,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:
                        const Icon(Icons.school, color: Colors.white, size: 22),
                  ),
                  const SizedBox(width: 10),
                  const Text('EduLearn',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: AppColors.dark)),
                ],
              ),
            ),
            actions: compact
                ? [
                    Builder(
                      builder: (ctx) => IconButton(
                        icon: const Icon(Icons.menu),
                        tooltip: 'Menu',
                        onPressed: () => Scaffold.of(ctx).openEndDrawer(),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ]
                : [
                    for (final e in links.entries)
                      TextButton(
                        onPressed: () => _go(context, e.key),
                        style: TextButton.styleFrom(
                          foregroundColor: current == e.key
                              ? AppColors.primary
                              : AppColors.text,
                          textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: current == e.key
                                  ? FontWeight.w700
                                  : FontWeight.w500),
                        ),
                        child: Text(e.value),
                      ),
                    const SizedBox(width: 16),
                    if (state.isLoggedIn) ...[
                      Center(
                        child: Text('Hi, ${state.firstName}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppColors.dark)),
                      ),
                      const SizedBox(width: 12),
                      Center(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 14)),
                          onPressed: () async {
                            await state.logout();
                            if (context.mounted) _go(context, '/');
                          },
                          child: const Text('Logout'),
                        ),
                      ),
                    ] else ...[
                      Center(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 14)),
                          onPressed: () =>
                              _go(context, '/auth', args: false),
                          child: const Text('Login'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 14)),
                          onPressed: () => _go(context, '/auth', args: true),
                          child: const Text('Sign Up'),
                        ),
                      ),
                    ],
                    const SizedBox(width: 32),
                  ],
          ),
          endDrawer: compact
              ? Drawer(
                  child: SafeArea(
                    child: ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Text('Menu',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w800)),
                        ),
                        for (final e in links.entries)
                          ListTile(
                            selected: current == e.key,
                            title: Text(e.value),
                            onTap: () {
                              Navigator.of(context).pop();
                              _go(context, e.key);
                            },
                          ),
                        const Divider(),
                        if (state.isLoggedIn)
                          ListTile(
                            leading: const Icon(Icons.logout),
                            title: Text('Logout (${state.firstName})'),
                            onTap: () async {
                              Navigator.of(context).pop();
                              await state.logout();
                              if (context.mounted) _go(context, '/');
                            },
                          )
                        else ...[
                          ListTile(
                            leading: const Icon(Icons.login),
                            title: const Text('Login'),
                            onTap: () {
                              Navigator.of(context).pop();
                              _go(context, '/auth', args: false);
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.person_add),
                            title: const Text('Sign Up'),
                            onTap: () {
                              Navigator.of(context).pop();
                              _go(context, '/auth', args: true);
                            },
                          ),
                        ],
                      ],
                    ),
                  ),
                )
              : null,
          body: SingleChildScrollView(
            child: Column(
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height - 400),
                  child: child,
                ),
                const AppFooter(),
              ],
            ),
          ),
        );
      },
    );
  }
}
