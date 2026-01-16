import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import 'market_data_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PulseNow',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          PopupMenuButton<ThemeMode>(
            icon: const Icon(Icons.dark_mode_outlined),
            onSelected: theme.setTheme,
            itemBuilder: (_) => const [
              PopupMenuItem(
                value: ThemeMode.system,
                child: Text("System"),
              ),
              PopupMenuItem(
                value: ThemeMode.light,
                child: Text("Light"),
              ),
              PopupMenuItem(
                value: ThemeMode.dark,
                child: Text("Dark"),
              ),
            ],
          ),
        ],
      ),
      body: const MarketDataScreen(),
    );
  }
}
