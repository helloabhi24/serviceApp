import 'package:flutter/material.dart';

class CustomAssetsImage extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final BoxFit? boxFit;
  final Color? color;
  const CustomAssetsImage(
      {this.color,
      this.boxFit,
      this.width,
      this.height,
      this.imagePath = "",
      super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      width: width,
      height: height,
      fit: boxFit,
      color: color,
    );
  }
}
