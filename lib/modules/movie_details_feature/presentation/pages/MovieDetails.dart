import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/modules/movie_details_feature/domain/entities/movie_details_entity.dart';
import 'package:movieapp/modules/movie_details_feature/presentation/manager/movie_details_state.dart';
import 'package:movieapp/widgets/GenresContainer.dart';
import 'package:movieapp/widgets/arrow_back_widget.dart';
import 'package:movieapp/widgets/button_widget.dart';

import '../../../../core/app_theme_manager/app_colors.dart';
import '../../../../core/gen/assets.gen.dart';
import '../../../../widgets/MovieDetailsContainer.dart';
import '../../../../widgets/movie_details_widget.dart';
import '../manager/movie_details_bloc.dart';
import '../manager/movie_details_event.dart';

class MovieDetails extends StatefulWidget {
  final int movieId;
  const MovieDetails({super.key, required this.movieId});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  late final MovieDetailsEntity movie;

  @override
  void initState() {
    context.read<MovieDetailsBloc>().add(
      MovieSelectedEvent(id: widget.movieId),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      body: BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
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
            movie = state.movieDetails;

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
                                Navigator.pop(context);
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
                            SizedBox(height: 8),
                            Text(
                              "Similar",
                              style: theme.titleLarge?.copyWith(
                                color: AppColors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),

                            /////////////++Suggestions++////////////////
                            Text(
                              "Summary",
                              style: theme.titleLarge?.copyWith(
                                color: AppColors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 16),
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
}
