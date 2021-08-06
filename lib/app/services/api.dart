import './../../app/services/api_keys.dart';

enum Endpoint { cases, casesSuspected, casesConfirmed, deaths, recovered }

class API {
  API({required this.apiKey});
  final String apiKey;

  factory API.sandbox() => API(apiKey: APIKeys.ncovSandboxKey);

  Uri tokenUri() => Uri(
      scheme: APIKeys.scheme,
      host: APIKeys.host,
      port: APIKeys.post,
      path: 'token',
      queryParameters: {'grant_type': 'client_credentials'});

  static Map<Endpoint, String> _paths = {
    Endpoint.cases: 'cases',
    Endpoint.casesSuspected: 'casesSuspected',
    Endpoint.casesConfirmed: 'casesConfirmed',
    Endpoint.deaths: 'deaths',
    Endpoint.recovered: 'recovered',
  };

  Uri endpointUri(Endpoint endpoint) => Uri(
        scheme: APIKeys.scheme,
        host: APIKeys.host,
        path: _paths[endpoint],
      );
}
