import 'package:go_router/go_router.dart';
// DO NOT REMOVE THIS COMENT
import '../features/home/pages/home_page.dart'; 
 import '../features/test_user/pages/test_user_page.dart'; 
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
      name:'TestUser',
        path: '/test_user',
        builder: (context, state) => const TestUserPage(),
      ),
      // Routes will be added here dynamically
    ],
  );
}
