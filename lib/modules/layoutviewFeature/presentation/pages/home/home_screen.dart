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
  State<MainLayoutView> createState() => MainLayoutViewState();
}

class MainLayoutViewState extends State<MainLayoutView> {
  int _selectedTabIndex = 0;

  final List<Widget> _tabs = const [
    HomeTab(),
    SearchTab(),
    BrowseTab(),
    ProfileTab(),
  ];

  void changeTab(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  Widget _buildNavItem({
    required int index,
    required String iconPath,
    required String activeIconPath,
    required IconData fallbackIcon,
    required double iconSize,
  }) {
    bool isSelected = _selectedTabIndex == index;
    String targetPath = isSelected ? activeIconPath : iconPath;

    return Expanded(
      child: GestureDetector(
        onTap: () => changeTab(index),
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: targetPath.isNotEmpty
              ? Image.asset(
            targetPath,
            width: iconSize,
            height: iconSize,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => Icon(
              fallbackIcon,
              color: isSelected ? const Color(0xFFFFB224) : Colors.white60,
              size: iconSize,
            ),
          )
              : Icon(
            fallbackIcon,
            color: isSelected ? const Color(0xFFFFB224) : Colors.white60,
            size: iconSize,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    final horizontalMargin = screenWidth * 0.03;
    final barHeight = screenHeight * 0.075;
    final clampedHeight = barHeight.clamp(56.0, 70.0);
    final iconSize = (clampedHeight * 0.38).clamp(20.0, 28.0);

    return Scaffold(
      backgroundColor: Colors.black,
      body: _tabs[_selectedTabIndex],
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(
          left: horizontalMargin,
          right: horizontalMargin,
          bottom: mediaQuery.padding.bottom > 0 ? mediaQuery.padding.bottom : 12,
        ),
        height: clampedHeight,
        decoration: BoxDecoration(
          color: const Color(0xFF282A28),
          borderRadius: BorderRadius.circular(clampedHeight * 0.26),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              index: 0,
              iconPath: 'assets/icons/home.png',
              activeIconPath: 'assets/icons/home1.png',
              fallbackIcon: Icons.home,
              iconSize: iconSize,
            ),
            _buildNavItem(
              index: 1,
              iconPath: 'assets/icons/search.png',
              activeIconPath: 'assets/icons/search1.png',
              fallbackIcon: Icons.search,
              iconSize: iconSize,
            ),
            _buildNavItem(
              index: 2,
              iconPath: 'assets/icons/explore.png',
              activeIconPath: 'assets/icons/explore1.png',
              fallbackIcon: Icons.explore,
              iconSize: iconSize,
            ),
            _buildNavItem(
              index: 3,
              iconPath: 'assets/icons/Profile.png',
              activeIconPath: 'assets/icons/Profile1.png',
              fallbackIcon: Icons.person,
              iconSize: iconSize,
            ),
          ],
        ),
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
          } else if (state is HomeLoaded) {
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
                          child: (movies[currentIndex].mediumCoverImage != null &&
                              movies[currentIndex].mediumCoverImage!.isNotEmpty)
                              ? Image.network(
                            movies[currentIndex].mediumCoverImage!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey[900]),
                          )
                              : Container(color: Colors.grey[900]),
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
                              errorBuilder: (context, error, stackTrace) => const Text(
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
                                final imageUrl = movies[index].mediumCoverImage ?? '';
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
                                        borderRadius: BorderRadius.circular(16),
                                        color: Colors.grey[850],
                                        image: imageUrl.isNotEmpty
                                            ? DecorationImage(
                                          image: NetworkImage(imageUrl),
                                          fit: BoxFit.cover,
                                        )
                                            : null,
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
                              errorBuilder: (context, error, stackTrace) => const Text(
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
                                onTap: () {
                                  context.findAncestorStateOfType<MainLayoutViewState>()?.changeTab(2);
                                },
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
                              final imageUrl = movies[index].mediumCoverImage ?? '';
                              return GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: 146,
                                  margin: const EdgeInsets.only(right: 12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.grey[850],
                                    image: imageUrl.isNotEmpty
                                        ? DecorationImage(
                                      image: NetworkImage(imageUrl),
                                      fit: BoxFit.cover,
                                    )
                                        : null,
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