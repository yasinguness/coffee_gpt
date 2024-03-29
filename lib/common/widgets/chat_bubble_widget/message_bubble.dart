import 'package:coffe_app/common/widgets/chat_bubble_widget/triangle.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class OutBubble extends StatelessWidget {
  final String message;
  final int chatIndex;
  const OutBubble({Key? key, required this.message, required this.chatIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: chatIndex == 0 ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (chatIndex == 0)
          Flexible(
            child: _customerBubble(),
          ),
        CustomPaint(painter: Triangle(Colors.indigo.shade600)),
        if (chatIndex == 1)
          Flexible(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: _img(),
                ),
                Expanded(
                  flex: 8,
                  child: _decoration(),
                ),
              ],
            ),
          ),
        //CustomPaint(painter: Triangle(Colors.indigo.shade600)),
      ],
    );
  }

  Container _customerBubble() {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        color: Colors.indigo.shade600,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(19),
          bottomLeft: Radius.circular(19),
          bottomRight: Radius.circular(19),
        ),
      ),
      child: Text(
        message,
        style: const TextStyle(color: Colors.white, fontSize: 15),
      ),
    );
  }

  Container _img() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(20)),
      child: const RiveAnimation.asset("assets/rive/bot.riv"),
    );
  }

  Container _decoration() {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(19),
          bottomLeft: Radius.circular(19),
          bottomRight: Radius.circular(19),
        ),
      ),
      child: Text(
        message,
        style: const TextStyle(color: Colors.black, fontSize: 15),
      ),
    );
  }
}
