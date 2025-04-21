import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_a_z/auth/auth_service.dart';
import 'package:shop_a_z/pages/dashboard_page.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errorMsg = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 500,
            child: Column(
              children: [
                SizedBox(
                  width: 256,
                  child: Image.asset('images/shop_dashboard.png'),
                ),
                Text(
                  'Administração da Loja de A to Z',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Card(
                  elevation: 5,
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(24),
                      children: [
                        Text('Login'),
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                            decoration: InputDecoration(
                              filled: true,
                              prefixIcon: Icon(Icons.email),
                              labelText: 'Email',
                            ),
                            validator: (value) {
                              if ((value == null) || (value.isEmpty)) {
                                return 'Este campo não pode ficar em branco.';
                              } else if (!EmailValidator.validate(value)) {
                                return 'Informe um endereço de email válido.';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: TextFormField(
                            obscureText: true,
                            controller: _passwordController,
                            decoration: InputDecoration(
                              filled: true,
                              prefixIcon: Icon(Icons.password),
                              labelText: 'Senha',
                            ),
                            validator: (value) {
                              if ((value == null) || (value.isEmpty)) {
                                return 'Este campo não pode ficar em branco.';
                              } else if (value.length < 6) {
                                return 'A senha deve ter no mínimo 6 caracteres.';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _authenticate,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(Icons.login),
                                Text('Login como Administrador'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    _errorMsg,
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _authenticate() async {
    if (_formKey.currentState!.validate()) {
      EasyLoading.show(status: 'Please wait...');
      final email = _emailController.text;
      final password = _passwordController.text;
      try {
        final status = await AuthService.loginAdmin(email, password);
        if (status) {
          if (context.mounted) {
            context.goNamed(DashboardPage.routeName);
          }
        } else {
          setState(() {
            _errorMsg = 'Esta não é uma conta de administrador.';
          });
        }
      } on FirebaseAuthException catch (error) {
        AuthService.logout();
        setState(() {
          _errorMsg = error.message!;
        });
      }
      EasyLoading.dismiss();
    }
  }
}
