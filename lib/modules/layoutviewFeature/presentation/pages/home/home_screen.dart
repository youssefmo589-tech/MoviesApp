
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/modules/layoutviewFeature/datalayer/datasources/browse_remote_data_source.dart';
import 'package:movieapp/modules/layoutviewFeature/datalayer/datasources/movie_remote_data_source.dart';
import 'package:movieapp/modules/layoutviewFeature/datalayer/datasources/profile_local_data_source.dart';
import 'package:movieapp/modules/layoutviewFeature/datalayer/repositoryImp/browse_repository_impl.dart';
import 'package:movieapp/modules/layoutviewFeature/datalayer/repositoryImp/movie_repository_impl.dart';
import 'package:movieapp/modules/layoutviewFeature/domain/usecases/get_movies_by_genre_usecase.dart';
import 'package:movieapp/modules/layoutviewFeature/domain/usecases/get_movies_usecase.dart';
import 'package:movieapp/modules/layoutviewFeature/presentation/manager/home_bloc.dart';
import 'package:movieapp/modules/layoutviewFeature/presentation/manager/profile_bloc.dart';

import 'presentation/tabs/browse_tab/browse_tab.dart';
import 'presentation/tabs/home_tab/home_tab.dart';
import 'presentation/tabs/profile_tab/profile_tab.dart';
import 'presentation/tabs/search_tab/search_tab.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final movieRepository = MovieRepositoryImpl(MovieRemoteDataSource());
    final browseRepository = BrowseRepositoryImpl(BrowseRemoteDataSource());

    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(
            getMoviesUseCase: GetMoviesUseCase(movieRepository),
            getMoviesByGenreUseCase: GetMoviesByGenreUseCase(browseRepository),
          )
            ..add(FetchMoviesEvent())
            ..add(FetchRandomGenreSuggestionsEvent()),
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
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    final horizontalMargin = screenWidth * 0.03;
    final barHeight = screenHeight * 0.075;
    final clampedHeight = barHeight.clamp(56.0, 70.0);
    final iconSize = (clampedHeight * 0.38).clamp(20.0, 28.0);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          IndexedStack(
            index: _selectedTabIndex,
            children: _tabs,
          ),

          // Floating Bottom Navigation Bar
          Positioned(
            left: horizontalMargin,
            right: horizontalMargin,
            bottom: mediaQuery.padding.bottom > 0 ? 8 : 16,
            child: SafeArea(
              child: Container(
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
                      iconSize: iconSize,
                    ),
                    _buildNavItem(
                      index: 1,
                      iconPath: 'assets/icons/search.png',
                      activeIconPath: 'assets/icons/search1.png',
                      iconSize: iconSize,
                    ),
                    _buildNavItem(
                      index: 2,
                      iconPath: 'assets/icons/explore.png',
                      activeIconPath: 'assets/icons/explore1.png',
                      iconSize: iconSize,
                    ),
                    _buildNavItem(
                      index: 3,
                      iconPath: 'assets/icons/Profile.png',
                      activeIconPath: 'assets/icons/Profile1.png',
                      iconSize: iconSize,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String iconPath,
    required String activeIconPath,
    required double iconSize,
  }) {
    final isSelected = _selectedTabIndex == index;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Image.asset(
          isSelected ? activeIconPath : iconPath,
          width: iconSize,
          height: iconSize,
        ),
      ),
    );
  }
}