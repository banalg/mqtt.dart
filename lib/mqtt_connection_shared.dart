part of mqtt_shared;

abstract class VirtualMqttConnection {
  Future connect({Iterable<String> protocols});
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
  startListening(_processData, _handleDone, _handleError);
  close();
}
