import 'package:coronavirus_tracker/app/model/case_data.dart';
import 'package:coronavirus_tracker/app/model/covid_data.dart';
import 'package:coronavirus_tracker/app/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataCacheService {
  DataCacheService({required this.preferences});
  final SharedPreferences preferences;

  static String valueKey(Endpoint endPoint) => '$endPoint/value';
  static String dateKey(Endpoint endPoint) => '$endPoint/date';

  Future<void> setData(CovidData data) async {
    data.values.forEach((endpoint, covidData) async {
      await preferences.setInt(valueKey(endpoint), covidData.data);
      await preferences.setString(dateKey(endpoint), covidData.date ?? '');
    });
  }

  CovidData getData() {
    final Map<Endpoint, CaseData> values = {};
    Endpoint.values.forEach((endpoint) {
      int? data = preferences.getInt(valueKey(endpoint));
      String? date = preferences.getString(dateKey(endpoint));
      values[endpoint] = CaseData(cases: 0, data: data ?? 0, date: date);
    });

    return CovidData(values: values);
  }
}
