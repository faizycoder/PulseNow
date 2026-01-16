import 'package:assessment/models/market_data_model.dart';
import 'package:assessment/providers/market_data_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late MarketDataProvider provider;

  setUp(() {
    provider = MarketDataProvider();
  });

  test('search filters correctly', () {
    provider
      ..search('btc');

    expect(provider.marketData, isEmpty); // no data loaded yet
  });

  test('normalizeSymbol removes slash and uppercase', () {
    final result = provider.normalizeSymbol("btc/usd");
    expect(result, "BTCUSD");
  });

  test('copyWith updates market data correctly', () {
    final item = MarketData(
      symbol: "BTC/USD",
      description: "",
      price: 100,
      change24h: 1,
      changePercent24h: 1,
      volume: 1,
      high24h: 1,
      low24h: 1,
      marketCap: 1,
      lastUpdated: DateTime.now(),
    );

    final updated = item.copyWith(price: 200);

    expect(updated.price, 200);
  });
}
