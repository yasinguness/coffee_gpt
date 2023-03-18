import 'package:coffe_app/common/widgets/chat_bubble_widget/triangle.dart';
import 'package:flutter/material.dart';

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
            child: Container(
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
            ),
          ),
        CustomPaint(painter: Triangle(Colors.indigo.shade600)),
        if (chatIndex == 1)
          Flexible(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(20)),
                    child: Image.asset("assets/chatGpt/dash.png"),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Container(
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
                  ),
                ),
              ],
            ),
          ),
        //CustomPaint(painter: Triangle(Colors.indigo.shade600)),
      ],
    );
  }
}
