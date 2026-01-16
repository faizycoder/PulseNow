import 'package:flutter_test/flutter_test.dart';
import 'package:assessment/models/market_data_model.dart';

void main() {
  test('MarketData.fromJson parses correctly', () {
    final json = {
      "symbol": "BTC/USD",
      "description": "Bitcoin",
      "price": 50000,
      "change24h": 10,
      "changePercent24h": 2.5,
      "volume": 1000000,
      "high24h": 52000,
      "low24h": 48000,
      "marketCap": 900000000,
      "lastUpdated": "2026-01-16T10:00:00Z"
    };

    final data = MarketData.fromJson(json);

    expect(data.symbol, "BTC/USD");
    expect(data.price, 50000);
    expect(data.changePercent24h, 2.5);
    expect(data.lastUpdated.year, 2026);
  });

  test('copyWith updates selected fields only', () {
    final original = MarketData(
      symbol: "BTC",
      description: "",
      price: 10,
      change24h: 1,
      changePercent24h: 2,
      volume: 5,
      high24h: 20,
      low24h: 5,
      marketCap: 100,
      lastUpdated: DateTime.now(),
    );

    final updated = original.copyWith(price: 99);

    expect(updated.price, 99);
    expect(updated.symbol, "BTC");
  });
}
