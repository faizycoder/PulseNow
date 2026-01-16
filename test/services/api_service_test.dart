import 'dart:convert';
import 'package:assessment/services/api_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late MockHttpClient client;
  late ApiService api;

  setUpAll(() {
    registerFallbackValue(Uri.parse('http://localhost'));
  });

  setUp(() {
    client = MockHttpClient();
    api = ApiService(client: client);
  });

  test('returns market data when API succeeds', () async {
    when(() => client.get(any<Uri>())).thenAnswer(
          (_) async => http.Response(
        jsonEncode({
          "data": [
            {"symbol": "BTC/USD", "price": 50000}
          ]
        }),
        200,
      ),
    );

    final result = await api.getMarketData();

    expect(result.length, 1);
    expect(result.first['symbol'], "BTC/USD");
  });

  test('throws exception when API fails', () async {
    when(() => client.get(any<Uri>()))
        .thenAnswer((_) async => http.Response("Error", 500));

    expect(() => api.getMarketData(), throwsException);
  });
}
