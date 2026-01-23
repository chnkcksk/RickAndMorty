import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rickandmorty_2/app/router.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giriş Yap'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Login View',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.go(AppRoutes.characters);
              },
              child: const Text('Ana Ekrana Geç (Test)'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                context.go(AppRoutes.register);
              },
              child: const Text('Kayıt Ol'),
            ),
          ],
        ),
      ),
    );
  }
}
