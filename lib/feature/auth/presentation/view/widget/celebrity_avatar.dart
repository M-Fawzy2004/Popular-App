import 'package:flutter/material.dart';

class CelebrityAvatar extends StatelessWidget {
  const CelebrityAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.2),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: const Icon(
        Icons.person_outline,
        size: 50,
        color: Colors.white,
      ),
    );
  }
}
