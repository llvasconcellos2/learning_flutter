import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_a_z/custom_widgets/dashboard_item_view.dart';
import 'package:shop_a_z/models/dashboard_model.dart';

import '../auth/auth_service.dart';
import '../utils/utils.dart';
import 'login_page.dart';

class DashboardPage extends StatefulWidget {
  static const String routeName = '/';
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Painel de Controle'),
        actions: [
          IconButton(
            onPressed: () {
              showConfirmDialog(
                context,
                onContinue: () async {
                  await AuthService.logout();
                  if (context.mounted) {
                    context.goNamed(LoginPage.routeName);
                  }
                },
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: dashboardModelList.length,
        itemBuilder: (context, index) {
          final model = dashboardModelList[index];
          return DashboardItemView(
            model: model,
            onPress: (route) => context.goNamed((route)),
          );
        },
      ),
    );
  }
}
