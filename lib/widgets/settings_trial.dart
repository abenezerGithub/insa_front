import 'package:flutter/material.dart';

class SettingTrail
 extends StatelessWidget {
  final String text;
  const SettingTrail
  ({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    return  Text(
                  text,
                  style: const TextStyle(color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                );
  }
}