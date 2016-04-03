part of mqtt_shared;

abstract class VirtualMqttConnection {
  Future connect({Iterable<String> protocols, Map<String, dynamic> headers});
  handleConnectError(e);

  sendMessageToBroker(MqttMessage m, [bool debugMessage = false]) {
    m.encode();

    if (debugMessage) {
      print(">>> ${m.toString()}");
    }
    privateSendMessageToBroker(m);
  }

  privateSendMessageToBroker(m);
  setConnection(cnx);
  startListening(_processData(Uint8List), _handleDone, _handleError);
  close();
}
