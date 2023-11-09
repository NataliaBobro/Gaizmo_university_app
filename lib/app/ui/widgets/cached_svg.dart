import 'package:cached_network_svg_image/cached_network_svg_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CachedSvg extends StatelessWidget {
  const CachedSvg(
    this.url, {
    Key? key,
    this.height,
    this.width,
    this.color,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.showErrorWidget = true,
  }) : super(key: key);

  final String url;
  final Color? color;
  final double? height;
  final double? width;
  final BoxFit fit;
  final AlignmentGeometry alignment;
  final bool showErrorWidget;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkSVGImage(
      url,
      height: height,
      width: width,
      fit: fit,
      alignment: alignment,
      placeholder: const CupertinoActivityIndicator(),
      errorWidget: showErrorWidget ? const Icon(
        Icons.error,
        color: Colors.red,
      ) : null,
      color: color,
      fadeDuration: const Duration(milliseconds: 150),
    );
  }
}
