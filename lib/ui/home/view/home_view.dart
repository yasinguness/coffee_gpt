import 'package:auto_route/annotations.dart';
import 'package:coffe_app/ui/splash/view/splash_view.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Container(clipBehavior: Clip.none, child: const SplashView() /* Stack(clipBehavior: Clip.none, ) */

        );
  }
}
