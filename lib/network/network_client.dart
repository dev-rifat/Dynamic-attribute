import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/api_endpoints.dart';

String _getRequestUrl(String apiEndPoint) => Api.baseUrl + apiEndPoint;

class NetworkClient {
  final Map<String, String> _headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };

  Future<http.Response> getRequest(String apiEndPoint) async {
    return await http
        .get(
          Uri.parse(_getRequestUrl(apiEndPoint)),
          headers: _headers,
        )
        .timeout(const Duration(seconds: 15));
  }

  Future<http.Response> postRequest(String apiEndPoint, dynamic body) async {
    return await http
        .post(
          Uri.parse(_getRequestUrl(apiEndPoint)),
          headers: _headers,
          body: jsonEncode(body),
        )
        .timeout(const Duration(seconds: 15));
  }
}
