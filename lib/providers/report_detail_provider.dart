import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insa_report/models/report.dart';
import 'package:insa_report/providers/user_provider.dart';
import 'package:insa_report/services/http.dart';

final reportProvider = FutureProvider.family<Report?, int>((ref, id) async {
  final user = await ref.watch(userProvider.future);
  if (user == null) return null;
  final resp =
      await HTTPServices.authGet(path: "api/report/$id", token: user.token);
  final parsedReport = jsonDecode(resp.body)["report"];
  final report = Report.fromMap(parsedReport);

  return report;

  // Replace this with actual API call to fetch report detail by ID
  // For now, we'll return a sample report
});
