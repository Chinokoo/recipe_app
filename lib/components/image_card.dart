import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  final Widget child;
  final Function()? onTap;
  const ImageCard({super.key, required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Center(
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: child,
          ),
        ));
  }
}
