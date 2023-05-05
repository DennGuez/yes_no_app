import 'package:flutter/material.dart';
import 'package:yes_no_app/config/helpers/get_yes_no_answer.dart';
import 'package:yes_no_app/domain/entities/message.dart';

/* ChangeNotifier nos dice basicamente esta clase puede notificar */
class ChatProvider extends ChangeNotifier {
  final ScrollController chatScrollController = ScrollController();
  final GetYesNoAnswer getYesNoAnswer = GetYesNoAnswer();

  List<Message> messageList = [
    Message(text: 'Hola my love', fromWho: FromWho.me),
    Message(text: 'Ya regresaste del trabajo?', fromWho: FromWho.me)
  ];

  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return; // Validamos si el texto esta vacio

    final newMessage = Message(text: text, fromWho: FromWho.me);
    messageList.add(newMessage);

    if (text.endsWith('?')) {
      herReply();
    }

    notifyListeners(); // Notificamos a todos lo que estan escuchando que algo del provider cambio
    moveScrollToBottom(); // Hacemos que los ultimos mensajes siempre se vean scrolleando hacia abajo
  }

  Future<void> herReply() async {
    final herMessage = await getYesNoAnswer.getAnswer();
    messageList.add(herMessage);
    notifyListeners(); // Notificamos a todos lo que estan escuchando que algo del provider cambio
    moveScrollToBottom(); // Hacemos que los ultimos mensajes siempre se vean scrolleando hacia abajo
  }

  // void moveScrollToBottom() {
  //   chatScrollController.animateTo(
  //       chatScrollController.position.maxScrollExtent,
  //       duration: const Duration(milliseconds: 300),
  //       curve: Curves.easeOut);
  // }

  /* Para que la animacion tarde un poco mas */
  Future<void> moveScrollToBottom() async {
    await Future.delayed(const Duration(milliseconds: 100));

    chatScrollController.animateTo(
        chatScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut);
  }
}
