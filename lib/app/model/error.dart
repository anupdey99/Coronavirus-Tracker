import 'package:json_annotation/json_annotation.dart';

part 'error.g.dart';

@JsonSerializable()
class Error {
  @JsonKey(name: 'code')
  int code = 0;
  @JsonKey(name: 'message')
  String message = '';
  @JsonKey(name: 'description')
  String description = '';

  Error();

  factory Error.fromJson(Map<String, dynamic> json) => _$ErrorFromJson(json);
  Map<String, dynamic> toJson() => _$ErrorToJson(this);
}
