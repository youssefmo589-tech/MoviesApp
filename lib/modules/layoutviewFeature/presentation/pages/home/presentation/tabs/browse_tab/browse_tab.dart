import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/modules/layoutviewFeature/datalayer/datasources/browse_remote_data_source.dart';
import 'package:movieapp/modules/layoutviewFeature/datalayer/repositoryImp/browse_repository_impl.dart';
import 'package:movieapp/modules/layoutviewFeature/domain/usecases/get_movies_by_genre_usecase.dart';
import 'package:movieapp/modules/layoutviewFeature/presentation/manager/browse_bloc.dart';
import 'package:movieapp/modules/layoutviewFeature/presentation/manager/browse_event.dart';
import 'package:movieapp/modules/layoutviewFeature/presentation/manager/browse_state.dart';

class BrowseTab extends StatelessWidget {
  const BrowseTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BrowseBloc(
        GetMoviesByGenreUseCase(
          BrowseRepositoryImpl(BrowseRemoteDataSource()),
        ),
      )..add(CategorySelectedEvent(genre: 'Action', index: 0)),
      child: const BrowseBody(),
    );
  }
}

class BrowseBody extends StatelessWidget {
  const BrowseBody({super.key});

  final List<String> categories = const [
    'Action',
    'Adventure',
    'Animation',
    'Biography',
    'Comedy',
    'Crime',
    'Documentary',
    'Drama',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: 40,
              child: BlocBuilder<BrowseBloc, BrowseState>(
                builder: (context, state) {
                  int selectedIndex = 0;
                  if (state is BrowseSuccess) {
                    selectedIndex = state.selectedCategoryIndex;
                  }

                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: categories.length,
                    separatorBuilder: (context, index) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final isSelected = selectedIndex == index;
                      return GestureDetector(
                        onTap: () {
                          context.read<BrowseBloc>().add(
                            CategorySelectedEvent(
                              genre: categories[index],
                              index: index,
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFFFFB224) : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFFFFB224),
                              width: 1.5,
                            ),
                          ),
                          child: Text(
                            categories[index],
                            style: TextStyle(
                              color: isSelected ? Colors.black : const Color(0xFFFFB224),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<BrowseBloc, BrowseState>(
                builder: (context, state) {
                  if (state is BrowseLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: Color(0xFFFFB224)),
                    );
                  } else if (state is BrowseError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  } else if (state is BrowseSuccess) {
                    if (state.movies.isEmpty) {
                      return const Center(
                        child: Text(
                          'No Movies Found',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      );
                    }
                    return GridView.builder(
                      itemCount: state.movies.length,
                      physics: const BouncingScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.68,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemBuilder: (context, index) {
                        final movie = state.movies[index];
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Image.network(
                                  movie.mediumCoverImage ?? '',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: const Color(0xFF282A28),
                                      child: const Icon(
                                        Icons.broken_image,
                                        color: Colors.grey,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Positioned(
                                top: 8,
                                left: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        movie.rating?.toString() ?? '0.0',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 3),
                                      const Icon(
                                        Icons.star,
                                        color: Color(0xFFFFB224),
                                        size: 14,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}