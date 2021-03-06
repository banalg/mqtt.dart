library mqtt_io_ws;

import 'dart:io';
import 'dart:async';
import 'mqtt_shared.dart';

class MqttConnectionIOWebSocket extends VirtualMqttConnection {
  final String _url;
  WebSocket _ws;

  MqttConnectionIOWebSocket.setOptions(this._url);

  Future connect({Iterable<String> protocols, Map<String, dynamic> headers, CompressionOptions compression}) {
    print("[WebSocket] Connecting to $_url");
    return WebSocket.connect(_url, protocols:protocols, headers:headers);
    return WebSocket.connect(_url, protocols:protocols, headers:headers, compression:compression == null ? CompressionOptions.DEFAULT:compression);
  }

  handleConnectError(e) {
    print("Error: $e");
  }

  privateSendMessageToBroker(MqttMessage m) {
    _ws.add(m.buf);
  }

  setConnection(cnx) {
    _ws = cnx;
  }

  startListening(_processData(Uint8List), _handleDone, _handleError) {
    //ToDo uniform here _processData with html_websocket and io_socket
    _ws.listen((data) => _processData(data),
        onDone: () => _handleDone(), onError: (e) => _handleError(e));
  }

  close() {
    _ws.close();
  }
}
