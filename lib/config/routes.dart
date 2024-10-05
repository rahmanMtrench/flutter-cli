import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../features/setting/pages/setting_page.dart';
import '../features/home/pages/home_page.dart';

GoRouter createRouter() {
  return GoRouter(
    routes: [
            GoRoute(
        path: '/home',
        builder: (context, state) => const HomePage(),
      ),
            GoRoute(
        path: '/setting',
        builder: (context, state) => const SettingPage(),
      ),
      
      // Routes will be added here dynamically
    ],
  );
}
