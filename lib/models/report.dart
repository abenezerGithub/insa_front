// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import 'package:insa_report/models/attachments.dart';

class Report {
  final int id;
  final String report_type;
  final String report_description;
  final bool is_resolved;
  final String location_url;
  final bool seen;
  final DateTime? date_of_crime;
  final DateTime date_reported;
  final List<Attachment>? attachments;
  Report({
    required this.id,
    required this.report_type,
    required this.report_description,
    required this.is_resolved,
    required this.location_url,
    required this.seen,
    this.date_of_crime,
    required this.date_reported,
    this.attachments,
  });

  Report copyWith({
    int? id,
    String? report_type,
    String? report_description,
    bool? is_resolved,
    String? location_url,
    bool? seen,
    DateTime? date_of_crime,
    DateTime? date_reported,
    List<Attachment>? attachments,
  }) {
    return Report(
      id:id ?? this.id,
      report_type: report_type ?? this.report_type,
      report_description: report_description ?? this.report_description,
      is_resolved: is_resolved ?? this.is_resolved,
      location_url: location_url ?? this.location_url,
      seen: seen ?? this.seen,
      date_of_crime: date_of_crime ?? this.date_of_crime,
      date_reported: date_reported ?? this.date_reported,
      attachments: attachments ?? this.attachments,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id':id,
      'report_type': report_type,
      'report_description': report_description,
      'is_resolved': is_resolved,
      'location_url': location_url,
      'seen': seen,
      'date_of_crime': date_of_crime?.toIso8601String(),
      'date_reported': date_reported.toIso8601String(),
      'attachments': attachments?.map((x) => x.toMap()).toList(),
    };
  }

  factory Report.fromMap(Map<String, dynamic> map) {
    return Report(
      id: map['id'] as int,
      report_type: map['report_type'] as String,
      report_description: map['report_description'] as String,
      is_resolved: map['is_resolved'] as bool,
      location_url: map['location_url'] as String,
      seen: map['seen'] as bool,
      date_of_crime: map['date_of_crime'] == null
          ? null
          : DateTime.parse(map['date_of_crime'] as String),
      date_reported: DateTime.parse(map['date_reported'] as String),
      attachments: map['attachments'] != null
          ? List<Attachment>.from(
              (map['attachments'] as List<dynamic>).map<Attachment?>(
                (x) => Attachment.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Report.fromJson(String source) =>
      Report.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Report(id: $id, report_type: $report_type, report_description: $report_description, is_resolved: $is_resolved, location_url: $location_url, seen: $seen, date_of_crime: $date_of_crime, date_reported: $date_reported, attachments: $attachments)';
  }

  @override
  bool operator ==(covariant Report other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.id == id && 
        other.report_type == report_type &&
        other.report_description == report_description &&
        other.is_resolved == is_resolved &&
        other.location_url == location_url &&
        other.seen == seen &&
        other.date_of_crime == date_of_crime &&
        other.date_reported == date_reported &&
        listEquals(other.attachments, attachments);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        report_type.hashCode ^
        report_description.hashCode ^
        is_resolved.hashCode ^
        location_url.hashCode ^
        seen.hashCode ^
        date_of_crime.hashCode ^
        date_reported.hashCode ^
        attachments.hashCode;
  }
}
