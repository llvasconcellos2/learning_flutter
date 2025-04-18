import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vcard/pages/contact_details.dart';
import 'package:vcard/providers/contact_provider.dart';

import 'models/contact_model.dart';
import 'pages/form_page.dart';
import 'pages/home_page.dart';
import 'pages/scan_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ContactProvider(),
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routerConfig: _router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      builder: EasyLoading.init(),
    );
  }

  final _router = GoRouter(
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        name: HomePage.routeName,
        path: HomePage.routeName,
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
            name: ContactDetails.routeName,
            path: ContactDetails.routeName,
            builder:
                (context, state) => ContactDetails(id: state.extra! as int),
          ),
          GoRoute(
            name: ScanPage.routeName,
            path: ScanPage.routeName,
            builder: (context, state) => const ScanPage(),
            routes: [
              GoRoute(
                name: FormPage.routeName,
                path: FormPage.routeName,
                builder:
                    (context, state) =>
                        FormPage(contactModel: state.extra! as ContactModel),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
