import 'package:flutter/cupertino.dart';

class CopyRight extends StatelessWidget {
  const CopyRight({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        "© 2024 INSA Report. All Rights Reserved",
        style: TextStyle(
          fontSize: 12,
          color: Color.fromARGB(255, 23, 64, 98),
        ),
        textAlign: TextAlign.center,
      ),
    ));
  }
}
