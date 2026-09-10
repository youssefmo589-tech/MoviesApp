import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/modules/layoutviewFeature/datalayer/models/movie_model.dart';
import 'package:movieapp/modules/layoutviewFeature/presentation/manager/ProfileBloc.dart';
import 'package:movieapp/modules/layoutviewFeature/presentation/manager/ProfileEvent.dart';
import 'package:movieapp/modules/layoutviewFeature/presentation/manager/ProfileState.dart';
import 'package:movieapp/modules/layoutviewFeature/presentation/pages/profile/presentation/Editprofile_screen.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final Map<String, String> _avatarMap = const {
    'gamer1': 'assets/images/gamer (1).png',
    'gamer11': 'assets/images/gamer (1) (1).png',
    'gamer12': 'assets/images/gamer (1) (2).png',
    'gamer13': 'assets/images/gamer (1) (3).png',
    'gamer14': 'assets/images/gamer (1) (4).png',
    'gamer15': 'assets/images/gamer (1) (5).png',
    'gamer16': 'assets/images/gamer (1) (6).png',
    'gamer17': 'assets/images/gamer (1) (7).png',
    'gamer18': 'assets/images/gamer (1) (8).png',
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    context.read<ProfileBloc>().add(LoadProfileDataEvent());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121312),
      body: SafeArea(
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoadingState) {
              return const Center(child: CircularProgressIndicator(color: Color(0xFFF6BD00)));
            }

            List<MovieModel> watchList = [];
            List<MovieModel> history = [];
            String avatarKey = 'gamer16';

            if (state is ProfileLoadedState) {
              watchList = state.watchList;
              history = state.history;
            }

            final selectedAvatarPath = _avatarMap[avatarKey] ?? 'assets/images/gamer (1) (6).png';

            return Column(
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage(selectedAvatarPath),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildStatColumn(watchList.length.toString(), "Wish List"),
                                _buildStatColumn(history.length.toString(), "History"),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "John Safwat",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF6BD00),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BlocProvider.value(
                                  value: context.read<ProfileBloc>(),
                                  child: const EditProfile(),
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            "Edit Profile",
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE50914),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        ),
                        onPressed: () {},
                        child: const Row(
                          children: [
                            Text("Exit ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            Icon(Icons.exit_to_app, color: Colors.white, size: 18),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                TabBar(
                  controller: _tabController,
                  indicatorColor: const Color(0xFFF6BD00),
                  labelColor: const Color(0xFFF6BD00),
                  unselectedLabelColor: Colors.white54,
                  tabs: const [
                    Tab(icon: Icon(Icons.list), text: "Watch List"),
                    Tab(icon: Icon(Icons.folder_open), text: "History"),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildMovieGridOrEmpty(watchList, "No movies in Watch List"),
                      _buildMovieGridOrEmpty(history, "No watch history found"),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildStatColumn(String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.grey, fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildMovieGridOrEmpty(List<MovieModel> movies, String emptyMessage) {
    if (movies.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.movie_creation_outlined, size: 80, color: Color(0xFFF6BD00)),
            const SizedBox(height: 12),
            Text(emptyMessage, style: const TextStyle(color: Colors.grey, fontSize: 16)),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.7,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                movie.mediumCoverImage ?? '',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(color: Colors.grey[900]),
              ),
              Positioned(
                top: 6,
                left: 6,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.star, color: Color(0xFFF6BD00), size: 12),
                      const SizedBox(width: 2),
                      Text(
                        movie.rating?.toString() ?? '0.0',
                        style: const TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}