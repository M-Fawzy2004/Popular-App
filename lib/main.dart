import 'package:first_app/core/theme/app_colors.dart';
import 'package:first_app/feature/home/presentation/manager/favorite_cubit/favorites_cubit.dart';
import 'package:first_app/feature/splash/presentation/view/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoritesCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.background,
          fontFamily: 'font',
        ),
        home: const SplashView(),
      ),
    );
  }
}
