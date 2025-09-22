import 'package:first_app/feature/auth/presentation/view/widget/celebrity_avatar.dart';
import 'package:first_app/feature/auth/presentation/view/widget/login_card.dart';
import 'package:first_app/feature/auth/presentation/view/widget/signup_text_row.dart';
import 'package:flutter/material.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(height: 60),
          CelebrityAvatar(),
          const SizedBox(height: 30),
          const Text(
            'Welcome Back',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Sign in to continue',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.8),
              letterSpacing: 0.5,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 50),
          LoginCard(),
          const SizedBox(height: 30),
          SignupTextRow(),
        ],
      ),
    );
  }
}
