import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/core/app_theme_manager/app_colors.dart';
import 'package:movieapp/modules/layoutviewFeature/domain/utils/genre_helper.dart';
import 'package:movieapp/modules/layoutviewFeature/presentation/manager/home_bloc.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int currentIndex = 0;
  late List<String> randomGenres;
  String? selectedGenre;

  @override
  void initState() {
    super.initState();
    _loadTabContent();
  }

  void _loadTabContent() {
    randomGenres = GenreHelper.getRandomGenres(count: 3);
    selectedGenre = randomGenres.isNotEmpty ? randomGenres.first : null;

    final homeBloc = context.read<HomeBloc>();

    if (homeBloc.movies.isEmpty) {
      homeBloc.add(FetchMoviesEvent());
    }

    homeBloc.add(FetchMoviesByGenresEvent(randomGenres));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                BlocBuilder<HomeBloc, HomeState>(
                  buildWhen: (previous, current) => current is HomeLoaded,
                  builder: (context, state) {
                    final movies = context.read<HomeBloc>().movies;
                    final currentCover = (movies.isNotEmpty && currentIndex < movies.length)
                        ? movies[currentIndex].mediumCoverImage
                        : null;

                    return Positioned.fill(
                      child: ShaderMask(
                        shaderCallback: (rect) {
                          return const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.black, Colors.black, Colors.transparent],
                            stops: [0.0, 0.7, 1.0],
                          ).createShader(rect);
                        },
                        blendMode: BlendMode.dstIn,
                        child: (currentCover != null && currentCover.isNotEmpty)
                            ? Image.network(
                          currentCover,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(color: const Color(0xFF121312)),
                        )
                            : Container(color: const Color(0xFF121312)),
                      ),
                    );
                  },
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
                      child: BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                          final homeBloc = context.read<HomeBloc>();

                          if (state is HomeLoading && homeBloc.movies.isEmpty) {
                            return const Center(
                              child: CircularProgressIndicator(color: Color(0xFFFFB224)),
                            );
                          }

                          final moviesList = homeBloc.movies;

                          if (moviesList.isEmpty) {
                            return const Center(
                              child: Text(
                                'No movies found',
                                style: TextStyle(color: Colors.white54),
                              ),
                            );
                          }

                          return PageView.builder(
                            itemCount: moviesList.length,
                            controller: PageController(viewportFraction: 0.6),
                            onPageChanged: (index) {
                              setState(() {
                                currentIndex = index;
                              });
                            },
                            itemBuilder: (context, index) {
                              bool isCurrent = currentIndex == index;
                              final imageUrl = moviesList[index].mediumCoverImage;

                              return AnimatedScale(
                                scale: isCurrent ? 1.0 : 0.85,
                                duration: const Duration(milliseconds: 300),
                                child: Container(
                                  width: 234,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.grey[900],
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: (imageUrl != null && imageUrl.isNotEmpty)
                                      ? Image.network(
                                    imageUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stack) =>
                                    const Icon(Icons.movie, color: Colors.white54, size: 50),
                                  )
                                      : const Icon(Icons.movie, color: Colors.white54, size: 50),
                                ),
                              );
                            },
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

            if (randomGenres.isNotEmpty)
              Container(
                height: 40,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: randomGenres.length,
                  itemBuilder: (context, index) {
                    final genre = randomGenres[index];
                    final isSelected = selectedGenre == genre;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ChoiceChip(
                        label: Text(genre),
                        selected: isSelected,
                        selectedColor: const Color(0xFFFFB224),
                        backgroundColor: Colors.grey[900],
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.black : Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        onSelected: (selected) {
                          setState(() {
                            selectedGenre = genre;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),

            const SizedBox(height: 10),

            Container(
              color: AppColors.black,
              child: selectedGenre != null
                  ? _buildGenreSection(selectedGenre!)
                  : const SizedBox.shrink(),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildGenreSection(String genre) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                genre,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: const Row(
                  children: [
                    Text('See More', style: TextStyle(color: Color(0xFFFFB224), fontSize: 14)),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_forward_ios, color: Color(0xFFFFB224), size: 12),
                  ],
                ),
              ),
            ],
          ),
        ),
        BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            final homeBloc = context.read<HomeBloc>();
            final genreMovies = homeBloc.genreMoviesMap[genre] ?? [];

            if (genreMovies.isEmpty) {
              return const SizedBox(
                height: 220,
                child: Center(
                  child: CircularProgressIndicator(color: Color(0xFFFFB224)),
                ),
              );
            }

            return SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: genreMovies.length,
                itemBuilder: (context, index) {
                  final imageUrl = genreMovies[index].mediumCoverImage;
                  return Container(
                    width: 146,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[900],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: (imageUrl != null && imageUrl.isNotEmpty)
                        ? Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stack) =>
                      const Icon(Icons.movie, color: Colors.white54, size: 40),
                    )
                        : const Icon(Icons.movie, color: Colors.white54, size: 40),
                  );
                },
              ),
            );
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}