import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import './../../app/services/api_keys.dart';
import './../../app/services/api.dart';
import './../../app/model/case_data.dart';
import './../../app/model/error_data.dart';

class APIService {
  APIService(this.api) {
    _dio = Dio(BaseOptions(
      baseUrl: APIKeys.baseUrl,
    ));
    //_dio.interceptors.add(AppInterceptors());
    _dio.interceptors.add(_interceptors);
  }
  final API api;
  late Dio _dio;
  static Map<Endpoint, String> _responseJsonKeys = {
    Endpoint.cases: 'cases',
    Endpoint.casesSuspected: 'data',
    Endpoint.casesConfirmed: 'data',
    Endpoint.deaths: 'data',
    Endpoint.recovered: 'data',
  };
  static Map<Endpoint, String> _paths = {
    Endpoint.cases: 'cases',
    Endpoint.casesSuspected: 'casesSuspected',
    Endpoint.casesConfirmed: 'casesConfirmed',
    Endpoint.deaths: 'deaths',
    Endpoint.recovered: 'recovered',
  };

  // Endpoint requests

  Future<String> getAccessToken() async {
    final response = await http.post(api.tokenUri(),
        headers: {'Authorization': 'Basic ${api.apiKey}'});
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final accessToken = data['access_token'];
      if (accessToken != null) {
        return accessToken;
      }
    }
    print(
        'Request ${api.tokenUri().toString()} failed\nResponse: ${response.statusCode} ${response.reasonPhrase}');
    throw response;
  }

  Future<CaseData> getEndpointData(
      String accessToken, Endpoint endpoint) async {
    final uri = api.endpointUri(endpoint);
    final response = await http.get(
      uri,
      headers: {'Authorization': 'Bearer $accessToken'},
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        final Map<String, dynamic> endpointData = data[0];
        final String? responseJsonKey = _responseJsonKeys[endpoint];
        final int? result = endpointData[responseJsonKey];
        final String dateString = endpointData['date'];
        if (result != null) {
          return CaseData(cases: 0, data: result, date: dateString);
        }
      }
    }
    print(
        'Request ${uri.toString()} failed\nResponse: ${response.statusCode} ${response.reasonPhrase}');
    throw response;
  }

  Future<int> getEndpointDataWithDio(Endpoint endpoint) async {
    try {
      final response = await _dio.get('/${_paths[endpoint]!}');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        if (data.isNotEmpty) {
          CaseData model = CaseData.fromJson(data[0]);
          if (endpoint == Endpoint.cases) {
            return model.cases;
          } else {
            return model.data;
          }
        } else {
          throw Exception('No data found');
        }
      } else {
        ErrorDate errorData = ErrorDate.fromJson(response.data);
        throw Exception('${errorData.error.message}');
      }
    } on DioError catch (e) {
      print("${e.message}");
      throw Exception(e.message);
    }
  }

  // InterceptorsWrapper
  InterceptorsWrapper _interceptors = InterceptorsWrapper(
    onRequest: (request, handler) {
      // Add token
      request.headers['Authorization'] = 'Bearer ${APIKeys.accessToken}';
      print("${request.method} ${request.baseUrl}${request.path}");
      return handler.next(request);
    },
    onResponse: (response, handler) {
      print("${response.data}");
      return handler.next(response);
    },
    onError: (error, handler) {
      print("${error.message}");
      return handler.next(error);
    },
  );
}

class AppInterceptors extends InterceptorsWrapper {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    //Add token
    // if (APIKeys.accessToken.isEmpty) {
    //   String token = await getAccessToken();
    //   APIKeys.accessToken = token;
    //   options.headers['Authorization'] = 'Bearer $token';
    // }
    options.headers['Authorization'] = 'Bearer ${APIKeys.accessToken}';
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    super.onError(err, handler);
  }
}
