import 'package:first_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PersonAlsoKnownAsWidget extends StatelessWidget {
  final List<String> alsoKnownAs;

  const PersonAlsoKnownAsWidget({super.key, required this.alsoKnownAs});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.person_outline,
              size: 20,
              color: AppColors.secondary,
            ),
            const SizedBox(width: 12),
            const Expanded(
              flex: 2,
              child: Text(
                'Also Known As',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Wrap(
                spacing: 8,
                runSpacing: 4,
                children: alsoKnownAs
                    .map((name) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            name,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textDark,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
