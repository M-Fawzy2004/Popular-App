import 'package:flutter/material.dart';

class PersonPlaceholderWidget extends StatelessWidget {
  const PersonPlaceholderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      child: const Center(
        child: Icon(
          Icons.person,
          size: 60,
          color: Colors.grey,
        ),
      ),
    );
  }
}
