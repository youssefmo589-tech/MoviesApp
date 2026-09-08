import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/core/app_theme_manager/app_colors.dart';
import 'package:movieapp/modules/layoutviewFeature/presentation/manager/home_bloc.dart';
import '../../../../../../core/app_routes/app_route_name.dart';
import '../../../../datalayer/datasources/movie_remote_data_source.dart';
import '../../../../datalayer/repositoryImp/movie_repository_impl.dart';
import '../../../../domain/usecases/get_movies_usecase.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        GetMoviesUseCase(
          MovieRepositoryImpl(
            MovieRemoteDataSource(),
          ),
        ),
      )..add(FetchMoviesEvent()),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFFFFB224)));
          } else if (state is HomeError) {
            return Center(child: Text(state.message, style: const TextStyle(color: Colors.white)));
          } else if (state is HomeLoaded) {
            final movies = state.movies;
            if (movies.isEmpty) {
              return const Center(child: Text('No movies found', style: TextStyle(color: Colors.white)));
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
                              colors: [Colors.black, Colors.black, Colors.transparent],
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
                              errorBuilder: (context, error, stackTrace) => const Text(
                                'Available Now',
                                style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 351,
                            child: PageView.builder(
                              itemCount: movies.length,
                              controller: PageController(viewportFraction: 0.6),
                              onPageChanged: (index) {
                                setState(() {
                                  currentIndex = index;
                                });
                              },
                              itemBuilder: (context, index) {
                                bool isCurrent = currentIndex == index;
                                return GestureDetector(
                                  onTap: () {
                                  },
                                  child: AnimatedScale(
                                    scale: isCurrent ? 1.0 : 0.85,
                                    duration: const Duration(milliseconds: 300),
                                    child: Container(
                                      width: 234,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        image: DecorationImage(
                                          image: NetworkImage(movies[index].mediumCoverImage ?? ''),
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
                              errorBuilder: (context, error, stackTrace) => const Text(
                                'Watch Now',
                                style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Action',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, AppRouteName.Editprofile);
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
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          height: 220,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: movies.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                },
                                child: Container(
                                  width: 146,
                                  margin: const EdgeInsets.only(right: 12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: NetworkImage(movies[index].mediumCoverImage ?? ''),
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