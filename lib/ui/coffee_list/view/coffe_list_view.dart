import 'package:coffe_app/common/constants/coffee_colors.dart';
import 'package:coffe_app/common/constants/router_constants.dart';
import 'package:coffe_app/common/constants/scrool.dart';
import 'package:coffe_app/ui/base/base_view.dart';
import 'package:coffe_app/ui/coffee_list/view_model/coffee_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';

class CoffeeListView extends StatefulWidget {
  const CoffeeListView({super.key});

  @override
  State<CoffeeListView> createState() => _CoffeeListViewState();
}

class _CoffeeListViewState extends State<CoffeeListView> {
  late PageController _coffeeController;
  late PageController _headingController;
  late double _currentPosition;
  late int _currentHeading;

  void _navigationListener() {
    setState(() {
      _currentPosition = _coffeeController.page!;
      if (_currentPosition.round() != _currentHeading) {
        _currentHeading = _currentPosition.round();
        _headingController.animateToPage(_currentHeading,
            duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _coffeeController = PageController(viewportFraction: 0.4, initialPage: 4);
    _headingController = PageController(viewportFraction: 1, initialPage: 4);
    _currentPosition = _coffeeController.initialPage.toDouble();
    _currentHeading = _headingController.initialPage;
    _coffeeController.addListener(() {
      _navigationListener();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _coffeeController.removeListener(_navigationListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<CoffeListViewModel>(
      onModelReady: (p0) => p0.fetchCoffees(),
      model: CoffeListViewModel(api: Provider.of(context)),
      builder: (context, value, widget) => value.busy
          ? const Center(child: CircularProgressIndicator())
          : Scaffold(
              appBar: _appBar(context),
              body: Stack(
                children: [
                  ..._backgroundAlign(),
                  _coffeListBuilder(value),
                  Container(
                    height: 240,
                    decoration: _backgroundDecoration(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [_coffeNameBuilder(value), ..._buildOverlays()],
                    ),
                  )
                ],
              ),
            ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              FeatherIcons.shoppingBag,
              color: CoffeeColors.black,
              size: 30,
            ))
      ],
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context, "fromHome");
          },
          icon: const Icon(
            FeatherIcons.chevronLeft,
            color: CoffeeColors.black,
            size: 30,
          )),
    );
  }

  BoxDecoration _backgroundDecoration() {
    return BoxDecoration(
        gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: const [0.6, 1],
      colors: [
        Colors.white,
        Colors.white.withOpacity(0.0),
      ],
    ));
  }

  SizedBox _coffeNameBuilder(CoffeListViewModel value) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.1,
      child: PageView.builder(
        controller: _headingController,
        itemCount: value.coffees!.length + 1,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          value.index = index;
          if (index == value.coffees!.length) {
            return const SizedBox.shrink();
          }
          return Column(
            children: [
              Expanded(
                child: _name(value, index, context),
              ),
              Expanded(
                child: _price(value, index, context),
              )
            ],
          );
        },
      ),
    );
  }

  Hero _name(CoffeListViewModel value, int index, BuildContext context) {
    return Hero(
        tag: "name2${value.coffees![index].id.toString()}",
        child: Text(
          value.coffees![index].name.toString(),
          style: Theme.of(context).textTheme.headline1,
          textAlign: TextAlign.center,
        ));
  }

  AnimatedSwitcher _price(CoffeListViewModel value, int index, BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: Text(
        "${value.coffees![index].mediumPrice} TL",
        style: Theme.of(context).textTheme.headline2!.copyWith(fontWeight: FontWeight.w500, fontSize: 26),
      ),
    );
  }

  Transform _coffeListBuilder(CoffeListViewModel value) {
    return Transform.scale(
      alignment: Alignment.bottomCenter,
      scale: 2.4,
      child: PageView.builder(
        controller: _coffeeController,
        itemCount: value.coffees!.length + 1,
        clipBehavior: Clip.none,
        scrollDirection: Axis.vertical,
        scrollBehavior: WindowsScrollBehaviour(),
        itemBuilder: (context, index) {
          if (index == 0) {
            return const SizedBox.shrink();
          }
          /* if (index == value.coffees!.length) {
            return Container(
              color: Colors.red,
            );
          } */
          /*  if (index == value.coffees!.length) {
            return Container(
              width: 50,
              height: 50,
              color: Colors.red,
              child: Column(
                children: [
                  const Text("Hangi kahveyi içeceğine karar veremiyormusun ? Hemen tıkla !"),
                  const SizedBox(
                    height: 10,
                  ),
                  FloatingActionButton(onPressed: () {}, child: const Icon(Icons.account_circle_outlined)),
                ],
              ),
            );
          } */
          final double distance = (_currentPosition - index + 1).abs();
          final isNotOnScreen = (_currentPosition - index + 1) > 0;
          final double scale = 1 - distance * .345 * (isNotOnScreen ? 1 : -1);
          final double translateY =
              (1 - scale).abs() * MediaQuery.of(context).size.height / 1.5 + 20 * (distance - 1).clamp(0.0, 1);
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.1),
            child: Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..translate(0.0, !isNotOnScreen ? 0.0 : translateY)
                  ..scale(scale),
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    var currentUser = value.coffees![index - 1];
                    Navigator.pushNamed(context, RouteConst.coffeeDetailView, arguments: currentUser);
                  },
                  child: _coffeeImage(value, index),
                )),
          );
        },
      ),
    );
  }

  Hero _coffeeImage(CoffeListViewModel value, int index) {
    return Hero(
      flightShuttleBuilder: (flightContext, animation, flightDirection, fromHeroContext, toHeroContext) {
        late Widget hero;
        if (flightDirection == HeroFlightDirection.push) {
          hero = fromHeroContext.widget;
        } else {
          hero = toHeroContext.widget;
        }
        return hero;
      },
      tag: "name${value.coffees![index - 1].id.toString()}",
      child: Image.asset(
        "assets/coffee/GLASS-$index.png",
        fit: BoxFit.fitHeight,
      ),
    );
  }

  List<Widget> _backgroundAlign() {
    return [_bottomCenterAlign(), _leftCenterAlign(), _rightBottomAlign()];
  }

  Align _rightBottomAlign() {
    return Align(
      alignment: Alignment.bottomRight + const Alignment(5, -0.40),
      child: const SizedBox(
          width: 350,
          height: 350,
          child: DecoratedBox(
            decoration: BoxDecoration(
              // color: kBrownColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.brown,
                  blurRadius: 60,
                  spreadRadius: 20,
                  offset: Offset(5, 0),
                ),
              ],
              shape: BoxShape.circle,
            ),
          )),
    );
  }

  Align _leftCenterAlign() {
    return Align(
      alignment: Alignment.centerLeft + const Alignment(-0.3, -0.5),
      child: Container(
        width: 60,
        height: 200,
        decoration: const BoxDecoration(boxShadow: [
          BoxShadow(color: Colors.brown, blurRadius: 50, spreadRadius: 20, offset: Offset(5, 0)),
        ], borderRadius: BorderRadius.only(topRight: Radius.circular(50), bottomRight: Radius.circular(50))),
      ),
    );
  }

  Align _bottomCenterAlign() {
    return Align(
      alignment: Alignment.bottomCenter + const Alignment(0, .4),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.5,
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.brown, blurRadius: 90, spreadRadius: 90, offset: Offset.zero),
          ],
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  List<Widget> _buildOverlays() {
    return [
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                CoffeeColors.kBrownColor.withRed(170).withOpacity(0),
                CoffeeColors.kBrownColor.withOpacity(0.0),
              ],
            ),
          ),
        ),
      )
    ];
  }
}
