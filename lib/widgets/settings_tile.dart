import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insa_report/constants/colors.dart';
import 'package:insa_report/constants/constants.dart';

class SettingTile extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final void Function()? onTap;
  final String title;
  final Widget? trail;

  SettingTile(
      {super.key,
      required this.icon,
      this.color,
      required this.onTap,
      required this.title,
      this.trail});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(4)),
      child: Material(
        child: InkWell(
          overlayColor: MaterialStateProperty.all(
              Theme.of(context).colorScheme.primary.withOpacity(.18)),
          splashColor: Theme.of(context).colorScheme.primary.withOpacity(.18),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(2.2),
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: klightContentColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(icon,
                      color: color ??
                          Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(.77)),
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    color: kprimaryColor,
                    fontSize: ksmallFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                trail ?? Container(),
                const SizedBox(
                  width: 8,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
