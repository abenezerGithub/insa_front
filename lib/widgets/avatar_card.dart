import 'package:flutter/material.dart';
import 'package:insa_report/constants/constants.dart';
import 'package:insa_report/models/user.dart';

class AvatarCard extends StatelessWidget {
  final User user;
  const AvatarCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor:
              Theme.of(context).colorScheme.primary.withOpacity(.77),
          radius: 35,
          child: Text(
            user.name[0].toUpperCase(),
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: "Poppins",
            ),
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              user.name,
              style: const TextStyle(
                fontSize: kbigFontSize,
                fontWeight: FontWeight.bold,
                color: kprimaryColor,
              ),
            ),
            Text(
              user.username,
              style: TextStyle(
                fontSize: ksmallFontSize,
                color: Colors.grey.shade600,
              ),
            )
          ],
        )
      ],
    );
  }
}
