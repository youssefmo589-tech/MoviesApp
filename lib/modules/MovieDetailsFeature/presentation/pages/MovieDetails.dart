import 'package:flutter/material.dart';
import 'package:movieapp/widgets/GenresContainer.dart';

import '../../../../core/app_theme_manager/app_colors.dart';

class MovieDetails extends StatefulWidget {
  const MovieDetails({super.key});

  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  List<String> titles = ["Action", "Sci-Fi", "Adventure", "Fantasy", "Horror"];

  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Summary",
                  style: theme.titleLarge?.copyWith(
                    color: AppColors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Following the events of Spider-Man No Way Home, Doctor Strange unwittingly casts a forbidden spell that accidentally opens up the multiverse. With help from Wong and Scarlet Witch, Strange confronts various versions of himself as well as teaming up with the young America Chavez while traveling through various realities and working to restore reality as he knows it. Along the way, Strange and his allies realize they must take on a powerful new adversary who seeks to take over the multiverse.—Blazer346",
                  style: theme.titleSmall?.copyWith(
                    fontSize: 16,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(height: 8),

                Text(
                  "Cast",
                  style: theme.titleLarge?.copyWith(
                    color: AppColors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8),

                // ListView.separated(
                //     itemBuilder: (context , index){
                //
                //       return MovieDetailsContainer(name: name, charachter: charachter, image: image) ;
                //     },
                //     separatorBuilder:(context ,index){
                //       return SizedBox(height: 8,) ;
                //     } ,
                //
                //     itemCount: itemCount
                //
                // ) ,
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
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 11,
                    mainAxisExtent: 36,
                  ),
                  itemBuilder: (Context, index) {
                    return GenresContainer(title: titles[index]);
                  },
                  itemCount: titles.length,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
