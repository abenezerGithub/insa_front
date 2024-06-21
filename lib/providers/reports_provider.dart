import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insa_report/models/report.dart';
import 'package:insa_report/models/user.dart';
import 'package:insa_report/services/http.dart';

final reportsProvider =
    FutureProvider.family<List<Report>?, User>((ref, user) async {
  final resp =
      await HTTPServices.authGet(path: "api/report/", token: user.token);
  final List<dynamic> reports = jsonDecode(resp.body)["reports"];
  // await Future.delayed(const Duration(seconds: 12));
  final reportsSerialized =
      reports.map((report) => Report.fromMap(report)).toList();
  return reportsSerialized;
});
