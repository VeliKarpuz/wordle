import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignInScreen(
        actions: [
          AuthStateChangeAction<SignedIn>((context, state) {
            if (1 == 1) {
              Navigator.pushNamed(context, '/verify-email');
            } else {
              Navigator.pushReplacementNamed(context, '/profile');
            }
          }),
        ],
      ),
    );
  }
}
