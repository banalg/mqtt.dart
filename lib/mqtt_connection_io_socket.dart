library mqtt_io;

import 'dart:io';
import 'dart:async';
import 'mqtt_shared.dart';

class MqttConnectionIOSocket extends VirtualMqttConnection {
  final String _host;
  final num _port;
  Socket _socket;

  MqttConnectionIOSocket.setOptions({String host: "127.0.0.1", num port: 1883})
      : _host = host,
        _port = port;
  Future connect({Iterable<String> protocols, Map<String, dynamic> headers, CompressionOptions compression}) {
    return Socket.connect(_host, _port);
  }

  handleConnectError(e) {
    print("Error: $e");
    test: (e) => e is SocketException;
  }

  privateSendMessageToBroker(MqttMessage m) {
    _socket.add(m.buf);
  }

  setConnection(cnx) {
    _socket = cnx;
  }

  startListening(_processData(Uint8List), _handleDone, _handleError) {
    //ToDo uniform here _processData with io_websocket and html_websocket
    _socket.listen((data) => _processData(data),
        onDone: () => _handleDone(), onError: (e) => _handleError(e));
  }

  close() {
    _socket.close();
  }
}
