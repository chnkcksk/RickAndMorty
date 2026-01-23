import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rickandmorty_2/app/router.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kayıt Ol'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Register View',
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
                context.go(AppRoutes.login);
              },
              child: const Text('Giriş Yap'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                context.go(AppRoutes.otp);
              },
              child: const Text('OTP Ekranına Geç'),
            ),
          ],
        ),
      ),
    );
  }
}
