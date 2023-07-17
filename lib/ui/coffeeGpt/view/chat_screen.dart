import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rive/rive.dart';

import '../../../common/util/coffee_colors.dart';
import '../../../common/widgets/app_bar_widget.dart';
import '../../../common/widgets/chat_bubble_widget/message_bubble.dart';
import '../../../common/widgets/text_widget.dart';
import '../../../locator.dart';
import '../../../main.dart';
import '../../../network/services/chat_gpt/chat_gpt_service.dart';
import '../../base/base_view.dart';
import '../view_model/coffee_gpt_view_model.dart';

@RoutePage()
class ChatScreenView extends StatefulWidget {
  const ChatScreenView({super.key});

  @override
  State<ChatScreenView> createState() => _ChatScreenViewState();
}

class _ChatScreenViewState extends State<ChatScreenView> with SingleTickerProviderStateMixin, RouteAware {
  bool _isTyping = false;
  late TextEditingController textEditingController;
  late ScrollController scrollController;
  late FocusNode node;
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  @override
  @override
  void initState() {
    textEditingController = TextEditingController();
    scrollController = ScrollController();
    node = FocusNode();
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    scrollController.dispose();
    node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<CoffeGptViewModel>(
      routeObserver: routeObserver,
      onDispose: () => routeObserver.unsubscribe(this),
      builder: (context, value, widget) => ScaleTransition(
        scale: scaleAnimation,
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          appBar: CustomAppBar(
              backgroundColor: CoffeeColors.kBrownColor,
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(20)),
                        child: const RiveAnimation.asset("assets/rive/bot.riv"),
                      ),
                      Positioned(
                        bottom: 1,
                        right: 1,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(),
                            color: const Color.fromARGB(255, 28, 209, 34),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Coffi",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        "Online",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white, fontSize: 10),
                      )
                    ],
                  )
                ],
              )),
          body: SafeArea(
              child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              const OutBubble(
                  message: "Merhaba, Ben sanal barista Cofi. Sana nasıl yardımcı olabilirim ?", chatIndex: 1),
              _messageList(value),
              if (_isTyping) ...[
                const SpinKitThreeBounce(
                  color: Color.fromARGB(255, 104, 99, 99),
                  size: 18,
                ),
              ],
              const SizedBox(
                height: 16,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                        focusNode: node,
                        style: Theme.of(context).textTheme.bodyLarge,
                        controller: textEditingController,
                        onSubmitted: (value2) {
                          //sendMessageFCT(value);
                        },
                        decoration: _textFieldDecoration(context),
                      )),
                      IconButton(
                        onPressed: () {
                          sendMessageFCT(value);
                        },
                        icon: const Icon(Icons.send),
                        color: Colors.black,
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
        ),
      ),
      model: CoffeGptViewModel(chatGptServices: locator<ChatGptServices>()),
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
        hintText: "Bana soru sor", hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 16));
  }

  Future<void> sendMessageFCT(CoffeGptViewModel value) async {
    if (_isTyping) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: TextWidget(
            label: "Aynı anda birden fazla mesaj gönderemezsin !",
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
            label: "Lütfen bir mesaj yazar mısın ?",
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
        duration: const Duration(seconds: 1), curve: Curves.easeOut);
  }
}
