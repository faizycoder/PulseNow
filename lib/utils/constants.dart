// App-wide constants
class AppConstants {
  // API Configuration

  // For iOS simulator :
 // static const String baseUrl = 'http://localhost:3000/api';
 // static const String wsUrl = 'ws://localhost:3000';
  
  // For Android emulator:
   static const String baseUrl = 'http://10.0.2.2:3000/api';
   static const String wsUrl = 'ws://10.0.2.2:3000';
  
  // API Endpoints
  static const String marketDataEndpoint = '/market-data';

  // Colors
  static const int positiveColor = 0xFF4CAF50; // Green
  static const int negativeColor = 0xFFF44336; // Red
}
