import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/feature/auth/presentation/view/login_view.dart';
import 'package:first_app/feature/home/data/model/populer_model.dart';
import 'package:first_app/feature/home/presentation/manager/favorite_cubit/favorites_cubit.dart';
import 'package:first_app/feature/home/presentation/manager/favorite_cubit/favorites_state.dart';
import 'package:first_app/feature/home/presentation/view/widget/favorites_bottom_sheet.dart';
import 'package:first_app/feature/home/presentation/view/widget/filter_section.dart';
import 'package:first_app/feature/home/presentation/view/widget/person_card.dart';
import 'package:first_app/feature/home/presentation/view/widget/welcome_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeViewBody extends StatefulWidget {
  final PopularModel popularModel;

  const HomeViewBody({
    super.key,
    required this.popularModel,
  });

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  String selectedFilter = 'All';
  List<Results> filteredPeople = [];

  @override
  void initState() {
    super.initState();
    filteredPeople = widget.popularModel.results ?? [];
  }

  void _onFilterChanged(String filter) {
    setState(() {
      selectedFilter = filter;
      if (filter == 'All') {
        filteredPeople = widget.popularModel.results ?? [];
      } else {
        filteredPeople = widget.popularModel.results
                ?.where((person) => person.knownForDepartment == filter)
                .toList() ??
            [];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Set<String> departments = {'All'};
    for (var person in widget.popularModel.results ?? []) {
      if (person.knownForDepartment != null) {
        departments.add(person.knownForDepartment!);
      }
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          Row(
            children: [
              const WelcomeHeader(),
              const Spacer(),
              IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  if (mounted) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginView(),
                      ),
                      (_) => false,
                    );
                  }
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
              ),
              BlocBuilder<FavoritesCubit, FavoritesState>(
                builder: (context, state) {
                  final favoritesCubit = context.read<FavoritesCubit>();
                  final favoritesCount = favoritesCubit.getFavorites().length;
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.favorite_border_rounded,
                          color: Colors.red,
                          size: 35,
                        ),
                        onPressed: () {
                          _showFavoritesBottomSheet(context);
                        },
                      ),
                      if (favoritesCount > 0)
                        Positioned(
                          right: 6,
                          top: 6,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 20,
                              minHeight: 20,
                            ),
                            child: Text(
                              '$favoritesCount',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 15),
          FilterSection(
            departments: departments.toList(),
            popularModel: widget.popularModel,
            selectedFilter: selectedFilter,
            onFilterChanged: _onFilterChanged,
          ),
          const SizedBox(height: 15),
          _buildPeopleList(),
        ],
      ),
    );
  }

  Widget _buildPeopleList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedFilter == 'All'
                  ? 'All Celebrities'
                  : _getArabicName(selectedFilter),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${filteredPeople.length}',
                style: TextStyle(
                  color: Colors.blue[800],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        filteredPeople.isEmpty
            ? _buildEmptyState()
            : GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemCount: filteredPeople.length,
                itemBuilder: (context, index) {
                  return PersonCard(person: filteredPeople[index]);
                },
              ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Icon(
            Icons.search_off,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No celebrities found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try a different filter',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _getArabicName(String filter) {
    switch (filter) {
      case 'Actor':
        return 'ممثل';
      case 'Actress':
        return 'ممثلة';
      case 'Director':
        return 'مخرج';
      case 'Producer':
        return 'منتج';
      default:
        return filter;
    }
  }

  void _showFavoritesBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return const FavoritesBottomSheet();
      },
    );
  }
}
