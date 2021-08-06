import 'package:coronavirus_tracker/app/services/api.dart';

import 'case_data.dart';

class CovidData {
  CovidData({required this.values});
  final Map<Endpoint, CaseData> values;

  CaseData get cases => values[Endpoint.cases]!;
  CaseData get suspected => values[Endpoint.casesSuspected]!;
  CaseData get confirmed => values[Endpoint.casesConfirmed]!;
  CaseData get deaths => values[Endpoint.deaths]!;
  CaseData get recovered => values[Endpoint.recovered]!;

  @override
  String toString() {
    return 'Cases: ${cases.toString()}, suspected: ${suspected.toString()}, confirmed: ${confirmed.toString()} deaths: ${deaths.toString()} recovered: ${recovered.toString()}';
  }
}
