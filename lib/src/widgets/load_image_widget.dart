import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_code/src/widgets/loader_widget.dart';

enum ImageType { assets, file, network }

class LoadImageWidget extends StatelessWidget {
  final ImageType imageType;
  final String imagePath;
  final double? height, width;
  final BoxFit? boxFit;
  final Widget? errorWidget;

  const LoadImageWidget({
    required this.imageType,
    required this.imagePath,
    this.height,
    this.width,
    this.boxFit,
    this.errorWidget,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return imageType == ImageType.file
        ? Image.file(
            File(imagePath),
            height: height,
            width: width,
            fit: boxFit,
          )
        : imageType == ImageType.assets
            ? Image.asset(
                imagePath,
                height: height,
                width: width,
                fit: boxFit,
              )
            : CachedNetworkImage(
                imageUrl: imagePath,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                height: height,
                width: width,
                fit: boxFit,
                placeholder: (context, url) => const LoaderWidget(),
                errorWidget: (context, url, error) =>
                    errorWidget ?? const Icon(Icons.error),
              );
  }
}
