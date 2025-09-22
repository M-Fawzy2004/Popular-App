import 'package:first_app/feature/details_popular/presentation/view/widget/person_image_widget.dart';
import 'package:first_app/feature/details_popular/presentation/view/widget/person_known_for_widget.dart';
import 'package:first_app/feature/details_popular/presentation/view/widget/person_name_widget.dart';
import 'package:flutter/material.dart';

class PersonHeaderWidget extends StatelessWidget {
  final dynamic person;

  const PersonHeaderWidget({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    final imageUrl = person?.profilePath != null
        ? 'https://image.tmdb.org/t/p/w500${person!.profilePath}'
        : null;

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 18),
          PersonImageWidget(
            imageUrl: imageUrl,
            personName: person?.name ?? 'Unknown',
          ),
          const SizedBox(height: 16),
          PersonNameWidget(name: person?.name ?? 'Unknown'),
          const SizedBox(height: 5),
          PersonKnownForWidget(knownFor: person?.knownForDepartment),
        ],
      ),
    );
  }
}
