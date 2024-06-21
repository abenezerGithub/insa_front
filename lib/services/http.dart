import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:insa_report/models/report.dart';
import 'package:insa_report/models/user.dart';

class HTTPServices {
  static String baseUrl = "https://insa.freedom-learn.com/";
  // static http = http()
  static String fullUrl(String path) {
    return baseUrl + path;
  }

  static Future<http.Response> get({required String path}) async {
    final uri = Uri.parse(fullUrl(path));
    final response =
        http.get(uri).timeout(const Duration(seconds: 10), onTimeout: () {
      throw TimeoutException('The connection has timed out, Please try again!');
    });
    return response;
  }

  static Future<http.Response> post(
      {required String path, required Map<String, dynamic> data}) async {
    final uri = Uri.parse(fullUrl(path));
    final response = await http
        .post(uri, body: data)
        .timeout(const Duration(seconds: 10), onTimeout: () {
      throw TimeoutException('The connection has timed out, Please try again!');
    });

    return response;
  }

  static Future<http.Response> authGet(
      {required String path, required String token}) async {
    final uri = Uri.parse(fullUrl(path));
    final response = await http
        .get(uri, headers: {"Authorization": "Bearer $token"}).timeout(
            const Duration(seconds: 10), onTimeout: () {
      throw TimeoutException('The connection has timed out, Please try again!');
    });
    return response;
  }

  static Future<http.StreamedResponse> submitReport(
      {required Report report, required String path, required User user}) {
    final uri = Uri.parse(fullUrl(path));
    var request = http.MultipartRequest('POST', uri);
    request.headers['Authorization'] = 'Bearer ${user.token}';
    request.fields['report_type'] = report.report_type;
    request.fields['report_description'] = report.report_description;
    request.fields["location_url"] = report.location_url;

    if (report.date_of_crime != null) {
      request.fields["date_of_crime"] = report.date_of_crime.toString();
    }
    if (report.attachments != null) {
      for (var attachment in report.attachments ?? []) {
        final file = File(attachment.image);
        request.files.add(http.MultipartFile.fromBytes(
            'attachment', file.readAsBytesSync(),
            filename: attachment.image));
      }
    }

    return request.send().timeout(const Duration(seconds: 15), onTimeout: () {
      throw TimeoutException('The connection has timed out, Please try again!');
    });
  }
}
