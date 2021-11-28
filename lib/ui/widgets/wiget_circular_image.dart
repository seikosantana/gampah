import 'package:flutter/material.dart';

class CircularImage extends StatelessWidget {
  final ImageProvider image;
  final double? width;
  final double? height;

  const CircularImage({required this.image, this.width, this.height, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 100.0,
      height: height ?? 100.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: image,
        ),
      ),
    );
  }
}
