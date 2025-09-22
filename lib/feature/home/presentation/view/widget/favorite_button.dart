import 'package:first_app/core/theme/app_colors.dart';
import 'package:first_app/feature/home/data/model/populer_model.dart';
import 'package:first_app/feature/home/presentation/manager/favorite_cubit/favorites_cubit.dart';
import 'package:first_app/feature/home/presentation/manager/favorite_cubit/favorites_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteButton extends StatelessWidget {
  final Results person;

  const FavoriteButton({
    super.key,
    required this.person,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        final favoritesCubit = context.read<FavoritesCubit>();
        final isFavorite = favoritesCubit.isFavorite(person);

        return GestureDetector(
          onTap: () {
            favoritesCubit.toggleFavorite(person);
            _showFavoriteSnackbar(context, !isFavorite);
          },
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.grey[600],
              size: 20,
            ),
          ),
        );
      },
    );
  }

  void _showFavoriteSnackbar(BuildContext context, bool isAdded) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isAdded
              ? 'تم إضافة ${person.name} للمفضلة'
              : 'تم إزالة ${person.name} من المفضلة',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: isAdded ? AppColors.secondary : Colors.red,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
