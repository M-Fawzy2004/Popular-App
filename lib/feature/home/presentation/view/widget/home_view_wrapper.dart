import 'package:first_app/feature/home/presentation/manager/popular_cubit/populer_cubit.dart';
import 'package:first_app/feature/home/presentation/view/widget/error_widget.dart';
import 'package:first_app/feature/home/presentation/view/widget/home_view_body.dart';
import 'package:first_app/feature/home/presentation/view/widget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeViewBodyWrapper extends StatelessWidget {
  const HomeViewBodyWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopulerCubit, PopulerState>(
      builder: (context, state) {
        if (state is PopulerLoading) {
          return const LoadingWidget();
        } else if (state is PopulerSuccess) {
          return HomeViewBody(popularModel: state.popularModel);
        } else if (state is PopulerError) {
          return ErrorCard(message: state.message);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
