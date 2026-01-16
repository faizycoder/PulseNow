import 'dart:convert';

import 'package:flutter/foundation.dart';
import '../services/api_service.dart';
import '../models/market_data_model.dart';
import '../services/websocket_service.dart';
import 'dart:async';

class MarketDataProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  final WebSocketService _socketService = WebSocketService();
  StreamSubscription? _socketSubscription;

  final List<MarketData> _marketData = [];
  List<MarketData> _filteredData = [];
  bool _isLoading = false;
  String? _error;
  String _searchQuery = '';

  List<MarketData> get marketData =>
      _searchQuery.isEmpty ? _marketData : _filteredData;

  bool get isLoading => _isLoading;

  String? get error => _error;

  Future<void> loadMarketData() async {
    _isLoading = true;
    _error = null;
    try {

      //calling data from api service
      final data = await _apiService.getMarketData();
      _marketData
        ..clear()
        ..addAll(data.map((json) => MarketData.fromJson(json)).toList());
      //applying Search
      _applySearch();
      // starting Socket
      _startSocket();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _startSocket() {
    _socketSubscription?.cancel();

    _socketSubscription = _socketService.connect().listen(
      (event) {
        final json = jsonDecode(event);

        if (json['type'] == 'market_update') {
          final data = json['data'];
          _handleLiveUpdate(data);
        }
      },
      onError: (e) {
        if (kDebugMode) {
          print("Socket error: $e");
        }
        _reconnect();
      },
      onDone: () {
        if (kDebugMode) {
          print("Socket disconnected");
        }
        _reconnect();
      },
    );
  }

  String normalizeSymbol(String value) {
    return value.replaceAll('/', '').toUpperCase().trim();
  }

  void _handleLiveUpdate(Map<String, dynamic> json) {
    try {
      final String? symbol = json['symbol'];

      final double? price = double.tryParse(json['price']?.toString() ?? '');

      final double? change24h = double.tryParse(
        json['change24h']?.toString() ?? '',
      );

      final double? volume = double.tryParse(json['volume']?.toString() ?? '');

      final DateTime? timestamp = DateTime.tryParse(
        json['timestamp']?.toString() ?? '',
      );

      if (symbol == null || price == null) return;

      final socketSymbol = normalizeSymbol(symbol);

      final int index = _marketData.indexWhere((e) {
        return normalizeSymbol(e.symbol) == socketSymbol;
      });

      if (index == -1) {
        print("No match found for $symbol");
        return;
      }

      final old = _marketData[index];

      _marketData[index] = old.copyWith(
        price: price,
        changePercent24h: change24h ?? old.changePercent24h,
        volume: volume ?? old.volume,
        lastUpdated: timestamp ?? DateTime.now(),
      );

      _applySearch();
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print("Live update parse error: $e");
      }
    }
  }

  @override
  void dispose() {
    _socketSubscription?.cancel();
    _socketService.disconnect();
    super.dispose();
  }

  void _reconnect() {
    Future.delayed(const Duration(seconds: 3), _startSocket);
  }

  void search(String value) {
    _searchQuery = value.trim().toLowerCase();
    _applySearch();
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    _filteredData.clear();
    notifyListeners();
  }

  void _applySearch() {
    if (_searchQuery.isEmpty) {
      _filteredData.clear();
    } else {
      _filteredData = _marketData.where((item) {
        return item.symbol.toLowerCase().contains(_searchQuery);
      }).toList();
    }
  }
}
