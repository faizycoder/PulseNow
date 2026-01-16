import 'package:intl/intl.dart';

class Formatters {
  static final usd = NumberFormat.currency(
    locale: 'en_US',
    symbol: '\$',
    decimalDigits: 2,
  );

  static String formatPrice(double value) {
    return usd.format(value);
  }
  static String formatCompact(double value) {
    if (value >= 1e9) return "\$${(value / 1e9).toStringAsFixed(1)}B";
    if (value >= 1e6) return "\$${(value / 1e6).toStringAsFixed(1)}M";
    return "\$${value.toStringAsFixed(0)}";
  }

  static String formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}