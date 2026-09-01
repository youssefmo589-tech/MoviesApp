import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../core/gen/assets.gen.dart';

class AvatarsCarouselSliderWidget extends StatelessWidget {
  const AvatarsCarouselSliderWidget({super.key});

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
    return CarouselSlider(items: avatarsList, options: CarouselOptions(
      height: 161,
      viewportFraction: 0.40,
      initialPage: 0,
      enableInfiniteScroll: true,
      autoPlayCurve: Curves.fastOutSlowIn,
      enlargeCenterPage: true,
      scrollDirection: Axis.horizontal,

    ),);
  }
}
