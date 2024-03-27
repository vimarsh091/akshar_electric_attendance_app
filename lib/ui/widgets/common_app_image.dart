import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommonAppImage extends StatelessWidget {
  final String path;
  final double width;
  final double height;
  final double? radius;
  final BoxFit? fit;

  const CommonAppImage(
      {super.key,
      required this.path,
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
        child: path.startsWith('http')
            ? path.endsWith('svg')
                ? SvgPicture.network(
                    path,
                    fit: fit ?? BoxFit.cover,
                    height: height,
                    width: width,
                  )
                : CachedNetworkImage(
                    imageUrl: "http://via.placeholder.com/350x150",
                    height: height,
                    width: width,
                    fit: fit,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  )
            : path.endsWith('svg')
                ? SvgPicture.asset(
                    path,
                    fit: fit ?? BoxFit.cover,
                    height: height,
                    width: width,
                  )
                : Image.asset(
                    path,
                    width: width,
                    height: height,
                    fit: fit ?? BoxFit.cover,
                  ));
  }
}
