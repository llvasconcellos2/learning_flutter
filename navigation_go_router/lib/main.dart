import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation_go_router/login_page.dart';
import 'package:navigation_go_router/page_one_details.dart';
import 'package:navigation_go_router/profile_page.dart';

import 'error_page.dart';
import 'home_page.dart';
import 'page_one.dart';
import 'page_two.dart';

bool loggedIn = true;

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: _router,
    );
  }

  final _router = GoRouter(
    initialLocation: '/',
    // redirect pode estar em qualquer rota
    redirect: (context, state) {
      if (!loggedIn) {
        return '/login';
      }
      return null;
    },
    debugLogDiagnostics: true,
    errorBuilder: (context, state) => const ErrorPage(),
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
            path: 'profile/:name',
            name: ProfilePage.routeName,
            builder:
                (context, state) =>
                    ProfilePage(name: state.pathParameters['name']!),
          ),
        ],
      ),
      GoRoute(
        path: '/one',
        name: 'one',
        builder: (context, state) => const PageOne(),
        routes: [
          GoRoute(
            name: PageOneDetails.routeName,
            path: 'on_details',
            builder: (context, state) => const PageOneDetails(),
          ),
        ],
      ),
      GoRoute(
        path: '/two',
        name: 'two',
        builder: (context, state) {
          final greeting = state.extra! as String;
          return PageTwo(greetings: greeting);
        },
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    ],
  );
}
