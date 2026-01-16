import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class ApiService {
  final http.Client client;

  ApiService({http.Client? client}) : client = client ?? http.Client();

  Future<List<Map<String, dynamic>>> getMarketData() async {
    final response = await client.get(
      Uri.parse(AppConstants.baseUrl + AppConstants.marketDataEndpoint),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return List<Map<String, dynamic>>.from(jsonData['data']);
    } else {
      throw Exception('Failed to load market data: ${response.statusCode}');
    }
  }
}

