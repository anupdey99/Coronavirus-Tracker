// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'case_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CaseData _$CaseDataFromJson(Map<String, dynamic> json) {
  return CaseData(
    cases: json['cases'] as int? ?? 0,
    data: json['data'] as int? ?? 0,
    date: json['date'] as String? ?? '',
  );
}

Map<String, dynamic> _$CaseDataToJson(CaseData instance) => <String, dynamic>{
      'cases': instance.cases,
      'data': instance.data,
      'date': instance.date,
    };
