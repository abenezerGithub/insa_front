import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insa_report/providers/reports_provider.dart';
import 'package:insa_report/providers/user_provider.dart';
import 'package:insa_report/services/securestore.dart';
import 'package:insa_report/widgets/avatar_card.dart';
import 'package:insa_report/widgets/settings_tile.dart';
import 'package:insa_report/widgets/settings_trial.dart';
import 'package:insa_report/widgets/shimmers/profile_screen_shimmer.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        child: SingleChildScrollView(
            child: ref.watch(userProvider).when(data: (user) {
          if (user == null) return const Text("Error loading in user");
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AvatarCard(user: user),
              const SizedBox(height: 15),
              const Divider(),
              const SizedBox(height: 10),
              SettingTile(
                icon: Icons.verified_user_outlined,
                onTap: null,
                title: "User id",
                trail: SettingTrail(
                  text: user.uid.length > 20
                      ? "${user.uid.substring(0, 20)}..."
                      : user.uid,
                ),
              ),
              ref.watch(reportsProvider(user)).when(data: (reports) {
                return Column(
                  children: [
                    SettingTile(
                      icon: Icons.article_outlined,
                      onTap: null,
                      title: "Total reports",
                      trail: SettingTrail(
                        text: "${reports?.length ?? 0}",
                      ),
                    ),
                    SettingTile(
                      icon: Icons.checklist_rounded,
                      onTap: null,
                      title: "Resolved reports",
                      trail: SettingTrail(
                        text:
                            "${reports?.where((element) => element.is_resolved).length ?? 0}",
                      ),
                    )
                  ],
                );
              }, error: (error, st) {
                return Container();
                return const Text("Faild to load user records");
              }, loading: () {
                return const Column(
                  children: [ShimmetTile(), ShimmetTile()],
                );
              }),
              const SizedBox(height: 10),
              const Divider(),
              SettingTile(
                icon: Icons.logout_outlined,
                onTap: () async {
                  final isDeleted = await SecureStore.removeUser();
                  if (isDeleted) {
                    if (mounted) {
                      ref.invalidate(userProvider);
                      Navigator.pushReplacementNamed(context, "/welcome");
                    }
                  }
                },
                title: "Logout",
                color: Colors.redAccent,
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 20),
            ],
          );
        }, error: (error, st) {
          print(error);
          return Container();
          return Text(error.toString());
        }, loading: () {
          return const ProfileScreenShimmer();
        })),
      ),
    );
  }
}
