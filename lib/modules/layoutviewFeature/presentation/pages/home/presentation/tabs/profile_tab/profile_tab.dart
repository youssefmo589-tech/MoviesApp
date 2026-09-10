import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/modules/layoutviewFeature/datalayer/models/movie_model.dart';
import 'package:movieapp/modules/layoutviewFeature/presentation/manager/profile_event.dart';

import '../../../../../../../../core/FirebaseCloudService/FirestoreCloudService.dart';
import '../../../../../../../../core/app_routes/app_route_name.dart';
import '../../../../../../datalayer/Models/UserModel.dart';
import '../../../../../manager/profile_bloc.dart';
import '../../../../../manager/profile_state.dart';
//Exit
class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController nameController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  UserModel ? currentuser;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    context.read<ProfileBloc>().add(LoadProfileDataEvent());
    loadCurrentUser();
  }

  Future<void> loadCurrentUser() async {
    final String userid = await FirebaseAuth.instance.currentUser!.uid;
    final user = await FirestoreCloudService.getuser(userid);
    if (user != null) {
      setState(() {
        currentuser = user;
        nameController.text = currentuser?.name ?? "";
        imageController.text = currentuser?.image ?? "";
      });

    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    nameController.dispose();
    imageController.dispose();
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

            if (state is ProfileLoadedState) {
              watchList = state.watchList;
              history = state.history;
            }

            return Column(
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Column(
                        spacing: 15,
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.transparent,
                            backgroundImage: AssetImage(imageController.text),
                          ),
                          Text(
                            nameController.text,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                        ],
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
                            Navigator.pushNamed(context, AppRouteName.Editprofile,);
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
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, AppRouteName.login,);
                        },
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