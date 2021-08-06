import 'package:json_annotation/json_annotation.dart';

part 'case_data.g.dart';

@JsonSerializable()
class CaseData {
  @JsonKey(name: "cases", defaultValue: 0)
  int cases = 0;
  @JsonKey(name: "data", defaultValue: 0)
  int data = 0;
  @JsonKey(name: "date", defaultValue: '')
  String? date = "";

  CaseData({this.cases = 0, this.data = 0, this.date});

  factory CaseData.fromJson(Map<String, dynamic> json) =>
      _$CaseDataFromJson(json);
  Map<String, dynamic> toJson() => _$CaseDataToJson(this);

  @override
  String toString() {
    return 'data: $data date: $date';
  }
}
