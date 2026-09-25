import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/modules/movie_details_feature/presentation/manager/movie_details_state.dart';
import 'package:movieapp/widgets/GenresContainer.dart';
import 'package:movieapp/widgets/arrow_back_widget.dart';
import 'package:movieapp/widgets/button_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/app_routes/app_route_name.dart';
import '../../../../core/app_theme_manager/app_colors.dart';
import '../../../../core/gen/assets.gen.dart';
import '../../../../widgets/MovieDetailsContainer.dart';
import '../../../../widgets/favorites_icon_widget.dart';
import '../../../../widgets/movie_details_widget.dart';

import '../../../layoutviewFeature/datalayer/Models/movie_model.dart';
import '../../../layoutviewFeature/presentation/manager/history_bloc.dart';
import '../../../layoutviewFeature/presentation/manager/history_event.dart';

import '../manager/movie_details_bloc.dart';
import '../manager/movie_details_event.dart';

class MovieDetails extends StatefulWidget {
  final int movieId;
  const MovieDetails({super.key, required this.movieId});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  void initState() {
    super.initState();
    context.read<MovieDetailsBloc>().add(
      MovieSelectedEvent(id: widget.movieId),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      body: BlocConsumer<MovieDetailsBloc, MovieDetailsState>(
        listener: (context, state) {
          if (state is MovieSuccess) {
            final details = state.movieDetails;
            final movieModel = MovieModel(
              id: details.id,
              title: details.name,
              mediumCoverImage: details.imageLarge,
              rating: details.rating,
            );
            context.read<HistoryBloc>().add(
              AddMovieToHistoryEvent(movieModel),
            );
          }
        },
        builder: (BuildContext context, MovieDetailsState state) {
          if (state is MovieLoading || state is MovieInitial) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is MovieError) {
            return Stack(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          state.message,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: AppColors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 8,
                  child: SafeArea(
                    child: ArrowBackWidget(color: AppColors.white),
                  ),
                ),
              ],
            );
          }

          if (state is MovieSuccess) {
            final movie = state.movieDetails;
            final similarmovies = state.similarmovies;

            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Image.network(movie.imageLarge),
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    AppColors.black.withValues(alpha: 0.2),
                                    AppColors.black,
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned.fill(
                            child: GestureDetector(
                              onTap: () {
                                return _launchURL(movie.url);
                              },
                              child: Center(
                                child: Image.asset(
                                  "assets/images/playmovie.png",
                                ),
                              ),
                            ),
                          ),
                          Positioned.fill(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  movie.name,
                                  style: theme.titleLarge?.copyWith(
                                    color: AppColors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 15),
                                Text(
                                  movie.year.toString(),
                                  style: theme.titleLarge?.copyWith(
                                    color: AppColors.offWhite,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 8,
                            child: SafeArea(
                              child: FavoritesIconWidget(
                                isFavorite: state.isFavorite,
                                onTap: () {
                                  context.read<MovieDetailsBloc>().add(
                                    MovieFavoriteEvent(id: movie.id),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8),
                            ButtonWidget(
                              title: "Watch",
                              buttoncolor: AppColors.red,
                              titlecolor: AppColors.white,
                              onTap: () {
                                return _launchURL(movie.url);
                              },
                            ),
                            SizedBox(height: 16),
                            Row(
                              spacing: 16,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MovieDetailsWidget(
                                  data: movie.likes.toString(),
                                  icon: Assets.icons.like.svg(),
                                ),
                                MovieDetailsWidget(
                                  data: movie.time.toString(),
                                  icon: Assets.icons.time.svg(),
                                ),
                                MovieDetailsWidget(
                                  data: movie.rating.toString(),
                                  icon: Assets.icons.stars.svg(),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              "ScreenShots",
                              style: theme.titleLarge?.copyWith(
                                color: AppColors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            ...movie.screenShots.map(
                                  (e) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 7.0,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.network(e),
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              "Similar",
                              style: theme.titleLarge?.copyWith(
                                color: AppColors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 10),

                            /////////////++Suggestions++////////////////
                            GridView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: similarmovies.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.68,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                              ),
                              itemBuilder: (context, index) {
                                final suggestedMovie = similarmovies[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, AppRouteName.MovieDetails,
                                        arguments: suggestedMovie.id);
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Stack(
                                      children: [
                                        Positioned.fill(
                                          child: Image.network(
                                            suggestedMovie.imageLarge,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error,
                                                stackTrace) {
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
                                              color: Colors.black.withValues(
                                                  alpha: 0.7),
                                              borderRadius: BorderRadius
                                                  .circular(10),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  suggestedMovie.rating
                                                      .toString(),
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
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 16),

                            Text(
                              "Summary",
                              style: theme.titleLarge?.copyWith(
                                color: AppColors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              movie.summary,
                              style: theme.titleSmall?.copyWith(
                                fontSize: 16,
                                color: AppColors.white,
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              "Cast",
                              style: theme.titleLarge?.copyWith(
                                color: AppColors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 8),
                            ListView.separated(
                              padding: EdgeInsets.zero,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return MovieDetailsContainer(
                                  cast: movie.cast[index],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(height: 8);
                              },
                              itemCount: movie.cast.length,
                            ),
                            SizedBox(height: 16),
                            Text(
                              "Genres",
                              style: theme.titleLarge?.copyWith(
                                color: AppColors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 8),
                            GridView.builder(
                              padding: EdgeInsets.zero,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 11,
                                mainAxisExtent: 36,
                              ),
                              itemBuilder: (Context, index) {
                                return GenresContainer(
                                  title: movie.genres[index],
                                );
                              },
                              itemCount: movie.genres.length,
                            ),
                            SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 8,
                  child: SafeArea(
                    child: ArrowBackWidget(color: AppColors.white),
                  ),
                ),
              ],
            );
          }

          return SizedBox();
        },
      ),
    );
  }

  void _launchURL(String url) async {
    final launch = await launchUrl(Uri.parse(url), mode: LaunchMode.platformDefault);
    if (!launch) {
      throw Exception('Could not launch $url');
    }
  }
}