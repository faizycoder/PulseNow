import 'dart:async';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../utils/constants.dart';

class WebSocketService {
  WebSocketChannel? _channel;

  Stream<dynamic> connect() {
    _channel = WebSocketChannel.connect(Uri.parse(AppConstants.wsUrl));
    return _channel!.stream;
  }

  void disconnect() {
    _channel?.sink.close();
    _channel = null;
  }
}
