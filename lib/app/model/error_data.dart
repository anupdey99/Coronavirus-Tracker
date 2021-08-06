import 'package:json_annotation/json_annotation.dart';
import 'error.dart';

part 'error_data.g.dart';

@JsonSerializable()
class ErrorDate {
  @JsonKey(name: 'error')
  Error error = Error();

  ErrorDate();

  factory ErrorDate.fromJson(Map<String, dynamic> json) =>
      _$ErrorDateFromJson(json);
  Map<String, dynamic> toJson() => _$ErrorDateToJson(this);
}
