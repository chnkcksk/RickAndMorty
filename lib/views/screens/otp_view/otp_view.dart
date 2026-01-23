import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rickandmorty_2/app/router.dart';

class OtpView extends StatelessWidget {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Doğrulama'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'OTP View',
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
              child: const Text('Giriş Ekranına Dön'),
            ),
          ],
        ),
      ),
    );
  }
}
