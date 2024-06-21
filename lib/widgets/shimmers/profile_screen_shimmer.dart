import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProfileScreenShimmer extends StatelessWidget {
  const ProfileScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AvatarCardShimmer(),
            SizedBox(height: 15),
            Divider(),
            SizedBox(height: 10),
            ShimmetTile(), // Placeholder for SettingTile
            ShimmetTile(), // Placeholder for SettingTile
            ShimmetTile(), // Placeholder for SettingTile
            SizedBox(height: 10),
            Divider(),
            ShimmetTile(), // Placeholder for SettingTile
            SizedBox(height: 10),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class ShimmetTile extends StatelessWidget {
  const ShimmetTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 24,
        height: 24,
        color: Colors.grey[300],
      ),
      title: Container(
        width: double.infinity,
        height: 20,
        color: Colors.grey[300],
      ),
      trailing: Container(
        width: 80,
        height: 20,
        color: Colors.grey[300],
      ),
    );
  }
}

class AvatarCardShimmer extends StatelessWidget {
  const AvatarCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: CircleAvatar(
            backgroundColor:
                Theme.of(context).colorScheme.primary.withOpacity(.77),
            radius: 35,
            child: const SizedBox(),
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: 120, // Adjust width as needed
                height: 20, // Adjust height as needed
                color: Colors
                    .grey[300], // Placeholder color for the shimmering text
              ),
            ),
            const SizedBox(height: 5),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: 80, // Adjust width as needed
                height: 16, // Adjust height as needed
                color: Colors
                    .grey[300], // Placeholder color for the shimmering text
              ),
            ),
          ],
        )
      ],
    );
  }
}
