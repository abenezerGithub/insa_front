import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';



class ReportCardShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.grey[300]!,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 220,
                  height: 18,
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 14,
                ),
                Container(
                  width: double.infinity,
                  height: 36,
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  width: 140,
                  height: 18,
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 70,
                      height: 18,
                      color: Colors.white,
                    ),
                    Container(
                      width: 100,
                      height: 18,
                      color: Colors.white,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AvatarCardShimmer extends StatelessWidget {
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
              child: SizedBox()),
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
