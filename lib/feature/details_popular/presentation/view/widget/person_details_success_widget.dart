import 'package:first_app/feature/details_popular/presentation/view/widget/person_biography_widget.dart';
import 'package:first_app/feature/details_popular/presentation/view/widget/person_header_widget.dart';
import 'package:first_app/feature/details_popular/presentation/view/widget/person_info_widget.dart';
import 'package:flutter/material.dart';

class PersonDetailsSuccessWidget extends StatelessWidget {
  final dynamic person;

  const PersonDetailsSuccessWidget({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PersonHeaderWidget(person: person),
          const SizedBox(height: 15),
          PersonInfoWidget(person: person),
          const SizedBox(height: 10),
          if (person?.biography?.isNotEmpty == true)
            PersonBiographyWidget(
              biography: person!.biography!,
            ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
