import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../../../common/constants/assets_const.dart';
import '../../../common/constants/coffee_colors.dart';
import '../../../common/constants/coffee_padding.dart';
import '../../../common/constants/text_const.dart';
import '../../../common/widgets/app_bar_widget.dart';
import '../../../router/app_router.dart';

@RoutePage()
class EntryView extends StatefulWidget {
  const EntryView({super.key});

  @override
  State<EntryView> createState() => _EntryViewState();
}

class _EntryViewState extends State<EntryView> {
  late RiveAnimationController riveAnimationController;
  late RiveAnimationController riveAnimationControllerBot;
  @override
  void initState() {
    super.initState();
    riveAnimationController = OneShotAnimation('bounce');
    riveAnimationControllerBot = OneShotAnimation('bot');
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: CoffeeColors.white,
      body: Column(
        children: [
          _coffiRoboCard(size, context),
          _productListCard(size, context),
        ],
      ),
    );
  }

  Expanded _coffiRoboCard(Size size, BuildContext context) {
    return Expanded(
        flex: 5,
        child: Padding(
          padding: CoffeePading.instance.medium,
          child: Card(
            elevation: 16,
            color: const Color(0xFFECDAC2),
            child: Stack(children: [
              _coffiImage(context),
              _coffiDesc(size, context),
            ]),
          ),
        ));
  }

  Positioned _coffiDesc(Size size, BuildContext context) {
    return Positioned(
        left: size.width * .05,
        top: size.height * .01,
        child: SizedBox(
          width: size.width * .6,
          height: size.height * 0.38,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 3, child: _title(context)),
              Expanded(flex: 9, child: _mediumTitle(context)),
              Expanded(flex: 2, child: _roboButon()),
              SizedBox(height: size.height * .01),
            ],
          ),
        ));
  }

  Positioned _coffiImage(BuildContext context) {
    return Positioned(
      left: MediaQuery.of(context).size.width * 0.5,
      top: MediaQuery.of(context).size.height * 0.01,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        width: MediaQuery.of(context).size.width * 0.5,
        child: RiveAnimation.asset(AssetConst.instance.coffiAsset,
            alignment: Alignment.centerRight, controllers: [riveAnimationControllerBot]),
      ),
    );
  }

  Expanded _productListCard(Size size, BuildContext context) {
    return Expanded(
      flex: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 16,
          color: const Color(0xFFECDAC2),
          child: Stack(children: [_coffeImage(size), _positionedText(size), _listButton(context, size)]),
        ),
      ),
    );
  }

  Positioned _listButton(BuildContext context, Size size) {
    return Positioned(
      right: size.height * .01,
      top: size.height * 0.3,
      child: SizedBox(
        height: size.height * .07,
        width: size.width * .45,
        child: ElevatedButton(
          onPressed: () {
            context.router.push(const CoffeeListRoute());
          },
          style: _listButtonStyles(context),
          child: Text(TextConst.instance.productListText),
        ),
      ),
    );
  }

  ButtonStyle _listButtonStyles(BuildContext context) {
    return ElevatedButton.styleFrom(
        backgroundColor: CoffeeColors.kTitleColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: CoffeeColors.white));
  }

  Positioned _positionedText(Size size) {
    return Positioned(
      right: size.height * .01,
      bottom: size.height * 0.1,
      child: SafeArea(
        child: SizedBox(
          width: size.width * 0.5,
          height: size.height * 0.3,
          child: Expanded(
            child: _animatedText(),
          ),
        ),
      ),
    );
  }

  DefaultTextStyle _animatedText() {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.displayLarge!.copyWith(
          fontSize: 40.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w800, color: CoffeeColors.kTitleColor),
      child: AnimatedTextKit(
        animatedTexts: [
          RotateAnimatedText(TextConst.instance.animatedText1),
          RotateAnimatedText(TextConst.instance.animatedText2),
          RotateAnimatedText(TextConst.instance.animatedText3),
        ],
        onTap: () {},
      ),
    );
  }

  Positioned _coffeImage(Size size) {
    return Positioned(
      right: size.height * .1,
      child: SizedBox(
        width: size.width,
        height: size.height * .4,
        child: RiveAnimation.asset(
          AssetConst.instance.homeCoffeRive,
          fit: BoxFit.fill,
          controllers: [riveAnimationController],
        ),
      ),
    );
  }

  Text _title(BuildContext context) {
    return Text(
      TextConst.instance.titleCoffi,
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
      TextConst.instance.coffiDesc,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontSize: 16,
          fontFamily: "Montserrat",
          height: 1.4,
          fontWeight: FontWeight.w500,
          color: CoffeeColors.kTitleColor.withOpacity(0.5)),
    );
  }

  ElevatedButton _roboButon() {
    return ElevatedButton(
      onPressed: () {
        context.router.push(const ChatScreenRoute());
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: CoffeeColors.kTitleColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(CoffeePading.instance.mediumValue),
          ),
          textStyle: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: CoffeeColors.white, fontWeight: FontWeight.bold)),
      child: Text(TextConst.instance.askCoffi),
    );
  }
}
