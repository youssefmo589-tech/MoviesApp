import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/core/app_theme_manager/app_colors.dart';
import 'package:movieapp/modules/layoutviewFeature/datalayer/datasources/movie_remote_data_source.dart';
import 'package:movieapp/modules/layoutviewFeature/datalayer/repositoryImp/movie_repository_impl.dart';
import 'package:movieapp/modules/layoutviewFeature/domain/usecases/get_movies_usecase.dart';
import 'package:movieapp/modules/layoutviewFeature/presentation/pages/home/presentation/tabs/browse_tab/browse_tab.dart';
import 'package:movieapp/modules/layoutviewFeature/presentation/pages/home/presentation/tabs/profile_tab/profile_tab.dart';
import 'package:movieapp/modules/layoutviewFeature/presentation/pages/home/presentation/tabs/search_tab/search_tab.dart';
import 'package:movieapp/modules/layoutviewFeature/datalayer/datasources/profile_local_data_source.dart';
import 'package:movieapp/modules/layoutviewFeature/presentation/manager/editProfileBloc.dart';

import '../../manager/home_bloc.dart';
import '../../manager/profile_bloc.dart';
import '../profile/presentation/home_tab.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(
            GetMoviesUseCase(
              MovieRepositoryImpl(
                MovieRemoteDataSource(),
              ),
            ),
          )..add(FetchMoviesEvent()),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(
            localDataSource: ProfileLocalDataSourceImpl(),
          ),
        ),
      ],
      child: const MainLayoutView(),
    );
  }
}

class MainLayoutView extends StatefulWidget {
  const MainLayoutView({super.key});

  @override
  State<MainLayoutView> createState() => _MainLayoutViewState();
}

class _MainLayoutViewState extends State<MainLayoutView> {
  int _selectedTabIndex = 0;

  final List<Widget> _tabs = const [
    HomeTab(),
    SearchTab(),
    BrowseTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _tabs[_selectedTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTabIndex,
        onTap: (index) {
          setState(() {
            _selectedTabIndex = index;
          });
        },
        backgroundColor: const Color(0xFF1A1A1A),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFFFB224),
        unselectedItemColor: Colors.white60,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_creation_outlined),
            label: 'Browse',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentIndex = 0;
  int selectedGenreIndex = 0;
  final List<String> genres = ['Action', 'Adventure', 'Animation', 'Comedy', 'Drama'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFFFFB224)),
            );
          } else if (state is HomeError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.white),
              ),
            );
          } if (state is HomeLoaded) {
            final movies = state.movies;
            if (movies.isEmpty) {
              return const Center(
                child: Text(
                  'No movies found',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Positioned.fill(
                        child: ShaderMask(
                          shaderCallback: (rect) {
                            return const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black,
                                Colors.black,
                                Colors.transparent,
                              ],
                              stops: [0.0, 0.7, 1.0],
                            ).createShader(rect);
                          },
                          blendMode: BlendMode.dstIn,
                          child: Image.network(
                            movies[currentIndex].mediumCoverImage ?? '',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          color: const Color(0xFF121312).withValues(alpha: 0.80),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Center(
                            child: Image.asset(
                              'assets/images/Available Now.png',
                              width: 267,
                              height: 93,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                              const Text(
                                'Available Now',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 351,
                            child: PageView.builder(
                              itemCount: movies.length,
                              controller: PageController(
                                viewportFraction: 0.6,
                              ),
                              onPageChanged: (index) {
                                setState(() {
                                  currentIndex = index;
                                });
                              },
                              itemBuilder: (context, index) {
                                bool isCurrent = currentIndex == index;
                                return GestureDetector(
                                  onTap: () {},
                                  child: AnimatedScale(
                                    scale: isCurrent ? 1.0 : 0.85,
                                    duration: const Duration(
                                      milliseconds: 300,
                                    ),
                                    child: Container(
                                      width: 234,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(16),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            movies[index].mediumCoverImage ?? '',
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 30),
                          Center(
                            child: Image.asset(
                              'assets/images/Watch Now.png',
                              width: 354,
                              height: 146,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                              const Text(
                                'Watch Now',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 25),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    color: AppColors.black,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 40,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: genres.length,
                            itemBuilder: (context, index) {
                              bool isSelected = selectedGenreIndex == index;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedGenreIndex = index;
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 12),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? const Color(0xFFFFB224)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: const Color(0xFFFFB224),
                                    ),
                                  ),
                                  child: Text(
                                    genres[index],
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.black
                                          : const Color(0xFFFFB224),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                genres[selectedGenreIndex],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: const Row(
                                  children: [
                                    Text(
                                      'See More',
                                      style: TextStyle(
                                        color: Color(0xFFFFB224),
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Color(0xFFFFB224),
                                      size: 12,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          height: 220,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            itemCount: movies.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: 146,
                                  margin: const EdgeInsets.only(right: 12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        movies[index].mediumCoverImage ?? '',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}