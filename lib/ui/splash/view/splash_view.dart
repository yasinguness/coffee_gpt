import 'package:coffe_app/common/constants/coffee_colors.dart';
import 'package:coffe_app/common/constants/router_constants.dart';
import 'package:coffe_app/common/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      const Duration(milliseconds: 1500),
      () {
        Navigator.pushNamed(context, RouteConst.loginView);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: _containerDecoration(),
        child: Scaffold(
          appBar: const CustomAppBar(),
          body: Stack(
            children: [
              ...[1, 2, 3, 4].map((index) {
                //TODO:Buralara bak
                double scale = 1.0 + (index - 1) * 0.32 + (index == 4 ? 0.3 : 0);
                double translate = (index - 1) * 100.0 + (index == 4 ? 160 : 0);
                return _image(translate, scale, index);
              }).toList(),
              _align()
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  BoxDecoration _containerDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
          colors: [
            CoffeeColors.white,
            CoffeeColors.kBrownColor,
            CoffeeColors.white.withOpacity(0.8),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0, 0.3, 0.4]),
    );
  }

  Transform _image(double translate, double scale, int index) {
    return Transform(
      alignment: Alignment.topCenter,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..translate(10.0, translate)
        ..scale(scale),
      child: Hero(
        tag: "coffee$index",
        child: Image.asset(
          "assets/coffee/GLASS-2.png",
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Align _align() {
    return Align(
      alignment: Alignment.center + const Alignment(0, 0.25),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          IntrinsicHeight(
            child: Column(
              children: const [
                IntroText(fontSize: 80, fontWeight: FontWeight.w400, text: "Coffee"),
                IntroText(text: "GPT", fontSize: 50, fontWeight: FontWeight.w700),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class IntroText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  const IntroText({
    Key? key,
    required this.text,
    required this.fontSize,
    required this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: Theme.of(context)
            .textTheme
            .headline1!
            .copyWith(fontSize: fontSize, fontWeight: fontWeight, color: CoffeeColors.black));
  }
}
