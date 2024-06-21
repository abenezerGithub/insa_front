import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insa_report/models/user.dart';
import 'package:insa_report/providers/reports_provider.dart';
import 'package:insa_report/providers/user_provider.dart';
import 'package:insa_report/widgets/ReportCard.dart';
import 'package:insa_report/widgets/shimmers/report_card_shimmer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ReportsScreen extends ConsumerStatefulWidget {
  const ReportsScreen({super.key});

  @override
  ConsumerState<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends ConsumerState<ReportsScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  int _page = 0;
  void _onRefresh(User user) async {
    // monitor network fetch
    // if failed,use refreshFailed()
    ref.invalidate(reportsProvider);
    await ref.read(reportsProvider(user).future);
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch

    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // items.add((items.length+1).toString());

    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ref.watch(userProvider).when(data: (user) {
        if (user == null) return Container();
        return SmartRefresher(
          controller: _refreshController,
          onRefresh: () => _onRefresh(user),
          onLoading: _onLoading,
          child: ref.watch(reportsProvider(user)).when(data: (reports) {
            if (reports == null || reports.isEmpty) {
              return const Center(
                  child: Text(
                "No reports yet",
                style: TextStyle(color: Colors.grey),
              ));
            }
            return ListView.builder(
              itemCount: reports.length,
              itemBuilder: (context, index) {
                return ReportCard(report: reports[index]);
              },
            );
          }, error: (error, st) {
            return const Center(
                child: Text(
              "Faild to load reports please refresh the app.",
              style: TextStyle(color: Colors.grey),
            ));
          }, loading: () {
            return ListView(
              children: [
                ReportCardShimmer(),
                const SizedBox(height: 4),
                ReportCardShimmer(),
                const SizedBox(height: 4),
                ReportCardShimmer(),
                const SizedBox(height: 4),
                ReportCardShimmer(),
              ],
            );
          }),
        );
      }, error: (error, st) {
        return const Center(
            child: Text(
          "Faild to load reports please refresh the app.",
          style: TextStyle(color: Colors.grey),
        ));
      }, loading: () {
        return Container();
      }),
    );
  }
}
