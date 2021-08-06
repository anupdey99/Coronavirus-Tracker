// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorDate _$ErrorDateFromJson(Map<String, dynamic> json) {
  return ErrorDate()
    ..error = Error.fromJson(json['error'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ErrorDateToJson(ErrorDate instance) => <String, dynamic>{
      'error': instance.error,
    };
