import 'package:first_app/feature/details_popular/presentation/manager/details_popular_cubit/details_popular_cubit.dart';
import 'package:first_app/feature/details_popular/presentation/view/widget/details_popular_view_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsPopularView extends StatelessWidget {
  final num? personId;

  const DetailsPopularView({super.key, this.personId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailsPopularCubit(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: DetailsPopularViewWrapper(id: personId),
          ),
        ),
      ),
    );
  }
}
