// ignore_for_file: prefer_typing_uninitialized_variables, file_names

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';

///Widget with encapulated logic to display image if already
///preloaded otherwise keeps the space to avoid pushing around the UI 
///And fade in the image upon Loading

//TODO: Maybe Implement Logic for if a placeholder is required
class GenericImagehandler extends StatelessWidget {
  const GenericImagehandler(this.imageUrl,
      {Key? key, this.height, this.width = 30, this.fit = BoxFit.contain, this.animationDuration = const Duration(milliseconds: 250),this.placeholder})
      : super(key: key);
  final imageUrl;
  final double? height;
  final double? width;
  final placeholder;
  final Duration animationDuration;
  final fit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: _getImageWidget(),
    );
  }

  static final _cachedManager = CacheManager(
      Config(
          'ximgx',
          stalePeriod: const Duration(hours: 12),
          maxNrOfCacheObjects: 50
      )
  );



  Widget _getImageWidget() {
    final imageProvider = buildImageProvider(imageUrl, fit);

    if (imageUrl is String && imageUrl.contains('https')) {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        cacheManager: _cachedManager,
        placeholder: (context, url) => const SizedBox(),
        fit: fit,
        errorWidget: (context, url, error) => const Icon(Icons.error,color: Colors.transparent,),
      );
    }

    if (imageUrl != null && imageUrl.contains('.svg')) {
      return SvgPicture.asset(imageUrl,fit: fit);
    }
    return Image(
      fit: fit,
      image: imageProvider,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) {
          return child;
        } else {
          return placeholder == null ? AnimatedSwitcher(
            duration: animationDuration,
            child: frame != null ?Image(
                fit: fit,
                height: height,
                width: width,
                image: imageProvider):const SizedBox(),
          ):AnimatedSwitcher(
            duration:  animationDuration,
            child: frame != null ? Image(
                fit: fit,
                height: height,
                width: width,
                image: imageProvider) : placeholder,
          );
        }
      },
    );
  }

  static Widget shaderMasked(url, {required color,double? height,double width = 30,}){
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: <Color>[color,color],
          tileMode: TileMode.mirror,
        ).createShader(bounds);
      },
      child:GenericImagehandler(url,height:height,width:width),
    );
  }

  ImageProvider buildImageProvider(url, BoxFit fit) {

    if(url is File){
      return Image.file(url, fit: fit).image;
    }
    else if (url != null && url.contains('https')) {
      return Image.network(url, fit: fit).image;
    } else {
      return Image.asset(
        url,
        fit: fit,
      ).image;
    }
  }
}
