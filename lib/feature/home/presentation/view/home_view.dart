import 'package:first_app/feature/home/presentation/manager/popular_cubit/populer_cubit.dart';
import 'package:first_app/feature/home/presentation/view/widget/home_view_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: BlocProvider(
          create: (context) => PopulerCubit()..getPopular(),
          child: const HomeViewBodyWrapper(),
        ),
      ),
    );
  }
}
