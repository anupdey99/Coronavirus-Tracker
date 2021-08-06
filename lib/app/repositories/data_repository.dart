import 'package:coronavirus_tracker/app/model/case_data.dart';
import 'package:coronavirus_tracker/app/model/covid_data.dart';
import 'package:coronavirus_tracker/app/services/api.dart';
import 'package:coronavirus_tracker/app/services/api_keys.dart';
import 'package:coronavirus_tracker/app/services/api_service.dart';
import 'package:coronavirus_tracker/app/services/data_cache_service.dart';
import 'package:http/http.dart' as http;

class DataRepository {
  DataRepository({required this.apiService, required this.dataCacheService});
  final APIService apiService;
  final DataCacheService dataCacheService;

  Future<CaseData> getEndpointData(Endpoint endpoint) async {
    try {
      CaseData data =
          await apiService.getEndpointData(APIKeys.accessToken, endpoint);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<CovidData> getAllEndpointData() async {
    try {
      final values = await Future.wait([
        apiService.getEndpointData(APIKeys.accessToken, Endpoint.cases),
        apiService.getEndpointData(
            APIKeys.accessToken, Endpoint.casesSuspected),
        apiService.getEndpointData(
            APIKeys.accessToken, Endpoint.casesConfirmed),
        apiService.getEndpointData(APIKeys.accessToken, Endpoint.deaths),
        apiService.getEndpointData(APIKeys.accessToken, Endpoint.recovered),
      ]);

      final data = CovidData(values: {
        Endpoint.cases: values[0],
        Endpoint.casesSuspected: values[1],
        Endpoint.casesConfirmed: values[2],
        Endpoint.deaths: values[3],
        Endpoint.recovered: values[4],
      });

      await dataCacheService.setData(data);

      return data;
    } on http.Response catch (response) {
      if (response.statusCode == 401) {
        return getAllEndpointCachedData();
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  CovidData getAllEndpointCachedData() {
    return dataCacheService.getData();
  }
}
