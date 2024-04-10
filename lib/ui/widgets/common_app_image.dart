import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommonAppImage extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;
  final double? radius;
  final BoxFit? fit;

  const CommonAppImage(
      {super.key,
      required this.imagePath,
      required this.height,
      required this.width,
      this.radius,
      this.fit});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      clipBehavior: Clip.hardEdge,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(radius ?? 0)),
      child: imagePath.startsWith('http')
          ? imagePath.endsWith('svg')
              ? SvgPicture.network(
                  imagePath,
                  height: height,
                  width: width,
                  fit: BoxFit.cover,
                )
              : Image.network(
                  imagePath,
                  height: height,
                  width: width,
                  fit: fit,
                )
          : imagePath.contains('assets')
              ? imagePath.endsWith('svg')
                  ? SvgPicture.asset(
                      imagePath,
                      height: height,
                      width: width,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      imagePath,
                      height: height,
                      width: width,
                      fit: fit,
                    )
              : imagePath.endsWith('svg')
                  ? SvgPicture.file(
                      File(imagePath),
                      height: height,
                      width: width,
                      fit: BoxFit.cover,
                    )
                  : Image.file(
                      File(imagePath),
                      height: height,
                      width: width,
                      fit: fit,
                    ),
    );
  }
}
