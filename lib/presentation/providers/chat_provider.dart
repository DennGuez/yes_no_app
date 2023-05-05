import 'package:flutter/material.dart';
import 'package:yes_no_app/domain/entities/message.dart';

/* ChangeNotifier nos dice basicamente esta clase puede notificar */
class ChatProvider extends ChangeNotifier {
  List<Message> messageList = [
    Message(text: 'Hola my love', fromWho: FromWho.me),
    Message(text: 'Ya regresaste del trabajo?', fromWho: FromWho.me)
  ];

  Future<void> sendMessage(String text) async {
    final newMessage = Message(text: text, fromWho: FromWho.me);
    messageList.add(newMessage);
    notifyListeners(); // Notificamos a todos lo que estan escuchando que algo del provider cambio
  }
}
