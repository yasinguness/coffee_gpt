import 'dart:developer';

import 'package:coffe_app/common/widgets/app_bar_widget.dart';
import 'package:coffe_app/common/widgets/chat_bubble_widget/message_bubble.dart';
import 'package:coffe_app/ui/base/base_view.dart';
import 'package:coffe_app/common/widgets/text_widget.dart';
import 'package:coffe_app/ui/coffeeGpt/view_model/coffee_gpt_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class ChatScreenView extends StatefulWidget {
  const ChatScreenView({super.key});

  @override
  State<ChatScreenView> createState() => _ChatScreenViewState();
}

class _ChatScreenViewState extends State<ChatScreenView> with SingleTickerProviderStateMixin {
  bool _isTyping = false;
  late TextEditingController textEditingController;
  late ScrollController scrollController;
  late FocusNode node;
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  @override
  @override
  void initState() {
    // TODO: implement initState
    textEditingController = TextEditingController();
    scrollController = ScrollController();
    node = FocusNode();
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    textEditingController.dispose();
    scrollController.dispose();
    node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<CoffeGptViewModel>(
      builder: (context, value, widget) => ScaleTransition(
        scale: scaleAnimation,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: const CustomAppBar(),
          body: SafeArea(
              child: Column(
            children: [
              _messageList(value),
              if (_isTyping) ...[
                const SpinKitThreeBounce(
                  color: Colors.black,
                  size: 18,
                ),
              ],
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      focusNode: node,
                      style: Theme.of(context).textTheme.bodyText1,
                      controller: textEditingController,
                      onSubmitted: (value2) async {
                        await sendMessageFCT(value);
                      },
                      decoration: _textFieldDecoration(context),
                    )),
                    IconButton(
                      onPressed: () async {
                        await sendMessageFCT(value);
                      },
                      icon: const Icon(Icons.send),
                      color: Colors.black,
                    )
                  ],
                ),
              )
            ],
          )),
        ),
      ),
      model: CoffeGptViewModel(chatGptServices: Provider.of(context)),
    );
  }

  Flexible _messageList(CoffeGptViewModel value) {
    return Flexible(
        child: ListView.builder(
      controller: scrollController,
      itemCount: value.list.length,
      itemBuilder: (context, index) {
        return OutBubble(message: value.list[index].msg, chatIndex: value.list[index].chatIndex);
      },
    ));
  }

  InputDecoration _textFieldDecoration(BuildContext context) {
    return InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(width: 2, color: Colors.black)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(width: 2, color: Colors.black)),
        hintText: "How can I help you ?",
        hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16));
  }

  Future<void> sendMessageFCT(CoffeGptViewModel value) async {
    if (_isTyping) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: TextWidget(
            label: "You cant send multiple messages at a time",
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (textEditingController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: TextWidget(
            label: "Please type a message",
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    try {
      String msg = textEditingController.text;
      setState(() {
        _isTyping = true;
        value.addUserMessage(message: msg);
        textEditingController.clear();
        node.unfocus();
      });
      await value.sendMessage(msg);

      setState(() {});
    } catch (error) {
      log("error $error");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: TextWidget(
          label: error.toString(),
        ),
        backgroundColor: Colors.red,
      ));
    } finally {
      setState(() {
        scrollListToEnd();
        _isTyping = false;
      });
    }
  }

  void scrollListToEnd() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 2), curve: Curves.easeOut);
  }
}
