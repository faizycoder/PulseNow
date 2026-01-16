class MarketData {
  final String symbol;
  final String description;
  final double price;
  final double change24h;
  final double changePercent24h;
  final double volume;
  final double high24h;
  final double low24h;
  final double marketCap;
  final DateTime lastUpdated;

  MarketData({
    required this.symbol,
    required this.description,
    required this.price,
    required this.change24h,
    required this.changePercent24h,
    required this.volume,
    required this.high24h,
    required this.low24h,
    required this.marketCap,
    required this.lastUpdated,
  });

  factory MarketData.fromJson(Map<String, dynamic> json) {
    return MarketData(
      symbol: json['symbol'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0,
      change24h: (json['change24h'] as num?)?.toDouble() ?? 0,
      changePercent24h:
      (json['changePercent24h'] as num?)?.toDouble() ?? 0,
      volume: (json['volume'] as num?)?.toDouble() ?? 0,
      high24h: (json['high24h'] as num?)?.toDouble() ?? 0,
      low24h: (json['low24h'] as num?)?.toDouble() ?? 0,
      marketCap: (json['marketCap'] as num?)?.toDouble() ?? 0,
      lastUpdated: DateTime.tryParse(json['lastUpdated'] ?? '') ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'description': description,
      'price': price,
      'change24h': change24h,
      'changePercent24h': changePercent24h,
      'volume': volume,
      'high24h': high24h,
      'low24h': low24h,
      'marketCap': marketCap,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }
  MarketData copyWith({
    String? symbol,
    String? description,
    double? price,
    double? change24h,
    double? changePercent24h,
    double? volume,
    double? high24h,
    double? low24h,
    double? marketCap,
    DateTime? lastUpdated,
  }) {
    return MarketData(
      symbol: symbol ?? this.symbol,
      description: description ?? this.description,
      price: price ?? this.price,
      change24h: change24h ?? this.change24h,
      changePercent24h: changePercent24h ?? this.changePercent24h,
      volume: volume ?? this.volume,
      high24h: high24h ?? this.high24h,
      low24h: low24h ?? this.low24h,
      marketCap: marketCap ?? this.marketCap,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}
