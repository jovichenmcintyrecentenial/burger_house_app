import 'package:burger_house/utils/helper.dart';
import 'package:burger_house/views/widgets/generic_Image_handler.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class AdvertBanner extends StatelessWidget {

  final List<String> images;

  const AdvertBanner(this.images, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return
      CarouselSlider.builder(
        itemCount: images.length,
        itemBuilder:
            (BuildContext context, int i, int pageViewIndex) =>
            GenericImagehandler(images[i],height: Helper.getScaleHeightPercentage(context,30),width: double.infinity,),
        options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: true,
          viewportFraction: 1,
          aspectRatio: 2.0,
          initialPage: 2,
        ),
      );
  }
}

