import 'package:flutter/material.dart';

class PersonSectionTitleWidget extends StatelessWidget {
  final String title;

  const PersonSectionTitleWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: Colors.black87,
      ),
    );
  }
}
