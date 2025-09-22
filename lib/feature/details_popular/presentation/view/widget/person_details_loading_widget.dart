import 'package:first_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PersonDetailsLoadingWidget extends StatelessWidget {
  const PersonDetailsLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.secondary),
          ),
          SizedBox(height: 16),
          Text(
            'Loading person details...',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
