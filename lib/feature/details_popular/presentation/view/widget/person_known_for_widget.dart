import 'package:first_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PersonKnownForWidget extends StatelessWidget {
  final String? knownFor;

  const PersonKnownForWidget({super.key, this.knownFor});

  @override
  Widget build(BuildContext context) {
    if (knownFor == null) return const SizedBox.shrink();

    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        knownFor!,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: AppColors.secondary,
        ),
      ),
    );
  }
}
