import 'package:flutter/material.dart';

import '../core/gen/assets.gen.dart';

class AvatarsCarouselSliderWidget extends StatelessWidget {

  final ValueChanged<int> onAvatarSelected;
  final int selectedIndex;

  const AvatarsCarouselSliderWidget({
    super.key,
    required this.onAvatarSelected,
    this.selectedIndex = 0,
  });


  static const avatarNames = [
    'assets/images/gamer (1).png',
    'assets/images/gamer (1) (1).png',
    'assets/images/gamer (1) (2).png',
    'assets/images/gamer (1) (3).png',
    'assets/images/gamer (1) (4).png',
    'assets/images/gamer (1) (5).png',
    'assets/images/gamer (1) (6).png',
    'assets/images/gamer (1) (7).png',
    'assets/images/gamer (1) (8).png',
  ];

  @override
  Widget build(BuildContext context) {
    var avatarsList = [
      Assets.images.gamer1.image(),
      Assets.images.gamer11.image(),
      Assets.images.gamer12.image(),
      Assets.images.gamer13.image(),
      Assets.images.gamer14.image(),
      Assets.images.gamer15.image(),
      Assets.images.gamer16.image(),
      Assets.images.gamer17.image(),
      Assets.images.gamer18.image(),
    ];

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: avatarsList.length,
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () => onAvatarSelected(index),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 6),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Colors.yellow : Colors.transparent,
                  width: 2.5,
                ),
              ),
              child: ClipOval(child: avatarsList[index]),
            ),
          );
        },
      ),
    );
  }
}