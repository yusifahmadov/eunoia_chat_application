import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final double? containerWidth;
  final double? containerHeight;

  const CustomCachedNetworkImage(
      {super.key,
      required this.imageUrl,
      required this.containerWidth,
      required this.containerHeight});

  @override
  Widget build(BuildContext context) {
    return imageUrl != null
        ? CachedNetworkImage(
            imageUrl: imageUrl!,
            imageBuilder: (context, imageProvider) => Container(
              width: containerWidth ?? 120.0,
              height: containerHeight ?? 120.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => Container(
              width: containerWidth ?? 120.0,
              height: containerHeight ?? 120.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                'assets/icons/no-profile-picture.svg',
              ),
            ),
          )
        : Container(
            width: containerWidth ?? 120.0,
            height: containerHeight ?? 120.0,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              'assets/icons/no-profile-picture.svg',
            ),
          );
  }
}
