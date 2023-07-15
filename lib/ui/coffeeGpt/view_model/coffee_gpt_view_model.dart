import 'package:coffe_app/network/models/gpt/chat_model.dart';
import 'package:coffe_app/network/services/chat_gpt/chat_gpt_service.dart';
import 'package:coffe_app/ui/base/base_model.dart';

class CoffeGptViewModel extends BaseViewModel {
  ChatGptServices? chatGptServices;

  CoffeGptViewModel({this.chatGptServices});

  List<ChatModel> list = [];

  void addUserMessage({required String message}) {
    list.add(ChatModel(msg: message, chatIndex: 0));
    setBusy(false);
  }

  Future<void> sendMessage(String message) async {
    list.addAll(await chatGptServices!.sendMessageGPT(message: message));
    setBusy(false);
  }
}
