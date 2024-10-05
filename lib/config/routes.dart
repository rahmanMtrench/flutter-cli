import 'package:go_router/go_router.dart';
// DO NOT REMOVE THIS COMMENT
import '../features/home/pages/home_page.dart';
 import '../features/profile/pages/profile_page.dart'; 
 import '../features/setting/pages/setting_page.dart'; 
 // Page Imports

GoRouter createRouter() {
  return GoRouter(
   initialLocation: '/home',
    routes: [
            GoRoute(
      name:'Home',
        path: '/home',
        builder: (context, state) => const HomePage(),
      ),
            GoRoute(
      name:'Profile',
        path: '/profile',
        builder: (context, state) => const ProfilePage(),
      ),
            GoRoute(
      name:'Setting',
        path: '/setting',
        builder: (context, state) => const SettingPage(),
      ),
      // Routes will be added here dynamically
    ],
  );
}
