import 'package:first_app/feature/details_popular/presentation/view/widget/person_also_known_as_widget.dart';
import 'package:first_app/feature/details_popular/presentation/view/widget/person_info_row_widget.dart';
import 'package:first_app/feature/details_popular/presentation/view/widget/person_section_title_widget.dart';
import 'package:flutter/material.dart';

class PersonInfoWidget extends StatelessWidget {
  final dynamic person;

  const PersonInfoWidget({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PersonSectionTitleWidget(title: 'Personal Information'),
            const SizedBox(height: 20),
            PersonInfoRowWidget(
              icon: Icons.cake,
              label: 'Birthday',
              value: person?.birthday ?? 'Not available',
            ),
            if (person?.deathday != null)
              PersonInfoRowWidget(
                icon: Icons.event_busy,
                label: 'Death Date',
                value: person!.deathday!,
              ),
            PersonInfoRowWidget(
              icon: Icons.location_on,
              label: 'Place of Birth',
              value: person?.placeOfBirth ?? 'Not available',
            ),
            PersonInfoRowWidget(
              icon: person?.gender == 1 ? Icons.female : Icons.male,
              label: 'Gender',
              value: person?.gender == 1
                  ? 'Female'
                  : person?.gender == 2
                      ? 'Male'
                      : 'Not specified',
            ),
            PersonInfoRowWidget(
              icon: Icons.star,
              label: 'Popularity',
              value: person?.popularity?.toStringAsFixed(1) ?? 'Not available',
            ),
            if (person?.alsoKnownAs?.isNotEmpty == true)
              PersonAlsoKnownAsWidget(alsoKnownAs: person!.alsoKnownAs!),
          ],
        ),
      ),
    );
  }
}
