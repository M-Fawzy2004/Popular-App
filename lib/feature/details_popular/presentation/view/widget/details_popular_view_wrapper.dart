import 'package:first_app/feature/details_popular/presentation/manager/details_popular_cubit/details_popular_cubit.dart';
import 'package:first_app/feature/details_popular/presentation/view/widget/person_details_error_widget.dart';
import 'package:first_app/feature/details_popular/presentation/view/widget/person_details_loading_widget.dart';
import 'package:first_app/feature/details_popular/presentation/view/widget/person_details_success_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsPopularViewWrapper extends StatefulWidget {
  const DetailsPopularViewWrapper({super.key, this.id});

  final num? id;

  @override
  State<DetailsPopularViewWrapper> createState() =>
      _DetailsPopularViewWrapperState();
}

class _DetailsPopularViewWrapperState extends State<DetailsPopularViewWrapper> {
  @override
  void initState() {
    super.initState();
    final id = widget.id ?? ModalRoute.of(context)?.settings.arguments as num?;
    if (id != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        DetailsPopularCubit.get(context).getDetails(id);
      });
    } else {
      print('Error: No ID provided to DetailsPopularViewBody');
    }
  }

  @override
  Widget build(BuildContext context) {
    final id = widget.id ?? ModalRoute.of(context)?.settings.arguments as num?;
    if (id == null) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red),
            SizedBox(height: 16),
            Text(
              'No Person ID Provided',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Please select a person to view details',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return BlocBuilder<DetailsPopularCubit, DetailsPopularState>(
      builder: (context, state) {
        if (state is DetailsPopularLoading) {
          return const PersonDetailsLoadingWidget();
        } else if (state is DetailsPopularError) {
          return const PersonDetailsErrorWidget();
        } else if (state is DetailsPopularSuccess) {
          final person =
              DetailsPopularCubit.get(context).popularPeopleDetailsModel;
          return PersonDetailsSuccessWidget(person: person);
        }
        return const PersonDetailsLoadingWidget();
      },
    );
  }
}
