import 'package:first_app/core/theme/app_colors.dart';
import 'package:first_app/feature/home/data/model/populer_model.dart';
import 'package:flutter/material.dart';

class FilterSection extends StatelessWidget {
  const FilterSection({
    super.key,
    required this.departments,
    required this.popularModel,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  final PopularModel popularModel;
  final List<String> departments;
  final String selectedFilter;
  final Function(String) onFilterChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Categories',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: departments.length,
            itemBuilder: (context, index) {
              final department = departments[index];
              final isSelected = selectedFilter == department;
              return GestureDetector(
                onTap: () => onFilterChanged(department),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.only(right: 8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.secondary : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      _getArabicName(department),
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.grey[700],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  String _getArabicName(String department) {
    switch (department) {
      case 'All':
        return 'All';
      case 'Acting':
        return 'Acting';
      case 'Directing':
        return 'Directing';
      case 'Production':
        return 'Production';
      case 'Writing':
        return 'Writing';
      case 'Sound':
        return 'Sound';
      case 'Camera':
        return 'Camera';
      case 'Editing':
        return 'Editing';
      case 'Art':
        return 'Art';
      case 'Costume & Make-Up':
        return 'Costume & Make-Up';
      case 'Visual Effects':
        return 'Visual Effects';
      case 'Crew':
        return 'Crew';
      default:
        return department;
    }
  }
}
