import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/market_data_model.dart';
import '../providers/market_data_provider.dart';
import '../utils/constants.dart';
import '../utils/formatters.dart';

class MarketDataDetailsScreen extends StatefulWidget {
  final MarketData data;

  const MarketDataDetailsScreen({super.key, required this.data});

  @override
  State<MarketDataDetailsScreen> createState() =>
      _MarketDataDetailsScreenState();
}

class _MarketDataDetailsScreenState extends State<MarketDataDetailsScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<MarketDataProvider>(context, listen: false).loadMarketData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.data.symbol,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: .fromLTRB(10, 10, 10, 10),
          child: Column(
            children: [
              _priceCard(widget.data),
              const SizedBox(height: 12),
              _statsGrid(widget.data),
              const SizedBox(height: 12),
              _descriptionCard(widget.data),
            ],
          ),
        ),
      ),
    );
  }
}

// 💰 Price Card
Widget _priceCard(MarketData data) {
  return Card(
    elevation: 1,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            Formatters.formatPrice(data.price),
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isPositive(data.changePercent24h)
                    ? Icons.trending_up
                    : Icons.trending_down,
                color: isPositive(data.changePercent24h)
                    ? Color(AppConstants.positiveColor)
                    : Color(AppConstants.negativeColor),
                size: 18,
              ),
              const SizedBox(width: 4),
              Text(
                "${data.changePercent24h.toStringAsFixed(2)}%",
                style: TextStyle(
                  color: isPositive(data.changePercent24h)
                      ? Color(AppConstants.positiveColor)
                      : Color(AppConstants.negativeColor),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                "(${data.change24h.toStringAsFixed(2)})",
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

// 📊 Stats Grid
Widget _statsGrid(MarketData data) {
  return GridView(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 2.4,
    ),
    children: [
      _statTile("High 24h", Formatters.formatPrice(data.high24h)),
      _statTile("Low 24h", Formatters.formatPrice(data.low24h)),
      _statTile("Volume", Formatters.formatCompact(data.volume)),
      _statTile("Market Cap", Formatters.formatCompact(data.marketCap)),
      _statTile("Last Updated", Formatters.formatDate(data.lastUpdated)),
    ],
  );
}

// 🧾 Description
Widget _descriptionCard(MarketData data) {
  return Card(
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "About",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(data.description, style: const TextStyle(height: 1.4)),
        ],
      ),
    ),
  );
}

// 🔹 Reusable Stat Tile
Widget _statTile(String label, String value) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: Colors.red.shade50,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    ),
  );
}

//checking value is positive or negative
bool isPositive(double change24h) {
  if (change24h < 0) {
    return false;
  } else {
    return true;
  }
}
