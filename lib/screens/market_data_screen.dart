import 'package:assessment/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/market_data_model.dart';
import '../providers/market_data_provider.dart';
import '../utils/formatters.dart';
import 'market_data_details_screen.dart';

class MarketDataScreen extends StatefulWidget {
  const MarketDataScreen({super.key});

  @override
  State<MarketDataScreen> createState() => _MarketDataScreenState();
}

class _MarketDataScreenState extends State<MarketDataScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<MarketDataProvider>(context, listen: false).loadMarketData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MarketDataProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (provider.error != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error: ${provider.error}'),
                ElevatedButton(
                  onPressed: () => provider.loadMarketData(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                controller: _searchController,
                onChanged: provider.search,
                decoration: InputDecoration(
                  hintText: 'Search coin (BTC, ETH...)',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            provider.clearSearch();
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            (provider.marketData.isEmpty)
                ? Center(child: Text("No data found."))
                : Expanded(
                    child: RefreshIndicator(
                      onRefresh: _onRefresh,
                      child: ListView.builder(
                        itemExtent: 100,
                        itemCount: provider.marketData.length,
                        itemBuilder: (context, int index) {
                          return _dataCard(provider.marketData[index]);
                        },
                      ),
                    ),
                  ),
          ],
        );
      },
    );
  }

  Widget _dataCard(MarketData data) {
    return Card(
      elevation: 0,
      margin: .fromLTRB(10, 5, 10, 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => MarketDataDetailsScreen(data: data),
            ),
          );
        },
        child: Padding(
          padding: .fromLTRB(10, 10, 10, 10),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data.symbol,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      Formatters.formatPrice(data.price),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "${data.changePercent24h.toStringAsFixed(2)} %",
                      style: TextStyle(
                        color: isPositive(data.changePercent24h)
                            ? Color(AppConstants.positiveColor)
                            : Color(AppConstants.negativeColor),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_outlined),
            ],
          ),
        ),
      ),
    );
  }

  //check if the value is positive or negative
  bool isPositive(double change24h) {
    if (change24h < 0) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> _onRefresh() async {
    Provider.of<MarketDataProvider>(context, listen: false).loadMarketData();
  }
}
