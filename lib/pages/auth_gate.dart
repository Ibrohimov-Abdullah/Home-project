import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_learning_part2/pages/home_page.dart';
import 'package:firebase_learning_part2/pages/auth_pages/register_page.dart';
import 'package:firebase_learning_part2/services/auth_service.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService.auth.authStateChanges(),
      builder: (context, snapshot) {
        return snapshot.hasData ? HomePage(user: snapshot.data,) : const RegisterPage();
      },
    );
  }
}
