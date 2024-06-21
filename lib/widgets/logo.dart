import 'package:flutter/cupertino.dart';

class Logo extends StatelessWidget {
  final double width;
  const Logo({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/logo/logo.png",
      width: width,
    );
  }
}
