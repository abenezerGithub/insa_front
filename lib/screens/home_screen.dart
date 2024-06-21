import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insa_report/providers/reports_provider.dart';
import 'package:insa_report/screens/profile_screen.dart';
import 'package:insa_report/screens/reports_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenScreenState();
}

class _HomeScreenScreenState extends ConsumerState<HomeScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  int _page = 0;
  List<Widget> pages = [ReportsScreen(), ProfileScreen()];

  void _onRefresh() async {
    // monitor network fetch
    // if failed,use refreshFailed()
    ref.invalidate(reportsProvider);
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
      appBar: AppBar(
        title: Text(
          _page == 0 ? "Your Reports" : "User Profile",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: "Poppins",
          ),
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        buttonBackgroundColor:
            Theme.of(context).colorScheme.primary.withOpacity(.77),
        color: Theme.of(context).colorScheme.primary.withOpacity(.77),
        animationDuration: const Duration(milliseconds: 300),
        height: 60,
        items: const <Widget>[
          Icon(Icons.article_outlined, size: 25, color: Colors.white),
          Icon(Icons.person_outlined, size: 25, color: Colors.white),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      body: pages[_page],

      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(.77),
        onPressed: () async {
          Navigator.of(context).pushNamed("/report-screen");
        },
        label: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.add,
              color: Colors.white,
            ),
            SizedBox(
              width: 5,
            ),
            Text("Submit Report")
          ],
        ),
      ),
    );
  }
}
