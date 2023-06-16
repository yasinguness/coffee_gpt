import 'package:auto_route/auto_route.dart';
import 'package:coffe_app/common/constants/coffee_colors.dart';
import 'package:coffe_app/common/widgets/app_bar_widget.dart';
import 'package:coffe_app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

@RoutePage()
class EntryView extends StatefulWidget {
  const EntryView({super.key});

  @override
  State<EntryView> createState() => _EntryViewState();
}

class _EntryViewState extends State<EntryView> {
  late RiveAnimationController riveAnimationController;
  late RiveAnimationController riveAnimationControllerBot;
  bool isHovered = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    riveAnimationController = OneShotAnimation('bounce');
    riveAnimationControllerBot = OneShotAnimation('bot');
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    bool isHovered = true;
    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(flex: 5, child: _topCard(size, context, isHovered)),
          Expanded(
            flex: 5,
            child: _bottomCard(context, size),
          ),
        ],
      ),
    );
  }

  Padding _bottomCard(BuildContext context, Size size) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 16,
        color: const Color(0xFFECDAC2),
        child: Stack(children: [_coffeImage(size), _positionedText(size), _listButton(context, size)]),
      ),
    );
  }

  Padding _topCard(Size size, BuildContext context, bool isHovered) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 16,
        color: const Color(0xFFECDAC2),
        child: Stack(children: [
          _robot(),
          Positioned(
              left: 10,
              top: 5,
              child: SizedBox(
                width: 220,
                height: size.height * 0.38,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 3, child: _title(context)),
                    Expanded(flex: 9, child: _mediumTitle(context)),
                    Expanded(flex: 2, child: _roboButon(isHovered)),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              )),
        ]),
      ),
    );
  }

  Positioned _listButton(BuildContext context, Size size) {
    return Positioned(
      right: 10,
      top: size.height * 0.3,
      child: SizedBox(
        height: 50,
        width: 180,
        child: ElevatedButton(
          onPressed: () {
            context.router.push(const CoffeeListRoute());
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: CoffeeColors.kTitleColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              textStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              )),
          child: const Text('Ürün Listesi'),
        ),
      ),
    );
  }

  Positioned _positionedText(Size size) {
    return Positioned(
      right: 10,
      bottom: size.height * 0.1,
      child: SafeArea(
        child: SizedBox(
          width: 180,
          height: size.height * 0.3,
          child: Expanded(
            child: _animatedText(),
          ),
        ),
      ),
    );
  }

  Text _text() {
    return const Text(
      'Hemen',
      style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700, color: CoffeeColors.kTitleColor),
    );
  }

  DefaultTextStyle _animatedText() {
    return DefaultTextStyle(
      style: const TextStyle(
          fontSize: 40.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w800, color: CoffeeColors.kTitleColor),
      child: AnimatedTextKit(
        animatedTexts: [
          RotateAnimatedText('KOLAY KARAR VER'),
          RotateAnimatedText('HIZLI SİPARİŞ VER'),
          RotateAnimatedText('HEMEN GELSİN'),
        ],
        onTap: () {},
      ),
    );
  }

  Positioned _coffeImage(Size size) {
    return Positioned(
      right: 75,
      child: SizedBox(
        width: size.width,
        height: size.height * .4,
        child: RiveAnimation.asset(
          "assets/rive/donut.riv",
          fit: BoxFit.fill,
          controllers: [riveAnimationController],
        ),
      ),
    );
  }

  Text _title(BuildContext context) {
    return Text(
      "Yardım etmemi ister misin ?",
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontSize: 24,
          fontFamily: "Montserrat",
          height: 1.2,
          fontWeight: FontWeight.w700,
          color: CoffeeColors.kTitleColor),
    );
  }

  Text _mediumTitle(BuildContext context) {
    return Text(
      "Hey! Ben sanal barista Cofi. Benimle birlikte hangi lezzette kahve içmekten hoşlandığına karar verebilirsin. Senin için en güzel kahveyi bulmamız için haydi hemen soru sormaya başla!!",
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontSize: 16,
          fontFamily: "Montserrat",
          height: 1.4,
          fontWeight: FontWeight.w500,
          color: CoffeeColors.kTitleColor.withOpacity(0.5)),
    );
  }

  ElevatedButton _roboButon(bool isHovered) {
    return ElevatedButton(
      onPressed: () {
        context.router.push(const ChatScreenRoute());
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: CoffeeColors.kTitleColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          )),
      child: const Text("Cofiye Sor"),
    );
  }

  Positioned _robot() {
    return Positioned(
      left: 200,
      top: 10,
      child: SizedBox(
        height: 300,
        width: 200,
        child: RiveAnimation.asset("assets/rive/bot.riv",
            alignment: Alignment.centerRight, controllers: [riveAnimationControllerBot]),
      ),
    );
  }
}
