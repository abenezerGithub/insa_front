import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insa_report/models/report.dart';
import 'package:insa_report/models/user.dart';
import 'package:insa_report/providers/report_detail_provider.dart';
import 'package:insa_report/providers/user_provider.dart';

class ReportDetailScreen extends StatefulWidget {
  const ReportDetailScreen({super.key});

  @override
  _ReportDetailScreenState createState() => _ReportDetailScreenState();
}

class _ReportDetailScreenState extends State<ReportDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Report Detail',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: "Poppins",
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Consumer(
                builder: (context, ref, _) {
                  final object =
                      ModalRoute.of(context)!.settings?.arguments ?? Object();
                  final int id = object is Map ? object['id'] : -1;
                  final reportAsyncValue = ref.watch(reportProvider(id));

                  return ref.watch(userProvider).when(
                    data: (user) {
                      if (user == null) return Container();
                      return reportAsyncValue.when(
                        data: (report) {
                          if (report == null) {
                            return const Text("No report found");
                          }
                          return ReportDetailView(report: report, user: user);
                        },
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        error: (error, stack) => Text("Error: $error"),
                      );
                    },
                    loading: () {
                      return const Center(child: CircularProgressIndicator());
                    },
                    error: (error, stack) {
                      return Text("Error: $error");
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ReportDetailView extends StatelessWidget {
  final Report report;
  final User user;

  const ReportDetailView({
    super.key,
    required this.report,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      children: [
        _ReportDetailItems(
          icon: Icons.assignment,
          label: 'Report Type',
          value: report.report_type,
        ),
        _ReportDetailItems(
          icon: Icons.description,
          label: 'Description',
          value: report.report_description,
        ),
        _ReportDetailItems(
          icon: Icons.done,
          label: 'Resolved',
          value: report.is_resolved ? 'Yes' : 'No',
        ),
        _ReportDetailItems(
          icon: Icons.date_range,
          label: 'Date Reported',
          value: report.date_reported.toString(),
        ),
        if (report.date_of_crime != null)
          _ReportDetailItems(
            icon: Icons.calendar_today,
            label: 'Date of Crime',
            value: report.date_of_crime!.toString(),
          ),
        _ReportDetailItems(
          icon: Icons.location_on,
          label: 'Location',
          value: report.location_url,
        ),
        _ReportDetailItems(
          icon: Icons.visibility,
          label: 'Seen',
          value: report.seen ? 'Yes' : 'No',
        ),
        const SizedBox(height: 16),
        if (report.attachments != null && report.attachments!.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Icon(
                  Icons.attachment_outlined,
                  color: Theme.of(context).colorScheme.primary.withOpacity(.77),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'Attachments:',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(.77)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: report.attachments!
                .map((attachment) => GestureDetector(
                      onTap: () {
                        // Handle onTap event here
                        // Example: open larger view
                      },
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: Image.network(
                          attachment.image,
                          headers: {"Authorization": "Bearer ${user.token}"},
                          fit: BoxFit.cover,
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ],
    );
  }
}

class _ReportDetailItems extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _ReportDetailItems({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon,
                color: Theme.of(context).colorScheme.primary.withOpacity(.77)),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
