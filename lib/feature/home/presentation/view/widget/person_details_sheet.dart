import 'package:first_app/feature/details_popular/presentation/view/details_popular_view.dart';
import 'package:first_app/feature/home/data/model/populer_model.dart';
import 'package:first_app/feature/home/presentation/manager/favorite_cubit/favorites_cubit.dart';
import 'package:first_app/feature/home/presentation/manager/favorite_cubit/favorites_state.dart';
import 'package:first_app/feature/home/presentation/view/widget/custom_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonDetailsSheet extends StatelessWidget {
  final Results person;

  const PersonDetailsSheet({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 20),
          CircleAvatar(
            radius: 40,
            backgroundImage: person.profilePath != null
                ? NetworkImage(
                    "https://image.tmdb.org/t/p/w300${person.profilePath}")
                : null,
            child: person.profilePath == null
                ? const Icon(Icons.person, size: 40)
                : null,
          ),
          const SizedBox(height: 16),
          Text(
            person.name ?? 'Unknown',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            person.knownForDepartment ?? 'Unknown',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildInfoItem(
                  'Rating',
                  '${person.popularity?.toStringAsFixed(1)} K',
                  Icons.star,
                ),
                _buildInfoItem(
                  'Gender',
                  _getGender(person.gender?.toInt()),
                  Icons.person,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              BlocBuilder<FavoritesCubit, FavoritesState>(
                builder: (context, state) {
                  final favoritesCubit = context.read<FavoritesCubit>();
                  final isFavorite = favoritesCubit.isFavorite(person);

                  return CustomActionButton(
                    label:
                        isFavorite ? "Removed favorites" : "Add to favorites",
                    icon: isFavorite ? Icons.favorite : Icons.favorite_border,
                    backgroundColor: isFavorite ? Colors.orange : Colors.red,
                    textColor: Colors.white,
                    onTap: () {
                      favoritesCubit.toggleFavorite(person);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            isFavorite
                                ? 'Removed ${person.name} from favorites'
                                : 'Added ${person.name} to favorites',
                          ),
                          backgroundColor:
                              isFavorite ? Colors.orange : Colors.green,
                          behavior: SnackBarBehavior.floating,
                          margin: const EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(width: 12),
              CustomActionButton(
                label: "Details",
                icon: Icons.info,
                backgroundColor: Colors.blue,
                textColor: Colors.white,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsPopularView(
                        personId: person.id,
                      ),
                    ),
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildInfoItem(String title, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 24, color: Colors.grey[600]),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  String _getGender(int? gender) {
    switch (gender) {
      case 1:
        return 'Female';
      case 2:
        return 'Male';
      default:
        return 'Unknown';
    }
  }
}
