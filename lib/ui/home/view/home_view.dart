import 'package:coffe_app/ui/chatGpt/view/chat_screen.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Container(clipBehavior: Clip.none, child: const ChatScreenView() /* Stack(clipBehavior: Clip.none, ) */

        );
  }
}
